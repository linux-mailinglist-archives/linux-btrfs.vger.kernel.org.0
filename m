Return-Path: <linux-btrfs+bounces-20812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hm8HLK2cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20812-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:21:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42855EAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD37C6861C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6033E9F72;
	Wed, 21 Jan 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4iV9igi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98D4418F2
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994039; cv=none; b=WMXRtfSumTXOvr0e56bn3dAJK9cHA+XSTqQyed1oPoHdndO3eIxJPp8yht2dmh57tSWgpHi2mH15ksZ3pi/JO/P3yDkLB/CAcIZDI4Rwc1BhLZlSQAQFB6QBZq7YADbnaMv7JuvULnagm7Y6LOePykZjxwVKcsgr28MPG85uTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994039; c=relaxed/simple;
	bh=9JTeTSJtdzIJ47imf5sRR02hc8SDhqRN8pHfgVpkjiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Lz5KL0IfINZ/VbEesBPPo9noksKLaChWb94/U4cHiXPv4aeuNYycigt0YBpnm/5KQ6s2VbzVV1t4WSlKTpRre+m5UJFV7LVDXaMVykWilMWJiIjHnfTG+5enaIUacEGqJwUKrg+9dDzbhDyZ3I4P5yJ2v5KvzsVX/ocBj8DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4iV9igi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE7BC19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994039;
	bh=9JTeTSJtdzIJ47imf5sRR02hc8SDhqRN8pHfgVpkjiE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D4iV9igi3OvQXF5VzZLQ+fn2XkE5exMSAfxU4Cztcjrx3wRbK8BhLsKA3DbwTlAuC
	 CPxYY0nbFtOpB3tsUscNgCwP+p5xkW9+FUoEt5ULd4nEMsd3e9WbvLh3NKRE8kPU/e
	 W8G+IQ+k9IRhkULhirhQ8mcNwsBm/hEvXGTetiBoIINC7cetKX0UTWiPIO6nZUjmzP
	 HCIWOg9v/g6LDrlKfhXIGnWW7ftZZ39GMkHCyXgT5Bz2rjNzt7uvKIJrUDA2ubGFqY
	 /84753RhEeUl+UziGX0zLkIpJKbbA6YgL2ym8cDzQG9F9tZMqcOI3Cs3RwMh7cmTaA
	 VYvzPMRrDCiLg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/19] btrfs: remove pointless out labels from ioctl.c
Date: Wed, 21 Jan 2026 11:13:36 +0000
Message-ID: <7853a4dc504d052dc921343eab8a8ea747e61256.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20812-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 1C42855EAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (__btrfs_ioctl_snap_create(), btrfs_ioctl_subvol_setflags()
and copy_to_sk()) have an 'out' label that does nothing but return, making
it pointless. Simplify this by removing the label and returning instead of
gotos plus setting up the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d9e7dd317670..6fea06685a51 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1184,7 +1184,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 
 	ret = mnt_want_write_file(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (strchr(name, '/')) {
 		ret = -EINVAL;
@@ -1236,7 +1236,6 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	}
 out_drop_write:
 	mnt_drop_write_file(file);
-out:
 	return ret;
 }
 
@@ -1359,7 +1358,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 
 	ret = mnt_want_write_file(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = -EINVAL;
@@ -1428,7 +1427,6 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	up_write(&fs_info->subvol_sem);
 out_drop_write:
 	mnt_drop_write_file(file);
-out:
 	return ret;
 }
 
@@ -1494,10 +1492,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 			continue;
 
 		if (sizeof(sh) + item_len > *buf_size) {
-			if (*num_found) {
-				ret = 1;
-				goto out;
-			}
+			if (*num_found)
+				return 1;
 
 			/*
 			 * return one empty item back for v1, which does not
@@ -1509,10 +1505,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 			ret = -EOVERFLOW;
 		}
 
-		if (sizeof(sh) + item_len + *sk_offset > *buf_size) {
-			ret = 1;
-			goto out;
-		}
+		if (sizeof(sh) + item_len + *sk_offset > *buf_size)
+			return 1;
 
 		sh.objectid = key->objectid;
 		sh.type = key->type;
@@ -1526,10 +1520,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		 * problem. Otherwise we'll fault and then copy the buffer in
 		 * properly this next time through
 		 */
-		if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
-			ret = 0;
-			goto out;
-		}
+		if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh)))
+			return 0;
 
 		*sk_offset += sizeof(sh);
 
@@ -1541,22 +1533,20 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 			 */
 			if (read_extent_buffer_to_user_nofault(leaf, up,
 						item_off, item_len)) {
-				ret = 0;
 				*sk_offset -= sizeof(sh);
-				goto out;
+				return 0;
 			}
 
 			*sk_offset += item_len;
 		}
 		(*num_found)++;
 
-		if (ret) /* -EOVERFLOW from above */
-			goto out;
+		/* -EOVERFLOW from above. */
+		if (ret)
+			return ret;
 
-		if (*num_found >= sk->nr_items) {
-			ret = 1;
-			goto out;
-		}
+		if (*num_found >= sk->nr_items)
+			return 1;
 	}
 advance_key:
 	ret = 0;
@@ -1576,7 +1566,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		key->objectid++;
 	} else
 		ret = 1;
-out:
+
 	/*
 	 *  0: all items from this leaf copied, continue with next
 	 *  1: * more items can be copied, but unused buffer is too small
-- 
2.47.2


