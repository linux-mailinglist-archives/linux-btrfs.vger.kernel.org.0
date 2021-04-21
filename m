Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46493669B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhDULN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 07:13:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238414AbhDULNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 07:13:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LB49ox155281;
        Wed, 21 Apr 2021 07:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=D7b/WKyPwfDQcsKgIxm4Ss3CVoAvxPtQ6jZcyYF2DPc=;
 b=KYFlRCCO2V6rS+Eh3guZsUjDUAf1fZT7UujJ9qp9xmzNmPdCtDWZj7lsbWyYnOKpb9ls
 J8gEBtNG8M9fw/0ENKFuFYzZvsIUsDpHYDXrR+4ik2t9k73/pfQY5T2D/mJ92oCxTDvy
 A370ExoTtevB18kW+VEqj5MDqyONjCKKXKn5BU0bTdtXAng/oeGbxiF+dk/BNp9sqFcn
 U4piXPmFjGauj7631Fu64rJXlYEF3FqfcWXvN1/I8nfs0zmJI59mT1BLebmauidLgYIN
 4yhV8PmFIAQ3fEB7THaECp8uZACzYbmnoz0lRLnZQTO1SaOsK/ho1JHNxH7iV5HUdUHs Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382j8q13rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:13:17 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LB4OMW156926;
        Wed, 21 Apr 2021 07:13:17 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382j8q13qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:13:17 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LB85C5022623;
        Wed, 21 Apr 2021 11:13:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37yqa8j8cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 11:13:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LBCnLO37224760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 11:12:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF3C4C059;
        Wed, 21 Apr 2021 11:13:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C83BE4C050;
        Wed, 21 Apr 2021 11:13:11 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 11:13:11 +0000 (GMT)
Date:   Wed, 21 Apr 2021 16:43:10 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210421111310.q2g2fhzhlcoaykff@riteshh-domain>
References: <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
 <20210421070331.r4enns6ticwpan35@riteshh-domain>
 <20210421073020.fwu7a5t4ihl7gzao@riteshh-domain>
 <ca952f24-d0cd-fda7-c9c5-85eba3e7d04a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca952f24-d0cd-fda7-c9c5-85eba3e7d04a@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7wzONq7rWpkiznH-0oVx2tOTDteAQyQX
