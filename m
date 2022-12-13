Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB664B194
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiLMIz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiLMIz1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:55:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9FF4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:55:25 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsQ4-1pDmUf2mA4-008srU; Tue, 13
 Dec 2022 09:55:18 +0100
Message-ID: <1a63eca2-b057-49ad-0cf2-bc23ff93ca69@gmx.com>
Date:   Tue, 13 Dec 2022 16:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 8/8] btrfs: call rbio_orig_end_io from scrub_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q+84YUjuObGprOgyDdphsuCVUKlxQQzOPsOxJ9L8/OPp39PLndM
 CjdHXW6dPk/zA1l29+Nr4gsuopiIhmZsFgh8x9w9BbFcflKSnc7mVMA8F2zXZnuARtUQpcH
 EUpGWcLo0MHa9vH0m4J4bSHjMQN3j47cFl1zukoYu++VDNxivH2MMbcDHTB41SThru3DKmS
 +KiSnuBqWx8YiGB2t4n+A==
UI-OutboundReport: notjunk:1;M01:P0:+QwAcCPPvPc=;Gw63PUd/BhbwrTpb7BdoqtT8BRd
 vPzj+dSa3xBX+uYyaAO0BCKtCVp+S6LQ/LJ4cOrt6w3US2u0K3UZHIS982q6e7uaX/ImcL4RS
 3r+vV68EnuS8Q4KrpSmmLhuDkEWPD6F6UAerwoxQmP6GhqMQRUXV5uv0AuhT8RxJhYFsVKjXf
 Pn592r1Oqq5zdLApnIdD90mXGYxUnbFzvBljEqxZER3DP9tCu5k0emyZb+Xzsxgjw9fKvj1yL
 RMrw5b44BsV5sdwv2pJNjlBDaaILdb4v5pNstdBMlp9bsoWMLFAvrgP0UhLsQ9Xc2AabAhdk5
 WJ2qufTiOoi8laUduDGl19kDVZlLVBuBDlNiY/iH+nPmFwZ8le1VJiz40fehQqE17i24L3cbU
 Hk0PEVff9rsqDeOl5ZhlwCrO5NUYMjOilFJWd6Artv13wmFrYoDWW43B7Ewq2GPXABWPdB/p/
 vTsWL6J54mh1GfliLBRSKztimixRB83GvaT30QmNDnu4MC3FPrcQq08Ctemaa93L0QefbAC7R
 FcD7Hs6jR1llHf2m1RKCNLDASyWpJuVeU4kIM0hXm5yXvGHgDllkRgaNDeIRRn/XbEvdqRl5B
 I2PoJ7uctZ02vmVvIvxajB44cVQD0pxAM6lDEB473uJOI0QxhX/f/vvbtaG7hQhrqxCLxGI1j
 Q2BWxHOszF7il37y6dQiEsOoMXGLsBwwiSqxVVaHp0OZatc/DsdCcFxOnddE2JrBONcwzRKIV
 je1GnQdU76MinFV+8CWP+AWBM80Z4WsT/Hi7L0e/VCtk4ZnItWxIDemTHoGbqy8XPE35TWCDF
 NN30xMMCEG8mmpJMYdhc+yIEOTRuS17sM/iU/6HjCsKhCoSathcCihX37cyk/a0i4yhXil1IT
 eclEiy2wtKB0DoUQdw2y467WnMpRTMsqn5Wq1n5W7EJ2PYnFy+4YrySYFiDDsEeP3FfEYNfgH
 ZOm5LR2p5OCnlAFh5W70nk118Y0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> The only caller of scrub_rbio calls rbio_orig_end_io right after it,
> move it into scrub_rbio to match the other work item helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index b2e02f02294163..4f2d63bfddae3c 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2732,7 +2732,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   	return ret;
>   }
>   
> -static int scrub_rbio(struct btrfs_raid_bio *rbio)
> +static void scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list = BIO_EMPTY_LIST;
>   	bool need_check = false;
> @@ -2742,13 +2742,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   
>   	ret = alloc_rbio_essential_pages(rbio);
>   	if (ret)
> -		return ret;
> +		goto out;
>   
>   	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
>   
>   	ret = scrub_assemble_read_bios(rbio, &bio_list);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	submit_read_bios(rbio, &bio_list);
>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> @@ -2758,7 +2758,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   	if (ret < 0) {
>   		while ((bio = bio_list_pop(&bio_list)))
>   			bio_put(bio);
> -		return ret;
> +		goto out;
>   	}
>   
>   	/*
> @@ -2776,17 +2776,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   			break;
>   		}
>   	}
> -	return ret;
> +out:
> +	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
>   }
>   
>   static void scrub_rbio_work_locked(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio;
> -	int ret;
> -
> -	rbio = container_of(work, struct btrfs_raid_bio, work);
> -	ret = scrub_rbio(rbio);
> -	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> +	scrub_rbio(container_of(work, struct btrfs_raid_bio, work));
>   }
>   
>   void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
