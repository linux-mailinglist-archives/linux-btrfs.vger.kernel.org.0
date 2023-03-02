Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61D6A8CF6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCBXZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBXZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:25:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BE1EBF1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:25:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ykg-1pdui62TNW-0064ST; Fri, 03
 Mar 2023 00:25:37 +0100
Message-ID: <4e6f4da8-a246-64bb-d59e-adce87abe1c3@gmx.com>
Date:   Fri, 3 Mar 2023 07:25:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/10] btrfs: move zero filling of compressed read bios
 into common code
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I2UAEHf/oI1iR3g+joURueYuGFUYNew48yK8OPE5CXaXS4KhiVP
 rD+GccN4+6dAQHRe0uLUu/aPyhQedm1uwl9tUFSZefPeBwj9wm2NwRizh1ShaUuu7fyWu91
 wPHp0fB5P7BnbDbIoJmK/D0R6svJMqz72GAr3RQTXDEnugqsjVrUfnFYbGQHWN8w7eY2qIC
 KO4tNxTqKomFG2+r3+uNQ==
UI-OutboundReport: notjunk:1;M01:P0:gU9vXkF0bEw=;U70GBD5tRcnqHsvsp6ac73zlKeF
 j9hz8hGYbkdYg43j7ZZ62+64R2DRn5JQzHd4+8q+/wOejF4bvEVFK6ubY73FjfDxVS56LPQtj
 PhyAbyeMT840FqdjwIlc+nUl8OnMIGjrraK3HD6zZdQ2C9MGdcKgSX6LZD0Zk86Ha+V7sUUD2
 9MNkJ5LL3VxuWcunHGyWy7G5RU2GBLnUUabxcg0m0DVUVa1CmW68JKi/obuPRrb6/nkrDDeeS
 JzsJWtupG8Q3m1ewUToy2lm1Um2goWVUU32X/PrbCqaPsaYntX7mnMy+QNhAcyo3VbHWwIc2c
 sHX91jy/8os3ovuadBlWnh015F07lPO02B72olD5mjj5glhNQMuGkVvwbmco6jRVNkt/GBL3L
 oN48vVzjtAW0avYgP5F02vkvcO3JcPSK/RWCZzgvXqp3d+EVCfVfv5FtzMkJsGmshuvkMBVu7
 UHOF7wGtyOYw1kw+MytwU74jWB+Vg2igKqE3r4p8DQ7zF8BP+yh4UHj9PGM6Cxh9Dxd511kMe
 18BbQhs0Qpyot3MRAOmK1h5Uwa0xsouWhJG1z+SmLeJocVKsWIJ6ATSCaRQOtJgKv4wgS/hPK
 DwQiwo9O1hkubfXNm/lO/6vDXZBmR09LK/YimMFpjjYQtF6ill/yyt/izcNI72mJKEXvS3E0G
 g+OPl3/5aa6uGojoKF8PKA+5A2SO/cyGM530hV06eu/ZN3E2ITEz9w/l6MEB3dnDqC4X7OMUG
 fwCbB6a69MKZSqYBrC8EuNw+lq9/72e9FayzEixyWNBhPrLJsesEOTuFYGk6XBMJcJMF56JN+
 /y//uQqAEdIEKJBg3jMkQzMSK9SJJOIjJHUw8iHQdWeYazcT4XpS6LELepRk/MC3OHoFAxRAI
 D+7bnr3tsshcOafIs6V0ESBkkUIMOjcW8Z8yLhUDfR3Nuxi30uhlK0r+RYko0GGRDoLPipx9D
 ZjEnLpHkEfJ40G50oq6z/1Az5PU=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> All algorithms have to fill the remainder of the orig_bio with zeroes,
> so do it in common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/compression.c |  2 ++
>   fs/btrfs/lzo.c         | 14 +++++---------
>   fs/btrfs/zlib.c        |  2 --
>   fs/btrfs/zstd.c        |  1 -
>   4 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 5b1de1c19991e9..64c804dc3962f6 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -965,6 +965,8 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
>   	ret = compression_decompress_bio(workspace, cb);
>   	put_workspace(type, workspace);
>   
> +	if (!ret)
> +		zero_fill_bio(cb->orig_bio);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index dc66ee98989e90..3a095b9c6373ea 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -389,8 +389,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   			 */
>   			btrfs_err(fs_info, "unexpectedly large lzo segment len %u",
>   					seg_len);
> -			ret = -EIO;
> -			goto out;
> +			return -EIO;
>   		}
>   
>   		/* Copy the compressed segment payload into workspace */
> @@ -401,8 +400,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   					    workspace->buf, &out_len);
>   		if (ret != LZO_E_OK) {
>   			btrfs_err(fs_info, "failed to decompress");
> -			ret = -EIO;
> -			goto out;
> +			return -EIO;
>   		}
>   
>   		/* Copy the data into inode pages */
> @@ -411,7 +409,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   
>   		/* All data read, exit */
>   		if (ret == 0)
> -			goto out;
> +			return 0;
>   		ret = 0;
>   
>   		/* Check if the sector has enough space for a segment header */
> @@ -422,10 +420,8 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   		/* Skip the padding zeros */
>   		cur_in += sector_bytes_left;
>   	}
> -out:
> -	if (!ret)
> -		zero_fill_bio(cb->orig_bio);
> -	return ret;
> +
> +	return 0;
>   }
>   
>   int lzo_decompress(struct list_head *ws, const u8 *data_in,
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index da7bb9187b68a3..8acb05e176c540 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -350,8 +350,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   	zlib_inflateEnd(&workspace->strm);
>   	if (data_in)
>   		kunmap_local(data_in);
> -	if (!ret)
> -		zero_fill_bio(cb->orig_bio);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index e34f1ab99d56fe..f798da267590d4 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -609,7 +609,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   		}
>   	}
>   	ret = 0;
> -	zero_fill_bio(cb->orig_bio);
>   done:
>   	if (workspace->in_buf.src)
>   		kunmap_local(workspace->in_buf.src);
