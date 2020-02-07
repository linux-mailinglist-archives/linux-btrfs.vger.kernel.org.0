Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC5156194
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 00:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGX2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 18:28:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:60913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgBGX2o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 18:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581118119;
        bh=W77ecEqfN/Np1NHd2QDAYKA/v1Kw8nwsVE2ByKbn0Mo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KPQhGNJGQGyzIBeXJXEXzbX9LPxoeo0owJTIIQyu0WGFC/ALhMkpYvqMBkyfWi2w8
         1Vc1gjOYRdsdlM3cm2zrV3xS88OFhg3Tbnibmk3ydlmtRMOPRRWfdYQcBRr+7QiKPT
         xHCsp0/2CKptS/VBNnoWvhIChgLWCy6if/SGFd7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1iuhH82HOG-005Wd2; Sat, 08
 Feb 2020 00:28:39 +0100
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
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
Message-ID: <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
Date:   Sat, 8 Feb 2020 07:28:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mpDfNl9KEUS1GWbYHG0z5QomXapmmCKUi"
X-Provags-ID: V03:K1:At1ui9TGU7rdqPDX+DJU9fvYA9sOcdE/QrnwvQqVrFLQCblNfN/
 clbI8qEz6vibujcOAcmh9CmDCb+V1yT6oQCSeaiLOJDfzuEQ9hWxJPRnpzv8kF3ciiUvEMc
 QYb+sDeDIONLYVnJG7KzpF+AneICvd7UQs4pYKqq4PuuvUFvw2UBodBs826cqp0N1b3U0qS
 r1/HSQbpca8TUBdmGw8xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XVh9z/o4Nt4=:fkvLMwYuQTLtZ40jsBX5dA
 EhbFMYe2A1AtOf9BJSNv1n3Djn7JA7AGNa+/vl4aatjiowW1TNMCEkJvz2RHGKKZ3wtbewY3x
 f8YUEI68nHFh8HJYHZISm1S6LI4wFre/jQyifZfWt9IyuLcShAmz/2/q9uf7tVo18xHdRFi1X
 eCSRFcjyeqq0vGvZwKaQPDu/d4P3xVEAKLiM3hU1cJPicMkUjCoNkBpmMfHxPsh0b8s8q57ms
 x0Cd8Sfe3jWGfu+aSnKj09MCJXd1duNelQ5N/uE/lB1fTKmJ9dNg3MTvHHEV9L0uAVGftqd/B
 AypO28y6jYng6XcYdgWgLS66Tup/P3Vm8kIuKA8mZLeMCdGyjJ3zRFo5NFkbNo7En33aTlBxd
 QbTLYJ3Nc5K47kufXrNdQ/1e5zReUWtz/5CipHiW+aqPZldc8t/c6zf/9WDBXmNJYwlFgND0n
 OtJT72dJ/p4PRsZifvLx9fEojuj7ISC6rro2hS/B3uhswxoXJGhMRwbmzi+appFBcixX6audD
 yJRUc0uZp6E2FgDByKuhWAPXMSL1xC+gt6QRjd7OZ7Jr9ZD9Ih6EwHCHlcsqtbz9/ah2k3kE6
 1SdywWO8a6AppaxZOO3NCFvBHH/4VHPdu/6YGezlCjX17kJOMwzEgGIlfsX6B568XTo0co9ov
 52tTN9nbdVosy92JZ81lTQ9qGFD7zz/9cCW9b1Cr28YWNIJdWPyLG859CiBgvIA9XRVxe38tO
 fKqwbkryCTuuaueWKbasRDVC9v5NpXKVlEkVVAov3bopX/1kzzE+ZbqRsedqeCENZRHpVEKzh
 YTlOzbH60PPaG0nSnoQSkQak8oprfgU0a50cQWYi3DeHTJozlo1RBC9oLRXgZWuZV9PzrfkGv
 /1TNiTpVOnMURwQeGx0E88RSqFlS83+EoBWqcW6NsTC02HE1LyWq1TyOapbkBscUb0JOdZFIE
 GuSlxwB6Ual62jVqVuZnDI7MDZQ+fp0uSYmPEAEs4Y8J7BDSI3k9lMkRV62U5TvuHyfkS9Iwx
 zKV3AI0cCRkuYZSWY3GCQK7yn3fIJnxNAeQxG1yqkE/wn1JMDncxtkVeH1OXKhYF1QIUaTyy3
 dmNls6pRQ12l0rpUZdTbHltsViRcViJJU8nMxPuRAC59wCwETO3vhALfWz5WBa6TyHp5hwXJA
 +I4t+4W5owpxt2f4Rz9PPWr6kE3HwrbmOAaC6kTvEA1zmakHqb0tnY8rHumaTPS6o6qDK1B2E
 CkG6bhq+Wjg+CB2Ow
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mpDfNl9KEUS1GWbYHG0z5QomXapmmCKUi
Content-Type: multipart/mixed; boundary="KlPbnrRddvEOHpBjoyFqQg2APhdttKKBV"

