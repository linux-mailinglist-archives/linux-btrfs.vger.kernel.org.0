Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2445436009C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 05:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhDODpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 23:45:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhDODpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 23:45:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F3XF8g121004;
        Wed, 14 Apr 2021 23:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JXwyIeUq+pKhHEFPCipqe5vF32rUz5RMdD/4fw+EVms=;
 b=B+t6G5HpapBpsYO2fir/0hntVXf/P5OZC3uhDzuWBwDWOckYVlrvYEeWK+0Nn79X32gF
 KzTCv92GmEc1+LV7nLq+g3cKTqozvqka1gBbnw2omdc4wTcAaegXkQn3Z4Y9yXyDYBXE
 wPVZLFkq7qVv9bmCGvs68H07OTWgBXspJrBUk+HihmdCEhfUfxKFe7V/BO46nYKCF56C
 sFdXCmM6bSBlJWc85vZcbzYYJZTWIF5AKhax7TodchkpG8sM2ODToTsT/BEgrcwJlbvd
 kDhlgq668TQLWgD19qWVdiiIWK9EQhzQqlFwKisD59G6KifHft2/BId80BPfE9m4pqUo 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x46wvuxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 23:44:50 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13F3h4l6161970;
        Wed, 14 Apr 2021 23:44:50 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x46wvuwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 23:44:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13F3b0I0021472;
        Thu, 15 Apr 2021 03:44:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hkmse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:44:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13F3ijpP43647360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 03:44:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92A81AE051;
        Thu, 15 Apr 2021 03:44:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347B2AE045;
        Thu, 15 Apr 2021 03:44:45 +0000 (GMT)
