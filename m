Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B055C2A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiF1H2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiF1H2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FAC1EEF8
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE481FB3C;
        Tue, 28 Jun 2022 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TCuBU9+Ebtl78YYJEE8nANTF1gTekBtlwBuL1hrnFno=;
        b=hnsPtvLr91hqMQ1zdevFt2N0w8TzyJSlnCLlI2oY2a7KZOGUYmP48JDjHJRLm3crAsI+RI
        /oEXTOZ6O22XZdP3aRdJRa4kxDRR57m46g5YB2l9zfQhj9/9CDfDr/861GgblVY6h3EyUB
        39nGNDYBLI4K/XSzt0f3y2rgDrHnIMw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03EFD139E9;
        Tue, 28 Jun 2022 07:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ahE+L5mtumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Date:   Tue, 28 Jun 2022 15:28:00 +0800
Message-Id: <cover.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
just pass the request range to underlying fses.

Under most case, this works fine, as U-boot only really needs to read
the whole file (aka, 0 for both offset and len, len will be later
determined using file size).

But if some advanced user/script wants to extract kernel/initramfs from
combined image, we may need to do unaligned read in that case.

[ADVANTAGE]
This patchset will handle unaligned read range in _fs_read():

- Get blocksize of the underlying fs

- Read the leading block contianing the unaligned range
  The full block will be stored in a local buffer, then only copy
  the bytes in the unaligned range into the destination buffer.

  If the first block covers the whole range, we just call it aday.

- Read the aligned range if there is any

- Read the tailing block containing the unaligned range
  And copy the covered range into the destination.

[DISADVANTAGE]
There are mainly two problems:

- Extra memory allocation for every _fs_read() call
  For the leading and tailing block.

- Extra path resolving
  All those supported fs will have to do extra path resolving up to 2
  times (one for the leading block, one for the tailing block).
  This may slow down the read.

[SUPPORTED FSES]

- Btrfs (manually tested*)
- Ext4 (manually tested)
- FAT (manually tested)
- Erofs
- sandboxfs
- ubifs

*: Failed to get the test cases run, thus have to go sandbox mode, and
attach an image with target fs, load the target file (with unaligned
range) and compare the result using md5sum.

For EXT4/FAT, they may need extra cleanup, as their existing unaligned
range handling is no longer needed anymore, cleaning them up should free 
more code lines than the added one.

Just not confident enough to modify them all by myself.

[UNSUPPORTED FSES]
- Squashfs
  They don't support non-zero offset, thus it can not handle the tailing
  block reading.
  Need extra help to add block aligned offset support.

- Semihostfs
  It's using hardcoded trap to do system calls, not sure how it would
  work for stat() call.

Extra testing/feedback is always appreciated.


Qu Wenruo (8):
  fs: fat: unexport file_fat_read_at()
  fs: always get the file size in _fs_read()
  fs: btrfs: move the unaligned read code to _fs_read() for btrfs
  fs: ext4: rely on _fs_read() to pass block aligned range into
    ext4fs_read_file()
  fs: fat: rely on higher layer to get block aligned read range
  fs: sandboxfs: add sandbox_fs_get_blocksize()
  fs: ubifs: rely on higher layer to do unaligned read
  fs: erofs: add unaligned read range handling

 arch/sandbox/cpu/os.c  |  11 +++
 fs/btrfs/btrfs.c       |  24 +++---
 fs/btrfs/inode.c       |  84 ++------------------
 fs/erofs/internal.h    |   1 +
 fs/erofs/super.c       |   6 ++
 fs/ext4/ext4fs.c       |  11 +++
 fs/fat/fat.c           |  17 ++++-
 fs/fs.c                | 169 +++++++++++++++++++++++++++++++++++++++--
 fs/sandbox/sandboxfs.c |  14 ++++
 fs/ubifs/ubifs.c       |  13 ++--
 include/btrfs.h        |   1 +
 include/erofs.h        |   1 +
 include/ext4fs.h       |   1 +
 include/fat.h          |   3 +-
 include/os.h           |   8 ++
 include/sandboxfs.h    |   1 +
 include/ubifs_uboot.h  |   1 +
 17 files changed, 258 insertions(+), 108 deletions(-)

-- 
2.36.1

