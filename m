Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0197A123BD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLRAsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:48:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:35881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLRAsh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576630107;
        bh=r2h7QbXfK5S6lxmh+2kJ9cGQ4Ku9HT3KWJMMUet6EL0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aw2XvrThd25h5gn8IZsRIwI7ajq4x97802i4vcoUqCgF/HN72TGwUpKwT+ioQXAlU
         cnU30TzE20Ka2bryKr4Zm9uymfRwwMeXyZ2NZK361lHAoz15A/bYBOMaeDAN7N2SHH
         ZHWGFZU9pFNWc/wAtRvP4wDjzfJjtSByJKjHRKEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9QC-1hrkKd07F6-00s86w; Wed, 18
 Dec 2019 01:48:27 +0100
Subject: Re: [btrfs-progs PATCH 4/4] tests: Do not fail is dmsetup is missing
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-5-marcos.souza.org@gmail.com>
 <ae5f2516-78e5-022f-f516-6351b75a362c@gmx.com>
 <65eb6792b6c9e1c8f58a741866305a6ccb9fee32.camel@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a880c99c-982d-135c-4e6e-e82c19e681c1@gmx.com>
Date:   Wed, 18 Dec 2019 08:48:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <65eb6792b6c9e1c8f58a741866305a6ccb9fee32.camel@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R0kRXgCPla6MzfT0hf9jyB39T1wUjN7HY"
X-Provags-ID: V03:K1:l8PydJwGmAKvu43/+FNlKCX3t3K4NcxS08GFpA3/2KRhknCiD/K
 VZYlSh41tWOwhJz+EebiKvBIo2M9y6tFRaQ3xIuRtrWcF6rJMqyH+6qQ3NhKVLkl1p0VKXb
 SUSQeFmzCkXy5f8h2CMtYQ2ZNh+dhxbP2MB4V6OIV50khOVfhgIa5LPx4kJajleQs6il+sk
 tNHP5/UcanmFd1m5kAwPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYfhavsgK/w=:BQeP5MIrLNPMxzdxHZAIwZ
 EdGZCqPukMUi9sYawNlLcyCwEhlWc4OwSl+b+qWc48GKX+1X9NL81FQrL5ZZ4nGAu8jHkFv8r
 BpHEaVcrFcBmELEHQM6HdCLsEFOM5AdyGAhIZcevL5UtC5eFEymQPw9Jy8qFGOvNUjwysibZx
 jWolb7gCmsBKwTp+IZVMd9iOdUu/tN+wQ7OyGTr/fgVrIxBYmxp3+Iek2UcHUsue7gx6to22W
 mw6FTbMy73DDTqPi+Mtm3pvX9B/O38HtC9hT0stcWjUNyzlqKvX/31AxSudo/Vt/myOsn1RLK
 jrd8D962TEq9l7O2oxfODzwpbxnSKbcSM1N4Bp27E7O+vtBdanGFGkbM/ha/2IeJEoHwdlWJz
 6DVc0k/LGAj4GO+W4vW3ha9CL1tye+Ov1TRoaj9cGY+GA603DjXwL8o7WAaQxpsTBh51smOZI
 KYEdNGsdXXlazDNXywbIudxva81UuSmP0ABxPPMnP/3bp04Cgw62Mbjl26ELirhFp8XzHsLNJ
 ejK9LU1Gq2BwF+OE1Zmie1t8rEflPraiGKZHSpQG3tgelt8ij2LPV0B8XEnmME+55qet5O5K4
 7Mujycrfq/9cbJExXIgmkMPK9/G7DDH0AjDO954CivdXswxYDT3+kzRmQrVHjVK0VPt2AZcZ+
 CjAH/kWw3jMSEbSZjjxJhaDmJ9JDhbeJHCjO2q5K6fl2AlVW6Ds3QUewWNYJtccE0vjNb40cB
 GNYt+aW5j9z5VEWf3Gk49aS5S1eJTXEXxG9T+VfRrd1NSI05WpXo3aMz9udWQ1vBopclMuSr9
 9+sJeq7ZwtAlCNEVKRBtpcZo8ourk6of2Zpd/KvW2tIVrngHXsG/6roIdpQqJt/MIrlBEfCHo
 tNBbG9EY9cPM0+U1gKnUrRvlVkM4jaCQ2m2q6oWTxuIyG5mw7g0nAayroxkkRNbyLea0PPurr
 noSLSby3XsuVS+r4gMwfGTJXD3fdFWlvs6af3w9Z1+6h1XuN+TPAvAwKAGUZIsEN3DScyz27T
 BRrTaqULLbKVENeFJJQr35g7SqbU1hwdajyXzbl6GehIBfQOXeoneSZKGN0mcW9uSojxOY/j3
 M4gDHFNodJALw90LmGZn/phLDpuZZ/h7zdR/7pspjR4EiJgCDfeGBsIm1EzvALKuCOFc9VL7v
 2JFVQrLmmMV3xgLdip/Y7/5Y6MYKNCUX5KGZW2agowL3ysGQxLeiWpUj/dCDf0BNnOAKONIkW
 /5hR/Zmmly1hE+YQ96NABIHQi77zCBUD8S7XZEqGmznrBmeK9I3kEGfcrqrM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0kRXgCPla6MzfT0hf9jyB39T1wUjN7HY
