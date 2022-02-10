Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3C4B1072
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiBJOaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 09:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiBJOaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 09:30:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8EB80
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 06:30:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7000D1F391;
        Thu, 10 Feb 2022 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644503434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYM2/h7cSRWffcEHkd2betiBL6rT67FROZMoE0EluKk=;
        b=a1mulDJNKuEB3rEb6zuLBtselRLtYTNi/bkjJhAl727tlWcOpDK94QlssdXhfUC20ZxGHn
        zeYc/966EK48zoJcdl8Z6LmgsTF2aIFROeV1RCxLXlXtsVOy4EZCHNCgRYOaiSaxF1WsZq
        R1LdL13ILubtExbLaxHwTh2u+Nqc5C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644503434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYM2/h7cSRWffcEHkd2betiBL6rT67FROZMoE0EluKk=;
        b=W5AfANGOp6Lx6PQCWtGDEJ5zvUILn6hj/pNZrTFEfdmwKLvVRkw7C202r1DQgN77Y7mu+z
        gEMzFKFmmkrKgqDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 67831A3B87;
        Thu, 10 Feb 2022 14:30:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1366ADA9BA; Thu, 10 Feb 2022 15:26:53 +0100 (CET)
Date:   Thu, 10 Feb 2022 15:26:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <20220210142652.GO12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
 <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
 <20220209151921.GK12643@twin.jikos.cz>
 <38abf10b-cca3-0c75-fb18-a90c658541a4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38abf10b-cca3-0c75-fb18-a90c658541a4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 08:33:04AM +0800, Qu Wenruo wrote:
> On 2022/2/9 23:19, David Sterba wrote:
> > On Wed, Feb 09, 2022 at 08:17:27AM +0800, Qu Wenruo wrote:
> >> On 2022/2/9 06:09, David Sterba wrote:
> >>> On Sat, Feb 05, 2022 at 01:41:01PM +0800, Qu Wenruo wrote:
> >>>> To get the missing optimization, also introduce a new structure,
> >>>> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
> >>>> @max_to_defrag around.
> >>>
> >>> Is this patchset supposed to be in 5.16 as fix for some defrag problem?
> >>> If yes, the patch switching to the control structure should be avoided
> >>> and done as a post cleanup as some other patches depend on it.
> >>
> >> I can backport it manually to v5.16 without the ctrl refactor.
> > 
> > That's not great if we have to do two versions, and more fixes to defrag
> > are still expected so a cleanup patch makes any backporting harder. That
> > we can send a manually ported version to stable is there for cases when
> > the changes are not possible. In this case the cleanup is not necessary,
> > but I understand it makes the code cleaner. Given that we need to fix a
> > released kernel it's the preference.
> > 
> Unfortunately, it looks like without this cleanup, all later patches 
> either needs extra parameters passing down the call chain, or have very 
> "creative" way to pass info around, and can causing more problem in the 
> long run.
> 
> I'm wondering if it's some policy in the stable tree preventing such 
> cleanup patches being merged or something else?

It's not a hard policy, I don't remember a patch rejected from stable
because it needed a prep work. The fix itself must be justified, and
minimal if possible and that's what I'm always trying to go for.

This patches has diffstat

4 files changed, 163 insertions(+), 101 deletions(-)

and the preparatory patch itself

3 files changed, 71 insertions(+), 93 deletions(-)

Patch 4 probably needs to add one parameter, and 5 is adding a new
one even though there's the ctrl structure. So I think it would not be
that intrusive with a few extra parameters compared to the whole ctrl
conversion.
