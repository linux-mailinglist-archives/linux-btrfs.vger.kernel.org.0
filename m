Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD29649997
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiLLHeZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLLHeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:34:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109FC95A5
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:34:21 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42jK-1p4dKH3dpY-0005j0; Mon, 12
 Dec 2022 08:34:14 +0100
Message-ID: <0b8647ed-a987-4648-630e-a544888420dc@gmx.com>
Date:   Mon, 12 Dec 2022 15:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] btrfs: cleanup raid56_parity_write
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221212070611.5209-1-hch@lst.de>
 <20221212070611.5209-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221212070611.5209-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EaxsvG0LnEQA1LA16pUHLpnUCpiGzG3d+Y4PF1wFIbDimthwKZ9
 /7tzpgBT4+cHKmMtelbIZSjtH2VehQrjr14S/ayp72t/VqUx0zqPM0Ro4gUox0V0N2n/9iI
 2J6eP/c0XPMpdtoPxQmxiHw7IL3pdPrO2yJmOp7K/xbCYn2lKtR13yzkHgH31U8iSpwt1zO
 ViXtdghmTGthV4n7dNZ1w==
UI-OutboundReport: notjunk:1;M01:P0:puFK/4V+ll0=;xUUBctghqu1GIOLfA2l7fji/krK
 +ArnPuDGj35S0lvS0bLPF9MXK3WUunBV5hZk80qXjAml5j2qUpZ5SNJJkCOmDxIkGu4nNN+/w
 3fFpPIZYKX3Ah0VbvgB0cjkb0UEvWJBiwns2zGkYooYx8NyF1A60X4ei951MndD6uwrDliJEQ
 rF643fdN8gTnHJQYDJOG5vvs3QToWMU1F3YVM3uE5ohAFSASebebAmuIhAflsXfacxnwdmluz
 CI93Kr8jpPduEPIXyHwbDQ3y3HhBYmGGt0ThBZk/pb7f6dKppd8w37g/i/VYK50/pXru8r7xn
 3CHTQBq1faNJObRI93lN3B1PAVztnwXGMsj+9MNPhV5D7vYHonu9crNpiLLH4ap4iHXheTlj5
 kjsobUoWpCSOPx0fXcIX9W9pJZvuxJVl9RzTnmvw2bmYGuCQDNVBQVj1a79bYaepUz6d2SdXE
 uf9F1ndRM/UmL8x1UWviCsLsvBYLh1aU/cVpRbQCAgxntSQ/xiBMaSZBo4FpAQOSTabSwjuj1
 iQ+0NDVes1Yy2DCx973+A+JxeeILdpvK/2glY4kYIrj8kRfgVhHR+hunECQvCzOCXPYkWks+7
 LhdQh/ApIo1kZnqDfRuAY7Qm72spVaScSovZBryiQeUVek4MzpfEmvcXKMrFxUI1kRCQKIF7Y
 MFnVvsIsHn5+3TfUUuKJJjUUjEFPGBDWVMZfF1faJaRwu+8Fp0Zi1LiE1Pjj2mJb/2gb6NLmk
 PnSqovUHkLdBGxtzaJ5cZ22iliArBfkI0jL0t1S3cpwL4GEDgaPn3/xZR3AxqOHcEDA/XrQeh
 N3/fJzIfSKqn3Gn+evlFdb9GG1PBG/jBGgvizzwkMxm+JgAHtQDmf9H7HGZw9f9Rs1I43pjPw
 LjtnTbvHcORT05yr/SxSH5GOJV5Y/7CcqtcCckIb7gtoqvcbghCqynxcDBVI5u02RMrgF+szd
 Vux/JqUsJvsyPae6CvZ2JFAk4Dk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 15:06, Christoph Hellwig wrote:
> Handle the error return on alloc_rbio failure directly instead of using
> a goto, and remove the queue_rbio goto label by moving the plugged
> check into the if branch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I originally thought the goto way would save some lines of code, but it 
turns out to be the opposite.

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 37 +++++++++++++++----------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 2d90a6b5eb00e3..5603ba1af55584 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1660,12 +1660,12 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
>   	struct btrfs_raid_bio *rbio;
>   	struct btrfs_plug_cb *plug = NULL;
>   	struct blk_plug_cb *cb;
> -	int ret = 0;
>   
>   	rbio = alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
> -		ret = PTR_ERR(rbio);
> -		goto fail;
> +		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
> +		bio_endio(bio);
> +		return;
>   	}
>   	rbio->operation = BTRFS_RBIO_WRITE;
>   	rbio_add_bio(rbio, bio);
> @@ -1674,31 +1674,24 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
>   	 * Don't plug on full rbios, just get them out the door
>   	 * as quickly as we can
>   	 */
> -	if (rbio_is_full(rbio))
> -		goto queue_rbio;
> -
> -	cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
> -	if (cb) {
> -		plug = container_of(cb, struct btrfs_plug_cb, cb);
> -		if (!plug->info) {
> -			plug->info = fs_info;
> -			INIT_LIST_HEAD(&plug->rbio_list);
> +	if (!rbio_is_full(rbio)) {
> +		cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
> +		if (cb) {
> +			plug = container_of(cb, struct btrfs_plug_cb, cb);
> +			if (!plug->info) {
> +				plug->info = fs_info;
> +				INIT_LIST_HEAD(&plug->rbio_list);
> +			}
> +			list_add_tail(&rbio->plug_list, &plug->rbio_list);
> +			return;
>   		}
> -		list_add_tail(&rbio->plug_list, &plug->rbio_list);
> -		return;
>   	}
> -queue_rbio:
> +
>   	/*
>   	 * Either we don't have any existing plug, or we're doing a full stripe,
> -	 * can queue the rmw work now.
> +	 * queue the rmw work now.
>   	 */
>   	start_async_work(rbio, rmw_rbio_work);
> -
> -	return;
> -
> -fail:
> -	bio->bi_status = errno_to_blk_status(ret);
> -	bio_endio(bio);
>   }
>   
>   static int verify_one_sector(struct btrfs_raid_bio *rbio,
