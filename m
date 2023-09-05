Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0879321B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIEWs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWsz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:48:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666D11F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693954126; x=1694558926; i=quwenruo.btrfs@gmx.com;
 bh=1x60D/8ZVOuWMVNQnz390DK6QFKrMl+elB+R8CG3RvQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=s5fXMyY3xAA2cj+oE2x2bk5RRE90N0tnRdYyCt1gGkwXusg6qBabrDw/t3wWNrBtzMzQaJP
 rpF5FjnLly+a7WzdT78Lldi2UYyS6Al9zCskD00tPBQPxbW7aZiReR7yEpw0Tf+SdJ6NSzxLU
 6zZMEmAXP3LzUJKjlhxNQDeTPx4TlVJeJecWxXxEnx2VyRCqP5KhaJqIJEZCV9KGQtlIuV5DK
 51qMFB4LDLeVqYABQM9carqCOjh9/V2CiUw2gVlCALVfjW4HQLXBHST/eUN6aP0UdZ1/6XP9X
 q6KAZdB5mAW/rO7NTl8GqWogVKj/QwlCVa3p7mPoRz22sKLHCPYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1qU0DO1MWJ-009icy; Wed, 06
 Sep 2023 00:48:45 +0200
Message-ID: <06cfc805-0bac-4479-bf66-690bf83f3f0b@gmx.com>
Date:   Wed, 6 Sep 2023 06:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: make sure to initialize start and len in
 find_free_dev_extent
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Jens Axboe <axboe@kernel.dk>
References: <cover.1693930391.git.josef@toxicpanda.com>
 <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:npHZ0DZQDdElK+nHpGZihXM/1uY9aTLeXAlNUTRH2eAJzk3N1jR
 /oA28Tf7LSbycYtAPUtJo8Nd0yVOZNoLwe8Qm12LByjoibkJH+G47Jqa29TbAGqYSU8lkRQ
 QWCb1txKX9Wa+Tp4hHN8uzOmzFqJtsSQm3rN+ykLfn807FkqRIfExsZajAAU8p1pZ9ImeWx
 5DTxOi3My1KJ32TdxRyBQ==
UI-OutboundReport: notjunk:1;M01:P0:AKSO43ip9Uk=;plgAe31yXUcFCm7DuNoHKP0llDy
 8D6MVhayyH1T4nioChx4eB9kkYPuNsQbWBBUPoNKhCbSAXrQCBtHvCm+WW2PK7igTmqFsCMdp
 4a1HFmSiFXKjV8H5rPGvHWya+s1ZTUOmDIR1ecDj5Jrv1BXFn7HXz8qo0mkNdP/VScLgaEExo
 Ls7MIR4cgnkO0oSOKj1++6sTzB3y4uFrKf0B3jxauz/PLRqQgb3nQxOKmfKhAgXcqLJU0RuQk
 Geq0FnN6eKqVNQkf2bmQ9k8ptYnFPU1U56WUW3Q+/Tb6fI2hDaIpONLNLt+C+nU+QjEu/bToc
 sBtKD7C+njM82euEPs/1sk4Kb38GLRFtQQMnkFsvShMbQTV+wcVr8Fqq+dsHCqqfGd7l9dVuH
 Xc/i+mxr+iN0Y4eRLuC+hhK2HI79MKcillVDIlFDXJQ7tXM0Ci76jZyj8ej5xTcd+3Kg4a/bL
 YtSaLZRl8ZDQDGePjcaDG+n+75saEnIJxS/Tu7h30UTr6cvizCSqHFImoDWmBxAnasVRM0haD
 ENqCGBRRLqC1MT9CoQK7lPhHILHi40NKIia+TBuMM4OQhgqpobBXAZiXZAherC5pwrQ68yw4Q
 7VfbFwqeiXu/s0mBcA83p8XBriQD8FDHTM3sHz2nXhgOt6z0ipXnOEZRHk66AU74p+IVV26Aw
 D2/E6g0EiJO0CG602H561CNbkR7+Py1g3Ydof7+rrz9E8B3FWpX/XpPa6n9zW02PHsFJlDgqC
 s7yJHLoqHf9J9k3W6lkHwyH6asjsxlsebiL6H1HUS7LePpiTzZBagUsCjpImVKOgSpKhqe3RQ
 i5Ts3uwIVGJInl0QDYrA165X3R4MVgF4R+MFZM8oMnn5iLGvi40NfCg8MJdKGNa9dewAZYQsL
 6g/Jf0nP9YMXK8/rV13D+LUC6EOdrrYuKY25wVf6B0daLNVPJ52wcOBsRvPuD/IPpSwc2V8cU
 3yc4aYZPR1HXF+4wyoacIDvjzq0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 00:15, Josef Bacik wrote:
> Jens reported a compiler error when using CONFIG_CC_OPTIMIZE_FOR_SIZE=3D=
y
> that looks like this
>
> In function =E2=80=98gather_device_info=E2=80=99,
>      inlined from =E2=80=98btrfs_create_chunk=E2=80=99 at fs/btrfs/volum=
es.c:5507:8:
> fs/btrfs/volumes.c:5245:48: warning: =E2=80=98dev_offset=E2=80=99 may be=
 used uninitialized [-Wmaybe-uninitialized]
>   5245 |                 devices_info[ndevs].dev_offset =3D dev_offset;
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> fs/btrfs/volumes.c: In function =E2=80=98btrfs_create_chunk=E2=80=99:
> fs/btrfs/volumes.c:5196:13: note: =E2=80=98dev_offset=E2=80=99 was decla=
red here
>   5196 |         u64 dev_offset;
>
> This occurs because find_free_dev_extent is responsible for setting
> dev_offset, however if we get an -ENOMEM at the top of the function
> we'll return without setting the value.
>
> This isn't actually a problem because we will see the -ENOMEM in
> gather_device_info() and return and not use the uninitialized value,
> however we also just don't want the compiler warning so rework the code
> slightly in find_free_dev_extent() to make sure it's always setting
> *start and *len to avoid the compiler error.
>
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one nitpick below.

> ---
>   fs/btrfs/volumes.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4b0e441227b2..08dba911212c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1594,25 +1594,23 @@ static int find_free_dev_extent(struct btrfs_dev=
ice *device, u64 num_bytes,
>   	u64 search_start;
>   	u64 hole_size;
>   	u64 max_hole_start;
> -	u64 max_hole_size;
> +	u64 max_hole_size =3D 0;
>   	u64 extent_end;
>   	u64 search_end =3D device->total_bytes;
>   	int ret;
>   	int slot;
>   	struct extent_buffer *l;
>
> -	search_start =3D dev_extent_search_start(device);
> +	max_hole_start =3D search_start =3D dev_extent_search_start(device);

IIRC we don't recommend such assignment, it would be better to go two
lines to do the assignment.

Thanks,
Qu
>
>   	WARN_ON(device->zone_info &&
>   		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
>
>   	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> -
> -	max_hole_start =3D search_start;
> -	max_hole_size =3D 0;
> -
> +	if (!path) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
>   again:
>   	if (search_start >=3D search_end ||
>   		test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
