Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21555FF54
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 03:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfGEBao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 21:30:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGEBao (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jul 2019 21:30:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x651TvDZ070913;
        Fri, 5 Jul 2019 01:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bGTIYI8717dWhfhyxjBDcmBLshj15C0WoZw3LyJTbjY=;
 b=ygznaC3TRQTJxjiTK/uVUVJAtodhn55yD08HaeSvhF0rwZ0rJJAm0qQEnyD+bnMZ6s99
 R4r470Ga3knHIM4sr4NRiXdYmbsLKTvxZEHXML1YvFjSkx7llr0d6KjPjB4ZTAOJJZx0
 Fq0ZF0fM6mvPvqFhPNtBZM2CxsVDX2+XKO6J6DyA/oAP+5ms04okPSzkOQJqb0XFtGBn
 HUh7CMxBWjmp3dmnE5H4xXPHgJutrKqulR/ELGYnLGok+EnwfsO0Il9Py/TB91e//Hbz
 +yIOmJWLw4RDPLUuUhP2W1pfn0ebbQ+xGOxf16hlYRDsDqOpEu8sp7F3k/CwYjNNYyMs og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61q8m9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 01:30:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x651Rk6N158408;
        Fri, 5 Jul 2019 01:30:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2th5qm8vqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 01:30:36 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x651UZeD022100;
        Fri, 5 Jul 2019 01:30:35 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 18:30:35 -0700
Subject: Re: [PATCH][next][V2] btrfs: fix memory leak of path on error return
 path
To:     Colin King <colin.king@canonical.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704230303.5583-1-colin.king@canonical.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <50990311-dc66-677b-0bd8-4a2ea62eba9c@oracle.com>
Date:   Fri, 5 Jul 2019 09:30:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704230303.5583-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050018
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/19 7:03 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the allocation of roots or tmp_ulist fails the error handling
> does not free up the allocation of path causing a memory leak. Fix this and
> other similar leaks by moving the call of btrfs_free_path from label out
> to label out_free_ulist.
> 
> Kudos to David Sterba for spotting the issue in my original fix and
> providing the correct way to fix the leak.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: move the btrfs_free_path to the out_free_ulist label as suggested by
>      David Sterba as the correct fix.
> 
> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1eb671c16ff1..31127f6d2971 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4766,11 +4766,11 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		ret = emit_last_fiemap_cache(fieinfo, &cache);
>   	free_extent_map(em);
>   out:
> -	btrfs_free_path(path);
>   	unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
>   			     &cached_state);
>   
>   out_free_ulist:
> +	btrfs_free_path(path);
>   	ulist_free(roots);
>   	ulist_free(tmp_ulist);
>   	return ret;
> 

Now this causes double free.

$ git diff
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b154bce5687..61ebdccca04b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4611,7 +4611,6 @@ int extent_fiemap(struct inode *inode, struct 
fiemap_extent_info *fieinfo,
         ret = btrfs_lookup_file_extent(NULL, root, path,
                         btrfs_ino(BTRFS_I(inode)), -1, 0);
         if (ret < 0) {
-               btrfs_free_path(path);
                 goto out_free_ulist;
         } else {
                 WARN_ON(!ret);


