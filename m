Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC1597E1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiHRFbE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 01:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiHRFbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 01:31:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A636AFAD1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 22:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660800655;
        bh=nsV7Nr/JUG56NhAd0SAeDtIMyyWFX9/U18p+AUjhpSU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YUc57L/NrhKO0kPYRqSYtL/L2Yz9HpJ8cq1imxXuP1jfC9PzXuWMiM6blL/e+pEWJ
         jv2B//wwAYSZIsJ32cv0JShv59tJ5imFCTbvqLHlsUD8SFzalQ7EUF0cPsJd07c9Od
         sqOIghaZQQSu+8WrxXcu/smkSrk33wKeLRYEAFSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1nLC7v0rbZ-013OmL; Thu, 18
 Aug 2022 07:30:54 +0200
Message-ID: <13f00165-53f8-1f16-7857-8749e21f3fa2@gmx.com>
Date:   Thu, 18 Aug 2022 13:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3]btrfs: round down stripe size and chunk size to pow of
 2
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220817145800.36175-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220817145800.36175-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n2+PMfUq+cY6AzHgtpdmoYaz3Ra1bTcW9Q+qV+Huf8mONxMVhsg
 afHSsUCbz7rvtulrXYCecWk7Kk0hNA/RNMxq2qHnWRfz9wjKJWsOcCvF9nnDktzX8V6O7TJ
 56zNxTPnuMk6JJXpgArXa0pNKPFoo67pYLtWvRiDKGZ9GU2Y7xWj5q7gBbYj9YZ5V+1xRi+
 iPBIt4mWFxdYx/BLDYwIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iwJZbYpcLQ=:k3bbU8TwIWy7h7ZwrBVvcE
 +G5Ql6/D9HPlBWImu493W0kwzhHfOoy6q1iyHS2C2TypS4n8Q5rOZem603Zpr+SXsjHMvJaDm
 bpWeOwm+rumg/QXVFQpQ/oCHtaFDXDmkotgli2kBdj08iyt9fz7HnkOvHz+fdOobFvZQZ2D9U
 BvnNSAcxNsvBPo82z05+oPKlcQFtjG2QNsurWmHKbs7NajASs9FbgH815iGxY3RpwS3LqQ76l
 IK+cjJ6TxkoziDEPHGg90O5Izqma0Gdgg1GqPWFYQv4NGgvG28QGCRNeex66GtQHsSBeKNHkc
 tFNdl25GSolbPAGYmdratJRv+p8w2XtcSyan1b0eJX1p9Xep83HY6TmRQvbrZlRYEBYXOftaT
 lAV5ELLLVl3f4+LdqLkHHm3SYgTCeqcnOshf9pSMKtuZAyrNUO61GstZEB1QhBwybzFAtm9+m
 LzpNmTx99uYN5ESgPaJ41ZMqkMJNCaCNxne3LPf7kuZM53rCuhpyOG5U7XXi2Hgp74P2GR0Lr
 /25w3sfOW9V2NkZjyP+QAcn1Jz00SOhY+zbnyuw50ENe3rGeDWEh4RkIgKGenmva4hNKUkd3A
 cKutAA28t/m7mY25cVTlgS7G02gx8qp//i99r8kK8+6U/tyyzozCtNXULGT+g9Rbo0IBGJ61Q
 kDKP4iePru0AjcE4BodmIh6Z8J29rn1qXOrCj0ZhDJttjd1iEhCj1Oxb3gb5GpWQ7EIDFaiMk
 yNjZGOGlYnqMITunhgkTIu5IEzOmPDbTWjUq7U0+4/b9Pbs7MGXfcP8kJ9kd4wRKuf95SPQvG
 zc0d3oWfKMlAsLDLJvLwluxGw//8M70NAT42IXW3Q8OYJkJkTQ9NlbQPsuqbjx9izqzzFFTsH
 32MkXaTTxJZ8TZ0E+kDcgkkjcx7Sdc5Vg+f4OVYAUzozF2rRqwImBx4OtT+2IZ8n7SovSLPPV
 ThUFsyDJeVQXC4JBGcLKxNfq0Br3pDixDfzc9ufX1cgXdX1ngyOiz/J6qVZCX7umwRv2L5WZ+
 rdut5J1Bzo0I15Lvly54ztNRLsvqqU323bK+u4Gk/zZu//6aoINPyZAd+PQ146CA5FegE1ejG
 vMvgSAGoB1eSPTx6r0jcY4+vsKbK5QwBWc2nTjespLxhlMlCbPtB1/m0Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/17 22:58, Wang Yugui wrote:
> In decide_stripe_size_regular(), when new disk is added to RAID0/RAID10/=
RAID56,
> it is better to free-then-reuse the free space if stripe size is kept or
> changed to 1/2. so stripe size of pow of 2 will be more friendly. Althou=
gh
> roundup_pow_of_two() match better with orig round_up(), but
> rounddown_pow_of_two() is better to make sure <=3Dctl->max_chunk_size he=
re.

Why insist on round*_pow_of_two()?

I see no reason that a power of 2 sized chunk has any benefit to btrfs.

>
> In another rare case that file system is quite small, we calc max chunk =
size
> in pow of 2 too, so that max chunk size / chunk size /stripe size are sa=
me or
> match easy in some case.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> changes since v2:
> 	restore to rounddown_pow_of_two() from roundup_pow_of_two()
> changes since v1:
>   - change rounddown_pow_of_two() to roundup_pow_of_two() to match bette=
r with
>     orig roundup().
>
>   fs/btrfs/volumes.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6595755..fab9765 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5083,9 +5083,9 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
>   		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK=
);
>
> -	/* We don't want a chunk larger than 10% of writable space */
> -	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1),
> -				  ctl->max_chunk_size);
> +	/* We don't want a chunk larger than 1/8 of writable space */
> +	ctl->max_chunk_size =3D min_t(u64, ctl->max_chunk_size,
> +			rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
>   	ctl->dev_extent_min =3D BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>
> @@ -5143,10 +5143,9 @@ static void init_alloc_chunk_ctl_policy_zoned(
>   		BUG();
>   	}
>
> -	/* We don't want a chunk larger than 10% of writable space */
> -	limit =3D max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
> -			       zone_size),
> -		    min_chunk_size);
> +	/* We don't want a chunk larger than 1/8 of writable space */
> +	limit =3D max_t(u64, min_chunk_size,
> +		rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
>   	ctl->max_chunk_size =3D min(limit, ctl->max_chunk_size);
>   	ctl->dev_extent_min =3D zone_size * ctl->dev_stripes;
>   }
> @@ -5284,13 +5283,12 @@ static int decide_stripe_size_regular(struct all=
oc_chunk_ctl *ctl,
>   	 */
>   	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
>   		/*
> -		 * Reduce stripe_size, round it up to a 16MB boundary again and
> +		 * Reduce stripe_size, round it down to pow of 2 boundary again and
>   		 * then use it, unless it ends up being even bigger than the
>   		 * previous value we had already.
>   		 */
> -		ctl->stripe_size =3D min(round_up(div_u64(ctl->max_chunk_size,
> -							data_stripes), SZ_16M),
> -				       ctl->stripe_size);
> +		ctl->stripe_size =3D min_t(u64, ctl->stripe_size,
> +			rounddown_pow_of_two(div_u64(ctl->max_chunk_size, data_stripes)));
>   	}
>
>   	/* Align to BTRFS_STRIPE_LEN */
