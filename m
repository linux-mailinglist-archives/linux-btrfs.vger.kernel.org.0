Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC372F58D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjFNHKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 03:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbjFNHKQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 03:10:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10733129;
        Wed, 14 Jun 2023 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686726592; x=1687331392; i=quwenruo.btrfs@gmx.com;
 bh=83EYxqpMyqxQQV7Rs8Hav4PgEkUJaX3hMn9+1RNS0Vo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nNfkiFfqDS3zxa72cvl4bUkiytn7DUcY+hXoEK8zuUHS5IiFJ/PQzUB8S8/LTYoqkDeavLP
 g/qsJlZKnK3UYzmsvgiQ5wjU6N4GvS9AGogo6TTcskKjiFe8Z0oZwtFYsZ4oHm+M4VCknE5aA
 B8mcFn4qu4/vqZ0/gwMCKNEqTBOvUCF56Q/ruuypP3k9LCeCx0fy977ejfCDhoPV4eRq78vxu
 HMClczKLc2flJqKY1PAnpgaHW8Vfw/cieKER6oS1UFtawYZBKs6KJRqQATR5jARFrIXTpiOni
 Oia/3rt3w1+m0QEQpPCSQ2eyDYXx0aZMxw24y7FxmsMTNY/WbaNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mjj87-1ph7HY3WPr-00lAf9; Wed, 14
 Jun 2023 09:09:52 +0200
Message-ID: <abb91fb3-f50a-6235-eac6-a94093c54cc8@gmx.com>
Date:   Wed, 14 Jun 2023 15:09:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: remove unneeded variable from unpin_extent_cache()
Content-Language: en-US
To:     baomingtong001@208suo.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230614065736.22353-1-luojianhong@cdjrlc.com>
 <a1c89487cc2839474f232ab140a96e3b@208suo.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a1c89487cc2839474f232ab140a96e3b@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OdS6CIgxPAKHwy/uAySt5xeqtgOpzZ6J87UXQyVcnvYluD1NgCo
 J3OHvRlW+hMBUu1igApykGuKKXrhE1zh9uNUyNZMa/zHr19xdp929vQUCUseJhEzR1et5Er
 KffDYI+7lRJXrARFJbs9SZ4DNBWKHDhlt/KAL13BGtbcD1oQ21fxXTJIaNmpdYO/FrRpb1h
 XzdT+V2i4/PSP4rrFiCKQ==
UI-OutboundReport: notjunk:1;M01:P0:FrRq7xmgPDg=;FFH9boazoK87MgRyt9IjkrDaz1t
 T1RcYep4SmCtfvaMGV/I+6ainBD3ERoq4IqdQT/lXw+4MO2CNXNXEdNkfJn26rSdnw6SoczZo
 As00Cm7I0WqpI3mKiFMohXaXrgsZlhe0kmlw4SbJ1mKYGj2ydc2jGL6zJD4j7I27ehEUfy3GO
 JhEiHQLyipDDxWp5m8VTFKjVix1hNkL8KlVHGKbB3eXpu+u8BHNy+t0frLk3yE60ZdnHsetPJ
 rtKssU51qpaa03NEBr9p4RHA8bt4QPhtzh0lWNnt4Ddhf/Kp1d0HLI/RVJ86tsQQU9RoAYid4
 23Ijk6jWfN9ISFfwkzXQgMI8xkPgHRtf7eKwXkp2iBeBDCOUsI9XP193Wj1hsuplUWxyI8TLs
 WM86I1tBVVQ7xua4IT0xJC8/FmdzFbESaBZFHzRj04fvUianUfYU4IC9Z0F8WSL4xaVAVqD7u
 l9THAtMCt96KHmGV9SqDIPIcVJIf2BZnbBOh3FmbT4vNhLBE84cFULK4ffOET2HF9rQ6NoKTg
 0AkDCgCrSl4JWu/6SrOdMt4MssHxwCMZt7BBhIDKrlRM1JYwmlf66hueHmGwKPytqncT0bVxl
 PIBPNvZaYkF7X/gUg+VpIij5q2jJ9Crg8Iy0gXy1/5El0yJI+S28IWGO01VTD1TQz15gWV+rN
 pk8a3G9lyzluU5s0v4j3EhDktOe1XS5h3tP4ySp6cnTr/5ZASmybmV/+ghQoDlmFqZMmouNoA
 0bn21l3NjTNGkJu0JxwQ8WxUkPNp5vOVEjLXawO+ptInXSnCXX6rFXLvcwC4GU7xrZG1kiVYT
 sTb771MXD5lMNB8RtFixnEdcsD7fstQov+ef3kK9b/PY8R1VjNaOb9owHBc+tygTFjlQo8YDv
 lykGNz4jDM2YmXz+cF6WkUKYiNpcEMpJaw/c+dAl5QNc8/O7Ftq2xrwC4RSkvIu/1TxHmK/mj
 245ZW3GOeTm1At7rlUkwwL4FylY=
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



On 2023/6/14 14:59, baomingtong001@208suo.com wrote:
> fix the following coccicheck warning:
>
> fs/btrfs/extent_map.c:298:5-8: Unneeded variable: "ret". Return "0".
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

You can take it one step further by making the function return void.

Thanks,
Qu
> ---
>  =C2=A0fs/btrfs/extent_map.c | 3 +--
>  =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 0cdb3e86f29b..f3e9aaeb9956 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -295,7 +295,6 @@ static void try_merge_map(struct extent_map_tree
> *tree, struct extent_map *em)
>  =C2=A0int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u=
64 len,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u64 gen)
>  =C2=A0{
> -=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct extent_map *em;
>  =C2=A0=C2=A0=C2=A0=C2=A0 bool prealloc =3D false;
>
> @@ -327,7 +326,7 @@ int unpin_extent_cache(struct extent_map_tree *tree,
> u64 start, u64 len,
>  =C2=A0=C2=A0=C2=A0=C2=A0 free_extent_map(em);
>  =C2=A0out:
>  =C2=A0=C2=A0=C2=A0=C2=A0 write_unlock(&tree->lock);
> -=C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 return 0;
>
>  =C2=A0}
