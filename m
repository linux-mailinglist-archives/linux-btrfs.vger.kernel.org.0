Return-Path: <linux-btrfs+bounces-179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E217EFEA3
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 10:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EEE280CE4
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAB107A3;
	Sat, 18 Nov 2023 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ2VTDsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944ED6D;
	Sat, 18 Nov 2023 01:10:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so2147112a12.1;
        Sat, 18 Nov 2023 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700298618; x=1700903418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgBxE/ugFyl092H9J0iO9taumdI7C9DtObSl7itfE5Q=;
        b=BZ2VTDsVVaoTD8MTtz4O55MrJBW8VOsNF2AE4zWu8xofBO/4GTNKVQAHguST46H7tq
         XbZ+GfkHq1SRHjnL5cPGWcrgUxbEPtrEN2yHVvp+uEpfU2tbuR62fnk8i/11I1xD/eJl
         F3WafN1K+ky5FzgHY761OueJmqQec2Q6dVoy5sAs5jwG/71OXUnCVXYLPgOsbvYEAb0z
         4j1RBOJA9Oei5X2JUxsnT7/vYjP/CY9KRwVafEHVDS8l5lhsv843XzJxw1d02BTbK8Fl
         hZyWE5wa3HhSdmVFPo2NmDUZIodkYwPKXiuQh6ktfDuA4Ccp4WOElUz0Aswhg3izZacO
         V30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700298618; x=1700903418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgBxE/ugFyl092H9J0iO9taumdI7C9DtObSl7itfE5Q=;
        b=BPiyy3NWnFnC2p/zZesR1unB+66h3Nngzbxl+n4Mo5b5YeESOUO3EtPntbokI3K7m0
         51dfeADVBbodhYyDjZF5OoyoWvM5M/HPTnFTpOtv9+bFugIfdqBZ8lUYWOzYSWWDFN7E
         AnmwTEP+O3m/K79iuTgz0g541CffNm2k8xRQbYK7kYR0b6HxqvWJpPMtdp7KkObAx1fc
         9aw3R6JBdjQOqsuYrdQxkXUIQkWRg7q0deGx1NmI3wrTABzH/h3Ydu2Aa06HeRlJeU22
         t/rYsvi2H7kg+RTndhSjwJm70nTD5+ZyKKxQqPIRASNu0RjET9j3ne4SAYE/fqudDTeu
         gm0A==
X-Gm-Message-State: AOJu0YyPDVduaOvcQS74AAzOsxFftpy1+9/qmq5FWOVZxe34DoHjkiXh
	/RA0OmRlrCPBRnC04EAqB/k=
X-Google-Smtp-Source: AGHT+IHAjtEOF/rmYOaUe+ODWsp0dqRq+tCEuYpytFyN6PRshL42r7YuuwKybEcC/ACWVjggOp4AOg==
X-Received: by 2002:a05:6a20:7faa:b0:186:664b:44a6 with SMTP id d42-20020a056a207faa00b00186664b44a6mr2489534pzj.48.1700298618376;
        Sat, 18 Nov 2023 01:10:18 -0800 (PST)
Received: from brag-vm.. ([59.182.202.200])
        by smtp.gmail.com with ESMTPSA id fj17-20020a056a003a1100b006cb4379061esm1112105pfb.205.2023.11.18.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 01:10:18 -0800 (PST)
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Subject: [PATCH v2] btrfs: ref-verify: fix memory leaks
Date: Sat, 18 Nov 2023 14:40:12 +0530
Message-Id: <20231118091012.14818-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btrfs_ref_tree_mod(), when !parent 're' was allocated
through kmalloc(). In the following code, if an error occurs,
the execution will be redirected to 'out' or 'out_unlock' and
the function will be exited. However, on some of the paths,
're' are not deallocated and may lead to memory leaks.

For example : lookup_block_entry() for 'be' returns null, the
out label will be invoked. During that flow ref and ra was
freed but not re, which can potentially lead to memleak

Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
V1 -> V2: 're' shouldn't be freed after it added to rbtree

 fs/btrfs/ref-verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 1f62976bee82..6486f0d7e993 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -794,6 +794,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		} else if (be->num_refs == 0) {
 			btrfs_err(fs_info,
@@ -803,6 +804,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 
-- 
2.34.1


