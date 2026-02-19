Return-Path: <linux-btrfs+bounces-21791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iChWOr9ml2nfxwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21791-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 20:38:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD94162129
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 20:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F5F30156D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FD3093BB;
	Thu, 19 Feb 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="v73HNVbK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLz7sLwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A82FFF9B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529912; cv=none; b=OS8SXPDLDZg9O1QnsnpOmdeGzZDcQRpltyXt3gGUIXv2dMN7+Vtt1dJFUQbGTExfpI6fW+ZtRXejP4S3x7s2NRc9c2zggyy+1djUrUegDaILT5ki/E53VnLHba7osQi/2CkJlgsvstyfGb4E42ompC+0vF5mKZcXs01rr2qo7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529912; c=relaxed/simple;
	bh=hyMnbRhGsVhQzCDK2bAHa42aGyaQI/rzUt1IjdBBYFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dJ8UZVYVY3+LRnzcOfCpbhdP5Sho8d3DmeJW3c3UAT0LkNcwd+Hv7U2hSurkTok9UmqqDwXAH2jUBUybHiJEFF4pFkc5chtkvmCNplSWPv8uvklTIRHlyp+bogC9/YS7cj0eVolCKp+tbdcQbW/UZE2Ew4iVIDpPfN/Pl6lnaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=v73HNVbK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLz7sLwQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F2601D000EB;
	Thu, 19 Feb 2026 14:38:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 14:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1771529909; x=1771616309; bh=5qEjA31tw1FnnoOZKDCMG
	xtBYA1WGjFjVn91/3kGbLM=; b=v73HNVbKCB4c6pPhg6OwSETaTGO5Jyu3abEZM
	hSt/Se31pvCSmSDt7rzDSoJGwG2D10trZaAPnEZI842WWYtPwGTCB+QlRZylKBDQ
	m0/IbSqDSj/yiCykds7QHhuHX5Hje/BZ8fuQMAxQn7F50WCUepddOkFrLQtxioKE
	Qn7uUNVgTeiI/LGk6tMa+GWyeytWJmXesDchW3GXZLa2lBmtzVSQZSL5hn+K0SkR
	1747Xf25p++Sf32SRhF3MOZgz+GiuzQ34MAiv8cQvL1YSjK53ja5UmOUIAxxboAq
	RI9gv8/tpUn08BW7ba8/lxYgzuGmIRa+EUbb3S7NtGDYZOn1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771529909; x=1771616309; bh=5qEjA31tw1FnnoOZKDCMGxtBYA1WGjFjVn9
	1/3kGbLM=; b=nLz7sLwQHbp6hebQ1XUENH170TGhOskThXFFvG23YnYQnhQEY5q
	5bS08Xig1xHuiu59E1nZHMPLwiUP5UXZcRZFMlbflDqvgKOqaV4onBhejecEgQLF
	AvbC6f6k5pPwWVM/d95J/8lXvnIpCAHnCOSSM1j98Dy5gi59zSmV5Ihrsoe1Tc3E
	CR8X5Hklb1G15i2TZh5XyIV8/ogXHpKUvOWdmrorK43ILXXDAF8wfo/oSx052pef
	3XgzNEmqOtKTuXrvHY2g4xTFZmvWP3e+gdaSD6wisALaCiwQ2RftdzBpahH6MJLQ
	9HDWdv8uBl2OjHiwsfi0J6EmqQMupsRQ8RA==
X-ME-Sender: <xms:tWaXaf1W7flhz3KhJuiSQwYDfL4dJRqKq4kmU0oQ7YEt79VWNMGUGg>
    <xme:tWaXaUH3BBZM-GZINAls_elsCEZrLNBCstPTwCyjFWpUAdrVXfmsp9xyeexhJDSmG
    xWMizHA9YHoHvg0aqj7CJFLRuacuR7pOX-kR5tKELbj-x866HHinMI>
X-ME-Received: <xmr:tWaXadiidlhw8C7_QMyEUVUZ3zonxrenmUtJWMf3P3leTkPjIJHrB3bI6ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeigedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfe
    ekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:tWaXaf-uy9dmySLDNCDeS0SwCtluMA1Pvm3i93jOywbLP5fSsiCT2Q>
    <xmx:tWaXaUoazT8b46EvLy_0N1b53_4HAYT4IedjLv3IuNsiIrWwIf0EWA>
    <xmx:tWaXae-YwnW_uk2-hb2-mKorXHO-IJjEqPezXEuoVxwANHaijsKlXA>
    <xmx:tWaXaYWKKhOS0Y_cw7WgAiGkEaQ3-J3-dpuQcYmJKpYRsSuQqj6Ocw>
    <xmx:tWaXaZZPAAhdxWYWRSGiNHTn-5KtoRHER4KBC_nnWwhOVN8GbVLdzWVW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 14:38:28 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/1] btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create
Date: Thu, 19 Feb 2026 11:38:22 -0800
Message-ID: <718a3b0c2275324b9e287af7e4434f55a4a45901.1771529877.git.boris@bur.io>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21791-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BD94162129
X-Rspamd-Action: no action

We have recently observed a number of subvolumes with broken dentries.
ls-ing the parent dir looks like:

