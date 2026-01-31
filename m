Return-Path: <linux-btrfs+bounces-21262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM4lAt5PfmlRXAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21262-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 19:54:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB1C39A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F086A302E7AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8136826E;
	Sat, 31 Jan 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiPWWTNc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556D366DC9
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885632; cv=none; b=TIKdibaopj9vAXSpK0gzOA/67LRZ1Tl8+QoVu6QB6iCpnwVhUo/MQWQmkr2YFScRGeG+BnpM4HxgFRRqRF80N/ssVW5HWryOu5de7WN0/i6u/aIaYK7qDhNKaNil4FOUabIATvi/Koe36Ui6PuXnYU+7D8dm39fUd1o8fOw5E+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885632; c=relaxed/simple;
	bh=PBKpupetibXO3Ennx631NgSMEZvGpbZUn+SaHduTJlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGilflE67RGB+GtBFo4dXyYxPR3PU+L6uZO43GhAwnavocSqHLC8kyDonmMIBWUcZHyW0E/KJoDGRHVYYV93DsS6/XDQ9hP2CtJslDTuXtkZVpQY7UL9uawoeJDSV2/4aDV5F/9ZFl6YLWc39LfuzuQeNcheYq5hytr2PyDpCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiPWWTNc; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b7c5db431cso2996300eec.1
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 10:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885630; x=1770490430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTZPBapmJrq4oJtHIScdpAnX9Q/PsyNXOSyLOul7qcI=;
        b=FiPWWTNcntw0/K4ICPesB9SPTPZA6Ygrgp09jAiqy8pGDa7R9H50wHL5xUK8w/pkvX
         MY2KpB/Of7rSnqL8dJXkiSynK6FBt0sodfdgbzTR0n5MVmkPnfwtSbOfmX/xIlANof9Z
         hklR/M/2Pe0pJXB6w6NMOiUOZflyMW5JQM1KCqaCMGOOywBOxFbkqbMu2DjWTPMmlE3k
         9ZtuPx+vzbFdzxVmRQ+oF48yxjv5iy4Z+PBaXSEwAi97eHdeJxVQ2EfSB6eFsvt+VygE
         oblUr6fGBigdSFltY0A/IjY5WfLZWsL5xzNCDHZDQoQO33K51T/ZKoamBqopxMFCkGwC
         JQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885630; x=1770490430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTZPBapmJrq4oJtHIScdpAnX9Q/PsyNXOSyLOul7qcI=;
        b=br0AXGl0eAlCIg0MamQWerH7FzaMoAdjbPd+dlRnd9shIxmBdpXmZnxMiE2bGQo0nv
         HjfxVPUyY1IFnHdMSSvOsLjcDGg6NbvvUpJKDlu4cgB/6ETLC0/soweOsF7CC6p0hDeQ
         Fc62kiOzbVy6DDwXbObAWCoHWC2t+jviJS9v5kHd6tGXR7SGmT2r+K4lCnJ1Yb5jxAJn
         h21hdziq4xChww1YxWfgH3V4zVYJHjd4DVTycWEIh7k1367rDwZqABDg21SKyQV4jAXq
         /xWti2kxPGj4NdPCJuHszFFtSjOG+SrsylKDDkxJTQ2hXkcmcPc9pJMKK+4IR/RL4Ukw
         g43A==
X-Gm-Message-State: AOJu0Yz4lSLJl6wt2LqBkRnF1nK6xJ8ZCzmUnoBYTANo2R6uqnXVQv2o
	U+2JYsz5I0chu49cbFBVq1nTEFbu1K87aSrpK5viY7o229KWtkZ8pb0Q
X-Gm-Gg: AZuq6aJyvFA/3/AUu/qLj5OYzGjXAbtjIpXp57/uH0wjI86ngEfb4goBrflkhzxk3T0
	cRQYby8WWy1o0tR8TT7vK9L2sEmQ9nNBUjwkQJvPHG36duogtgZ8ySVt/Xkkml8yFnkl2pUwPp5
	4bW9JnkW/QqDHpxUFPGajIXbTC8yiV2VFyag4HviFXHOzpA83KrOsohiue/srlU/Le8aREN8pTt
	bwzozmHR5JmjVDWIgsCPvnKnREAzmG4VtyrDU1PrPlZhvsXMGo+69FV3CySTH+ngoO4/yCsCReI
	6Al/s5HZiCSQ0u1hAhF68eX4hj48Q2DQQpCcBX7JVuA3WvdW+RLmpHw7lBajxv2v+CRiPdxUfb/
	dzLHJvmEkb2AroQTUYrXxpj+FywqnNTVNgrwcytKFuizoa7W1Nn7dImHx0nboAvzLanqL6aRUTV
	JwaIiVnaYNemSaSvbuOxa5EKlamxcAuDjOSKbZOQ==
X-Received: by 2002:a05:7301:3e18:b0:2b7:4118:88aa with SMTP id 5a478bee46e88-2b7c890c90emr2980431eec.35.1769885630233;
        Sat, 31 Jan 2026 10:53:50 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a170ca0esm16355941eec.15.2026.01.31.10.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 10:53:49 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: wqu@suse.com,
	boris@bur.io,
	clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 6.12] btrfs: prevent use-after-free prealloc_file_extent_cluster()
Date: Sat, 31 Jan 2026 10:53:35 -0800
Message-ID: <20260131185335.72204-1-inwardvessel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21262-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2CB1C39A2
X-Rspamd-Action: no action

Users of filemap_lock_folio() need to guard against the situation where
release_folio() has been invoked during reclaim but the folio was
ultimately not removed from the page cache. This patch covers one location
that was overlooked. Affected code has changed as of 6.17, so this patch is
only targeting stable trees prior.

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
            btrfs_detach_folio_state()
              bfs = folio_detach_private(folio)
              btrfs_free_folio_state(folio)
                kfree(bfs) /* point A */

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
                                   btrfs_subpage_clear_updodate()
                                     bfs = folio->priv /* use-after-free */

This patch is intended as a minimal fix for backporting to affected
kernels. As of 6.17, a commit [0] replaced the vulnerable
filemap_lock_folio() + btrfs_subpage_clear_uptodate() sequence with
filemap_invalidate_inode() avoiding the race entirely. That commit was part
of a series with a different goal of preparing for large folio support so
backporting may not be straight forward.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Fixes: 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially overwriting last page data")

[0] 4e346baee95f ("btrfs: reloc: unconditionally invalidate the page cache for each cluster")
---
 fs/btrfs/relocation.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0d5a3846811a..040e8f28b200 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2811,6 +2811,20 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 		 * will re-read the whole page anyway.
 		 */
 		if (!IS_ERR(folio)) {
+			/*
+			 * release_folio() could have cleared the folio private data
+			 * while we were not holding the lock.
+			 * Reset the mapping if needed so subpage operations can access
+			 * a valid private folio state.
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


