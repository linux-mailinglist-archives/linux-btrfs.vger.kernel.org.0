Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0E64B193
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiLMIzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMIzH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:55:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A8F4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:55:05 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1oeQwP0Kch-00mItw; Tue, 13
 Dec 2022 09:54:58 +0100
Message-ID: <b5bf8d50-67e4-e575-0e67-b9f72fe9f9fc@gmx.com>
Date:   Tue, 13 Dec 2022 16:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 7/8] btrfs: call rbio_orig_end_io from recover_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AvjS8dRoEb4xPxbIRzqV01tpO2rQV1M6Dj2VSheKR7gZI9qLzsY
 IXJD16L9wpry/hT98XzwWo4Gs9mmQ5i1Pf3RycTSXr6NBxK40WOSI185yMaGa8fhhWL6Lyn
 8wkWHgFF3D4tllbZsv7P5Cf27DQ1M7UHYTPJznaqN8s/bBwK0mxf0IoTP2QHUn6t5Q1I/WF
 OKUDjjgIxi16iyyrcTTcg==
UI-OutboundReport: notjunk:1;M01:P0:UJOOWxZDnwA=;s3TLv2OPsykhR9sJzwXWjhcWouS
 S5Ql6fJiAFa7H6DuVUMfn2uWJPo5BVPmyxtSU6yhaYPjzLww16E5dKX9qyDnOW3EkK876CgCD
 YMLIK/b+bLoaFeQzODtsYi8P6BYqLsMxwUv0t+ObMnawYQpSRCD4mLgg4TTprBz48UEqr9obs
 bnA1IF3V6zBWUmY5a6TIeLtC2JN8BOdkN3+aqrRDkn/K+CIo/NCzuqFXAco8Yod1Xstl6Dcpq
 q27Lzm3Ytm+jDwKPUPQZU1sEfwyWGXqPtCWTngOCtYH6iBnz9IWEVeJKdVOpGW24nwScBgs/u
 2HLciYNKWKVXRaBNutoaFepvzkbIN62AilATD+UWplGQch1jD5+V2tP7gRic1tDVY18Z/av+m
 svxSRFZw8LyGAIREnPrs76IgupMjBlVznv577DCeN08wV+4veq+WCoAR2ewz8eio7sw75+rWQ
 JttOd2wWVI2h/o6GdImEDQuXWOmRXnPnK5xXaz86uB4JbNAwvML9lfH6H7BpPR9qeRB+GbKy+
 bh9GZMyQPjCdzZpmMSwYF0FY9ldQFu5USUSkYHJzSaSEI2qu6xM8AtXnR9hkkVdFe4c9+g4a5
 sNV8GW5G+oaJwNURhv1EXmc25xCCb2IS1wlL/eEh1radlEy/mX30/9T9rMRTMnodvEjTbwirO
 UFW2AQmZijObbLbDhXEu/XLwqifWWkxcsKBj9mvgzxs8c+1Kd5n/QVDjWbCBR9m2mwxQdmRwu
 /QmLzVvEx/KL2nBd/2NYBsokj3pIR2hfgXVbHexXYCrjTO3U866FCRTNZZt+j4Rg2h95NxWqT
 rFoMQZ6GB2PCCLf2jZ6pHViIJHfGEIDhre3Khr845BAq9ZikFmrFaPbAORfKT2QrpegH+mZoo
 LMrmUEsEmfELB38Se9r/bbRnpVpf+MRLe6G7rhtBoasZmZdazw7hhOWjzUuBANrgz6jrGBMlQ
 El1OR3L8cnlydo8siBsN8NnoU28=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> Both callers of recover_rbio call rbio_orig_end_io right after it, so
> move the call into the shared function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 2432c2d7fcbed0..b2e02f02294163 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1985,7 +1985,7 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   	return -EIO;
>   }
>   
> -static int recover_rbio(struct btrfs_raid_bio *rbio)
> +static void recover_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	struct bio *bio;
> @@ -2000,13 +2000,13 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	/* For recovery, we need to read all sectors including P/Q. */
>   	ret = alloc_rbio_pages(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	index_rbio_pages(rbio);
>   
>   	ret = recover_assemble_read_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	submit_read_bios(rbio, &bio_list);
>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> @@ -2014,32 +2014,22 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	ret = recover_sectors(rbio);
>   	while ((bio = bio_list_pop(&bio_list)))
>   		bio_put(bio);
> -	return ret;
> +out:
> +	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
>   }
>   
>   static void recover_rbio_work(struct work_struct *work)
>   {
>   	struct btrfs_raid_bio *rbio;
> -	int ret;
>   
>   	rbio = container_of(work, struct btrfs_raid_bio, work);
> -
> -	ret = lock_stripe_add(rbio);
> -	if (ret == 0) {
> -		ret = recover_rbio(rbio);
> -		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> -	}
> +	if (!lock_stripe_add(rbio))
> +		recover_rbio(rbio);
>   }
>   
>   static void recover_rbio_work_locked(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio;
> -	int ret;
> -
> -	rbio = container_of(work, struct btrfs_raid_bio, work);
> -
> -	ret = recover_rbio(rbio);
> -	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> +	recover_rbio(container_of(work, struct btrfs_raid_bio, work));
>   }
>   
>   static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_num)
