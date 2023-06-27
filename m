Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948B73F472
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjF0GYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 02:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjF0GYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 02:24:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749C1BEC
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687847032; x=1688451832; i=quwenruo.btrfs@gmx.com;
 bh=ThlhZhdMLaYJFL13B0mXCHOfH8N0KdYg/sPkt/EB39Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AgDETPA0l13B9s7/onyEUZs76dpncWBPxxCpiQql6upel6kfPYvWrgRXX4D1nMfya0TT9Ik
 B45mm82FOgrx+V3iynMxiYyiAaO0wWKR3WKTj9yJV4bJmWV6Ab4gMXUK36acjZPcLFcjl8Wl2
 WWj/fYQ/RhdNOZFCfrOze2kygs9szDcsWvOkpKCf6fkBlPe9ZS6jC1RpYwDeCF8azjfIAqOM4
 xypKkOhddjv706L1C4RqfsPZwx4wy/3/Oqwbcs8a4J8yQDm+GZk4SgbGKR3m1SjdY5+Z9TDXN
 eimy2KyloqqQ0/lxUaDkn4CFCylilpEUZqx96ALsbArzPNlgt6fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvY8-1qa9SR1jBQ-00UpM0; Tue, 27
 Jun 2023 08:23:52 +0200
Message-ID: <5ed6c3b8-887d-f863-ddd7-92f55389b099@gmx.com>
Date:   Tue, 27 Jun 2023 14:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] btrfs: be a bit more careful when setting
 mirror_num_ret in btrfs_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230627061324.85216-1-hch@lst.de>
 <20230627061324.85216-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230627061324.85216-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbrJ/0Zz7JHzz3FZIMRKCRZHUUYoYQDPHxU4VW/ShF8Ss4tdA/V
 aMYg2Yy/ssn3i0xLLfStrw0gn8XB3Er1k8ri8X8dMVEFaBs1Ns7vPwep+Gpus87KY7iWKor
 HCd4CwTMWwhHfsd1TgHtq0aMSwGL6TLV3jyhnVZUo/akhxKIYAagHdvTrClsANj8ksbPtDf
 Dm3iBgeHPxF2Bx4Fj1KPg==
UI-OutboundReport: notjunk:1;M01:P0:1q3FMJsYFTg=;d6PYJZYH8hsK3RbGqMcaTySh8KO
 rn7ffeoq13vJGNgQ7Xnl0ZFJnjII2Y/grfvTuOfjfl7vLBQiJ9TrErYbKKJOh6MiKX5zfVTMf
 gXMQKv+bJqXza6g/4gmnVftazSyCQl6CyrygCjvrn27pA5Fc4kf+1aRdkw+B8lT44iNGmedkj
 1EO+VhP8odKwK1MzS4JbR0UvGFNSxdUKEFVjo05koEV2fFkbfHRfB3AlazN0KT1hjz8NZZ1eI
 A8oqpk0f0PG5gyx+qA9qn/zWrgWRw06zRSIqQ54k6Unk9LIEJbJmVcaRunfdup9mCEqlD0xAW
 5haP+5dGOiVAHpD3xScggzAdvtZP1U6Rv+KC3uDT9Q+wJgGarMpVCyJkPeAXK446EPdKbTg3X
 DZjiDMNRBehg/AI26i9r5TSEB1uHhr2b+ijbM6leuE7W5WEvAXPxLJqYvNFpOCUrlAUkHeuKo
 sITGX4MRPrsjppBynrHHqK+bJqUVEf9zsCfCMB6mWBEqOTabB8ZesrWRwiwSPjROgQ4HEodDS
 SGt0wQGPlYBh6akoaRqyPydw1ff5jWHQTRumEStqPIqDbCX5wlrems0yZ+4D1Yw5dsjL+m0V4
 EFGAbDWS5WRkVvP1mryJEEMYTU7+QAiVMzmqhfZZaUv8biNSG+1cDQgXdZXDoIoBa/NRvYWOC
 fUdMBI7a6de3wqWW+xMM0zxDyVHnXHALYJG7PVE6ICTBjJYASoy8elQ+JXkoAgWSeWZMazf4L
 pPfwEYNxzcZKZaB8uN+o7PXuGBUWVVtXM531k/Ki2g3uw5yFDibHpwjv0B+i1s4AWKIFCIGhB
 ER4F1aT3Eu7JfGyGA4ON/9ga03z54hftgjEnOn3TofcrffHtLFFQIqXEw2Lbm4ZO4la83mL6O
 rlK1xB1sFdSGC+DObRTk7CI5uNL2OnsMSHGQZdJo4tEBsFiojmXivwtNNclTufG8FOxStGQ68
 +/INxXAzVCrzBN0geOuOmCtcXIM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 14:13, Christoph Hellwig wrote:
> The mirror_num_ret is allowed to be NULL, although it has to be set when
> smap is set.  Unfortunately that is not a well enough specifiable
> invariant for static type checkers, so add a NULL check to make sure the=
y
> are fine.
>
> Fixes: 03793cbbc80f ("btrfs: add fast path for single device io in __btr=
fs_map_block")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a536d0e0e05566..0d386ed44279ce 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6406,7 +6406,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   	    (op =3D=3D BTRFS_MAP_READ || !dev_replace_is_ongoing ||
>   	     !dev_replace->tgtdev)) {
>   		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
> -		*mirror_num_ret =3D mirror_num;
> +		if (mirror_num_ret)
> +			*mirror_num_ret =3D mirror_num;
>   		*bioc_ret =3D NULL;
>   		ret =3D 0;
>   		goto out;
