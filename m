Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603912E7CD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL3Vqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 16:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Vqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 16:46:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44DC06179B
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 13:45:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a6so6015185wmc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 13:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hejGp/yRbA6hp815CuUAcWvhSqi6grOi4WyEZLC03I=;
        b=Ej5EeHt+PNhKbByRPoyd1xDzwSr3TwVeXoLII2J3p5d99xCxJeG2acnzPd8kIj7MhA
         P6LwDlFpcyICg1IDVgGaAu//qxvXwd0NWmd1rpe89yCuAh/SP6jNcI5mksSvJ2cEaxyB
         WGGYvvcUvJZK6Afrx7XkFhmwnZvoP2ciCuTps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hejGp/yRbA6hp815CuUAcWvhSqi6grOi4WyEZLC03I=;
        b=TF/IqTjmef3FAOkVw669DrQijDy5XJ2t21oedG0ziJFcQQPKYsBFDj1aTE7IPkoX3F
         UrU9Od8AB+i6HlHz9IZ0Sit7p2Ft0Ck+XAIyJIyLSMJTc/5LjQx+PzgZT2XR23de/mic
         iyE05CypIH6syTlYTCac7Nd77WhNHx9vCICVkxCLE+KDaUoeTJojQW9nThzXUqJ7DKDF
         A7/9OxQz7mBqWW9Ydk+GoryaeYVhpgZn/rvoG1LFdRehAOt6r2RZjx3J1k8QBxNI1ozk
         zIQqpDxKHeSiUm/7Fm13oLLAgbpeynkC1vJRb6lRCCXzwDeSUq1hS6YZUgtJDbqiXo9R
         wFEw==
X-Gm-Message-State: AOAM5310Cg/W74DUnOZMmAsGVGd8gYuAkAqAGwUAp6NNFR0aDMbTgypT
        nFNy/R5YTMj5L83Qh3TJ/V8Cag==
X-Google-Smtp-Source: ABdhPJwcjksapBBfKUFh6a0gYI4XOMiYf8GRZS0iWdz7BEKXiWRLf+0F8tTcBQgSWmQJiyXOW1nXag==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr9203607wmm.80.1609364757418;
        Wed, 30 Dec 2020 13:45:57 -0800 (PST)
Received: from dev.cfops.net (165.176.200.146.dyn.plus.net. [146.200.176.165])
        by smtp.gmail.com with ESMTPSA id r7sm8749894wmh.2.2020.12.30.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 13:45:56 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name, stable@vger.kernel.org
Subject: [PATCH v2 1/2] dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
Date:   Wed, 30 Dec 2020 21:45:19 +0000
Message-Id: <20201230214520.154793-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201230214520.154793-1-ignat@cloudflare.com>
References: <20201230214520.154793-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 39d42fa96ba1b7d2544db3f8ed5da8fb0d5cb877 made it possible for some code
paths in dm-crypt to be executed in softirq context, when the underlying driver
processes IO requests in interrupt/softirq context.

In this case sometimes when allocating a new crypto request we may get a
stacktrace like below:

