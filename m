Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4B60C90D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiJYJya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJYJxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 05:53:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B3474F0;
        Tue, 25 Oct 2022 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666691402;
        bh=nGbUmv6JpXRaCmCY+0r2SxjehWVaWhU66Y26mjFItS4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J/CYUIPU/H/ak9Q31JveQQxQuxUY6ADUbjTl+nzbJxNtr2Ifqr0RqehOl6xHJ7u27
         Ia9al3/GPVWQmQC3aXKcGZa7tSnPDepFbVkPQJgk5c0rjULI5gFgV97xf1SJkpwN0g
         TlYWCZSJ0oC4OwJo2Ebnt2yVQu/9F0bNRlxb3XYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My32L-1p0fWY0hLT-00zUQ0; Tue, 25
 Oct 2022 11:50:02 +0200
Message-ID: <13035b03-ed27-c36e-da6a-072d882e787f@gmx.com>
Date:   Tue, 25 Oct 2022 17:49:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: volumes: Increase bioc pointer check
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Li zeming <zeming@nfschina.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025082835.3751-1-zeming@nfschina.com>
 <1d9d4d78-073d-fc49-1918-f7c8ab6fe15e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1d9d4d78-073d-fc49-1918-f7c8ab6fe15e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m/FYG2I36mrPj5kj1qyr5RON40pEUSu56DxBMDDE8w1yaUYEQdb
 fcJ/PrLZnSEoESSgv59NYEsJ/kAb4vy1+vJ8/fGPdGfCNiyeyL/k92Z12QKbqWVpq8S/MAa
 Qt/vFLQD/bYk2KtLHzNXkHFQANqE40vvKqUNGxUsz3oFs0EQ1RAlrGA31wyHOsO01N56k+/
 1eyGWGCR6a4RQJEEPdxvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qZhyDxZjN4M=:5eedd5Rpzy9evbq8EEwkko
 ZuICaT+pLW0v62IB/Tpfx1x3MJBiYMUdGBBb/em2Xn40CjtealO7D+eyPAGBtzR+YVqEAEtXl
 rmigqjuvQnKd6j2mVwHLx2R2S+iC0nqY3dHWfUN10SGirrSeaBOHyqICgSbVESVZRtGr/YOHv
 5whzlJ1YYLbkLtA5Ccj389choBNXoIBDUukCdekdDSgZlhWdsNvEsZ4wGwcIcy4fWaxIyoUNa
 PHqYRmVuQtmKQlO5pgie4Y7ydyq1VudPzW8vM2RQ7F1uqt4g8nReeVmIoqOvcMekOaDHxdRmj
 cnhqNyBErtkPJOJHIYBwu4+oFvAGdj0VJgLSo+i0U7VzTWCNqp0AZRbl8IxqzEltKV2j5Vo2u
 6syaVZ3FiyTS/vGmfRkvCZJsbFx7KPucHBbnwH7dJ+2o6X5g4Om0xpQP6pYSrxkcN1i9STRrA
 IHrbLvHRYspsNR+37ummaB5LDDOWJNjx3/1h0bw9EvcFHHOMBJc8KHfkbKKYcQRBnRGc4BS1q
 6dHzWrhICkafTKEXB8+rqNK/wPb9pu/DTU9QiOaNxNLAHieOpCTz7j9u1ig48/VazV1BxhhHn
 kau5y+0ff9pkoGptfASQf3lySRWD+RjXuMSH910+UuJmtow+ibeF2HXbeSsh2yUKJw+7nJjKC
 knPkKiDYom63aK2rGpfgyjel4Ph3Cg1rPuh4UriS+SiRvoPcL6b8noeyhb7i+YS3Ly73ZWCkR
 BFFxvxy/a7U4dK2SHTevKiyYZ6n2SKGNVd79B1HPNYd4GUytOBm2ex0u4QDb9nN+ACc3YslkF
 kzX0kViysJellc6CSk8Q+NWt1XhgQGECkUMFhBkJnC5OgZsEssuR9i7ZICyK+uDdRwW9zyNgC
 zaiR0ytnoAc9ho5pS1XuKgXufjGSeWOMe/KcF8PT15HeFyUC5PEyVfJn4JkIU/yqxFJvn1h45
 h7BXN1CHoeOD1q52b0zBop35rBLDDN/DraymfhXqxFsgVazUpkvrsg05H6e5ZrQfEV3S1g/lA
 RxA0SaE7fA5hDwBhtkw0sYtH9j81bmX5KUTdOvrgNhEtqcXtafPtvEr5xACXM3g3ZrHvvrqtG
 0JLJdzKF9xqxrM0ajcdzH29sszmhZc0q4lVylXHf5JH4TN/x0cMnVTbXYrs1DL+tHUWGwNhjQ
 A7Ht7svt6cDgb0ZH2Qq7NKem3+37bXqoVLvQ/hepGWm9sMZZXx2/s9GrP7nr0jR4nO4xLuCtI
 72zzdohEQiM7K0DMPO4K7SGrUNmmnbeShGTfOMylqFp61jvHA4ryW2ma0sxp0T+Ib+9KLIRYV
 TwtkTBqg/o5ZqTVU/mB3xCJ8d9HIz0gHrz/vo5SECfAmsqfFwSQbHaGM0rRoI541GXDeX4OIx
 DsEeH8zHlGEfydO+v5JNuRcFXIjSORY7FfxspXQEjROYXNfSdH0sVROdEqEr4mLqbfT09CxGY
 727TgMjn/RMQO6dYHAAVNhsgO0dI7U3aoxYbtGICWbdE9Xi1Q5+D8TGODjwwvnNq27exH9YcP
 pwdXr94vxrBYaY/b327m4w+mX8653YYd7qqDLWkkSinWb
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 17:29, Nikolay Borisov wrote:
>
>
> On 25.10.22 =D0=B3. 11:28 =D1=87., Li zeming wrote:
>> If kzalloc fails to allocate the bioc pointer, NULL is returned
>> directly.
>>
>> Signed-off-by: Li zeming <zeming@nfschina.com>
>
> This patch clearly shows you haven't really understood the code. As is
> evident there is __GFP_NOFAIL flag so as per the guarantees for this
> flag we either loop infinitely trying to allocate a bioc or simply
> allocated it. So this check can never be triggered.

I guess what he missed is just to also remove that NOFAIL flag.

NOFAIL will not 100% guarantee the allocation, and I don't see this
location to be so important, especially when the only caller is already
handing allocation failure.

Thanks,
Qu

>
> NAK
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 064ab2a79c80..f9cb815fe23d 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5892,6 +5892,8 @@ static struct btrfs_io_context
>> *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(u64) * (t=
otal_stripes),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOFS|__GFP_N=
OFAIL);
>> +=C2=A0=C2=A0=C2=A0 if (!bioc)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&bioc->error, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_set(&bioc->refs, 1);
