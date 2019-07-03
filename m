Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4EA5E548
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGCNVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 09:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfGCNVR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 09:21:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 672A2AFFB;
        Wed,  3 Jul 2019 13:21:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DFF9BDA7E9; Wed,  3 Jul 2019 15:21:58 +0200 (CEST)
Date:   Wed, 3 Jul 2019 15:21:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
Message-ID: <20190703132158.GV20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628022611.2844-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 10:26:11AM +0800, Anand Jain wrote:
> At the time mkfs.btrfs the device id and stripe index gets reversed as
> shown in [1]. This patch helps to keep them in order at the time of
> mkfs.btrfs. And makes it easier to debug.
> 
> Before:
> Stripe 0 is on devid 2; Stipe 1 is on devid 1;
> 
> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"

I've reformatted that so it's not overly long line. For dumps it's ok
but a command can be split by && or | .

> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 1048576
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 22020096
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 9437184
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 30408704
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 277872640
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 298844160
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
> 
> After:
> Stripe 0 is on devid 1; Stripe 1 is on devid 2
> 
> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tree -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" | grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
> /dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
> /dev/sdc: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 66 53 5f 4d
> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsize 112
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 22020096
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 1048576
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize 112
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 30408704
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 9437184
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 itemsize 112
> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 298844160
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 277872640
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.
