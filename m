Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95875735D37
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFSSBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSSBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 14:01:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEE12A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 11:01:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98E2C1F889;
        Mon, 19 Jun 2023 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687197666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDAET0O1W9JHYDZH6zkC00UwZW0Dif4BiC1qlf9GQtM=;
        b=PZzjR+NEcDAo/rUojmLOSOOJEOJQFDalahGe71bp2dakNn6KdeTthNr2qMw0ryjp2LwsBG
        tCUhrMnwWY/dWNCgBLgCJ6MRQRUYCcVSEPCQRxbqhCrOR0eEwPs1yzWv9njcFl6hdCfIDB
        iuYbqsGxb0Gwv5o1AgmRP+6/Vxw7uTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687197666;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDAET0O1W9JHYDZH6zkC00UwZW0Dif4BiC1qlf9GQtM=;
        b=J7PSDnBAQDxYBC8oJL+AwDuM1RJTI4rabWJ8znA9FjDISMDkyfp2+3O56TFjWLZNO7lJG5
        f3UOi/sLGvLMjLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55162139C2;
        Mon, 19 Jun 2023 18:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /s/oE+KXkGQEBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 18:01:06 +0000
Date:   Mon, 19 Jun 2023 19:54:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Song Liu <song@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: BUG in raid6_pq while running fstest btrfs/286
Message-ID: <20230619175443.GE16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <72097c8f447b02fb4ed3cb6b898d73423ca52d09.camel@kernel.org>
 <8b24dc83-1506-b5cc-1441-5233d161f5d8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b24dc83-1506-b5cc-1441-5233d161f5d8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 16, 2023 at 09:57:47AM +0800, Qu Wenruo wrote:
