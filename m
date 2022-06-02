Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DEF53BBED
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiFBPz1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiFBPz0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 11:55:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE98813E9F;
        Thu,  2 Jun 2022 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654185325; x=1685721325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6MsF1Yi8LeWcMVuU/in+a8UlaD/p7nvWDhBkwg/UJU=;
  b=gWY6aYoqRxMK6r/8Q9nTmdeahCtGCGbv1Gb8b58WnW/BcXmcBawBKFdl
   ErLTseBEdcymThH/IZq2DK3dDBN1GZ8UAWJkQS72qG3Y5XoC8A8vt+oRn
   S1l3NTP6qOl0uUvhS1RhIdf9wJtwQc2wJ9jmGNoTdvVEoqPk2bF1ish0e
   8vvGJDbdzIWq8QRUybyF+oJIdruv+u+MgS4TjSDKAGU3hFukmn059DZZD
   u3+TorGTPXAL/IZ6bQj7No+LIIcj+ZFAi0mZqDLD4fQC/HL5eXuvqPSNV
   YdZ8+aPxqfJiQuyl2UbsY8Xx8pccnrqes0ZTDB5H3vJC/OJ5B/JkWfJgm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275999731"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275999731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:55:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="721357881"
Received: from liqiong-mobl.amr.corp.intel.com (HELO localhost) ([10.209.7.136])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:55:24 -0700
Date:   Thu, 2 Jun 2022 08:55:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <YpjdbCLQI0kaGGCh@iweiny-desk3>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
 <YpjVKAGz+GuI4GB0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpjVKAGz+GuI4GB0@infradead.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 02, 2022 at 08:20:08AM -0700, Christoph Hellwig wrote:
> Turns out that while this looks good, it actually crashes when
> running xfstests.  I think this is due to the fact that kmap sets
> the page address, which kmap_local_page does not.

:-(

I know that Fabio is working on getting xfstests set up and we have been
discussing the use of page address in the fs/btrfs code.

Stay tuned,
Ira

> 
> btrfs/150 1s ... [  168.252943] run fstests btrfs/150 at 2022-06-02 15:17:11
> [  169.462292] BTRFS info (device vdb): flagging fs with big metadata feature
> [  169.463728] BTRFS info (device vdb): disk space caching is enabled
> [  169.464953] BTRFS info (device vdb): has skinny extents
> [  170.596218] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4
> devid 1 transid 5 /dev)
> [  170.599471] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4 devid 2 transid 5 /dev)
> [  170.657170] BTRFS info (device vdc): flagging fs with big metadata feature
> [  170.659509] BTRFS info (device vdc): use zlib compression, level 3
> [  170.661190] BTRFS info (device vdc): disk space caching is enabled
> [  170.670706] BTRFS info (device vdc): has skinny extents
> [  170.714181] BTRFS info (device vdc): checking UUID tree
> [  170.735058] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  170.736478] #PF: supervisor read access in kernel mode
> [  170.737457] #PF: error_code(0x0000) - not-present page
> [  170.738529] PGD 0 P4D 0 
> [  170.739211] Oops: 0000 [#1] PREEMPT SMP PTI
> [  170.740101] CPU: 0 PID: 43 Comm: kworker/u4:3 Not tainted 5.18.0-rc7+ #1539
> [  170.741478] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [  170.743246] Workqueue: btrfs-delalloc btrfs_work_helper
> [  170.744282] RIP: 0010:zlib_compress_pages+0x128/0x670
> [  170.745346] Code: 00 00 00 16 00 00 48 01 e8 31 ed 48 c1 f8 06 48 c1 e0 0c 48 01 f8 49 89 0
> [  170.749042] RSP: 0018:ffffc9000038bc70 EFLAGS: 00010286
> [  170.750037] RAX: 0000000000000001 RBX: ffffc9000038bdb8 RCX: 0000000000000001
> [  170.751351] RDX: 0000000000002000 RSI: ffffffff82f532fb RDI: ffff888000000000
> [  170.752695] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> [  170.754106] R10: 0000000000000000 R11: ffff8881039a5b30 R12: ffff888107befb48
> [  170.755449] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> [  170.756922] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
> [  170.758642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.759714] CR2: 0000000000000008 CR3: 000000010ab60000 CR4: 00000000000006f0
> [  170.761082] Call Trace:
> [  170.761553]  <TASK>
> [  170.761968]  ? _raw_spin_unlock+0x24/0x40
> [  170.762776]  btrfs_compress_pages+0xda/0x120
> [  170.763682]  compress_file_range+0x3b9/0x840
> [  170.764570]  async_cow_start+0xd/0x30
> [  170.765308]  ? submit_compressed_extents+0x3c0/0x3c0
> [  170.766241]  btrfs_work_helper+0xf5/0x3f0
> [  170.767009]  ? lock_is_held_type+0xe2/0x140
> [  170.767817]  process_one_work+0x239/0x550
> [  170.768633]  ? process_one_work+0x550/0x550
> [  170.769447]  worker_thread+0x4d/0x3a0
> [  170.770210]  ? process_one_work+0x550/0x550
> [  170.771019]  kthread+0xe2/0x110
> [  170.771623]  ? kthread_complete_and_exit+0x20/0x20
> [  170.772697]  ret_from_fork+0x22/0x30
> [  170.773454]  </TASK>
> 
