Return-Path: <linux-btrfs+bounces-21270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BZ6CE/9fml9hwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21270-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:14:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B136C51A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 08:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D0730182B7
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Feb 2026 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4F2E62A6;
	Sun,  1 Feb 2026 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j84VZcJm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176682E339B
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Feb 2026 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930047; cv=none; b=ua3D0IbgR3Q09irWnEf0KZ4m38d3+T9dUTZP7sA9nOaJKfce2y6cyBWe+QQk79NJC8axNgJnEWP0NP0BvHRtYHU+SHhxrjMo2RZfb+VFrIs8S7ki8HiJp9iaKGuYbjtqd03btTCEYVyxwon4BwV9A/u7WjrwM8/SkEMEgpxU+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930047; c=relaxed/simple;
	bh=qQ5jEQwXfoZAkudftg+kXXDEawdvl34d9f7OgSGwN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPnYyTcbFF+zkdXyIhf7Il+/ooo6tpxo5XKZnZ9hIVthxM7AjiF9uozASt9Zp5UcG30zJ3rawsTirZTMLRF/j9NMSpQugCvjcK2vpEAvMnl5tSs7LyvnIoS3mIN/2mtoHZ/P4yMjLNSrDYl9g9R0uU3ntIYtPIKKdZn9pYfs4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j84VZcJm; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b751c8b6beso2498933eec.0
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 23:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769930045; x=1770534845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZDw3vdQYiwVFo053FncWzhupEEGPJGFHynGMHSSRHQ=;
        b=j84VZcJm56RRlmhyhbF6M13TYBZQDSyHfYKj+mPtYXUoZsDZWBB7kRkH/VHfMrTH5Q
         L9F1vc16YLul8+E7GIG6SQ25m3V/fyg8uNwoin+njU0oHXfWZPw7JRFyFb//1Ur96ZWO
         DyhzVyI0E0gcpvb1D+6XnkcwStngOy2wn+yjDz64Ci+NUeVgjd7JWHpMcRBGB8yCu4Dz
         NokUKzIria6aT9Z6ANCXR13jMolZbkFSKv4p6qPKBjldEKYuDzBqEKCLXrrayWCPr1Fb
         meUBbdPn5cb7qZuiT8FCTKd0ns4FLtCyTH2F9YWiAEVCmpEfW6y0Xbn2VDX2BfW4JcBi
         QfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769930045; x=1770534845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZDw3vdQYiwVFo053FncWzhupEEGPJGFHynGMHSSRHQ=;
        b=fN5ggUhoZtBsOEge8+4rrIQ7VZG7cmTTJUxfkCtQAEIQ1bmTrSYRucjgXSA9VoJJHo
         hK5rbl7dP9b6FDqktweBaDDWnxpXV5sHcpz9VgtQVhmuossEY7OSi6WiVYT3+yCDG50t
         0dWgoSB5OVHiBf1Ki8t+y4+VKNrhztIKmRNsxq3J6qK42/jCUVssMbUKxVypqOWwgT9w
         sL3ADD448N8jJISX8VsiSI1ftIeM45s0HndQwsjFtBPmi5JQML29EkaYhPkGLdrlG5Sk
         TECH8oO4i18wjnYSBWFSYEBQ3ByzmZq8g6wM9YPKeNqOmWXbx6tDUBiVlVWR3Xo4XvV7
         sr2A==
X-Gm-Message-State: AOJu0YyLvlZHii1H6KSXulMQ9aKyk6QKHOMSz0PvqNhTCiD/vSSWWTH1
	tkVWyBV2y1STLu3i355wJmlJBfGl+hmHr+AeRd2CfR/hxEKjEpu8iTha