drwxrwxrwt 1 root root 16 Jan 23 16:49 .
drwxr-xr-x 1 root root 24 Jan 23 16:48 ..
d????????? ? ?    ?     ?            ? broken_subvol

and similarly stat-ing the file fails.

In this state, deleting the subvol fails with ENOENT, but attempting to
create a new file or subvol over it errors out with EEXIST and even
aborts the fs. Which leaves us a bit stuck.

dmesg contains a single notable error message reading:
"could not do orphan cleanup -2"

2 is ENOENT and the error comes from the failure handling path of
btrfs_orphan_cleanup(), with the stack leading back up to
btrfs_lookup().

After some detailed inspection of the internal state, it became clear
that:
- there are no orphan items for the subvol
- the subvol is otherwise healthy looking, it is not half-deleted or
  anything, there is no drop progress, etc.
- the subvol was created a while ago and first does orphan_cleanup()
  much later
- after orphan_cleanup fails, btrfs_lookup_dentry() returns -ENOENT,
  which results in a negative dentry for the subvolume via
  d_splice_alias(NULL, dentry), leading to the observed behavior. The
  bug can be mitigated by dropping the dentry cache, at which point we
  can successfully delete the subvolume if we want.

btrfs_orphan_cleanup() does test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
on the root when it runs, so it cannot run more than once on a given
root, so something else must run concurrently. However, the obvious
routes to deleting an orphan when nlinks goes to 0 should not be able to
run without first doing a lookup into the subvolume, which should run
btrfs_orphan_cleanup() and set the bit.

The final important observation is that create_subvol() calls
d_instantiate_new() but does not set BTRFS_ROOT_ORPHAN_CLEANUP, so if
the dentry cache gets dropped, the next lookup into the subvolume will
make a real call into btrfs_orphan_cleanup() for the first time. This
opens up the possibility of concurrently deleting the inode/orphan items
but most typical evict() paths will be holding a reference on the parent
dentry (child dentry holds parent->d_lockref.count via dget in
d_alloc(), released in __dentry_kill()) and prevent the parent from
being removed from the dentry cache.

The one exception is delayed iputs. Ordered extent creation calls
igrab() on the inode. If the file is unlinked and closed while those
refs are held, iput() in __dentry_kill() decrements i_count but does
not trigger eviction (i_count > 0). The child dentry is freed and the
subvol dentry's d_lockref.count drops to 0, making it evictable while
the inode is still alive.

Since there are two races (the race between writeback and unlink and
the race between lookup and delayed iputs), and there are too many moving
parts, the following two diagrams show the complete picture. The first
sets us up in a condition where we can evict the subvol dentry and there
is a delayed iput on the inode:

T1 (task)                    T2 (writeback)                   T3 (OE workqueue)

write() // dirty pages
                              btrfs_writepages()
                                btrfs_run_delalloc_range()
                                  cow_file_range()
                                    btrfs_alloc_ordered_extent()
                                      igrab() // i_count: 1 -> 1+N
btrfs_unlink_inode()
  btrfs_orphan_add()
close()
  __dentry_kill()
    dentry_unlink_inode()
      iput() // 1+N -> N
    --parent->d_lockref.count
    // count -> 0
                                                                finish_ordered_fn()
                                                                  btrfs_finish_ordered_io()
                                                                    btrfs_put_ordered_extent()
                                                                      btrfs_add_delayed_iput()

Once the delayed iput is pending and the subvol dentry is evictable,
the shrinker can free it, causing the next lookup to go through
btrfs_lookup() and call btrfs_orphan_cleanup() for the first time.
If the cleaner kthread processes the delayed iput concurrently, the
two race:

  T1 (shrinker)              T2 (cleaner kthread)                          T3 (lookup)

  super_cache_scan()
    prune_dcache_sb()
      __dentry_kill()
      // subvol dentry freed
                              btrfs_run_delayed_iputs()
                                iput()  // i_count -> 0
                                  evict()  // sets I_FREEING
                                    btrfs_evict_inode()
                                      // truncation loop
                                                                            btrfs_lookup()
                                                                              btrfs_lookup_dentry()
                                                                                btrfs_orphan_cleanup()
                                                                                  // first call (bit never set)
                                                                                  btrfs_iget()
                                                                                    // blocks on I_FREEING

                                      btrfs_orphan_del()
                                      // inode freed
                                                                                    // returns -ENOENT
                                                                                  btrfs_del_orphan_item()
                                                                                    // -ENOENT
                                                                                // "could not do orphan cleanup -2"
                                                                            d_splice_alias(NULL, dentry)
                                                                            // negative dentry for valid subvol

The most straightforward fix is to ensure the invariant that a dentry
for a subvolume can exist if and only if that subvolume has
BTRFS_ROOT_ORPHAN_CLEANUP set on its root (and is known to have no
orphans or ran btrfs_orphan_cleanup()).

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b8db877be61cc..77f7db18c6ca5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,6 +672,13 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	/*
+	 * Subvolumes have orphans cleaned on first dentry lookup. A new
+	 * subvolume cannot have any orphans, so we should set the bit before we
+	 * add the subvolume dentry to the dentry cache, so that it is in the
+	 * same state as a subvolume after first lookup.
+	 */
+	set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &new_root->state);
 	d_instantiate_new(dentry, new_inode_args.inode);
 	new_inode_args.inode = NULL;
 
-- 
2.47.3


