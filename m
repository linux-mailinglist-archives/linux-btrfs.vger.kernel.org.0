Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274F63801E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 04:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhENC1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 22:27:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29444 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhENC1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 22:27:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14E2JNAL066139;
        Thu, 13 May 2021 22:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=WTVsqF7awjYZ58DmdJ7J4aaIOxt9YtpFgqys5M9YhwI=;
 b=CA+V1ZYoc58h5/c0spGXS7YbmZq0zkms+kZtZFS/fufGbyswe9ZwGkjOnCRPQj8icQ6A
 5OzEcqIXgFX2+dDs6Iyct0jpjIcBKtJrHpR5JGkNjgtTuVXgl4s0zxwbMv+JTdgUBPFd
 f5nIhEC9WHVlgyQnHb3Zvij88N/DCH92+AirXnxmXFC44S7MFGlDTE9kj5jJzg+Mx/vp
 INNTmhPd5tqoga7tV7VzXMU1MwTAqYe+AdFtqgrm9KERSs9QAbDDtJbfZvozWgPLRL3n
 wInD3bUv+CS1imgum7QSig6anD3O/9XRL2Kyzbs6YW96CScfeQHBeQilwM+ufHHh0tey eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hgapr346-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 22:26:15 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14E2K46n072265;
        Thu, 13 May 2021 22:26:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hgapr33j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 22:26:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14E2NPhI011504;
        Fri, 14 May 2021 02:26:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38hc6cr21x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 02:26:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14E2QAEJ41222552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 02:26:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9AF142049;
        Fri, 14 May 2021 02:26:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 674FB42045;
        Fri, 14 May 2021 02:26:10 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 May 2021 02:26:10 +0000 (GMT)
Date:   Fri, 14 May 2021 07:56:09 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514022609.lixjorvhu6mwsaoe@riteshh-domain>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210513225409.GL7604@twin.jikos.cz>
 <2b05bb47-f16c-62dd-d234-8bffdd332081@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b05bb47-f16c-62dd-d234-8bffdd332081@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 63ibXWqF9CvlTLb7MhI2Cw_2lJnSFkbd
X-Proofpoint-ORIG-GUID: REPSwnjHSYahmeWtKEgKYPGTL-3ZpSWB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_01:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140011
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/14 09:41AM, Qu Wenruo wrote:
>
>
> On 2021/5/14 上午6:54, David Sterba wrote:
> > On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
> > > > > Do you think the patches 1-13 are safe to be merged independently? I've
> > > > > paged through the whole patchset and some of the patches are obviously
> > > > > preparatory stuff so they can go in without much risk.
> > > >
> > > > Yes. I believe they are OK for merge.
> > > >
> > > > I have run the full tests on x86 VM for the whole patchset, no new
> > > > regression.
> > > >
> > > > Especially patch 03~05 would benefit 4K page size the most, thus merging
> > > > them first would definitely help.
> > > >
> > > > Just let me to run the tests with patch 1~13 only, to see if there is
> > > > any special dependency missing.
> > >
> > > Yep, patch 1~13 with the v5 read time repair patches are safe for x86.
> > >
> > > So they should be fine for the next merge window.
> > > > >
> > > > > I haven't looked at your git if there are updates from what was posted,
> > > > > but I don't expect any significant changes, but what I saw looked ok to
> > > > > me.
> > > >
> > > > I haven't touched those patches since v2 submission, thus there
> > > > shouldn't be any modification to them.
> > > > (At most some cosmetic change for the commit message/comments)
> > > > >
> > > > > If there are changes, please post 1-13 (ie. all the preparatory
> > > > > patches), I'll put them to misc-next so you can focus on the rest.
> >
> > I did another pass and found a few unimportant style fixes, it's now
> > pushed to branch ext/qu/subpage-prep-13. I'll run tests before merging
> > it to misc-next, the cleanups are great, some changes scare me a bit
> > though. Handling the ordered extents gets changed a bit, nothing
> > obviously wrong but based on past experience there are some subtle bugs
> > lurking.
>
> Yes, that's also what I'm a little concerned of.
>
> But with more understanding on ordered extent, it should be less a
> concern, at least for x86.
>
> Currently the biggest change is in the new
> btrfs_mark_ordered_io_finished(), it will do extra skip for range
> without Ordered (Private2) bit.
>
> For x86 it shouldn't be a big problem as one page represents one sector,
> and the only location we may get such call is for cases we don't need to
> submit IO.
>
> Those cases are fully covered by fstests, according to my countless
> crashes/failures during initial tests.
>
> Other than that, the btrfs_mark_ordered_io_finished() behavior should be
> the same as old one, at least for x86.
>
> Although more tests are always helpful.

If it helps, I tested "-g quick" on PPC64 with 64k config for 1-13 patches of
this patch series and didn't find any regression/crash with xfstests.
I am running "-g auto" now, will let you know the results once it completes.

-ritesh


>
> Thanks,
> Qu
> >
> > The plan is to add the branch to misc-next soon so we have enough time
> > to test it. I'll reply to the individual patches with comments that
> > stand out among the trivialities.
> >