X-Gm-Gg: AZuq6aIfKa3ijngSI7QhjiDcVPUvqp/DWmVE74E8mDs/PlijksVSgnrvIToX48MiMhQ
	01qZU6YUOIB2JBWwAMR0UaiKSe7o2DSbWhhclT5ErxySY1LueofVEFVpuMmVSOETQv0F3nyqTKU
	ZggsPP1kvb8++JqH4DscsqfoO6uM5aHqWcet+CRs6U+ib+xhkqjFsHnJ+QhmN9deWg6iYj7zBwK
	fIpKBvegQcvphQpsCTz2uI8BbnfiTJFLEHrksuTLPHn1BXdc6sDj5jvDpWw8p/Lj23A82iZ8GXo
	uWnA9g7c0s2/WJ2bw9KSNpc15MWfGbsRpoT72oYTAxJE59NacjXDLCQarCAeFJaOVFNG8PLSt60
	gleOeE9syJvlYkGLTKYCLEOMr0fseYOQOLuL6QDqsRVkBwhoM4uiA8yAh9gp+zmebuI1rzTQABM
	Yp2vYtBRuyjnMWaLguVkQw9pOUL9TA1Uad/JYeEA==
X-Received: by 2002:a05:7300:80cd:b0:2b7:b4f7:27de with SMTP id 5a478bee46e88-2b7c925284bmr3856136eec.6.1769930044963;
        Sat, 31 Jan 2026 23:14:04 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm17419076eec.17.2026.01.31.23.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 23:14:04 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: wqu@suse.com,
	boris@bur.io,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH stable 6.10-6.16] btrfs: prevent use-after-free on folio private data in btrfs_subpage_clear_uptodate()
Date: Sat, 31 Jan 2026 23:13:46 -0800
Message-ID: <20260201071346.130641-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21270-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B136C51A0
X-Rspamd-Action: no action

This is a stable-only patch. The issue was inadvertently fixed in 6.17 [0]
as part of a refactoring, but this patch serves as a minimal targeted fix
for prior kernels.

Users of filemap_lock_folio() need to guard against the situation where
release_folio() has been invoked during reclaim but the folio was
ultimately not removed from the page cache. This patch covers one location
that was overlooked.

After acquiring the folio, use set_folio_extent_mapped() to ensure the
folio private state is valid. This is especially important in the subpage
case, where the private field is an allocated struct containing bitmap and
lock data.

Without this protection, the race below is possible:

[mm] page cache reclaim path        [fs] relocation in subpage mode
shrink_folio_list()
  folio_trylock() /* lock acquired */
  filemap_release_folio()
    mapping->a_ops->release_folio()
      btrfs_release_folio()
        __btrfs_release_folio()
          clear_folio_extent_mapped()
            btrfs_detach_subpage()
              subpage = folio_detach_private(folio)
              btrfs_free_subpage(subpage)
                kfree(subpage) /* point A */

                                   prealloc_file_extent_cluster()
                                     filemap_lock_folio()
                                       folio_try_get() /* inc refcount */
                                       folio_lock() /* wait for lock */

  if (...)
    ...
  else if (!mapping || !__remove_mapping(..))
    /*
     * __remove_mapping() returns zero when
     * folio_ref_freeze(folio, refcount) fails /* point B */
     */
    goto keep_locked /* folio remains in cache */

keep_locked:
  folio_unlock(folio) /* lock released */

                                   /* lock acquired */
                                   btrfs_subpage_clear_uptodate()
                                     /* use-after-free */
                                     subpage = folio_get_private(folio)

Fixes: 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially overwriting last page data")
Cc: stable@vger.kernel.org # 6.10-6.16
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

[0] 4e346baee95f ("btrfs: reloc: unconditionally invalidate the page cache for each cluster")
---
v2:
 - comment text formatting
 - renamed subject from "prevent use-after-free prealloc_file_extent_cluster()"

v1:
 - https://lore.kernel.org/all/20260131185335.72204-1-inwardvessel@gmail.com/

 fs/btrfs/relocation.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0d5a3846811a..43e8c331168e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2811,6 +2811,20 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 		 * will re-read the whole page anyway.
 		 */
 		if (!IS_ERR(folio)) {
+			/*
+			 * release_folio() could have cleared the folio private data
+			 * while we were not holding the lock. Reset the mapping if
+			 * needed so subpage operations can access a valid private
+			 * folio state.
+			 */
+			ret = set_folio_extent_mapped(folio);
+			if (ret) {
+				folio_unlock(folio);
+				folio_put(folio);
+
+				return ret;
+			}
+
 			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
 					round_up(i_size, PAGE_SIZE) - i_size);
 			folio_unlock(folio);
-- 
2.52.0


