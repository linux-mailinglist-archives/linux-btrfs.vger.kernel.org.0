Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8BBDBCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfIYKDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 06:03:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:53133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfIYKDf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569405808;
        bh=ol3PxNTC71Jnr5kOc08PuPyGbna71PBFBGVsQ9MWrTw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hJPXGFojmp7uWT3Xuc0NyXaGGLPddyZlap5rXkeVQrOWkbEAWJqnV3fIgEvJTTIbb
         hO3llgzOAzBOING50JhVta+1eQx55DSEhrHWJF84fO3IrexcCGW52AjVimYGU+Vjvd
         nWoabMJAe88g4+HMq9vBKtQZicZQ/ilk598VBNcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1hayAO19h5-00cSf3; Wed, 25
 Sep 2019 12:03:28 +0200
Subject: Re: [PATCH] fstests: btrfs/011: Fill the fs to ensure we have enough
 data for dev-replace
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190923124347.30850-1-wqu@suse.com>
 <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <52c7fccb-a760-25ae-f3d0-14994ffe480e@gmx.com>
Date:   Wed, 25 Sep 2019 18:03:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a"
X-Provags-ID: V03:K1:pLUmN2fugaiRfgmA6d4SSIooA3FDaDMpAzK1jIw4Wtg/EmK550Z
 4typEKJsCj4yZR5KP8y5eAIloc876B+8tVTPH+Jxmy9wHtZDig4hxfcOjkCns6o5+LglVuq
 Zz7xkJ5G4AW+Q5nDt3+tYTpPYcFWjXEmlw/6M11z02vXDxUhCmenY6DWyOOcEADxaC74pMZ
 YdeoEdSfUI/oltaGVifnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/RRdUqgGFKs=:j4LQDl0yyTeOLYkBNYSJI6
 DkWGh9qDOaMtdKQLu33L9Hpx/J/QWD4nKz3hDw0nXqPMrFSAzuKAKXe5GbBHUgsVltJncladD
 K3EpZMnP7coYucc+zmN8hJpj/MElX8kyQlDdcY7F9aNa+T0x8gfj3jiqDdEaGmUUPXvcgWXiy
 90jO9qI53ddP5g7FCi5J9GK9KrYfVETrLpItg5+JxGdd/gqH3voKeCtM6PnG/bdHsH47sw8dj
 Arj1wjXpvCnLM1c0VDIYHaloWTEM23UVnPQbBzg34XM/2586ZpgJxViIliVL3M0aT8kD0Bk6z
 +bfUggv9CBXtiKnWjNxraDU9RL8AF5X02C5Kl1KogkV/WSVrkIcdZSX1xjyTTDakkLwFvGogP
 /xMfnA8De4pWWw42DNKBmlYBf57rHZ6M64GU7hewFY9AoYKla7OPdqVGI2bun3gvCjbBQU4t8
 X+NZNdQ1usjw0NJTeNET+ZiaxN9Ac8vuQL350izEkkN+OUoJjCE38POoLYsOCvGoaTCJNk4yi
 o4OFA8um1HCcYov0bqI+kRhdRvt2KEuGV2jv5bOb91hndEeZZVlGFOGYfMf4Xrt4RgO8WFNk4
 H9FVByW/ZxciPB4neahMGFJvIHHzf5neE5IM1RKl1+WYl60cPWJxo0MiBwKuqTWzrohB17bvz
 rDYEQaJ2J44c35Oa8vba29Ywn9oh0ZYliQ/WAockVbOqmqjVaCdexLUajS1+jP7V7t3JRl0ME
 VuoToHmH04dLCObFjRsftquCs27kx2Pltu4qLIB9xfglYVQPMOSWAe0f1lnZCe4IktcktuE/s
 0JSew198EN8rf4pLMsJee6RK2aSiu7Anu7uIWwB5vU3ZgdSTHJoRWyB9v9+a6JphkOtQWN+z3
 iwnx6wgtNGIRC6cSy68rnJJraPspEHdlgYysvtr6qv8Y9W2mEKx9k5AaH5+HwGoBdlzpW+xm5
 poxqm7nopx+jKLcqkrF6GOe0xK4KJnGwKePNJpSkUAXZxJBhrsM77k8pGXQ1ZwSJZkJyndvgo
 ZTUtSSrUPlK8N7OcWdfPC4tINTBXchFrSYQ4ROHPF0RUE7K0ynnIqsBh1nRb/mwfQV/Xqj6UY
 jjpglAQCXtEOkXDu0TRf5B/zZHx2guibDUTQKOrpzo04W9JRAl3q72u7+dTOQBTdRejDVia0g
 ZSIHgsi4WGyuvxKy/UivvBarhUPcFVrhov3ywpfQNNbT7+kIDv8jGLbjrGxuhR+HIPpMzHUVW
 9NrjYKeLOERIUezHCF0QwaADzd7Y74SD6x5qMsFMuKrEgri0iW+TwxxvFju8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a
