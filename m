Return-Path: <linux-btrfs+bounces-19092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E62C6A761
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 14E792BDF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F736996F;
	Tue, 18 Nov 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RHKdyzuQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE759369963
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481583; cv=none; b=cbJL9dS+he+1GUBCogBMaTiW+pU3l2ClSZrrm+ZlRXBpv/+A8veqom+iHuOuPU0Gk88ySEVl+vjYm3mK/c6z/QaiaJqM/22YwBoHyFksSBU7ZMupqWkhvnTxEwkBavBu2c7n4VISBO4hua2HydPGqHydMv8c5TXfgAqAOqCFaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481583; c=relaxed/simple;
	bh=f9JTSMlemnA1oe6SdTjcXQUOVJB4bCrJuoKjAii1hoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnItxHHhu6rcKhl3M8baZbve0oziHF9iwLE4i9a47EQFKoBaeEZ5UatYnfCXnDyiuR73ph1IbAOTr+ZtHWpBjfhL2g/oneSSL4291t9FAp2cczJx5vXqg/q50tCx4ZpF1/pE782AZvx5tkNy90zMsJ/gvadKuqQWT4ztG9Say18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RHKdyzuQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso26730851cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763481580; x=1764086380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtdO6dSUVT81b8FZtNT7lMnV+a5sHKG/pmvjzXizM1w=;
        b=RHKdyzuQAIjuSqg7JHu0P9MzbbCDPMBkvMf+CnQlZDTgmIllccq/JAi8nFdTz1q1ws
         /ZWBdJMPu56Kl6FU7OB73ljWt32+/DD7wx/TMbScFe+jzuzD6J01slL9c69EfJ1NxlPp
         yQ4hjd/dIXRTyUFn7wz/EMXIxt7u7QihOsrczN6y5D4SG6/QPgZ8qjkAP/ZY5Y+3B1a+
         ZLgfelY7Y9dTsaKY6Uw+u9+E7tU9vuS0ZHfo+jwlVLBv2L6h5RTd11ij4ZhLY1StFZpu
         otY7+xM9i+b8Gi6Y5gVMGhhuHB49WNkYkO7VNXR3ogFaUXESZ+TmCFjSgpojdtypRDSz
         p5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481580; x=1764086380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtdO6dSUVT81b8FZtNT7lMnV+a5sHKG/pmvjzXizM1w=;
        b=oT0SAB9OZT03kfAbbXGR1Veq2RMOynzYAqcgQQM/nPDeK77kzDVkb+bIgACTa/B4iG
         iR3oQoHM/A1sFRvopitu1B/P/XcZJeUX6JmjfJjkfQcmgy7/Y/zyUPIOXgIKCw5RelwK
         OW8cUZIr8xOuS6cSt3x5HbEK7VWFVQvDbqUP50Rj9tV3l2RZZ37VbDaxnkIqZ1il2FdG
         NRh6AvwNr7vRYnlnroJQkraeH7TINhLRkAlfUEWZrtPs6dH4kVwJA2ytDUyZNn2sBXWN
         /Z91Ag63tQKAxfWDycxBTOBygR6d36j/yOVhLekIKLFKuTnRAnVLmR6A2uGB4iEsHRGc
         lyEA==
X-Gm-Message-State: AOJu0YzzUAxlyjvJWgEgr0S2HEZxfwusD3Ua9HFZ/CoSTXNK3giudd7Z
	TgoBKyDIhDZtGNS84Y0kIjutoLMVfLq72Co7JYPs1n+ioGlrQ9B4Jp8xQvk0FahPK830ma6csb7
	t2+atzkAKXA==
X-Gm-Gg: ASbGncu8O8YWcHn4l+PL/WuK7Uw8qXDzTyU/epDxJuCgpHRTMoixWSR5lW0PDbfSK/F
	Bid486jQDGn10LxT+olZ1mCcOY4Ae+uu60Gyhr4wfC8bZfSHqRZau//2WaqnOgvX2feGB+SPZku
	hkNzQwR39VDElY19y1ZNyT5YZPN3blpluFkP9u2yOrxT979YmAAFfa0EG77SE29g+PLIJXFi0Xh
	oD0nEfSFibyHp2Zj/oxUYYE1T4uvzq7T0prefQaLQa5VLxiyHiV07qHudRSk2GcwvWx2/c96aNu
	jo7i/0c+rmUZt7tIG3+j1KS/D+scMjswvP1ATfV+ZH8bD0f6GgGKwZ/WlqD40F89lBbegKNRfG4
	euJ5b2cYgGPkRyI3/uNrzq0E/O0E/IB04ofW2mWa3suCFVRUxKoXlqaZGSCNau6uVzUtzP/rC4a
	YCA6NLfV4fy8oa
X-Google-Smtp-Source: AGHT+IHYtoWRISJnF/VWONHxeoZZXUo+7q7EqvFs6Sw739KZ3AWimfm945VNOiXnf1i2piLToSRVjQ==
X-Received: by 2002:a05:622a:1104:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4edf204846emr201824991cf.14.1763481580320;
        Tue, 18 Nov 2025 07:59:40 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2ed2bc066sm514323785a.33.2025.11.18.07.59.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:59:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: remove useless smp_mb in start_transaction
Date: Tue, 18 Nov 2025 10:59:29 -0500
Message-ID: <a13853efeaf263d266d7af885640f7d80b63aa25.1763481355.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763481355.git.josef@toxicpanda.com>
References: <cover.1763481355.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're using READ_ONCE on trans->state we don't need this
smp_mb(), which actually was never correct in the first place.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 20bacee478d1..380445ab8ac2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -727,7 +727,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	INIT_LIST_HEAD(&h->new_bgs);
 	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
 
-	smp_mb();
 	if (READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START &&
 	    may_wait_transaction(fs_info, type)) {
 		current->journal_info = h;
-- 
2.51.1


