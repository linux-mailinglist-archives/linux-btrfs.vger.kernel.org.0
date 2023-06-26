Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDC73EAF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFZTKq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZTKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 15:10:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2BE75;
        Mon, 26 Jun 2023 12:10:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 247DA1F8AC;
        Mon, 26 Jun 2023 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687806642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0SC+AjIj1yfEWO1l6xoiIjESXZFklczUys3UjT75cP8=;
        b=vzzEpkEJiiFUAIGCkCQRR78XxMJDUA8qLHwXmsJ86wtrXePvUsDWCl6B2vkJvL4rwhdPGC
        Tt0yDlf6MLhfW6HT6MqvK0kh9sqcpKmiYOSFGuGb2gN+oosTh6dRY0NCafDf7AUOB88M1H
        tlOc9XLYsv6Q9zf4VaurznKahIEAheU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687806642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0SC+AjIj1yfEWO1l6xoiIjESXZFklczUys3UjT75cP8=;
        b=hvlSLwQz00HasAbrkNLrc/5Yh5DUuHUVT8pKSH8TgV4hmzpH10MK3vElzH8dfz8Fk1Ec4S
        NUjaF1Vcre6KFADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF43413905;
        Mon, 26 Jun 2023 19:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YMXTNbHimWQpBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 26 Jun 2023 19:10:41 +0000
Date:   Mon, 26 Jun 2023 21:04:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.5
Message-ID: <20230626190415.GZ16168@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687802358.git.dsterba@suse.com>
 <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 26, 2023 at 11:49:13AM -0700, Linus Torvalds wrote:
> On Mon, 26 Jun 2023 at 11:21, David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5
> 
> Ouch. I did this merge twice.
> 
> Your pull request only points to the branch. I didn't immediately
> notice - my scripting only complains about non-kernel.org addresses -
> but then after doing the merge I went "Hmm, I see no signature".
> 
> And then I noticed that you do have a for-6.5-tag that points to your
> branch, you just didn't mention it in the pull request.
> 
> So then I re-did it all.
> 
> Can I ask you to be more careful in your pull request flow, and point
> at the tag? I did notice eventually, and I'll go make my scripting
> actually complain even about kernel.org pulls without signed tags so
> that I'll notice earlier (and not just by mistake when I happen to
> check later)

I'm sorry about that, I had to redo the pull request before sending and
did not update the tag name in the new cover letter, it's not
automated/scripted on my side. I'll go fix it now.
