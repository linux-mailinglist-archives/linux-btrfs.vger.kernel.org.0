Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AF152543
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 04:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgBEDeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 22:34:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:37331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbgBEDeg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 22:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580873672;
        bh=rn0bz3ejAd22O7F8kvhbOUMwHsud1AMkl9fePjn9pJM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=YNyI26FRcW3CDWpsZuM/EtjFTyokGhVVmBAfHBkCfuM3zGfPHOus69Ccp3Nza+SZL
         gT/WYC7d06HDuBP2+71l75UFK7iSAljAxvUq2zEjzVMP0CaW9lIAfvELvvYdmEi2EG
         YJ/ylRoBxt57DMb0hoFOFqBWa2YUQuouG2HibtIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ygz-1iwiLt3vLf-003229; Wed, 05
 Feb 2020 04:34:32 +0100
Subject: Re: btrfs balance start -musage=0 / eats drive space
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Matt Corallo <linux@bluematt.me>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
 <CAJCQCtTuKnsQJNKupKbmBxGpkZSqWcYXBD+36v9aT6zZAqmuhg@mail.gmail.com>
 <2353c20b-95c2-2d58-65eb-9d574ff506ee@bluematt.me>
 <615c56b6-4a05-2765-ce34-c6e1992c4c6f@bluematt.me>
 <bc23d961-6df3-6bcc-357c-200f68d05f5d@gmx.com>
 <8b51da8d-1060-a207-b542-26afe5023561@bluematt.me>
 <1e5081a4-96d5-6066-dffa-52dc7cd5c242@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <d0862e86-b707-9201-20b6-79f7f35cdc8e@gmx.com>
Date:   Wed, 5 Feb 2020 11:34:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1e5081a4-96d5-6066-dffa-52dc7cd5c242@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XZOd9fK3HzHfbFI0yy3lMWAuOOSSCpwdP"
X-Provags-ID: V03:K1:loHksCB0tNkfEXEdjAHubcbNEn6WoSDuahBe7zsBEed57xg/Le8
 7gY2/i3KRCqU9JJjrpkFJTlof5/6V1/jDXsU806Fkxkx0NCU89h1fqovBD9q5LE+8GRPn8O
 rxjXxfRElSRYnpOIsneaYINjfRAQsm7W9dx+zpWof5xbX7vdfVwxRByKjXANRMHEJfpfgIE
 4OHV2JEs1MBNeWyXISgnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zjZoJifLl+k=:4ADLY6rFnIuzGt6IGPGMKX
 RFy66XzyF61xz+f49SD8kbfTApjygyY6mfJrBXqQxSd+73rLRWf4EJOcc4GuA7BM1MP6bSh5p
 iR775b6j9KQ1quWfLj4/as+2j/YMalXYZjVYlzBSrIPjQUoyBNAgIHlGlemSXw8spnKXXgJOI
 b3T52zY18hMEXdPIaGnLh7L/To8WPhgBHxBMaxvQfo9uRKKhbNjILAJOmwP9kA80/3/eXcJ5K
 /Af/o6IfWupLYbUOdlr13gqFWJDjQP6i0HveVKcQLMfC6mJRo4tS2b2pIHdIEsT8hR02TbScj
 HFg0BxJ6SEVstlATV6fGSpCr5X1jIU4w+gYusniBX1vEOB4Yz5nDWcadDJTGjJak09nHP0I+M
 Kbhr39N5y3WvSPp+WUwkJ0WI2FkWzYYQ7NFGdqZW4vADsu8ixD9T7yF9PiEHDQ6hHjM9+UiYv
 PAUFLO2qJlbaRPUbgX94If032AQx5N3dJOiVyfScWuVB3YCoA9lXYyl1PayhiOne50yuxmF8K
 tOO5vDGwTqUzp5NntLXFUMEXe/sli7OkNp6OvgKHr8fzXKo/IUAzDzOi1doCrTsI9SVczQzoT
 y3oPntKeYwgzfSJPq8FPcJB0b26v1/WF1XoTwfOZBHksn2+sEbsDvw0eqSfagdyiet9Ugv5ca
 rV8iA1qU9d3BZ+SkCTXDJilWKsMpsK8GgEc4ql7+2WtIDEBVyigU9z39oGu8yjuuTGlPBL8Ir
 iIB+N8qzjh7aYynrzPUctZeEWe7MAyet7ZfJC4nSlPnG/FyQphTjGPpqkTiaBFgLR3Mc4kofK
 E/idxVMxSpX9vYCI49PGr1blbaCG9KfngH9pYNkIK9BYv5v9tP5oFWhuK1oeMtvU0mm7qnKR7
 OwTZHlWs3EC1bKy+eAcKv6zNRqrpNlFqC0lnGWo7To+CUjwPnUMCzJ6aFPvNIOWF8Mvhn5apA
 s7FgHjhFrOujEF5wxVhSVhcTx3ewpskl5I0DCLYOrGMiWU+/TCQQYY9aYrIWqn1PtNhkRvF75
 IweU0AUP+nFDdE9bzqLXx0auIaCmmIH+q6KrJfZTZkQaIzmi3hSwiK8sLcNZgEuqS0CiUm/SJ
 CSE6Fzic+iSzxmk5W0qOji26R2kAQKS37AwmY1D97dlMgZ7h4tLYefZ2xLdDI+nGjX9IKbrxO
 fOhDXcIn6wtJdZahA1xtMhJsC7PpkxxFjKjRN2xz9Lt5j46olSBqWVOeOyDT+MA+3BXvrweFh
 vqNVkSIjregJRJLUO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XZOd9fK3HzHfbFI0yy3lMWAuOOSSCpwdP
