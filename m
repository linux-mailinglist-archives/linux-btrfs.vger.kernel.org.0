Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA721397F0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFBC3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:29:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229828AbhFBC3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Jun 2021 22:29:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1522EqZI088904;
        Tue, 1 Jun 2021 22:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t8+TEJwGvmOodk9xM7vC8sabSez5FVkZlJCs4eIFegQ=;
 b=pUoKUBSpBBlz2pbZvh2utSM9NeVOcAHGUrEz23LzdkGISlVQN6WvC14aQKMk1chqwdU4
 zGfFV6wq8rNpBv3+hWU3PBUnWnuZSuiJWQWYqZEN3MyUK44iHQTxWGkDK8E/RWZfiymc
 HKHgMSm6qpsRhlJdBmTaNxhncXFJlJkcPrENO8KFeweYEZFonAONwOTz2HbX8M3J0Iwv
 UzQtyFy/qP4x5KZ3mWv0IkHHpkuMATKQZhdqX8etsW7LWyaVD8UmD6wzaNZXOoWuLTU0
 gZmOINa7yFOK1kPg7LJ2qKvB9fNVqTvsohgBNlHmaUdVMl6L6mLQwZ1ktnozNpwsNOxJ dg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38x11e87m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 22:27:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1522Mh6v000380;
        Wed, 2 Jun 2021 02:27:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 38ud88142r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 02:27:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1522RrvV33096070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 02:27:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D66052051;
        Wed,  2 Jun 2021 02:27:53 +0000 (GMT)
Received: from localhost (unknown [9.85.75.172])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFFED52050;
        Wed,  2 Jun 2021 02:27:52 +0000 (GMT)
Date:   Wed, 2 Jun 2021 07:57:51 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
Message-ID: <20210602022751.m3x63imxqicwiygu@riteshh-domain>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210602022239.7ueomwrumsbbc5wu@riteshh-domain>
 <1008e8d0-ec68-05e6-19dd-83c5069e3119@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1008e8d0-ec68-05e6-19dd-83c5069e3119@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jZPWiYB8pNj5QsHvOiNCunspPa-6d4x1
X-Proofpoint-GUID: jZPWiYB8pNj5QsHvOiNCunspPa-6d4x1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_12:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106020011
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/06/02 10:24AM, Qu Wenruo wrote:
>
>
> On 2021/6/2 上午10:22, riteshh wrote:
> > On 21/05/31 04:50PM, Qu Wenruo wrote:
> > > This huge patchset can be fetched from github:
> > > https://github.com/adam900710/linux/tree/subpage
> > >
> > > === Current stage ===
> > > The tests on x86 pass without new failure, and generic test group on
> > > arm64 with 64K page size passes except known failure and defrag group.
> > >
> > > For btrfs test group, all pass except compression/raid56/defrag.
> > >
> > > For anyone who is interested in testing, please apply this patch for
> > > btrfs-progs before testing.
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/
> > > Or there will be too many false alerts.
> > >
> > > === Limitation ===
> > > There are several limitations introduced just for subpage:
> > > - No compressed write support
> > >    Read is no problem, but compression write path has more things left to
> > >    be modified.
> > >    Thus for current patchset, no matter what inode attribute or mount
> > >    option is, no new compressed extent can be created for subpage case.
> > >
> > > - No inline extent will be created
> > >    This is mostly due to the fact that filemap_fdatawrite_range() will
> > >    trigger more write than the range specified.
> > >    In fallocate calls, this behavior can make us to writeback which can
> > >    be inlined, before we enlarge the isize, causing inline extent being
> > >    created along with regular extents.
> > >
> > > - No support for RAID56
> > >    There are still too many hardcoded PAGE_SIZE in raid56 code.
> > >    Considering it's already considered unsafe due to its write-hole
> > >    problem, disabling RAID56 for subpage looks sane to me.
> > >
> > > - No defrag support for subpage
> > >    The support for subpage defrag has already an initial version
> > >    submitted to the mail list.
> > >    Thus the correct support won't be included in this patchset.
> > >
> > > === Patchset structure ===
> > >
> > > Patch 01~19:	Make data write path to be subpage compatible
> > > Patch 20~21:	Make data relocation path to be subpage compatible
> > > Patch 22~29:	Various fixes for subpage corner cases
> > > Patch 30:	Enable subpage data write
> > >
> > > === Changelog ===
> > > v2:
> > > - Rebased to latest misc-next
> > >    Now metadata write patches are removed from the series, as they are
> > >    already merged into misc-next.
> > >
> > > - Added new Reviewed-by/Tested-by/Reported-by tags
> > >
> > > - Use separate endio functions to subpage metadata write path
> > >
> > > - Re-order the patches, to make refactors at the top of the series
> > >    One refactor, the submit_extent_page() one, should benefit 4K page
> > >    size more than 64K page size, thus it's worthy to be merged early
> > >
> > > - New bug fixes exposed by Ritesh Harjani on Power
> > >
> > > - Reject RAID56 completely
> > >    Exposed by btrfs test group, which caused BUG_ON() for various sites.
> > >    Considering RAID56 is already not considered safe, it's better to
> > >    reject them completely for now.
> > >
> > > - Fix subpage scrub repair failure
> > >    Caused by hardcoded PAGE_SIZE
> > >
> > > - Fix free space cache inode size
> > >    Same cause as scrub repair failure
> > >
> > > v3:
> > > - Rebased to remove write path prepration patches
> > >
> > > - Properly enable btrfs defrag
> > >    Previsouly, btrfs defrag is in fact just disabled.
> > >    This makes tons of tests in btrfs/defrag to fail.
> > >
> > > - More bug fixes for rare race/crashes
> > >    * Fix relocation false alert on csum mismatch
> > >    * Fix relocation data corruption
> > >    * Fix a rare case of false ASSERT()
> > >      The fix already get merged into the prepration patches, thus no
> > >      longer in this patchset though.
> > >
> > >    Mostly reported by Ritesh from IBM.
> > >
> > > v4:
> > > - Disable subpage defrag completely
> > >    As full page defrag can race with fsstress in btrfs/062, causing
> > >    strange ordered extent bugs.
> > >    The full subpage defrag will be submitted as an indepdent patchset.
> >
> > Hello Qu,
> >
> > I have completed another 2 full iterations of testing this v4 with "-g all" on
> > Power. There are no failures reported (other than the known ones mostly due to
> > defrag disabled) and no kernel warnings/errors reported with v4 of your patch
> > series (other than a known one causing transaction abort -28 msg, but that seems
> > to be triggering even w/o your patch series i.e. with 64k blocksize too).
> >
> >  From the test perspective, please feel free to add below for your v4.
> >
> > Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> 		[ppc64]
> >
> >
> > I think since this patch series looks good, I can now start helping with defrag
> > patch series of yours :)
> > That should be on top of this v4 I guess.
>
> Exactly, and that has been just submitted.
>
> You can also fetch the branch from 'defrag_refactor' branch from my github
> repo.
>
> And since that branch only touches defrag ioctl, free feel to just test '-g
> defrag' test cases if you want a quick run.

Great! Thanks for the quick response.
Will start my testing.

-ritesh

