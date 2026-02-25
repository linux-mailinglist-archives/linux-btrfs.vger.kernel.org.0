Return-Path: <linux-btrfs+bounces-21933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LClK/dUn2nXaAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21933-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:00:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8B19D006
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA5493012CA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2852D77FA;
	Wed, 25 Feb 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sBjshTMe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655F2BD00C
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049613; cv=none; b=fafj9r+0tI9orPhkoUpvnGjOfvWIZYCfeToI0n1Q56feaJY5kG1qsfVzRtJ1KYTW08yHuAENtLsUNucavCEURPY2UQyDRu7BeVGzyDT2SmoMnGN6kUhsAmeF7+reTzGWuS2OJwIK6wgM1vsSUYSAUH1LUtEqKFol9Ccsvu0XOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049613; c=relaxed/simple;
	bh=pm1Pfsw4eYYQWqHncTU2Nkp9ejef/CezeN/q77NaVwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cO00zbDFEl9xn6DR9PEa/YWG6cmjFWnR1R+KX6epOjIX0o7Qh82iGv8aVyDfE2MuarZri7GMJ09Fh/vNgctz4ryFoSju2sBi8533Y/qukfNEQCz8hZvbpsm5QE7dvL+cvhxwOPrqGG7HX2X4f7yzddwsMhtA8Jk1YFYB/1U2JwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sBjshTMe; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fLln75L9Lzlfddp;
	Wed, 25 Feb 2026 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1772049609; x=1774641610; bh=R1a0xj/w+zEYiF9Zt6bX9yypeSHVFh7sTid
	RprFFlkU=; b=sBjshTMeZbAtlvVUBpb3dhQGBOadf/lPCnPz/c/I0ch6KYdXUHF
	iz22V1QstdZHxjyBQZqnrOdBu77vSOZh4LCklCml6DDUwdR/GsCob1giSMRoAYAY
	5Dzv0TvVWn6Y5zhxyuFSQ6cX7fxvTnDepV3EveK9cQzqLva8mL0MAX+HY2a/itJG
	zejaOEi1oYHOolYhPwfxTH9aFSwsC7hEbwluCA31CTAVbFgnustXXgXzmKHUKk5f
	ycEFr/Y0GZdXES1as3JTd6sSDjJf3fMAfZxdQBSfNSRHM4s3HT4l2iyfA2HmaEn3
	bv0xEpCVmCSYWDPb50nqZomElZb2gFy3eEQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P3a-bNtp9dfW; Wed, 25 Feb 2026 20:00:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fLln44Fqbzlfddn;
	Wed, 25 Feb 2026 20:00:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Chris Mason <clm@fb.com>
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Leo Martins <loemra.dev@gmail.com>
Subject: [PATCH] btrfs: Fix a bug in try_release_subpage_extent_buffer()
Date: Wed, 25 Feb 2026 11:59:58 -0800
Message-ID: <20260225195958.309047-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,acm.org,bur.io,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21933-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,acm.org:email,bur.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 42B8B19D006
X-Rspamd-Action: no action

Call rcu_read_lock() before exiting the loop in
try_release_subpage_extent_buffer() because there is a rcu_read_unlock()
call past the loop. This has been detected by the Clang thread-safety
analyzer. Compile-tested only.

Cc: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Leo Martins <loemra.dev@gmail.com>
Cc: Chris Mason <clm@fb.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Fixes: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_=
extent_buffer()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 744a1fff6eef..5f97a3d2a8d7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4507,6 +4507,7 @@ static int try_release_subpage_extent_buffer(struct=
 folio *folio)
 		 */
 		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
 			spin_unlock(&eb->refs_lock);
+			rcu_read_lock();
 			break;
 		}
=20