> On 2023/6/16 01:58, Jeff Layton wrote:
> > I hit this today, while doing some testing with kdevops. Test btrfs/286
> > was running when it failed:
> > 
> > [ 4759.230216] run fstests btrfs/286 at 2023-06-15 16:11:41
> > [ 4759.636322] BTRFS: device fsid 8d197804-9964-4b3f-bbea-3ef33869b564 devid 1 transid 484 /dev/loop16 scanned by mount (893879)
> > [ 4759.641190] BTRFS info (device loop16): using crc32c (crc32c-intel) checksum algorithm
> > [ 4759.644817] BTRFS info (device loop16): using free space tree
> > [ 4759.650706] BTRFS info (device loop16): enabling ssd optimizations
> > [ 4759.652720] BTRFS info (device loop16): auto enabling async discard
> > [ 4760.484561] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> > [ 4760.494221] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> > [ 4760.497373] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (892535)
> > [ 4760.502687] BTRFS: device fsid 2a451aed-b7b6-4498-ba17-0e28a2e1a26b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894095)
> > [ 4760.515672] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4760.519412] BTRFS info (device loop5): setting nodatasum
> > [ 4760.521777] BTRFS info (device loop5): using free space tree
> > [ 4760.527120] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4760.528861] BTRFS info (device loop5): auto enabling async discard
> > [ 4760.532184] BTRFS info (device loop5): checking UUID tree
> > [ 4762.658754] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4762.662098] BTRFS info (device loop5): allowing degraded mounts
> > [ 4762.664749] BTRFS info (device loop5): setting nodatasum
> > [ 4762.667347] BTRFS info (device loop5): using free space tree
> > [ 4762.672306] BTRFS warning (device loop5): devid 2 uuid de8712ab-ca85-4414-93a7-213060d1831d is missing
> > [ 4762.676977] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4762.679852] BTRFS info (device loop5): auto enabling async discard
> > [ 4763.355404] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 started
> > [ 4763.595633] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 finished
> > [ 4764.044660] 286 (893750): drop_caches: 3
> > [ 4765.384814] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484b devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> > [ 4765.392235] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484b devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> > [ 4765.404469] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484b devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
> > [ 4765.412107] BTRFS: device fsid 7acce38c-63c2-4365-a338-e1f6c0fd484b devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894169)
> > [ 4765.429084] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4765.433332] BTRFS info (device loop5): setting nodatasum
> > [ 4765.435506] BTRFS info (device loop5): using free space tree
> > [ 4765.440808] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4765.442402] BTRFS info (device loop5): auto enabling async discard
> > [ 4765.444752] BTRFS info (device loop5): checking UUID tree
> > [ 4767.634901] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4767.637985] BTRFS info (device loop5): allowing degraded mounts
> > [ 4767.640216] BTRFS info (device loop5): setting nodatasum
> > [ 4767.642221] BTRFS info (device loop5): using free space tree
> > [ 4767.646646] BTRFS warning (device loop5): devid 2 uuid 6240c286-893c-4d19-bbf5-f1d2fecc6b96 is missing
> > [ 4767.650311] BTRFS warning (device loop5): devid 2 uuid 6240c286-893c-4d19-bbf5-f1d2fecc6b96 is missing
> > [ 4767.655256] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4767.658073] BTRFS info (device loop5): auto enabling async discard
> > [ 4768.343633] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 started
> > [ 4768.608799] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 finished
> > [ 4768.750345] 286 (893750): drop_caches: 3
> > [ 4769.993871] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3ad devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> > [ 4770.002879] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3ad devid 2 transid 6 /dev/loop6 scanned by (udev-worker) (892207)
> > [ 4770.015617] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3ad devid 3 transid 6 /dev/loop7 scanned by (udev-worker) (894101)
> > [ 4770.021936] BTRFS: device fsid 965cdb50-095a-4fd9-bcda-2c17bd80c3ad devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894243)
> > [ 4770.041357] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4770.043426] BTRFS info (device loop5): setting nodatasum
> > [ 4770.045340] BTRFS info (device loop5): using free space tree
> > [ 4770.050615] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4770.053473] BTRFS info (device loop5): auto enabling async discard
> > [ 4770.056311] BTRFS info (device loop5): checking UUID tree
> > [ 4772.692223] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4772.695043] BTRFS info (device loop5): allowing degraded mounts
> > [ 4772.697901] BTRFS info (device loop5): setting nodatasum
> > [ 4772.700355] BTRFS info (device loop5): using free space tree
> > [ 4772.704900] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8f54-4652-ba28-7c302a265f8d is missing
> > [ 4772.708151] BTRFS warning (device loop5): devid 2 uuid 5fa35bdf-8f54-4652-ba28-7c302a265f8d is missing
> > [ 4772.713703] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4772.716270] BTRFS info (device loop5): auto enabling async discard
> > [ 4773.735253] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 started
> > [ 4774.089640] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 finished
> > [ 4774.269606] 286 (893750): drop_caches: 3
> > [ 4775.897236] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c3 devid 1 transid 6 /dev/loop5 scanned by (udev-worker) (894101)
> > [ 4775.905939] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c3 devid 2 transid 6 /dev/loop6 scanned by mkfs.btrfs (894317)
> > [ 4775.909603] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c3 devid 3 transid 6 /dev/loop7 scanned by mkfs.btrfs (894317)
> > [ 4775.913080] BTRFS: device fsid 0552fbf6-2877-4ab3-b5a2-da5db268e1c3 devid 4 transid 6 /dev/loop8 scanned by mkfs.btrfs (894317)
> > [ 4775.928177] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4775.930566] BTRFS info (device loop5): setting nodatasum
> > [ 4775.932930] BTRFS info (device loop5): using free space tree
> > [ 4775.937296] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4775.938306] BTRFS info (device loop5): auto enabling async discard
> > [ 4775.940084] BTRFS info (device loop5): checking UUID tree
> > [ 4779.204728] BTRFS info (device loop5): using crc32c (crc32c-intel) checksum algorithm
> > [ 4779.207351] BTRFS info (device loop5): allowing degraded mounts
> > [ 4779.210284] BTRFS info (device loop5): setting nodatasum
> > [ 4779.212740] BTRFS info (device loop5): using free space tree
> > [ 4779.218547] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0caa-4c5f-8f92-034e72257005 is missing
> > [ 4779.221982] BTRFS warning (device loop5): devid 2 uuid 9a9f7178-0caa-4c5f-8f92-034e72257005 is missing
> > [ 4779.227912] BTRFS info (device loop5): enabling ssd optimizations
> > [ 4779.230483] BTRFS info (device loop5): auto enabling async discard
> > [ 4780.128223] BTRFS info (device loop5): dev_replace from <missing disk> (devid 2) to /dev/loop9 started
> > [ 4780.422390] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [ 4780.423934] #PF: supervisor read access in kernel mode
> > [ 4780.425584] #PF: error_code(0x0000) - not-present page
> > [ 4780.427234] PGD 0 P4D 0
> > [ 4780.428293] Oops: 0000 [#1] PREEMPT SMP PTI
> > [ 4780.429722] CPU: 3 PID: 761699 Comm: kworker/u16:4 Not tainted 6.4.0-rc6+ #6
> > [ 4780.431582] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> > [ 4780.433897] Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
> > [ 4780.435655] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
> > [ 4780.437518] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49 8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
> > [ 4780.442488] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
> > [ 4780.444147] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
> > [ 4780.446192] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000000000000000
> > [ 4780.448278] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffffa0ff4cfa3238
> > [ 4780.450387] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffffa0fe8bdf3000
> > [ 4780.452515] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 0000000000000000
> > [ 4780.454638] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000) knlGS:0000000000000000
> > [ 4780.456956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4780.458778] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 0000000000060ee0
> > [ 4780.460789] Call Trace:
> > [ 4780.461832]  <TASK>
> > [ 4780.462804]  ? __die+0x1f/0x70
> > [ 4780.463915]  ? page_fault_oops+0x159/0x450
> > [ 4780.465207]  ? fixup_exception+0x22/0x310
> > [ 4780.466484]  ? exc_page_fault+0x7a/0x180
> > [ 4780.467666]  ? asm_exc_page_fault+0x22/0x30
> > [ 4780.468879]  ? raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
> > [ 4780.470372]  ? raid6_sse21_gen_syndrome+0x38/0x130 [raid6_pq]
> > [ 4780.471801]  rmw_rbio+0x5c8/0xa80 [btrfs]
> > [ 4780.472987]  ? preempt_count_add+0x6a/0xa0
> > [ 4780.474061]  ? lock_stripe_add+0xe1/0x290 [btrfs]
> > [ 4780.475288]  process_one_work+0x1c7/0x3d0
> > [ 4780.476304]  worker_thread+0x4d/0x380
> > [ 4780.477232]  ? __pfx_worker_thread+0x10/0x10
> > [ 4780.478241]  kthread+0xf3/0x120
> > [ 4780.479071]  ? __pfx_kthread+0x10/0x10
> > [ 4780.479982]  ret_from_fork+0x2c/0x50
> > [ 4780.480843]  </TASK>
> > [ 4780.481488] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_flakey nls_iso8859_1 nls_cp437 vfat fat ext4 9p crc16 joydev kvm_intel netfs virtio_net mbcache cirrus kvm psmouse pcspkr net_failover failover xfs irqbypass drm_shmem_helper virtio_balloon jbd2 evdev button 9pnet_virtio drm_kms_helper loop drm dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel nvme virtio_blk crypto_simd nvme_core virtio_pci cryptd t10_pi virtio i6300esb virtio_pci_legacy_dev crc64_rocksoft_generic virtio_pci_modern_dev crc64_rocksoft crc64 virtio_ring serio_raw btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
> > [ 4780.492421] CR2: 0000000000000000
> > [ 4780.493185] ---[ end trace 0000000000000000 ]---
> > [ 4780.494099] RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
> > [ 4780.495217] Code: 4d 8d 54 05 00 44 89 c0 48 c1 e0 03 48 29 c6 49 8b 03 48 01 d0 0f 18 00 66 0f 6f 10 49 8b 01 0f 18 04 10 66 0f 6f e2 49 8b 01 <66> 0f 6f 34 10 4c 89 d0 45 85 c0 78 34 48 8b 08 0f 18 04 11 66 0f
> > [ 4780.498186] RSP: 0018:ffffb66f0296fdc8 EFLAGS: 00010286
> > [ 4780.499138] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
> > [ 4780.500327] RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000000000000000
> > [ 4780.501533] RBP: ffffa0ff4e72a000 R08: 00000000fffffffe R09: ffffa0ff4cfa3238
> > [ 4780.502683] R10: ffffa0ff4cfa3230 R11: ffffa0ff4cfa3240 R12: ffffa0fe8bdf3000
> > [ 4780.503827] R13: ffffa0ff4cfa3240 R14: 0000000000000003 R15: 0000000000000000
> > [ 4780.504971] FS:  0000000000000000(0000) GS:ffffa0ff77cc0000(0000) knlGS:0000000000000000
> > [ 4780.506207] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4780.507143] CR2: 0000000000000000 CR3: 000000015eb0a001 CR4: 0000000000060ee0
> > [ 4780.508242] note: kworker/u16:4[761699] exited with irqs disabled
> > [ 4780.509242] note: kworker/u16:4[761699] exited with preempt_count 1
> > 
> > 
> > Looks like a quadword move failed? I'm not well-versed in SSE asm, I'm afraid:
> > 
> > $ ./scripts/faddr2line --list ./lib/raid6/raid6_pq.ko raid6_sse21_gen_syndrome+0x9e/0x130
> > raid6_sse21_gen_syndrome+0x9e/0x130:
> > 
> > raid6_sse21_gen_syndrome at /home/jlayton/git/kdevops/linux/lib/raid6/sse2.c:56
> >   51 		for ( d = 0 ; d < bytes ; d += 16 ) {
> >   52 			asm volatile("prefetchnta %0" : : "m" (dptr[z0][d]));
> >   53 			asm volatile("movdqa %0,%%xmm2" : : "m" (dptr[z0][d])); /* P[0] */
> >   54 			asm volatile("prefetchnta %0" : : "m" (dptr[z0-1][d]));
> >   55 			asm volatile("movdqa %xmm2,%xmm4"); /* Q[0] */
> >> 56<			asm volatile("movdqa %0,%%xmm6" : : "m" (dptr[z0-1][d]));
> >   57 			for ( z = z0-2 ; z >= 0 ; z-- ) {
> >   58 				asm volatile("prefetchnta %0" : : "m" (dptr[z][d]));
> >   59 				asm volatile("pcmpgtb %xmm4,%xmm5");
> >   60 				asm volatile("paddb %xmm4,%xmm4");
> >   61 				asm volatile("pand %xmm0,%xmm5");
> > 
> > 
> > This machine is running v6.4.0-rc5 with some ctime handling patches on
> > top (nothing that should affect anything at this level). The Kconfig is
> > config-next-20230530 from the kdevops tree:
> > 
> > https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20230530)
> > 
> > Let me know if you need other info!
> 
> Unfortunately there are similar reports but I failed to reproduce anywhere.
> 
> In the past, I have added extra debugging for the reporter, and the 
> result is, at least every pointer is valid, until the control is passed 
> to the optimization routine...
> 
> You can try to disable SSE for the vCPU, or even pass AVX feature to the 
> vCPU, and normally you would see the error gone.
> 
> The last time I see such problem is from David, but we did not got any 
> progress any further.

I haven't seen the crash for a long time, IIRC it's related to SSE2,
no acceleration or anything AVX+ works.
