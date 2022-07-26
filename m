Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D3580AC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 07:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiGZFWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiGZFWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 01:22:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C327CD5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 22:22:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD311F9C3;
        Tue, 26 Jul 2022 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658812957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N5vMrlZsznWTxDDP5VjzMo40WkvisIyfwBvd8HxY+Lw=;
        b=UtLL8nr+Rb2hlOoLtPbEKf4D+iLxk3NNRqZdx2ka85l+XKRZQ8926YRnzyfwqTtvgIxrlC
        CSkeXFdKaNwPFNor+94W2IaCjkNHP8asK/hxEmBYfKYKs/FsAX8qLiR7S5YsPkQ3OTHNQb
        Tbf93y8ovMV8xT/aka+2l92fJ5VFRLE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B8D013A12;
        Tue, 26 Jul 2022 05:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5Ep5Ext632IFOwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 26 Jul 2022 05:22:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 0/8] U-boot: fs: add generic unaligned read offset handling
Date:   Tue, 26 Jul 2022 13:22:08 +0800
Message-Id: <cover.1658812744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2->v1:
- Fix a linkage error where (U64 % U32) is called without proper helper
  Fix it with U64 & (U32 - 1), as the U32 value (@blocksize) should
  always be power of 2, thus (@blocksize - 1) is the mask we want to
  calculate the offset inside the block.

  Above change only affects the 4th patch, everything else is not
  touched.

RFC->v1:
- More (manual) testing
  Unfortunately, in the latest master (75967970850a), the fs-tests.sh
  always seems to hang at preparing the fs image.

  Thus still has to do manual testing, tested btrfs, ext4 and fat, with
  aligned and unaligned read, also added soft link read, all looks fine here.

  Extra testing is still appreciated.

- Two more btrfs specific bug fixes
  All exposed during manual tests

- Remove the tailing unaligned block handling
  In fact, all fses can easily handle such case, just a min() call is
  enough.

- Remove the support for sandboxfs
  Since it's using read() calls, really no need to do block alignment
  check.

- Enhanced blocksize check
  Ensure the returned blocksize is not only non-error, but also
  non-zero.

This patchset can be fetched from github:
https://github.com/adam900710/u-boot/tree/fs_unaligned_read

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

- Read the remaining range which starts at block aligned offset
  For most common case, which is 0 offset and 0 len, the code will not
  be changed at all.

Just one extra get_blocksize() call, and for FAT/Btrfs/EROFS they all have
cached blocksize, thus it takes almost no extra cost.

Although for EXT4, it doesn't seem to cache the blocksize globally,
thus has to do a path resolve and grab the blocksize.

[DISADVANTAGE]
The involved problem is:

- Extra path resolving
  All those supported fs may have to do one extra path resolve if the
  read offset is not aligned.

  For EXT4, it will do one extra path resolve just to grab the
  blocksize.

For data read which starts at offset 0 (the most common case), it
should cause *NO* difference in performance.
As the extra handling is only for unaligned offset.

The common path is not really modified.

[SUPPORTED FSES]

- Btrfs (manually tested*)
- Ext4 (manually tested)
- FAT (manually tested)
- Erofs
- ubifs (unable to test, due to compile failure)

*: Failed to get the test cases run, thus have to go sandbox mode, and
attach an image with target fs, load the target file (with unaligned
range) and compare the result using md5sum.

For EXT4/FAT, they may need extra cleanup, as their existing unaligned
range handling is no longer needed anymore, cleaning them up should free 
more code lines than the added one.

Just not confident enough to modify them all by myself.

[UNSUPPORTED FSES]
- Squashfs
  They don't support non-zero offset, thus it can not handle the block
  aligned range.
  Need extra help to add block aligned offset support.

- Semihostfs
- Sandboxfs
  They all use read() directly, no need to do alignment check at all.

Extra testing/feedback is always appreciated.

Qu Wenruo (8):
  fs: fat: unexport file_fat_read_at()
  fs: btrfs: fix a bug which no data get read if the length is not 0
  fs: btrfs: fix a crash if specified range is beyond file size
  fs: btrfs: move the unaligned read code to _fs_read() for btrfs
  fs: ext4: rely on _fs_read() to handle leading unaligned block read
  fs: fat: rely on higher layer to get block aligned read range
  fs: ubifs: rely on higher layer to do unaligned read
  fs: erofs: add unaligned read range handling

 fs/btrfs/btrfs.c      |  33 ++++++++---
 fs/btrfs/inode.c      |  89 +++--------------------------
 fs/erofs/internal.h   |   1 +
 fs/erofs/super.c      |   6 ++
 fs/ext4/ext4fs.c      |  22 +++++++
 fs/fat/fat.c          |  17 +++++-
 fs/fs.c               | 130 +++++++++++++++++++++++++++++++++++++++---
 fs/ubifs/ubifs.c      |  13 +++--
 include/btrfs.h       |   1 +
 include/erofs.h       |   1 +
 include/ext4fs.h      |   1 +
 include/fat.h         |   3 +-
 include/ubifs_uboot.h |   1 +
 13 files changed, 212 insertions(+), 106 deletions(-)

-- 
2.37.0

