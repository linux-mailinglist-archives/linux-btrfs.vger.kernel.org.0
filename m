Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1713C97CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 06:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhGOE5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 00:57:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:59589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhGOE5S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 00:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626324859;
        bh=3Gbzti5/wp+CqTiilrryFmW3kjYOih2XucqLL2W6qHQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N/ozR4OUHG6e4S/9sDKAlV3bCQjc4A/hW8kVxDVptgMXpW1mhtkDClppyRgR42DOM
         CqqQ/d6pAjrVuRAGwmlMZr0j3c63unjYIydGLsydNR0p9LajWGSIg9oRpd1QzNBHZZ
         kcf+cuvwmBxtifW5sRx5SKtRED2xZOEbM8CuYSc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72sP-1m48Mm0IO7-008XvO; Thu, 15
 Jul 2021 06:54:19 +0200
Subject: Re: [PATCH v2] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210715022848.139009-1-wqu@suse.com>
 <d3d1dfea-2858-0877-e671-73ef1e1ec7af@oracle.com>
 <4808cdac-986f-ee84-154e-5a4d90b6a06f@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <45bba91c-1e79-852a-c3ca-80d1fba2c083@gmx.com>
Date:   Thu, 15 Jul 2021 12:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4808cdac-986f-ee84-154e-5a4d90b6a06f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UPJDsF0umR5+hRx9pOXMekrJMwCRTmXu/uZaT21H4CVdjoTubIk
 ICm0VZQqQWEnSNfmpRHO/2PiSL6uAjtmdNF75AVNGc7WwEGxaYPT5PAAnWyoW+w34z2Cizi
 a8sQjffy66bC4rWsKGNpYLy0eqC9GZQ0RkzBAxfR1w+svqKM2S1mOo+vs0+P9tg94kASajS
 p94SK2cwcQKuAyC7zV+uA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GrraRrpCrHs=:VEXEIBxPF0zuYqi1Ym0UZf
 ev+7sfUqXt7AjrbjEZ9GDdiZ3ZT3EaCSJ6ekMoVkmglvuTKsaZdW6UGDPYfAR9bmnQ94k/VFA
 iORkao/v2fTQ3V6fSMp4fFVJPPX+YWm02gufWZUfx2CoyyuANejlNj5tuADea3BD0F8g16k1b
 yOuT6vR0Iwq7+FuRP6JHIqk72JHwwgpKMimUOh/Fn58Z5wI2g/b+HnCLgmVRzRDlk9nk3chwG
 3WXOJPI9Q/tMK2fREffPwWElEkwbxyNOKTkAFOg1EhdgL0VXa+EuXvdIxtWwn4vT4ConvWE0d
 O7VhF5v8TWgo8a8Vl8to0eIL57G0QhGW40J8N8EJbGPv74EfgyOWBNuBNtdOsHGInYzh2DSmr
 F8H5Wc/UscqwrkISmj5xnckx7mod5abyZ5dXXlqkM6OIbH86g5LorQv36enZR/NarGl/C+1vA
 yHzJV8glXvx0azRGmzfxFYAPVtDvbSDeQ2Hetl52PwM9ZPYHs2E+PIUfrATISLRwS4h6db8kI
 fZW/TIUcjdL2PqONOKwt8oZ9LYtlMymDDe5RxwQ5ul1iliyWhqOzWRl25Y19FxGrXWBs2+xgy
 9iJULvf/QdAmSbZZDeSonjEDP3HfxH4sOvNO6WVU2b/1tpsU5E9PoSFy93f2j5jVskfiq3c91
 Qj8SW0O3XcVD4K6Urw+KRj/KP4KeQvlV8bD71o04NAq0mOroak15NXULMz97//+gjCRrMSVbQ
 Q7HnRPVARlebqvNHuDdyb7Q41MUJKS5YX+dO+G1bzslzPRbQGwu41fvN8XFwvn+2gjY3mUSq1
 w931oY9G5vdxWKz1aE1XZcsIhbdX1wm70k5IYRPf8tVqV97nK+F5jumj16dTymbY8Gp7H2aqv
 Ixu6rszEHkyNwXmfTHGIEp4bupDIuOdmyiF0At4qsvRyk/P+LQEQF0YxSfoQcOreHIJqfPtgp
 6tmRaxO4IZA6OKF0NBdMUg2oelk2MBH001lGKAtTXmmPQkrQ2CuvV5URX8rztQnbT7fynfzJM
 pnfJoFko2q79chwltquxoaoDuZnM3DH4A+8Eo1FyxpmL+gx3wvkb069DbJugHGjkbi+oFGeXT
 PHYet5TOY0LHf7KzVBxgEJTDsu9uIi20N3NmEUgd9UOF50vDrUSy0MDrQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8B=E5=8D=8812:52, Qu Wenruo wrote:
