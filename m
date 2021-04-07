Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E07357119
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhDGPy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 11:54:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46886 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353966AbhDGPyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 11:54:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137FXn37054525;
        Wed, 7 Apr 2021 11:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OaaOkKq9NXm7G+LIt4BWFKHKOaQ9dvF7ezY1P3jWHZk=;
 b=Bp6VvaYsfsYjPRvnJPt61nmOXwtaqvlpTMyoNuvgx5FhXGanZEpqJh/k+/QCmj5m37dm
 +GFAJcm31hVHoOS3HzILkI/PcWMlKoBH9Adlkn5isP01vmj4Inb0DjUAYcT7jKwB0JQ7
 WiAVhWZSXaNtFVgJ+yBv33243dAHVxEShIJl9Q2eJOq++nA5KjvBoudW82AzlBzf3RwJ
 0KiySn+tZdFAZ0aEOVbUZyl1+o8m6hx4Nh5FFwbVUkwlgTY4sUoMhOlrWTxqC8R+ZElt
 2d+Dn0bZv5CfhGpDR8kbnggT8D4IZldVpxk928sAa4v7zfP2rHUjKkzEEil5ISJK++KR DQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpgedfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 11:54:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137FrUtP021945;
        Wed, 7 Apr 2021 15:54:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbw8uj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 15:54:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137Frwas50200980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 15:53:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A9D52050;
        Wed,  7 Apr 2021 15:53:58 +0000 (GMT)
Received: from localhost (unknown [9.85.69.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC54B5204E;
        Wed,  7 Apr 2021 15:53:57 +0000 (GMT)
Date:   Wed, 7 Apr 2021 21:23:56 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/2] btrfs: Remove unused function btrfs_reada_detach()
Message-ID: <20210407155356.7oq7dslpox7pujjs@riteshh-domain>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406162404.11746-1-rgoldwyn@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: obRWJ3JbS05CChhYuphFcoU92cxF7jtl
X-Proofpoint-GUID: obRWJ3JbS05CChhYuphFcoU92cxF7jtl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=993 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070109
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/06 11:24AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> btrfs_reada_detach() is not called by any function. Remove.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h | 1 -
>  fs/btrfs/reada.c | 9 +--------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>

Although not an expert in this area, but I would hopefully start doing more
reviews in btrfs and hence will be spending more time with it's code.

For this patch seems to be easy and trivial and looks fine to me.
Please feel free to add:-

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

