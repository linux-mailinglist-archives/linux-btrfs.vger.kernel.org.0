Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1548FF7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHPJx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 05:53:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:37171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfHPJx7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 05:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565949211;
        bh=TkhxWHM8C8jN27BbuQJv40SdIsV5PVPep2MQPkvZbDk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GiEGBv3YrA7BcG9/pQ7vr7Nl3Xwsv0lDLLe3yzkHNE0PJbg1qB081SK9JApAfUEUi
         KLOWx2yq/uA0YaKLpD8PIl7kp/tel7YJ6ZKXIW5Tgia7sMV6oto3fI5fNGqYvqocC+
         L9BwaZG2yZ/gQqVivjOnEDvocBeq6T8AUy9d+VKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MU1MP-1hpvyM04Hp-00QoEA; Fri, 16
 Aug 2019 11:53:31 +0200
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
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
Message-ID: <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
Date:   Fri, 16 Aug 2019 17:53:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qycI9LXnEttmC5Hto6f3gdIp4POxGDLNd"
X-Provags-ID: V03:K1:ecFpmzZrMgnf1NonWq7YkSGKbH9JhiLFhUbHGpxq0YY6/wgQT/H
 fjAhEYS2rM19Cae9riPZf1+Dv20wpRpmvK3i+kuCTTnYF7xEgwolMfsEBCb3rM977HHWQe1
 A3lz6tGCtETohEhNXupoLG+LVd+J8MO6DUHOqa/YAQBoUtO2CrzzULG+RRQi2tZwKrhlLJw
 5SV1q8S57Talgh7AyDz1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sse0JugI0Ag=:Ai7MeiBUTE2jKPSPZLkb1q
 uiriPKNIPYvxy4/hk29ZwqII2QGKat/FfeHL30Pb/bb2g8dT7GbS4VRjSKqtXh75gzyY9KpZE
 fowOnfRrY8/fqGLYqyqskAkXEg1X4MM1btHj82+SUlMpcvlmbch+oAW/C8ERpBlOVuBQj2u+b
 tifpOMqKzcshHjDHw/zPoFmYd0Y9q0F9aXEkAqJoGAIDZ/DKrNwFjXfkHVKWx3zAP3q8dhRid
 UxTOE73sBSaHOm6xTWNVBmqupwUKy9DIgS0GyNXE7CHytjhbaRAdx6AlzV2kVxvM0KIUPRzt5
 QBgiRYvtkahCap0VpB7haBRmhvNu0/b9HKDs3xh9bJuNKPshle5lrNVVqY/tTFSZPFlFyxICa
 b7JUcKcR4wwqW+n4S6NeomCkLspH5l9hH5P4n3OL/hdObeoZi3LYM2lvIIAlcwvte2wgspTnL
 qLvXAodmylSYr/RI8gZK3R15jXG7zuPvNwmW/FMF/FtWQJXFqQ0d/iC23kvEzbusw7VehdRTB
 jjxBbqtX8GLqewGceox/xtn609gVviMtHUPZT2ijbfvskr39WX5o0jrWn1TLJlBSN/tlDHpQZ
 eQ74Y4cq70T2RKR3i/OfEw2u+fg14Vm7+OBs+2bBIsr6umzZ08DpLUudVuIEFnyXb74CfZbKl
 nVZDD+iOtLGukYSiWz3eN1rRSQHM/U4gcXldkaC1uMQOHjc2rzTnd+roTuWFolXaDD1FpckiM
 6skNqMlCPyDYcZRPGyzAi6uV5CY9yDiF0Vf3Q4D4/8EMpGwTpqsQwvNHZi6P+unaKopjDyACr
 KwPezcGccsUK6NlqMVYn00OqXzsZHO25OzLE4QKNN8pVrOvyMT/BeML36LuLO4nMdShIHyuNY
 uIQKWHeVDcFsUvxTgBSIWVp0fdc0cM2swNFZKEXa+uttYbJI6MGNnVuwGoyL8/XapnSeoNCGo
 VIi57NzA3SwX1SuJyyZHmflouSi4jJMX8xeSSwj+2VqQx/tIQoxamZIy5q6aGmNwvvhYx3hO7
 8vLY8Mjq8p+nH8umm8gGVtiRNENUP6rMtHnvD0UNqlrGqk+nIU6Ce5U2021rebJ1x01eJ0oYm
 bDWMIMbz/G9L9eq8sbWHHrj2dLvyJ+THFiCdiqjZ1cdw57kXV4ADPcu/w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qycI9LXnEttmC5Hto6f3gdIp4POxGDLNd
Content-Type: multipart/mixed; boundary="P0RgvaRv8occlTwPVdMf0yKJek8ERVQwQ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
In-Reply-To: <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>

