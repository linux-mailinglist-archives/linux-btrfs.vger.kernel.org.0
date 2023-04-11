Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2E6DE4F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 21:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDKT1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKT1e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 15:27:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B57171F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 12:27:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53326219D6;
        Tue, 11 Apr 2023 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681241246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1vXFaKgJ49Nxd1pmkCKb8Hr3qF7T/Jca32RnCUaDQM=;
        b=MlPTb49li8g/B/ZtIVQ2F4LoYn4kLwGSaexr58rq0ksmNy7xuP0/uWm9+JcGc89KDoZEQy
        7e2QeQ7a317SP6CVCllnF+GMOg2Rlj2pqCwmsOFSgIH08slQVvCiDfxXycY5t+nWI0XPkp
        D58yug1bZH2mxtncBLZNDc3mgE0G1xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681241246;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1vXFaKgJ49Nxd1pmkCKb8Hr3qF7T/Jca32RnCUaDQM=;
        b=FapIA9so/A2iBrS8qoZdyWQY3WqKwPKnRikabV7uj8hm+UeE+O/rdGgoLHVsk5Ztz7DK4z
        FVqIIz/Uh5RYBWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1503D13638;
        Tue, 11 Apr 2023 19:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id knBJBJ60NWSCcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Apr 2023 19:27:26 +0000
Date:   Tue, 11 Apr 2023 21:27:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        boris@bur.io
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <20230411192720.GC19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info>
 <20230406154732.GV19619@twin.jikos.cz>
 <dbd7d712-0c46-7a18-d8fc-fc263f4de6e9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd7d712-0c46-7a18-d8fc-fc263f4de6e9@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 08:10:24AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.04.23 17:47, David Sterba wrote:
> > On Wed, Apr 05, 2023 at 03:07:52PM +0200, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
> >> [TLDR: I'm adding this report to the list of tracked Linux kernel
> >> regressions; the text you find below is based on a few templates
> >> paragraphs you might have encountered already in similar form.
> >> See link in footer if these mails annoy you.]
> >>
> >> On 15.02.23 21:04, Chris Murphy wrote:
> >>> Downstream bug report, reproducer test file, and gdb session transcript
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >>>
> >>> I speculated that maybe it's similar to the issue we have with VM's when O_DIRECT is used, but it seems that's not the case here.
> >>
> >> To properly track this, let me add this report as well to the tracking
> >> (I already track another report not mentioned in the commit log of the
> >> proposed fix: https://bugzilla.kernel.org/show_bug.cgi?id=217042 )
> > 
> > There were several iterations of the fix and the final version is
> > actually 11 patches (below), and it does not apply cleanly to current
> > master because of other cleanups.
> > 
> > Given that it's fixing a corruption it should be merged and backported
> > (at least to 6.1), but we may need to rework it again and minimize/drop
> > the cleanups.
> > 
> > a8e793f97686 btrfs: add function to create and return an ordered extent
> > b85d0977f5be btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
> > c5e9a883e7c8 btrfs: stash ordered extent in dio_data during iomap dio
> > d90af6fe39e6 btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
> > 8d4f5839fe88 btrfs: simplify splitting logic in btrfs_extract_ordered_extent
> > 880c3efad384 btrfs: sink parameter len to btrfs_split_ordered_extent
> > 812f614a7ad7 btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
> > 1334edcf5fa2 btrfs: simplify extent map splitting and rename split_zoned_em
> > 3e99488588fa btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
> > df701737e7a6 btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent
> > 87606cb305ca btrfs: split partial dio bios before submit
> 
> David, many thx for the update; and thx Boris for all your work on this.
> 
> I kept a loose eye on this and noticed that fixing this turned out to be
> quite complicated and thus required quite a bit of time. Well, that's a
> bit unfortunate, but how it is sometimes, so nothing to worry about.
> Makes me wonder if "revert the culprit temporarily, to get this fixed
> quickly" was really properly evaluated in this case (if it was, sorry, I
> might have missed it or forgotten).

I haven't evaluated a revert before, the patch being fixed is actually
fixing a deadlock and a fstests case tests it. A clean revert works on
5.16 but not on the most recent stable version (6.1).

I have a backport on top of 6.2, so once the patches land in Linus' tree
they can be sent for stable backport, but I don't have an ETA. It's hard
to plan things when we're that close to release, one possibility is to
send the patches now and see.
