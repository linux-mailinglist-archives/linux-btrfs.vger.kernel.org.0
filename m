Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D5396D1B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFAGDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 02:03:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhFAGDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Jun 2021 02:03:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1515X8aV026408;
        Tue, 1 Jun 2021 02:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=C+Ja4IeSdgYjWMIxPEcBbaXGK3Rx6Su6fqp5kiZ0Ecs=;
 b=dnq3jB6MTqKPP+8lrPJNPM3DesfpYmR3CHcW3P662ZaUqWAHyohCMDOefeYAYZM+AbAT
 WjGtvHo4uSc6wT2uBvdpmUxIl7UJ+3qaNxBsrULzEZG8XoY+p0kH7iz5nwAwLBIATj3R
 hyN0FLzuROGtXseRxoGqBDA2Vc6EOyCRmJCVmiCxwe8qODCeqdkSuH2Cah/Kpi+Mebrt
 z4R0h6uBI6LK8OkdI1DNroDD9Gb6gM8Z+KutJTXaGLk51ivhwkA0JifRj0aH3vaIkQm9
 EhfosUY5cn10ZWVl2YHNkZbL1dGOZ7evuNM3YkGjdD1zLYXd5BqDmeJSbgu4fjPTNbnw zw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38weub8j62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:01:36 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1515qack024658;
        Tue, 1 Jun 2021 06:01:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 38ud880sfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:01:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15161VFU18547056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 06:01:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC5AA4059;
        Tue,  1 Jun 2021 06:01:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0251EA4040;
        Tue,  1 Jun 2021 06:01:31 +0000 (GMT)
Received: from localhost (unknown [9.85.75.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 06:01:30 +0000 (GMT)
Date:   Tue, 1 Jun 2021 11:31:29 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH] btrfs: Fix return value of btrfs_mark_extent_written()
 in case of error
Message-ID: <20210601060129.3n7eohzswwpddv63@riteshh-domain>
References: <76ddeec8b7de89c338b8cb94ee2c4015a0be6e2f.1622386360.git.riteshh@linux.ibm.com>
 <20210531184931.GE31483@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531184931.GE31483@twin.jikos.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K-UT9nCad6z9LRpIaMzcZo5Y70rk5Eib
X-Proofpoint-ORIG-GUID: K-UT9nCad6z9LRpIaMzcZo5Y70rk5Eib
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=858
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010035
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/31 08:49PM, David Sterba wrote:
> On Sun, May 30, 2021 at 08:24:05PM +0530, Ritesh Harjani wrote:
> > We always return 0 even in case of an error in btrfs_mark_extent_written().
> > Fix it to return proper error value in case of a failure.
>
> Oh right, this looks like it got forgotten, the whole function does the
> right thing regarding errors and the callers also handle it.
>
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> > Tested fstests with "-g quick" group. No new failure seen.
>
> That won't be probably enough to trigger the error paths but the patch

Yes. However, I found the bug while stress testing btrfs/062 failure
with bs < ps patch series from Qu.
On analyzing the kernel panic [1], it looked like it was caused by not
properly returning an error from btrfs_mark_extent_written().
So, I thought of just running "-g quick" test to avoid any obvious issue.

[1]: https://www.spinics.net/lists/linux-btrfs/msg113280.html

> otherwise looks correct to me. Added to misc-next, thanks.

Thanks
