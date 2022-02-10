Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2604B13A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiBJQ4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 11:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbiBJQ4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 11:56:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7397
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 08:56:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 262691F399;
        Thu, 10 Feb 2022 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644512195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJ3PrUa0vM8qRbm/9khCZ1QiJQtCm7oXqLCO/8g770o=;
        b=rJNc9C+3hg6ha5sxRtZbnUgE7TNeOXlVkd4DzyLSN9gpfkHNcAIVBQ0WIqvWInPzz4GHFP
        BKYgFdrcexMvfcr8237GhJ7T5mH0s7upZo6mOKKmCl1kCiqx0E1onWxTge4Fw72gLdHaIH
        9ybI+Aqc+M/RU4ulTMlHYO4Ap4GRS7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644512195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJ3PrUa0vM8qRbm/9khCZ1QiJQtCm7oXqLCO/8g770o=;
        b=ETFxgIaWl86rLbfqckvidqQa0kmNPmhJADRkHzbzomBfA6wqJeP5sIVZ9VzdPF3IXsKujx
        1+qwZ/4CwlDcAQBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1DC78A3B89;
        Thu, 10 Feb 2022 16:56:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABD76DA9BA; Thu, 10 Feb 2022 17:52:53 +0100 (CET)
Date:   Thu, 10 Feb 2022 17:52:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <20220210165253.GQ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1644039494.git.wqu@suse.com>
 <20220208220923.GH12643@twin.jikos.cz>
 <b50e1856-f03e-8570-6283-54e5f673a040@gmx.com>
 <20220209151921.GK12643@twin.jikos.cz>
 <38abf10b-cca3-0c75-fb18-a90c658541a4@suse.com>
 <20220210142652.GO12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210142652.GO12643@twin.jikos.cz>
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

On Thu, Feb 10, 2022 at 03:26:52PM +0100, David Sterba wrote:
> > Unfortunately, it looks like without this cleanup, all later patches 
> > either needs extra parameters passing down the call chain, or have very 
> > "creative" way to pass info around, and can causing more problem in the 
> > long run.
> > 
> > I'm wondering if it's some policy in the stable tree preventing such 
> > cleanup patches being merged or something else?
> 
> It's not a hard policy, I don't remember a patch rejected from stable
> because it needed a prep work. The fix itself must be justified, and
> minimal if possible and that's what I'm always trying to go for.
> 
> This patches has diffstat
> 
> 4 files changed, 163 insertions(+), 101 deletions(-)
> 
> and the preparatory patch itself
> 
> 3 files changed, 71 insertions(+), 93 deletions(-)
> 
> Patch 4 probably needs to add one parameter, and 5 is adding a new
> one even though there's the ctrl structure. So I think it would not be
> that intrusive with a few extra parameters compared to the whole ctrl
> conversion.

I've tried to minimize that, basically it's just patch 5, passing around
the last_scanned, but I'm not 100% sure, the ctrl structure makes it
incomprehensible what else needs to be passed around or initialized.
If we're fixing a not so great rewrite I'm very inclined to fix it by a
series of minimal fixes, not another rewrite.
