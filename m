Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B429A1DB1CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETLcf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 07:32:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:57389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETLce (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 07:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589974346;
        bh=kYT5Z3clkOeU/C2FJw4PsKEcu20UYv6LoWbyjp8KQ8c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TjkMTLMr4FqcC7PDefPkQK1hJtHd6jDskAq8K2gXofcAbpj6DnpLD0EEW7f1MoelK
         R+5f0r8U9Zuxptf68+q3WolbIDgV/PzBV1wWH2oI/6RdX5qGW0J5WoW04r8pSbnTzr
         hVIEQUwWF5a0vnFki1llBStMxikT9n5+97z86f7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfNl-1im9wr0CuF-00v88i; Wed, 20
 May 2020 13:32:26 +0200
Subject: Re: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20200520075746.16245-1-wqu@suse.com>
 <CAL3q7H7fY0fyiPS=LiFYDxHBAXqQF_WuZu7z=jKQv8DTkPadMA@mail.gmail.com>
 <b109c38d-288b-3a4f-de7b-6a2d52c2be7a@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <e374561f-397a-8ab3-e2d4-cac423da6636@gmx.com>
Date:   Wed, 20 May 2020 19:32:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b109c38d-288b-3a4f-de7b-6a2d52c2be7a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIZ6FKBruG2hudBTxAQqfPezs13IGRnTr"
X-Provags-ID: V03:K1:zZMTWnlx1xwg1/HhetK0JZbZzAgpCjnmsDGDEvb8fy7Q3WoIBfs
 fiYNFZe+KMOA4UT/jBxD2Q1WB4UbDIeqEaJtstpPII8BWwwmalYXvIE/PgxxoOwenEjaMPY
 18k7GxqKoSbL10NgdcHfJsdrg+OySkHcwttSaN5uQukHlEERFJvt2v6rmKh211vI57GdXLo
 /8LXJe0A/EIMyTaadVbLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:08Uguz2j0eM=:5C0MhhIju+hIv1BsQqk68r
 aCwRQZ2JQIEqFDOSmG/ObnzjaOHLmDdhvllmja2i1krs9zOvQn6jj1/am9Ej2dIVhuWMRkSsw
 quiRHldXEsTE+xCBBST077UvfzvA8Od52eWuGBtCkcN5FPPFd1xzMVMgCuD05nGsfgknwaery
 ssnJiJcQ65MrdaQejQRz7vq5JeeGZS/ZPMvxqwX8x/Jg3f7nstw2h4AoFAKskIj7cBGYNfO5X
 Rmh9G2GUJtbmJIa2NSFgyN5ef8JdUCkJidWm/6HhB/xwVlJvdl7KgeKazxrw5S7qULu+yYWMM
 dJKSASnvLh2IJmJ2aaC+2jAOvk51z4U9hVo2GrX0GOVbyV/bjjI/cPisRD5l4iGSC90lZfoBf
 danqkPHKFTVYIFBjC7s8623Og98HANOgypjrV1xeEHaRqVeBEV/sOLqPVXQ/5RTEQcwR1xJc0
 7elQGL0KwEaX0YYkGrGlMdi8KgjwOWIa0CTea52rk7TuVDmJmPreP3ILP0y3X90+7LvvxBMEK
 okiPt10SvSwChj+WaQm6nxKRCmgnAVU6mvnNMp1k3vElG4mDV01yDUes8+FH2pDlSD/FXfvyd
 m7dzDK8m/9e2nnIF6vCBu7NNUeHRjzMYoXJiQ/mkY3jXaaczV84jxiVjxfkB7ySyPs5s4oP7R
 gWxGbTSXS4AQoEo0TFFLF9SBvL2BLrfWy5EsB5fRoibAmJsM8YtKzmgqb2YTrdwiqWuOAhhbo
 3Iz0O8v3/5Tcm1NV1ztm425buc/m7t1dcvHO8MedpbddsMC388dRoBtaVZFRtx9sxTHiGb9Mz
 dYu6z9S4ysehRY255lKqcWaKd52oXsmBqNYr4pHG2gFo3g3DqWIViXaDuwVtm/8i9Q6nhVlyR
 U0YlFgx4n7xcGZWwAyEC79Tw9G8doBnY/0+kq9RF/H0qcHYYqXgwxtX7XA0RkyZdsCXZGxPZX
 6hyeSi3Ey00whvrNx4gJ2cT/ftpsNBVPxF5TVfRSMCyqh9EQ+BpTVqnnrIVPVCcGNSDzbx/AB
 5vrEKLWUu+w2XXEiall/+O5/FLYja7oB4n7GZpvGAh+/3NHcxYo8p/AH0v5QOlfNXAXK8czyv
 cVOxMWG040/ojAhpAefrxG92BB44vFHlAIh3Rfncl7Cbakt15ijm+0nzWx8KEX53BdhYZ7iqz
 ChquT/4PzCLWfYzG4h2WmiLP+gUQrfEZEBViyh2Tl8w30MHwE+jdbOYR/COWJWemrxz+Nh/J8
 r7POvE/km+TGpxCnM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIZ6FKBruG2hudBTxAQqfPezs13IGRnTr
Content-Type: multipart/mixed; boundary="2f5q1z8PMaVdIeAt6BBT99NWWjmXlTOKW"

--2f5q1z8PMaVdIeAt6BBT99NWWjmXlTOKW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/20 =E4=B8=8B=E5=8D=886:02, Qu Wenruo wrote:
>=20
>=20
> On 2020/5/20 =E4=B8=8B=E5=8D=885:29, Filipe Manana wrote:
>> On Wed, May 20, 2020 at 8:59 AM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> Test if canceling a running balance can cause later balance to dead
>>> loop.
>>>
>>> The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit f=
or
>>>  orphan roots to prevent runaway balance".
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Remove lsof debug output
>>> v3:
>>> - Remove ps debug output
>>> ---
>>>  tests/btrfs/213     | 64 +++++++++++++++++++++++++++++++++++++++++++=
++
>>>  tests/btrfs/213.out |  2 ++
>>>  tests/btrfs/group   |  1 +
>>>  3 files changed, 67 insertions(+)
>>>  create mode 100755 tests/btrfs/213
>>>  create mode 100644 tests/btrfs/213.out
>>>
>>> diff --git a/tests/btrfs/213 b/tests/btrfs/213
>>> new file mode 100755
>>> index 00000000..f56b0279
>>> --- /dev/null
>>> +++ b/tests/btrfs/213
>>> @@ -0,0 +1,64 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 213
>>> +#
>>> +# Test if canceling a running balance can lead to dead looping balan=
ce
>>> +#
>>> +seq=3D`basename $0`
>>> +seqres=3D$RESULT_DIR/$seq
>>> +echo "QA output created by $seq"
>>> +
>>> +here=3D`pwd`
>>> +tmp=3D/tmp/$$
>>> +status=3D1       # failure is the default!
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_cleanup()
>>> +{
>>> +       cd /
>>> +       rm -f $tmp.*
>>> +}
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common/rc
>>> +. ./common/filter
>>> +
>>> +# remove previous $seqres.full before test
>>> +rm -f $seqres.full
>>> +
>>> +# Modify as appropriate.
>>> +_supported_fs btrfs
>>> +_supported_os Linux
>>> +_require_scratch
>>> +_require_command "$KILLALL_PROG" killall
>>> +
>>> +_scratch_mkfs >> $seqres.full
>>> +_scratch_mount
>>> +
>>> +runtime=3D4
>>> +
>>> +# Create enough IO so that we need around $runtime seconds to reloca=
te it
>>> +dd if=3D/dev/zero bs=3D1M of=3D"$SCRATCH_MNT/file" oflag=3Dsync stat=
us=3Dnone \
>>> +       &> /dev/null &
>>> +dd_pid=3D$!
>>> +sleep $runtime
>>> +"$KILLALL_PROG" -q dd &> /dev/null
>>
>> Do we really need the killall program? There's only one dd process.
>>
>> We should also kill the dd process at _cleanup(), as killing the test
>> during the sleep above will result in the dd process not being killed.=

>=20
> The main problem here is, I can't find a good way to kill dd.
> plain 'kill $dd_pid' doesn't seem to kill it properly, as my debug
> lsof/ps still shows dd running and failed to unmount the fs.
>=20
> 'kill -KILL $dd_pid' kills it well, but causes extra output for the
> terminated dd.
>=20
> Only 'killall -q dd' works as expected.
>=20
> Any good advice on this?

Oh, the fstests "kindly" overrides dd, "kill $dd_pid" only kills the
child bash running that dd function, not the real dd command.
I'll use xfs_io to ensure we get no extra wrapper.

Thanks,
Qu

>=20
>>
>>> +wait $dd_pid
>>> +
>>> +# Now balance should take at least $runtime seconds, we can cancel i=
t at
>>> +# $runtime/2 to ensure a success cancel.
>>> +$BTRFS_UTIL_PROG balance start -d --bg "$SCRATCH_MNT"
>>> +sleep $(($runtime / 2))
>>> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
>>> +
>>> +# Now check if we can finish relocating metadata, which should finis=
h very
>>> +# quickly
>>> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full
>>
>> Why redirect this one to $seqres.full and not the other balance? What
>> kind of useful information it provides?
>=20
> Not really much, just an indicator to show that the balance finishes as=

> expected.
> And we don't want to output it golden output, as mkfs change may create=

> more metadata chunks and cause difference.
>=20
> For other ones, like the one to be canceled, we don't really care that =
much.
>=20
> Thanks,
> Qu
>>
>>> +
>>> +echo "Silence is golden"
>>> +
>>> +# success, all done
>>> +status=3D0
>>> +exit
>>> diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
>>> new file mode 100644
>>> index 00000000..bd8f2430
>>> --- /dev/null
>>> +++ b/tests/btrfs/213.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 213
>>> +Silence is golden
>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>> index 8d65bddd..fe4d5bb3 100644
>>> --- a/tests/btrfs/group
>>> +++ b/tests/btrfs/group
>>> @@ -215,3 +215,4 @@
>>>  210 auto quick qgroup snapshot
>>>  211 auto quick log prealloc
>>>  212 auto balance dangerous
>>> +213 auto fast balance dangerous
>>
>> fast -> quick
>>
>> Thanks.
>>
>>> --
>>> 2.26.2
>>>
>>
>>
>=20


--2f5q1z8PMaVdIeAt6BBT99NWWjmXlTOKW--

--GIZ6FKBruG2hudBTxAQqfPezs13IGRnTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7FFUYACgkQwj2R86El
/qjcKwgAnuaDFur9A+FZpoMmH4g/bwvuvNoIEk51MaQ1KnXBym5ZX6VJfHwfEYMV
ilOWRdaLfNouZC12mrKfRyj0/9sdIEC05tYEDwZmlON5oRLXKs4S/MvQjbupVad3
AUrhf3vxis4KpVKbTDAeFlhEqIVtL/uG5SwDT52Rrs/3/bN7j8h0VAu5QhaDY5Mf
Yj2imZbDoRoWuYPZNCGE4M94zFZOAa5oSEP+JLUtb6XVIYDUZvQMSO0pS67GSMlE
pdcjC4SJ+c587sNm3tYc+KPh73tsxMxOG/zWADnA6OzJLDrN/TrF48BpklkmCJMd
HCeRkux6a/HaWKBnk0PMMdcPHCX6CA==
=kxDV
-----END PGP SIGNATURE-----

--GIZ6FKBruG2hudBTxAQqfPezs13IGRnTr--
