Return-Path: <linux-btrfs+bounces-18423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF74C21CC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 19:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DCF408046
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4C36CA95;
	Thu, 30 Oct 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="SBl4cNzG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="tN9CbTRc";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="NF2HvmrE";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="ckhcImAC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC796EEBB;
	Thu, 30 Oct 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849574; cv=none; b=dS5RoaeAgS4tDhv+AWQtKXTUabqUM9falTPuO8Fl3zcK523a2IOle0pf5rrbNIIZFXa9CZQxagU/Ph2CKRcncdSEg0276uOI1/Vb+swMjDdji2IDSPcbiXVNz1JOcaEw1eyczaqrt++XhAPfTGwxNbuiFW7zjoeJ2rvOzw38h30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849574; c=relaxed/simple;
	bh=TekjPNxEvxifqfA9tU1bs6msDNIILyeqiQoQHC1s9E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0hTJn7ZZUOvG7tVEwTkyCa4d7jbDQY/2dyyVwwKqELHFSIlg3AsJFrRAyLLk8FPJFsf8M/qUabLjPSbrCPYiPux5BZcGSs0bE6o26byLmT7Sp+S56V4EUgOUKTy4sN5UEsLKBliYdXeJAr+W3KeJm0kH4IB6DEVrxdjrWtt2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=SBl4cNzG; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=tN9CbTRc; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=NF2HvmrE; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=ckhcImAC; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IwRegeCdAxRUZSDwQb6vAVMbdRio5Zuxgn8WY4q5vV0=; t=1761849570; x=1762022370;
	 b=SBl4cNzGDEK1ccoDN4lR1idJCz8gNBwyzX+91n4U68EgdvNWJ5rprNzM8Aa/DhPtzHNTT3WFw0
	DLzIuQHO4uLKkCBAS9V2oqinPlXqV9f10NHIWpaoc78yMtBG9KlrQYyIhC+920QzoqcYJVGJFJgXO
	TaAi7G14oGfmQOrUhRwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=IwRegeCdAxRUZSDwQb6vAVMbdRio5Zuxgn8WY4q5vV0=;
	t=1761849570; x=1762022370; b=tN9CbTRcaejLKjdUOUlaWDRCY0nYma6l4NmJ6AKqqNbMc9/
	i6a5wq6UW/R4DkTPnwmSEq30TGWqso6WvYHuPgX/Mo+DMTsqwvxbrxUEKe/Besq0GvZ6lWCjFz2jR
	R/24sqrcYjBBpboRCdUB72/BhDHd7IupRMVFzmAgKfQJsgc=;
Precedence: bulk
X-Issuen: 1390421
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1390421:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251029.201254
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1761848632; bh=IwRegeCdAxRUZSDwQb6vAVM
	bdRio5Zuxgn8WY4q5vV0=; b=NF2HvmrERes1QkI3TPC+nacq7G0N+VU42kAZRmb1LvpIozx+Cm
	ob9cGdOka0hddTe83JmtL1rB33usJzLGgjkL2Y1nT25wn2YQAAH1X4IuQhxSX4tjeYeXCL3lBEp
	0Ui7cpIbXY1+H4XNv2ISDGtp42OU/g013HhNGHsntt6OiWobCIMK3NlN7w0bSKX4L81IThh97jS
	DWFnKJLNux8Se5PYvX76YVptGW1CnXHbVmwtHo2ked0Ltdmfi3T55x976rRixyP48MWR8MWXGvH
	bzsBlkl9WaXYmRD2hj4tDCKlb4tgC9nX9aiOR2weQszDSjkeFm3K1CML0kOSfASoa4g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1761848632; bh=IwRegeCdAxRUZSDwQb6vAVM
	bdRio5Zuxgn8WY4q5vV0=; b=ckhcImACfa0F44z7zVfDbptfH76D8cqwdLO48TXEFKvt1xbWvT
	ttrc41lX5pylpNlMuF6f7QuswI7lB+azPMAw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: make ASSERT no-op in release builds
Date: Thu, 30 Oct 2025 21:23:17 +0300
Message-ID: <20251030182322.4085697-1-foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
because all checks are without side effects and don't affect code logic.

However, some checks has READ_ONCE in them or other 'compiler-unfriendly'
behaviour. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
was compiled to redundant mov because of this.

This patch replaces ASSERT with BUILD_BUG_ON_INVALID for
!CONFIG_BTRFS_ASSERT builds.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>

---
.o size reductions are not that big, for example on defconfig + btrfs
fs/btrfs/*.o size went from 3280528 to 3277936, so compiler was pretty
efficient on his own
---
 fs/btrfs/messages.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 4416c165644f..f80fe40a2c2b 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -168,7 +168,7 @@ do {										\
 #endif
 
 #else
-#define ASSERT(cond, args...)			(void)(cond)
+#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
 #endif
 
 #ifdef CONFIG_BTRFS_DEBUG

base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.1.dirty


