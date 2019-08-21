Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF19B976F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfHUKRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 06:17:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfHUKRC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 06:17:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LADqWF042554;
        Wed, 21 Aug 2019 10:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IVLDqqCZrsGOn3LWIqYZ8zfVdylPo1owAi3xe9CpsD4=;
 b=OpLQlZC1JDWLZkk2FHCOCdQZ/nNCPVic7xNi7MFl6bPnXibQtwQbTuZsPhtaxa5OQ6E3
 kS4UpbsOk4+8MMXkVNIZVy+UWvqaInc07XIeoMHZDATe2HM7yzg9NxbRySxQ2VhiBEuh
 ONJfviefkPVvnRY8WObPcSxDViZe01bmacJYUUsGOUNyL16ZLNd+iri6k38MWxh3cdNH
 DKQsJ5QP9mISfhoQAKKsmqtpApqJwCVnQj8u7wElqN41Re5RvEv17RxePFdEoGKcHCdm
 28PqiOWr/ZDpEdoXDoig1kNoaj4ZVL08G3OCxWfQ9fqxfBS/m1qrZhMA3u07dUW/XI3I pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90tms66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 10:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LADmK0055580;
        Wed, 21 Aug 2019 10:16:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ug269urts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 10:16:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LAGZMG028180;
        Wed, 21 Aug 2019 10:16:35 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 03:16:35 -0700
Subject: Re: [PATCH v2 2/2] btrfs: compression: replace set_level callbacks by
 a common helper
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1566313756.git.dsterba@suse.com>
 <779b3811b04d18b861f14166b2f67ac402df7a88.1566313756.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <adfb48ec-8cc8-2d0a-bce8-fda730e2f919@oracle.com>
Date:   Wed, 21 Aug 2019 18:16:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <779b3811b04d18b861f14166b2f67ac402df7a88.1566313756.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210110
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/8/19 12:17 AM, David Sterba wrote:
> The set_level callbacks do not do anything special and can be replaced
> by a helper that uses the levels defined in the tables.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/compression.c | 20 ++++++++++++++++++--
>   fs/btrfs/compression.h |  9 ++-------
>   fs/btrfs/lzo.c         |  6 ------
>   fs/btrfs/zlib.c        |  9 ---------
>   fs/btrfs/zstd.c        |  9 ---------
>   5 files changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 60c47b417a4b..53376c640f61 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1039,7 +1039,7 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
>   	struct list_head *workspace;
>   	int ret;
>   
> -	level = btrfs_compress_op[type]->set_level(level);
> +	level = btrfs_compress_set_level(type, level);
>   	workspace = get_workspace(type, level);
>   	ret = btrfs_compress_op[type]->compress_pages(workspace, mapping,
>   						      start, pages,
> @@ -1611,7 +1611,23 @@ unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
>   			level = 0;
>   	}
>   
> -	level = btrfs_compress_op[type]->set_level(level);
> +	level = btrfs_compress_set_level(type, level);
> +
> +	return level;
> +}
> +
> +/*
> + * Adjust @level according to the limits of the compression algorithm or
> + * fallback to default
> + */
> +unsigned int btrfs_compress_get_level(int type, unsigned level)
> +{
> +	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
> +
> +	if (level == 0)
> +		level = ops->default_level;
> +	else
> +		level = min(level, ops->max_level);
>   
>   	return level;
>   }
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index cffd689adb6e..4cb8be9ff88b 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -156,13 +156,6 @@ struct btrfs_compress_op {
>   			  unsigned long start_byte,
>   			  size_t srclen, size_t destlen);
>   
> -	/*
> -	 * This bounds the level set by the user to be within range of a
> -	 * particular compression type.  It returns the level that will be used
> -	 * if the level is out of bounds or the default if 0 is passed in.
> -	 */
> -	unsigned int (*set_level)(unsigned int level);
> -
>   	/* Maximum level supported by the compression algorithm */
>   	unsigned int max_level;
>   	unsigned int default_level;
> @@ -179,6 +172,8 @@ extern const struct btrfs_compress_op btrfs_zstd_compress;
>   const char* btrfs_compress_type2str(enum btrfs_compression_type type);
>   bool btrfs_compress_is_valid_type(const char *str, size_t len);
>   
> +unsigned int btrfs_compress_set_level(int type, unsigned level);
> +

    btrfs_compress_set_level() is undefined.

Thanks, Anand




>   int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
>   
>   #endif
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index adac6cb30d65..acad4174f68d 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -507,11 +507,6 @@ static int lzo_decompress(struct list_head *ws, unsigned char *data_in,
>   	return ret;
>   }
>   
> -static unsigned int lzo_set_level(unsigned int level)
> -{
> -	return 0;
> -}
> -
>   const struct btrfs_compress_op btrfs_lzo_compress = {
>   	.init_workspace_manager	= lzo_init_workspace_manager,
>   	.cleanup_workspace_manager = lzo_cleanup_workspace_manager,
> @@ -522,7 +517,6 @@ const struct btrfs_compress_op btrfs_lzo_compress = {
>   	.compress_pages		= lzo_compress_pages,
>   	.decompress_bio		= lzo_decompress_bio,
>   	.decompress		= lzo_decompress,
> -	.set_level		= lzo_set_level,
>   	.max_level		= 1,
>   	.default_level		= 1,
>   };
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 03d6c3683bd9..df1aace5df50 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -418,14 +418,6 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
>   	return ret;
>   }
>   
> -static unsigned int zlib_set_level(unsigned int level)
> -{
> -	if (!level)
> -		return BTRFS_ZLIB_DEFAULT_LEVEL;
> -
> -	return min_t(unsigned int, level, 9);
> -}
> -
>   const struct btrfs_compress_op btrfs_zlib_compress = {
>   	.init_workspace_manager	= zlib_init_workspace_manager,
>   	.cleanup_workspace_manager = zlib_cleanup_workspace_manager,
> @@ -436,7 +428,6 @@ const struct btrfs_compress_op btrfs_zlib_compress = {
>   	.compress_pages		= zlib_compress_pages,
>   	.decompress_bio		= zlib_decompress_bio,
>   	.decompress		= zlib_decompress,
> -	.set_level              = zlib_set_level,
>   	.max_level		= 9,
>   	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
>   };
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index b2b23a6a497d..0af4a5cd4313 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -710,14 +710,6 @@ static int zstd_decompress(struct list_head *ws, unsigned char *data_in,
>   	return ret;
>   }
>   
> -static unsigned int zstd_set_level(unsigned int level)
> -{
> -	if (!level)
> -		return ZSTD_BTRFS_DEFAULT_LEVEL;
> -
> -	return min_t(unsigned int, level, ZSTD_BTRFS_MAX_LEVEL);
> -}
> -
>   const struct btrfs_compress_op btrfs_zstd_compress = {
>   	.init_workspace_manager = zstd_init_workspace_manager,
>   	.cleanup_workspace_manager = zstd_cleanup_workspace_manager,
> @@ -728,7 +720,6 @@ const struct btrfs_compress_op btrfs_zstd_compress = {
>   	.compress_pages = zstd_compress_pages,
>   	.decompress_bio = zstd_decompress_bio,
>   	.decompress = zstd_decompress,
> -	.set_level = zstd_set_level,
>   	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
>   	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
>   };
> 

