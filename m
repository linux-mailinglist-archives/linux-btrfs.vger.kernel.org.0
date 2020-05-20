Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF69C1DAF96
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETKCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 06:02:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:48457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKCp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 06:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589968958;
        bh=lFIq20MaKhTddS4o/cxTSfr8N8L2CtIq6Qq5thdALHI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PU8n73WRL7ngJC7dENkCzzwMWP6Z5q8WXOnc6PgCMCVY7Zh5epauj0WWPu5ocMeDb
         jTt/+n2H9+gg7POMC8oLKbjMEOt82lm5IqluwA9aQogF/p7BrO35T7v1fQPiKjgfw6
         ryfBEGQZpYreFls4kd9tf/RNeH8wRhFS/hQ+A0Eg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1jG5cN2KQc-00nBLA; Wed, 20
 May 2020 12:02:38 +0200
Subject: Re: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20200520075746.16245-1-wqu@suse.com>
 <CAL3q7H7fY0fyiPS=LiFYDxHBAXqQF_WuZu7z=jKQv8DTkPadMA@mail.gmail.com>
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
Message-ID: <b109c38d-288b-3a4f-de7b-6a2d52c2be7a@gmx.com>
Date:   Wed, 20 May 2020 18:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7fY0fyiPS=LiFYDxHBAXqQF_WuZu7z=jKQv8DTkPadMA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VBCp8KnonVTEuBebq4h9bZmEumP4rE9Zj"
X-Provags-ID: V03:K1:xV6z3jMx0wk2lG1OFHLhxLRxUjDwv/YSygGNjeXDSaMCJY4J4CP
 cMVCaLlwuq4GlFpF8MTFPYndZpOCPCHkIU/L6gkVDCLprMFzZULl8QuR4oug9ObKvJov1Fb
 0zcM/Zpee4g+4mCoUAwg+Uwg7nOK2DQePZIvtoY+/dGV8/X0+bnr/y2s0dvpCBYtMWpZTct
 ykTBvJqKXOI+o25VMpMww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YMkYYT9gATU=:sUkPcvNFt9gHKTZiw2tpX7
 AKzGSsrZh6xoYKrBZCUjB470cEcdykNUZXnNkEcOS/23a8e6jdjVuAN7wRrQuLJC1PztOP357
 c6uOXCXJXPiFixI0sTALM6MoZF5N5PykYlm73M2NGulea3biZkRfhaL0OPl8jvKodl8J5hFMr
 hKQr2aSVHQyBgAbuPaqHjAnHyoIBcK6NBAk/de60FGgiGq+0G5x8lIOZPkgERdpPRoHQYIazg
 DXGpPbz5/kfNrt9T1zmwf05jUiCj4VP6YvD8iJvWKySt9FDImyGtI7qic+tIGJWvCm+gX3hvT
 W8MQCdDESPUu2MWFTzBQXFbG3JnlVMel+ZB7t5ZGY5FbbEraS8jmQceXb13GGdRPaVgzUB9hz
 k0Ux0OZFk3jy6T1RF12eBnT/pWds+2QwSsjwgkrzWSPEnrQUoVDCgdN746WHghzOcLDka/P0G
 Cx9bvDIDKN0KDgxH0vBWCE2QcQpjg2UJjzDpsuLLnVtPG3KY4znv5oTaYtl6n1ZmZgoiBal6v
 SaYoo/KT+hDa5i8DdFA2hp7urUvLdWZD7uJ7hHi+vV1Grpmg4MehNoLt3LA5LC6UnPT+qn/WB
 YQaZEs3qN72aevP5Q1EdBfseLxa0qVgFn6JY+3iJUP15wLvW+3+OVLq+npGfatqEhWvBZ7kzS
 RZrbwOcHr92r+L5ggbVWG9704wz+11c4X1QGYsO5FmCIVCnU9qvAr/8ibqkwcirXPYOQqcTNH
 /nU7iVBAkeM6m7y2tncTUGBCp+JRVOwO2kzAp0+jBTo/DGHLP39r+ejWRGRaNzf904etfsXAA
 SiMwdV2Y6GFY5+CNgyGuV9eSjp7qeV4KoLPakKZLpsJmK/g88+P24azSwfwwbwBL1AK7TjvIG
 h/PUO4wydQFP/UWN2iWyem+IeY3ycxkuqwfT6CiSmY7GVd4bcTQ/yLiyH5aQqbuMtcrWxa0uI
 QmwRUbFW6W5NeCFn2u+aTl5xIn2bJt5uNl2fqo97yKzsGf9eAdIkBNZzIN2pUUt32Cnq+nefI
 Obm10Ebcbk9BDbzXV6V0Etlfzr3zt9X3mtubyU1M4rhXBoZjyVQm3zFKZkHRLorFA1FEiEO9e
 UmVvh1/ydTg7+QxQWhN0l/XAzcPXlCo06yxslrb3NkmJf7CQUnm1NYuVVTF9cRihpI3iK5znc
 LnCzQrpaSFM+5C+3hUhSTvSYP5OgMfAauXQCEkbAWvKIyiiO59fRE1Fh/4eSogPn/nNOiQi5q
 TMS0Brfrpdm9mL9zY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBCp8KnonVTEuBebq4h9bZmEumP4rE9Zj
