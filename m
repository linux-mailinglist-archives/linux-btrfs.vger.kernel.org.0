Return-Path: <linux-btrfs+bounces-21921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wECVIyjvnmk/XwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21921-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:46:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F61978EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5C0D30405E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F523B8BCD;
	Wed, 25 Feb 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b="POKaDi4c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx1.orionsoft.ru (ip-210-182.nltel.ru [185.110.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B53B530F;
	Wed, 25 Feb 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.110.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023480; cv=none; b=pwgGhQHYYwxcAADDj3kLs1rAeIDlRA9qIfBl5G5xq481LahEMMy4kL0KZTyCdoXDeyEoLwIvKcJiDNgHevj+kq9KzvD4lmE4mc6/Y8qh/ym28XVmgAVWGi7pbY6IYu3XdIsgKwgM4tOmJwGy/AxY9qY2DlJJzdNh6ed1ZqPNH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023480; c=relaxed/simple;
	bh=ucH6wDhblBd4rlBJLTWUrsPrnN/uQalrkzziVcmV3bY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jcEv8ZWY8B8OTkwALudqeVldqI7TrT5JcQxTxb0rI59NuAwrs8kgYFoA/smdNpqywR63tvPiSFej07kyZzjB9D/xBk0Eytj+E1vdYKiMst9PWEc9phs2yI16SGmiL74upDnfFmnkMSueq5zyjZCGbrtxwnXDp8ge5svdnnX4WTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru; spf=pass smtp.mailfrom=orionsoft.ru; dkim=pass (2048-bit key) header.d=orionsoft.ru header.i=@orionsoft.ru header.b=POKaDi4c; arc=none smtp.client-ip=185.110.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orionsoft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orionsoft.ru
Received: by orionsoftpostfix.orionsoft.ru (Postfix, from userid 1001)
	id 7C535A1A62; Wed, 25 Feb 2026 15:43:41 +0300 (MSK)
X-Spam-Level: 
X-Envelope-From: eburenchev@orionsoft.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orionsoft.ru; s=dkim;
	t=1772023416; bh=ucH6wDhblBd4rlBJLTWUrsPrnN/uQalrkzziVcmV3bY=;
	h=From:To:CC:Subject:Date:From;
	b=POKaDi4cu98K4SIjx4J9aHnmZPNWef+CbWTi44CP/dMLqFTnek0XCWBScC3i65+PK
	 QlmM6P3ezEoKGi7sN1rLjiMs2j+s9ZHpcjQvv6ige6y0shMUiB1D5PCHm84oKJIwDK
	 zVFzUGWdIQjRBYqjjKgzpszc1qK3s0Ilc3LHEo+LPow+2NtOqEITc8nM2JqPW8aupJ
	 iM/ai/8KPiEcyGLdyUFOatcsx1BCDM8cX9N9ySsIrSG2K2jbT43pgpT7/mao9b9bm0
	 vQHfLu3DhnvOa7tdta+oyHbKC3rRqog87SKrjxaWTo/ZCkEHjuGGOdupwJI2Mf7Ug2
	 HmJGs3JRHlvug==
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
Subject: [PATCH v2 0/2] btrfs: perform a minor cleanup in
 btrfs_search_path_in_tree()
Thread-Topic: [PATCH v2 0/2] btrfs: perform a minor cleanup in
 btrfs_search_path_in_tree()
Thread-Index: AQHcplRfUbscG3BbdkmbijWOYAryqQ==
Date: Wed, 25 Feb 2026 12:44:31 +0000
Message-ID: <0ac42b939a6b4a479c2f508e18305873@orionsoft.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21921-lists,linux-btrfs=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[orionsoft.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orionsoft.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[EBurenchev@orionsoft.ru,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orionsoft.ru:mid,orionsoft.ru:dkim]
X-Rspamd-Queue-Id: 229F61978EF
X-Rspamd-Action: no action


Related discussion: https://lore.kernel.org/linux-btrfs/20260224172835.GB26=
902@twin.jikos.cz

This series splits the original patch into two logical changes as suggested
during review.

Patch 1 removes an unused dirid assignment that became dead code after the
introduction of btrfs_search_backwards().

Patch 2 performs a small return value cleanup by initializing ret at
declaration and removing a redundant assignment.

Changes since v1:
- split into two patches as requested

Evgenii Burenchev (2):
  btrfs: remove dead assignment to dirid in btrfs_search_path_in_tree()
  btrfs: btrfs: initialize ret at declaration and remove redundant assignme=
nt

 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--=20
2.43.0

