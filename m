Return-Path: <linux-btrfs+bounces-10858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD0A07B99
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A9B169FBE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F92236E3;
	Thu,  9 Jan 2025 15:15:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA022259F;
	Thu,  9 Jan 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435730; cv=none; b=pxKVlUski+uo+xeN+Ii2oPB94LWUs8vLdjUnC4YYEDrhbRZ3ek9DCcfZY7lvuo0NOYJsMOYY02elbkBk8PBhJGfQE0UqXPlQ9KIiAbD02EYRsv69B+dZFG7Sc98Sq4EPTBg71OoCmLr424Ca1wAHchnc4qCy09J4y3tOwjm827s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435730; c=relaxed/simple;
	bh=kxPheXsGcgr7C7bmW2sFDIN+8yZhU6P18+xwCuVRn3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6SLaTfvSZiOFbR95tnuH6sN6vwAQcFBoRFGDgARBooLrJejeQarPqjJlEDdden8FCg2wXA02wJb83H35yFvZbFpJWD/TCXYG+kkmMETSkCpm8n+bbaEWPBvmSn6NoAas3DqMrFBIGQccDNHXjne7sJMT9lbfifw6OVAc2UUPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso211592866b.3;
        Thu, 09 Jan 2025 07:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435727; x=1737040527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4qxRvmfu7+JXk512bdqWeZXj/ZLfnbrQ2mO7uJqnjk=;
        b=Qr7uDvfgSwFI+HcqhZRBzzrNzx0VbK4Xc0mr+Gk+w78qiERWxJj39QfYdPH9O/62N9
         4wHN+QTCeQAIoFu5738Un3ai8SNUIcRhbSrO1l8KtfNTjr5N6GbsF2zrYXMQoqqFXZ1W
         3LJKOaIcaS1zWvRnLWe+cPw9kWi8OK+n9WB7xlSNaoy13nA8Gp0hRNUTqm5Ix2IFJfzf
         +jIl90EHl510D5GU8Dle7FzZIvSVVY/+GO9HoTuPNICPZyatK7rPfBCMZ82uawJFfnpl
         306CzT1FxIx1Nx+UT90STAmKBPiGW9q5KZYCsWguuC4yfU94bFMca3W7MPOGzjDGfZH7
         V+bw==
X-Forwarded-Encrypted: i=1; AJvYcCX5kmg9HZgT+5YKpcbbj5RgaI56Anm29IhoOP2FaBj0o8IGkg8cRdkw6ldCxzi//dyvzx10ux1zuy/pfw==@vger.kernel.org, AJvYcCXGIfhPcV5tZl4vWvTkyo2n77Xp/oV6fzCapLILWoVqE7lcQvTo9gRA8/hQ0pCIiUJTwzRQ2QDuHu0MuDql@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TIBCamcXe1Cunv+UAFU2a/64xf3x9X8s2M5KJ84nYDoyE7LR
	LqrJxqx0wQGZJ3u3gmjJMaZNNU0gjFbOI7zKDeTNuvvwhnuB9Rr8
X-Gm-Gg: ASbGnctr7fyqq8GB9Teib4ikq3rQ8pqvq5K5fmPY/eHz/LWyDgKKer8BjSsv3W+nzkS
	t6UchuCWsnCy93+UuP+c+anj/1m43CglGsB3DYAXJDrEq7xV93k84vXUd3Q5/eo37pEHxeqW07/
	GSAlRsJixxjn6Aw4f4JgJQg/7MVQcsRtRRBVob8NR8ZK2V9lQTzNN9xCd1U/kxzoeLxddK2AWy7
	necF+thT07sapdHGSDF9MPk/PGZnb8CildVlQdo9h/nNHt4WxxVRxIO+wzSbR3NoWWJs3Fr+tGn
	S4VSNqpp+hV/Ld+mLqtwHbxO8QWsEEtyleZM
X-Google-Smtp-Source: AGHT+IHDDZceAa1sKL8dn6/9yMfzEjIDZXcupVZ2tXxTfyaRTVq5pZ7nCEdRdnyajz9BCzCdqPSSFQ==
X-Received: by 2002:a17:907:6090:b0:aab:d4f0:c598 with SMTP id a640c23a62f3a-ab2ab7415b9mr632374966b.27.1736435727071;
        Thu, 09 Jan 2025 07:15:27 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:26 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:10 +0100
Subject: [PATCH v3 09/14] btrfs: selftests: check for correct return value
 of failed lookup
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-9-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jth@kernel.org;
 h=from:subject:message-id; bh=Hai+FH+wlQA9jUF34rKWHq12Hes2Et4vpJtRh4PDbc4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2A5tI5/wvrLHYyPik+ZPb2ubcgS0zynvP70p4+bJ
 VcuzWSU7yhlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJrE9lZGgIEfq1WYTJWC0r
 V70izD78wVWzs6/fi360F33JZh2eqMnwT9mhU0rxe2z98zIN1z/PmxzLJeqilKW7m2zms/4SbL7
 JBQA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit 5e72aabc1fff ("btrfs: return ENODATA in case RST lookup fails")
changed btrfs_get_raid_extent_offset()'s return value to ENODATA in case
the RAID stripe-tree lookup failed.

Adjust the test cases which check for absence of a given range to check
for ENODATA as return value in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index f060c04c7f76357e6d2c6ba78a8ba981e35645bd..19f6147a38a54f6fe581264a971542840bc61180 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -125,7 +125,7 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 	}
 
 	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
-	if (!ret) {
+	if (ret != -ENODATA) {
 		ret = -EINVAL;
 		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
 			 logical, logical + SZ_32K);

-- 
2.43.0


