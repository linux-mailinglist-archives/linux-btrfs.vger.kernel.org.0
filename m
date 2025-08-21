Return-Path: <linux-btrfs+bounces-16229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72179B30695
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08E6AE6F36
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894738F1B5;
	Thu, 21 Aug 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dCv/3NfJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6238E740
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807660; cv=none; b=LJkv7X+y5P98BEvl4LcqwY3iLjdulu2m0uaIELkfvII1H9NKBRSUH2H3j1FKpIpShXX/uXpuUnwzyf5TYzfV26uh9HpNvv7GOgHKkCyUdAPVSNfCo+F4Q/vGv/NmCOax2KUQuGujHYQOm9NfqVxb1A2EjlZ3aJgJeUHhaSGOSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807660; c=relaxed/simple;
	bh=HO3qn6E2mu4iKLp4ae70vUhOoqfZurpCVV09CRALkRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq61hKDoWdwv/4vPHIkzPNjMVdka5lBCVaVHkoDHVzSa0W4IctgY9BWew5xA/Twmg6scpQKSZdtJKgjMlNrpCwWepVXziZJG2U6vxGoZF2P8pibh9arAu5Uep2JXh3xNPJNgE4Fi8agwIFg6i6FvDxt4ViDEvqsgt9Lf3NLNeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dCv/3NfJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71e6eb6494eso13046677b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807658; x=1756412458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=dCv/3NfJMgy1NTV8aXZrLV/VPd0uX758F5uGHu9mHnNHwSlwt/MIuKV2zIZR+3f44p
         CgRLBav/0nvbZL/DjqQYgNjgx9bR5rpCCwso3sA7wRUgN/MLnQvhynz9I2vfkwqBKH4E
         k8aRe0hfz3ZVFlgs6QTvihs2AHjV2m0Kvl+mgoHxUo2wOM/o40ailVZ8olI2KZaUe1l5
         jI0Eze4T00ZTynCE0WFtOnu+XPRzUVtIsH9HGF5/OghSBpQU/VVcd48gG4vRDoILinN6
         5SXFamskA3rOryXuW1EYRvAlritNNFHbX1mCVu5yoHgeaQmSXsJ4FQw6zQQDlnB+tN9q
         MZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807658; x=1756412458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=llIgBw+cqzPewCUXjKD9JJBFmSLrxT4HNeSxO7oVkPbN2+RrD39NMaLwELr8UwnjBL
         HCoYT96tfANs48jekfcEShH9bN7bxPTrvQloCcO5zCMSrWfEQ7EWpDzXL3cwJQIeItA7
         Cf3KtzcAk1UapcMuaxJYrIMJo8rLDtJLPuoFwRDOUtKbMj34OGdXmw5tWmPTY10Tfu4w
         fu/XS+oIyuBtBTGnXBqbI2wGc4+mo4fr85Lwt9hX4qxaMXoXgiLdkaBP3zAbrs7VkVik
         OEjeMqcevLQbU5pLdP102a/Q3Mpvna5ekzIrd9Fx7uplqrFkZhuWIcu3R5V27LaWnT+L
         Tk3g==
X-Forwarded-Encrypted: i=1; AJvYcCWGzBf+Ptj+PzABMgMrwwiCGTmQjRyz7AFG4jF5en1mmJD38qvjUJTbY0dibaNfsmKHNhaw3RntVdxvrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxh4kO90lqoS4MPaUgRCB5DoK+fINx6QrgDAobCjy4+6vaEdH1
	i21bBh8Jc6BXdSwWFvFuR8c03Ck/+JlctGRa8HhMfFbkWRcL9qYU5+s/gbead/+LEfg=
X-Gm-Gg: ASbGnctBB6pfegunbhZQzYnRDBOvhYO1PZ6LYb6f4nxFkfkE3LJ/AZD5bkT8sG/uS6G
	KGAAqvAg11i4VkUqI+yrrLdVg+5Q1IDGjsSBkVi6w3yvuF+Nr6H8FjnX/UHOH+4cmJk576Q1wyB
	9e9B4rAnS3GwaQZvRGgs/jZjX2O/FTNpzPe7IHjeXfYrqASirIsmbQ1gF5p5A8/agtqX/7+XEmk
	+JzVNLZbh5OxFNkY3MkOb2WsWG8WJU6yaQZJI+y+OuavtnwxpyKe7TZhcFZ2KqnZA43ba9tYefv
	oRg6o+i6TQcQbDesUPtJRJgVTWlSqsfoJzEbC3TKsDLDeln5HdYnVjnSg963UMzZWL+2LwLZckA
	nMC0L3AQUO2BbUZOW7nAWqnrb13pv9lWgYZlejyzj2qMZr4pkCe5HtCCxQSHbI1KrXNNsDA==
X-Google-Smtp-Source: AGHT+IEIFJCVTu1EDZBPKF7Wn7HgQkKCR2Ee9oTaJqcUfdrFVpYc/qrWl5B/CxZoKQkUQjNMeDd4HA==
X-Received: by 2002:a05:690c:b1e:b0:71c:8de:8846 with SMTP id 00721157ae682-71fdc2a890dmr6082907b3.6.1755807657866;
        Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deeb6easm46112717b3.33.2025.08.21.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 28/50] fs: change evict_dentries_for_decrypted_inodes to use refcount
Date: Thu, 21 Aug 2025 16:18:39 -0400
Message-ID: <a1eaf8cd138a75f087654700e9295a399403ead8.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
make sure we have a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..969db498149a 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -956,13 +956,16 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
+
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&mk->mk_decrypted_inodes_lock);
 
 		shrink_dcache_inode(inode);
-- 
2.49.0


