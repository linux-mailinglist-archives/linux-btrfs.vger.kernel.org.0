Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1562A389EE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhETH0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 03:26:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14468 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETH0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 03:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621495530; x=1653031530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GF2RR1mzxg0LXglGejKUR64W734EijwRfiAKOfb/5u0=;
  b=NKBUn1kbvA2h8ZUVOdxBx9CZVontoWHo5lg3MzjlhGZI9xpI0D/cCp5n
   WNkO0+hoauKDNa8qYlFAqJl/idH/Ur0ihotYyHZ871EHokGmqMVCB5zZc
   5VgLm2kVMG++rnZoukB3ZLNF2/pehsoxnl3cpgCWyg4fPxGA/D4mplReK
   iOy+hg+8pLY2nwaanoVMovcngQX+XS+tYiucbtrE56cTfbhtRZR0AdfqP
   bF6Yl3yU0kocjoU9sshf+iPz9ctwg5UmBydf7+wu2A9saeinHtk5Uq2lt
   gxXtsCwQ/1MAX5gK3BQi5HF5gBCTW2J3QkqQFxSTnIuQQReupSLrnH4N+
   g==;
IronPort-SDR: LuoYxWV656tahHxNk5YPXK/X3CIff4bDehavDVTosgRjgb0wDsFfEfUGwfKLrxMTZhKTB/Cq1g
 BGvmQ7pnPr3+OOmFGNCORz1Zjn0RFqwk/3XIXLEUFLPejFdG7jqmgv17diFnZDOKwvaVI7MEZG
 BrEMnP2vfA+Pq4SSelf7ovBHwTK7HdQchNkzuHxafc5fnEJHrfaa4l80hn2jGl//RiTpeldq04
 Ndwt+O66EFaxc1Pd+0b6T0NCf/t6TRDgKBPJNVhrZlyyyiO2a6P1A6M1LEe93kVtcH5H1hRyxp
 Bi8=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169356331"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 15:25:29 +0800
IronPort-SDR: QzFOtdV7c7V7s45QWh32onPHXzbIaQGg1h51/cMB19Fmw5FSkBbByY/DF4gvEBGWhu+TxIFyB1
 EE08pv2Cz2E3ZrMKawUluC/uSYtceAp4Dnzss8WuOsICPRVa/1G4Pu+3q0Eydu4e9evyIQrWhY
 Rk1cPpeVQeityMnYa+Wfs/Tw8fQItl3Do2H0zbxb7DUnKCHnJ8FwnkNS1e6RgV8+VqpRtuzumB
 QZIwf9nSnhosg+woFd5XCqzgD7sCzjBfSs7vboNrP8Vmr+AKjPGr0GhWCgOopxDSIFQ6zpKuhc
 XsVDCh9TZXLjygbo5mIdbPT8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:03:52 -0700
IronPort-SDR: mZZSGCxV933Llq8NL3FhJevGMxqiHsWqXtyQ9isHzUuYHITVJzIxemvx/4HZrHl6MQniFm0JHU
 gyvq9qLgVdpiO3CBURwdyVnL6KC8m/UaLt2VdxYlcMyGTsFVUDqdtAgKrpGxYtYfdpi7AYFNrk
 owypdQ/A3OIgGE7wJ+xrjY4Bv+3qTzXPAnaSTfj/fMeRUje/itGPQCv1dkXQXMeKtMD3awkoLz
 gZ/E6ntyuwzzwPrB+ldftwANMT8S8oRcNPRQNNDUHMZ4S5bfy8L5PY6eNv3tKo46RatqfkYu+o
 Nzk=
WDCIronportException: Internal
Received: from jpf010043.ad.shared (HELO naota-xeon) ([10.225.52.46])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:25:28 -0700
Date:   Thu, 20 May 2021 16:25:26 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Behavior of btrfs_io_geometry()
Message-ID: <20210520072526.6tpa2ndu4qqs6ic6@naota-xeon>
References: <20210520061138.d775gajnfj7h2xu4@naota-xeon>
 <bb4d60e6-5bb0-d50a-ed20-309bb643dc06@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb4d60e6-5bb0-d50a-ed20-309bb643dc06@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the comments.

