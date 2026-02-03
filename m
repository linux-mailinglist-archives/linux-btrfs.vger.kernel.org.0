Return-Path: <linux-btrfs+bounces-21322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K03DsgvgmlFQAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21322-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:26:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD6DCC25
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9883A30B384E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800A2F1FE7;
	Tue,  3 Feb 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8gb2dqi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84B27AC45
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139458; cv=none; b=i3K1mUbI/vsmX3h9tK29lc7VuO1vZGx2bmP+ze8siZju852kDplXw5eDJ5KS+vJ5Ggd6HYOSFOxBrRfdmxKg6z+IwhcCvP8XC/ah86fOnFFGZZAN8eqqCnP8W8AdiS7PVqiruHDtXyMMVcXgyEPki1F1onsmZA+vbFJKsubCynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139458; c=relaxed/simple;
	bh=xdsqt4LY9mDvAbthOsoy33+UTUCrQhFjTOEC8AFUsdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrLzmKvCKerPZgKYm5IOe9I6APEaPFF0+fvKm97YL43a8huztku7oKlMsutBCSpxU6M67HlS4ptN6DPGX+rSaOX3783Tqeaj1S6GWwLIE1+KbkNXRtcS62YXYY5oiWxrEGrUqI3BLC2BdLLqqToiac/rrbeeOymfpkYGlsjBtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8gb2dqi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so3121927b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139457; x=1770744257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5REtf72BQKSplIumKJMbUKv1WSANnD7w4fiW0DxC7NY=;
        b=A8gb2dqicZnnILeyd0IvC38Utn1R2j16Szx+WGRlLfSymOXfVGmd+sAnr3a3j9gX4V
         sssoQCPg5w9KsOxAJqz4YQvNgD2T9NyVK61FnaiOu08Pfk6/V7x59TyKVJUHoemXv4WH
         Mqk5wFd6eWMkgnAFZLTQNWTpxTQhPgHAqW8ykpzx4uvurfq45wfvezTuntM0Ym+fcs2r
         kAKFP7sZm3EjWpB8ZJ7vAFwmMnSjL3KM8gmyq1h62WjsoEFOZgPHqFIq2B4uVfugXtDw
         mVpuWZDQAsFAZYHPddE0wbB2G1Sa9T2pxdhfYvOz2lh2V7cBTIRrUc21ykZfFbu/mtUf
         2EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139457; x=1770744257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5REtf72BQKSplIumKJMbUKv1WSANnD7w4fiW0DxC7NY=;
        b=YLUKBmhBqJOW08LGmjiqv3zEQmNwji+HZDsM3y6bhQO0ySvJXvwCufh3QNh19Iuqiz
         VZ5bw5KalNs/chBvmXX5+7UWyv8i4nwRd23+5kUtPiw4i7MI0koeDVe+Wmv8qG8jInoM
         9ApWXjvfeDJDfteX/I1LOoEgCIZcTzkVtf7Vn2pL1PfaXgsNNNzDyR5LXL6fJLjnCHta
         bDjCDwviVMg5bv15RP7ClhL0pcltBE1mXw6nlijM/+2FqLM8mFetV9c9EyKhh3RJPbRf
         FuaKyhecfWBuoPd9+dVYLN8QFJqvNqHqp9JPMvt2CV8HK0ON0PbYlWv52K/gp4Nb30Ii
         LunQ==
X-Gm-Message-State: AOJu0YzCdkGSmzc+FAQPu3UEi5UT3OFTnkCWuYD0Sh4lemXgPURH4YS0
	Hy7mkHQIxoCT0KYggcu3PoD4mc483dRXuwkFSIgoEj+RBJ0c5jLzUBY02Mcrfw==
X-Gm-Gg: AZuq6aLZvJhbYIZStm4nNqrJYJrDvaeGPSwgBV3QNuhPfLoC2sjlRIIY+wLNaUVdskq
	bi0gbQgcya9x/hp4g24BvOvsYThmrN9EWy4VR+wTyRCpmXjQptTYq3hhbU7DKnCBMRtH3t0DCev
	pcJgmBSOjDvX040F+Pu+6woSVsvyeGCsG6Pk3TBrkzIm4ZxiGxUpeFNklZCzkPfn4RNFedeJfLY
	/73/Y1JTC3VdXZfqzXmnKR1AScSr6FRf2kBF1x6nIB55btM49cZub20jz0xHQIOuKJyhZW8F/iT
	sUVX1KOUPh4Op0MeULa0ZeXkEP2DERnetLepAenGTNjKhmtxNElpPtK6aK0I1V0PeKR/wTrlFkx
	Gx9Xb8PtKHSpER2jrdw1y/xdnrdkPQjsgZlItJXRLZO7uG5uVy0HwhxbShS1JlcgqH7zeZOz+rU
	yPJAmiaM11
X-Received: by 2002:a05:6a20:9d94:b0:351:db7:2328 with SMTP id adf61e73a8af0-39372090caamr144800637.16.1770139456692;
        Tue, 03 Feb 2026 09:24:16 -0800 (PST)
Received: from archlinux ([45.119.31.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f70fesm17099299a12.25.2026.02.03.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:24:16 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 0/2] btrfs: clean up two FIXMEs related to btrfs_search_slot output handling
Date: Tue,  3 Feb 2026 22:53:55 +0530
Message-ID: <20260203172357.65383-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21322-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 99BD6DCC25
X-Rspamd-Action: no action

Both patches fix cases where a search with offset (u64)-1 gets an
unexpected exact match. The first silently returned success, and the
second crashed the kernel. Both now both log an error and return -EUCLEAN.

Adarsh Das (2):
  btrfs: handle unexpected exact match in btrfs_set_inode_index_count()
  btrfs: replace BUG() with error handling in __btrfs_balance()

 fs/btrfs/inode.c   | 15 ++++++++++++---
 fs/btrfs/volumes.c | 10 ++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.53.0


