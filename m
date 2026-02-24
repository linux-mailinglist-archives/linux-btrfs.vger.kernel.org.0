Return-Path: <linux-btrfs+bounces-21900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO1OB2wlnmn5TgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21900-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:25:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932418D1D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C86A3018D6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEA344D86;
	Tue, 24 Feb 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OJppZ9Pq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVBqZVTY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C233A9ED
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971941; cv=none; b=WWQW5G/7mDcZmuSAGBvhJZ6mbQksjaFbpz8SIEdmyKsJ6viBGrMdWdqYeobG1ReTMONMPEptrfQmvBcpj9hTrjgmi0izF1x6z+KT1gIpQfWBEPSjkDYIerpEQYQ/wY7vkbzLRHWoiJKzoykvz1xkW9KFQzJ5Er/MkxRAAs8I1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971941; c=relaxed/simple;
	bh=4J2253Qb0xVSyOnFVIc5mFEic7JpvSwjiirmg61irsI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VYRH1i/9FFrxUgd75pVD8rTrl6+l0JMxSwzpB7gUNkDfwJELCD62lGjBpWld+1aI2uZ2Cyigfor8bWQXZXsql7fIkaG9mqGGrgANoi9hll3EZNih/NdUTjvrar18hJCntqalnUu9kH59vYLLpQfUTZXNy2rsQqKSzQ5cC7pDYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OJppZ9Pq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVBqZVTY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9213A14000AE;
	Tue, 24 Feb 2026 17:25:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 17:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1771971938; x=1772058338; bh=MOweG00spcjpdEyx+cIqQ
	uUyRy/6vaCIEAfxxiCc+9I=; b=OJppZ9Pqk92cpiEW2kkqNbQA+NdtbPLOwLMGs
	fbLyBJXw9w1+xXKDL6XQFq6EXoc1805dcbzGntq3ksLGWkv8cD0OKzkJ+tXA12bV
	YJYXtkneMYduA3VhLdxMIHrcQf2OAty/USLbsaPk7zScCWb76EAyWVp/grBRx79D
	gYVRx796ChHmRaKPmX4qwSWYzZi9PwuTbNwUd3RXCjD+laGpXjOcTTtMNU5sam0B
	1rus+3kydMtSWV7SOqhD98S0avPWKxtjUxBERBEIOPyZnX+sdS4VMNSlouQWbiWz
	onviXqve6puH9MSxAK6py/a7IihQe46+G2tw7gBU+AUjqFgoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771971938; x=1772058338; bh=MOweG00spcjpdEyx+cIqQuUyRy/6vaCIEAf
	xxiCc+9I=; b=VVBqZVTYK5h4i1gfv0BOYEfNmVVu9siyhjPoR6w9cokFhKmmkcL
	8jMwYFPKckDEbUaaDJzd9onO1UvyPzAD9I0fFz8TbRpjPq07hqx/Pvd20hjy5RYW
	dqTLqfUe0YV3SMTIQkk8oK/tlPNhlzQdf6yG1DZV7rHhU+bV52WsMRDF6PhFhVPr
	ghsMa9dlp1NFQfqReqfIGPdy4nBdCD9uyxotwNuxle9Bgo2Bx9j2qtLvBTR0qFr2
	K8oP5DOQ2rdNOVU8gT674Nm6yLsvSPQgLIT0icZ9sbLX5eLwyhwDNxksv+Qb/BEd
	2VlW/uOVqS+p2Ntpjw3+V9oPAuHVWAu3nnw==
X-ME-Sender: <xms:YiWeab00s590k-p6-eRlnQuRSLQP189DrQ-UB33VW7VC84_NNcTstg>
    <xme:YiWeaQHifl0nW3AHvBAopOc-71dnYZIBhRxaEXdSvt5BivSP6CMTci2sXMTtC96a6
    dlbp_mkNLmrj9AJKnL3J4FpeXNEs_98PECP98e8tf-11zk6gI2RzNo>
