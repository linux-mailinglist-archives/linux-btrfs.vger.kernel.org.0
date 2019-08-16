Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26B8FFB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHPKGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 06:06:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:56127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHPKGe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565949984;
        bh=/ceYqjgyTXVt/OuPJccXORiPPZUtmtoGG26TLxpMgTc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cg/8pke3oM8o6sOs2AUNv5PZoxQKCKbOXTXD6iszjc4Q4TVHCv/aS5qxdwTdH2AEZ
         H8wLia/mW/tEcx+HfvfFm1gwhhsPPo7p908aLek7dB3J4XcE/iAcfIRj4+6c4epKxe
         l0PYqI5UfdBiVesoggLGeSdXnaGcRfggbg7bhBSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1iAcOJ0ms0-00wS73; Fri, 16
 Aug 2019 12:06:23 +0200
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
 <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
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
Message-ID: <7ab52335-6a1c-46d9-5891-27fcd86db0e1@gmx.com>
Date:   Fri, 16 Aug 2019 18:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AZmb9hcA7FCvcU5aB4CL1u6mpLySq6mgE"
X-Provags-ID: V03:K1:pLjVwBC89bVA/B6fdzkUORhu/Pnkp7Ld/K7+nQhbcxhGdMQlHMz
 xUNqkMtZ9voLsxQHbHqfTvtB//KdFNV+eG3aR2tLKh/9bap+BAGoeKcvfC/nIUl3Ydrco2I
 vFaQjg1bVvOUpfSNN2juJQz4uDdCfjJMjVSheI7gpWt0dnbnjgGxm3ogqHttEB0GI9ignvH
 JArD69lNma87vfyVVoGsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kw/Aij0YmJE=:3RsKgs2fIQAwSrmTvTr9CO
 MzpbblssGX/YaTW/pKBR7bv7Y70fbr2EvfFwBRQnQQ7WXqTbNfY+VoNY4phcg4ytE52KPD6Cp
 mS8emmXQztYyy743HGnmTo4oNkxydKrK7YbH0sRZdNiN9iZWNjNmg2DqBRG9yTnAVkP+d9ilH
 AAafXDWjwLNxRMpM8MTMRt4g3Kl8XvSM3ntbLXX+87MOGT/JwXboWy13Z8kyUjchZIBG5UAdY
 LqiB0sGxpscfUy3pAHn8CkRphLED0HTqB1oxyu99YOxtoztw33wABIpNYjcE1C+qgRwSKdcZh
 TjxpJp0I1JKwxr31Zp9JmYcx6olIQKAECg5voBKfPVfSao+yXNlvFDD6+hPLxZM6XJhcBURPG
 c5+uPzKSldMgb/D+IiKbKrQ+n4BkB1YPCras6sbtvuRQznFIKAd+RgGVF41EOdQBO4lRhK3tE
 KEq4Yz3rpe1qPGR8pP2hDzrYHmrexXLc00RH7+Hv0DUW/5iKklBNZcJAANSuZg5vrpzZKowUD
 TctajeYd1/PJxC5/GBt4WzU5XgsiefSAf9uAFoLVBbcw9e5dADahqDp+yU9cFVJsxw5vwnmmW
 vGRIVil9nnX/XIiZZH8Orv63bVIWy60y1LqFO0h5fvMWwjWluIZlZ0b14zEXhYLYvOCkP4VyV
 Cel3g2dDZ7b3O5hocmSZnYadTX1n9YroRWQ/Xnv9skw1nSK6G6RwCdX8N3p0RebeAcQlSWa1i
 YwUCBwmEWaF75Q4aSjOeBsvi1u7E2GJWPicOPAzjtK9t5uz/fUBgjp7yoSYUhRj9Hzqo59Vgz
 1K3SPaCAJkm5RzNuGKw5ELeyxQvfa9GtJmBrCDVM+6p2kAusho0QkRgmJSWTbNHqeABhr8irh
 kYqyRen9dBiTUrIg3yiIh3aoCiwuIGunYJJ1IY1RhR/aF2V7eK1hSNP/53wWvG8ne07EBs3hV
 pPCTkkRJJTRpTHzLoSccDyD/uHTtI6VXYeyU7HdGyhKMFspUjKybQ1NoN9oul4p+cBs/vuhpW
 /UIOB4krl/i98gjUamaaR/P0r0Uqf1sqvMen0gOCue1ryW7QLLZ3jz0jStVof0vzSsp0LR8RL
 gY19jpicV6tl/MRyVDuNEHOLUFvErhMY60052QcnMZKxjS9qjnZzThjgw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AZmb9hcA7FCvcU5aB4CL1u6mpLySq6mgE
Content-Type: multipart/mixed; boundary="GjxvmmJH4p96KaUA0iEM6QEtJUfg0wJMR";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <7ab52335-6a1c-46d9-5891-27fcd86db0e1@gmx.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
 <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>

--GjxvmmJH4p96KaUA0iEM6QEtJUfg0wJMR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/16 =E4=B8=8B=E5=8D=886:03, Filipe Manana wrote:
> On Fri, Aug 16, 2019 at 10:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>
>>
>>
>> On 2019/8/16 =E4=B8=8B=E5=8D=885:33, Filipe Manana wrote:
>>> On Thu, Aug 15, 2019 at 9:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> Btrfs has btrfs_end_transaction_throttle() which could try to commit=

>>>> transaction when needed.
>>>>
>>>> However under most cases btrfs_end_transaction_throttle() won't real=
ly
>>>> commit transaction, due to the hard timing requirement.
>>>>
>>>> Now introduce a new error injection point, btrfs_need_trans_pressure=
(),
>>>> to allow btrfs_should_end_transaction() to return 1 and
>>>> btrfs_end_transaction_throttle() to fallback to
>>>> btrfs_commit_transaction().
>>>>
>>>> With such more aggressive transaction commit, we can dig deeper into=

