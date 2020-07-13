Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D516221D335
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMJw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 05:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgGMJw5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 05:52:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAD83AC1D;
        Mon, 13 Jul 2020 09:52:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88E37DA809; Mon, 13 Jul 2020 11:52:34 +0200 (CEST)
Date:   Mon, 13 Jul 2020 11:52:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Message-ID: <20200713095234.GF3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
 <20200710140511.30343-2-johannes.thumshirn@wdc.com>
 <20200713094251.GE3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713094251.GE3703@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 11:42:51AM +0200, David Sterba wrote:
> On Fri, Jul 10, 2020 at 11:05:09PM +0900, Johannes Thumshirn wrote:
> > @@ -261,7 +264,8 @@ struct btrfs_ioctl_fs_info_args {
> >  	__u32 flags;				/* in/out */
> >  	__u16 csum_type;			/* out */
> >  	__u16 csum_size;			/* out */
> > -	__u8 reserved[972];			/* pad to 1k */
> > +	__u32 generation;			/* out */
> > +	__u8 reserved[968];			/* pad to 1k */
> 
> I've tested the static assert by switching just the type but not the
> remaining reserved bytes
> 
>   ./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct btrfs_ioctl_fs_info_args) == 1024"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> 	|                                         ^~~~~~~~~~~~~~
>   ./include/linux/build_bug.h:77:34: note: in expansion of macro ‘__static_assert’
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> 	|                                  ^~~~~~~~~~~~~~~
>   ./include/uapi/linux/btrfs.h:270:1: note: in expansion of macro ‘static_assert’
>     270 | static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
> 	| ^~~~~~~~~~~~~
>   make[2]: *** [scripts/Makefile.build:281: fs/btrfs/super.o] Error 1
>   make[1]: *** [scripts/Makefile.build:497: fs/btrfs] Error 2
>   make: *** [Makefile:1756: fs] Error 2
> 
> Good.

There's extra padding now required for u64:

  struct btrfs_ioctl_fs_info_args {
	  __u64                      max_id;               /*     0     8 */
	  __u64                      num_devices;          /*     8     8 */
	  __u8                       fsid[16];             /*    16    16 */
	  __u32                      nodesize;             /*    32     4 */
	  __u32                      sectorsize;           /*    36     4 */
	  __u32                      clone_alignment;      /*    40     4 */
	  __u32                      flags;                /*    44     4 */
	  __u16                      csum_type;            /*    48     2 */
	  __u16                      csum_size;            /*    50     2 */

	  /* XXX 4 bytes hole, try to pack */

	  __u64                      generation;           /*    56     8 */
	  /* --- cacheline 1 boundary (64 bytes) --- */
	  __u8                       reserved[964];        /*    64   964 */

	  /* size: 1032, cachelines: 17, members: 11 */
	  /* sum members: 1024, holes: 1, sum holes: 4 */
	  /* padding: 4 */
	  /* last cacheline: 8 bytes */
  };

What if, instead of inserting a padding/reserved field we switch the
flags to u64 too. This unfortunatelly requires swapping order for flags
and csum_type/_size but the result

  struct btrfs_ioctl_fs_info_args {
	  __u64                      max_id;               /*     0     8 */
	  __u64                      num_devices;          /*     8     8 */
	  __u8                       fsid[16];             /*    16    16 */
	  __u32                      nodesize;             /*    32     4 */
	  __u32                      sectorsize;           /*    36     4 */
	  __u32                      clone_alignment;      /*    40     4 */
	  __u16                      csum_type;            /*    44     2 */
	  __u16                      csum_size;            /*    46     2 */
	  __u64                      flags;                /*    48     8 */
	  __u64                      generation;           /*    56     8 */
	  /* --- cacheline 1 boundary (64 bytes) --- */
	  __u8                       reserved[960];        /*    64   960 */

	  /* size: 1024, cachelines: 16, members: 11 */
  };

does not require any padding and leaves the end member with 8 byte
alignment.
