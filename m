Return-Path: <linux-btrfs+bounces-21223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OelNL4boe2mcJQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21223-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 00:08:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F5B5977
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 00:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546A63009F8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634F37418E;
	Thu, 29 Jan 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfHs7d/w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1E367F2A
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728118; cv=none; b=KvfPYHl19XExdOzmIUacLKXGcb309c3EpvtuRVy5Rb7/e1bhJeFEZvKfgb8XsYdu+GGKiwg+oDyXjHaeRTNQ4bkpSPTMcEf2gS6Os58fe381d7JIPtVHDCp4P++BZRhQ5LDQaU8wmOD+qqqRpyb4pTV62yhC2d9+0nAMSN99dAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728118; c=relaxed/simple;
	bh=l8A7Bb0Ah9P57uxJNkSy88Hx3ejJGD+DmCE0mmVuvfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhGopN6Cq3wwbVmHfoLUVATFtBKF7i/62JkreBb8sI4bo8fXy01+GHYcKaCldMZBf/jVXrHwjkMJ+pbT7X/HNY0jNSBLD5AlfPKZ5JsZTPR3RrVCgrS8IEH1FAGNk79arzBrL7ZMl5eCK7/HETFSU7VIIBazignJT+/1hYuojHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfHs7d/w; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233bc1117fso1788101c88.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 15:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728116; x=1770332916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sh7b3TT+ztYyRiJ7tIzVvf9puY7sLF3p/pWLZb/u1QM=;
        b=mfHs7d/wk4KVyFC08hjD+9sjAJf+ZSjm0QjE5NPfxOeCznsKFpQRyj3Nl5yDNIUQVM
         /gKg0A2hm1dxQlf14eR1RvnTVEI6g83MpFeYdrIWm8J3xU0Jfvq3793r7y/5qcGLFK1J
         xwrsZ6aAbsM6RbK2R04O6wUAReIUbrN8S2jygYf366emN/LoXGF3epYj1Nb/ujZ0yBxL
         6Z30ePKR0xEPKrYnMRNmYYEutJlwxYLyTSK+nR/f1z7D9sOHTLUFs766cqunTEPYQtD+
         KJuYf8+XM2R7+Lp5PMteU/A9IzSc9gptCq6uD25KAu8fd5vPwXq2CBmqCZOhTKpb8eLk
         xcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728116; x=1770332916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh7b3TT+ztYyRiJ7tIzVvf9puY7sLF3p/pWLZb/u1QM=;
        b=W9cJuP5bgenO9bvJB9x/x5RucqbWVPmHomcTD4Xufb2QZ6SO+5++h/o2uU4UfW7tQv
         D4CA3xO0dp8zZhGZKROfg2CVeLnBbUi41Fusv4iDKKX+pixIixwlCuW3mQsD4vdowtGt
         UeASw4csAnNBy+mdwbpQG5Lmt8AKgWU98hga4xy5b2hmr5DL274ZxXJ/gQwGImG/Coei
         Z9faLiLTFrLlH5vPzZj6u3zlScW41+f58OmbLwL/KRDum1Ozrtyo5/BYC4XxerXFz1/t
         +MJMjL/jFAhcG8TTR/sDYKPwhM9dRHxIzq3moSjtk6gbOl7S7jwhJEuPeyoedwi/BMCE
         QKlg==
X-Gm-Message-State: AOJu0Yy9EMyKWAZ+nm7dc9sS2u7tos7f5SYLFmB/Wwa03YhKLooK54/A
	KJohKT+tETJY/Zjm6e6AnSMcUqid+sQMOmNOCzaoXcMMjl7Ib/PcLxDO
X-Gm-Gg: AZuq6aLJji2lDT1y7pczMMu//iQ3b+Nk6xxSMKb8jC+fZEpJqjAAlSBlhBYxomFpyVs
	jLgss5rvTPrPqcfX9P2fV6pFtsCIMPVI4VnI1ILr1JMS3PgkCvz1Nh9S4DPiynlbT/lA7uKMou3
	uZ7iThrJHOnxWqFLEH6XA4dyfSgFgFGA2l9KbbsBWPdUqG0rsiZwjympzVYtof1LnYed2ZWVSDZ
	4lr7t8HqYMD0g3Jr4wVD8g6akO2vCn/JB4ixsaVYH7yM/C1zVncOR8Cy2R5qRPS2KTJ9VsDwk5o
	fcSZ4043T2SpY/P9EydVtrmaO05bIjkaFX8359yPTJeKFTFNt9lVRcD6yZ3NZu71tWmOhYS9Rzf
	kV36dE107+Sp80qAec/IeiWVkm8A7UDT8k4Au2fB/RbG6U3gvoo2hJTqQiDs03+Lp8w8EGem4L3
	mA5BhNOO487cG7RQVauHa6ReuUPGy2y7LWPV75jIk=
X-Received: by 2002:a05:7300:f108:b0:2b7:1dd3:585b with SMTP id 5a478bee46e88-2b7b17a83bfmr2020423eec.7.1769728115855;
        Thu, 29 Jan 2026 15:08:35 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::2:15ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88dasm9511691eec.32.2026.01.29.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:08:35 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: boris@bur.io,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH] btrfs: defer freeing of subpage private state to free_folio