--P0RgvaRv8occlTwPVdMf0yKJek8ERVQwQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/16 =E4=B8=8B=E5=8D=885:33, Filipe Manana wrote:
> On Thu, Aug 15, 2019 at 9:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Btrfs has btrfs_end_transaction_throttle() which could try to commit
>> transaction when needed.
>>
>> However under most cases btrfs_end_transaction_throttle() won't really=

>> commit transaction, due to the hard timing requirement.
>>
>> Now introduce a new error injection point, btrfs_need_trans_pressure()=
,
>> to allow btrfs_should_end_transaction() to return 1 and
>> btrfs_end_transaction_throttle() to fallback to
>> btrfs_commit_transaction().
>>
>> With such more aggressive transaction commit, we can dig deeper into
>> cases like snapshot drop.
>> Now each reference drop of btrfs_drop_snapshot() will lead to a
>> transaction commit, allowing dm-logwrites to catch more details, other=

>> than one big transaction dropping everything.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add comment to explain why this function is needed
>> ---
>>  fs/btrfs/transaction.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 3f6811cdf803..8c5471b01d03 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/blkdev.h>
>>  #include <linux/uuid.h>
>> +#include <linux/error-injection.h>
>>  #include "ctree.h"
>>  #include "disk-io.h"
>>  #include "transaction.h"
>> @@ -749,10 +750,25 @@ void btrfs_throttle(struct btrfs_fs_info *fs_inf=
o)
>>         wait_current_trans(fs_info);
>>  }
>>
>> +/*
>> + * This function is to allow BPF to override the return value so that=
 we can
>> + * make btrfs to commit transaction more aggressively.
>> + *
>> + * It's a debug only feature, mainly used with dm-log-writes to catch=
 more details
>> + * of transient operations like balance and subvolume drop.
>=20
> Transient? I think you mean long running operations that can span
> multiple transactions.

Nope, really transient details.

E.g catching subvolume dropping for each drop_progress update. While
under most one transaction can contain multiple drop_progress update or
even the whole tree just get dropped in one transaction.

>=20
>> + */
>> +static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_han=
dle *trans)
>> +{
>> +       return false;
>> +}
>> +ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);
>=20
> So, I'm not sure if it's really a good idea to have such specific
> things like this.
> Has this proven useful already? I.e., have you already found any bug us=
ing this?

Not exactly.
I have observed a case where btrfs check gives false alert on missing a
backref of a dropped tree.

Originally planned to use this feature to catch the exact update, but
the problem is, with this pressure, we need an extra ioctl to wait the
full subvolume drop to finish.

Or we will get the fs unmounted before we really go to DROP_REFERENCE
phase, thus dm-log-writes gets nothing interesting.

Thanks,
Qu

>=20
> I often add such similar things myself for testing and debugging, but
> because they are so specific, or ugly or verbose, I keep them to
> myself.
>=20
> Allowing the return value of should_end_transaction() to be
> overridden, using the same approach, would be more generic for
> example.
>=20
> Thanks.
>=20
>> +
>>  static int should_end_transaction(struct btrfs_trans_handle *trans)
>>  {
>>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>>
>> +       if (btrfs_need_trans_pressure(trans))
>> +               return 1;
>>         if (btrfs_check_space_for_delayed_refs(fs_info))
>>                 return 1;
>>
>> @@ -813,6 +829,8 @@ static int __btrfs_end_transaction(struct btrfs_tr=
ans_handle *trans,
>>
>>         btrfs_trans_release_chunk_metadata(trans);
>>
>> +       if (throttle && btrfs_need_trans_pressure(trans))
>> +               return btrfs_commit_transaction(trans);
>>         if (lock && READ_ONCE(cur_trans->state) =3D=3D TRANS_STATE_BLO=
CKED) {
>>                 if (throttle)
>>                         return btrfs_commit_transaction(trans);
>> --
>> 2.22.0
>>
>=20
>=20


--P0RgvaRv8occlTwPVdMf0yKJek8ERVQwQ--

--qycI9LXnEttmC5Hto6f3gdIp4POxGDLNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1WfRUACgkQwj2R86El
/qhoTwf8C32wjFq3lAYk0+gsi8xhB8wXn9UA7wsqgePYJ0Y2ZjXYjM4uYSJ+tNos
PW15zeawrNUzvTgW9FXRO7gt5vIMf3ZQ48TtZ7fYT5mE+uBUXoSf0qhfVA/APa9X
J9skGcqlPhyhbWIorQlrdIgYmofXMSrxFwHb+sMMF+E3IsBy0E3tzPtabH7RJPtD
przT31t6lQWgVWXIn5iXpyRK0IWZQ/JbjLCIXno/CTiI0X+O2/kUJyhq+eJBuJpz
wRQjdTOoo/wkRKMmOAK4PteXgMiojpHyDSe88cL+OaW2MUeleh+M7hh5k/VlaHaC
g85R1HNzpQ+kL90Jr6MR4Sve5F3zNA==
=B+z/
-----END PGP SIGNATURE-----

--qycI9LXnEttmC5Hto6f3gdIp4POxGDLNd--