On Thu, May 20, 2021 at 09:58:28AM +0300, Nikolay Borisov wrote:
> 
> 
> On 20.05.21 г. 9:11, Naohiro Aota wrote:
> > I have a few questions about btrfs_io_geometry()'s behavior. 
> > 
> > While I'm testing zoned btrfs on ZNS drive with 2GB zone size, I hit
> > the following ASSERT in btrfs_submit_direct() by running fstests
> > btrfs/017.
> > 
> > static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
> > 		struct bio *dio_bio, loff_t file_offset)
> > {
> > ...
> > 	start_sector = dio_bio->bi_iter.bi_sector;
> > 	submit_len = dio_bio->bi_iter.bi_size;
> > 
> > 	do {
> > 		logical = start_sector << 9;
> > 		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
> > ...
> > 		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
> > 					    logical, submit_len, &geom);
> > ...
> > 		ASSERT(geom.len <= INT_MAX);
> > 
> > 		clone_len = min_t(int, submit_len, geom.len);
> > ...
> > 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
> > 
> > 
> > On zoned btrfs, we create a SINGLE block group whose size is equal to
> > the device zone size, so we have a 2 GB SINGLE block group on a 2 GB
> > zone size drive. Then, on a SINGLE single block group,
> > btrfs_io_geometry() returns the remaining length from @logical to the
> > end of the block group regardless of the @len argument. Thus, with
> > @logical == 0, we get geom->len = 2 GB, which is larger than INT_MAX,
> > hitting the ASSERT.
> > 
> > I'm confusing because I'm not sure what the ASSERT wants to do. It
> > might want to guard btrfs_bio_clone_partial() (and bio_trim()) below?
> > But, since bio_trim() takes sector-based values, and the passed
> > "clone_offset" and "clone_len" is byte-based, we can technically allow
> > larger bytes than INT_MAX. (well, we might never build such large bio,
> > though). And, it looks meaningless to check geom->len here. Since, it
> > can be much larger than bio size on a SINGLE block group.
> > 
> > So, in summary, below are my questions.
> > 
> > 1. About btrfs_bio_clone_partial()
> >   1.1 What is the meaning of geom->len?
> >       - Length from @logical to the stripe boundary? or
> >       - Length [logical, logical+len] can go without crossing the boundary?
> 
> So think of it as splitting a block group into 64k chunks (those are the
> stripes) then finding in which such 64k chunk/stripe_nr logical falls
> within, so len would be the length of an io you could do without
> crossing this 64k boundary. This process is described in
> https://github.com/btrfs/btrfs-dev-docs/blob/master/bio-submission.txt
> under section 'Bio mapping'. With this in mind I'd say it's  [logical,
> logical+len] without crossing a 64k boundary. !!!HOWEVER!!!!  This
> applies to bg types other than SINGLE , that's the
> if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) check in the function.
> We do this because for raid levels we'd like the io granularity to be
> 64k, whereas for SINGLE we simply issue a single write, i.e len is
> calculated as:
> 
> len = em->len - offset;
> 
> which is why you are getting such the size of the block group.

OK, it's the current behavior. So, we should expect geom->len vary
the meaning depending on the block group profile type?

> >   1.2 @len is currently unused in btrfs_bio_clone_partial(), is this correct?
> 
> It's used to calculate @clone_len parameter so it's indirectly involved
> in btrfs_bio_clone_partial.

Oops, I made a mistake here. I meant btrfs_get_io_geometry() here. The
same for the bullet "1." above. In btrfs_get_io_geometry(), we don't
use @len.

> >   1.3 What should we fill into geom->len when the block group is SINGLE profile?
> 
> See above.
> 
> > 
> > 2. About the ASSERT
> >   2.1 Shouldn't we check submit_len (= bio's length) instead of geom->len ?
> 
> The assert got added quite a while back so I'm not entirely sure it's
> pertinent.
> 
> >   2.2 Can't it be larger than INT_MAX? e.g., INT_MAX << SECTOR_SHIFT?
> > 
> > 3. About btrfs_bio_clone_partial()
> >   3.1 We can change "int" to "u64" maybe?
> 
> Can we though? So if size in btrfs_bio_clone_partial is switched to u64
> then in that fuction we do size >> 9 potentially having a value of at
> most 55 bits, passing it to bio_trim, which in turn takes an int. So
> you'd be truncating values at the time you call bio_trim, no ?

Yes, but we can still safely allow the value up to "INT_MAX << 9",
can't we? We may need to add another ASSERT here in this case...
