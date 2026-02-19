Return-Path: <linux-btrfs+bounces-21790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IQAJbJOl2liwwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21790-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:56:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544021616D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF2A301F163
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D2352939;
	Thu, 19 Feb 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b="nl6tLCoN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.orionsoft.ru (ip-210-182.nltel.ru [185.110.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56634347BC1;
	Thu, 19 Feb 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.110.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523744; cv=none; b=PKeduzdaY0VjYlQ75RPBkWm0/elwVIzbKJPH10QBnICHVEMluIlzg1gXW0MJCuslru+DLTWWXw1qwy0pbD6yfH68bRPxhRwLYj9sQvpl290yroKVNUZumL+ouAmv/kktAXLVzvTBIr46lfTkPrfrrV9D7Wj6uJFg5zyfv7ZfJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523744; c=relaxed/simple;
	bh=4CYpMHT7HToX4hDi4Xpf7Z9vRZ3HJm59yEiFSRpGcqU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NLGnf5V1O14R/YNeoRk7lFiea9/knR5yj+CmibGt0kIs/d8G6no97hoUxZyPRkFvVcjSKxdsoGyvpiSiCv3HLihVKmz06OLV7fCEnQqbi0jzNGdqbEUz06YYjMWb2W8kLPebyf53JMI/oAUYg9xFJudEgddgbtRuCg1IT+8Ocec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru; spf=pass smtp.mailfrom=orionsoft.ru; dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b=nl6tLCoN; arc=none smtp.client-ip=185.110.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orionsoft.ru
Received: by orionsoftpostfix.orionsoft.ru (Postfix, from userid 1001)
	id D9444A1A71; Thu, 19 Feb 2026 20:54:41 +0300 (MSK)
X-Spam-Level: 
X-Envelope-From: eburenchev@orionsoft.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orionsoft.ru; s=dkim;
	t=1771523681; bh=4CYpMHT7HToX4hDi4Xpf7Z9vRZ3HJm59yEiFSRpGcqU=;
	h=From:To:CC:Subject:Date:From;
	b=nl6tLCoNV/QmCbEHXlIrG28yOHtnKLkD1LAuB4okvye+kHHNLMxGvWjZ015md0Ale
	 hgl+xgDW19pL1PQIt5KDiEI6OInH/r8Fo7FvB9HVhjDMbs5g8fPldQgEkOlinK0fXF
	 wNLUZF1SY6dL6OAclkcqTMZHRUzWy9t/DQTlrsHcrTgr6EOPLNWPY3fGfjhoWjnTlc
	 Pjr3akSq0u2s/AgqU9Qfnf6SiXHJT602UFz2csLTUjc3qySXlE8dP6fbudIeDmta3C
	 Zvy+Z7zgepXzT5HODH26i/dbIFMgS6zDlv+7au8fqOQGerlZ7sNv3/jaF80AEWx9nD
	 P+kxcg+2mN/UA==
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
From: Burenchev Evgenii <EBurenchev@orionsoft.ru>
To: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"mssola@mssola.com" <mssola@mssola.com>, "fdmanana@kernel.org"
	<fdmanana@kernel.org>
Subject: [PATCH] btrfs: perform a minor cleanup in btrfs_search_path_in_tree()
Thread-Topic: [PATCH] btrfs: perform a minor cleanup in
 btrfs_search_path_in_tree()
Thread-Index: AQHcocg4bkgjOW3Ar0KhpFkKCifPug==
Date: Thu, 19 Feb 2026 17:55:32 +0000
Message-ID: <5a31d815257543b689373583411428b0@orionsoft.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Score: -1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[orionsoft.ru:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21790-lists,linux-btrfs=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[orionsoft.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orionsoft.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[EBurenchev@orionsoft.ru,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orionsoft.ru:mid,orionsoft.ru:dkim,orionsoft.ru:email]
X-Rspamd-Queue-Id: 544021616D0
X-Rspamd-Action: no action

After the introduction of btrfs_search_backwards(), the directory
traversal state in btrfs_search_path_in_tree() is fully maintained via
struct btrfs_key. The local variable 'dirid' is no longer used to control
the search and the assignment

    dirid =3D key.objectid;

has no observable effect and is dead code.

Also initialize ret at declaration and remove a redundant
"ret =3D 0;" before out:.

Remove the unused assignment to avoid confusion and silence static
analysis warnings.

No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
---
 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a6cc2d3b414c..d85e6a92538e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1648,7 +1648,7 @@ static noinline int btrfs_search_path_in_tree(struct =
btrfs_fs_info *info,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	char *ptr;
-	int ret =3D -1;
+	int ret =3D 0;
 	int slot;
 	int len;
 	int total_len =3D 0;
@@ -1708,11 +1708,9 @@ static noinline int btrfs_search_path_in_tree(struct=
 btrfs_fs_info *info,
 		btrfs_release_path(path);
 		key.objectid =3D key.offset;
 		key.offset =3D (u64)-1;
-		dirid =3D key.objectid;
 	}
 	memmove(name, ptr, total_len);
 	name[total_len] =3D '\0';
-	ret =3D 0;
 out:
 	btrfs_put_root(root);
 	return ret;
--=20
2.43.0


