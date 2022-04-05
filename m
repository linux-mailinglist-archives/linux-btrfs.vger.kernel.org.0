Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E84F478C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbiDEVNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572998AbiDERoz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 13:44:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D0B91A9;
        Tue,  5 Apr 2022 10:42:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5355C1F37D;
        Tue,  5 Apr 2022 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649180575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9/opB1dmrwwRT1K8TkAgykRgtJiuStwy16fQBFlZuk=;
        b=Ve0Ai/3r2vOGSGF38312vXaPCgD+Jep/JZ7TUsUGdK6wkFrx0GHHCk1L9kYIP/kWdojjX0
        02y1/fRVihYsLxf17SY2R1bJ+FpW+JPZ1RRA/SJ0b1nuRepSXnbin/q0XzqYZJodjKZCte
        E8xtKq1xcAf5KWbClw5Ifp1ufOK4GCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649180575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9/opB1dmrwwRT1K8TkAgykRgtJiuStwy16fQBFlZuk=;
        b=U1hmDdR/n3fC5qSuwAkR424KokOpvccEIAIKnPx2BWtQIUEXFffg4TpBssNxHNpBRqya6v
        wWtKC9d3pXX3R0Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 44EFCA3B83;
        Tue,  5 Apr 2022 17:42:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DEE7CDA80E; Tue,  5 Apr 2022 19:38:53 +0200 (CEST)
Date:   Tue, 5 Apr 2022 19:38:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc2
Message-ID: <20220405173853.GZ15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <cover.1649109877.git.dsterba@suse.com>
 <CAADWXX-XPrfiD0TLGwMuzmGfs9pZ+HiTo1v9cs-mxb6x0OXpZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX-XPrfiD0TLGwMuzmGfs9pZ+HiTo1v9cs-mxb6x0OXpZw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 08:58:35AM -0700, Linus Torvalds wrote:
> On Tue, Apr 5, 2022 at 6:28 AM David Sterba <dsterba@suse.com> wrote:
> >
> > please pull the following fixes for btrfs, thanks.
> 
> Hmm. I got two copies of this...
> 
> ...and both were in my spam folder.
> 
> I don't see anything wrong with the message (spf and dkim both
> fine).so I assume it's something about suse.sz or suse.de that gmail
> doesn't like. Presumably some spammer sitting on a nearby network on
> the same ISP.

I don't know what could be wrong. Regular mails I send from mutt and the
pull request with 'git send-email'. Today I sent the first pull request
mail from mutt to see if there's a change from last time when you found
the mail in spam. The mail delivery took longer than expected, I think
more than half an hour which could be the gray listing period that I saw
on vger in the past. So I sent it again with git send-mail, just to be
sure. But if both end up in spam then it's probably something in the
mail body, other mails seem to be delivered.

> Anyway, not much you can do about it except perhaps ask whatever MIS
> people to see if they got put on some blacklist or whatever.
> 
> I've obviously noticed the pull request despite it being in my spam folder.

Good to know, thanks, I'll check if there's anything to do in my mail
setup.
