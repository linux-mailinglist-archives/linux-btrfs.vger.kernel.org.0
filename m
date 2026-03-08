Return-Path: <linux-btrfs+bounces-22277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI4NGgjirWks8wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22277-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Mar 2026 21:54:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7B23233B
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Mar 2026 21:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498D4302DB4F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE135293B;
	Sun,  8 Mar 2026 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgRdaOI8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D791A682D
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003241; cv=none; b=LTqmznFGSADncjsVARzI4MCi2wTVgGehpfmZoZdWaV0IXzIn2tq3MSwaF7hI0nyiik9ujhMpFr43J6uBA534iGDfqQSVn+zk7H/O3wuEDUTfn9pe5gzT6kOmIwmq2kOqpCEVelOENQF6XF7I6oL07AzLm5tCvU/8+0keGs7C+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003241; c=relaxed/simple;
	bh=PylX8IEChGBaGlHqXEbfqUg1n2BDvKGc7VXqNccsPWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CK6l5hOXXpDsphmGxXS/AZC2LhASjZoJnNoHc7rubC38sED1jLABHzdFsUp1wbPPzZtKRTwA1KGwkTKSoVRRfqc2B5X5bOW3oU70Jw0YHy9mvYPYvZi4nUo4+vegZXQx6wMXmLdjU3nbQ99ulo/ORuvIExwkKXDXsOguiE2Sjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgRdaOI8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9d08644so1130107b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773003239; x=1773608039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeShWZUkCPM3Ka2Jx58JiwWvMzj51hGgMlQCsJB6FhM=;
        b=GgRdaOI8PRudmy0iq8OE3OInK4/1aPxbmOSWN6tCCkgcmmwew9he1dGINYqJ53jGmE
         SLJ2FRd5nCEc09yS4Ci8DUKc8Wkyj7n9HkFMyMz94RbG+fL2aADBiYUqPw17Blfs1JQx
         4YOOD0raN/CeXHpTat73UnOF0Gt7pu6S9jxaG66pl0MelfI2J0/QzmUXLMXjPZ9sLWGj
         DPQyCFSkWHNStAuGxPuXBpnIHZKhVmjrpP1/95JaOjvceIzieDK3EQClYmihbbWZGUHf
         i1igUTpev7S7BzyJRMiV7LRXGhAkqtOEQ2+G+nv74/6DFZzaE+Ji1jEHa67PtPZ0G0tu
         a1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773003239; x=1773608039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeShWZUkCPM3Ka2Jx58JiwWvMzj51hGgMlQCsJB6FhM=;
        b=gOd/M6DrTgjI9U4rk3X5YuGot67M9uvnnhpV1d28xHZehXL18IsFumhoTT3NaiZ+50
         z0cHxov6pEIgDVNTCpWrpSksOppw3jQoNBMhP6qZfXoaG7+Wh0Q9ubov9yDAbFYo35Gl
         vnIY50LvIaTQf54mZjwWdU2jeakt/dhs1AwmGddJTETN2mZ3cP/vvqtB4b/l4Wcz+CXT
         iIfHMiTrZ+OsaKOTEtm/wc6T9Dw/We5UP3tOjsWsEXB+P02iu3p11Ga3j+LLc3gLZk0P
         hAlObDQ2s1AOVzk99mAo/HFTzfZvYfpuK53HcEb9JS5BLxqfqclo3CBBGqgH1q+fDxzA
         yCWg==
X-Gm-Message-State: AOJu0YxahX0fYj77/IJPhshanlP5opdHxDBzYAJjzXmHDOVdK3l070Qi
	fBYl4hatyriHJ5gB7cn/Q3YE3vF/OFWXYOvKmgzgzxFoD+oGOK0R7KKjVslXASFS
