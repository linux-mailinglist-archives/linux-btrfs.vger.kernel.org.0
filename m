Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905DF366641
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhDUHbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 03:31:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234002AbhDUHbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 03:31:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13L7DpcH071270;
        Wed, 21 Apr 2021 03:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=lIBbZ8ZnldfB2ySefK7V3yVZdaaF1lTutg1EKQI6nqE=;
 b=P1kcndHKwbdVudyexhpmOAsoT6DIwzojJb5AfNzYIJIZ2Mrpzgj3RVkoTKf8tzieORgb
 HJD4Ye15LG8KegeQGKWqBNTNbSOVsaTvmHEFhZsqViDJwy9siZHp10QnDFcH5JOpox6x
 rDqUCMikLusyJ02n+Cg6RUbk9CrxTA6FX51Ql8cOBLcxs4i0dvagphNueZgPkxy5mZm/
 j7l1B+b/7/+nKTh9RUwYJn9WruuvXjIBUEbZ2R/M5rXwjbgdan+dmqnkpo9t957nURB9
 A6YG+nxMN/wmEX9BXtrkMxKvkRDY82dYIEg9duZhsk/6e636M3vgBOB3ni1yyviSX348 dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382ffmrd9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 03:30:26 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13L7EnCO073535;
        Wed, 21 Apr 2021 03:30:26 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382ffmrd78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 03:30:26 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13L7S6jW019166;
        Wed, 21 Apr 2021 07:30:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37yt2rt35j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:30:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13L7UM0x46334286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 07:30:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18DD211C058;
        Wed, 21 Apr 2021 07:30:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B792911C05E;
        Wed, 21 Apr 2021 07:30:21 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 07:30:21 +0000 (GMT)
Date:   Wed, 21 Apr 2021 13:00:20 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210421073020.fwu7a5t4ihl7gzao@riteshh-domain>
References: <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
 <20210421070331.r4enns6ticwpan35@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421070331.r4enns6ticwpan35@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4tgwf6y2wRnnpGSbs2n9kXkGP_croEuH
