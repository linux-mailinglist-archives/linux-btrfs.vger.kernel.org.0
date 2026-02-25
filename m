Return-Path: <linux-btrfs+bounces-21919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKwvKArunmk/XwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21919-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:41:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D6E197821
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E238F3051D0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B23AE70E;
	Wed, 25 Feb 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b="ymOXT4ZJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.orionsoft.ru (ip-210-182.nltel.ru [185.110.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7A1C84B8;
	Wed, 25 Feb 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.110.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023281; cv=none; b=B0VYf0peCqcC2+85O+E6Pum3tQYFV6T64qnhKJ0zysqC71T84adnxXG8tdO5jsTRdwUYvT8Ufl/CAkcxtSfJaDFpJr0TjBMEKOqUy276CQXQ+j+B/EQRsd7QGwELf0gFNkW6R90i1fwAyZBTlf/syj5EXMiV8zaegrbcsA00Edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023281; c=relaxed/simple;
	bh=0z/EYwHoGf9A3H2A7OVeoNMqvXRtfF0hjBFSpIJCqHM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g0IzCShBGRXUn8WACkfWsVD2m+Pe1Gniwq5erofWHs8uJ4VI3DeSI4Flhd0xvYO0b3zZvtwaT0eB1LtXFWCXU2qLeSUIZ3GH3xxM1yrh980V+eEpQKONaUEJ55ghdfGTMbtFoqsO588M1hqInyWvJVX5PkgH51o/cYgcHiTTL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru; spf=pass smtp.mailfrom=orionsoft.ru; dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b=ymOXT4ZJ; arc=none smtp.client-ip=185.110.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orionsoft.ru
Received: by orionsoftpostfix.orionsoft.ru (Postfix, from userid 1001)
	id A6875A1A4A; Wed, 25 Feb 2026 15:40:21 +0300 (MSK)
X-Spam-Level: 
X-Envelope-From: eburenchev@orionsoft.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orionsoft.ru; s=dkim;
	t=1772023206; bh=0z/EYwHoGf9A3H2A7OVeoNMqvXRtfF0hjBFSpIJCqHM=;
	h=From:To:CC:Subject:Date:From;
	b=ymOXT4ZJ03hIinPc9GUXHsxed0Lybd10Saj9GPjcKbDCNgJYy5q+uQiqVDSEaJdTn
	 MgONWWu75euiliU0aDn1LGfgLNmT3TEiGfpvzf9GCrt5vu3rzgrqldaJPlmHzm9/ml
	 pCqQACC03PQaRByczGPibsZ8Dx3Q6PxdM+TlEvO2CSgJGZ2hiL48Yq+OJGEUuHXIkB
	 /fDMIUH4hLQMMRynrGr3MNO2Zb+xW2Kpjceob45h6y/aHTAalcvLYuQpSWmCv68/Uo
	 7RM8nbaClZ7+pHZ5QJuhxnCvOfs4ivApI1jd57sjERIDg/X72Cch68OrLHeowEQV/q
	 GajNPlhiwZDZg==
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
X-Envelope-From: eburenchev@orionsoft.ru
From: Burenchev Evgenii <EBurenchev@orionsoft.ru>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"mssola@mssola.com" <mssola@mssola.com>, "fdmanana@kernel.org"
	<fdmanana@kernel.org>
Subject: [PATCH v2 1/2] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()
Thread-Topic: [PATCH v2 1/2] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()
Thread-Index: AQHcplLR3EW4Dza6/Uy8jPd/Xx7RJw==
Date: Wed, 25 Feb 2026 12:41:02 +0000
Message-ID: <10496334e2624a818aa786a697833f67@orionsoft.ru>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21919-lists,linux-btrfs=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[orionsoft.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orionsoft.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[EBurenchev@orionsoft.ru,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 04D6E197821
X-Rspamd-Action: no action


Related discussion: https://lore.kernel.org/linux-btrfs/20260224172835.GB26=
902@twin.jikos.cz

After the introduction of btrfs_search_backwards(),
the directory traversal state in btrfs_search_path_in_tree() is fully
maintained via struct btrfs_key.

The assignment:

    dirid =3D key.objectid;

no longer affects control flow and is dead code.

Remove the unused assignment to avoid confusion and silence static analysis
warnings.

No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Changes since v1:
- split from original patch

Signed-off-by: Evgenii Burenchev <eburenchev@orionsoft.ru>
---
 fs/btrfs/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ae2173235c4d..3a45ee1a7026 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1707,7 +1707,6 @@ static noinline int btrfs_search_path_in_tree(struct =
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


