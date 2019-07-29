Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C318078DDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfG2O17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:27:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:55563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfG2O17 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564410477;
        bh=YSKdrB2/lpQ0cHjM/aqI9GXwgrOjZZKn3G2hwoS2kfY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RsovG6KTzyv27XPqx5cGmUdOVQ9iT5wZEmaB6f/CSKZFeUqJuMOf0ve+vS1B3zjRi
         rJH8c/IgAgyond1z/JYfWetXjoRPJQo+8IFkFHcIJzUaeDdu6fA71da4j9fqDhJnSY
         bR7HGEhslcNH6BBSZNhGhCR9NGssiXtdbXh0Nujc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1ia4Og45vV-0102Wb; Mon, 29
 Jul 2019 16:27:57 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
 <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com>
 <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
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
Message-ID: <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com>
Date:   Mon, 29 Jul 2019 22:27:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gp+RzWYyMG72PT9VFS8NTRiVKLHZFgOsN+Fm2r5j43OsALUj4e/
 mGgnadJRCp1vGn8LkGg31PoHjsV6eqcY9UYwGjHcmSSEl8Wjzps5dat8c6s6GSKtponvSXq
 53UCnkMQdIqirutDMS41uDKNDDmLReYJlAzUGBt5dK88ZgF2Dz7zM+f+fFk4D2P0jPn/Mh9
 drG9HauL0qlOcOnYkJorQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MRg86ICVhQg=:5lVoc3GVB/KAzUOhGCosw2
 vs867m0HLUAyPuePbq3xq1pKDmEGltM0gm2l52rtiriGEeBvpwVUDyGoaO2PxTj3B1v0JrN8u
 YFdarBNH3gTvlZj3+DPt8vUMo0F0CuSc/K/huMSS2+w79zEAW1Z22BnstD18QG4GoAvDeW7YM
 RbkypDA2xa/Ls4mQWhpn7MUd+w/GsQ+oYrMO0VoxtHk4UcjdfTFwCCX1f6GtLUgyddCuJzJ78
 bXEYUOZyudh/ffq2bH7FkrPuPMdA8V842fk2HNg7JJMpkoDB0wfjP9iT5WTxkahlW5RX6ScKV
 vIBtb3w8fYpBzAF72mLzoa98s4Hf5duwbGdy3TAMuLtxDyGwxlkYoisEhaAYB7ULNmSRgJ5EY
 pbkoiL0DrV3dnmTYeF2b2SzGOzxzYby0nv7u1REPqGiNha6+O9FdNWGaa+3N359vJhdCyUmMk
 GHfUQCb6g3i3G3w9luQ6lMDt6jNH8HemGCEh86kuSE6qCHN6WdittHHydNOKM7Ejztl5/5yd1
 G40Z7MR0BwlPenMv5TF1fLXebCUjcyUNbLhptOH16w+5gzD9PKDVL5WAnr/zsVclrOiGJzP9i
 IeFlSruCFnqHhc+DWAF9amREIjQDwF+FWCZEaYntqbMbhFLU8SUPZve84OnXFuUC5yBWG5O7O
 f+ziy/iip4rntRuGmPp6ye7czfOZ/1/QAU9bRvrasy3tZtY74W64anORbSgoO0qImWZhmIIX4
 0MFLpPFnNdwohlcECo6LPQRI2MAECL4Gskugu1tDHMCWbHc2zZaRh1qXwQ2wHeRvgghI9/Kt2
 V61zvvEjQDxEgCmnBhKyP+n6SeIY+aEgWviOGULKt9U+G4KYp7RKccQu9RcsrsWXmZnO8zoQv
 uzcWi2DQTQ70R+5OZrXudge9nXLTeyAcCNMUien8QA3v38yfJ1o4qzqzVRvAklU7pf+Luf469
 9Zl8Y+OI1fHaDpKcRMN+RJ6BYfjKMgzBppdvFx96cuHWuwOizxHFC2RKrmzTVW7RW00hl4bzI
 +yfngti0GuW5kdYsZHDid6I/tC5yHg0G11rDEdKu+Rt1V0bwP9Tj0x+eWuSN7O7YCaeFFIVLe
 NN478b1D4C+W4CACJQ+lUebIYHHmntRDAeC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=8810:21, Sw=C3=A2mi Petaramesh wrote:
> Le 29/07/2019 =C3=A0 16:08, Qu Wenruo a =C3=A9crit=C2=A0:
>> You don't need to repair.
>>
>> The corruption is in extent tree, to read data out you don't need exten=
t
>> tree at all.
>
>> But I'd say you would have a good chance to salvage a lot of data at le=
ast.
>>
>> BTW, --repair may help, but won't be any better than that skip_bg
>> rescue, you won't have much chance other than salvaging data.
>
>
> Basically my question is : Is there anyway I can turn this broken FS
> into a sane FS using =C2=AB btrfs repair =C2=BB EVEN if this causes data=
 losses ?
>
> I can afford some data losses of this backup disk (next backup will fix
> missing files)
>
> But I DO NOT want to lose (or have to recreate) the complete FS with all
> its subvols and snapshots, which I have no other disk to copy to current=
ly.
>
> So I can accept a =C2=AB fix with losses =C2=BB, but not a =C2=AB well y=
ou need to
> reformat the disk completely =C2=BB...

Then you can try, but we can't ensure anything. The problem is, as long
as CoW is already broken once, especially when extent tree is corrupted,
it's very easy later write breaks CoW again due to corrupted extent
tree, thus make things worse.

The rescue method provides full access, including subvolume and things
like that, the only problem is everything is RO.

To be clear again, btrfs check --repair is never ensured to make the
image to be usable (pass btrfs check after repair), especially when
extent tree corruption is involved.

BTW, I'm more interesting in your other corrupted leaf report other than
this transid error.
The later one is either some real corruption from older fs, or some
false alerts needs to be addressed.

Thanks,
Qu

>
> Kind regards.
>
> =E0=A5=90
>
