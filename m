Return-Path: <linux-btrfs+bounces-19224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F84C748F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A1624EAB8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE9346E7C;
	Thu, 20 Nov 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlJ/WcMp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D782773CC
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648412; cv=none; b=PxovEfVeb1nuaRUwKtlG+nJQtovMoZ975qqyugm6Y64eMtq1/BN3qFoHsCozD7RrPyUIcOvmT9qjC6+t0mRVR6bG04rMFvX3RNvfyey4iK5S1uc/O26CpUAQb0QcHcAmTn6RsDL+GY4qn8s8Y1BnmxknKgJG9hUWFBiEwv6aGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648412; c=relaxed/simple;
	bh=NkzpNVgxMAVPyseiMi6Phfrz4r3Eseu0EHiseaXATM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncMmiCq0W8r4q2O3m2jwc04NwfhWwhUjA3QFOHsNN0//ewvl/aMtz4Qxw6hp5XRWiLObqVeec7Dx2UZBaXlvlsyeAzdH05fbHGeqLgC4TKh7FsK0K2DFWX9ccDSFL3gDMfnQ1m2jm1zftGO6TO2Kd+SX9aPjdCLKxxK1sayF32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlJ/WcMp; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so103116a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648411; x=1764253211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dq8fJAxy3nOvPaNDWdvqdt4+s+tq0xKi9xtqeJDe10=;
        b=SlJ/WcMp3zMN/x7S7nwJmH7nJW9LqG/fQCadm5uU26zL57kZvAVFYDLb6k/aZSh59G
         qIWBKDcNhdoOE8nVAPYtWoah5IjbwmMPk9liLV9R3Nvn/WeWrXu8YrKVMrrxooW+DdmC
         o1abIeQ2WTX3oYxbnFCFCTL4qODP6Gbwv6CHlzXGnQuy0wMIB11RQohGKYiuDDAqQedZ
         GFal1D6miC5Oo33fVR//OwcdwN+r6gQzzo2uNy6iCLVjICHpaF+ftoGii3Ps76fbc+RN
         cTXmKvaQhxHGwwlMD4MwXqbg3VuwUunfa1q2gT0gGars1WFp14DgtJozAlEH3bYNwav3
         pqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648411; x=1764253211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dq8fJAxy3nOvPaNDWdvqdt4+s+tq0xKi9xtqeJDe10=;
        b=Yefo4TIEgmvzqLoFKi5HlIoNmIEn9PqkAgQyzQLrNT0n8XiK29ety4FfF90fKFaP7h
         4s0IYsJ+4mi3sejH0TAdStvpYDIEKGiWQzCSRhIoLRorHX4cuBTi0tjhXoyjVK2FyMwa
         Lxh9e4UGDiovWFmEfE0J/0qRGAwXdWLfVPomS4sQNNfiv/PA5pr5kxIWkMIa58IKDrZL
         v8aiOh601BPV3c8yN6v7aZ4rR6DXi+1TlQBg3ekHXD6ToLWkvcmt114hMpmdzFJIKUJJ
         8HSbrlBzWYmppjyYTxYHfnCy71Kvk5FVxx91/n+EGGJktU0KhADcQfbZ7NOgp1xUJ+DK
         wUWg==
X-Gm-Message-State: AOJu0Yz1GFqGSH8xT92dD50Seg5c2n3HsE6Y5VfqHW2Ot2lourFfoRYA
	PRtF1u+9AdDI8yZ0zNxHReV0SwJY9rK/LPfo9u7Bc4WWLOe2m3mfnF4WX1zRy/OXuU4=
