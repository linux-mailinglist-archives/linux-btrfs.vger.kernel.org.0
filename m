Return-Path: <linux-btrfs+bounces-17194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE680BA10DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6856D6C0627
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B231A578;
	Thu, 25 Sep 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Hzw3mcq+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76FA944;
	Thu, 25 Sep 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825733; cv=none; b=Sy9kHhqfKsJcLstXbU2lx6LRYbHwc75HAOe+n8/cxwVNJDJQQEglbWHCsQBlzqnt5fIVnPb057/hqd1bpsPH3lI2K0vIWKOtA/sYGOqNbZRDXDlRDHyBum1AUo3mHUBkWIaGY2W0Prc+Z3MU9OWodNIpF12l3u6HW2cSyM2OH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825733; c=relaxed/simple;
	bh=hwdRBdcNsUcmJ+K59rhrs4+nWsrkgB4EhcUZpsI5j80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qts4u7m71/XChM4DV9jK8HB7eHVhP+UGGbKL4TQNN78BNz6Cp7ilBxihLDqNGkwqnAxnpQZRFReJMQgLxqD/mQYfCm8KmTXbxML48ck80XIkWQgcv4w30M8MgNPl4+5gfpNqcHeoJZ+VBmHE+QDiTv0n7ThM3TiAZOby0PBbFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Hzw3mcq+; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cXjHf1kdyzB0l2;
	Thu, 25 Sep 2025 20:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758825726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4M9ZLcJXSUwaRGj/k1GlEUNg5wyMgiEIgqlESuJ1/6g=;
	b=Hzw3mcq+AVY81LTaC0SSB8oxE+jGFoe7pC61gcWKxetESd5455tlFKHFeG079J557dH+6H
	Y28e9w9FjoUJLocBPU1mKOQDG4iHLPlTEeijcjbbZ6CRkPsrCEWxSdtnWV6GmdVX7KOu92
	hIbRZf7hqdhizSzHMMX+UFGHaqYN6qqb56YY6n356gfzpq2VXDwflGleH7016w6XT+5oVE
	U3QQicxaYNgGtJNutGZwv/Ngb7+iyQSi23cvueqZNL7cW07feL6I7D6QH9B56TEHiOMjf3
	roUB2m1cDVXyM8dBv+lzb6JxeKPfNLHGyZqxBXzkIMVVRoSnLWX4zb+BBJYGrw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: ioctl: Fix memory leak on duplicated memory
Date: Thu, 25 Sep 2025 20:41:39 +0200
Message-ID: <20250925184139.403156-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cXjHf1kdyzB0l2

On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
provided by the user, which is kfree'd in the end. But this was not the
case when allocating memory for 'prealloc'. In this case, if it somehow
failed, then the previous code would go directly into calling
'mnt_drop_write_file', without freeing the string duplicated from the
user space.

Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a relation")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 185bef0df1c2..8cb7d5a462ef 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
 		if (!prealloc) {
 			ret = -ENOMEM;
-			goto drop_write;
+			goto out;
 		}
 	}

--
2.51.0