Content-Type: multipart/mixed; boundary="4AWvP8gyhHU2OWgKA3Xs8hvryLn7Fu0B3"

--4AWvP8gyhHU2OWgKA3Xs8hvryLn7Fu0B3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/20 =E4=B8=8B=E5=8D=885:29, Filipe Manana wrote:
> On Wed, May 20, 2020 at 8:59 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Test if canceling a running balance can cause later balance to dead
>> loop.
>>
>> The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit fo=
r
>>  orphan roots to prevent runaway balance".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Remove lsof debug output
>> v3:
>> - Remove ps debug output
>> ---
>>  tests/btrfs/213     | 64 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/213.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 67 insertions(+)
>>  create mode 100755 tests/btrfs/213
>>  create mode 100644 tests/btrfs/213.out
>>
>> diff --git a/tests/btrfs/213 b/tests/btrfs/213
>> new file mode 100755
>> index 00000000..f56b0279
>> --- /dev/null
>> +++ b/tests/btrfs/213
>> @@ -0,0 +1,64 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 213
>> +#
>> +# Test if canceling a running balance can lead to dead looping balanc=
e
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +_require_command "$KILLALL_PROG" killall
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +
>> +runtime=3D4
>> +
>> +# Create enough IO so that we need around $runtime seconds to relocat=
e it
>> +dd if=3D/dev/zero bs=3D1M of=3D"$SCRATCH_MNT/file" oflag=3Dsync statu=
s=3Dnone \
>> +       &> /dev/null &
>> +dd_pid=3D$!
>> +sleep $runtime
>> +"$KILLALL_PROG" -q dd &> /dev/null
>=20
> Do we really need the killall program? There's only one dd process.
>=20
> We should also kill the dd process at _cleanup(), as killing the test
> during the sleep above will result in the dd process not being killed.

The main problem here is, I can't find a good way to kill dd.
plain 'kill $dd_pid' doesn't seem to kill it properly, as my debug
lsof/ps still shows dd running and failed to unmount the fs.

'kill -KILL $dd_pid' kills it well, but causes extra output for the
terminated dd.

Only 'killall -q dd' works as expected.

Any good advice on this?

>=20
>> +wait $dd_pid
>> +
>> +# Now balance should take at least $runtime seconds, we can cancel it=
 at
>> +# $runtime/2 to ensure a success cancel.
>> +$BTRFS_UTIL_PROG balance start -d --bg "$SCRATCH_MNT"
>> +sleep $(($runtime / 2))
>> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
>> +
>> +# Now check if we can finish relocating metadata, which should finish=
 very
>> +# quickly
>> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full
>=20
> Why redirect this one to $seqres.full and not the other balance? What
> kind of useful information it provides?

Not really much, just an indicator to show that the balance finishes as
expected.
And we don't want to output it golden output, as mkfs change may create
more metadata chunks and cause difference.

For other ones, like the one to be canceled, we don't really care that mu=
ch.

Thanks,
Qu
>=20
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
>> new file mode 100644
>> index 00000000..bd8f2430
>> --- /dev/null
>> +++ b/tests/btrfs/213.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 213
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 8d65bddd..fe4d5bb3 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -215,3 +215,4 @@
>>  210 auto quick qgroup snapshot
>>  211 auto quick log prealloc
>>  212 auto balance dangerous
>> +213 auto fast balance dangerous
>=20
> fast -> quick
>=20
> Thanks.
>=20
>> --
>> 2.26.2
>>
>=20
>=20


--4AWvP8gyhHU2OWgKA3Xs8hvryLn7Fu0B3--

--VBCp8KnonVTEuBebq4h9bZmEumP4rE9Zj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7FADoACgkQwj2R86El
/qg5TAf/c8gYpjbAq70yvVYib6lPKKNes40x9cQgKEvXneWMKc9u22mJVlTXSrb8
FL70h2iqJ6QohcCVkPgVp0oDHDkLAaTtiL5HlT8HP9uKlAqnL79T+7es54btagxI
X9cDENssZsfFU5dTpUpYh5u0Rsof/Yz/JhXwpIX2qOf9R9Qng9XDEMKQAL2z3HJ+
M2zSdYyzW6Wz2h+jAH3BBp+GvrfTfRLNsjsSGCTS/XRiXVpXWru8OejanUEDnpOd
0CEwqHPfjg33FMELFdh4vN6aeAhpQHn5Uu+Dadj/qwn/izX0JEobNwjL8S5YWIlc
1hgQ5PJqeWT6gAHfVvAFcnrGv7kfAA==
=7aJc
-----END PGP SIGNATURE-----

--VBCp8KnonVTEuBebq4h9bZmEumP4rE9Zj--
