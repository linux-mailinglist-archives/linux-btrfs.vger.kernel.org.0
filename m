Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D3E60DB84
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 08:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiJZGnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiJZGnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 02:43:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E3AB81F;
        Tue, 25 Oct 2022 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666766581;
        bh=eVsqDAkO60zzzbCbPmbMbB6FmoKGwnDVc6iIXRS2xQE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Eh+1/LV1KQbNejOMOjQT68VnRhg/Bo72i7BhdDuxA/Vn8S0pLmltzfFAy5b7bnpVS
         6OG30FqC+4hm+yeN1mMXU4tIwitvABZmdTIk79GYW8NCNhbh3GUOHQdiJjnoi2/72j
         Psd9oY7k7K5r3xTTLbwXieGrPZDgfHCpcARzu7io=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1pSQi73IhR-00nvbt; Wed, 26
 Oct 2022 08:43:01 +0200
Message-ID: <26b65420-2609-26a5-9cc2-c12cabd310e0@gmx.com>
Date:   Wed, 26 Oct 2022 14:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] btrfs: volumes: Increase bioc pointer check
To:     Li zeming <zeming@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026013611.2900-1-zeming@nfschina.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221026013611.2900-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LdqUXrjaT/j5NJMl4erkVvo7lcGKi1JeZI9+pbALwv8uL4GPBj6
 7GW92Fe8TkNRUW/WA/g9lqa1Qmq7GlzgJaT3yf1eLtCbeXpFrO+GeDCd0vXTBNt04v738QP
 flL0/MUCcwyk7Juuy+uC7NuJePufvapx5nphWVACmso7Bz7kkavoXpLTgcJvkIuwvbK9A8f
 CVUYQr5i9AGX3kOIgckkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OmAyeGVG7fo=:bkGTXzA6qmQ1G+SJoZQfp/
 MdC1SnzTPRBEfZhFY0RdH3COJJj13PTopzYATcDvaYOo9IemjurKcz/PL6TxkSzODAHE++YCk
 q1/ROrttqNghpwIb6vaTSN9i7MxlAILQVAclYDzhmyQRl8VeMMHEiB2CZtJ5sykTC7CixUlMu
 k2e7JrBu+e0/nIbW7SEbkIdG9XzJ9A8pBju9ddw6s7IwXGI5tHsBAhTglwhrhBuKieqe17vgo
 0/gCuAxpIg7Yl3c04ryf7WvZyKnBTTUiS6iF326BYxToIfD8A0rIvPnD8Qkuonzv+Cy4upmWo
 1c2tmRkPh4VwL+ENQJn3kTKGyb4K/O4cOm9YGp78C/gPkV3uQRGgO8jNPRQERtZ6qfuOR0kGg
 JtCyeerDLP3gCxj6Rr3MrwxyaNLfstDaXbXl1ynwfJnoOdQ7rbBfnbjEGwNCYcD5KtJdMuRgk
 yTMjv++8xvYEI7qC5KZSPbQPouj/kNjVt+lCpSySTRVdwioGx0Lk3dJ1yUuomWmPA9du974y3
 pmw4qp+f5G5m1NFGyFBtV+f9XLq3H+uZaZHxqha2rAf3V5rDfbmbUG3TmeM+RXfqOMgWxBc2q
 qujrw0XA1IGOJzobGaKyrpin8bjNFhWpd4L9CMxkkD0K2sX0VuPfAmQIVvWm71QD2i9uZHwyu
 THsuY2le5N93VvRKXIegfdNa7ftG9wf0d+N8xTwnG/5DBxkClUxa+I0aDIgJHR61/zHQ2ZEpQ
 Oy0dhtOlL9adQ4dCYObBiWGSwB2i/yE/b6rPFy8N7tEGa7c9Fj93HOn7oMsHfy5pNwkAqqOst
 /wHB82ipNTNDxXvu/O63Ox4KnXgolIuOdyupPjUXo6FTdWpbFtogaPxwGLXsF/2nPUcGiiAuY
 q5D9nZRDpb/bSyofdxnTLL5710KaJZHvVASyBuuLun9AjK4UL1y5HaY8+J+XNtF6FtYL7M/1L
 J8HnpjL3cn3faADLpKId2VV7fTvtZq6sQ0RSMoKvzqDCQmDehCmQYIaSdkcYuiocYbDoJMdR0
 alp76SE2sV9erKm+8Af8oK3Q2rFwlFJDUXOqkJeo17LbF/06Lg++sVXiYKroC3/NIkk/i8IRi
 w1oZrgrOHBzdu2rnSWtbtvNrPg7gNbgKdSfwYdDgFvpXyQEV7gnwMSBwr9kCDbH4pjVKDbqlv
 7IoUaZKmWnpQibOfB8GMmPeWcRbbOIHbevemzp+D7mLtl7nrzzCheedMSu5p5gFzKuhJjMprg
 gy/H2MGIQmJPI1Z+3CNGG2aE5HV/dujK9sh1hwtMR0BrSCXotujqCUrmRFKRVSHJftjqVkqh8
 Y8LC2TUVRjf7uyaNBwnr4MEPOWvUfo2K1OPtDJmH/Zf6o2t1kh7/qSD4Dm7OcSgYMRUpig1Y/
 7Zy5ddSfiBpw36NOInbdWjpIK2Kno7lGf2Q5eRf7kR3Hk0rhZOGyN5EicrP1NtfnnQ9aBsJjU
 bJfOFOhQzKHdfsKkfK4Liax5bPl6tQxedptNmeMwSW/DXczEeHZEwosehpkbH1PiZPzAvYilD
 Z2ohChP7lapgfU8FJZeovPctRKphuyFj2AXrT3ltqspnn
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/26 09:36, Li zeming wrote:
> The __GFP_NOFAIL flag will cause memory to be allocated an infinite
> number of times until the allocation is successful, but it is best to
> use it only for very necessary code, and try not to use it.
>
> The alloc_btrfs_io_context function looks a little closer to normal
> (excuse my analysis), but I think we can remove __GFP_NOFAIL from it and
> add a bioc pointer allocation check that returns NULL if the allocation
> fails.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   v2: Add annotation vocabulary modify, remove __GFP_NOFAIL flag.
>   v3: Modifying the Description.
>
>   fs/btrfs/volumes.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 064ab2a79c80..b8d901f58995 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5891,7 +5891,9 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   		 * and the stripes.
>   		 */
>   		sizeof(u64) * (total_stripes),
> -		GFP_NOFS|__GFP_NOFAIL);
> +		GFP_NOFS);
> +	if (!bioc)
> +		return NULL;
>
>   	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
> @@ -6071,7 +6073,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(str=
uct btrfs_fs_info *fs_info,
>    * array of stripes.
>    * For READ, it also needs to be supported using the same mirror numbe=
r.
>    *
> - * If the requested block is not left of the left cursor, EIO is return=
ed. This
> + * If the requested block is not left of the left cursor, EIO should be=
 returned. This

Is there any need for this change?

I don't think your patch has even touched the call chain of
get_extra_mirror_from_replace().

Thanks,
Qu
>    * can happen because btrfs_num_copies() returns one more in the dev-r=
eplace
>    * case.
>    */
