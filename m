Return-Path: <linux-btrfs+bounces-18779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB781C3D04D
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3903BA154
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ECC3502A7;
	Thu,  6 Nov 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXEtAkGs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69734FF6D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452079; cv=none; b=cXge1QbDeNnRplcsjUwRpvsf2fQE/HjxDr/dI8gAOy3ih3D1JpNFMrA0ku682DG3bVvkiLSI2OIgl4wwjGIcRFG54crCIM1cEm1JohVOWAMNMuGLa5a8nUeuiQ/phPEpKfwZ3iKYdFFgvpgyw6f/sx2EtlEhu1M4uQtEw2iFBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452079; c=relaxed/simple;
	bh=ecKx94Uloyw5Ypg7LHJi/wxlymzsTKHjuBzKSBg9xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fak7ZKxyR3LocgvTU8wcYqueTsIfel0tnnZqfdM7zVEi6dVlAc/dubslZMcsbf2TsmMllN/kLc2kHQ1KZX/iUoNBKH/G9YnGdgb7FLYVFkrmvbwkDktqd9KKucGBung6XqOcdnPpZFSqlHyGMauoxp+7TCd4uWfLAmP975zUlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXEtAkGs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7260435287so160882166b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452075; x=1763056875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=cXEtAkGsAMSpPV0eqxFPKAklkaT1xQOUfrnbecZluVxpVDLgHWVdA1yDX3GNSP6TyG
         /wU8aLnLQFrxKZF0fucd+VCCFsgdxQSBjkAKdiHBwUDTUcDg/YDWDrRO6740rEs7tBrl
         opNnuGdHVHdWvEIMR0P8kkzDU7gW2XebRcOgD3KN93ZphfxVFJIh2Kiox+/ZwRJriXiG
         IGNG8Druwc3ypXVQ8eOqbXxH8K1cE2U+NLHvnmC0jxtO65zIo8Zjd3sxobpnprzRU3ed
         pLZykLeM4eMzVqZBYVoX0Af6FTsb91Btk0dNfafWy17bJssZCom6V8M3XWMbdkfBuCP1
         uYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452075; x=1763056875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=Zew0FfeRDA5DDNt9iefyq5LCShnTl2X8HBlt4tHuP3hbnsx9aKvslPi8JnFy7KRAOY
         WOGPP/t+ZD0yQAtpq6JeiIB4khzI74H36LBalGFrd3EfwRffbwyuyKkumJAEX+g6FM7O
         u7uKzrY5gXku+sCt9QSvGovAq4cnu/ubaNJi7HbSeSZfQJEqG2mrO+LddFPkXza7JNeB
         ukyMXMEhiGrJbULMc9PSI4NqSe6lT/nOidtEDItkXqDR+hu/jiEkS50YRuG+x5ZXVHiu
         zKjdc5BGNeyrs/lrTlkPUJ/5NDC3BGqkrLyTH8JzK2JrcrQ9FJwZL3xKo7BJA8sJpSoL
         Vb5w==
X-Forwarded-Encrypted: i=1; AJvYcCWWXklMRItHAMdNwFYWEp66ikXMQEeZK5O3QwyW+mD53s0OV9XXAk/tmH6Kf024Mlh7QWLWReORENNwWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwtM9/pfKy7dXgzlMO4PrK6loW4Qm/lTsPFsNwPuh72kCp2c4
	Bg2Z4uBzdzz5HuO14S+5QYiAX7NUpHEv48zIBELHBU1AyFohpc7uE0CX
X-Gm-Gg: ASbGncusyF+IV3ZTZjzHPFfjomFIMX5v2SiVcjxKWB1ku3KnDwYPgwMIu8hLpq5bm9X
	8ukkmc4E65yudBoewQhgKU2wTeprRVrozqya3sil4WpjyMpWZVCM5UlvL2mpVK42uXSDo68bjSB
	P8zyGnZd1YlmOmhZL90SXWf+vfP8L8JfkSMa2EMjhylZZhXdbzT2fXzKJB33ICTJLPKeVAf6XHb
	VdjEAVWfzfEZnx2LWAh4t9EKaBPfoYJASe7J/2LtYtrHQZY9XzvTCMGLYrgaozAhxdZ03z+6Iid
	8456gBeXk/QiXAi7ZTZasjbXSQ7jrtQ5uihB2kTvI5OUOjzoPSrYRHEvjg+V2KszV0GZbTul1iP
	jxgt26cb2uPQYXwO/viBHWPPEyy7LCEOwHm7biwcghvmGS8+V+bKDFiXtDqWfoipD4HGgZubecS
	4LEHQZ6wBGGqPM39yWwg5+MpY3PVAf1ad90432mGhScWyMrNnW
X-Google-Smtp-Source: AGHT+IGe8qAFLbn4/vX5i0Ow1/iT5EGUdVcCOuyeIG6eX5kopi8FhtvrktlTKE/4N10OlP9KFFo2Ww==
X-Received: by 2002:a17:907:9627:b0:b72:56ad:c9c0 with SMTP id a640c23a62f3a-b72c078d329mr10605466b.17.1762452074675;
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/4] ext4: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:00 +0100
Message-ID: <20251106180103.923856-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c | 2 ++
 fs/ext4/namei.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eaf776cd4175..7d5369f66686 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5522,6 +5522,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
 		cache_no_acl(inode);
 
+	inode_enable_fast_may_exec(inode);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..870bee252e54 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3038,6 +3038,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	err = ext4_mark_inode_dirty(handle, dir);
 	if (err)
 		goto out_clear_inode;
+	inode_enable_fast_may_exec(inode);
 	d_instantiate_new(dentry, inode);
 	ext4_fc_track_create(handle, dentry);
 	if (IS_DIRSYNC(dir))
-- 
2.48.1


