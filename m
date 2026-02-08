Return-Path: <linux-btrfs+bounces-21470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bh6DxYDiGm8hAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21470-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:29:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F85107BFC
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A49A300D153
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011AF2BEFEB;
	Sun,  8 Feb 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSPXumUw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4811DFFD
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521359; cv=none; b=cuXPXiUombTSiAwTFak9RaamJIsFasCJOl4s8a/rA7pFdsVvcFOAvSe7J5Rb9jwvvgMpDYpFKPVPYjFT93tGCCWd9vqDTBlD+hGGGXzl2RI6JJuh+eUYs2pa36U1BmC2YCCNQyvEwpGgv+pNe2K/mmqiqpnF3RCzBpc+0w9o1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521359; c=relaxed/simple;
	bh=zhQwleEM6KKA0BN22ka1N2sSqC/7IyHDXpzd6poHBhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcaNaL6AyGktX0uT1NjNzjCz1D7o+rzR1Ec5Zg0JfwrTo4amP6T6+okLxLUwhDZUmziM3Dpmpec3fPBvOH3dcXfKk7wPOWKOpXYoEk6nnJJEkllDFbzulGEBWxz5gdAmBnwHS0eDMywSMGURkDQ/2fgzW7MCW1KVtbnnD12L0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSPXumUw; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7951e7122adso2467567b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 19:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770521358; x=1771126158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V66C2Sna6zqrBqtFFT2YPLCEoDNJBXBRLbmgSSGTxg0=;
        b=iSPXumUwAgLQ1Guz+YTLVs3HldVhWSSU2OixwkpW6+Re9219AdDuFZF482DXDexoRE
         JnBGUyxZCX4aHaUQVfiV7lt+bLrCvZCIVncYT03LgOKXU+gAENx7cnYcBHK8+Vhyr6i3
         KpjzkgnvwNYQD8crab51p6QYQov67bty/on/wi4Pr08boE8S111fjTRv+jagARpr8UvT
         mpA2tVK+eK7QkseFx4At0pH5/Co1TXpghxZjJ5VworQweUm/FtM0qLYiUjPDBqKb07kX
         diaM7vKTMpaozHdoEvp5IWGKAyXae2LRECwKlCiibWSYUSzB+SYUDISYsqDmJkStJhxZ
         /jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770521358; x=1771126158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V66C2Sna6zqrBqtFFT2YPLCEoDNJBXBRLbmgSSGTxg0=;
        b=gz7Dir0EijgrOLt+duTClZChm4v9jTvL+z/Avz6VpSKUpQxqnYKCNsGoJbspgJRVVc
         6O7q3mjXFQnlLv44YP3nCNK+oGwtxuSarR/RNm/kAC41mAmYoYQCEpM5+gLUyWWkEKkN
         hsdtA2Vf9FEAwkYJ43Lq9Dq6ST69UdyVDv0J9uIyddkgi8mGJVucZnBZM6FESMYaXxMN
         MW4mdHygQLPPFBOmgMxiZR81Jv/pE6lVKehM525bq9fp4NFUPDosfwwLRrVgb0fnxEv/
         3vtMvThqVZHsm9nZNjHdFLf7Z+7ZCSezZqu6J9sCWde1rdEBFZPbz+SebUiJSNsGlpVm
         CbDA==
X-Gm-Message-State: AOJu0Yz0cjiU7tBXIpnFGpdqrrYgkYmH7PTAlgtARekNgC8IXnnm+1CY
	+opTLvG9qKswb5mLb5MOkU3fsCHCZMwFy7beLbilMIAfAo7hp+03nDryPhU13YYJtk/i6Q==
X-Gm-Gg: AZuq6aKoK0hHFOZXzPAbOEsKwcwTHEMxxFf0tuPnlYj01Ah5Lx/6we6yOtX6IpPsaPD
	Wr2hWMxluRqbtkvT4L9kviP3zy3U6pz/ad7C/cS9LRZqxxjjU4yxScH/X6+/ZQ1Nzf8SLvjUzr4
	TKykqX0xYJYsMMbEzIjiOdEtURg085lTzDRiUjXLw9DlGsSZYJSLnKvgKxAP8KWTNBSxsjMQQ2c
	SUXS6B8ry7FIprEe8QlNtsHnGnPMRYA2+NBVqvAIuGD8iAj050BN2DQ4cFLFPTyOWPhsjrkX0J2
	SYw+7zlV2/lWlkgZimcdNT3fd6ahSN8i5AtEF/dmDBHjKcD6HcFQqPD6XzW3uRIjZPE9Zh593AI
	iaxsHgWnnSIvDHAh18JyhkKuF+2i1r2sslCXaFN/6htQHuZq42se0tZskhpTt+E1zJiWPdhEsSu
	8/QF4jtTvJE7aJaMVwsA==
X-Received: by 2002:a05:690c:10c:b0:794:ce39:c63a with SMTP id 00721157ae682-7952aa5547fmr57792137b3.2.1770521358040;
        Sat, 07 Feb 2026 19:29:18 -0800 (PST)
Received: from SaltyKitkat ([163.176.176.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1d8c66sm59956607b3.30.2026.02.07.19.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 19:29:17 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/3] btrfs: qgroup: drop pointless return_any fallback when reading qgroup config
Date: Sun,  8 Feb 2026 11:19:37 +0800
Message-ID: <20260208032705.27040-5-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208032705.27040-3-sunk67188@gmail.com>
References: <20260208032705.27040-3-sunk67188@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21470-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7F85107BFC
X-Rspamd-Action: no action

btrfs_read_qgroup_config() initializes iteration over the quota root by
searching for the first item using a zeroed key (0, 0, 0).

The search is done with find_higher=1, meaning it looks for the first key
strictly greater than (0, 0, 0). However, the call also sets return_any=1,
which allows falling back to a lower key if no higher one is found.

Since (0, 0, 0) is the absolute minimum in the btrfs key space, there can
be no valid lower key. The return_any fallback is therefore impossible to
trigger and misleading in this context.

Set return_any to 0 to correctly express the intent: find the first item
greater than (0, 0, 0), or return not found if the quota root is empty.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 206587820fec..b8040740f7ca 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -415,7 +415,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
-	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 1);
+	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 0);
 	if (ret)
 		goto out;
 
-- 
2.52.0


