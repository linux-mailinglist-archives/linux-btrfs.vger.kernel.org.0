Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64F210EA22
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 13:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfLBMf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 07:35:29 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35822 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfLBMf3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 07:35:29 -0500
Received: by mail-pl1-f178.google.com with SMTP id s10so16170778plp.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uy2djPJUZLiJaUIfon//bBpHhFZDefRjLuL8K+gQt8I=;
        b=im5EI4gtByz/Ek6F1t7RdxkI6kowelk8ydlM13VpWxUOfKwILh5XjqtsEgdoYOZLFs
         sfYk++H0pn98q6ItXH2Hm7N7BDJpw7475tmHgqrynjp/AVU4V0lY8Md/IoA73llO7lqt
         ykiiVREUlwbKMnwlygfo3JVzsoDsD1XIOthxXpu9X038oFa+71Cf3qMfVMPiD4jPAPOh
         KOVZ4k0j2rsDCLnvmAxTgIs5+9vH/lo40JmWhJJeSQI8euiG/RY6T5AHyKYBsHP+WzQn
         l7gUmSV+4V9/HGn2qZQN4J29uOu/LLIO71IawwISqj8+NoMFkAG6ncdZEuAq7OWmnDLM
         LEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uy2djPJUZLiJaUIfon//bBpHhFZDefRjLuL8K+gQt8I=;
        b=Qckid5masboeGU0gxc2/fYeboUIZVz4yYoxZviW92k74YiSwHgSWztf36H9nwqj5++
         ri27DBmWmnG97FkHZb+nLLh0TsU5uJCwDtd1VERXdyc5kgJ9NTfaXanT/GAQ5sNruisO
         7a1yGOvZOgj7VwjbYgJxh2f8/rPSDK19A9/BPwdnMIRFzVRDbaMdNAR4BMPAVR/5ggw4
         IVEzuwwceYp6fjTLkcuKyXat7XqLSWS1kWDAf7EA7EAENdXcVnZT0kfXFTmBmpPqSSTG
         2OaMW6VJ2zSfTXcfYxPxEY1V6ii+FQtIJwaL3RRiLX4mqxNZRLY6uLExbnUacd9+nY26
         ZYug==
X-Gm-Message-State: APjAAAVg0OQLm5t2lr6gI8EwvIKYejQ/jAS8VYKwOZjrGYAnd2s2m/uT
        VSGWBiAk8O4zYqM0qYkRPWfwOBJZEio=
X-Google-Smtp-Source: APXvYqyHXkIyZDwoiI1NjDUpIf1kWzbQq4Jtjs4ULlUo5yiCCpUo7VL0jbgfuy3PDhzuIuv/MdI3qw==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr34372404pjr.90.1575290128663;
        Mon, 02 Dec 2019 04:35:28 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id l9sm20768054pgh.34.2019.12.02.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 04:35:28 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH v2] btrfs-progs: misc-tests/038: fix wrong field filtered under root directory
Date:   Mon,  2 Dec 2019 20:35:23 +0800
Message-Id: <20191202123523.6544-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191202115454.4749-1-Damenly_Su@gmx.com>
References: <20191202115454.4749-1-Damenly_Su@gmx.com>
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
Changelog:
v2:
  The version 1 is with problematic rule. And remove grep.
---
 tests/misc-tests/038-backup-root-corruption/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
index f15d0bbac291..1b3704169a88 100755
--- a/tests/misc-tests/038-backup-root-corruption/test.sh
+++ b/tests/misc-tests/038-backup-root-corruption/test.sh
@@ -23,7 +23,7 @@ dump_super() {
 # Ensure currently active backup slot is the expected one (slot 3)
 backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
 
-main_root_ptr=$(dump_super | grep root | head -n1 | awk '{print $2}')
+main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
 
 [ "$backup2_root_ptr" -eq "$main_root_ptr" ] || _fail "Backup slot 2 is not in use"
 
-- 
2.23.0