--KlPbnrRddvEOHpBjoyFqQg2APhdttKKBV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8B=E5=8D=8811:59, Anand Jain wrote:
>=20
>=20
> On 7/2/20 8:15 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/7 =E4=B8=8B=E5=8D=888:01, Anand Jain wrote:
>>> On some systems btrfs/179 fails as the check finds that there is
>>> difference in the qgroup counts.
>>>
>>> By the async nature of qgroup tree scan, the latest qgroup counts at =
the
>>> time of umount might not be upto date,
>>
>> Yes, so far so good.
>>
>>> if it isn't then the check will
>>> report the difference in count. The difference in qgroup counts are
>>> anyway
>>> updated in the following mount, so it is not a real issue that this t=
est
>>> case is trying to verify.
>>
>> No problem either.
>>
>>> So make sure the qgroup counts are updated
>>> before unmount happens and make the check happy.
>>
>> But the solution doesn't look correct to me.
>>
>> We should either make btrfs-check to handle such half-dropped case
>> better,
>=20
> =C2=A0Check is ok. The count as check counts matches with the count aft=
er the
> mount. So what is recorded in the qgroup is not upto date.

Nope. Qgroup records what's in commit tree. For unmounted fs, there is
no difference in commit tree and current tree.

Thus the qgroup scan in btrfs-progs is different from kernel.
Please go check how the btrfs-progs code to see how the difference comes.=


>=20
>> or find a way to wait for all subvolume drop to be finished in
>> test case.
>=20
> Yes this is one way. Just wait for few seconds will do, test passes. Do=

> you know any better way?

I didn't remember when, but it looks like `btrfs fi sync` used to wait
for snapshot drop.
But not now. If we have a way to wait for cleaner to finish, we can
solve it pretty easily.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Papering the test by rescan is not a good idea at all.
>> If one day we really hit some qgroup accounting problem, this papering=

>> way could hugely reduce the coverage.
>>
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 tests/btrfs/179 | 8 ++++++++
>>> =C2=A0 1 file changed, 8 insertions(+)
>>>
>>> diff --git a/tests/btrfs/179 b/tests/btrfs/179
>>> index 4a24ea419a7e..74e91841eaa6 100755
>>> --- a/tests/btrfs/179
>>> +++ b/tests/btrfs/179
>>> @@ -109,6 +109,14 @@ wait $snapshot_pid
>>> =C2=A0 kill $delete_pid
>>> =C2=A0 wait $delete_pid
>>> =C2=A0 +# By the async nature of qgroup tree scan, the latest qgroup
>>> counts at the time
>>> +# of umount might not be upto date, if it isn't then the check will
>>> report the
>>> +# difference in count. The difference in qgroup counts are anyway
>>> updated in the
>>> +# following mount, so it is not a real issue that this test case is
>>> trying to
>>> +# verify. So make sure the qgroup counts are updated before unmount
>>> happens.
>>> +
>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>> +
>>> =C2=A0 # success, all done
>>> =C2=A0 echo "Silence is golden"
>>> =C2=A0
>>


--KlPbnrRddvEOHpBjoyFqQg2APhdttKKBV--

--mpDfNl9KEUS1GWbYHG0z5QomXapmmCKUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl498qMACgkQwj2R86El
/qifuAf/Tpd8KWIq9E2Z4EbLD3E5lL/TMjsG2NF+CYzmAuTSHKmI6fHyLdocedIk
ZKrU4tSmhIBSwlfaBwOhaSkbFI5GqOaGQpa+pTZGM5b0qDiokEyRfxB2Ta8zbjAS
9dSlDdVEvcIxigLC1b2teuR+/yTibtE+7XWKDcukUkBz2xyep6xWvCfP3jUckoYt
ylf7tk2M2gTNONICQ29yYoE98TvDKTthBXdw6jevJqLZPm42gNMlopnisTbJHaK6
N0tp7Cyx00b2QC+7WEO9Rftgr1AhX9gEP+CqIxVDYImF0kgKfZ+eza8QDuIlU/CQ
Cy4/VYcDmGixi79GJb2wTdVqWLNWqA==
=C+C5
-----END PGP SIGNATURE-----

--mpDfNl9KEUS1GWbYHG0z5QomXapmmCKUi--
