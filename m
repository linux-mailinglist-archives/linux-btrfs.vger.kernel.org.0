Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31437B697
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELHKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 03:10:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229627AbhELHKr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 03:10:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C72jGG154678;
        Wed, 12 May 2021 03:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uIWnFrHNfyrW9ecuycbR25fOtlL8avdnK5ZeIJnPLDI=;
 b=iexCmlsLVvIUvezCuL+iiSGASzkHcJShDr2WEETFIkIMS9GZZH8zSUVDFUYMCF2T0TxI
 Avusq3MT7054AcRPvFltkZ7Tjni/aFsamLCxHoN7kTI4F/AwD+qB0NOXq/28FSij9gcz
 NnsrnVZkoK15iRSh79TrFn9uEiu6cc8fKXiqJQgPMw4fwbaa0vET5flSXL0NfZ3ZbyZR
 fMzgGErhSKzrN2o7HLjfLVSLYcnjlgUp3P3uBF8zP8RxQhQgsFGpNV7VWHQ2eSE/diHE
 BKnWlWNcMGPBcCQCxsxvQ2D4nduG2+1Rnd7PDUfUQXXiEKj3/5JBDbpK04z5D2ikPKZU yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ga3q0fvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 03:09:37 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14C73YFf157485;
        Wed, 12 May 2021 03:09:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ga3q0ftk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 03:09:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14C72DwK026032;
        Wed, 12 May 2021 07:09:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj98a1bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 07:09:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14C79W6H61735408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 07:09:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91936A4051;
        Wed, 12 May 2021 07:09:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F5BAA404D;
        Wed, 12 May 2021 07:09:32 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 May 2021 07:09:32 +0000 (GMT)
Date:   Wed, 12 May 2021 12:39:31 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
References: <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
 <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
 <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lh2NfFjLOPNuOVvZnHZnu-kdxvGAQFsz
X-Proofpoint-ORIG-GUID: vN3l6Ll-gNZtfVC3djNW2U1612acycK5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_03:2021-05-11,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120050
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/12 09:49AM, Qu Wenruo wrote:
> Hi Ritesh,
>
> The patchset gets updated, and I am already running the tests, so far so
> good.
Sure, I have started the testing. Will update the results for both
4k, 64k configs with "-g quick", "-g auto" options on PPC64.

>
> The new head is:
> commit cb81da05e7899b8196c3c5e0b122798da3b94af0
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Mon May 3 08:19:27 2021 +0800
>
>     btrfs: remove io_failure_record::in_validation
>
> I may have some minor change the to commit messages and comments
> preparing for the next submit, but the code shouldn't change any more.
>
>
> Just one note, thanks to your report on btrfs/028, I even find a data
> corruption bug in relocation code.
Nice :)

> Kudos (and of-course Reported-by tags) to you!
Thanks!

>
> New changes since v2 patchset:
>
> - Fix metadata read path ASSERT() when last eb is already dereferred
> - Fix read repair related bugs
>   * fix possible hang due to unreleased sectors after read error
>   * fix double accounting in btrfs_subpage::readers
>
> - Fix false alert when relocating data extent without csum
>   This is really a false alert, the expected csum is always 0x00
>
> - Fix a data corruption when relocating certain data extents layout
>   This is a real corruption, both relocation and scrub will report
>   error.
Thanks for the detailed info.

>
> Thanks and happy testing!
Thanks for the quick replies and all your work in supporting bs < ps.
This is definitely very useful for Power platform too!!

-ritesh