X-ME-Received: <xmr:YiWeaZgWSDlRPjlHS-cpGsYxrXz9WM0-ri7iu02HDIZ2Ipr8I3ROPKpSm7ztihQXMqUgfpOvIfwiSAaibHA7gNBNftQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfe
    ekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:YiWeab93-POhUO9w741qiJ-rMasQ0ob_BcHnYwKJ2DyF_PcxzecIsg>
    <xmx:YiWeaQoUOwwhi8KlSMj5JCPu88XTYZ_0CO0-BKGcYOY1SnoWYj5-zA>
    <xmx:YiWeaa9v-AtMk-DCyYa1o1mbOMHbgp9zpZpQUW6PnLQjOR0i5Uqp2g>
    <xmx:YiWeaUV6B-AewtIWFT4dpPDhAM48m_FkmCPsT4r2YZk8Mv84zgMR6w>
    <xmx:YiWeaVYprllZ2OewLf5oJXaqxJuydKT3YVf8XdoQZtORgMXyR0bRTEFU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:25:38 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/1] btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create
Date: Tue, 24 Feb 2026 14:25:35 -0800
Message-ID: <14fc2404e55d99e9d3a4f95e3e825678dc2422a0.1771971643.git.boris@bur.io>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21900-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3932418D1D2
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

btrfs_lookup
btrfs_lookup_dentry
btrfs_orphan_cleanup // prints that message and returns -ENOENT

After some detailed inspection of the internal state, it became clear
that:
- there are no orphan items for the subvol
- the subvol is otherwise healthy looking, it is not half-deleted or
  anything, there is no drop progress, etc.
- the subvol was created a while ago and does the meaningful first
  btrfs_orphan_cleanup() call that sets BTRFS_ROOT_ORPHAN_CLEANUP much
  later.
- after btrfs_orphan_cleanup() fails, btrfs_lookup_dentry() returns -ENOENT,
  which results in a negative dentry for the subvolume via
  d_splice_alias(NULL, dentry), leading to the observed behavior. The
  bug can be mitigated by dropping the dentry cache, at which point we
  can successfully delete the subvolume if we want.

i.e.,
btrfs_lookup()
  btrfs_lookup_dentry()
    if (!sb_rdonly(inode->vfs_inode)->vfs_inode)
    btrfs_orphan_cleanup(sub_root)
      test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
      btrfs_search_slot() // finds orphan item for inode N
      ...
      prints "could not do orphan cleanup -2"
  if (inode == ERR_PTR(-ENOENT))
    inode = NULL;
  return d_splice_alias(NULL, dentry) // NEGATIVE DENTRY for valid subvolume

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
parts, the following three diagrams show the complete picture.
(Only the second and third are races)

Phase 1:
Create Subvol in dentry cache without BTRFS_ROOT_ORPHAN_CLEANUP set

btrfs_mksubvol()
  lookup_one_len()
    __lookup_slow()
      d_alloc_parallel()
        __d_alloc() // d_lockref.count = 1
  create_subvol(dentry)
    // doesn't touch the bit..
    d_instantiate_new(dentry, inode) // dentry in cache with d_lockref.count == 1

Phase 2:
Create a delayed iput for a file in the subvol but leave the subvol in
state where its dentry can be evicted (d_lockref.count == 0)

T1 (task)                    T2 (writeback)                   T3 (OE workqueue)

write() // dirty pages
                              btrfs_writepages()
                                btrfs_run_delalloc_range()
                                  cow_file_range()
                                    btrfs_alloc_ordered_extent()
                                      igrab() // i_count: 1 -> 2
btrfs_unlink_inode()
  btrfs_orphan_add()
close()
  __fput()
    dput()
      finish_dput()
        __dentry_kill()
          dentry_unlink_inode()
            iput() // 2 -> 1
          --parent->d_lockref.count // 1 -> 0; evictable
                                                                finish_ordered_fn()
                                                                  btrfs_finish_ordered_io()
                                                                    btrfs_put_ordered_extent()
                                                                      btrfs_add_delayed_iput()

Phase 3:
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
Changelog:
v2:
- fixed some typographical errors in the commit message.
- improved the commit message with more callstacks / details.

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


