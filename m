Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DC6D9CA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjDFPrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDFPrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 11:47:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B798A51
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 08:47:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13BF31F7AB;
        Thu,  6 Apr 2023 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680796055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64/dOjhRl/4NvmQqi8Uek3/VlWQzSiRXoRTzXhSBeuU=;
        b=sAMUwhUJsuZ0xOJ9WtK6IQ4g9K+ITxRDP2wRkGswu9yu7zIDRsOEPnWKUjwL3vl7Wh0zP9
        vo/ZNZRvvfgzxAVd4805GHv96dVVM6+VUI6G6IXwe9AEbMO56N9brG9cZZEgAgsraGPOnV
        LDQODbipVnSisqAkObA+uExcw/5n+uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680796055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64/dOjhRl/4NvmQqi8Uek3/VlWQzSiRXoRTzXhSBeuU=;
        b=t5PvW6XmsUBGWIDWqH8iHAuBYbUS7ZmAVXLdF+xpn6VN4e5Fe3resJZ3FegMkDfYROKewR
        BfXYQdpdkOVgNOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFDF8133E5;
        Thu,  6 Apr 2023 15:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KJLONZbpLmRXYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 15:47:34 +0000
Date:   Thu, 6 Apr 2023 17:47:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, boris@bur.io
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <20230406154732.GV19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 03:07:52PM +0200, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 15.02.23 21:04, Chris Murphy wrote:
> > Downstream bug report, reproducer test file, and gdb session transcript
> > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > 
> > I speculated that maybe it's similar to the issue we have with VM's when O_DIRECT is used, but it seems that's not the case here.
> 
> To properly track this, let me add this report as well to the tracking
> (I already track another report not mentioned in the commit log of the
> proposed fix: https://bugzilla.kernel.org/show_bug.cgi?id=217042 )

There were several iterations of the fix and the final version is
actually 11 patches (below), and it does not apply cleanly to current
master because of other cleanups.

Given that it's fixing a corruption it should be merged and backported
(at least to 6.1), but we may need to rework it again and minimize/drop
the cleanups.

a8e793f97686 btrfs: add function to create and return an ordered extent
b85d0977f5be btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
c5e9a883e7c8 btrfs: stash ordered extent in dio_data during iomap dio
d90af6fe39e6 btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
8d4f5839fe88 btrfs: simplify splitting logic in btrfs_extract_ordered_extent
880c3efad384 btrfs: sink parameter len to btrfs_split_ordered_extent
812f614a7ad7 btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
1334edcf5fa2 btrfs: simplify extent map splitting and rename split_zoned_em
3e99488588fa btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
df701737e7a6 btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent
87606cb305ca btrfs: split partial dio bios before submit
