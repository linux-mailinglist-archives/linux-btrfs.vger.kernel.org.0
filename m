Return-Path: <linux-btrfs+bounces-16391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3DB36E6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC24A8E5EAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1C362985;
	Tue, 26 Aug 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ATwT5TzG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6424362068
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222886; cv=none; b=n1gEdvaM5f32OjA0pl0spxeKT+mehn2VtvsUSUS6f2m2hkOxRoM2BgNq8e5XGxNMdmBt60zaTn15rWoqF8gaBMlPlcvP3Z7Sb8uT8DXzXhYspmyY/6zL3lmuzj0cVf0osala8ABaTs+gSLFavt7ltuiRyCPjJf703Mzd4kjLjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222886; c=relaxed/simple;
	bh=BcsxwfXtk0iNo1/SL2s/ecZqZhvAJgKGVc1u5U8/F38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilhnqfCp23lPjxKj3c3xPrfT+3T1kYye6eoF+rJWUKzuVhT7zjEz+fK4Iy0J1VknlFzRquEfKNuU9xPD9tBS1z5kn3B0csxau+MOrmr6D19eWLv9yCb+G+/uW2LHjK9biW+VdXdqMKUOKhER60xIKKKR1jGov6fBfLdm9qzBwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ATwT5TzG; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e967d4acaa0so2118294276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222884; x=1756827684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj/q5LV/Zjj+RGaDytTI7HVb3/yBVl27+fEybeIP2II=;
        b=ATwT5TzGHoxrj7PHJUbtByIbeBESmWp6ty18jiEYudGN9FBVYPOqTdTOeEIY7YBhMI
         Rppdv+reft/PaddOUc2vqF66FppCm1CPyfvy1sQTNikiO2Qh7sB3tNfGqxJEK3OtbFcH
         oRaoVl2QtV6cfmLBwh2BBH0pWG2UmsD2YQx7GmhIEPcGxSQp8VeHsaUi44XoEf+wNa1u
         WjUOHyXIsLfggsqbewQ58u/GrhjICly1+nVh+BIGyIk+ry1i0hbHCkGr8LYFiZrrT+xP
         wgQiL4bmSOyWHTw1tmPcJZku8ay62pA6qadRvIs1P31XbhS5ltysvtAmXNcOwko7cLFX
         N8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222884; x=1756827684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj/q5LV/Zjj+RGaDytTI7HVb3/yBVl27+fEybeIP2II=;
        b=Qh66uax7ru1I9ikHNxvAKbn2g4WZBnb3KQhRtqOVKv4+l6AWdXgWmZwzGYdxxdwggt
         7XckZeP8eG1ifUbz9w8nZ9lz7my0MaZA2Kp7Algaea/e5t2nytokAqeb30V4OqCbdeQ4
         pzr7Bz1OT2V4RPD8JZTWRPfbT+k3lInuTj69d6If0Whi+TGZnOfaNOx8zBGb4df7xFUd
         fANzF86Cdy2kRVMLUN9ODoRLOmfxn3rT+Pv6Kt6ibSaEFmUJmMoYZDxn8xFSqoujyqF1
         GWOusMhqc1Cn+occ0wQMVgC/YbggrZLYBjz9Ax8B4XjY+VSvvcttXlSX/Cp5PfxQYRq5
         NTZA==
X-Forwarded-Encrypted: i=1; AJvYcCWOhD7kigYTBYUcN2OXHq+MR6riC25y8/hgt4PMsDskNJGj57gh+cSXkckLiKHRR0A9t/Yz9M1BIh50CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VNcoLUvzFR9AJyfeOcROERnDQ+BYF0OL+XI9FKypdxsmOVnY
	tmfhK8hgAkR4CMUclbG/RS//LdmIQAW99VNmqbcY8jTloFA2Hn/oGEsGGVsRGO1/gaM=
X-Gm-Gg: ASbGnculBoSYTM4uMzEB6jqs05BvaQy9yulmxT7nhW5d8s+BY5CiufWGTJgaEJsnb/r
	cXBsTxkseUKIq5q6xBXmcMAtooplqJbf+zuFrR2/V/6RQnfvn/fsm6Qx1mEfAghAyE8IJgxL7u3
	9TNNYUesasBFb0iGeppaQoZ7HoActHPy9IXCJrBEF8wPeXsa5xeyUi7dKWE2fL+FRIcASnBFpVo
	qJX+3AD4z+JalZ8Ah2f1Ie7EazIFw5aZ7vvere1FV5Jw2tIk4d0Sj2O5cTJZDpbeRDXRVJBJ83X
	jKJTrEIafOmp0/IDjOPNcmIHjCnj5tFCYwFgFr3VS7ZipEi7Ny0Ls3ouPflkO5O+udR3H8Alr4t
	fi3qyRwo2BMiOGMHdWFP1UugEZ6Qzbtg91NwF2/Dt83bH+I4FCp/OrNAgwak=
X-Google-Smtp-Source: AGHT+IFo3Ri8M1iGHczh+0kLy567c+XsPWYnjC+DbxsArk1jOqV22kRgMeMJMzsFpnNj7TQiFIR5Rg==
X-Received: by 2002:a05:6902:120e:b0:e96:c67d:c61c with SMTP id 3f1490d57ef6-e96c67dcbafmr6156328276.8.1756222883548;
        Tue, 26 Aug 2025 08:41:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d661d1basm1058955276.13.2025.08.26.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 24/54] fs: use inode_tryget in find_inode*
Date: Tue, 26 Aug 2025 11:39:24 -0400
Message-ID: <ea152e1b05ea305c0bb8fcd066a0e1e57e680de4.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we never drop the i_count to 0 for valid objects, rework the
logic in the find_inode* helpers to use inode_tryget() to see if they
have a live inode.  If this fails we can wait for the inode to be freed
as we know it's currently being evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 66402786cf8f..4ed2e8ff5334 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1093,6 +1093,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
+
 /*
  * Called with the inode lock held.
  */
@@ -1116,16 +1117,15 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1158,16 +1158,15 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-- 
2.49.0


