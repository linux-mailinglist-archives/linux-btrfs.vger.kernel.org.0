Return-Path: <linux-btrfs+bounces-16396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F840B36E50
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3557A40FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D33680BA;
	Tue, 26 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PAIBrMSp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06390362999
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222893; cv=none; b=CUFCNTZcJca2wdH6TtZcjDKzacr6an6A+0X2vK0s1whVJqmD69QNK/iXjkHQlLTwzm7j84JKcFJHq2uaIXKRIcmHW+N9PtR/m44/uLgS3WG8GLj5kmJMs9nqQrTw66HzaP1MADzPcX0TXiJ9FnNbeueIPq5G0wBlxyEcQrzy9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222893; c=relaxed/simple;
	bh=KH914xoQJXrO8N3ZjmL923rQ+0fw5BtVRwkJcmLo93g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbgqaRWKnh1aTlCG/tgftUDHs2ATWDICtd53+2GknPO8Jpw5MdePWyt5Vv8l5sMjjerChUwsVmb9pN1JCX7IWOJoDAu1AsXvTHaOW6SNddT0zN5XuZrBVRAhy2Vfh2kUiM4flmcF95T6yczWQ7R2uHcNyV1405f4PsUBRyuZ3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PAIBrMSp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60504788so47004387b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222891; x=1756827691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=PAIBrMSpjeDzuYzNJC62+RMhL/Fl6xdLmvBwZflI1a2/qZ0H7VxahgeFe2J2cCNZRY
         B7WCA2M7b7ZxDaLu8Pv1/LjFNsZODqQwetoe6/v53qB85BF4QxQRvZt+epApAW5nmbox
         5K4Z5S9FFpR5PrM1gDfEFGHtONcq8m5NWSsyG+D3GR2Xr6y9n/29LBjdYnoYNqyDtZ6a
         aqoCK/SRshuysx1TLXRFN6UKV6pcIFgfMJamxsm/QRbcCddYijlsCeSpK+3iW5MlUTpL
         QIbe3e8BkATd0PTHj2lgJVw7U8vA7LWjvbcnN36GpewVJX01gNebt/D18gy6m+PdtcNT
         zUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222891; x=1756827691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5KAKsh2PfGXT4+TYPG/ltaJ7kkJlF6llKvHHQC7hMo=;
        b=j0W8RpmUozpFOMwxM8zoDkOEXtnP3eyTalh1Me5DQQPR0CHelcCq0DJ0hlOzul+4Nx
         6VYioGmtvE1q3H3v6ixig43BDjEPRwqSn30qgNCwU0iu+9vQNlbMRYfW3XHdFtcRaHnM
         bs+5xIQXS8jGqcnMoQ7XRNcJg0zeo0+b+5+CY10gFdrhaMfyrp/EQbi+83MHcIDJTmhg
         taWTMsI9+o6wumVApWYEc15Lus7miplGWx8KZ75J99U2E2tmLkoiIo7rVtxb8IonQoJF
         hQ5Mx8Mil/eEDKqRxrvu4hpQLGM5y6BhaLdS+fdcTgqHdo/iv+ErdV0xyX6Oa3j3yjKv
         /nkA==
X-Forwarded-Encrypted: i=1; AJvYcCWmBTl5jMwivfHvtMGiyoAOH0VkJLc8kz9y+SFACq/QA1DVylN8Fnfl78bSYMIvtofCY1fPRLjQ9k7cOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUj+T3UN2xJBVtt1usNxSe1JepladFxIBk283rixBujhgKLEMR
	Qo2wpyVw8LQ1YwVcylAm73J5jkBeZ/qwdH2V0F+Wpp02g9tsMOkOJAE9VgeoMvzHAmg=
X-Gm-Gg: ASbGncvCNSmvb6UMlFhwCjMT+J/O43zFWALGNDJg21fTu5fUQU6yoL2elGjmazpXIRH
	jPMq5gXp4LtqXoI3FhYwBV7+pkPe5eOWseSzhaA6uThMpnwdGouyS2TJxW1r3Yu/G/uH8GigeKm
	ZNVLomv1rA/4hQc7aVfZ66vQ03I4+Y/qPpngrj1njSHVKLlIXKpLSQkxTlCTdv8wanxZezNmN7J
	D88gA0aH3n5Ga4+1OtwRze6sCB3akKJOeSuBxUcJE5Hoesj1wJ3QN4GINz5x2oHZLkfNhgDLEJ9
	fLBQFdOpZvLeUDCj1zS4TxJ3uNJxSItGleZ11g9JuuQpNNzuFMorOFvUEspkBPLuatgNuk5dDWH
	vP27zTbffhC0MVg4wLBmD8CYBc1y3FbkpTiEGruvLsumo2Vqe0iVyyRcpCyhv7zDasMwvfw==
X-Google-Smtp-Source: AGHT+IFKqwEmHNx5eQFlQTUVO696PTRIuWbfxVqgnshRh3PzZ7/9O1IwzGnfu42E66nP2s6IML84qQ==
X-Received: by 2002:a05:690c:620d:b0:721:369e:44e4 with SMTP id 00721157ae682-721369e668dmr18015457b3.45.1756222890893;
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ffce104d1sm21641597b3.28.2025.08.26.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 29/54] fs: use inode_tryget in evict_inodes
Date: Tue, 26 Aug 2025 11:39:29 -0400
Message-ID: <a9182c9716b474752c0110af726b95125a7007db.1756222465.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE|I_FREEING we can simply use
inode_tryget() to determine if we have a live inode that can be evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2ceceb30be4d..eb74f7b5e967 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -967,12 +967,16 @@ void evict_inodes(struct super_block *sb)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		__iget(inode);
 		inode_lru_list_del(inode);
 		list_add(&inode->i_lru, &dispose);
 		spin_unlock(&inode->i_lock);
-- 
2.49.0


