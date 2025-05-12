Return-Path: <linux-btrfs+bounces-13869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C089AB2F4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 08:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B873A502C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 06:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2525525F;
	Mon, 12 May 2025 06:08:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71380B;
	Mon, 12 May 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030090; cv=none; b=i08vCZ6cfReqTP2FmBddVCtIRqKnlNTLRhMrO4AyELDMXNta/JHhvvlICaJ5VnPf/4UTWpA1wj/Qc9ysjeCdFb2q6277X/FFJboqNe3e09vdQ9uGmdd4Ld46tA6TYvXZP77G5cY7dntXFBCSC48xhDXtIIU2NP5d1EVgJsVXFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030090; c=relaxed/simple;
	bh=fHEYCej//BwYWTeTEr7nvzToJxSxPlXYUBTCLa6lLjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/hBmFfVaL7vFz8T8xT40MsjNXBrVIqhNcgvU/ky6mmwaJjGbeA6EOaMUFnZQmZ2iCLgraEg8Zb8owndMAlvQe+p2ApHCKIpu5rsTcBiSdVytCbJpRedL3t87YuNpccTb5DjEDV9s6jGYK5aTs5YPGMm4+OqxJVMRhxdWaHYVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so29167425e9.1;
        Sun, 11 May 2025 23:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747030087; x=1747634887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3y9pmlXthm8J5Wx50FXvvJS7IT+st1KgqJNvOkDQeA=;
        b=TcmymyNhswefGCpsmBFN8pYdY9GBqMjzdJNAC1/Yex29rogxTPEEptywIzxf5XE4p8
         Sdd1CW1v1ha3k7AFR4mJcOWKQiCG4jjHyufQLBA74HlSvL7AxoKcudZetCRHPUlpQWdK
         jLV6xb6wRQpe6kjf6SFUtOt2n1MUfv7a/O8AttYVXhn69Ix5NPiWnx9jjX0JnQt9LlhC
         s05142LSeLtL41sfXreaKPqVMeszMv5c+HTFEf0dRKyhSoiB1ZQSsNBObGCuuOfQueuE
         upp88dd3ar7zRgW4Z0AVFaBeoq3UR2yWL/SvO4vEdAl10nTkyeN/MaX7SZsLtPe+COVb
         7pnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3K4/75FpxD40xMWEyHLGoAC0Z53MrqCsopKVw6AYK4Dm99UGZ2Uwjr6NR8rCk9KYTKhU4v9p@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQKHSyagVr+MGSrzpfBXTXzQ0So+rwq2w4kuadOiqkU63W4qX
	U9rzGANoPAqUr3xL+LfjFMmB5rFAVm8LK9o4/Vkjwnfp4p45CWJz
X-Gm-Gg: ASbGncv7hLdYOIfhvF9rsdvzV77wUguwwjTahbQL1kPSIEpGgCEGmxSzxq9pxPPbMt7
	VRad0Q7+G8nbPBCte+CGDfjfMVPnpANA801KElaz3V3F3cUlcSUAO+cJ79Y8BNmmUDUlmSh/yFs
	Ck85ttomMIYkcdqnnGMvr+cLTo1DHhVJqpS1MoV/vv/JNfTzhV8FvxSx9MZiaBukZJ/oBlOqVVm
	qJuWSoQYvqcPxJhzyhi3hYmTRYOJw7FMLMbyCDfd5yypi1w9YG1CrjuC2DN1j9Jct98v//1eyKn
	ir5QsLCfrl6NRD1AQ9CeTYiusGdgmD7Xi/JtjQzzCFbUrAKfFHuounYKvU6IAFQQdZvIFpSzVEA
	tb+w0sLdWBbl6FOBYRHg/KTuf4NMx58tmWA==
X-Google-Smtp-Source: AGHT+IEvBLyw2MkL4S6LNYLErGhLqSSRAlm5UzhIP0ESZBH8xirfySKUZ9ChI9B/Le5gQz5BK1/sQg==
X-Received: by 2002:a05:600c:8707:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442d6ddd6eemr66167365e9.28.1747030086372;
        Sun, 11 May 2025 23:08:06 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f743d300fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f743:d300:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ebee9sm112296105e9.17.2025.05.11.23.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 23:08:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org,
	Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: btrfs: add git commit ID to btrfs/335
Date: Mon, 12 May 2025 08:07:49 +0200
Message-ID: <7b7c5af880673b1698b17fc183d369457e1a89f9.1747030065.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that kernel commit 'b0c26f479926 ("btrfs: zoned: return EIO on RAID1 block
group write pointer mismatch")' is merged, add git commit ID to fstests
btrfs/335 and also add the test to the auto group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/335 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/335 b/tests/btrfs/335
index 82085d4f04ef..eba1c7eac65c 100755
--- a/tests/btrfs/335
+++ b/tests/btrfs/335
@@ -9,11 +9,11 @@
 # position in the target zone.
 #
 . ./common/preamble
-_begin_fstest zone quick volume
+_begin_fstest zone quick volume auto
 
 . ./common/filter
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit b0c26f479926 \
 	"btrfs: zoned: return EIO on RAID1 block group write pointer mismatch"
 
 _require_scratch_dev_pool 2
-- 
2.43.0


