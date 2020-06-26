Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E120B1C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZMzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 08:55:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFZMzA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 08:55:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC709AC77;
        Fri, 26 Jun 2020 12:54:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4C4ADAA08; Fri, 26 Jun 2020 14:54:46 +0200 (CEST)
Date:   Fri, 26 Jun 2020 14:54:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200626125446.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 04:30:19PM +0900, Johannes Thumshirn wrote:
> With the recent addition of filesystem checksum types other than CRC32c,
> it is not anymore hard-coded which checksum type a btrfs filesystem uses.
> 
> Up to now there is no good way to read the filesystem checksum, apart from
> reading the filesystem UUID and then query sysfs for the checksum type.
> 
> Add a new csum_type field to the BTRFS_IOC_FS_INFO ioctl command which
> usually is used to query filesystem features. Also add a flags member
> indicating that the kernel responded with a set csum_type field.
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

This leaves 2 bytes (one u16) unaligned to the next 4 bytes, which
shouldn't be a problem, but I think having the csum_size would be a good
and also getting rid of the gap.

>         __u8                       reserved[974];        /*    50   974 */
> 
>         /* size: 1024, cachelines: 16, members: 9 */
> };