>>>> cases like snapshot drop.
>>>> Now each reference drop of btrfs_drop_snapshot() will lead to a
>>>> transaction commit, allowing dm-logwrites to catch more details, oth=
er
>>>> than one big transaction dropping everything.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Add comment to explain why this function is needed
>>>> ---
>>>>  fs/btrfs/transaction.c | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>>> index 3f6811cdf803..8c5471b01d03 100644
>>>> --- a/fs/btrfs/transaction.c
>>>> +++ b/fs/btrfs/transaction.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include <linux/pagemap.h>
>>>>  #include <linux/blkdev.h>
>>>>  #include <linux/uuid.h>
>>>> +#include <linux/error-injection.h>
>>>>  #include "ctree.h"
>>>>  #include "disk-io.h"
>>>>  #include "transaction.h"
>>>> @@ -749,10 +750,25 @@ void btrfs_throttle(struct btrfs_fs_info *fs_i=
nfo)
>>>>         wait_current_trans(fs_info);
>>>>  }
>>>>
>>>> +/*
>>>> + * This function is to allow BPF to override the return value so th=
at we can
>>>> + * make btrfs to commit transaction more aggressively.
>>>> + *
>>>> + * It's a debug only feature, mainly used with dm-log-writes to cat=
ch more details
>>>> + * of transient operations like balance and subvolume drop.
>>>
>>> Transient? I think you mean long running operations that can span
>>> multiple transactions.
>>
>> Nope, really transient details.
>>
>> E.g catching subvolume dropping for each drop_progress update. While
>> under most one transaction can contain multiple drop_progress update o=
r
>> even the whole tree just get dropped in one transaction.
>>
>>>
>>>> + */
>>>> +static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_h=
andle *trans)
>>>> +{
>>>> +       return false;
>>>> +}
>>>> +ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);
>>>
>>> So, I'm not sure if it's really a good idea to have such specific
>>> things like this.
>>> Has this proven useful already? I.e., have you already found any bug =
using this?
>>
>> Not exactly.
>> I have observed a case where btrfs check gives false alert on missing =
a
>> backref of a dropped tree.
>=20
> Wasn't this fixed by Josef in
> https://github.com/kdave/btrfs-progs/commit/42a1aaeec47bc34ae4a923e3e8b=
2e55b59c01711
> ?

Oh...

> That's normal, the first phase of dropping a tree removes the
> references in the extent tree, and then only in the second phase we
> drop the leafs/nodes that pointed to the extent.

Yes, that's just a false alert from btrfs check, so it is nothing
related to kernel.

>=20
>>
>> Originally planned to use this feature to catch the exact update, but
>> the problem is, with this pressure, we need an extra ioctl to wait the=

>> full subvolume drop to finish.
>=20
> That, the ioctl to wait (or better, poll) for subvolume removal to
> complete (either all subvolumes or just a specific one), would be
> useful.

OK, would work on that feature.

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> Or we will get the fs unmounted before we really go to DROP_REFERENCE
>> phase, thus dm-log-writes gets nothing interesting.
>>
>> Thanks,
>> Qu
>>
>>>
>>> I often add such similar things myself for testing and debugging, but=

>>> because they are so specific, or ugly or verbose, I keep them to
>>> myself.
>>>
>>> Allowing the return value of should_end_transaction() to be
>>> overridden, using the same approach, would be more generic for
>>> example.
>>>
>>> Thanks.
>>>
>>>> +
>>>>  static int should_end_transaction(struct btrfs_trans_handle *trans)=

>>>>  {
>>>>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>>>
>>>> +       if (btrfs_need_trans_pressure(trans))
>>>> +               return 1;
>>>>         if (btrfs_check_space_for_delayed_refs(fs_info))
>>>>                 return 1;
>>>>
>>>> @@ -813,6 +829,8 @@ static int __btrfs_end_transaction(struct btrfs_=
trans_handle *trans,
>>>>
>>>>         btrfs_trans_release_chunk_metadata(trans);
>>>>
>>>> +       if (throttle && btrfs_need_trans_pressure(trans))
>>>> +               return btrfs_commit_transaction(trans);
>>>>         if (lock && READ_ONCE(cur_trans->state) =3D=3D TRANS_STATE_B=
LOCKED) {
>>>>                 if (throttle)
>>>>                         return btrfs_commit_transaction(trans);
>>>> --
>>>> 2.22.0
>>>>
>>>
>>>
>>
>=20
>=20


--GjxvmmJH4p96KaUA0iEM6QEtJUfg0wJMR--

--AZmb9hcA7FCvcU5aB4CL1u6mpLySq6mgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1WgBgACgkQwj2R86El
/qinIgf+MwzJLU2ppIhWEcdCMq/hN2lAHZYJHCHQXMa2/8mx9dy4tPSJ8x4TDthq
GOJuECXpDtJbvw6zz5XKUpgdd6bl+adSP2PUZcJIYAybRNmYbD/t7qRO3LH3uwYI
OJ8M7UvfeI6MhO6sqLO6d3P79JupzgqRkktSIdPLEF3SKzCDA0VTBdTkRLJDivQq
Tlgna9Eu31wZLshKUoj815yMlAk8MmtdbAUCPIvqTeRpCoyJKHgWRTAdYoH3lvGh
xoUKiJn8yJeKfkPCtML2V8/X6aQ3pyctsyHRYzl67GWFcZcV5oWT8fB9FSsVqm8s
NF/xfDqyzZvvvOpRa0gouSK1K+0Drw==
=0E/Q
-----END PGP SIGNATURE-----

--AZmb9hcA7FCvcU5aB4CL1u6mpLySq6mgE--