[  210.103008][    C0] BUG: sleeping function called from invalid context at mm/mempool.c:381
[  210.104746][    C0] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2602, name: fio
[  210.106599][    C0] CPU: 0 PID: 2602 Comm: fio Tainted: G        W         5.10.0+ #50
[  210.108331][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[  210.110212][    C0] Call Trace:
[  210.110921][    C0]  <IRQ>
[  210.111527][    C0]  dump_stack+0x7d/0xa3
[  210.112411][    C0]  ___might_sleep.cold+0x122/0x151
[  210.113527][    C0]  mempool_alloc+0x16b/0x2f0
[  210.114524][    C0]  ? __queue_work+0x515/0xde0
[  210.115553][    C0]  ? mempool_resize+0x700/0x700
[  210.116586][    C0]  ? crypt_endio+0x91/0x180
[  210.117479][    C0]  ? blk_update_request+0x757/0x1150
[  210.118513][    C0]  ? blk_mq_end_request+0x4b/0x480
[  210.119572][    C0]  ? blk_done_softirq+0x21d/0x340
[  210.120628][    C0]  ? __do_softirq+0x190/0x611
[  210.121626][    C0]  crypt_convert+0x29f9/0x4c00
[  210.122668][    C0]  ? _raw_spin_lock_irqsave+0x87/0xe0
[  210.123824][    C0]  ? kasan_set_track+0x1c/0x30
[  210.124858][    C0]  ? crypt_iv_tcw_ctr+0x4a0/0x4a0
[  210.125930][    C0]  ? kmem_cache_free+0x104/0x470
[  210.126973][    C0]  ? crypt_endio+0x91/0x180
[  210.127947][    C0]  kcryptd_crypt_read_convert+0x30e/0x420
[  210.129165][    C0]  blk_update_request+0x757/0x1150
[  210.130231][    C0]  blk_mq_end_request+0x4b/0x480
[  210.131294][    C0]  blk_done_softirq+0x21d/0x340
[  210.132332][    C0]  ? _raw_spin_lock+0x81/0xd0
[  210.133289][    C0]  ? blk_mq_stop_hw_queue+0x30/0x30
[  210.134399][    C0]  ? _raw_read_lock_irq+0x40/0x40
[  210.135458][    C0]  __do_softirq+0x190/0x611
[  210.136409][    C0]  ? handle_edge_irq+0x221/0xb60
[  210.137447][    C0]  asm_call_irq_on_stack+0x12/0x20
[  210.138507][    C0]  </IRQ>
[  210.139118][    C0]  do_softirq_own_stack+0x37/0x40
[  210.140191][    C0]  irq_exit_rcu+0x110/0x1b0
[  210.141151][    C0]  common_interrupt+0x74/0x120
[  210.142171][    C0]  asm_common_interrupt+0x1e/0x40
[  210.143206][    C0] RIP: 0010:_aesni_enc1+0x65/0xb0
[  210.144313][    C0] Code: 38 dc c2 41 0f 28 52 d0 66 0f 38 dc c2 41 0f 28 52 e0 66 0f 38 dc c2 41 0f 28 52 f0 66 0f 38 dc c2 41 0f 28 12 66 0f 38 dc c2 <41> 0f 28 52 10 66 0f 38 dc c2 41 0f 28 52 20 66 0f 38 dc c2 41 0f
[  210.148542][    C0] RSP: 0018:ffff88810dbe6db0 EFLAGS: 00000286
[  210.149842][    C0] RAX: ffffffff9a90cdc0 RBX: 0000000000000000 RCX: 0000000000000200
[  210.151576][    C0] RDX: ffff888101e5f240 RSI: ffff888101e5f240 RDI: ffff8881111b5020
[  210.153339][    C0] RBP: ffff88810dbe6e20 R08: 0000000000000000 R09: 0000000000000020
[  210.155063][    C0] R10: ffff8881111b5090 R11: 1ffff11021b7cdcc R12: ffffffff9e87cd40
[  210.156791][    C0] R13: ffff8881111b5210 R14: ffff888101e5f0d8 R15: 0000000000000000
[  210.158497][    C0]  ? aesni_set_key+0x1e0/0x1e0
[  210.159523][    C0]  ? aesni_enc+0xf/0x20
[  210.160408][    C0]  ? glue_xts_req_128bit+0x181/0x6f0
[  210.161571][    C0]  ? aesni_set_key+0x1e0/0x1e0
[  210.162560][    C0]  ? glue_ctr_req_128bit+0x630/0x630
[  210.163706][    C0]  ? kasan_save_stack+0x37/0x50
[  210.164761][    C0]  ? kasan_save_stack+0x20/0x50
[  210.165786][    C0]  ? get_page_from_freelist+0x2052/0x36a0
[  210.167024][    C0]  ? __blkdev_direct_IO_simple+0x43b/0x7e0
[  210.168288][    C0]  ? blkdev_direct_IO+0xd16/0x1020
[  210.169396][    C0]  ? generic_file_direct_write+0x1a3/0x480
[  210.170648][    C0]  ? __generic_file_write_iter+0x1d9/0x530
[  210.171882][    C0]  ? blkdev_write_iter+0x20d/0x3e0
[  210.172954][    C0]  ? vfs_write+0x524/0x770
[  210.173889][    C0]  ? do_syscall_64+0x33/0x40
[  210.174859][    C0]  ? __zone_watermark_ok+0x340/0x340
[  210.175977][    C0]  ? crypt_convert+0x28b6/0x4c00
[  210.177079][    C0]  ? mempool_alloc+0x107/0x2f0
[  210.178096][    C0]  ? crypt_iv_tcw_ctr+0x4a0/0x4a0
[  210.179193][    C0]  ? bio_add_page+0x111/0x170
[  210.180251][    C0]  ? __bio_try_merge_page+0x480/0x480
[  210.181446][    C0]  ? bio_associate_blkg+0x6d/0x100
[  210.182558][    C0]  ? kcryptd_crypt_write_convert+0x5ea/0x980
[  210.183852][    C0]  ? crypt_map+0x5bf/0xc80
[  210.184838][    C0]  ? bio_clone_blkg_association+0x10e/0x2c0
[  210.186125][    C0]  ? __map_bio.isra.0+0x109/0x3f0
[  210.187204][    C0]  ? __split_and_process_non_flush+0x7f9/0xc50
[  210.188560][    C0]  ? __send_empty_flush+0x2d0/0x2d0
[  210.189697][    C0]  ? __part_start_io_acct+0x70/0x2d0
[  210.190842][    C0]  ? dm_submit_bio+0x4d8/0xe40
[  210.191845][    C0]  ? __split_and_process_non_flush+0xc50/0xc50
[  210.193201][    C0]  ? submit_bio_noacct+0x2b9/0xe50
[  210.194313][    C0]  ? blk_queue_enter+0x6d0/0x6d0
[  210.195372][    C0]  ? __bio_add_page+0x246/0x3d0
[  210.196418][    C0]  ? bio_iov_iter_get_pages+0x7dd/0xbe0
[  210.197611][    C0]  ? submit_bio+0xe2/0x460
[  210.198481][    C0]  ? submit_bio_noacct+0xe50/0xe50
[  210.199496][    C0]  ? free_unref_page_commit.constprop.0+0x130/0x330
[  210.200825][    C0]  ? __blkdev_direct_IO_simple+0x43b/0x7e0
[  210.202050][    C0]  ? bd_link_disk_holder+0x690/0x690
[  210.203239][    C0]  ? put_pages_list+0x210/0x210
[  210.204341][    C0]  ? scan_shadow_nodes+0xb0/0xb0
[  210.205472][    C0]  ? _raw_write_lock_irqsave+0xe0/0xe0
[  210.206698][    C0]  ? bd_may_claim+0xc0/0xc0
[  210.207715][    C0]  ? zero_user_segments.constprop.0+0x2e0/0x2e0
[  210.209092][    C0]  ? blkdev_direct_IO+0xd16/0x1020
[  210.210200][    C0]  ? pagevec_lookup_range_tag+0x28/0x60
[  210.211416][    C0]  ? __filemap_fdatawait_range+0xc4/0x1f0
[  210.212669][    C0]  ? page_cache_next_miss+0x1e0/0x1e0
[  210.213842][    C0]  ? generic_file_buffered_read+0x520/0x9e0
[  210.215128][    C0]  ? delete_from_page_cache_batch+0x850/0x850
[  210.216470][    C0]  ? bd_abort_claiming+0xd0/0xd0
[  210.217531][    C0]  ? file_remove_privs+0x74/0x430
[  210.218589][    C0]  ? filemap_check_errors+0x50/0xe0
[  210.219705][    C0]  ? generic_file_direct_write+0x1a3/0x480
[  210.220979][    C0]  ? __generic_file_write_iter+0x1d9/0x530
[  210.222238][    C0]  ? blkdev_write_iter+0x20d/0x3e0
[  210.223328][    C0]  ? bd_unlink_disk_holder+0x360/0x360
[  210.224464][    C0]  ? new_sync_write+0x37b/0x620
[  210.225511][    C0]  ? new_sync_read+0x610/0x610
[  210.226539][    C0]  ? _cond_resched+0x17/0x80
[  210.227539][    C0]  ? inode_security+0x58/0x100
[  210.228582][    C0]  ? security_file_permission+0x54/0x450
[  210.229796][    C0]  ? vfs_write+0x524/0x770
[  210.230758][    C0]  ? __x64_sys_pwrite64+0x197/0x1f0
[  210.231890][    C0]  ? vfs_write+0x770/0x770
[  210.232869][    C0]  ? do_syscall_64+0x33/0x40
[  210.233839][    C0]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by allocating crypto requests with GFP_ATOMIC mask in interrupt context

Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/md/dm-crypt.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 53791138d78b..e4fd690c70e1 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1454,13 +1454,16 @@ static int crypt_convert_block_skcipher(struct crypt_config *cc,
 static void kcryptd_async_done(struct crypto_async_request *async_req,
 			       int error);
 
-static void crypt_alloc_req_skcipher(struct crypt_config *cc,
+static int crypt_alloc_req_skcipher(struct crypt_config *cc,
 				     struct convert_context *ctx)
 {
 	unsigned key_index = ctx->cc_sector & (cc->tfms_count - 1);
 
-	if (!ctx->r.req)
-		ctx->r.req = mempool_alloc(&cc->req_pool, GFP_NOIO);
+	if (!ctx->r.req) {
+		ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
+		if (!ctx->r.req)
+			return -ENOMEM;
+	}
 
 	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);
 
@@ -1471,13 +1474,18 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
 	skcipher_request_set_callback(ctx->r.req,
 	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
+
+	return 0;
 }
 
-static void crypt_alloc_req_aead(struct crypt_config *cc,
+static int crypt_alloc_req_aead(struct crypt_config *cc,
 				 struct convert_context *ctx)
 {
-	if (!ctx->r.req_aead)
-		ctx->r.req_aead = mempool_alloc(&cc->req_pool, GFP_NOIO);
+	if (!ctx->r.req) {
+		ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
+		if (!ctx->r.req)
+			return -ENOMEM;
+	}
 
 	aead_request_set_tfm(ctx->r.req_aead, cc->cipher_tfm.tfms_aead[0]);
 
@@ -1488,15 +1496,17 @@ static void crypt_alloc_req_aead(struct crypt_config *cc,
 	aead_request_set_callback(ctx->r.req_aead,
 	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req_aead));
+
+	return 0;
 }
 
-static void crypt_alloc_req(struct crypt_config *cc,
+static int crypt_alloc_req(struct crypt_config *cc,
 			    struct convert_context *ctx)
 {
 	if (crypt_integrity_aead(cc))
-		crypt_alloc_req_aead(cc, ctx);
+		return crypt_alloc_req_aead(cc, ctx);
 	else
-		crypt_alloc_req_skcipher(cc, ctx);
+		return crypt_alloc_req_skcipher(cc, ctx);
 }
 
 static void crypt_free_req_skcipher(struct crypt_config *cc,
@@ -1539,7 +1549,10 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 
 	while (ctx->iter_in.bi_size && ctx->iter_out.bi_size) {
 
-		crypt_alloc_req(cc, ctx);
+		r = crypt_alloc_req(cc, ctx);
+		if (r)
+			return BLK_STS_RESOURCE;
+
 		atomic_inc(&ctx->cc_pending);
 
 		if (crypt_integrity_aead(cc))
-- 
2.20.1

