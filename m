Return-Path: <linux-btrfs+bounces-21689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJCYKKNGk2l83AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21689-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 17:32:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E2146373
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913F430490E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C0332EA2;
	Mon, 16 Feb 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b="ye+be+is"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.orionsoft.ru (ip-210-182.nltel.ru [185.110.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FE2C0F8C;
	Mon, 16 Feb 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.110.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259175; cv=none; b=KrbpF55ZLufJZDD4R3JehPzS3t6xxO3FgtZrQtuOUrbW6C4Fy6jKcLiH+SyOVFMh+itK39gfGpshJA24ImZQq0nQXkAaz6oLIsBi9/4WmyDrSJHV397qjeEWws9w+b0ZTzk8r1cpR0G6LtChlEw2a5vuj43J/5TnDoowPqXMJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259175; c=relaxed/simple;
	bh=p97GUChJVwZtN+EI3y4IOUWtUuFg/saYUAyWsiOl0Vg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BivkdU8AaTI8BlGx9AbH2yAH0WLUMVvVm7qPMj7aBKujaYkgKdHGeNsYWWqpBjcLcaOVJQEt3iRd3qLw53GvJ25GvplQ/P5ZbCws97/s9DObWSyv6vOUQQlAIAvIFdfIlttvMFYpkUQ5pwbKwz7T7lsEx8vWORkky2USRRpdCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru; spf=pass smtp.mailfrom=orionsoft.ru; dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b=ye+be+is; arc=none smtp.client-ip=185.110.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orionsoft.ru
Received: by orionsoftpostfix.orionsoft.ru (Postfix, from userid 1001)
	id 1E390A1A25; Mon, 16 Feb 2026 19:16:05 +0300 (MSK)
X-Spam-Level: 
X-Envelope-From: eburenchev@orionsoft.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orionsoft.ru; s=dkim;
	t=1771258564; bh=p97GUChJVwZtN+EI3y4IOUWtUuFg/saYUAyWsiOl0Vg=;
	h=From:To:CC:Subject:Date:From;
	b=ye+be+isCeC8dnS/G/H9JC3gNqvU0dmDsamXZsp+V5hs2kg4jbDvKrb/yn94JhCIU
	 pYMNFfWsukOgdzbUGShFiVS3RRNkNeouzIXLuspO4UaUXOCFuhy+iMo/RW+WDn3UCz
	 x7YvtbimlgkWPjnjapRahkVh5JtNcg/mLv6vuIqP3v/LuQ4upb2g9Z+NUzeRzXzrmk
	 qv/6qYXq1Z8xyqm/REFsiNAQpp2UqjExjFbUhePwYpVa0dSqp2HbRRB2q30Xl7VLn5
	 TYDN4NgVUerjB7fDJuL/6LoYxOH+tNSzyQdV62xA6hsaSijb5ramB9ZPa48Ve3pJIo
	 i1XP221C5nv3A==
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
From: Burenchev Evgenii <EBurenchev@orionsoft.ru>
To: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] btrfs: remove dead assignment to dirid in
  btrfs_search_path_in_tree()
Thread-Topic: [PATCH] btrfs: remove dead assignment to dirid in
  btrfs_search_path_in_tree()
Thread-Index: AQHcn111J/11wufZzUCRlBI692A8mw==
Date: Mon, 16 Feb 2026 16:16:53 +0000
Message-ID: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[orionsoft.ru:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[orionsoft.ru];
	TAGGED_FROM(0.00)[bounces-21689-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[EBurenchev@orionsoft.ru,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[orionsoft.ru:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 0A4E2146373
X-Rspamd-Action: no action

From ff2df73ba6483b0dc67b3ed89d2a43c49f1c2eb8 Mon Sep 17 00:00:00 2001
From: Evgenii Burenchev <eburenchev@orionsoft.ru>
Date: Mon, 16 Feb 2026 18:39:30 +0300
Subject: [PATCH] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()

After the introduction of btrfs_search_backwards(), the directory
traversal state in btrfs_search_path_in_tree() is fully maintained via
struct btrfs_key. The local variable 'dirid' is no longer used to control
the search and the assignment

    dirid =3D key.objectid;

has no observable effect and is dead code.

Remove the unused assignment to avoid confusion and silence static
analysis warnings.

No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
---
 fs/btrfs/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a6cc2d3b414c..292043b11207 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1708,7 +1708,6 @@ static noinline int btrfs_search_path_in_tree(struct =
btrfs_fs_info *info,
 		btrfs_release_path(path);
 		key.objectid =3D key.offset;
 		key.offset =3D (u64)-1;
-		dirid =3D key.objectid;
 	}
 	memmove(name, ptr, total_len);
 	name[total_len] =3D '\0';
--=20
2.43.0


