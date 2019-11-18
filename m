Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3488FFFE25
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 06:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKRFxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 00:53:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40369 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfKRFxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 00:53:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so1720181pgd.7
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2019 21:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6dIah2qpSX7JdrW3yFwHDO6VBb4FkBSlKIz0MB1VVg=;
        b=BC/NIE3wtRjlKTwpdnGoKpAhnQAf62F9nTLLtwtNTVMpId05oYyg+ZjUfrN0DkQ1+q
         3lBiy11RCHj3KwD0COicXHLi2mQ7mCK5iGCLcVqhrUyJZkB7ERE943pOBUtm3uv+G5g5
         zmvysgXGDx7Vx1u6xn5fN+0sGFsRCc8+XVuLPQ10LUOhjjrtRvWX7ltg5qZFhOL82htR
         jEnkq0Wy7YUgAGpLKCohpjIK2KB8QEk3dUn7n0BwOt7OXu11wmfPyuLJyho33Wn27IBG
         fAhrApYkNHL/kTcaD4GWPqWEblLn0RXVXc5z52j7TchA6xzB1aCLMGcHYnkjB4IAcW4P
         Q9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6dIah2qpSX7JdrW3yFwHDO6VBb4FkBSlKIz0MB1VVg=;
        b=pWnu0DBsOPR6i6bbuBXgPgR3yJYpF2fzxzqtYFDF779GE0sj+NXQ6Zrb0v+uOjSVGZ
         umfg13O/x/DjFrsfHaPCGyozRR4LTik/244eMh0/mmApW1BRXmgQM5cVkTLowh+nU7b4
         TKS4a0cfG152Lj12MUWJ5X7QKsK6vNXwbRR2L37FOJDPdoNoBQU3Bc0x8S6p8Aj4JVHL
         FQPbS7M3TQQoRU3jrwPsgpBT1jXxKdnSh3lrAY060C2vmUrIamOjqQdqwPocL0rsgGaP
         OVILcXMW4Iz5wL9b8af4RP+tcl003369eeHstSanQv6Mr1rOszNdIGx0SCHn2QFAfQei
         eFIw==
X-Gm-Message-State: APjAAAXFuXiqdAazt+fskUDnxSIO7ersBu/uhXI7+bza9oq8e3kh5C0H
        G5hE2gZDpa4I7/4pp9iX34ovs0iBBKI=
X-Google-Smtp-Source: APXvYqzCovcXqVow4NVZ+t3W1aqrnrP/wjGy5CCjZ0QeCfIQHmgO7Kj633vZTByMFB8PuLxvpa2Ofw==
X-Received: by 2002:a63:6742:: with SMTP id b63mr8276441pgc.24.1574056423244;
        Sun, 17 Nov 2019 21:53:43 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id n62sm19838775pjc.6.2019.11.17.21.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 21:53:42 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH 2/2] btrfs-progs: fuzz-tests: add image trigers abort of open_ctree()
Date:   Mon, 18 Nov 2019 13:53:35 +0800
Message-Id: <20191118055335.9927-2-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118055335.9927-1-Damenly_Su@gmx.com>
References: <20191118055335.9927-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

This test case contains a bad block of dev tree and trigers abort while
open_ctree() due to its exquisite chunk layout. It can't be repaired
by fsck, so put it into fuzz-tests/images.

The image is provided by Ruud van Asseldonk. This commit just did xz
and writes the record.

Link: https://github.com/kdave/btrfs-progs/issues/210
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 .../images/bad-dev-tree-node.raw.txt          |  58 ++++++++++++++++++
 .../images/bad-dev-tree-node.raw.xz           | Bin 0 -> 18788 bytes
 2 files changed, 58 insertions(+)
 create mode 100644 tests/fuzz-tests/images/bad-dev-tree-node.raw.txt
 create mode 100644 tests/fuzz-tests/images/bad-dev-tree-node.raw.xz

