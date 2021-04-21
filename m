Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EA36660E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhDUHEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 03:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234637AbhDUHEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 03:04:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13L743eY135050;
        Wed, 21 Apr 2021 03:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=yRrgflUuh/mLF+WeYV0a+PcBQBlPBPWkVE5IuVH63MU=;
 b=DCqV1CqIOkWiGwnXjvKZvRqWqmPBt4qfL7RsS4g2avOiwX3Qw/uXVWGLXGWR2anQTXs8
 RsU1PaWtX6sIVEFfik376fG2I94Mq1m7OZQ/fHNsBjxRZRT3zP9WTRfxPksz2PwrkU/O
 j6TE8ASmKhyLlaEHchhr8AtOYBRp531xEb/xPqXp+a/Q1e/YD8vw2B5J6Sj5LfnFK85d
 SMLvGTEBV1GJTxaLb0koia3TCUHYFp3VUvJO/whE8CP1WYny/sNO2X64vDin5vlHCTqI
 rqpHYZaQWXjuSwQzdAlEXqSVZY0rdnCmjhY6YT78GBSji6GUnCbbmq1GTiuOW7YBHuYi tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382eafsm71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 03:04:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13L749CQ138368;
        Wed, 21 Apr 2021 03:04:09 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 382eafskt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 03:04:08 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13L73HXs003074;
        Wed, 21 Apr 2021 07:03:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 37yqa8960u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:03:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13L73WsH51380564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 07:03:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 851A9A404D;
        Wed, 21 Apr 2021 07:03:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 381B1A4059;
        Wed, 21 Apr 2021 07:03:32 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 07:03:32 +0000 (GMT)
Date:   Wed, 21 Apr 2021 12:33:31 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210421070331.r4enns6ticwpan35@riteshh-domain>
References: <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 69h83XLnCHcxjwkrQi2OOFHJArdUF8A3
X-Proofpoint-GUID: PsCd48yIuviDop09gpeF5DmvOiC-gsT0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_02:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/19 09:24PM, Qu Wenruo wrote:
> [...]
> > >
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index 45ec3f5ef839..49f78d643392 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode
> > > *inode,
> > >                         unlock_page(page);
> > >                         return -EIO;
> > >                 }
> > > -               if (page->mapping != inode->i_mapping) {
> > > +
> > > +               /*
> > > +                * Since btrfs_readpage() will get the page unlocked, we
> > > have
> > > +                * a window where fadvice() can try to release the page.
> > > +                * Here we check both inode mapping and PagePrivate() to
> > > +                * make sure the page is not released.
> > > +                *
> > > +                * The priavte flag check is essential for subpage as we
> > > need
> > > +                * to store extra bitmap using page->private.
> > > +                */
> > > +               if (page->mapping != inode->i_mapping ||
> > > PagePrivate(page)) {
> >   ^ Obviously it should be !PagePrivate(page).
>
> Hi Ritesh,
>
> Mind to have another try on generic/095?
>
> This time the branch is updated with the following commit at top:
>
> commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
> github/subpage)
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Mon Apr 19 13:41:31 2021 +0800
>
>     btrfs: fix a crash caused by race between prepare_pages() and
>     btrfs_releasepage()
>
> The fix uses the PagePrivate() check to avoid the problem, and passes
> several generic/auto loops without any sign of crash.
>
> But considering I always have difficult in reproducing the bug with previous
> improper fix, your verification would be very helpful.
>

Hi Qu,

Thanks for the patch. I did try above patch but even with this I could still
reproduce the issue.

1. I think the original problem could be due to below logs.
	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
	<...>
	[   83.634710] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!

Meaning, there might be a race here between DIO and buffered IO.
So from DIO path we call invalidate_inode_pages2_range(). Somehow this maybe
causing call of btrfs_releasepage().

Now from code, invalidate_inode_pages2_range() can be called from both
__iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as to from
where this might be triggering this bug.

I will try and debug more. But I thought I will update you with above findings.

-ritesh