X-Gm-Gg: ASbGncv3l73N1JYia8+lbJ5IWRIaO4wVpFol11MC8ZOXGbcOxv8CE9n+dpvGAt+LhUZ
	4+OlEQFH4vH/4vQU1wwrh95OIkebu1ObIpLHXllmB1+o1AktLr9rQ64P5O9zdjjz4ORi6QL44YU
	cbQoyJJ0eI8yCUr7lVjAraKpBOrkxCz7ZxbG0Bosyi9Izg0c4T4YG2QfdqWIgx9P1KYuxyf3cIM
	pfS3DIhihY0wulSiaONRgFcfz2P2Rik9lltffTmxQhCm6pAyWGS32nCOzz8zNCPmKA3/909BLZI
	GgJ8CH+XCkUrMwqCurE4p29W1bTXqI7bXUk9JXym8dUbtvyIyEfaCKIj4QzHS/6OMpDUZmEfTvH
	gqJmF+CFb3u85XQWmAWp0tQlkBul3czSbyc3kHkJz5SbQ8dskB/s5Sof9pucBoMYNNY15FlthxG
	35rhuSReJctlsBHKmCoOSF
X-Google-Smtp-Source: AGHT+IHwW0jd1h1I9w1DUestjNxXHAjsEwDoIEF4erektxXKPi0DXzJwXT3PsffJtC9pR3J2xgHiPQ==
X-Received: by 2002:a05:6a21:6da7:b0:35f:4e9d:d263 with SMTP id adf61e73a8af0-36140b21bc9mr1462378637.1.1763648410720;
        Thu, 20 Nov 2025 06:20:10 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4ca0casm2781600a12.10.2025.11.20.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:20:10 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/2] btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
Date: Thu, 20 Nov 2025 22:19:13 +0800
Message-ID: <20251120141948.5323-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120141948.5323-1-sunk67188@gmail.com>
References: <20251120141948.5323-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace integer literals 0/1 with true/false when calling
btrfs_inc_ref() and btrfs_dec_ref() to make the code self-documenting
and avoid mixing bool/integer types.

No functional change intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c       | 20 ++++++++++----------
 fs/btrfs/extent-tree.c |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3c4aea71bbbf..1b15cef86cbc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -292,11 +292,11 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	}
 
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
-		ret = btrfs_inc_ref(trans, root, cow, 1);
+		ret = btrfs_inc_ref(trans, root, cow, true);
 		if (unlikely(ret))
 			btrfs_abort_transaction(trans, ret);
 	} else {
-		ret = btrfs_inc_ref(trans, root, cow, 0);
+		ret = btrfs_inc_ref(trans, root, cow, false);
 		if (unlikely(ret))
 			btrfs_abort_transaction(trans, ret);
 	}
@@ -420,15 +420,15 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		if ((owner == btrfs_root_id(root) ||
 		     btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) &&
 		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
-			ret = btrfs_inc_ref(trans, root, buf, 1);
+			ret = btrfs_inc_ref(trans, root, buf, true);
 			if (ret)
 				return ret;
 
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
-				ret = btrfs_dec_ref(trans, root, buf, 0);
+				ret = btrfs_dec_ref(trans, root, buf, false);
 				if (ret)
 					return ret;
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 				if (ret)
 					return ret;
 			}
@@ -439,21 +439,21 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		} else {
 
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 			else
-				ret = btrfs_inc_ref(trans, root, cow, 0);
+				ret = btrfs_inc_ref(trans, root, cow, false);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 			else
-				ret = btrfs_inc_ref(trans, root, cow, 0);
+				ret = btrfs_inc_ref(trans, root, cow, false);
 			if (ret)
 				return ret;
-			ret = btrfs_dec_ref(trans, root, buf, 1);
+			ret = btrfs_dec_ref(trans, root, buf, true);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b22b0aaa99e4..527310f3aeb3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5469,12 +5469,12 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
 		ASSERT(path->locks[level]);
-		ret = btrfs_inc_ref(trans, root, eb, 1);
+		ret = btrfs_inc_ref(trans, root, eb, true);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
-		ret = btrfs_dec_ref(trans, root, eb, 0);
+		ret = btrfs_dec_ref(trans, root, eb, false);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
@@ -5876,13 +5876,13 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
 			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-				ret = btrfs_dec_ref(trans, root, eb, 1);
+				ret = btrfs_dec_ref(trans, root, eb, true);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
 					return ret;
 				}
 			} else {
-				ret = btrfs_dec_ref(trans, root, eb, 0);
+				ret = btrfs_dec_ref(trans, root, eb, false);
 				if (unlikely(ret)) {
 					btrfs_abort_transaction(trans, ret);
 					return ret;
-- 
2.51.2


