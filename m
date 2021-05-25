Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB3390194
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhEYNEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 09:04:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233052AbhEYNEH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 09:04:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PCdvMs142223;
        Tue, 25 May 2021 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zvhlKv52LyKiov399dpcx514W8Rq+ZbpZYeorABV+aU=;
 b=WWBMC6rof7ZkZi1O0sKaF1iLdxFCT1om9wR/ZFYvkdH8AwXo9GNNB0WPcImZE/AgKXic
 vU7KgzkTZGz3UUuxvhbR0dgFbIZyHSHchO9ElGDuReURlflUbcbR4Y1o48AnallWJD9M
 wBUQ7+/3AhrjzcpjWWzMuJ7H34eJRvszVP4cRD5rYGwH2TUs+FXlQFxnm1hw4h1b5dry
 s0l/CW89vTBCygVyCUW82lwGo0aqSHiD9Rj+sgyJJWLBo8KfLBrvxwjygKXRpcnM5YhT
 3sbG2Dnyd65N/Hb+g5qBr3/UphnGtA29s7K3Qx93WMKyV6fCJ6lmpfjZZ32bcdVHBbQk cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s0fwu2j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:02:34 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PCfEZ8147197;
        Tue, 25 May 2021 09:02:33 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s0fwu2fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:02:33 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PCrN6w019853;
        Tue, 25 May 2021 13:02:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 38s1ht007h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:02:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PD2SfL29950360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:02:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7D21AE059;
        Tue, 25 May 2021 13:02:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52ABEAE051;
        Tue, 25 May 2021 13:02:28 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 13:02:28 +0000 (GMT)
Date:   Tue, 25 May 2021 18:32:27 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210525130227.ldhbj4x7sryr63bk@riteshh-domain>
References: <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
 <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
 <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q2ckEF_9JAlDfElifB9hZVTy-cNU0QWB
X-Proofpoint-GUID: n_P3fnpWFwqhOJGy4FoynotX77SZ30UK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxlogscore=900 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250077
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/25 07:41PM, Qu Wenruo wrote:
>
>
> On 2021/5/25 下午6:20, Ritesh Harjani wrote:
> [...]
> > > >
> > > > - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-
> > > >     bit memory addresses")
> > > >     Will screw up at least my ARM board, which is using device tree for
> > > >     its PCIE node.
> > > >     Have to revert it.
> > > >
> > > > - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
> > > >     Will screw up compressed write with striped RAID profile.
> > > >     Fix sent to the mail list:
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.85166-1-wqu@suse.com/
> > > >
> > > >
> > > > - Known btrfs mkfs bug
> > > >     Fix sent to the mail list:
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.129287-1-wqu@suse.com/
> > > >
> > > >
> > > > - btrfs/215 false alert
> > > >     Fix sent to the mail list:
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.119788-1-wqu@suse.com/
> > >
> > > Please wait for while.
> > >
> > > I just checked my latest result, the branch doesn't pass my local test
> > > for subpage case.
> > >
> > > I'll fix it first, sorry for the problem.
> >
> > Ok, yes (it's failing for me in some test case).
> > Sure, will until your confirmation.
>
> Got the reason. The patch "btrfs: allow submit_extent_page() to do bio
> split for subpage" got a conflict when got rebased, due to zone code change.
>
> The conflict wasn't big, but to be extra safe, I manually re-craft the
> patch from the scratch, to find out what's wrong.
>
> During that re-crafting, I forgot to delete two lines, prevent
> btrfs_add_bio_page() from splitting bio properly, and submit empty bio,
> thus causing an ASSERT() in submit_extent_page().
>
> The bug can be reliably reproduced by btrfs/060, thus that one can be a
> quick test to make sure the problem is gone.
>
> BTW, for older subpage branch, the latest one without problem is at HEAD
> 2af4eb21b234c6ddbc37568529219d33038f7f7c, which I also tested on a
> Power8 VM, it passes "-g auto" with only 18 known failures.
>
> I believe it's now safe to re-test.

Thanks. I will give your latest subpage github branch a run then :)

-ritesh

