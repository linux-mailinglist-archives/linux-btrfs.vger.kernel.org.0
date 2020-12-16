Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFABC2DC406
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLPQXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgLPQXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:42 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4FCC061248
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:33 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so11574113qvj.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZdeTl5SKwAOkQZaidN/2G3m4A3ct7/nmjyeSueqnnGU=;
        b=ujIg3r1NaPlxaHRHIRZloypFNo+YHdEDqGH3irHF1Tw9j4q6yk5ygfG3yY1egRpshE
         i7l1tHVuMmcFz4OBEr5EyC+v98mohNtAm/A2BTPAzsxTHbAU2tOtJOJud2wWvXKn73tj
         q+rTpymvVy9We3deLec2SN1IR/i7BwdD9wz3RHBaUHv6sEkpStjF0lJr1eJFTQAhbj77
         UBBXP+ShIhPbSj4A8XBNE0j3kPAh0EhRXoyQhTrDzj43EOlDFOYf+tvEOH6SSDZAoflj
         J7fN6N6vbO1ArlFxQozQTuCkEMDTUquDrX8yUoO/XIx2EecqbrzamoLQuvC3sKeeVtyi
         gCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdeTl5SKwAOkQZaidN/2G3m4A3ct7/nmjyeSueqnnGU=;
        b=gWlLD6VCb0yPQ/nPI2b25po28rwraB8ZgnptvdP4Oikbqxda/s9bCsKV1aLXekk/4i
         +oat6OVhSkHx2mOMXD+I34ppvC0SazO9Kb6MQdmIk+7o5QSIcyfhvlEydzzPpEgMehIT
         4R79Rnpw6imWudHTC4bGqqLFWSHMEdN7IdQtUcUo5kqYxeZ8gvOXimWfwWxgdLZQ0mWU
         9H0wThpAiNyNl4Ut8ZN15ATQK4ujXiP87aLLBlevgdQfOrt0HtlEVe4vpeGUIni3Gupt
         n9mMb0J5/pM37GnikU04vsEBDwW7qep9DkcRJC5Ou55Hfd4qOOyg6XdlCAEBzsDATYWK
         dpfQ==
X-Gm-Message-State: AOAM532PkJMAC6vs6rY7H3Q+WCt6SaEyoRpBJ++a1NlbPeNeSZL6vCo9
        hx9D6Lfop23A6/R+eF+4TFWZMAJwiybvjlOl
X-Google-Smtp-Source: ABdhPJx/k3utmm93g23/XSCZNisLaoWzmqvFE3lN1YqFCJq0uvNKiSbennj+LWH6lseUnvwrBAiLxw==
X-Received: by 2002:a05:6214:d05:: with SMTP id 5mr43115232qvh.54.1608135751491;
        Wed, 16 Dec 2020 08:22:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f1sm1201046qtj.73.2020.12.16.08.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/13] btrfs: do not double free backref nodes on error
Date:   Wed, 16 Dec 2020 11:22:11 -0500
Message-Id: <39bfa3b49c43175cc1042dd372396fa139a0e2cd.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo reported the following KASAN splat

BUG: KASAN: use-after-free in btrfs_backref_cleanup_node+0x18a/0x420
Read of size 8 at addr ffff888112402950 by task btrfs/28836

