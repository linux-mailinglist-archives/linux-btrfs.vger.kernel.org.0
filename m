Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785966654DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjAKGuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjAKGu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:50:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E112A91
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:50:26 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDysm-1p5d280xsa-009u5Q; Wed, 11
 Jan 2023 07:50:20 +0100
Message-ID: <700f547b-184b-5b98-aa09-8780e15f3fa1@gmx.com>
Date:   Wed, 11 Jan 2023 14:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 09/10] btrfs: call rbio_orig_end_io from recover_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-10-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q1mTEz/CWXuiduM2RnPeI7ouYob1Lp5865jRnYlaNYE/KIHzrSZ
 f5z1a3nMQXgBuOE7zeRyr9E5yCu1LAvaYB14+Ms10vw9NZn3FajQ03Q34MVByV3afgdZhMX
 EcA4JsiVtEHaK2ts+DUMPkJ5f9A64s58n4A6NSvC6M2JWOESz1UUEZnYRDGB7iBVBSC+XyT
 fS2YVrnM8J9yfEghtn9tQ==
UI-OutboundReport: notjunk:1;M01:P0:ov3DGbNKuuY=;2h2XO2BEHWMZBFsXMRu+WVZpq2f
 Xx9Q8cNei183BLjCTA92p8wWWOi7iwuyfH+2pvKJfB9buVzt3ddm77ooOAgZZPdr0uGoG99ZR
 V6NNaDH9wz5TNiW5RjgR7+IJugvmoGjJQscrsRwmoCxOd+JBpH5GgSsqUoAAjTSH/qtfoSpkb
 0umpS4yf2zFnkNRWC4Uzar3ShwngDItH0OHhG4OiUPgAotK7v3EYp/dv16mb9bLnRPb+4XUNX
 cthpNblKXRqSDBsi1tCwcRMhu58txUIFnGkINi8c0MuFIGBRleu9d1gp3xtVP/dTK47rVfysW
 7js4EJonRstYITc/fIHTSGw0TwTk63hyACT/7JPQUCNIN3GAWmTeX0UxLgL7VPTxYgQ0H7nQE
 D4oWeiyMSCxpu60hU0dLDvmNC+ufEeAqZmfsBiePBg2HMzaxCUS+0QMfLxJHamHCvQGfLDNsR
 uhCmy5GfNdyqJPUpn7JzMjeMt57vK946oWeDTqxlR7E4qHfUXJ+CtChmv30jEOIKg1i72BBg9
 Of5CInY0zqjjpSoilYTwV1em60s1WmL1KrkuoN6LI1QJHWm8OURLbMsliA/U3r55UGGVqhsue
 BEcPosMUCIwZtcZ7rHdkkiL+ljCiF0/plCu0qw/BA5VC3RLBzHRL471a1hngIvkCpBlYR2mzV
 XgjEYwokv8g3/RjzCdxoWH/SNmCjSxJCkOO9BurUE1sTtaDeII2N+eDjX1ea31pekDh9BcbMo
 LCTjpE3aNB6NtODBUUSznhxfm1GkVsOrXD1Rt7Z5tCrj64PFJDO5wIU+JezVDNfWqm7uVO1Nl
 6JSDbAn/YcXWPmMu3enuIY/MZyfNTTEdq4LpxtJC16TRE5eiSnor1qGhKTFJKpkuZuSaLIP4U
 huxVmm4No3TxhJzXFIjLLY1qNyKgJTxKO3duuTD7OZ3uB6jc1PsvhCRpNiyRTegUsChzNg4e+
 O/O++KRd8ln5uYqiOLauzOUu4NY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> Both callers of recover_rbio call rbio_orig_end_io right after it, so
> move the call into the shared function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index a9947477daf26d..c007992bf4426c 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1907,7 +1907,7 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>   	return ret;
>   }
>   
> -static int recover_rbio(struct btrfs_raid_bio *rbio)
> +static void recover_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	int total_sector_nr;
> @@ -1922,7 +1922,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	/* For recovery, we need to read all sectors including P/Q. */
>   	ret = alloc_rbio_pages(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	index_rbio_pages(rbio);
>   
> @@ -1960,37 +1960,28 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   					 sectornr, REQ_OP_READ);
>   		if (ret < 0) {
>   			bio_list_put(&bio_list);
> -			return ret;
> +			goto out;
>   		}
>   	}
>   
>   	submit_read_wait_bio_list(rbio, &bio_list);
> -	return recover_sectors(rbio);
> +	ret = recover_sectors(rbio);
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
