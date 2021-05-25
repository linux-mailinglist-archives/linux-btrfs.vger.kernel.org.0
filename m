Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6A38FEEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEYKVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 06:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhEYKVu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 06:21:50 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PA4jAK165315;
        Tue, 25 May 2021 06:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BbBpbvsXlfW05D4ng1t57Hj02jz12s5C4ifHTWnrT0c=;
 b=SAeeSIpNLDtW9nN8LtDgV0iVUS3SWjYogGob+fpWk9N0rb+XFuRInZqle7C7EXTkPpZE
 2afkAnE3sHgJIX+Ca68RACxMoQ8kl9MA57lRxCKE0qtQ6TdhhThCEv25eiWJcnIC9tqL
 nH6U/pfHnhf6zpS8os8pnqx3OQLC8Dl2mnJJngnUutD3Co7PIQM1Ow5YPgvWG87MddC5
 T7dEqPns7ht0PFuBIQIMxD/iD7bCEg6TkBrTHwcT8pGcF/fUqi96k2/2bZ8a+OQaE+/t
 mzcgQCR+gamJhkFRcYV2Sk+HN0oAKSBZOMolYHRCqSZYR9zlv+SI3r4goVaTlCoWaRuk 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ry488h6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 06:20:17 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PA5FMi168572;
        Tue, 25 May 2021 06:20:17 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ry488h5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 06:20:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14PAJLiJ004673;
        Tue, 25 May 2021 10:20:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38ps7h98cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:20:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PAKBUQ21758424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 10:20:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 599F35205A;
        Tue, 25 May 2021 10:20:11 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 105655205F;
        Tue, 25 May 2021 10:20:10 +0000 (GMT)
Date:   Tue, 25 May 2021 15:50:10 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
References: <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cpg5_C-Fyfs_mtFTTjojiNIq86ukJvvT
X-Proofpoint-GUID: AltM1Ou9dyWtn5bOKnJKSbQqJp3zpF2h
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_05:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250066
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/25 05:49PM, Qu Wenruo wrote:
>
>
> On 2021/5/25 下午5:45, Qu Wenruo wrote:
> [...]
> > > >
> > > > What a relief, it's not a big problem in my patchset, but more likely to
> > > > be in the test case, especially in the how the mirror number is chosen.
> > > >
> > > > When the test failed, you can find in the dmesg that, there is not any
> > > > error mssage related to csum mismatch at all.
> > > >
> > > > This means, we're reading the correct copy, no wonder we won't submit
> > > > read repair.
> > > > This is mostly caused by the page size difference I guess, which makes
> > > > the pid balance read for RAID1 less perdicatable.
> > > >
> > > > I don't yet have any good idea to fix the test case yet, so I'm afraid
> > > > we have to consider it as a false alert.
> > >
> > > Ohk gr8, Thanks a lot for looking into it.
> > > I saw the change log of v3, though I don't think there are any changes
> > > from when
> > > I last tested the whole patch series, still I will give it a full run
> > > with v3
> > > for both 4k and 64k config, (since now mostly all issues should be
> > > fixed).
> >
> > Just to be more clear, there are some known bugs in the base of my
> > subpage branch:
> >
> > - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-
> >    bit memory addresses")
> >    Will screw up at least my ARM board, which is using device tree for
> >    its PCIE node.
> >    Have to revert it.
> >
> > - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
> >    Will screw up compressed write with striped RAID profile.
> >    Fix sent to the mail list:
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.85166-1-wqu@suse.com/
> >
> >
> > - Known btrfs mkfs bug
> >    Fix sent to the mail list:
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.129287-1-wqu@suse.com/
> >
> >
> > - btrfs/215 false alert
> >    Fix sent to the mail list:
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.119788-1-wqu@suse.com/
>
> Please wait for while.
>
> I just checked my latest result, the branch doesn't pass my local test
> for subpage case.
>
> I'll fix it first, sorry for the problem.

Ok, yes (it's failing for me in some test case).
Sure, will until your confirmation.

-ritesh


>
> Thanks,
> Qu
>
>
> >
> >
> > Thanks,
> > Qu
> > >
> > > Thanks
> > > -ritesh
> > >
> > >
> > > >
> > > > Thanks,
> > > > Qu
> > > > >
> > > > > Thanks again for the awesome report!
> > > > > Qu
> > > > > >
> > > > > >
> > > > > > -ritesh
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > 2. btrfs/124 failure.
> > > > > > > >
> > > > > > > > I guess below could be due to small size of the device?
> > > > > > > >
> > > > > > > > xfstests.global-btrfs/4k.btrfs/124
> > > > > > > > Error Details
> > > > > > > > - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
> > > > > > >
> > > > > > > Again passes locally.
> > > > > > >
> > > > > > > But accroding to your fs, I notice several unbalanced disk usage:
> > > > > > >
> > > > > > > # /usr/local/bin/btrfs filesystem show
> > > > > > > Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
> > > > > > >      Total devices 2 FS bytes used 32.00KiB
> > > > > > >      devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
> > > > > > >      devid    2 size 2.00GiB used 622.38MiB path /dev/vdi
> > > > > > >
> > > > > > > Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
> > > > > > >      Total devices 4 FS bytes used 379.12MiB
> > > > > > >      devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
> > > > > > >      devid    3 size 20.00GiB used 264.00MiB path /dev/vde
> > > > > > >      devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
> > > > > > >
> > > > > > > We had reports about btrfs doing poor work when handling
> > > > > > > unbalanced disk
> > > > > > > sizes.
> > > > > > > I had a purpose to fix it, with a little better calcuation, but still
> > > > > > > not
> > > > > > > yet perfect.
> > > > > > >
> > > > > > > Thus would you mind to check if the test pass when all the disks in
> > > > > > > SCRATCH_DEV_POOL are in the same size?
> > > > > > >
> > > > > > > Of course we need to fix the problem of ENOSPC for unbalanced
> > > > > > > disks, but
> > > > > > > that's a common problem and not exacly related to subpage.
> > > > > > > I should take some time to refresh the unbalanced disk usage patches
> > > > > > > soon.
> > > > > > >
> > > > > > > Thanksm
> > > > > > > Qu
> > > > > > >
> > > > > > > [...]
> > > > > > > >
> > > > > > > > -ritesh
> > > > > > > >
> > > > > >
> > > > > >
