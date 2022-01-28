Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615F749F192
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 03:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiA1C5K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 21:57:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbiA1C5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 21:57:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S2aJ55010692;
        Fri, 28 Jan 2022 02:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8NxdPlAMlPwuckeWNAJW5xxnE6UnboXF1xroucukYoQ=;
 b=S6LXjZ+gnxPAa0jMm99cdRFQfmLzA75OThoGE+O6TtqelJAVXHZMaNjzUeITbLAymsEB
 o9zMafPrfzZlI/G0Bb9rLjTRD1ZR78MUfJeq2HbmYhBzZDytTfhhiVQ/Gsx3fVpZkQal
 0Phx3QNYAvlhT0UOAoUnIXBqEoWHHHMWfl/PBO62vZJbrd1XZgVzyO8eh19MXsbdNb3h
 U/WF8vHYaBqr4nrH7hRuqAj/8m3UHVsRwzc7wlowLgLf81+qNYXuKF8BTuM/PPIjTo9J
 bF9NEIww1spvYi8iW3dcdQEUtcfr/oCW57Z6vNmAHRDVFTvR2emIa82f96PL1pyfjNrI AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wbp1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 02:57:06 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S2bscd016996;
        Fri, 28 Jan 2022 02:57:05 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wbp15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 02:57:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S2mILH025316;
        Fri, 28 Jan 2022 02:57:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3dr9ja36a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 02:57:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S2v0eG41746842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 02:57:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D22EDAE04D;
        Fri, 28 Jan 2022 02:57:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B102AAE045;
        Fri, 28 Jan 2022 02:56:58 +0000 (GMT)
Received: from localhost (unknown [9.43.76.191])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 02:56:58 +0000 (GMT)
Date:   Fri, 28 Jan 2022 08:26:56 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Message-ID: <20220128025656.z3a72e2xak66vbj7@riteshh-domain>
References: <20220127055306.30252-1-wqu@suse.com>
 <20220127153806.vufsbus447s2tdib@riteshh-domain>
 <92343b23-cf6c-e138-9cfe-79336cd1bb54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92343b23-cf6c-e138-9cfe-79336cd1bb54@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hPJm8xX1_SFrAL8fdnQu8d1Q6hM_Qf-R
X-Proofpoint-ORIG-GUID: YT2cVf0rdq5zUrXr7_DcOPIoDTI-1F56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280010
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/28 06:20AM, Qu Wenruo wrote:
>
>
> On 2022/1/27 23:38, Ritesh Harjani wrote:
> > On 22/01/27 01:53PM, Qu Wenruo wrote:
> > > There is a long existing bug in btrfs defrag code that it will always
> > > try to defrag compressed extents, even they are already at max capacity.
> > >
> > > This will not reduce the number of extents, but only waste IO/CPU.
> > >
> > > The kernel fix is titled:
> > >
> > >    btrfs: defrag: don't defrag extents which is already at its max capacity
> > >
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/257     | 79 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/257.out |  2 ++
> > >   2 files changed, 81 insertions(+)
> > >   create mode 100755 tests/btrfs/257
> > >   create mode 100644 tests/btrfs/257.out
> > >
> > > diff --git a/tests/btrfs/257 b/tests/btrfs/257
> > > new file mode 100755
> > > index 00000000..326687dc
> > > --- /dev/null
> > > +++ b/tests/btrfs/257
> > > @@ -0,0 +1,79 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 257
> > > +#
> > > +# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
> > > +# at their max capacity.
> >
> > Haven't really looked into this fstest. But it is a good practice to add the
> > commit id and the title here for others to easily refer kernel commit.
>
> Isn't that already in the commit message?

Yes, that's true. And thanks for adding that.
I generally found mentioning commit-id and commit-title
in the description section of the test too to be lot more helpful.

For e.g. tests/btrfs/232

# FS QA Test 232
#
# Test that performing io and exhausting qgroup limit won't deadlock. This
# exercises issues fixed by the following kernel commits:
#
# 4f6a49de64fd ("btrfs: unlock extents in btrfs_zero_range in case of quota
# reservation errors")
# 4d14c5cde5c2 ("btrfs: don't flush from btrfs_delayed_inode_reserve_metadata")

Though I don't think it is mandatory, but as I said, it is generally helpful
for anyone to refer to commit directly / title directly from here if it has
a commit-id (might be it's just me :))

Thanks!
-ritesh

