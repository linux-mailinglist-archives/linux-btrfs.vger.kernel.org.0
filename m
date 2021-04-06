Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91541355506
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhDFNZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 09:25:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37609 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhDFNZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 09:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617715497; x=1649251497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IDdrGl2FLLkMroSCFeZdrP5sIFNpe93jpVjN9v2gSOI=;
  b=h5DP07exqKLZ6kx/MvQ9GKXryHGl2JAx/cXzLuBn644hWD8wvGYWeeFr
   vOD2rLj3LOfQpuSYvSDuwZclahBzumkh+1pIvNpR4G5i1J1RmS3DGmZjj
   YiywXHWcPWcsq/Gwp0X7+hKShH93X/WruEmWnfgPmhik8BRL0XShsQOKv
   H6EJylNJOHE6HD/KCDVoSLabKcsba9mjTeIhUQ/NlFVTuGdkiR8ijs0W5
   updoRX6qqB9vZKb04BvHDYWEuG2ZLRyZwE82F1+bRitIZW9VUmnS8NeN7
   TgBPQRp08iOp4iuQNbq4PsiakaTjRbOMeUgN+Wzk8pZVQtA7lZdYW0QBr
   w==;
IronPort-SDR: wSkOpHfoRDMd1xQTe+WCVrCwMQkZ7iQP4c8U/Q4PfBkzuJ9tfx9AMzF0wyrp0xI+E+FrLC1GdK
 q6EhwxxUupTvrioVA0hwYJKdUoGPECnuQi6HM+ZSlvbPNZ4NpW/hjtArUIjipcaZvkniq8I17B
 ABMzlLvO/2Osw5TJ1WIr/7KI2gBjRZPgeZOBojjCnCdbCV7aPuQgML5RjMVM8YQmG2bwR3rtST
 Lmc296+7cG2VvHX/I+4YcgSw8GaRO3y5u9qozq/dhHyz0U5ePOMUVKUc0pp1A/tyZF/YNj9aBJ
 OL8=
X-IronPort-AV: E=Sophos;i="5.81,309,1610380800"; 
   d="scan'208";a="268310464"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 21:24:41 +0800
IronPort-SDR: +8eCgfl71fK1TdhKXo06Yk6qrnFzM6DNbs74iPzP2Z3Zox7emqxyA1yYHxcD0iCO8XVIpTdSLA
 HklyifONK2nLeV5SISXXJWZAiPmRjCjns1WetZhiwXbsTwnPkfgKGovQCIC6ZR2sl4/HcYeNxT
 DQTuqOImOuMqpqF1dJ5bnMhXr44p1GhN8VUXfTVaAnJ7pgsLz1ocXfBL6v994jsgE5gS1xaxZR
 SzXDCVAA4p/8JK782OXcr9a9CnwpvPO30/bNBljnLgHEga7vg+OZ9Zx/QOpoSUYyi3yZM1CCAV
 GpPW5JosDgQYuGqN1ml9PqhK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 06:04:20 -0700
IronPort-SDR: UbLLp13Qb7yXicBFR9N2mQi5+8DdYTgt6NT04jFuDwsq5peVl/jRvqnvzi0dHOlBjumY8L91Bk
 0VJ9PO6abhHdHDpcOFjTRE8+SpfZcFd4OGZWTIyZtdzsxeb9mwKsuZ7Jvl6tkKGS31tOYDyJqu
 xHRjUuehiPdztWsLyl/IOm0a6mLzuclkpldkTiVybrNGhCIk3STPbKnuamEyIZSaSDOnl1d4WI
 VvrpyErxQO+ED9MTMTgBgTTQcjfePZrGD5ZFSIQD1fafx+yH9m1dCLc8d3VNgQt4+GfrUf31i5
 bkg=
WDCIronportException: Internal
Received: from jpf009835.ad.shared (HELO naota-xeon) ([10.225.49.106])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 06:24:30 -0700
Date:   Tue, 6 Apr 2021 22:24:29 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Su Yue <l@damenly.su>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Message-ID: <20210406132429.y4ew2n3yanrm6ayn@naota-xeon>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
 <35w3d6gz.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35w3d6gz.fsf@damenly.su>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 06:54:37PM +0800, Su Yue wrote:
