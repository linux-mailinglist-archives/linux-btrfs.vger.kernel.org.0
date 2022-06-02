Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7C53BB7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiFBPUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiFBPUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 11:20:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763A2A5515;
        Thu,  2 Jun 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bpvd1J1b0WtEe4XAB45cptIRNT3LAskrJazfccK+Ke0=; b=vmwGEc0Cc/yLViaTzRaFL5ig2s
        pQgxUIPOIQBksyLkqEXjgfJ01HzvYvW0Mp10p8q6vlhk0x5gzYpGjjt9Qb8Q3hUpShcMQNg6KfmeF
        J8OqwD+zl1nwFlwMGRGIj3g+FWscEHhCghzlY2GlfZrf/xMLBdXVFCb0K7dPaouyygVlfUUARQRWB
        fz8LZek8EAmKnWdtNpUP0gS+rHouxPs7SgWZplAiuweJ/FEtq3hunEhqy5KIU7zY4I8gFHOBDrBnT
        Nd9/1XDeScERELqRi6Cnds+lm0EUctZdvV3WMEvsNE9HMQtT9vEx3K7ndqvyqT7rlVmZSzXcrh8eQ
        VXXSw93A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwmcK-003gM1-Mi; Thu, 02 Jun 2022 15:20:08 +0000
Date:   Thu, 2 Jun 2022 08:20:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <YpjVKAGz+GuI4GB0@infradead.org>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531145335.13954-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Turns out that while this looks good, it actually crashes when
running xfstests.  I think this is due to the fact that kmap sets
the page address, which kmap_local_page does not.

btrfs/150 1s ... [  168.252943] run fstests btrfs/150 at 2022-06-02 15:17:11
[  169.462292] BTRFS info (device vdb): flagging fs with big metadata feature
[  169.463728] BTRFS info (device vdb): disk space caching is enabled
[  169.464953] BTRFS info (device vdb): has skinny extents
[  170.596218] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4
devid 1 transid 5 /dev)
[  170.599471] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4 devid 2 transid 5 /dev)
[  170.657170] BTRFS info (device vdc): flagging fs with big metadata feature
[  170.659509] BTRFS info (device vdc): use zlib compression, level 3
[  170.661190] BTRFS info (device vdc): disk space caching is enabled
[  170.670706] BTRFS info (device vdc): has skinny extents
[  170.714181] BTRFS info (device vdc): checking UUID tree
[  170.735058] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  170.736478] #PF: supervisor read access in kernel mode
[  170.737457] #PF: error_code(0x0000) - not-present page
[  170.738529] PGD 0 P4D 0 
[  170.739211] Oops: 0000 [#1] PREEMPT SMP PTI
[  170.740101] CPU: 0 PID: 43 Comm: kworker/u4:3 Not tainted 5.18.0-rc7+ #1539
[  170.741478] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[  170.743246] Workqueue: btrfs-delalloc btrfs_work_helper
[  170.744282] RIP: 0010:zlib_compress_pages+0x128/0x670
[  170.745346] Code: 00 00 00 16 00 00 48 01 e8 31 ed 48 c1 f8 06 48 c1 e0 0c 48 01 f8 49 89 0
[  170.749042] RSP: 0018:ffffc9000038bc70 EFLAGS: 00010286
[  170.750037] RAX: 0000000000000001 RBX: ffffc9000038bdb8 RCX: 0000000000000001
[  170.751351] RDX: 0000000000002000 RSI: ffffffff82f532fb RDI: ffff888000000000
[  170.752695] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[  170.754106] R10: 0000000000000000 R11: ffff8881039a5b30 R12: ffff888107befb48
[  170.755449] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[  170.756922] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[  170.758642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  170.759714] CR2: 0000000000000008 CR3: 000000010ab60000 CR4: 00000000000006f0
[  170.761082] Call Trace:
[  170.761553]  <TASK>
[  170.761968]  ? _raw_spin_unlock+0x24/0x40
[  170.762776]  btrfs_compress_pages+0xda/0x120
[  170.763682]  compress_file_range+0x3b9/0x840
[  170.764570]  async_cow_start+0xd/0x30
[  170.765308]  ? submit_compressed_extents+0x3c0/0x3c0
[  170.766241]  btrfs_work_helper+0xf5/0x3f0
[  170.767009]  ? lock_is_held_type+0xe2/0x140
[  170.767817]  process_one_work+0x239/0x550
[  170.768633]  ? process_one_work+0x550/0x550
[  170.769447]  worker_thread+0x4d/0x3a0
[  170.770210]  ? process_one_work+0x550/0x550
[  170.771019]  kthread+0xe2/0x110
[  170.771623]  ? kthread_complete_and_exit+0x20/0x20
[  170.772697]  ret_from_fork+0x22/0x30
[  170.773454]  </TASK>