Content-Type: multipart/mixed; boundary="jzvr9ZXMcJq2jkwHElF38xeOsqeWY2zf0"

--jzvr9ZXMcJq2jkwHElF38xeOsqeWY2zf0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/5 =E4=B8=8A=E5=8D=8811:25, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/5 =E4=B8=8A=E5=8D=8811:18, Matt Corallo wrote:
>> Hmm? My understanding is that that issue was only visible via stat
>> calls, not in actual behavior. In this case, if you have a lot of
>> in-flight writes from write cache balance will fail after allocating
>> blocks (so I guess balance relies on stat()?)
>>
>> Also, this is all on a kernel with your previous patch "btrfs: super:
>> Make btrfs_statfs() work with metadata over-commiting" applied.
>=20
> Oh, sorry, misread some thing.
>=20
> Then it's going to be fixed by a patchset:
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D229013

Oh, wrong patchset. It's to solve another problem. Not the problem you hi=
t.

This is the correct patch set:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D229979

Sorry for the inconvinience.

Thanks,
Qu
>=20
> It's relocation space calculation going too paranoid.
>=20
> Thanks,
> Qu
>>
>> Thanks,
>> Matt
>>
>> On 2/5/20 1:03 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/2/5 =E4=B8=8A=E5=8D=882:17, Matt Corallo wrote:
>>>> This appears to be some kind of race when there are a lot of pending=