> 
> On Tue 06 Apr 2021 at 16:05, Naohiro Aota <naohiro.aota@wdc.com> wrote:
> 
> > This is the userland counterpart of the following series.
> > 
> > https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.aota@wdc.com/
> > 
> > This series refactors chunk allocation and device_extent allocation
> > functions and make them generalized to be able to implement other
> > allocation policy easily.
> > 
> > On top of this series, we can simplify userland side of the zoned series
> > as
> > adding a new type of chunk allocator and extent allocator for zoned
> > block
> > devices. Furthermore, we will be able to implement and test some other
> > allocator in the idea page of the wiki e.g. SSD caching, dedicated
> > metadata
> > drive, chunk allocation groups, and so on.
> > 
> > This series also fixes a bug of calculating the stripe size in DUP
> > profile,
> > and cleans up the code.
> > 
> > * Refactoring chunk/dev_extent allocator
> > 
> > Two functions are separated from find_free_dev_extent_start().
> > dev_extent_search_start() decides the starting position of the search.
> > dev_extent_hole_check() checks if a hole found is suitable for device
> > extent allocation.
> > 
> > Split some parts of btrfs_alloc_chunk() into three functions.
> > init_alloc_chunk_policy() initializes the parameters of an allocation.
> > decide_stripe_size() decides the size of chunk and device_extent. And,
> > create_chunk() creates a chunk and device extents.
> > 
> > * Patch organization
> > 
> > Patches 1 and 2 refactor find_free_dev_extent_start().
> > 
> > Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the code into
> > three
> > other functions.
> > 
> > Patch 7 uses create_chunk() to simplify btrfs_alloc_data_chunk().
> > 
> > Patch 8 fixes a bug of calculating stripe size in DUP profile.
> > 
> > Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping
> > unnecessary
> > parameters, and using better macro/variable name to clarify the meaning.
> > 
> > 
> gcc10 complains following warnings:
> kernel-shared/volumes.c: In function ‘decide_stripe_size’:
> kernel-shared/volumes.c:1119:1: warning: control reaches end of non-void
> function [-Wreturn-type]
> 1119 | }
>      | ^
> kernel-shared/volumes.c: In function ‘dev_extent_search_start’:
> kernel-shared/volumes.c:465:1: warning: control reaches end of non-void
> function [-Wreturn-type]
>  465 | }
>      | ^
> 
> Looked at locations just two nits about 'switch'. Care to fix?

These are actually false-positve warnings. They never reach the end of
the function because BUG() in the default case will abort the program.

The warnings are showing up because the BUG() macro is not marked as
unreachable. This is addressed in the following patch. So, once the
following patch is merged, the warnings will disappear.

https://lore.kernel.org/linux-btrfs/5c7b703beca572514a28677df0caaafab28bfff8.1617265419.git.naohiro.aota@wdc.com/T/#u

> --
> Su
> > Naohiro Aota (12):
> >   btrfs-progs: introduce chunk allocation policy
> >   btrfs-progs: refactor find_free_dev_extent_start()
> >   btrfs-progs: convert type of alloc_chunk_ctl::type
> >   btrfs-progs: consolidate parameter initialization of regular
> > allocator
> >   btrfs-progs: factor out decide_stripe_size()
> >   btrfs-progs: factor out create_chunk()
> >   btrfs-progs: rewrite btrfs_alloc_data_chunk() using   create_chunk()
> >   btrfs-progs: fix to use half the available space for DUP   profile
> >   btrfs-progs: use round_down for allocation calcs
> >   btrfs-progs: drop alloc_chunk_ctl::stripe_len
> >   btrfs-progs: simplify arguments of chunk_bytes_by_type()
> >   btrfs-progs: rename calc_size to stripe_size
> > 
> >  kernel-shared/volumes.c | 514  +++++++++++++++++++++-------------------
> >  kernel-shared/volumes.h |   6 +
> >  2 files changed, 274 insertions(+), 246 deletions(-)
> 