>
>
> On 2021/7/15 =E4=B8=8B=E5=8D=8812:19, Anand Jain wrote:
>> On 15/07/2021 10:28, Qu Wenruo wrote:
>>> When extent tree gets corrupted, normally it's not extent tree root, b=
ut
>>> one toasted tree leaf/node.
>>>
>>> In that case, rescue=3Dibadroots mount option won't help as it can onl=
y
>>> handle the extent tree root corruption.
>>>
>>> This patch will enhance the behavior by:
>>>
>>> - Allow fill_dummy_bgs() to ignore -EEXIST error
>>>
>>> =C2=A0=C2=A0 This means we may have some block group items read from d=
isk, but
>>> =C2=A0=C2=A0 then hit some error halfway.
>>>
>>> - Fallback to fill_dummy_bgs() if any error gets hit in
>>> =C2=A0=C2=A0 btrfs_read_block_groups()
>>>
>>> =C2=A0=C2=A0 Of course, this still needs rescue=3Dibadroots mount opti=
on.
>>>
>>> With that, rescue=3Dibadroots can handle extent tree corruption more
>>> gracefully and allow a better recover chance.
>>>
>>> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
>>> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Don't try to fill with dummy block groups when we hit ENOMEM
>>> ---
>>> =C2=A0 fs/btrfs/block-group.c | 14 +++++++++++++-
>>> =C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 5bd76a45037e..240e6ec8bc31 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info
>>> *fs_info)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->used =3D em=
->len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->flags =3D m=
ap->type;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_a=
dd_block_group_cache(fs_info, bg);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We may have some b=
lock groups filled already, thus ignore
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the -EEXIST error.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && ret !=3D -EEXIS=
T) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_remove_free_space_cache(bg);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_put_block_group(bg);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_update_sp=
ace_info(fs_info, bg->flags, em->len, em->len,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, &space_inf=
o);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->space_info =
=3D space_info;
>>
>>
>>
>>> @@ -2212,6 +2217,13 @@ int btrfs_read_block_groups(struct
>>> btrfs_fs_info *info)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_chunk_block_group_mapping=
s(info);
>>> =C2=A0 error:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Either we have no extent_root (already imp=
lies
>>> IGNOREBADROOTS), or
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we hit error and have IGNOREBADROOTS, then=
 we can try to use
>>> dummy
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bgs.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (!info->extent_root || (ret && btrfs_test_opt(i=
nfo,
>>> IGNOREBADROOTS)))
>>
>>
>> =C2=A0=C2=A0 I missed this part before, my bad.
>>
>> =C2=A0=C2=A0info->extent_root can not be NULL here, which is checked at=
 the
>> beginning of the function.
>>
>> 2138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!info->extent_=
root)
>> 2139=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fill_dummy_bgs(info);
>
> Oh, you're right.
>
>>
>> =C2=A0=C2=A0=C2=A0 So should be
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && btrfs_test_opt(in=
fo, IGNOREBADROOTS)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->extent_root =3D =
NULL;
>
> But this is not needed.
>
> We can have extent_root if only some extent tree nodes/leaves get
> corrupted.

In fact, if here we manually set extent_root to NULL, we will leak some
extent buffers.

Thanks,
Qu
>
> Thanks,
> Qu
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs=
(info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> Thanks, Anand
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs(inf=
o);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>
>>
>>
>>