Received: from localhost (unknown [9.85.70.169])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 03:44:45 +0000 (GMT)
Date:   Thu, 15 Apr 2021 09:14:44 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87PI2pzLkvW8EyaHUThJjYLmQ3o4w4Rc
X-Proofpoint-ORIG-GUID: LqA26KkpKy3gXvK4wRYi0-nHW3wThUJ3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_01:2021-04-15,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150023
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/12 07:33PM, Qu Wenruo wrote:
>
>
> On 2021/4/2 下午4:52, Qu Wenruo wrote:
> >
> >
> > On 2021/4/2 下午4:46, Ritesh Harjani wrote:
> > > On 21/04/02 04:36PM, Qu Wenruo wrote:
> > > >
> > > >
> > > > On 2021/4/2 下午4:33, Ritesh Harjani wrote:
> > > > > On 21/03/29 10:01AM, Qu Wenruo wrote:
> > > > > >
> > > > > >
> > > > > > On 2021/3/29 上午4:02, Ritesh Harjani wrote:
> > > > > > > On 21/03/25 09:16PM, Qu Wenruo wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 2021/3/25 下午8:20, Neal Gompa wrote:
> > > > > > > > > On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This patchset can be fetched from the following github repo,
> > > > > > > > > > along with
> > > > > > > > > > the full subpage RW support:
> > > > > > > > > > https://github.com/adam900710/linux/tree/subpage
> > > > > > > > > >
> > > > > > > > > > This patchset is for metadata read write support.
> > > > > > > > > >
> > > > > > > > > > [FULL RW TEST]
> > > > > > > > > > Since the data write path is not included in this patchset, we
> > > > > > > > > > can't
> > > > > > > > > > really test the patchset itself, but anyone can grab the patch
> > > > > > > > > > from
> > > > > > > > > > github repo and do fstests/generic tests.
> > > > > > > > > >
> > > > > > > > > > But at least the full RW patchset can pass -g generic/quick -x
> > > > > > > > > > defrag
> > > > > > > > > > for now.
> > > > > > > > > >
> > > > > > > > > > There are some known issues:
> > > > > > > > > >
> > > > > > > > > > - Defrag behavior change
> > > > > > > > > >       Since current defrag is doing per-page defrag, to support
> > > > > > > > > > subpage
> > > > > > > > > >       defrag, we need some change in the loop.
> > > > > > > > > >       E.g. if a page has both hole and regular extents in it,
> > > > > > > > > > then defrag
> > > > > > > > > >       will rewrite the full 64K page.
> > > > > > > > > >
> > > > > > > > > >       Thus for now, defrag related failure is expected.
> > > > > > > > > >       But this should only cause behavior difference, no crash
> > > > > > > > > > nor hang is
> > > > > > > > > >       expected.
> > > > > > > > > >
> > > > > > > > > > - No compression support yet
> > > > > > > > > >       There are at least 2 known bugs if forcing compression
> > > > > > > > > > for subpage
> > > > > > > > > >       * Some hard coded PAGE_SIZE screwing up space rsv
> > > > > > > > > >       * Subpage ASSERT() triggered
> > > > > > > > > >         This is because some compression code is unlocking
> > > > > > > > > > locked_page by
> > > > > > > > > >         calling extent_clear_unlock_delalloc() with locked_page
> > > > > > > > > > == NULL.
> > > > > > > > > >       So for now compression is also disabled.
> > > > > > > > > >
> > > > > > > > > > - Inode nbytes mismatch
> > > > > > > > > >       Still debugging.
> > > > > > > > > >       The fastest way to trigger is fsx using the following
> > > > > > > > > > parameters:
> > > > > > > > > >
> > > > > > > > > >         fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file
> > > > > > > > > > > /tmp/fsx
> > > > > > > > > >
> > > > > > > > > >       Which would cause inode nbytes differs from expected
> > > > > > > > > > value and
> > > > > > > > > >       triggers btrfs check error.
> > > > > > > > > >
> > > > > > > > > > [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> > > > > > > > > > The metadata part in fact has more new code than data part, as
> > > > > > > > > > ithas
> > > > > > > > > > some different behaviors compared to the regular sector size
> > > > > > > > > > handling:
> > > > > > > > > >
> > > > > > > > > > - No more page locking
> > > > > > > > > >       Now metadata read/write relies on extent io tree locking,
> > > > > > > > > > other than
> > > > > > > > > >       page locking.
> > > > > > > > > >       This is to allow behaviors like read lock one eb while
> > > > > > > > > > alsotry to
> > > > > > > > > >       read lock another eb in the same page.
> > > > > > > > > >       We can't rely on page lock as now we have multiple extent
> > > > > > > > > > buffers in
> > > > > > > > > >       the same page.
> > > > > > > > > >
> > > > > > > > > > - Page status update
> > > > > > > > > >       Now we use subpage wrappers to handle page status update.
> > > > > > > > > >
> > > > > > > > > > - How to submit dirty extent buffers
> > > > > > > > > >       Instead of just grabbing extent buffer from
> > > > > > > > > > page::private, we need to
> > > > > > > > > >       iterate all dirty extent buffers in the page and submit
> > > > > > > > > > them.
> > > > > > > > > >
> > > > > > > > > > [CHANGELOG]
> > > > > > > > > > v2:
> > > > > > > > > > - Rebased to latest misc-next
> > > > > > > > > >       No conflicts at all.
> > > > > > > > > >
> > > > > > > > > > - Add new sysfs interface to grab supported RO/RW sectorsize
> > > > > > > > > >       This will allow mkfs.btrfs to detect unmountable fs better.
> > > > > > > > > >
> > > > > > > > > > - Use newer naming schema for each patch
> > > > > > > > > >       No more "extent_io:" or "inode:" schema anymore.
> > > > > > > > > >
> > > > > > > > > > - Move two pure cleanups to the series
> > > > > > > > > >       Patch 2~3, originally in RW part.
> > > > > > > > > >
> > > > > > > > > > - Fix one uninitialized variable
> > > > > > > > > >       Patch 6.
> > > > > > > > > >
> > > > > > > > > > v3:
> > > > > > > > > > - Rename the sysfs to supported_sectorsizes
> > > > > > > > > >
> > > > > > > > > > - Rebased to latest misc-next branch
> > > > > > > > > >       This removes 2 cleanup patches.
> > > > > > > > > >
> > > > > > > > > > - Add new overview comment for subpage metadata
> > > > > > > > > >
> > > > > > > > > > Qu Wenruo (13):
> > > > > > > > > >       btrfs: add sysfs interface for supported sectorsize
> > > > > > > > > >       btrfs: use min() to replace open-code in
> > > > > > > > > > btrfs_invalidatepage()
> > > > > > > > > >       btrfs: remove unnecessary variable shadowing in
> > > > > > > > > > btrfs_invalidatepage()
> > > > > > > > > >       btrfs: refactor how we iterate ordered extent in
> > > > > > > > > >         btrfs_invalidatepage()
> > > > > > > > > >       btrfs: introduce helpers for subpage dirty status
> > > > > > > > > >       btrfs: introduce helpers for subpage writeback status
> > > > > > > > > >       btrfs: allow btree_set_page_dirty() to do more sanity
> > > > > > > > > > checkon subpage
> > > > > > > > > >         metadata
> > > > > > > > > >       btrfs: support subpage metadata csum calculation at write
> > > > > > > > > > time
> > > > > > > > > >       btrfs: make alloc_extent_buffer() check subpage dirty bitmap
> > > > > > > > > >       btrfs: make the page uptodate assert to be subpage
> > > > > > > > > > compatible
> > > > > > > > > >       btrfs: make set/clear_extent_buffer_dirty() to be subpage
> > > > > > > > > > compatible
> > > > > > > > > >       btrfs: make set_btree_ioerr() accept extent buffer and to
> > > > > > > > > > be subpage
> > > > > > > > > >         compatible
> > > > > > > > > >       btrfs: add subpage overview comments
> > > > > > > > > >
> > > > > > > > > >      fs/btrfs/disk-io.c   | 143
> > > > > > > > > > ++++++++++++++++++++++++++++++++++---------
> > > > > > > > > >      fs/btrfs/extent_io.c | 127
> > > > > > > > > > ++++++++++++++++++++++++++++----------
> > > > > > > > > >      fs/btrfs/inode.c     | 128
> > > > > > > > > > ++++++++++++++++++++++----------------
> > > > > > > > > >      fs/btrfs/subpage.c   | 127
> > > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >      fs/btrfs/subpage.h   |  17 +++++
> > > > > > > > > >      fs/btrfs/sysfs.c     |  15 +++++
> > > > > > > > > >      6 files changed, 441 insertions(+), 116 deletions(-)
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.30.1
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Why wouldn't we just integrate full read-write support with the
> > > > > > > > > caveats as described now? It seems to be relatively reasonable
> > > > > > > > > to do
> > > > > > > > > that, and this patch set is essentially unusable without the
> > > > > > > > > rest of
> > > > > > > > > it that does enable full read-write support.
> > > > > > > >
> > > > > > > > The metadata part is much more stable than data path (almost not
> > > > > > > > touched
> > > > > > > > for several months), and the metadata part already has some
> > > > > > > > difference
> > > > > > > > in its behavior, which needs review.
> > > > > > > >
> > > > > > > > You point makes some sense, but I still don't believe pushing a
> > > > > > > > super
> > > > > > > > large patchset does any help for the review.
> > > > > > > >
> > > > > > > > If you want to test, you can grab the branch from the github repo.
> > > > > > > > If you want to review, the mails are all here for review.
> > > > > > > >
> > > > > > > > In fact, we used to have subpage support sent as a big patchset
> > > > > > > > from IBM
> > > > > > > > guys, but the result is only some preparation patches get merged,
> > > > > > > > and
> > > > > > > > nothing more.
> > > > > > > >
> > > > > > > > Using this multi-series method, we're already doing better work and
> > > > > > > > received more testing (to ensure regular sectorsize is not
> > > > > > > > affectedat
> > > > > > > > least).
> > > > > > >
> > > > > > > Hi Qu Wenruo,
> > > > > > >
> > > > > > > Sorry about chiming in late on this. I don't have any strong
> > > > > > > objection on either
> > > > > > > approach. Although sometime back when I tested your RW support git
> > > > > > > tree on
> > > > > > > Power, the unmount patch itself was crashing. I didn't debug it
> > > > > > > thattime
> > > > > > > (this was a month back or so), so I also didn't bother testing
> > > > > > > xfstests on Power.
> > > > > > >
> > > > > > > But we do have an interest in making sure this patch series work
> > > > > > > on bs < ps
> > > > > > > on Power platform. I can try helping with testing, reviewing (to
> > > > > > > best of my
> > > > > > > knowledge) and fixing anything is possible :)
> > > > > >
> > > > > > That's great!
> > > > > >
> > > > > > One of my biggest problem here is, I don't have good enough testing
> > > > > > environment.
> > > > > >
> > > > > > Although SUSE has internal clouds for ARM64/PPC64, but due to the
> > > > > > f**king Great Firewall, it's super slow to access, no to mention doing
> > > > > > proper debugging.
> > > > > >
> > > > > > Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the
> > > > > > test.
> > > > > > But their computing power is far from ideal, only generic/quick can
> > > > > > finish in hours.
> > > > > >
> > > > > > Thus real world Power could definitely help.
> > > > > > >
> > > > > > > Let me try and pull your tree and test it on Power. Please let me
> > > > > > > know if there
> > > > > > > is anything needs to be taken care apart from your github tree and
> > > > > > > btrfs-progs
> > > > > > > branch with bs < ps support.
> > > > > >
> > > > > > If you're going to test the branch, here are some small notes:
> > > > > >
> > > > > > - Need to use latest btrfs-progs
> > > > > >     As it fixes a false alert on crossing 64K page boundary.
> > > > > >
> > > > > > - Need to slightly modify btrfs-progs to avoid false alerts
> > > > > >     For subpage case, mkfs.btrfs will output a warning, but that
> > > > > > warning
> > > > > >     is outputted into stderr, which will screw up generic test groups.
> > > > > >     It's recommended to apply the following diff:
> > > > > >
> > > > > > diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> > > > > > index 569208a9..21976554 100644
> > > > > > --- a/common/fsfeatures.c
> > > > > > +++ b/common/fsfeatures.c
> > > > > > @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
> > > > > >                   return -EINVAL;
> > > > > >           }
> > > > > >           if (page_size != sectorsize)
> > > > > > -               warning(
> > > > > > -"the filesystem may not be mountable, sectorsize %u doesn't match
> > > > > > page
> > > > > > size %u",
> > > > > > +               printf(
> > > > > > +"the filesystem may not be mountable, sectorsize %u doesn't match
> > > > > > page
> > > > > > size %u\n",
> > > > > >                           sectorsize, page_size);
> > > > > >           return 0;
> > > > > >    }
> > > > > >
> > > > > > - Xfstest/btrfs group will crash at btrfs/143
> > > > > >     Still investigating, but you can ignore btrfs group for now.
> > > > > >
> > > > > > - Very rare hang
> > > > > >     There is a very low change to hang, with "bad ordered accounting"
> > > > > >     dmesg.
> > > > > >     If you can hit, please let me know.
> > > > > >     I had something idea to fix it, but not yet in the branch.
> > > > > >
> > > > > > - btrfs inode nbytes mismatch
> > > > > >     Investigating, as it will make btrfs-check to report error.
> > > > > >
> > > > > > The last two bugs are the final show blocker, I'll give you extra
> > > > > > updates when those are fixed.
> > > > >
> > > > > Thanks Qu Wenruo, for above info.
> > > > > I cloned below git tree as mentioned in your git log to test for RW
> > > > > onPower.
> > > > > However, I still see that RW mount for bs < ps is disabled for in
> > > > > open_ctree()
> > > > > https://github.com/adam900710/linux/tree/subpage
> > > > >
> > > > > I see below code present in this tree.
> > > > >            /* For 4K sector size support, it's only read-only */
> > > > >            if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
> > > > >                    if (!sb_rdonly(sb) ||
> > > > > btrfs_super_log_root(disk_super)) {
> > > > >                            btrfs_err(fs_info,
> > > > >            "subpage sectorsize %u only supported read-only for page
> > > > > size %lu",
> > > > >                                    sectorsize, PAGE_SIZE);
> > > > >                            err = -EINVAL;
> > > > >                            goto fail_alloc;
> > > > >                    }
> > > > >            }
> > > > >
> > > > > Could you pls point me to the tree I can use for bs < ps testing on
> > > > > Power?
> > > > > Sorry if I missed something.
> > > >
> > > > Sorry, I updated the branch to my current development progress, it's now
> > > > at the ordered extent rework part, without the remaining subpage
> > > > functionality at all.
> > > >
> > > > You may want to grab this tree instead:
> > > > https://github.com/adam900710/linux/tree/subpage_old
> > > >
> > > > But please keep in mind that, you may get random hang, and certain
> > > > generic test case, especially generic/075 can corrupt the inode nbytes
> > > > and leaving all later test cases using TEST_DEV to report error on fsck.
> > > >
> > >
> > > Thanks for quick response. Sure, I will exclude generic/075 from the test
> > > for now.
> >
> > Not only generic/075, but all tests running fsx may cause inode nbytes
> > corruption.
> >
> > Thus I'd recommend either modify btrfs-check to ignore it, or re-mkfs on
> > TEST_DEV after each test case.
>
> Good news, you can fetch the subpage branch for better test results.
>
> Now the branch should pass all generic tests, except defrag and known
> failures.
> And no more random crash during the tests.

Thanks, let me test it on PPC64 box.

-ritesh

>
> And for btrfs/143, it will no longer trigger a BUG_ON(), although at the
> cost of worse granularity for repair.
> (Now it's per-bvec repair, not yet fully per-sector repair).
>
> I'll rebase the branch in recent days to latest misc-next, but the
> current branch is already good enough for full subapge RW support.
>
> Thanks,
> Qu
> >
> > Thanks,
> > Qu
> >
> > >
> > > -ritesh
> > >