X-Proofpoint-GUID: nmjdqywphbRdzwI103lTqng0ywJd-egR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_04:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210085
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/21 04:26PM, Qu Wenruo wrote:
>
>
> On 2021/4/21 下午3:30, riteshh wrote:
> > On 21/04/21 12:33PM, riteshh wrote:
> > > On 21/04/19 09:24PM, Qu Wenruo wrote:
> > > > [...]
> > > > > >
> > > > > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > > > > index 45ec3f5ef839..49f78d643392 100644
> > > > > > --- a/fs/btrfs/file.c
> > > > > > +++ b/fs/btrfs/file.c
> > > > > > @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode
> > > > > > *inode,
> > > > > >                          unlock_page(page);
> > > > > >                          return -EIO;
> > > > > >                  }
> > > > > > -               if (page->mapping != inode->i_mapping) {
> > > > > > +
> > > > > > +               /*
> > > > > > +                * Since btrfs_readpage() will get the page unlocked, we
> > > > > > have
> > > > > > +                * a window where fadvice() can try to release the page.
> > > > > > +                * Here we check both inode mapping and PagePrivate() to
> > > > > > +                * make sure the page is not released.
> > > > > > +                *
> > > > > > +                * The priavte flag check is essential for subpage as we
> > > > > > need
> > > > > > +                * to store extra bitmap using page->private.
> > > > > > +                */
> > > > > > +               if (page->mapping != inode->i_mapping ||
> > > > > > PagePrivate(page)) {
> > > > >    ^ Obviously it should be !PagePrivate(page).
> > > >
> > > > Hi Ritesh,
> > > >
> > > > Mind to have another try on generic/095?
> > > >
> > > > This time the branch is updated with the following commit at top:
> > > >
> > > > commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
> > > > github/subpage)
> > > > Author: Qu Wenruo <wqu@suse.com>
> > > > Date:   Mon Apr 19 13:41:31 2021 +0800
> > > >
> > > >      btrfs: fix a crash caused by race between prepare_pages() and
> > > >      btrfs_releasepage()
> > > >
> > > > The fix uses the PagePrivate() check to avoid the problem, and passes
> > > > several generic/auto loops without any sign of crash.
> > > >
> > > > But considering I always have difficult in reproducing the bug with previous
> > > > improper fix, your verification would be very helpful.
> > > >
> > >
> > > Hi Qu,
> > >
> > > Thanks for the patch. I did try above patch but even with this I could still
> > > reproduce the issue.
> > >
> > > 1. I think the original problem could be due to below logs.
> > > 	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
> > > 	<...>
> > > 	[   83.634710] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> > >
> > > Meaning, there might be a race here between DIO and buffered IO.
> > > So from DIO path we call invalidate_inode_pages2_range(). Somehow this maybe
> > > causing call of btrfs_releasepage().
> > >
> > > Now from code, invalidate_inode_pages2_range() can be called from both
> > > __iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as to from
> > > where this might be triggering this bug.
> >
> > I think I got one of the problem.
> > 1. we use page->private pointer as btrfs_subpage struct which also happens to
> >     hold spinlock within it.
> >
> >     Now in btrfs_subpage_clear_writeback()
> >     -> we take this spinlock  spin_lock_irqsave(&subpage->lock, flags);
> >     -> we call end_page_writeback(page);
> >     		  -> this may end up waking up invalidate_inode_pages2_range()
> > 		  which is waiting for writeback to complete.
> > 			  -> this then may also call btrfs_releasepage() on the
> > 			  same page and also free the subpage structure.
>
> This indeeds looks like a problem.
>
> This really means we need to have such a small race window below:
> (btrfs_invalidatepage() doesn't seem to be possible to race considering
>  how much work needed to be done in that function)
>
> 	Thread 1		|		Thread 2
> --------------------------------+------------------------------------
>  end_bio_extent_writepage()	| btrfs_releasepage()
>  |- spin_lock_irqsave()		| |
>  |- end_page_writeback()	| |
>  |				| |- if (PageWriteback() ||...)
>  |				| |- clear_page_extent_mapped()
>  |- spin_unlock_irqrestore().
>
> It looks like my arm boards are not fast enough to trigger the race.
>
> Although it can be fixed by doing the same thing as dirty bit, by checking
> the bitmap first and then call end_page_writeback() with spinlock unlocked.
>
> Would you please try the following fix? (based on the latest branch, which
> already has the previous fixes included).
>
> I'm also running the tests on all my arm boards to make sure it doesn't
> cause extra problem, so far so good, but my board is far from fast, thus not
> yet 100% tested.
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 696485ab68a2..c5abf9745c10 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct
> btrfs_fs_info *fs_info,
>  {
>         struct btrfs_subpage *subpage = (struct btrfs_subpage
> *)page->private;
>         u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +       bool finished = false;
>         unsigned long flags;
>
>         spin_lock_irqsave(&subpage->lock, flags);
>         subpage->writeback_bitmap &= ~tmp;
>         if (subpage->writeback_bitmap == 0)
> -               end_page_writeback(page);
> +               finished = true;
>         spin_unlock_irqrestore(&subpage->lock, flags);
> +       if (finished)
> +               end_page_writeback(page);
>  }
>
>  void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,

Thanks for this patch. I have re-tested generic/095 with 100 iterations and -g
quick (with both of your patches). I don't see this issue anymore.
So with the two patches (including above one) the race with
btrfs_releasepage() is now fixed.


For both of these patches, please feel free to add:

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>

-ritesh
