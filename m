Return-Path: <linux-btrfs+bounces-9201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011769B4555
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 10:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935FE28336B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AD2040A1;
	Tue, 29 Oct 2024 09:11:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17D200BBC;
	Tue, 29 Oct 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193104; cv=none; b=Fv+EYXp48FBnnYdYetNl1ttpY+GhLfti6ygCdY3meeQ3TVrGyYNxD8fGu+sMELeeNIQUkPwrwSPxT5xL7lIV1+QBqMrMB8BCfpnjnjM82qSBdN227hs0aoA5F4rbp2WvojBJj1BvxAOwojI+QIu0u6b54JJ1XqE5MnjrugQ7Aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193104; c=relaxed/simple;
	bh=SvUjc0ShhUJ8PhVnVn5bxNftQP0fRbqFlsWFRRWwIMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUrUvGPaCkAZSaq1y6IX7rgNeNf2JhtdaWUiNBt6We3DvDD0oPhYwqpRWWTkNLWFG7Oc37B1GXNQBsrdt/+mLNNsa24Ys7CPlAhLeWZMeDSY0oUT2kHilbQmeGp7vGW94JMFXr8QjYfVZ+Ch44STZKrt9GTk5RllvMBhOSzN3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5319918e87.2;
        Tue, 29 Oct 2024 02:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193101; x=1730797901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHFBQa6cjEimlbCXbA9xxyetkthyL4ca8SFHWzeSkLA=;
        b=P7T9iXh55ZBwpEyZeqwmPcIpj2xA5ABILTnrfWK+52AGWNPfIXiDByblLVsVhL1twX
         G+1hv/EztDs7Pknnn3o2qmZeQj3Cch4c4Gnbni9L9eUf/YGIVScn3x4+dVrt0DGGOCrx
         XjnAWQC05byhsM5g9crgK0BJGowNVfFEL94zVDpwUK0flf6TFhHnzUqPskBzOPpPWMDw
         EElzV4VmDCv4WXuAuLGPqy1Xp+uo3lcjazJ37indzAXyygVdeXIYiKy4AKiIcJITyHaC
         i8ITkX9uP2dnDRnzS3RqThS/i5Mn3HSONwD5sa+ucnmLATuPBrmA8NlXsAoU2mUnHVw5
         7TYw==
X-Forwarded-Encrypted: i=1; AJvYcCVCOqlFwvo+94cWiQr6pn3f6EHAzFhEWFn7wN+NlKqj4yuIHnn+mx/1EzX3qY7raWcTP14V2uVf2DIUtA==@vger.kernel.org, AJvYcCXTCMluGaBRvwnhscXxeYAQGmfQVOnFA4PJs/OGJGp+mmu67pragERiYeqSssq8jorsO6gkAiKrTd2TWg==@vger.kernel.org, AJvYcCXeRGvTK9dtNd7/WO2SZq9yLuNPK1MhVkF7zDquNtgP9cewXHlwcXjnVXtlwViH+bPG+lBKc0olt6Djw8RI@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0WdsmW83HaT0dP2W5EA0BgH0AtqvDiMCG9pZ6rqh5p0CYYph
	hgs74ApkkOtO+K4MznQnMQ8TKEsk6a7eByRp1HaWwQGIOb+4rfwZ
X-Google-Smtp-Source: AGHT+IFJTESo4oJeQB4cKVRo8UjWHZscVtmUPs2gtEXYHYwUup2fKpV699zrxFmWr9bDUda49tBLDQ==
X-Received: by 2002:a05:6512:3404:b0:53b:27ba:2d11 with SMTP id 2adb3069b0e04-53b348cb2cbmr6032968e87.16.1730193100751;
        Tue, 29 Oct 2024 02:11:40 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b929a8sm12000095f8f.103.2024.10.29.02.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:11:40 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	axboe@kernel.dk,
	song@kernel.org,
	yukuai3@huawei.com,
	hch@lst.de,
	martin.petersen@oracle.com,
	hare@suse.de,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: handle bio_split() error
Date: Tue, 29 Oct 2024 10:11:21 +0100
Message-ID: <20241029091121.16281-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028152730.3377030-1-john.g.garry@oracle.com>
References: <20241028152730.3377030-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that bio_split() can return errors, add error handling for it in
btrfs_split_bio() and ultimately btrfs_submit_chunk().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

John,
in case you have to send a v3, can you please include this one in your series?

 fs/btrfs/bio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..96cacd5c03a5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
 			&btrfs_clone_bioset);
+	if (IS_ERR(bio))
+		return ERR_CAST(bio);
+
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -687,6 +690,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 	if (map_length < length) {
 		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(bbio)) {
+			ret = PTR_ERR(bbio);
+			goto fail;
+		}
 		bio = &bbio->bio;
 	}
 
-- 
2.43.0


