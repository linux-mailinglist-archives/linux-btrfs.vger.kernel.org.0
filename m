Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2793E91C43
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 07:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfHSFOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 01:14:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:47149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSFOb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 01:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566191663;
        bh=JuUN0SLO7/1VDIszJlkFJSmCapxzCX0AnIL26Gry0MM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f7dnwXqz/CtqXHWN4yzMHSHByBK+JGsvybCo5/8foueRzwG1NdfAZy4Hq1lkvf9g5
         OxTJ2wCCAWexuOfaNnSwd64UsO1piGSzZvQ/H3KRjPHYVzqaq9EKqIaymU7XczlGXl
         /C3qiclTiRGegce9NGX+YVlQVw8sOoq4NaQDmtFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M3j17-1iHf4x3HdZ-00rJJM; Mon, 19
 Aug 2019 07:14:23 +0200
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
Message-ID: <ab1df7bf-a168-f385-447a-2e8cb13c6a93@gmx.com>
Date:   Mon, 19 Aug 2019 13:14:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5Hiz1LoLsUsCyIomCkUSXPgE8nLr9Rg1d"
X-Provags-ID: V03:K1:vRjJu/EcdUm7oSyvB3iW9+GkASpimOB6O+0S+dev/LP4JMjwixc
 4MPtB7VXibOYV1RfGMY1RC7J58LuaFcQA0yAV84jYF6tQ6l8tAmzWSbSaE5pf/KM9e4rBlL
 f50GoCRPY1d/1dc2dRNQmC5PsfiIy8pMTMvt020OWiI/paPJLiTNtEskYGou6lEIbjsNmj8
 dhriaKy8tvAf6V0GDW3Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IyJsNQeZuZs=:14FIdMcyypejwck3yP8eUS
 Ft0s90y/MX39I5jkNGXF3sCgU3PixJ/BjaOLC7V0i+8YCN0NfMVPVcooTfmpts0oA3V7VCqwx
 9cKdBafAbw2cJdnIUnThDpp/QwXF3J10OV/A9tfNmlscj1hi2l5znoA+yjlADHa4uBT+z4npP
 sIQeYRUXilELkQd+sBWsXLgiB/QEcv7XKvvLTxQ0N3VMpPO4woxj2xiKRWYQ4bUqQxyDpI1SK
 O49euHxyleMzsLBjv2izAgLdLK4ApBacSXeh/jAby6zTwgvTKNQOcH2f45q5zdzTDbGA5iDgy
 K3O9EZd5Q2hdbImrrh8150rtzx1L1oto/mYM/TfEMc/KMEmbrVyMtEL1oqE3bCExVZrOoy/BC
 Vj5xKN5TbiV3/GFufikSnQ8JAnsanznYFo8AisKp9YnrKopVk26w68PfL20fHoUJwGmL/D9Bl
 kEZmCuq5HIGdJ4yrPhMtufVCaKKDl13Cka9BARZw03z74JeyZ7pTa56ygyuyfkJiJOhEyw0PY
 uyAptDZDuJKY7zYmRTbiQplaPo7Unz75Rw7ZpQ/nm8uRofqg0lDKtxLHGJWZ73IYQKbCO/qAZ
 9Fsadk5LFf4T4FBs5Q6G3Vey/yKHSz18ASLWAFO/TFxw4QZFbY8UoA2J8gA0AvQazfWRHr0tX
 P3J4LNTokjvsyVJfeYItyBYs8+zzgcz+sM1+38isxKGz0PHU+n31RvpjKmODfLQwkVIJ+56bh
 fJGBq2FB4Mi9TkeKo4FagOhqIHdS7zQtDzBg3T29E9kyPXly+0rGG6Q0HLC1lNu4OEriCKtpy
 mGMBp7MnfLpuWXOtCDKn3vuMZy76E5suSPdziaPalnFDjy9mp2j/7/TwOLrYv9q6N+/XjYOda
 G4tkMFcaRf7QiGTdAJJq3QwLAMBjvFTFueegmEitoJWjTym9n4oqL3vwG1FLG5g/ftE9c16ZH
 09U1wMClc14GWpfyitVGIEh/1lzIVuRuM0ibLu590+Itn62cdZ5Xc2Yf8jIa9iZjlJa7k33Nk
 t0PRtbNp7sp4/h52qPheFtdWLPCKb+Ox7AZHc8LkXulYl+dJ5P7ilJl9Tv/OyhcHS7YRy4e6t
 e6rpBmZB8uqRus7/r4mygQGhgRoAnMPNPlXNoIEylEX52iDmfiV1DWF0Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Hiz1LoLsUsCyIomCkUSXPgE8nLr9Rg1d
Content-Type: multipart/mixed; boundary="iP0ZkH1bFp06VDAzmgSL9cDEqlilcYqTq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <ab1df7bf-a168-f385-447a-2e8cb13c6a93@gmx.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
In-Reply-To: <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>

--iP0ZkH1bFp06VDAzmgSL9cDEqlilcYqTq
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
>=20
> I often add such similar things myself for testing and debugging, but
> because they are so specific, or ugly or verbose, I keep them to
> myself.
>=20
> Allowing the return value of should_end_transaction() to be
> overridden, using the same approach, would be more generic for
> example.

Forgot to mention there is another function checking this:
__btrfs_end_transaction.

If btrfs_need_trans_pressure() returns true, __btrfs_end_transaction()
will try to commit transaction for btrfs_end_transaction_throttle().

Thanks,
Qu

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


--iP0ZkH1bFp06VDAzmgSL9cDEqlilcYqTq--

--5Hiz1LoLsUsCyIomCkUSXPgE8nLr9Rg1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1aMCoACgkQwj2R86El
/qiEHwf/ZYpMGzFR03dAbvY+BvY73rgDDAaNQ7lfNyMuMNjJC8d8Ah2dvjATMZVY
MxwKieryuCs58W4je1X51vO+1OouebuPdMR2RAFqPC4bkmfmRSKP2KHnSCc1iAvg
O0/6r4eaubjzeuKpa7mE6QOP0h11rlG2CGT9d7IVAgpfTEW++X/jXnbSp7KvteeS
VPoSAytOJomOzTaYivH60SofJSXd9VTMaEFUtCFLKV8J6vo3ZE+KePTg8j2XzknE
Em73lBJSyOK9n0L/PzF0AFCqd2D+v95E0nMVOuS8PUaaE+360gHG1+G8VuIykOd9
jyNuFvC/KBP71dAxZ1BydGORB48RMw==
=hTvO
-----END PGP SIGNATURE-----

--5Hiz1LoLsUsCyIomCkUSXPgE8nLr9Rg1d--
