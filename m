Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4349E635
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiA0PiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 10:38:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236698AbiA0PiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 10:38:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RF0sTE008853;
        Thu, 27 Jan 2022 15:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OiY7xQGOtMDUc16rw3tnwTW8C+KCo4uC6glXgiOK3kY=;
 b=aQHZYKJIC0VSomMeOnwbf5sepPGuPycJSVfGtBs2oOVx3EbJZgNZWmkU0a/fDugudcBf
 yiIjitM7takkNA1ZHm6WLY+nP+2pD7VM8nAqGYa+a2e5cPRvL6uTbYLhnyWmJoMbfC5z
 YHSI/ijQNqe/+UxURLaWCNHi4uBG3vCJAJLM7DL2hbt9Ch2+7/NjRjaasPLhyrL+9IaF
 nFLabZDdrLZaMzAICAhA596+W5DTtW9K983SiGRnmQt2ZyWrNdTEaCe8dNZ8tNlavyf4
 zmEQneZqP3O32Pl2mu6SHLPHBCBzGkCjRq45qDEL/kEDl0ccxFJCKt7CBpHpGXvZTgDZ Iw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duvxxhvct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:38:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RFI8Ii029059;
        Thu, 27 Jan 2022 15:38:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9smsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:38:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RFc8KF19136768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 15:38:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34EE9A405E;
        Thu, 27 Jan 2022 15:38:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFABA4057;
        Thu, 27 Jan 2022 15:38:07 +0000 (GMT)
Received: from localhost (unknown [9.43.91.218])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 15:38:07 +0000 (GMT)
Date:   Thu, 27 Jan 2022 21:08:06 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Message-ID: <20220127153806.vufsbus447s2tdib@riteshh-domain>
References: <20220127055306.30252-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127055306.30252-1-wqu@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fnhnSkZWl0tqm_LfeBh-n0fd0m40FpG1
X-Proofpoint-ORIG-GUID: fnhnSkZWl0tqm_LfeBh-n0fd0m40FpG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270094
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/27 01:53PM, Qu Wenruo wrote:
> There is a long existing bug in btrfs defrag code that it will always
> try to defrag compressed extents, even they are already at max capacity.
>
> This will not reduce the number of extents, but only waste IO/CPU.
>
> The kernel fix is titled:
>
>   btrfs: defrag: don't defrag extents which is already at its max capacity
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/257     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/257.out |  2 ++
>  2 files changed, 81 insertions(+)
>  create mode 100755 tests/btrfs/257
>  create mode 100644 tests/btrfs/257.out
>
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> new file mode 100755
> index 00000000..326687dc
> --- /dev/null
> +++ b/tests/btrfs/257
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 257
> +#
> +# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
> +# at their max capacity.

Haven't really looked into this fstest. But it is a good practice to add the
commit id and the title here for others to easily refer kernel commit.

-ritesh

