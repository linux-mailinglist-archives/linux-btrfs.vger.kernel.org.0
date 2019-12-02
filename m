Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F405F10E9D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLBLzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 06:55:00 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:38222 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfLBLzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 06:55:00 -0500
Received: by mail-pj1-f41.google.com with SMTP id l4so5451469pjt.5
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBRIAJRLKjmbToGUW4QLm+UYZd79vXmt6WKIsRlF23M=;
        b=IUwfQaWFFa3RUhJ61Az8hFsLZt88CfYeZhwd2soCShOzGoRlm7iP8vTRIzk93BVQAv
         u07SnEb0xTKlW8KXdWcnOUJ+m9cIR6IJAAnYMRNH/w8KMPSW1n+C5yTh8TcnUQ4e1N/W
         MYgOSYfWrM/5rYWaQ5ppf2hzNTwUnRCIbPSyzNilmOzeluJnvMYUoSj1FrIv4zYZkwSS
         +fqP1sFlZnQpFr9Mgtpj/EElgj5SLx5uzBvSV4QdzJxza6cHkefCizGwiHdVRQS9otbH
         nYBImzNRnxTShJlBR4zR5hVILdxHl/qoRxBRny5eWA+ZqUnfxcCWqHEUUdvN4Lm8Xe/T
         WlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBRIAJRLKjmbToGUW4QLm+UYZd79vXmt6WKIsRlF23M=;
        b=E++VZyncKG50/gAduBmLcPuKXHCr1aajHjTesKDwO8gYgFQ8sFzegfPB9c9NSh7NfW
         v1D/h3mttGCj/bzq0ukXIZKbZijq8oU8tGCO/JWb6DXMu34/IF/ggcBqna8ZQEgv9JM4
         8KxOuX+XhUuMWDwLYC01VEOmwAPqkzY5sjKFDEMVaYzQJ8QCJzPuJYY2wby5zQnu9WUq
         hSIk8mjY9X3R3em6GCpzEaK6nTUVWtaosVviQsmWRKWiuKiDeE6cWnY69pI2s19TwcRg
         vH0PVc9pBtv9XR5tfuaXqT6jWNSdB4nO3xmHmla+TLXs+9c7r2fyjgheSpVDmUpuo2Jk
         GVjw==
X-Gm-Message-State: APjAAAXvETC40CHQw4edj2YtDvnJvnfjXbmoKJpYf4QagCaHowXAcfSz
        LMkgFZuguyxGGVW1E2AhnRcUhXvG0CI=
X-Google-Smtp-Source: APXvYqw1nQshyzAPFKEeLyGeZS0/yBAUy86wcG620usO4SzgY/Fs70Wzrtf52ZC+uwZ0rxNoxglQyw==
X-Received: by 2002:a17:90a:1b4d:: with SMTP id q71mr34482469pjq.120.1575287699856;
        Mon, 02 Dec 2019 03:54:59 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id a6sm31208394pgg.25.2019.12.02.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 03:54:59 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH] btrfs-progs: misc-tests/038: fix wrong field filtered under root directory
Date:   Mon,  2 Dec 2019 19:54:54 +0800
Message-Id: <20191202115454.4749-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Ran misc-tests/038 in /root/btrfs-progs:
======================================================================
make test-misc TEST=038\*
    [TEST]   misc-tests.sh
    [TEST/misc]   038-backup-root-corruption
./test.sh: line 33: [: bytenr=65536,: integer expression expected
Backup slot 2 is not in use
test failed for case 038-backup-root-corruption
make: *** [Makefile:401: test-misc] Error 1
======================================================================

It's caused by the wrong line filtered by
$(dump_super | grep root | head -n1 | awk '{print $2}').

The $(dump-super | grep root) outputs
======================================================================
superblock: bytenr=65536, device=/root/btrfs-progs/tests/test.img
root                    30605312
chunk_root_generation   5
root_level              0
chunk_root              22036480
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
root_dir                6
backup_roots[4]:
======================================================================

Here
"superblock: bytenr=65536, device=/root/btrfs-progs/tests/test.img" is
selected but not the line "root                    30605312".

Restricting the awk rule can fix it.

Fixes: 78a3831d46ec ("btrfs-progs: tests: Test backup root retention logic")
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 tests/misc-tests/038-backup-root-corruption/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index f15d0bba..e5979c76 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -23,7 +23,7 @@ dump_super() {
 # Ensure currently active backup slot is the expected one (slot 3)
 backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
 
-main_root_ptr=$(dump_super | grep root | head -n1 | awk '{print $2}')
+main_root_ptr=$(dump_super | grep root | awk '^/root\t/{print $2}')
 
 [ "$backup2_root_ptr" -eq "$main_root_ptr" ] || _fail "Backup slot 2 is not in use"
 
-- 
2.24.0