>>>> metadata writes in flight.
>>>>
>>>> I went and unmounted/remounted again (after taking about 30 minutes =
of
>>>> 5MB/s writes flushing an rsync with a ton of tiny files) and after t=
he
>>>> remount the issue went away again. So I can only presume it is an is=
sue
>>>> only when there are a million or so tiny files pending write.
>>>
>>> Known bug, the upstream fix is d55966c4279b ("btrfs: do not zero
>>> f_bavail if we have available space"), and is backported to stable ke=
rnels.
>>>
>>> I guess downstream kernels will soon get updated to fix it.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Matt
>>>>
>>>> On 2/4/20 3:41 AM, Matt Corallo wrote:
>>>>> Things settled a tiny bit after unmount (see last email for the err=
ors
>>>>> that generated) and remount, and a balance -mconvert,soft worked:
>>>>>
>>>>> [268093.588482] BTRFS info (device dm-2): balance: start
>>>>> -mconvert=3Draid1,soft -sconvert=3Draid1,soft
>>>>> ...
>>>>> [288405.946776] BTRFS info (device dm-2): balance: ended with statu=
s: 0
>>>>>
>>>>> However, the enospc issue still appears and seems tied to a few of =
the
>>>>> previously-allocated metadata blocks:
>>>>>
>>>>> # btrfs balance start -musage=3D0 /bigraid
>>>>> ...
>>>>>
>>>>> [289714.420418] BTRFS info (device dm-2): balance: start -musage=3D=
0 -susage=3D0
>>>>> [289714.508411] BTRFS info (device dm-2): 64 enospc errors during b=
alance
>>>>> [289714.508413] BTRFS info (device dm-2): balance: ended with statu=
s: -28
>>>>>
>>>>> # cd /sys/fs/btrfs/e2843f83-aadf-418d-b36b-5642f906808f/allocation/=
 &&
>>>>> grep -Tr .
>>>>> metadata/raid1/used_bytes:	255838797824
>>>>> metadata/raid1/total_bytes:	441307889664
>>>>> metadata/disk_used:	511677595648
>>>>> metadata/bytes_pinned:	0
>>>>> metadata/bytes_used:	255838797824
>>>>> metadata/total_bytes_pinned:	999424
>>>>> metadata/disk_total:	882615779328
>>>>> metadata/total_bytes:	441307889664
>>>>> metadata/bytes_reserved:	4227072
>>>>> metadata/bytes_readonly:	65536
>>>>> metadata/bytes_may_use:	433502945280
>>>>> metadata/flags:	4
>>>>> system/raid1/used_bytes:	1474560
>>>>> system/raid1/total_bytes:	33554432
>>>>> system/disk_used:	2949120
>>>>> system/bytes_pinned:	0
>>>>> system/bytes_used:	1474560
>>>>> system/total_bytes_pinned:	0
>>>>> system/disk_total:	67108864
>>>>> system/total_bytes:	33554432
>>>>> system/bytes_reserved:	0
>>>>> system/bytes_readonly:	0
>>>>> system/bytes_may_use:	0
>>>>> system/flags:	2
>>>>> global_rsv_reserved:	536870912
>>>>> data/disk_used:	13645423230976
>>>>> data/bytes_pinned:	0
>>>>> data/bytes_used:	13645423230976
>>>>> data/single/used_bytes:	13645423230976
>>>>> data/single/total_bytes:	13661217226752
>>>>> data/total_bytes_pinned:	0
>>>>> data/disk_total:	13661217226752
>>>>> data/total_bytes:	13661217226752
>>>>> data/bytes_reserved:	117518336
>>>>> data/bytes_readonly:	196608
>>>>> data/bytes_may_use:	15064711168
>>>>> data/flags:	1
>>>>> global_rsv_size:	536870912
>>>>>
>>>>>
>>>>> Somewhat more frightening, this also happens on the system blocks:
>>>>>
>>>>> [288405.946776] BTRFS info (device dm-2): balance: ended with statu=
s: 0
>>>>> [289589.506357] BTRFS info (device dm-2): balance: start -musage=3D=
5 -susage=3D5
>>>>> [289589.905675] BTRFS info (device dm-2): relocating block group
>>>>> 9676759498752 flags system|raid1
>>>>> [289590.807033] BTRFS info (device dm-2): found 89 extents
>>>>> [289591.300212] BTRFS info (device dm-2): 16 enospc errors during b=
alance
>>>>> [289591.300216] BTRFS info (device dm-2): balance: ended with statu=
s: -28
>>>>>
>>>>> Matt
>>>>>
>>>>> On 2/3/20 9:40 PM, Chris Murphy wrote:
>>>>>> A developer might find it useful to see this reproduced with mount=

>>>>>> option enospc_debug. And soon after enospc the output from:
>>>>>>
>>>>>>  cd /sys/fs/btrfs/UUID/allocation/ && grep -Tr .
>>>>>>
>>>>>> yep, space then dot at the end
>>>>>>
>>>
>=20


--jzvr9ZXMcJq2jkwHElF38xeOsqeWY2zf0--

--XZOd9fK3HzHfbFI0yy3lMWAuOOSSCpwdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl46N8IACgkQwj2R86El
/qjVSwf/cORVg2Mj0bT9fslhTgqZUn5RvRCq0eEm+LsXhUrIeJ55ZqPaNjhmN/0x
v9u18Ai8pBVPMiEadZ2xUYT9OjcH8P+LCXJ24O9S0pmvht4DvcgDenhWWAsyA+gs
KUia9foUaflAESmJLAibQHSFmOJ2JjAHR/Zwr5/N7zqt48iOjVxUsX5MWihZZFXF
RJiyJlN+DjdK4rn/uRDJXouoHM2Ws4WCKoUO5fXolk6HW/1da5OXXgEuHLeEwgke
YTkXHwmp+JigeYl+jVgFsTDow9MvDZZNdVoReTSoXz43x/9kwTSQchaSlUm5cSt6
VUs3uIzzsiO7ORX/fD/w9zqlA8OdaA==
=DKdG
-----END PGP SIGNATURE-----

--XZOd9fK3HzHfbFI0yy3lMWAuOOSSCpwdP--
