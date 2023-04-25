Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED86EE450
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Apr 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjDYOy3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Apr 2023 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjDYOy1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Apr 2023 10:54:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4D170D;
        Tue, 25 Apr 2023 07:54:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD26E219C0;
        Tue, 25 Apr 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682434465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UuFcKLSvjtYjYDwVvs5uj1rPCVVtEm4R1j3vEbQGPE=;
        b=kmZivN56VWhkAPuk6RI43aw6i4XmJM9erfhQbymS+/EbEdNhU8HqjDCFKA9XdtQW07nO6s
        WY33pVF99//+tyKi0JvoZJ2H0E7UKprIB3WZ6lg6tIy4SbXDNhOaH/iaWZSG8BJnw8GUoE
        2OEPB11aQ6Q/YEm8OiyroHcOxCN2SqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682434465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UuFcKLSvjtYjYDwVvs5uj1rPCVVtEm4R1j3vEbQGPE=;
        b=xLP6jEW0fnVszwK8Zw84MmrlwfcKFJP/ScrtFjbvzvr/+PMyeo2ScdsvnTVDjnhNvFJeow
        vCz8SKN/S2Te5rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8747C138E3;
        Tue, 25 Apr 2023 14:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nKlbIKHpR2SHSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Apr 2023 14:54:25 +0000
Date:   Tue, 25 Apr 2023 16:54:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Memet <zxce3@gnuweeb.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [GIT PULL] Btrfs updates for 6.3
Message-ID: <20230425145412.GC19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676908729.git.dsterba@suse.com>
 <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
 <4b35f3a4-9972-b7f0-287f-165a817c0f73@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b35f3a4-9972-b7f0-287f-165a817c0f73@gnuweeb.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 23, 2023 at 09:27:30AM +0700, Ammar Faizi wrote:
> On 2/21/23 4:02 AM, Linus Torvalds wrote:
> > On Mon, Feb 20, 2023 at 11:26 AM David Sterba <dsterba@suse.com> wrote:
> >> Other:
> >>
> >> - locally enable -Wmaybe-uninitialized after fixing all warnings
> > 
> > I've pulled this, but I strongly suspect this change will get reverted.
> > 
> > I bet neither you nor linux-next is testing even _remotely_ a big
> > chunk of the different compiler versions that are out there, and the
> > reason flags like '-Wmaybe-uninitialized' get undone is because some
> > random compiler version on some random config and target archiecture
> > gives completely nonsensical warnings for odd reasons.
> > 
> > But hey, maybe the btrfs code is special.
> 
> Maybe it's too late for 6.3. So please fix this in 6.4 and backport it to
> 6.3 stable. If someone fixes it, kindly add:

Fix for this warning is in 6.4 pull request, there's no CC:stable tag
but we can ask to add it once the code lands in master.
