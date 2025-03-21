Return-Path: <linux-btrfs+bounces-12488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E31A6BE5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE16F1899D74
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C41E22FA;
	Fri, 21 Mar 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="pfPW0hQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956099461;
	Fri, 21 Mar 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571172; cv=none; b=TNEdfHF/4c718xscCVKDtxMLO6BpRBzOolDXFRcQpap4QWaVu25NIuWxWk2qCmRk6vfVj/v1A6szCUuqblNqWGcTMXROzyhhBlWAS4zI6bFfMsUg/yG08d/MP6yYUZ+r5ceskb8LM9Sx5qZr0PEVQgNKmQPvdC1NH0zWMVCNnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571172; c=relaxed/simple;
	bh=ZrXLkydeiMW9PLt4uCF3ve2+57IWGeHbUunRpNSBEWQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OmvXsqHJ7/JMuKZoyE/QX9iUOLsDUDf6D4jhiccYMZ2Y2P6VjZqieWqWY0nPvd2EHhaXvTi9gM/v48qYstfXnekaoH/8Hat8LhKoSmxe4IXkaC+kGINuexOkuJyboKsgBSVJKPlGPK31gBCqCGGCGk5KPYhtxK9vbU6vrVjY5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=pfPW0hQP; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 0AED3108CF52;
	Fri, 21 Mar 2025 18:32:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 0AED3108CF52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1742571159; bh=3hzkxewlzAw9gqGNtlUqfJTSgMas1vCBFJRghfKnQ6Y=;
	h=From:To:CC:Subject:Date:From;
	b=pfPW0hQPoTLhWyEmanmS18h9FNjtYTE3Oxhdbwc0jsqZRRNcuRexrx5xBp3kZtJx0
	 iA55nYoVVRVCXTKjfqwa7aCjHEaxocl3pitcI8j8MwYS/7sf1nKJBAR4Si3At8q8O7
	 L4ZRunM4j5ImwD1H811kAaSgJIjxazDc2efZ3pmc=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 051393042F4F;
	Fri, 21 Mar 2025 18:32:39 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10] btrfs: have proper error handling in
 btrfs_init_reloc_root
Thread-Topic: [PATCH 5.10] btrfs: have proper error handling in
 btrfs_init_reloc_root
Thread-Index: AQHbmnZ6U2b+tEjdAE2Ihn3R2kCLZg==
Date: Fri, 21 Mar 2025 15:32:38 +0000
Message-ID: <20250321153238.918616-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/03/21 14:01:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/03/21 09:53:00 #27808853
X-KLMS-AntiVirus-Status: Clean, skipped

From: Josef Bacik <josef@toxicpanda.com>

commit 00bb36a0e76ab7e94bdd70d561baf25f9bc1415d upstream.

create_reloc_root will return errors in the future, and __add_reloc_root
can return ENOMEM or EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5b921e6ed94e..b0d34879e267 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -878,9 +878,15 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *t=
rans,
 	reloc_root =3D create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv =3D rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
=20
 	ret =3D __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		/* Pairs with create_reloc_root */
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root =3D btrfs_grab_root(reloc_root);
 	return 0;
 }
--=20
2.39.5