X-Gm-Gg: ATEYQzwY71UEMy6RkCtV+75D3PMpA3WoJZIhIxsiIMkvDwXAXRWfbXp5cVQrqSEO0CT
	z0uRkFaoN5jd8VN2marA3fcdmI+ZDWX693KCDziRTb8qs1VKToUheDb3KPXgCOVcGHaP5cGrH4w
	zduZBwq6g1IqeM1kHxjJLhqHESu1zwIC3C6P35H58oipAo1X5jA+FlMc5KAZIwlRcv/0Rft66K/
	q71kdmmPuYuXLN+O1FgskFOGDod/f00obogy0ZsfnKXQvoYJlNggAUB5zLBmhdK9LQi1YtbbJjl
	cVgVQbUtmOXQKyguUtnnxdwJBclpI2oGaWK7aC+UsTuDuOaaq5L7ajNLo3XXMDlR0Cis4IVnyGa
	YHETM2cLSSqs8B5DNO9lhhFw0KnC+KHKE3amBzHWcoWnSU5jYTvnQULPASbIhmzMn4CrZHgCrpO
	mizBCCiGdZ8He7okRFKG4CVNA6d28S17iXEVqf6EiGSEJC0zDXsn5pkw==
X-Received: by 2002:a05:6a00:2346:b0:823:8a5:297f with SMTP id d2e1a72fcca58-829a2de2ab2mr6966782b3a.16.1773003239273;
        Sun, 08 Mar 2026 13:53:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d3621sm8722968b3a.62.2026.03.08.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 13:53:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] btrfs: raid56: use kzalloc_flex for rbio
Date: Sun,  8 Mar 2026 13:53:40 -0700
Message-ID: <20260308205340.24208-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15B7B23233B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22277-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.959];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Simplifies allocation slightly. Now stripe_pages does not need to be
freed separately.

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/btrfs/raid56.c |  9 ++++-----
 fs/btrfs/raid56.h | 12 ++++++------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index baebd9f733e9..d74ae380265e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -151,7 +151,6 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
 	bitmap_free(rbio->stripe_uptodate_bitmap);
-	kfree(rbio->stripe_pages);
 	kfree(rbio->bio_paddrs);
 	kfree(rbio->stripe_paddrs);
 	kfree(rbio->finish_pointers);
@@ -1070,10 +1069,11 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	ASSERT(real_stripes >= 2);
 	ASSERT(real_stripes <= U8_MAX);
 
-	rbio = kzalloc_obj(*rbio, GFP_NOFS);
+	rbio = kzalloc_flex(*rbio, stripe_pages, num_pages, GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
-	rbio->stripe_pages = kzalloc_objs(struct page *, num_pages, GFP_NOFS);
+
+	rbio->nr_pages = num_pages;
 	rbio->bio_paddrs = kzalloc_objs(phys_addr_t,
 					num_sectors * sector_nsteps, GFP_NOFS);
 	rbio->stripe_paddrs = kzalloc_objs(phys_addr_t,
@@ -1083,7 +1083,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
-	if (!rbio->stripe_pages || !rbio->bio_paddrs || !rbio->stripe_paddrs ||
+	if (!rbio->bio_paddrs || !rbio->stripe_paddrs ||
 	    !rbio->finish_pointers || !rbio->error_bitmap || !rbio->stripe_uptodate_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
@@ -1102,7 +1102,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&rbio->hash_list);
 	btrfs_get_bioc(bioc);
 	rbio->bioc = bioc;
-	rbio->nr_pages = num_pages;
 	rbio->nr_sectors = num_sectors;
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 1f463ecf7e41..dbe6b7a2e194 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -194,12 +194,6 @@ struct btrfs_raid_bio {
 	 * allocated.
 	 */
 
-	/*
-	 * Pointers to pages that we allocated for reading/writing stripes
-	 * directly from the disk (including P/Q).
-	 */
-	struct page **stripe_pages;
-
 	/* Pointers to the sectors in the bio_list, for faster lookup */
 	phys_addr_t *bio_paddrs;
 
@@ -230,6 +224,12 @@ struct btrfs_raid_bio {
 	 * Should only cover data sectors (excluding P/Q sectors).
 	 */
 	unsigned long *csum_bitmap;
+
+	/*
+	 * Pointers to pages that we allocated for reading/writing stripes
+	 * directly from the disk (including P/Q).
+	 */
+	struct page *stripe_pages[] __counted_by(nr_pages);
 };
 
 /*
-- 
2.53.0


