Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347C83570F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbhDGPuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 11:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353856AbhDGPuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 11:50:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137FWx8Y152448;
        Wed, 7 Apr 2021 11:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=weeg01njSU2kIBTbmfHt26ub7F2NMWkDQo0rBDM7m0E=;
 b=DB+hNgwd1u3HxcDIYJoc9jQ8cdJJJWNJLRFoyEryMOzLzyRl0+ufX8lzOlER5F2MTa5g
 QIaDc3G4ZVTt4SR/kvjHJVXRkRye4bnYbX1lRGs8X+urYW6ewOPlWXKT2LRPlHabtDrt
 4Yit8FRKIfuO4jaJqip4EU638yaR02zKweEuu2yMU0LYdVY7ZwntgcB6YpGo/GsmKXUM
 RwYf9pEp+uDx7OazPS21vC4ccDPftifBshJ7e8dDObMf8FvcAvXjpOP4NcYBX0FPzZ5x
 j2pBoDRIQ/oB5hlRLINb5IvBnY2hk0s6AABCLFSa9JYfoIiFG/2bWH2N3H84iv/1XLqa XQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7jp0vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 11:49:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137Fb5V9003578;
        Wed, 7 Apr 2021 15:49:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 37rvbqgurj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 15:49:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137FnmoD38666618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 15:49:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4EFEAE055;
        Wed,  7 Apr 2021 15:49:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94A3FAE053;
        Wed,  7 Apr 2021 15:49:47 +0000 (GMT)
Received: from localhost (unknown [9.85.69.78])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 15:49:47 +0000 (GMT)
Date:   Wed, 7 Apr 2021 21:19:46 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] btrfs: Use reada_control pointer instead of void
 pointer
Message-ID: <20210407154946.xqvwajsmh77pejvt@riteshh-domain>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
 <20210406162404.11746-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406162404.11746-2-rgoldwyn@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YerjrsTATCZ25POkLnXlj1dgi2il2_Uf
X-Proofpoint-ORIG-GUID: YerjrsTATCZ25POkLnXlj1dgi2il2_Uf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=966 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070109
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/06 11:24AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> Since struct reada_control is defined in ctree.h,
> Use struct reada_control pointer as a function argument for
> btrfs_reada_wait() instead of a void pointer in order
> to avoid type-casting within the function.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h | 2 +-
>  fs/btrfs/reada.c | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2acbd8919611..8bf434a4f014 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3699,7 +3699,7 @@ struct reada_control {
>  };
>  struct reada_control *btrfs_reada_add(struct btrfs_root *root,
>  			      struct btrfs_key *start, struct btrfs_key *end);
> -int btrfs_reada_wait(void *handle);
> +int btrfs_reada_wait(struct reada_control *rc);

While we are at it we may as well make this function return void.
Since we anyways always return 0 and no one seems to be handling the return
value anyways.


>  int btree_readahead_hook(struct extent_buffer *eb, int err);

I guess, you may want to look into return value from this function too.
I don't think that too is being checked by any of it's callers.

-ritesh