CPU: 0 PID: 28836 Comm: btrfs Tainted: G        W         5.10.0-e35f27394290-for-next+ #23
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 dump_stack+0xbc/0xf9
 ? btrfs_backref_cleanup_node+0x18a/0x420
 print_address_description.constprop.8+0x21/0x210
 ? record_print_text.cold.34+0x11/0x11
 ? btrfs_backref_cleanup_node+0x18a/0x420
 ? btrfs_backref_cleanup_node+0x18a/0x420
 kasan_report.cold.10+0x20/0x37
 ? btrfs_backref_cleanup_node+0x18a/0x420
 __asan_load8+0x69/0x90
 btrfs_backref_cleanup_node+0x18a/0x420
 btrfs_backref_release_cache+0x83/0x1b0
 relocate_block_group+0x394/0x780
 ? merge_reloc_roots+0x4a0/0x4a0
 btrfs_relocate_block_group+0x26e/0x4c0
 btrfs_relocate_chunk+0x52/0x120
 btrfs_balance+0xe2e/0x1900
 ? check_flags.part.50+0x6c/0x1e0
 ? btrfs_relocate_chunk+0x120/0x120
 ? kmem_cache_alloc_trace+0xa06/0xcb0
 ? _copy_from_user+0x83/0xc0
 btrfs_ioctl_balance+0x3a7/0x460
 btrfs_ioctl+0x24c8/0x4360
 ? __kasan_check_read+0x11/0x20
 ? check_chain_key+0x1f4/0x2f0
 ? __asan_loadN+0xf/0x20
 ? btrfs_ioctl_get_supported_features+0x30/0x30
 ? kvm_sched_clock_read+0x18/0x30
 ? check_chain_key+0x1f4/0x2f0
 ? lock_downgrade+0x3f0/0x3f0
 ? handle_mm_fault+0xad6/0x2150
 ? do_vfs_ioctl+0xfc/0x9d0
 ? ioctl_file_clone+0xe0/0xe0
 ? check_flags.part.50+0x6c/0x1e0
 ? check_flags.part.50+0x6c/0x1e0
 ? check_flags+0x26/0x30
 ? lock_is_held_type+0xc3/0xf0
 ? syscall_enter_from_user_mode+0x1b/0x60
 ? do_syscall_64+0x13/0x80
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? __kasan_check_read+0x11/0x20
 ? __fget_light+0xae/0x110
 __x64_sys_ioctl+0xc3/0x100
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4c4bdfe427

Allocated by task 28836:
 kasan_save_stack+0x21/0x50
 __kasan_kmalloc.constprop.18+0xbe/0xd0
 kasan_kmalloc+0x9/0x10
 kmem_cache_alloc_trace+0x410/0xcb0
 btrfs_backref_alloc_node+0x46/0xf0
 btrfs_backref_add_tree_node+0x60d/0x11d0
 build_backref_tree+0xc5/0x700
 relocate_tree_blocks+0x2be/0xb90
 relocate_block_group+0x2eb/0x780
 btrfs_relocate_block_group+0x26e/0x4c0
 btrfs_relocate_chunk+0x52/0x120
 btrfs_balance+0xe2e/0x1900
 btrfs_ioctl_balance+0x3a7/0x460
 btrfs_ioctl+0x24c8/0x4360
 __x64_sys_ioctl+0xc3/0x100
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 28836:
 kasan_save_stack+0x21/0x50
 kasan_set_track+0x20/0x30
 kasan_set_free_info+0x1f/0x30
 __kasan_slab_free+0xf3/0x140
 kasan_slab_free+0xe/0x10
 kfree+0xde/0x200
 btrfs_backref_error_cleanup+0x452/0x530
 build_backref_tree+0x1a5/0x700
 relocate_tree_blocks+0x2be/0xb90
 relocate_block_group+0x2eb/0x780
 btrfs_relocate_block_group+0x26e/0x4c0
 btrfs_relocate_chunk+0x52/0x120
 btrfs_balance+0xe2e/0x1900
 btrfs_ioctl_balance+0x3a7/0x460
 btrfs_ioctl+0x24c8/0x4360
 __x64_sys_ioctl+0xc3/0x100
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This occurred because we free'd our backref node in
btrfs_backref_error_cleanup(), but then tried to free it again in
btrfs_backref_release_cache().  This is because
btrfs_backref_release_cache() will cycle through all of the
cache->leaves nodes and free them up.  However
btrfs_backref_error_cleanup() free'd the backref node with
btrfs_backref_free_node(), which simply kfree()'d the backref node
without unlinking it from the cache.  Change this to a
btrfs_backref_drop_node(), which does the appropriate cleanup and
removes the node from the cache->leaves list, so when we go to free the
remaining cache we don't trip over items we've already dropped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f0877d2883f9..3af38b09be43 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3117,7 +3117,7 @@ void btrfs_backref_error_cleanup(struct btrfs_backref_cache *cache,
 		list_del_init(&lower->list);
 		if (lower == node)
 			node = NULL;
-		btrfs_backref_free_node(cache, lower);
+		btrfs_backref_drop_node(cache, lower);
 	}
 
 	btrfs_backref_cleanup_node(cache, node);
-- 
2.26.2