Content-Type: multipart/mixed; boundary="30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA"

--30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/25 =E4=B8=8B=E5=8D=885:48, Filipe Manana wrote:
[...]
>> +
>> +       # If the system is too fast and the fs is too small, then skip=
 the test
>> +       if grep -q "No space left" $tmp.filler_result; then
>> +               ls -alh $SCRATCH_MNT >> $seqres.full
>> +               cat $tmp.filler_result >> $seqres.full
>> +               _notrun "system too fast and/or too small fs"
>=20
> It would probably be better to require so minimal size for the
> filesystem instead.
>=20
>> +       fi
>> +       # If killed properly, this file should be empty.
>=20
> Confusing comment for me. If killed properly? How does that influence
> the file being empty?
> What influences the file being empty is that it's impossible (in
> practice) for xfs_io to complete the write in less then 2 seconds,
> assuming the fs isn't very small and it hits ENOSPC in less than 2
> seconds.

The point I want to express is, if xfs_io is killed by KILL signal
halfway without finish, it doesn't output anything. So if the output
file is not empty (and not ENOSPC), we must have something wrong happened=
=2E

I'll rephrase that line.

Thanks,
Qu
>=20
> I would rephrase that or remove that line.
>=20
> Other than that it looks ok to me.
>=20
> Thanks
>=20
>> +       # If something other than ENOSPC happened, output to make sure=
 we can
>> +       # detect the error
>> +       cat $tmp.filler_result
>>         sync; sync
>>  }
>>
>> @@ -147,7 +178,7 @@ btrfs_replace_test()
>>         if [ "${with_cancel}Q" =3D "cancelQ" ]; then
>>                 # background the replace operation (no '-B' option giv=
en)
>>                 _run_btrfs_util_prog replace start -f $replace_options=
 $source_dev $target_dev $SCRATCH_MNT
>> -               sleep 1
>> +               sleep $wait_time
>>                 _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>>
>>                 # 'replace status' waits for the replace operation to =
finish
>> @@ -157,10 +188,10 @@ btrfs_replace_test()
>>                 grep -q canceled $tmp.tmp || _fail "btrfs replace stat=
us (canceled) failed"
>>         else
>>                 if [ "${quick}Q" =3D "thoroughQ" ]; then
>> -                       # On current hardware, the thorough test runs
>> -                       # more than a second. This is a chance to forc=
e
>> -                       # a sync in the middle of the replace operatio=
n.
>> -                       (sleep 1; sync) > /dev/null 2>&1 &
>> +                       # The thorough test runs around 2 * $wait_time=
 seconds.
>> +                       # This is a chance to force a sync in the midd=
le of the
>> +                       # replace operation.
>> +                       (sleep $wait_time; sync) > /dev/null 2>&1 &
>>                 fi
>>                 _run_btrfs_util_prog replace start -Bf $replace_option=
s $source_dev $target_dev $SCRATCH_MNT
>>
>> --
>> 2.22.0
>>
>=20
>=20


--30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA--

--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2LO2oACgkQwj2R86El
/qgdiQf+JvjWxMjjgcaYOMb0mQONW+5PDuP1gGCbeaT52FG1P5DzXOtE9tzN613A
osI/bo/cUU0bTu3wZ8iOIXgoGRBWnfFemS8EflAJAHiIpdq5Bxaqi68TjjIbrl9I
xKQS9Evx1InoUF3N1I2n7+KQ2Sd/kJ+Fxn77vtpyBzgDQgGgLkq5RsCrA70PClkN
8OLooKoCCn5E10Ka7Az720SM8Ufg4CDgjb9dSO2Vk3c2BCLUMIYjJYGCKSR6TbqU
UB29dNCHoHeJILhZpJElRV9G4a27Vn9rfrEzBJi9tTYPMbab7V/qjyQ9ApqKqBML
eeb08UJM5G6/xvXL/VSQdEiBQlR0CA==
=CRBe
-----END PGP SIGNATURE-----

--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a--
