Return-Path: <linux-btrfs+bounces-22146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHSdIU+GpWn4DAYAu9opvQ
	(envelope-from <linux-btrfs+bounces-22146-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 13:45:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10E1D8F19
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 13:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C958B30B0A0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 12:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA337105D;
	Mon,  2 Mar 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JFNWTbkq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344636DA15;
	Mon,  2 Mar 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455059; cv=none; b=Xli3rJSREw/naEPyEX3Gu09FtML/woJ2HcmyXEZc7nuXUZz/eFRWj5Zp3aL/EsEq3Uc9JeL7grEzpBK8R2RJpXJ9C8mhLWVA0zLYNK6bTiaAZQ7KLeeZxIA3BWzd2qvTz3r89dxPLllysddgQb9viFLg9JHNIp/wRlTZe7SLtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455059; c=relaxed/simple;
	bh=Lkf/dg2txwGuTXcdz7WNlvtKk26/JEZhF9P2VLliJOE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=LvC7LAaPg6hIT2F99Y8LMCqzOQYdwL2kFr068wrBwYJWEY31qIuCRyBwV9XhEIAbrTmqs53fmb7O1BjECIGsZeMbBd2PguvEx1NVt8xl4ckV4yx4x/un7l2muNwxL2WecXR/vvp/IDz/MAIZeaE7h4gE3g+Bzjjj9eadO/USJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JFNWTbkq; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772455050;
	bh=e8CHuB4p0fDzrHhTA6KSlIS4quZmLrs97Bn8FmkDHSw=;
	h=From:To:Cc:Subject:Date;
	b=JFNWTbkqtd16A/9RZQJVZyuB5Av5+ZidwevMH0vPp/TW5cAjPnPzy48TzqVpu3hpk
	 mB7k4iCfE7FgAUEwqRpAhWVeUoPjQ3PYqLhh/kvUp7OgOqVpywXZ7d6aQPJiwqjbfS
	 Gsj3bVtIkMbPBLQgQ3Yw+IYtGs8Gm2kkKG9kym4A=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 95B98C5E; Mon, 02 Mar 2026 20:37:27 +0800
X-QQ-mid: xmsmtpt1772455047tj1744mao
Message-ID: <tencent_1F20921BD691389E308E0D31B4FF35831F08@qq.com>
X-QQ-XMAILINFO: NmhoXJR/eu5x5vrX2k5TKpOc9jv48PzadKcU68Rtd+Fda38o7POgYSgcJBpm+N
	 U4zwDKCu2C9OvzMRupPruuOns0ZVyDXCo71X/TyGqRNHSAP6G8kfM/fW5e/lZR2BcjcERplC70tO
	 qIW6kCeYYs/AA8YJ10EqhqdgzJWNO+TRSIN5RD/J6KvCYhAccVNN8/9HgvkTkawmNdcu0OfSRbt1
	 TI7zHiA45lDS053uXtzGIRt3/VWQcgG0vmQE+LAa3WUsQslclETOlRutVhaTdXS2yoN/5O3zOSI2
	 G8lDPXQkghTHSfG1CH0sGNIB+N9T5bh9EYOUx6BBleArxbP2BU8EwSN9+lGuVINmu38MVRY6Y6au
	 iuKTTGHkq2e1MclSSZszIcvxLUd16QysuQKSfvaI+izeuBNqRWiXHS4k3ZmK9vgSCMfrgssypa9u
	 7gjV57B4leHgnpCtzUm56o0Hir5XG7CdO8A3/5D3E//i+ycUs2ItqYdzOE3RkqBBDVS+xhc6WNP3
	 rqc+k8iotqVjrUk+ejNNmZV488Wy7VefuuEnwrnw4UhWaFVbV13mWqUN+ivavgwEUhzbWELMD2Q+
	 4Kox53HL43zbn76jcUVzPZGaMpaLKZ+hxMyXYAWCk3rfOvf9YkW9Lh3+sY+zsyxDMsHCg4eklcZi
	 X9Fc6QTPpUb1dOImt08ua4mIyd2IGH82kkwx5LBdiCJIqI97ekocgPKH35pLo7FwAgpyOnU5HclR
	 Csq6+y8CKtElHkMnFggCs6q1CSHApe4GqzLu3r6fjpsHUSI53XRyYzjfFxwIzJeYfdGvUBQeQr4x
	 EESQ16rP3r3QiaMq3Iz7ZSs7iwFmorjCrPCAWBS0tzosG2qkKK7ce0DgL7Cj2qTsLj9A2pa9BnG+
	 xmQP8NR2dl2d9QzHxTSo3T7TBXfWIVPc6Xcfg7STdcCR4dqLpWw7ydgE71zYSkSiLXadCRZkjdmu
	 XU+fGimt+ks1+1PqpJAyIByIBxd6uJum6EPjquJcDdC8ox88WmyuOyssK4wTX2tOZo9SpUpXWvj0
	 MjjCNYQM4xjmerjZ0epNWIJx0NKrfeNy/BsTVDWDe8yEB0aUukwp8ZNdx+Fng7zQjzx0SO/g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] btrfs: send: check for inline extents in range_is_hole_in_parent()
Date: Mon,  2 Mar 2026 20:37:12 +0800
X-OQ-MSGID: <20260302123712.1429366-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22146-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: DE10E1D8F19
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
index f5a9f6689c46..afab6a4e6a3c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6289,6 +6289,10 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
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