X-Proofpoint-ORIG-GUID: zkx_6GZ_G3rcgMUy9CJxUEuVGE9EIg9K
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_02:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/21 12:33PM, riteshh wrote:
> On 21/04/19 09:24PM, Qu Wenruo wrote:
> > [...]
> > > >
> > > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > > index 45ec3f5ef839..49f78d643392 100644
> > > > --- a/fs/btrfs/file.c
> > > > +++ b/fs/btrfs/file.c
> > > > @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode
> > > > *inode,
> > > >                         unlock_page(page);
> > > >                         return -EIO;
> > > >                 }
> > > > -               if (page->mapping != inode->i_mapping) {
> > > > +
> > > > +               /*
> > > > +                * Since btrfs_readpage() will get the page unlocked, we
> > > > have
> > > > +                * a window where fadvice() can try to release the page.
> > > > +                * Here we check both inode mapping and PagePrivate() to
> > > > +                * make sure the page is not released.
> > > > +                *
> > > > +                * The priavte flag check is essential for subpage as we
> > > > need
> > > > +                * to store extra bitmap using page->private.
> > > > +                */
> > > > +               if (page->mapping != inode->i_mapping ||
> > > > PagePrivate(page)) {
> > >   ^ Obviously it should be !PagePrivate(page).
> >
> > Hi Ritesh,
> >
> > Mind to have another try on generic/095?
> >
> > This time the branch is updated with the following commit at top:
> >
> > commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
> > github/subpage)
> > Author: Qu Wenruo <wqu@suse.com>
> > Date:   Mon Apr 19 13:41:31 2021 +0800
> >
> >     btrfs: fix a crash caused by race between prepare_pages() and
> >     btrfs_releasepage()
> >
> > The fix uses the PagePrivate() check to avoid the problem, and passes
> > several generic/auto loops without any sign of crash.
> >
> > But considering I always have difficult in reproducing the bug with previous
> > improper fix, your verification would be very helpful.
> >
>
> Hi Qu,
>
> Thanks for the patch. I did try above patch but even with this I could still
> reproduce the issue.
>
> 1. I think the original problem could be due to below logs.
> 	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
> 	<...>
> 	[   83.634710] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
>
> Meaning, there might be a race here between DIO and buffered IO.
> So from DIO path we call invalidate_inode_pages2_range(). Somehow this maybe
> causing call of btrfs_releasepage().
>
> Now from code, invalidate_inode_pages2_range() can be called from both
> __iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as to from
> where this might be triggering this bug.

I think I got one of the problem.
1. we use page->private pointer as btrfs_subpage struct which also happens to
   hold spinlock within it.

   Now in btrfs_subpage_clear_writeback()
   -> we take this spinlock  spin_lock_irqsave(&subpage->lock, flags);
   -> we call end_page_writeback(page);
   		  -> this may end up waking up invalidate_inode_pages2_range()
		  which is waiting for writeback to complete.
			  -> this then may also call btrfs_releasepage() on the
			  same page and also free the subpage structure.

   -> then we call spin_unlock => here the btrfs_subpage structure got freed
   but we still accessed and hence causing spinlock bug corruption

<below call traces were observed without any fixes>
<i.e. tree contained patches till "btrfs: reject raid5/6 fs for subpage">
[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
[   81.118576] BTRFS: device fsid 0450e360-e0ea-4cff-9f84-3c6064437ef6 devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (4669)
[   81.208410] BTRFS info (device loop3): disk space caching is enabled
[   81.209219] BTRFS info (device loop3): has skinny extents
[   81.209849] BTRFS warning (device loop3): read-write for sector size 4096 with page size 65536 is experimental
[   81.219579] BTRFS info (device loop3): checking UUID tree
[   83.634710] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
[   83.639921] File: /mnt1/scratch/file1 PID: 221 Comm: kworker/30:1
[   85.130349] fio (4720) used greatest stack depth: 7808 bytes left
[   87.022500] BUG: spinlock bad magic on CPU#26, swapper/26/0
[   87.023457] BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
[   87.024776] Faulting instruction address: 0xc000000000283654
cpu 0x1a: Vector: 380 (Data SLB Access) at [c000000007af7160]
    pc: c000000000283654: spin_dump+0x70/0xbc
    lr: c000000000283638: spin_dump+0x54/0xbc
    sp: c000000007af7400
   msr: 8000000000009033
   dar: 6b6b6b6b6b6b725b
  current = 0xc000000007ab9800
  paca    = 0xc00000003ffc9a00   irqmask: 0x03   irq_happened: 0x01
    pid   = 0, comm = swapper/26
Linux version 5.12.0-rc7-02317-gee3f9a64895 (riteshh@ltctulc6a-p1) (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #78 SMP Wed Apr 21 01:10:41 CDT 2021
enter ? for help
[c000000007af7470] c000000000283078 do_raw_spin_unlock+0x88/0x230
[c000000007af74a0] c0000000012b1e34 _raw_spin_unlock_irqrestore+0x44/0x90
[c000000007af74d0] c000000000a918fc btrfs_subpage_clear_writeback+0xac/0xe0
[c000000007af7530] c0000000009e0478 end_bio_extent_writepage+0x158/0x270
[c000000007af75f0] c000000000b6fd34 bio_endio+0x254/0x270
[c000000007af7630] c0000000009fc110 btrfs_end_bio+0x1a0/0x200
[c000000007af7670] c000000000b6fd34 bio_endio+0x254/0x270
[c000000007af76b0] c000000000b7821c blk_update_request+0x46c/0x670
[c000000007af7760] c000000000b8b3b4 blk_mq_end_request+0x34/0x1d0
[c000000007af77a0] c000000000d82d3c lo_complete_rq+0x11c/0x140
[c000000007af77d0] c000000000b880c4 blk_complete_reqs+0x84/0xb0
[c000000007af7800] c0000000012b2cc4 __do_softirq+0x334/0x680
[c000000007af7910] c0000000001dd878 irq_exit+0x148/0x1d0
[c000000007af7940] c000000000016f4c do_IRQ+0x20c/0x240
[c000000007af79d0] c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0

-ritesh