diff --git a/tests/fuzz-tests/images/bad-dev-tree-node.raw.txt b/tests/fuzz-tests/images/bad-dev-tree-node.raw.txt
new file mode 100644
index 000000000000..64935568c7a6
--- /dev/null
+++ b/tests/fuzz-tests/images/bad-dev-tree-node.raw.txt
@@ -0,0 +1,58 @@
+URL: https://github.com/kdave/btrfs-progs/issues/210
+
+ruuda commented on Sep 24
+Running btrfs check on the attached minimal file system causes the following:
+
+Opening filesystem to check...
+extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
+btrfs(+0x2de57)[0x560c4d7cfe57]
+btrfs(+0x2e210)[0x560c4d7d0210]
+btrfs(set_extent_bits+0x254)[0x560c4d7d0854]
+btrfs(exclude_super_stripes+0xbf)[0x560c4d7c65ff]
+btrfs(btrfs_read_block_groups+0x29d)[0x560c4d7c698d]
+btrfs(btrfs_setup_all_roots+0x3f3)[0x560c4d7c0b23]
+btrfs(+0x1ef53)[0x560c4d7c0f53]
+btrfs(open_ctree_fs_info+0x90)[0x560c4d7c11a0]
+btrfs(+0x6d3f9)[0x560c4d80f3f9]
+btrfs(main+0x94)[0x560c4d7b60c4]
+/usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fd189773ee3]
+btrfs(_start+0x2e)[0x560c4d7b635e]
+zsh: abort (core dumped)  btrfs check /tmp/bad.btrfs
+Tested versions:
+
+v5.2.1 as shipped by Arch in 5.2.1-1
+v5.2.2 built from source (55a8c96)
+Data to reproduce:
+
+4a2d85625461bfed3cb60c53e5e913.zip
+
+GDB output:
+Starting program: /btrfs-progs/btrfs check bad-dev-tree-node.raw
+[Thread debugging using libthread_db enabled]
+Using host libthread_db library "/usr/lib/libthread_db.so.1".
+Opening filesystem to check...
+extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
+/btrfs-progs/btrfs(+0xa3fa8)[0x5555555f7fa8]
+/btrfs-progs/btrfs(+0xa4046)[0x5555555f8046]
+/btrfs-progs/btrfs(+0xa45f1)[0x5555555f85f1]
+/btrfs-progs/btrfs(set_extent_bits+0x83)[0x5555555f8c63]
+/btrfs-progs/btrfs(+0xbfb90)[0x555555613b90]
+/btrfs-progs/btrfs(exclude_super_stripes+0x1fc)[0x555555613de9]
+/btrfs-progs/btrfs(+0xbd85d)[0x55555561185d]
+/btrfs-progs/btrfs(btrfs_read_block_groups+0xd3)[0x5555556119f5]
+/btrfs-progs/btrfs(btrfs_setup_all_roots+0x454)[0x555555607740]
+/btrfs-progs/btrfs(+0xb4219)[0x555555608219]
+/btrfs-progs/btrfs(open_ctree_fs_info+0x177)[0x555555608415]
+/btrfs-progs/btrfs(+0x693dd)[0x5555555bd3dd]
+/btrfs-progs/btrfs(+0x14dc7)[0x555555568dc7]
+/btrfs-progs/btrfs(main+0x126)[0x555555569713]
+/usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ffff7a85153]
+/btrfs-progs/btrfs(_start+0x2e)[0x555555568cce]
+
+Program received signal SIGABRT, Aborted.
+0x00007ffff7a99f25 in raise () from /usr/lib/libc.so.6
+
+
+The compressed fuzz image causes above btrfsck abort.
+Fixed by commit "btrfs-progs: block group: do not exclude bytenr
+adjacent to block group".
diff --git a/tests/fuzz-tests/images/bad-dev-tree-node.raw.xz b/tests/fuzz-tests/images/bad-dev-tree-node.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..a6e62106da03d81a2dbafa23f0c8082d75f82af0
GIT binary patch
literal 18788
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

literal 0
HcmV?d00001

-- 
2.23.0

