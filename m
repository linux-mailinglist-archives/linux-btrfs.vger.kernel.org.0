Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7365ECE63A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfJGO6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 10:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:57922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfJGO6c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 10:58:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73436B180;
        Mon,  7 Oct 2019 14:58:29 +0000 (UTC)
Subject: Re: [PATCH 0/4] Add xxhash64 and sha256 as possible new checksums
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191007091104.18095-1-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2cf5e517-0c2e-87f9-45b4-6d0b2a04af25@suse.com>
Date:   Mon, 7 Oct 2019 17:58:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007091104.18095-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.10.19 г. 12:11 ч., Johannes Thumshirn wrote:
> This series adds support for two additional checksum algorithms to btrfs. These
> algorithms are xxhash64[1] and sha256[2].
> 
> xxhash64 is a fast non-cryptographic hash function with good collision resistance.
> It has a constant output length of 8 Byte (64 Bit), it provides a good
> trade-off between collision resistance and speed compared to the currently
> used crc32c.
> 
> sha256 is the 32 Byte (256 Bit) variant of the SHA-2 cryptographic hash. It
> provides cryptographically secure collision resistance with a trade off in
> speed.
> 
> Support for xxhash64 in mkfs.btrfs is in the current devel branch and sha256
> support will be sent separately after this patch-set.
> 
> In addition to adding these two hash algorithms two sysfs files are
> implemented, one being /sys/fs/btrfs/features/supported_checksums showing the
> in kernel support for different checksumming algorithms. The other one is
> /sys/fs/btrfs/$FSID/checksum showing the checksum used for a specific
> file-system and the used in-kernel driver for this checksum.
> 
> Here is an example in a qemu vm:
> host:/# cat /sys/fs/btrfs/features/supported_checksums
> crc32c, xxhash64, sha256
> host:/# cat /sys/fs/btrfs/3cf09516-5bb8-498f-834d-e9ec54043546/checksum
> sha256 (sha256-generic)
> 
> This series has survived the usual regression testing with xfstests.
> 
> I could not observe any performance differences between any of these hashes in
> my test setup 256K mixed read-write IO to a single file from a single process
> on both a 5700rpm SATA 3G Disk behind a HPE SmartArray RAID HBA and RAM Disk.
> 
> Here's the raw numbers for the spinning rust behind SATA:
> CRC32C Buffered Read (KiB/s): Avg: 7881, Min: 7495, Max: 8744, Stdev: 508
> CRC32C Buffered Write (KiB/s): Avg: 7883, Min: 7497, Max: 8746, Stdev: 508
>                                
> CRC32C Direct Read (KiB/s): Avg: 331, Min: 319, Max: 339, Stdev: 7
> CRC32C Direct Write (KiB/s): Avg: 331, Min: 319, Max: 339, Stdev: 7
> 
> XXHASH64 Buffered Read (KiB/s): Avg: 8143, Min: 7748, Max: 8721, Stdev: 355
> XXHASH64 Buffered Write (KiB/s): Avg: 8145, Min: 7750, Max: 8722, Stdev: 355
> 
> XXHASH64 Direct Read (KiB/s): Avg: 311, Min: 248, Max: 336, Stdev: 36
> XXHASH64 Direct Write (KiB/s): Avg: 311, Min: 248, Max: 336, Stdev: 36
>                                
> SHA256 Buffered Read (KiB/s): Avg: 7997, Min: 7665, Max: 8336, Stdev: 273
> SHA256 Buffered Write (KiB/s): Avg: 7998, Min: 7666, Max: 8337, Stdev: 273
> 
> SHA256 Direct Read (KiB/s): Avg: 312, Min: 248, Max: 336, Stdev: 36
> SHA256 Direct Write (KiB/s): Avg: 312, Min: 248, Max: 336, Stdev: 36
> 
> The reason I could not observe any changes in performance is the fact that the
> btrfs checksumming process takes only 0.04% of the IO path. This also explains
> the very small standard deviation in the above table as I stooped benchmarking
> after 5 benchmark runs.
> 
> The hottest call chain (according to perf) is this:
> 
> 17.08%     0.00%  kworker/u128:9-  [kernel.vmlinux]  [k] btrfs_finish_ordered_io
>  |
>  ---btrfs_finish_ordered_io
>     |          
>      --17.04%--insert_reserved_file_extent.constprop.75
>        |          
>         --17.02%--__btrfs_drop_extents
>      	   |          
>      	    --16.94%--btrfs_free_extent
>      		|          
>      		 --16.94%--btrfs_add_delayed_data_ref
>      		   |          
>      		    --16.90%--btrfs_qgroup_trace_extent_post

Yeah, we know qgroups tracing and backrefs resolv are somewhat slow. How
about benchmarking without them since I believe this to be more
representative of how people use btrfs.

>      			      btrfs_find_all_roots
>      			      |          
>      			       --16.90%--btrfs_find_all_roots_safe
>      				 |          
>      				  --16.89%--find_parent_nodes
>      				    |          
>      				     --16.68%--resolve_indirect_refs
> 					       [snip]
> 
> [1] https://cyan4973.github.io/xxHash
> [2] https://en.wikipedia.org/wiki/SHA-2
> 
> David Sterba (1):
>   btrfs: sysfs: export supported checksums
> 
> Johannes Thumshirn (3):
>   btrfs: add xxhash64 to checksumming algorithms
>   btrfs: add sha256 to checksumming algorithms
>   btrfs: show used checksum driver per filesystem in sysfs
> 
>  fs/btrfs/Kconfig                |  2 ++
>  fs/btrfs/ctree.c                |  7 ++++++
>  fs/btrfs/ctree.h                |  2 ++
>  fs/btrfs/disk-io.c              |  2 ++
>  fs/btrfs/super.c                |  2 ++
>  fs/btrfs/sysfs.c                | 48 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs_tree.h |  2 ++
>  7 files changed, 65 insertions(+)
> 