Content-Type: multipart/mixed; boundary="dKrVkT19dNY8l7KLOyYdqcC1ciNp6UJU3"

--dKrVkT19dNY8l7KLOyYdqcC1ciNp6UJU3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=888:44, Marcos Paulo de Souza wrote:
> On Wed, 2019-12-18 at 08:30 +0800, Qu Wenruo wrote:
>>
>> On 2019/12/18 =E4=B8=8A=E5=8D=884:31, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> Move the check of dmsetup to check_dm_target_support, and adapt the
>> only
>>> two places checking if dmsetup is present in the system. Now we
>> skip the
>>> test if dmsetup isn't available, instead of marking the test as
>> failed.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>
>> Looks good overall, just a small nitpick inlined below.
>>
>>> ---
>>>  tests/common                                             | 9
>> +++++++--
>>>  tests/mkfs-tests/005-long-device-name-for-ssd/test.sh    | 1 -
>>>  .../017-small-backing-size-thin-provision-device/test.sh | 1 -
>>>  3 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/common b/tests/common
>>> index f138b17e..dc2d084e 100644
>>> --- a/tests/common
>>> +++ b/tests/common
>>> @@ -322,10 +322,15 @@ check_global_prereq()
>>>  	fi
>>>  }
>>> =20
>>> -# check if the targets passed as arguments are available, and if
>> not just skip
>>> -# the test
>>> +# check if dmsetup and targets passed as arguments are available,
>> and skip the
>>> +# test if they aren't.
>>>  check_dm_target_support()
>>>  {
>>> +	which dmsetup &> /dev/null
>>> +	if [ $? -ne 0 ]; then
>>> +		_not_run "This test requires dmsetup tool.";
>>> +	fi
>>
>> What about using existing check_global_prereq()?
>=20
> check_global_prereq call _fail when the executable is not found in
> $PATH, that's why I open coded the implementation and just called
> _not_run.

Makes sense.

Although it would be even better to change from "_fail" to "_not_run"
for check_global_prereq().
That could be a new patch.

Thanks,
Qu

>=20
>>
>> Despite that,
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>
>>> +
>>>  	for target in "$@"; do
>>>  		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
>>>  		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
>>> diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
>> b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
>>> index 329deaf2..2df88db4 100755
>>> --- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
>>> +++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
>>> @@ -4,7 +4,6 @@
>>>  source "$TEST_TOP/common"
>>> =20
>>>  check_prereq mkfs.btrfs
>>> -check_global_prereq dmsetup
>>>  check_dm_target_support linear
>>> =20
>>>  setup_root_helper
>>> diff --git a/tests/mkfs-tests/017-small-backing-size-thin-
>> provision-device/test.sh b/tests/mkfs-tests/017-small-backing-size-
>> thin-provision-device/test.sh
>>> index 91851945..83f34ecc 100755
>>> --- a/tests/mkfs-tests/017-small-backing-size-thin-provision-
>> device/test.sh
>>> +++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-
>> device/test.sh
>>> @@ -6,7 +6,6 @@ source "$TEST_TOP/common"
>>> =20
>>>  check_prereq mkfs.btrfs
>>>  check_global_prereq udevadm
>>> -check_global_prereq dmsetup
>>>  check_dm_target_support linear thin
>>> =20
>>>  setup_root_helper
>>>
>>
>=20


--dKrVkT19dNY8l7KLOyYdqcC1ciNp6UJU3--

--R0kRXgCPla6MzfT0hf9jyB39T1wUjN7HY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35d1UXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh3DAf/VJfK77A8p/bTdVJh71bkVjxB
VYvRSoMhinqjwUwiHZap65UZyTbgE7SI0wnmatNXJT42hkciLUMSqY4CPk2/XBk0
3u61YaoZ8czxKzoRonfgM4G32NA3+llWBg6DTKEB8y3yGvqCvYBG1JwM5satSudN
Loa+y+O56okKI6MUUGX2PffJbWwSWegj2RhCITkJTlntcy+hfxYQ37buyFmwvBRa
DrXMJOhXH0WHrlPDW5X6RuozwvX1zCMz0WBP74I18dyGV3szaCGVJwwKGC8s/Hhe
F5B6meH+UH5/y5komLloNZPPJ+vHB6NsMbAxfkdNRfZshBiaKo/jqbTBYkIVBw==
=BYbf
-----END PGP SIGNATURE-----

--R0kRXgCPla6MzfT0hf9jyB39T1wUjN7HY--
