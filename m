Return-Path: <linux-btrfs+bounces-16238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD83B306E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E46279D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375E37441A;
	Thu, 21 Aug 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3a2hxYO8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A303743E8
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807674; cv=none; b=ZgiofhsjuqbI0s8q1Wew2kMaLk/86zWZbg+6Q/hzI0io6nzDCL2TC+pQwVFAdFb2P83kp5yXJAB2wkI9TL6fqATobtABT45Vcyou4TJmR8vcZxphSwSM94xl5Zhd/u3IsT/9YWH2ck3ZWMmfhfjW8z2eFRXkO8K4J0BHzd9BDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807674; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAdTbX1eWwO5Cd0m5lbSugwbDIRRdau93amyCFPAkKV7yhflvrD8k+ThX3/y6YIZnQOLSP/aUwxePWzduOkFYL7W4Cv9Njxcu+sOOepcs2ERNsZxo5lwwYBc6babbbRlSAtFDLWnz2ba29+3g2CuF0IvY8bX8+MMPR4/V4xcBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3a2hxYO8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d6014810fso13120327b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807672; x=1756412472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=3a2hxYO836tfYyAVGnW2blIN319c+qyOm7QlScVs2dhASeE6ZvyGrxPDmVBKRoC6qE
         QpkTSKqg8J26CU9WfvFxJ70pIZ0XCbvcuw1cb/rYJ2Py2VKfxnlLyUDj5k54VpgQMB7I
         D4H3EZY0f2UnpxdoJN4FAxMCfi7ZVc6QajhNg4u8PrPFa6jOAaIYfoPQs/ef3alEfGwc
         jbdNtGvRTYzolRxjlcNTad9E3z+CjSFwtiL0J9XrRdL0EUPGovsRklQptL7mIDBgjbpF
         lE5T2t4tH/9uaoc7uWQt7NExagl/cwsl+VKq69S1Yxjv1Y3o6a+5aud9ylZuC4vmLAY9
         +XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807672; x=1756412472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=QNLaCm8iOwulNVDI+vRn3qR0L220qFBOYC+2a0O2VmxXSGW7zwXupInG48ZhJvWbtl
         fE4DROLWAYDqD0YnrIzHyKWp8FYnvUEbNLo//LjHrA6ulXE61a3TL+5xRLi/VyIsBDUs
         bzjIoYfBkMckTP/sp1YS9xkAcjHTKnVnMnTHi61Q93ZKeVT7A6x4t3INACpSWbaBDD2u
         JJSNCodQfQEBq8YjdTyBXbRmy7nlFHab1PloKXSsofXBurLfgk/WaGPB76HKZc2yJ/6j
         7NsumYfqYr3qE7KsBhjRVIIZYqNmozB8hGrhzPPc6onm6wwKsBewLL1PKJjxlkDwo4DN
         Vfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVF/ip3rnTeHqKFLKjcCPL6wirCBxUWTES1mcpf6ie4RopF749IYLrFaEsqHvctV74BiPeAuLv3o+xbQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeELOpZzm1nv1JyjQI4IIm7fYHuFRM+vaZnBRCroZ5iApMHdSu
	vaOGK6m5PPqqSkY9C8UXAsS0s795id0Noxk0t9602bVKVcpQF/Am0DrL8So8bH+g5h4=
X-Gm-Gg: ASbGncvrFK+3KD5CawjNAwh70h7CBKQRl9v2BWff94JNnu361Jk/4RcbbuWS3pYdoTa
	zXiimFY4rbd/Pd2WslFZMdLeCTPV800rgNZ4v3exLUdi0RUbneuPz2ecLaf7+rpKz9ohzElOP9t
	CLnP6HNxCp9ElVnEZF/SzO29piN6NdkvISo3kqEJOEFJNzD6tGiuVhQVRygOjn4Tmku4W8L+mU9
	9xo47eIHVYqcHfpfxwmmoU3cnIr2IFaIUBA0Gq+nL6nIjCSWOPTKBL1A0Dv2qEFqEymwMxf0W8p
	f0LTIFcn1LdUWlqH7v/84HBthgXxYbUHIfwU93J6i92dqpC4c0nKm2zCvNLByiX6SyD5KhwPCTd
	EHM0/JjkIaqAbeV3geF22K3YVuUi4IGpTftD2SXzIRKnTO7oZRa7rCIgphf7qK/822Xei+Q==
X-Google-Smtp-Source: AGHT+IHgWhO0XZL2d+T13fQCGNTnfEWS9ecA9Ina0HETuoa+JmM/sUYXK320kf/CPFEnDhrEBPT2MA==
X-Received: by 2002:a05:690c:6d13:b0:71e:8165:990f with SMTP id 00721157ae682-71fdc316064mr7520287b3.24.1755807672210;
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871437b3.74.2025.08.21.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 37/50] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Thu, 21 Aug 2025 16:18:48 -0400
Message-ID: <109daa67d809b78526099377be7f9fef59608010.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


