Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7DC218CF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgGHQ2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 12:28:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbgGHQ2x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 12:28:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7AC2ACC6;
        Wed,  8 Jul 2020 16:28:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D50CADA818; Wed,  8 Jul 2020 18:28:31 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:28:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans@knorrie.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200708162831.GC28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Hans van Kranenburg <hans@knorrie.org>,
        stable@vger.kernel.org
References: <20200706150924.40218-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706150924.40218-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 12:09:24AM +0900, Johannes Thumshirn wrote:
> With the recent addition of filesystem checksum types other than CRC32c,
> it is not anymore hard-coded which checksum type a btrfs filesystem uses.
> 
> Up to now there is no good way to read the filesystem checksum, apart from
> reading the filesystem UUID and then query sysfs for the checksum type.
> 
> Add a new csum_type and csum_size fields to the BTRFS_IOC_FS_INFO ioctl
> command which usually is used to query filesystem features. Also add a
> flags member indicating that the kernel responded with a set csum_type and
> csum_size field.
> 
> For compatibility reasons, only return the csum_type and csum_size if the
> BTRFS_FS_INFO_FLAG_CSUM_TYPE_SIZE flag was passed to the kernel. Also
> clear any unknown flags so we don't pass false positives to user-space
> newer than the kernel.
> 
> To simplify further additions to the ioctl, also switch the padding to a
> u8 array. Pahole was used to verify the result of this switch:
> 
> pahole -C btrfs_ioctl_fs_info_args fs/btrfs/btrfs.ko
> struct btrfs_ioctl_fs_info_args {
>         __u64                      max_id;               /*     0     8 */
>         __u64                      num_devices;          /*     8     8 */
>         __u8                       fsid[16];             /*    16    16 */
>         __u32                      nodesize;             /*    32     4 */
>         __u32                      sectorsize;           /*    36     4 */
>         __u32                      clone_alignment;      /*    40     4 */
>         __u32                      flags;                /*    44     4 */
>         __u16                      csum_type;            /*    48     2 */
>         __u16                      csum_size;            /*    50     2 */
>         __u8                       reserved[972];        /*    52   972 */
> 
>         /* size: 1024, cachelines: 16, members: 10 */
> };
> 
> Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
> Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")
> CC: stable@vger.kernel.org # 5.5+
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v4:
> * zero all data passed in from user-space
>   (I've chosen this variant as I think it is the most complete)

I'll have to refresh the whole evolution since v1 but the memset sounds
reasonable to me.
