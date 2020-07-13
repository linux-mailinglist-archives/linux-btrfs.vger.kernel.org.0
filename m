Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE321D577
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMMCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:02:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgGMMCv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:02:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3B03AC12;
        Mon, 13 Jul 2020 12:02:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74421DA809; Mon, 13 Jul 2020 14:02:28 +0200 (CEST)
Date:   Mon, 13 Jul 2020 14:02:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Message-ID: <20200713120228.GG3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
 <20200710140511.30343-2-johannes.thumshirn@wdc.com>
 <20200713094251.GE3703@twin.jikos.cz>
 <20200713095234.GF3703@twin.jikos.cz>
 <SN4PR0401MB3598247EF50C61FB79F98A369B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598247EF50C61FB79F98A369B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 09:57:15AM +0000, Johannes Thumshirn wrote:
> On 13/07/2020 11:53, David Sterba wrote:
> > On Mon, Jul 13, 2020 at 11:42:51AM +0200, David Sterba wrote:
> >> On Fri, Jul 10, 2020 at 11:05:09PM +0900, Johannes Thumshirn wrote:
> >   struct btrfs_ioctl_fs_info_args {
> > 	  __u64                      max_id;               /*     0     8 */
> > 	  __u64                      num_devices;          /*     8     8 */
> > 	  __u8                       fsid[16];             /*    16    16 */
> > 	  __u32                      nodesize;             /*    32     4 */
> > 	  __u32                      sectorsize;           /*    36     4 */
> > 	  __u32                      clone_alignment;      /*    40     4 */
> > 	  __u16                      csum_type;            /*    44     2 */
> > 	  __u16                      csum_size;            /*    46     2 */
> > 	  __u64                      flags;                /*    48     8 */
> > 	  __u64                      generation;           /*    56     8 */
> > 	  /* --- cacheline 1 boundary (64 bytes) --- */
> > 	  __u8                       reserved[960];        /*    64   960 */
> > 
> > 	  /* size: 1024, cachelines: 16, members: 11 */
> >   };
> > 
> > does not require any padding and leaves the end member with 8 byte
> > alignment.
> 
> The swapped order looks a bit odd, but I don't really see a way around it. 
> Can you fix that up or should I re-send all 4 patches?

Please resend all 4, I'll drop and replace the csum_* patch in
misc-next. Thanks.
