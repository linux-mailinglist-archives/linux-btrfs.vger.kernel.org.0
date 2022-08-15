Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8234592E69
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiHOLrl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiHOLpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:45:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E259FFF
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 04:45:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D794A20839;
        Mon, 15 Aug 2022 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660563939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IG+W3GPsQxJWKRJrpoGUzYeFPdMahNbOtgGnByA4Hcw=;
        b=meKxjjkmwQXUW9IiarwIO229i5TZFyDTGKRWyFm+HJ+oblNkq8d60rnFRMPF8ngbD81lec
        CN5W9zfP0QwepLi9z2Z4aqYTFpi20lvik7rI2MpFBm2YoDQ1dMhu2vQUfxjbrC0XE+s6v/
        U9Bl31kt7X5pWvg0LskSs09Ciu60Vpk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 469D413A93;
        Mon, 15 Aug 2022 11:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hiARA+Ex+mLsGAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 0/8] U-boot: fs: add generic unaligned read offset handling
Date:   Mon, 15 Aug 2022 19:45:11 +0800
Message-Id: <cover.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
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

[CHANGELOG]
v3:
- Fix an error that we always return 0 actread bytes for unsupported fses
  For unsupported fses, we should also populate @total_read.
  Or we will just read the data but still return 0 for actually bytes.

  Now it pass all test_fs* cases.

v2
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
2.37.1

