Return-Path: <linux-btrfs+bounces-16996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C65B8A659
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9950A3BC67A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816F31E10C;
	Fri, 19 Sep 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN0uEklB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A46270553
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296955; cv=none; b=uA3spNXDlYj6Apt9p62C1tviaM35avHqcgzH9dsJOoKDBvM6UUw+Fli7jBd9DZfL5yOX2DSNNW+v7LBNrPFV7PazyF6Qs35FS8E8tfVkDOt0VC/nUyoLFXAfN0FPESfnZDaed0s6vVVhtg0cf9gGFqk9tAZEVHMvOw78FSbY5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296955; c=relaxed/simple;
	bh=WzMigsI8XU1Mz2+AbYO0H8GUDTcyXuAAvNIV83fgeQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAVehHHFwhQGuIP/6GqD5ji7hWdHkDRxwLhZ5aqlTqn++cUNx3LrWXJsBFdKbHSs0da31xYDze87P6z7pi34EZP5SVIGvW/OaCE1giU4IF2bE8QMo+Mz52bJ9hJ95OLJSEDM3m3UviVI2CR5ZJLp0Gi4XiBe+MYO+tSf8NVw6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN0uEklB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so21404745e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296952; x=1758901752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXzD2xToz4myOdiuXS9HZSpzaqk5AwYCBtvdB4YBjyk=;
        b=PN0uEklBHgpCgn//Emm0AXpUS6cZUg637Lj00tnQ+t6su9H1XK1u++Ghm1I0boekgj
         FLOm+I2Pwn97z7zB/jR1H9OC9OoaZYIyaezc5AtmjKWvSwxPwD9a6CQJoiOub08SKoLf
         SS3/33ifcVRO6ynEuof8X05nYkfxB+qsjUXs7wafjdOreLxs2kE688XnhrXOq9VSfcuL
         cFwz4mw8u8waEjcaWj7kBHHf8XS3FuNLjKeHdz/nqwaBEdYNpVoPbZDRSfX8gvxTQDy2
         vLb+kBf0GmeAjTZPH9TBfD+406kFlG7fxWfonYiQtHFE8p3K+qX0IzIIA/+30kGfNMW+
         9NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296952; x=1758901752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXzD2xToz4myOdiuXS9HZSpzaqk5AwYCBtvdB4YBjyk=;
        b=v5MSa3McuvfbOui4Q/g+voNq0zEVmAy/rH6bQ4pYRAE2BJw5hf6l7q4Q5FXdakMNEl
         W5bSX8FAWxqWdXW83j4I6R+O7Kz32BARcJ/wExZyHn/pX9ZMg/jBLTfqIWZTWDEDHwaF
         He4NsKxld/+tVFLUrlSI1odWeH6k79kXJPF5fOeDiwBu6ZJld+9roEWof4yQNGU53U8R
         qjGiUjropcio0QeeP7qlxqi9tIhWM/5Wh3VNd2XqUF8LTpxAw87+NnyTB8LLpXX7/gMQ
         +69cHYPmTqCFaj9pdGBja+0z4NTf0QWN17gDYwKCMc6zpstP12HVBDdvP70hEOxiT23q
         506Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjsw8/aOnw6h4Pby84SHaj+P/JOBzT9mDZdvix4+0ZQA3QJ7bWX3wuIv5GdVaIPbcGhBkcvNjP2enw5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhER1MOPUH//rGml2l8BZv00RLiiRDe/0cNEbaphjU/3ZoHPFf
	CSLCqSDMLEx2WB40ROdiyi1jJURr8ugI85iOaqIot/76ZMdHKvt/5ZPw
