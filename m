Return-Path: <linux-btrfs+bounces-22163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFNKDmU9pmkZNAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22163-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 02:46:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69001E7CDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 02:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 668473039F51
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 01:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F794363C4D;
	Tue,  3 Mar 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tEV8xS9N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1A19CD0A;
	Tue,  3 Mar 2026 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502362; cv=none; b=uZiTR/GWMxCFBQNhsZwjn1DoRXFttBJZuYClI8ZN6N8DUQ0I+d1n9uFETm0E3bGx4DhwJe+bj1+rItKc/TMROqgksO4TVTgGTb0HLKQU+I58tHYnhHh2aehsRPm+rt6SmE279+eXc0rk4bK835KzUkA60/fle/1ll/Nk7zrzRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502362; c=relaxed/simple;
	bh=QCQGDvW+Nr1ARK1MamhfGuYRf4HyjQ1yWH2xs4BcAxU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gVnY+1278b+UMw+nPXgiBsrBKHEBdq/duhB6FgZOZgaR5Rt45RNcjVgwMISG6o1aWlpXXFRLkzv0xx7O60PYUXwWrge6Nf20DLid6pbJSA/X+F3lDDGuUfO+9VSQbeM+Rpf0/LRgdGEAKx+4F3i8f5IeOzUVrWWaeyEkJ5Ndwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tEV8xS9N; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772502350;
	bh=hZxK6yPiXLJKf9NexCfa/9nJkEBZ5VgwLq8zk3x+Cbw=;
	h=From:To:Cc:Subject:Date;
	b=tEV8xS9NNc2/kz4bPupCYQHcSYRKo/GuMhaH/37xN75rhgGa/stADhJ3CqXarGGlF
	 OlCsHElywInCgPvKjuYaXJm5igq0LKqxeJqda/l4+RFnfP5WqrMOWXC+oeAWSwwBiD
	 GzYTpNE80w9uMIlBZkQ1zaKXUTK0hMBOmGwfgxP8=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B66B864F; Tue, 03 Mar 2026 09:45:38 +0800
X-QQ-mid: xmsmtpt1772502338t7ioimsuj
Message-ID: <tencent_E33A07070D66A4018456A326E0C34932DE05@qq.com>
X-QQ-XMAILINFO: N2MqhO5su2b5lytw7Fdqz0j/Rg51/kJo53Jl+lOgNhT2cIgn504KFm6d/ve/vB
	 T1XnlTJ04jgWAxLPd9mcoNaRCHaVvfU084txcIgOsJG+pf8ervGaijBSd5ySu3ozbv2Zl9EIYYDo
	 /KooOg0IG9+N7hqLl0CsO9d5xWJQec5ub8JjzIXce5lMWkEmw4HcM75S7Tp7jmHnqoCEIBQSM2Or
	 aq4idPBNNnDaH3ZnWRoyOICIN5+Ts4Cf3JQXK2AQ2BWyXnChtZR3o78eLs3JFEjM4usDT8trMwtG
	 y7hh2x8Kd0/ec2R9G9QsacmASsU+c+PI7FfW2ovgtaJWaoc6m+ruo4SssB99nVh9bEilIQaxk5Iw
	 tLC5Zkd4AvtQ19L1QV0BnuFHK52PjYWIL9yvEc1RdRsVp6RLfRxm7xc0ArOphdkR9aqR2Znb1Epm
	 fBJKZL1kNnaNfwozLPnkWMcST6L0OH80ztFZ4KGhDCcg1BTaqeP71OOJeX7tbtbtt3AgSKlB8WXB
	 BmT0f/oVuqHx3+EvhDzjFTXvQ5mKJ3gxSBaQfjBw4k6hPc5qkY649q6UKuYZmq4vGL85QhccQwSb
	 VZBEvO9AC8a55aZ/l47Ve173EIVm2nq0QQWTdwpxBKNRBxkK1lnFYiSMh0JFDpna+rIcG3GLBjfx
	 vW7OyNimciBY97GkWQxU+IDmlTd2V/Kdgzt6umbo/cWKSTqUTPo3rjbiUQn2/UhG5Pr/e8u+w9d8
	 WsYX9J2D5LVXO74yhPbudw1uXk/2EAYHDu04sn5pBYlAL3/uHPM9Re/v0dqq/xl2Iu/n2ibr30Pj
	 KfLLDPdfDyLUl95of6or+8Nm/wYhawzxKxigSgdcaW1OxyGgOxmmulwAps0OaVnrDjo15eP4jFYR
	 adCR8p06jrErP59C2sZOvEHZLi7zbVk8VyeM1ajFyT0A/tBPtkWHg2LFeUKLVCmrRQIm0G66xpMs
	 q077lV21PjKvJFElmCpKZxfc19eaMIEpX70tFKygj8yH4eITkbJd4+qny1MTOLnYcZslZ8qEt6/M
	 JSxMT2ph4TvESUrrtyM8sdbdK6fV5SHrSx8pYcyJzPen0elT8Rb+yjScdcKu2GpX1cJRL9aQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] btrfs: send: check for inline extents in range_is_hole_in_parent()
Date: Tue,  3 Mar 2026 09:45:22 +0800
X-OQ-MSGID: <20260303014522.1551857-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C69001E7CDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22163-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 08b096c1372cd69627f4f559fb47c9fb67a52b39 ]

Before accessing the disk_bytenr field of a file extent item we need
to check if we are dealing with an inline extent.
This is because for inline extents their data starts at the offset of
the disk_bytenr field. So accessing the disk_bytenr
means we are accessing inline data or in case the inline data is less
than 8 bytes we can actually cause an invalid
memory access if this inline extent item is the first item in the leaf
or access metadata from other items.

Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole writes for sparse files")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Avoid leaking the path by using { ret = 0; goto out; } instead of
returning directly. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/btrfs/send.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a46076788bd7..68c62b34d6f0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5892,6 +5892,10 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
+		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+			ret = 0;
+			goto out;
+		}
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
 			search_start = extent_end;
 			goto next;
-- 
2.43.0


