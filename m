Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77C431FD07
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBSQTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 11:19:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBSQTs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 11:19:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF2E9AF1B;
        Fri, 19 Feb 2021 16:19:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A2EFDA875; Fri, 19 Feb 2021 17:17:07 +0100 (CET)
Date:   Fri, 19 Feb 2021 17:17:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs test error on fsck/012-leaf-corruption
Message-ID: <20210219161707.GF1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210218025614.GA1755@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218025614.GA1755@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 18, 2021 at 02:56:14AM +0000, Sidong Yang wrote:
> I found some error when I run unittest code in btrfs-progs.
> fsck/012-leaf-corruption test corrupt leaf and check that it's recovered.
> but the test was failed and demsg below
> 
> [   47.284095] BTRFS error (device loop5): device total_bytes should be at most 27660288 but found 67108864
> [   47.284207] BTRFS error (device loop5): failed to read chunk tree: -22
> [   47.286465] BTRFS error (device loop5): open_ctree failed
> 
> I'm using kernel version 5.11 and there is no error in old version kernel.
> I traced the kernel code and found the code that prints error message.
> When it tried to mount btrfs, the function read_one_dev() failed.
> I found that code added by the commit 3a160a9331112 cause this problem.
> The unittest in btrfs-progs should be changed or kernel code should be patched?

The kernel check makes sense. The unit test fails because the image is
restored from a dump and not extended to the full size automatically.

After 'extract_image' the image is

-rw-r--r-- 1 root root 27660288 Feb 19 17:47 good.img.restored
-rw-r--r-- 1 root root   186392 Jul 27  2020 good.img.xz
-rwxr-xr-x 1 root root     2788 Feb 19 17:46 test.sh

but with a manual 'truncate -s 67108864 good.img.restored' the test
succeeds.

btrfs-image enlarges the file but it's probably taking the wrong size

2281         dev_size = key.offset + btrfs_dev_extent_length(path.nodes[0], dev_ext);
2282         btrfs_release_path(&path);
2283
2284         btrfs_set_stack_device_total_bytes(dev_item, dev_size);
2285         btrfs_set_stack_device_bytes_used(dev_item, mdres->alloced_chunks);
2286         ret = fstat(out_fd, &buf);
2287         if (ret < 0) {
2288                 error("failed to stat result image: %m");
2289                 return -errno;
2290         }
2291         if (S_ISREG(buf.st_mode)) {
2292                 /* Don't forget to enlarge the real file */
2293                 ret = ftruncate64(out_fd, dev_size);
2294                 if (ret < 0) {
2295                         error("failed to enlarge result image: %m");
2296                         return -errno;
2297                 }
2298         }

here it's the 'dev_size'. In the superblock dump, the sb.total_size and
sb.dev_item.total_size are both 67108864, which is the correct value.

The size as obtained from the device item in the device tree also matches the
right value

        item 6 key (1 DEV_EXTENT 61210624) itemoff 3667 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 61210624 length 5898240
                chunk_tree_uuid b2834867-4e78-47ee-9877-94d4e39bda43

Which is the key.offset + length = 61210624 + 5898240 = 67108864.

But the code is not called in restore_metadump because of condition
"btrfs_super_num_devices(mdrestore.original_super) != 1"
