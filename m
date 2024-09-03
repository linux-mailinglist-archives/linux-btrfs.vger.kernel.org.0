Return-Path: <linux-btrfs+bounces-7774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CE96950A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49041C22DEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05B200128;
	Tue,  3 Sep 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYnTtFnh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78A1D6C48;
	Tue,  3 Sep 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347802; cv=none; b=kIpV/kc99M7dIeRRSK7JWRwb/eBqtEalDY76fLYBN6EGXvl4ESZFcj+rpA2Aak5nB9+UJxMjwLc3alUQ3WQskqBKNjBAep9slpmhb4sT9SI32nUDhWvPJiVyeHJitIiKPoGTrh6FigP3vuu6epRLTnAJvq2m/FCd4uxxOgb2OUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347802; c=relaxed/simple;
	bh=+OQdfPxxcjTD3+sUfVA/9T2w8bAdEbP+yqDYsBHnQzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhJV3/j0PAG8IJ0IJqGUGSHXyn1VuZ6aZduC91v0caHPoCDh49bDkBHt94/kPzF/azupAik5NKHpNOBGVxrsCDOpOd+iyQQf77Ait5rJWubiuHK+KACONIfZ/xEb6w6DLaJD1HUmom6Gx1Jhxl9MJUrtu/VOmJYz1U8YFeODuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYnTtFnh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374bb1a3addso1914365f8f.1;
        Tue, 03 Sep 2024 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725347799; x=1725952599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjiEQutbL4t9l0my21gE0YieX3qenAsUUpmVjhWTT/Q=;
        b=KYnTtFnh2Edx9U9/T99U5E6ZWHNdwMz45yC3cVAkGQNS5bbXmIsCfizrqZPpRkVEZe
         TD1DQ63zNUYMQalCXcOWeA3ipyhqyilw8Ct/9N63vLPywV68WQ1hb1VPfLwggRLQoaXL
         z5P4CYc13jzSOELrw4730Gb0O3haDTpfeKHhobATbFHM8r4NhsdsjWzFFw1yM0ZfrE30
         f6ajkNJCz25dd5eGNfDbu+sCnqOBSJ6EBJzgo6YPKTG/n+xhem5HN8IkmBW1j2VbmZgk
         TEtwCVKTWUrOe4RaVJLCURJ3YrOAQX/yIlIfBGLri3pHeqcoc+eQkxIKyhCUAy76p2Az
         /4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347799; x=1725952599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjiEQutbL4t9l0my21gE0YieX3qenAsUUpmVjhWTT/Q=;
        b=cGPy9r3aCm7wb1fV5QmlvJT4IK7AkeJdyab7iG/3AhaXafWU/V4yVEgFxOXAQIfQxo
         H//g+halB70kSBbx9ZINqZFfwaQEvuhpmef1P4e5tHA/SvVbBOFYsToAOIwCJ3Ot079W
         sQ6RO3fLArJ1wUCWf3Z7sIv9AWdiCs9hd+809+NIvmbUgLKPlRC/NO1qal7pt15Yv9Vq
         NbUvn4lXZ1SVRgezivmNIsfss28mMfoF9O+xJwMPiROH+6JN2eBAe4Wzz7CDz8rgWLUK
         CidhI1xNY7RrwR3nqjA7g6olDJvDzjs3Hy/YqM0M5N8em48vXoRqESby9bgLYINPMzy2
         KeDg==
X-Forwarded-Encrypted: i=1; AJvYcCWcHJK6eZkz159aHzJVFqTo7yX/1Mzvs4mw0hPRt5AxJ9y86qWjKHgMyzrKTWJheeu3NPooVC3YrlBRmQ==@vger.kernel.org, AJvYcCX2TAEmoj/qN5ToIeXEhveRmrjZU1CUhyl24lMqzUHxguCauAL4yKn76sCyKPYv7Kqa5vz/yhHOtKCaWgMq@vger.kernel.org
X-Gm-Message-State: AOJu0YzTW6tSBuNonfB15LyDYDwol/OXcaNqtapjnmR174dlCPUI94ba
	7hUQtWnlToVKxQWqIs+xg1HHiiGahVz/WJLrT3qKf6AvNVoIPJfP
X-Google-Smtp-Source: AGHT+IE3qfgEJWSXt4JsHiQ6wXgNrsQ/B6JmvLau6Ed8BoyGcY6uxABDNzyVFgsHpouelO+9MZhtfg==
X-Received: by 2002:a5d:47c6:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-374c28793aamr7035251f8f.4.1725347798392;
        Tue, 03 Sep 2024 00:16:38 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm154349815e9.12.2024.09.03.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:16:37 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: Always update fstrim_range on failure
Date: Tue,  3 Sep 2024 09:16:10 +0200
Message-ID: <20240903071625.957275-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even in case of failure we could've discarded
some data and userspace should be made aware of it,
so copy fstrim_range to userspace regardless.

Also make sure to update the trimmed bytes amount
even if btrfs_trim_free_extents fails.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/ioctl.c       | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..a5966324607d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6551,13 +6551,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			continue;
 
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
+
+		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
 			break;
 		}
-
-		trimmed += group_trimmed;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..94d8f29b04c5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -543,13 +543,11 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 
 	range.minlen = max(range.minlen, minlen);
 	ret = btrfs_trim_fs(fs_info, &range);
-	if (ret < 0)
-		return ret;
 
 	if (copy_to_user(arg, &range, sizeof(range)))
 		return -EFAULT;
 
-	return 0;
+	return ret;
 }
 
 int __pure btrfs_is_empty_uuid(const u8 *uuid)
-- 
2.46.0