Date: Thu, 29 Jan 2026 15:08:22 -0800
Message-ID: <20260129230822.168034-1-inwardvessel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21223-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 189F5B5977
X-Rspamd-Action: no action

During reclaim, file-mapped folio callbacks can be invoked through the
address_space_operations "aops" interface. In one specific case involving
btrfs, the release_folio() callback is made and the btrfs-specific private
data is freed. Afterward, continuing in the reclaim path, the folio will be
freed from the page cache if its refcount has reached zero. Because there
is a window between the freeing of the private data and the refcount check,
it is possible for another task to increment the refcount in parallel and
the folio will remain in the page cache with NULL private data. The other
task then acquires the folio and is forced to take precautions on accessing
the private field.

There is existing code that is aware of this. In some of these places, a
NULL check is performed on the private field and if not present it gets
recreated. There are surrounding comments referring to the race of freeing
the private data. For example:

/*
 * We unlock the page after the io is completed and then re-lock it
 * above.  release_folio() could have come in between that and cleared
 * folio private, but left the page in the mapping.  Set the page mapped
 * here to make sure it's properly set for the subpage stuff.
 */
ret = set_folio_extent_mapped(folio);

It's worth noting in advance that the protections currently in place and
also the points in which btrfs invokes filemap_invalidate_inode() may be
sufficient. The purpose of this patch though, is to ensure the btrfs
private subpage metadata lives as long as its folio, which may help avoid
the loss of subpage metadata and improve maintainability (by preventing any
possible use after free in present/future code). Currently the private data
is freed in the btrfs-specific aops callback release_folio(), but this
proposed change instead defers the freeing until the aops free_folio()
callback.

The patch also might have the advantage of being easy to backport to the
LTS trees. On that note, it's worth mentioning that we encountered a kernel
panic as a result of this sequence on a 6.16-based arm64 host (configured
with 64k pages so btrfs is in subpage mode). On our 6.16 kernel, the race
window is shown below between points A and B:

[mm] page cache reclaim path        [fs] relocation in subpage mode
shrink_folio_list()
  folio_trylock() /* lock acquired */
  filemap_release_folio()
    mapping->a_ops->release_folio()
      btrfs_release_folio()
        __btrfs_release_folio()
          clear_folio_extent_mapped()
            btrfs_detach_folio_state()
              bfs = folio_detach_private(folio)
              btrfs_free_folio_state(folio)
                kfree(bfs) /* point A */

                                   prealloc_file_extent_cluster()
                                     filemap_lock_folio()
                                       folio_try_get() /* inc refcount */
                                       folio_lock() /* wait for lock */

  __remove_mapping()
    if (!folio_ref_freeze(folio, refcount)) /* point B */
      goto cannot_free /* folio remains in cache */

  folio_unlock(folio) /* lock released */

                                   /* lock acquired */
                                   btrfs_subpage_clear_updodate()
                                     bfs = folio->priv /* use-after-free */

This exact race during relocation should not occur in the latest upstream
code, but it's an example of a backport opportunity for this patch.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 fs/btrfs/extent_io.c |  6 ++++--
 fs/btrfs/inode.c     | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3df399dc8856..d83d3f9ae3af 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -928,8 +928,10 @@ void clear_folio_extent_mapped(struct folio *folio)
 		return;
 
 	fs_info = folio_to_fs_info(folio);
-	if (btrfs_is_subpage(fs_info, folio))
-		return btrfs_detach_folio_state(fs_info, folio, BTRFS_SUBPAGE_DATA);
+	if (btrfs_is_subpage(fs_info, folio)) {
+		/* freeing of private subpage data is deferred to btrfs_free_folio */
+		return;
+	}
 
 	folio_detach_private(folio);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8abfe7439a3..7a832ee3b591 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7565,6 +7565,23 @@ static bool btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 	return __btrfs_release_folio(folio, gfp_flags);
 }
 
+/* frees subpage private data if present */
+static void btrfs_free_folio(struct folio *folio)
+{
+	struct btrfs_folio_state *bfs;
+
+	if (!folio_test_private(folio))
+		return;
+
+	bfs = folio_detach_private(folio);
+	if (bfs == (void *)EXTENT_FOLIO_PRIVATE) {
+		/* extent map flag is detached in btrfs_folio_release */
+		return;
+	}
+
+	btrfs_free_folio_state(bfs);
+}
+
 #ifdef CONFIG_MIGRATION
 static int btrfs_migrate_folio(struct address_space *mapping,
 			     struct folio *dst, struct folio *src,
@@ -10651,6 +10668,7 @@ static const struct address_space_operations btrfs_aops = {
 	.invalidate_folio = btrfs_invalidate_folio,
 	.launder_folio	= btrfs_launder_folio,
 	.release_folio	= btrfs_release_folio,
+	.free_folio = btrfs_free_folio,
 	.migrate_folio	= btrfs_migrate_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.error_remove_folio = generic_error_remove_folio,
-- 
2.47.3