X-Gm-Gg: ASbGnctVAkcw6IoYuqmeHVV09GxD1qwh9zgXoQmSls+v4w1em+HlOnYYCBqAqBRZ3JZ
	1+lC+fkE1X3wuEFivoijoagmv5rZyXCeBtzEW8wIdtkbTT5ws6n5YqPnkln8JehiTBBhzfYKdDr
	3N6bUrY7oOP69awLA+uMpeOCAJwrID9GlRun4gJuuEYs/QsK4jCQ3MdFyQOQ2JjJbEQQmyFMfr1
	p3fhUhbVhHP0yirm7ICoq5gqI0OFHkdwHkcUOcmSFp0MSP3sXmmC0jwE7LDOJh8NCulUFkoko+D
	vGCfK9tJTAxhB0V33z2h3Q1IfDk4H1sDhF5sFOzBTaqW9kCoNnxHdDJ5Ei/W4uH8Vajn/Ma6fBt
	7kBR3rQW+mMlC3SJKAcP6auLxYhsiAVtA6Ow2H64UkjgwJVEMJogYGlZwqYv26V7ajIWFmxkDqe
	/y3c0liDs=
X-Google-Smtp-Source: AGHT+IEbFuXtdTSkzWivIeO3XAAKwZOU9is/JOJp4hfdLKzSu67HGXZJVYrLPblPcD5dEqny6zTaoA==
X-Received: by 2002:a05:600c:45c9:b0:45f:286e:49a8 with SMTP id 5b1f17b1804b1-467eaa88162mr40026405e9.30.1758296952033;
        Fri, 19 Sep 2025 08:49:12 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:11 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 0/4] hide ->i_state behind accessors
Date: Fri, 19 Sep 2025 17:49:00 +0200
Message-ID: <20250919154905.2592318-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is generated against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

First commit message quoted verbatim with rationable + API:

[quote]
Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

Given the late stage of the release cycle this patchset only aims to
hide access, it does not provide any of the checks.

Consumers can be trivially converted. Suppose flags I_A and I_B are to
be handled, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)
[/quote]

Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.

Given this, I decided to not submit any per-fs patches. Instead, the
conversion is done in 2 parts: coccinelle and whatever which was missed.

v5:
- drop lockdep for the time being

v4:
https://lore.kernel.org/linux-fsdevel/CAGudoHFViBUZ4TPNuLWC7qyK0v8LRwxbpZd9Mx3rHdh5GW9CrQ@mail.gmail.com/T/#m866b3b5740691de9b4008184a9a3f922dfa8e439

