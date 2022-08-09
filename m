Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4763258E07D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiHITxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbiHITwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 15:52:47 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06C0221E36
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 12:52:44 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 5A169490776; Tue,  9 Aug 2022 15:52:44 -0400 (EDT)
Date:   Tue, 9 Aug 2022 15:52:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Alex Lieflander <atlief@icloud.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Help fixing filesystem after stupid lvresize
Message-ID: <YvK7DHBN39teoOne@hungrycats.org>
References: <98E508AD-82F0-4DCC-B9F6-73D03462A604@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98E508AD-82F0-4DCC-B9F6-73D03462A604@icloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 01:18:37PM +0200, Alex Lieflander wrote:
> Hello,
>
> Thank you for your continued work on this awesome filesystem. I just
> made a really stupid mistake and now I can’t seem to `mount`, `btrfs
> check`, or `btrfs rescue` my filesystem. I’m wondering (hoping)
> that there’s an easy fix.
>
> The filesystem size was 4606G (3.78T used), the parent block device
> was 5T, it was mounted read-write, and there was a `btrfs receive`
> operation running. I accidentally `lvresize`-d the parent block
> device to 4792 bytes (but probably 1M since that’s my PV extent
> size) instead of 4792G. I didn’t realize the mistake yet and ran
> `btrfs file resize max` which completed without printing any errors.
>
> Within a few minutes I `lvresized`-d the filesystem back to 5T and
> tried to `btrfs file resize max` it, but by that point it was mounted
> read-only. I `umount`-ed it and could no longer `mount` it. When I try
> (with or without `-o usebackuproot`), I get "wrong fs type, bad option,
> bad superblock on /dev/dm-2, missing codepage or helper program,
> or other error.” `btrfs rescue -b` prints "All supers are valid,
> no need to recover”. `btrfs version` prints "btrfs-progs v5.18.1”
> (I compiled it myself). Please see the attached files for the output of
> `btrfs check` and `btrfs inspect-internal dump-super`.
>
> I don’t have any other disks large enough for `btrfs recover`
> and I’d really like to avoid using `btrfs rescue chunk-recover`
> if possible. Do you have any other suggestions?

You might want to look in /etc/lvm/backup or /etc/lvm/archive for old
versions of your LVM configuration.  The resized LV might not be in
the same location on disk as it used to be, and if that's the case,
it will break btrfs completely.

If you're lucky, the missing btrfs blocks are still on the disk, and
you can do a vgcfgrestore and get the old layout of the LV back;
otherwise, it's mkfs+restore time.

> Thanks,
> Alex Lieflander
> 

> Opening filesystem to check...
> checksum verify failed on 6393548521472 wanted 0x18a23d5c found 0xa56c5634
> checksum verify failed on 6393548521472 wanted 0x69c424f0 found 0x89318211
> checksum verify failed on 6393548521472 wanted 0x18a23d5c found 0xa56c5634
> bad tree block 6393548521472, bytenr mismatch, want=6393548521472, have=16977026753978170276
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system

> superblock: bytenr=65536, device=backup_crypt_3
> ---------------------------------------------------------
> csum_type		0 (crc32c)
> csum_size		4
> csum			0x3ce13204 [match]
> bytenr			65536
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			bae77875-a496-4758-9de1-28263b6a678f
> metadata_uuid		bae77875-a496-4758-9de1-28263b6a678f
> label			Postulate_Backup_3_Main
> generation		139646
> root			5959629045760
> sys_array_size		129
> chunk_root_generation	139300
> root_level		1
> chunk_root		23412736
> chunk_root_level	1
> log_root		0
> log_root_transid	0
> log_root_level		0
> total_bytes		4945654841344
> bytes_used		4159119925248
> sectorsize		4096
> nodesize		16384
> leafsize (deprecated)	16384
> stripesize		4096
> root_dir		6
> num_devices		1
> compat_flags		0x0
> compat_ro_flags		0x0
> incompat_flags		0x179
> 			( MIXED_BACKREF |
> 			  COMPRESS_LZO |
> 			  COMPRESS_ZSTD |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  SKINNY_METADATA )
> cache_generation	139646
> uuid_tree_generation	139646
> block_group_root	0
> block_group_root_generation	0
> block_group_root_level	0
> dev_item.uuid		b815cbe9-80b3-4439-a614-1a75bd4bb314
> dev_item.fsid		bae77875-a496-4758-9de1-28263b6a678f [match]
> dev_item.type		0
> dev_item.total_bytes	4945654841344
> dev_item.bytes_used	4247704829952
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		1
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
> dev_item.generation	0
> 

