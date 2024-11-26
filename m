Return-Path: <linux-btrfs+bounces-9913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A329D9A5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE422840D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C351D61A3;
	Tue, 26 Nov 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJiZE+9B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574E1D45E5
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634670; cv=none; b=vC+zAefA07W5o56m0ccuP6W/iZqYaZI50i7x9bOr6lVJaACQWcEr3m5WugFY/ZV34HjHOMDMz+D4C0U1GVPfVRqQ+P2Ocso/FFVsEAnVnK20BCa4ScjoQfIra0iyDbK3l4D0rcN9C/FlQ+7l9okab6rj8gl/V5PlfjWQRZ2d5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634670; c=relaxed/simple;
	bh=0nft9+2InSXfMNHbACxebYYRMVsPma/YV3+FO83lLFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY4PiKVR5avZMRxPi+VJrl/oON5KONO7eHPrjo39HXqa/qoMQK2AP3pl/FpdepAXxsQPNKdL4WhgzxyMVbiYBAFxkGC92KG02dOeNTFDacUO9NncLlQzyJW3W2KP6jAOwEh82rUTu5YBRygmybPUPzPhWewcY4AXKbRFQTlWTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJiZE+9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732634666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjDx8OlXD2/WfS8jDjPYSgHlVJb6xQJh3y8DAKeGSnE=;
	b=VJiZE+9B6FCLpOuM+ulyKdU7nIOLNx1zw56Dxmv0xTNjIEitvsPA/zotRUhhz92eEXHLrw
	bW0mpbEnOMq5rDRF8YFc6hiUwAHDnY1K5YhhdfdPPE5iVGMO55tP/91jJcCf0UR2w1QwEJ
	UPj0Ei89VZ5KVeFqKGduv6V73+wykP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-ThjAZ9pfNomGLp6x-Xjb_Q-1; Tue,
 26 Nov 2024 10:24:23 -0500
X-MC-Unique: ThjAZ9pfNomGLp6x-Xjb_Q-1
X-Mimecast-MFC-AGG-ID: ThjAZ9pfNomGLp6x-Xjb_Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D825419560B8;
	Tue, 26 Nov 2024 15:24:21 +0000 (UTC)
Received: from toolbx.fritz.box (unknown [10.39.193.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B4A01955F67;
	Tue, 26 Nov 2024 15:24:19 +0000 (UTC)
From: Allison Karlitskaya <allison.karlitskaya@redhat.com>
To: dsterba@suse.cz
Cc: allison.karlitskaya@redhat.com,
	ebiggers@kernel.org,
	fsverity@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	tytso@mit.edu
Subject: [PATCH] btrfs: add FS_IOC_READ_VERITY_METADATA ioctl
Date: Tue, 26 Nov 2024 16:23:31 +0100
Message-ID: <20241126152331.90434-1-allison.karlitskaya@redhat.com>
In-Reply-To: <20241126151123.GF31418@twin.jikos.cz>
References: <20241126151123.GF31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

146054090b085 introduced fs-verity support for btrfs, but didn't add
support for FS_IOC_READ_VERITY_METADATA to directly query the Merkle
tree, descriptor and signature blocks for fs-verity enabled files.

Add the (trival) implementation: we just need to wire it through to the
fs-verity code, the same way as is done in the other two filesystems
which support this ioctl (ext4, f2fs). The fs-verity code already has
access to the required data.

Signed-off-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9302d193187..392322a70ce8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5290,6 +5290,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fsverity_ioctl_enable(file, (const void __user *)argp);
 	case FS_IOC_MEASURE_VERITY:
 		return fsverity_ioctl_measure(file, argp);
+	case FS_IOC_READ_VERITY_METADATA:
+		return fsverity_ioctl_read_metadata(file, argp);
 	case BTRFS_IOC_ENCODED_READ:
 		return btrfs_ioctl_encoded_read(file, argp, false);
 	case BTRFS_IOC_ENCODED_WRITE:
-- 
2.47.0