Mateusz Guzik (4):
  fs: provide accessors for ->i_state
  Convert the kernel to use ->i_state accessors
  Manual conversion of ->i_state uses
  fs: make plain ->i_state access fail to compile

 Documentation/filesystems/porting.rst |   2 +-
 block/bdev.c                          |   4 +-
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/9p/vfs_inode_dotl.c                |   2 +-
 fs/affs/inode.c                       |   2 +-
 fs/afs/dynroot.c                      |   6 +-
 fs/afs/inode.c                        |   6 +-
 fs/bcachefs/fs.c                      |   8 +-
 fs/befs/linuxvfs.c                    |   2 +-
 fs/bfs/inode.c                        |   2 +-
 fs/btrfs/inode.c                      |  10 +--
 fs/buffer.c                           |   4 +-
 fs/ceph/cache.c                       |   2 +-
 fs/ceph/crypto.c                      |   4 +-
 fs/ceph/file.c                        |   4 +-
 fs/ceph/inode.c                       |  28 +++---
 fs/coda/cnode.c                       |   4 +-
 fs/cramfs/inode.c                     |   2 +-
 fs/crypto/keyring.c                   |   2 +-
 fs/crypto/keysetup.c                  |   2 +-
 fs/dcache.c                           |   8 +-
 fs/drop_caches.c                      |   2 +-
 fs/ecryptfs/inode.c                   |   6 +-
 fs/efs/inode.c                        |   2 +-
 fs/erofs/inode.c                      |   2 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext4/inode.c                       |  10 +--
 fs/ext4/orphan.c                      |   4 +-
 fs/f2fs/data.c                        |   2 +-
 fs/f2fs/inode.c                       |   2 +-
 fs/f2fs/namei.c                       |   4 +-
 fs/f2fs/super.c                       |   2 +-
 fs/freevxfs/vxfs_inode.c              |   2 +-
 fs/fs-writeback.c                     | 121 +++++++++++++-------------
 fs/fuse/inode.c                       |   4 +-
 fs/gfs2/file.c                        |   2 +-
 fs/gfs2/glops.c                       |   2 +-
 fs/gfs2/inode.c                       |   4 +-
 fs/gfs2/ops_fstype.c                  |   2 +-
 fs/hfs/btree.c                        |   2 +-
 fs/hfs/inode.c                        |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/dir.c                         |   2 +-
 fs/hpfs/inode.c                       |   2 +-
 fs/inode.c                            | 100 ++++++++++-----------
 fs/isofs/inode.c                      |   2 +-
 fs/jffs2/fs.c                         |   4 +-
 fs/jfs/file.c                         |   4 +-
 fs/jfs/inode.c                        |   2 +-
 fs/jfs/jfs_txnmgr.c                   |   2 +-
 fs/kernfs/inode.c                     |   2 +-
 fs/libfs.c                            |   6 +-
 fs/minix/inode.c                      |   2 +-
 fs/namei.c                            |   8 +-
 fs/netfs/misc.c                       |   8 +-
 fs/netfs/read_single.c                |   6 +-
 fs/nfs/inode.c                        |   2 +-
 fs/nfs/pnfs.c                         |   2 +-
 fs/nfsd/vfs.c                         |   2 +-
 fs/nilfs2/cpfile.c                    |   2 +-
 fs/nilfs2/dat.c                       |   2 +-
 fs/nilfs2/ifile.c                     |   2 +-
 fs/nilfs2/inode.c                     |  10 +--
 fs/nilfs2/sufile.c                    |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ntfs3/inode.c                      |   2 +-
 fs/ocfs2/dlmglue.c                    |   2 +-
 fs/ocfs2/inode.c                      |  10 +--
 fs/omfs/inode.c                       |   2 +-
 fs/openpromfs/inode.c                 |   2 +-
 fs/orangefs/inode.c                   |   2 +-
 fs/orangefs/orangefs-utils.c          |   6 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/overlayfs/inode.c                  |   6 +-
 fs/overlayfs/util.c                   |  10 +--
 fs/pipe.c                             |   2 +-
 fs/qnx4/inode.c                       |   2 +-
 fs/qnx6/inode.c                       |   2 +-
 fs/quota/dquot.c                      |   2 +-
 fs/romfs/super.c                      |   2 +-
 fs/smb/client/cifsfs.c                |   2 +-
 fs/smb/client/inode.c                 |  14 +--
 fs/squashfs/inode.c                   |   2 +-
 fs/sync.c                             |   2 +-
 fs/ubifs/file.c                       |   2 +-
 fs/ubifs/super.c                      |   2 +-
 fs/udf/inode.c                        |   2 +-
 fs/ufs/inode.c                        |   2 +-
 fs/xfs/scrub/common.c                 |   2 +-
 fs/xfs/scrub/inode_repair.c           |   2 +-
 fs/xfs/scrub/parent.c                 |   2 +-
 fs/xfs/xfs_bmap_util.c                |   2 +-
 fs/xfs/xfs_health.c                   |   4 +-
 fs/xfs/xfs_icache.c                   |   6 +-
 fs/xfs/xfs_inode.c                    |   6 +-
 fs/xfs/xfs_inode_item.c               |   4 +-
 fs/xfs/xfs_iops.c                     |   2 +-
 fs/xfs/xfs_reflink.h                  |   2 +-
 fs/zonefs/super.c                     |   4 +-
 include/linux/backing-dev.h           |   3 +-
 include/linux/fs.h                    |  42 ++++++++-
 include/linux/writeback.h             |   4 +-
 include/trace/events/writeback.h      |   8 +-
 mm/backing-dev.c                      |   2 +-
 security/landlock/fs.c                |   2 +-
 107 files changed, 342 insertions(+), 304 deletions(-)

-- 
2.43.0


