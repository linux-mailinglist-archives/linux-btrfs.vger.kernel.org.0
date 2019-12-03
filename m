Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34FF10FC24
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 12:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCLET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 06:04:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfLCLET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 06:04:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3AvrWM012191
        for <linux-btrfs@vger.kernel.org>; Tue, 3 Dec 2019 06:04:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnp8r8qyg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2019 06:04:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-btrfs@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 3 Dec 2019 11:04:15 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 11:04:12 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3B4BoU46858470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 11:04:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579E14C04A;
        Tue,  3 Dec 2019 11:04:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 986BF4C052;
        Tue,  3 Dec 2019 11:04:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.56.131])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Dec 2019 11:04:10 +0000 (GMT)
Date:   Tue, 3 Dec 2019 13:04:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix btrfs_find_create_tree_block() testing
References: <20191203093036.fp4rbgm56yzbw6ku@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203093036.fp4rbgm56yzbw6ku@kili.mountain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19120311-0012-0000-0000-0000037049B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120311-0013-0000-0000-000021AC051F
Message-Id: <20191203110408.GA30629@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=2 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030088
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Tue, Dec 03, 2019 at 12:33:04PM +0300, Dan Carpenter wrote:
> The btrfs_find_create_tree_block() uses alloc_dummy_extent_buffer() for
> testing and alloc_extent_buffer() for production.  The problem is that
> the test code returns NULL and the production code returns error
> pointers.  The callers only check for error pointers.
> 
> I have changed alloc_dummy_extent_buffer() to return error pointers and

nit:		alloc_test_extent_buffer()

> updated the two callers which use it directly.
> 
> Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/btrfs/extent_io.c                   | 6 ++++--
>  fs/btrfs/tests/free-space-tree-tests.c | 4 ++--
>  fs/btrfs/tests/qgroup-tests.c          | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index eb8bd0258360..2f4802f405a2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5074,12 +5074,14 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>  		return eb;
>  	eb = alloc_dummy_extent_buffer(fs_info, start);
>  	if (!eb)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	eb->fs_info = fs_info;
>  again:
>  	ret = radix_tree_preload(GFP_NOFS);
> -	if (ret)
> +	if (ret) {
> +		exists = ERR_PTR(ret);
>  		goto free_eb;
> +	}
>  	spin_lock(&fs_info->buffer_lock);
>  	ret = radix_tree_insert(&fs_info->buffer_radix,
>  				start >> PAGE_SHIFT, eb);
> diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
> index 1a846bf6e197..914eea5ba6a7 100644
> --- a/fs/btrfs/tests/free-space-tree-tests.c
> +++ b/fs/btrfs/tests/free-space-tree-tests.c
> @@ -452,9 +452,9 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
>  	root->fs_info->tree_root = root;
>  
>  	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
> -	if (!root->node) {
> +	if (IS_ERR(root->node)) {
>  		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(root->node);
>  		goto out;
>  	}
>  	btrfs_set_header_level(root->node, 0);
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
> index 09aaca1efd62..ac035a6fa003 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -484,9 +484,9 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
>  	 * *cough*backref walking code*cough*
>  	 */
>  	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
> -	if (!root->node) {
> +	if (IS_ERR(root->node)) {
>  		test_err("couldn't allocate dummy buffer");
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(root->node);
>  		goto out;
>  	}
>  	btrfs_set_header_level(root->node, 0);
> -- 
> 2.11.0
> 

-- 
Sincerely yours,
Mike.

