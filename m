Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8437978451
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfG2FHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 01:07:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:43097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfG2FHv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 01:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564376860;
        bh=YalNMJwW21ZLwvyKohS8TEGTEqdtWDlprLFqadZgrk4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g3WneuLCugtU3Ux6HTGH1NAAlRXaag14EKodSAUIQV39geJP9cnbdKjg4xUA/DsN0
         ElSqBA8kF5N24tkM8ii31zAakc5A8sHcp2mqeNwBW7/EaMeTaJolXoTAnXi0jMdFEM
         bLuLvHlRwYUP3BJjAUVr6TXDLcENxffA1j3zEsys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1i7q4j22oo-00JJJS; Mon, 29
 Jul 2019 07:07:40 +0200
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
 <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
 <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
 <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <009c2be3-f09d-3dfc-6c95-8fa0e62d4f41@gmx.com>
Date:   Mon, 29 Jul 2019 13:07:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vhtw9UoDDcS6GP18lQ5Q2BqT9YNrbq4a+p3sVjeB3CZIaKcOfWR
 V8IIKZRWjQjotDLlTzO3g+d+hkHzzMskdspsk5EG6qfbscZn03n5R5Ydct3TFLKAN+AFdzu
 HYK5tHqcSf5AX7D1V5ZuvgTLKARBeUbG/Y59TXM21nB7SZOJKv4HkBGvcmsAQSj1BG2vXPk
 /n+IiQ6mxWcWdZdzkHOYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:29GAlzgfJCU=:hjYc5h9Gqr+K2M5TBbo2mb
 B4xy6mk8G2p3aEjeBSihtGzWI91VlOD8QTYhq5t/I7jX+rI4px2PFioMp7l1rlOQT6PDkZf7q
 lP7oPnxwd8bYiQ9Kp3F5WhlZR6m7dlSu8TrVn41YjGe901UCn4kEFs45Glt6mu+OeHwaC2ib3
 T18OCPXImpc+wFsJK92Kfa89zmUPhXajInu5EF76/xhexmpWtB9MSTVMNCDfsFBOw/9h3pHWK
 oFwjEdq1Hvj6uPLXmpYzCIE0FRMrso/IODyVSIvOWXu6phaD/X+8+dkkOaH44SHqn3RPZjqdi
 /GqQ+D6QmIg+64J48Uq1WyiTfN9APBBnvpAWTXMs1twvToDNV3ASpJgRKCYroHkPjMqSoQce5
 6oJO4ka1lA/u498yj06SJ7mNR4i6S9/3mgnggXNQSDE7vbuEoR45jNNYFzQm1WjZnmo7pYspE
 J21kk/t/FYz7VWanK8tTpKJrBCgsKeDjcHM6Ob6hyd1yykng2l+YJk0hNwpvhpULDOTxngZcn
 3EqyTlKMGjw0eAmOSNKoopqtIRWp+pOUqGD8/TzycTiUVVFiTErs+SFY4+7HAiZIlDekkh6oY
 P4UisjusmISMM9t50OxoPYGx7XviHdtw+iFvX6KyJUCG18G4HuUAD7gSXY7kQxCZ2IZ8IMxSx
 LzZ/InqClXx0xMYBsF22UJTKDvHFnXbLclpZ+yHMmfQOyDfaeZUTeaes1SdCuuS8J7GwQ6qzh
 gfTSjq3I6zw1mbNTa2Nb1FJQ+cXYa+ITZXhiza9RDrv1IUq0UWRmyWlkAECk5Z1ErDq8uAQCe
 NUmQqCli/9f78eMXkqq0cdAJfAMpTr74ZANMIZ64pH2Bwhs3yivtTzPPEIKidV4zouNHgqFju
 Ji9kuG38Tm6euAY9xC1oSeudtY9WdCmwzpqC2+iP8GKRhYp0hjQItQXmZKxEOdRCi5AXmEoAk
 0SoE3Ovj/6G7Pvy3El290As9LBhjEMwcq05RChIPlwqbpe4fELNWzi2yij2Db+GwnyOrBkAk4
 3n82pN4CZj9rlOc1eMjHoLciKsEcOieu5UM+5bzbjEx9az6mHzsiNV1vaXfqmBurbICKXgkfU
 mgjePWPVRac3pr/NnoOezNERBxydzUUVPSt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/26 =E4=B8=8B=E5=8D=884:15, Naohiro Aota wrote:
> On Fri, Jul 26, 2019 at 02:36:10PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/7/26 =E4=B8=8B=E5=8D=882:13, Naohiro Aota wrote:
>>> On Fri, Jul 26, 2019 at 08:38:27AM +0300, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 26.07.19 =D0=B3. 8:27 =D1=87., Naohiro Aota wrote:
>>>>> Several functions to read/write an extent buffer check if specified
>>>>> offset
>>>>> range resides in the size of the extent buffer. However, those check=
s
>>>>> have
>>>>> two problems:
>>>>>
>>>>> (1) they don't catch "start =3D=3D eb->len" case.
>>>>> (2) it checks offset in extent buffer against logical address using
>>>>> =C2=A0=C2=A0=C2=A0 eb->start.
>>>>>
>>>>> Generally, eb->start is much larger than the offset, so the second
>>>>> WARN_ON
>>>>> was almost useless.
>>>>>
>>>>> Fix these problems in read_extent_buffer_to_user(),
>>>>> {memcmp,write,memzero}_extent_buffer().
>>>>>
>>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>>
>>>> Qu already sent similar patch:
>>>>
>>>> [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer rea=
d
>>>> write functions
>>>>
>>>>
>>>> He centralised the checking code, your >=3D fixes though should be me=
rged
>>>> there.
>>>
>>> Oops, I missed that series. Thank you for pointing out. Then, this
>>> should be merged into Qu's version.
>>>
>>> Qu, could you pick the change from "start > eb->len" to "start >=3D
>>> eb->len"?
>>
>> start >=3D eb->len is not always invalid.
>>
>> start =3D=3D eb->len while len =3D=3D 0 is still valid.
>
> Correct.
>
> But then, we can even say "start > eb->len" is valid if len =3D=3D 0?

Tried the "start >=3D eb->len" check in the centralized check_eb_range(),
and unfortunately it triggers a lot of warnings.

Some callers in fact pass start =3D=3D eb->len and len =3D=3D 0:
memmove_extent_buffer() in btrfs_del_items()
copy_extent_buffer() in __push_leaf_*()

Since the check of "start > eb->len || len > eb->len || start + len >
eb->len)" has already ensured we won't access anything beyond the eb
data, I'd prefer to let the start =3D=3D eb->len && len =3D=3D 0 case to p=
ass.

Doing the extra len =3D=3D 0 check in those callers seems a little
over-reacted IMHO.

Thanks,
Qu
>
>> Or should we also warn such bad practice?
>
> Maybe...
>
> Or how about let the callers bailing out by e.g. "if (!len) return 1;"
> in the check function?
>
> Regards,
> Naohiro
