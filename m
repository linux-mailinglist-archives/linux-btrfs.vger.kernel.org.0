Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122C2130ACC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 00:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAEXvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 18:51:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:34785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgAEXvR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 18:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578268263;
        bh=VZEUB0nSpmOG4zHy59HL6NNFWdGecdLQhYjcVLDeWGk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PbuwO/Y7tVF1mR6KZFQ+gQ2skOSu/ARgT/jcpLa5iTjrGKhn2nuWKyhfZRpm8J34C
         ktH8iAsVijkpOwAV+WwNHaYdar9bRwnK77+1as1trHtTJDYLJJPgJ9gVn12GwFbVLT
         SLCls6MkJk1kHCE65FzQEpvKuQ538CVUu4ds8tEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO2E-1jU8zu0OYS-00opjX; Mon, 06
 Jan 2020 00:51:03 +0100
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
Date:   Mon, 6 Jan 2020 07:50:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VcQQUEWS185MyePX4HLQiMf5k9mo89mED"
X-Provags-ID: V03:K1:gw3taMd6kcU2P6v9WAtBq+Ww/13nhHpKkmCOlUdOeN+4idUd3y1
 7pRB7JtoNFDOaiBiBIdCtTjaSEXjrcnKmZxWE3MgbKaDB6NUdBVbd9CtMNn7jcYSCphbgbs
 bB87jmY/2hQy7g3iSFYd7ZQkkzIHVcIaT3OcUqIPAfE5NY1fgM6zTFsTllNAkA0XEsUHkDQ
 dpS3JoXPzUrtEit+SAHRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qTbMht9/5ws=:TgbMB7KkCxiG1ILZ0LaMe7
 YmOPxxx/P0/znP/nVX+TryXyb/6Wam17T/gIduLprrXjaJjmPNUKxfDN1MX7tJ5RUhdnGtH8l
 RmJgj326O2pbDC46B6UL6U3oP+LfQ4zFk0heaSJ4fJuw6pyfeE6vb4kTSjiCclXhksngv3Ti6
 cPR/hgZdSpPea3R83LGmrQdtkoIAc8nsDOy7Gg7kZS0ROSrjz0KmfG0XfggEXCk26Ap6ykVpU
 PIwyvO4XifeVdjyfpGRiM1dgB72GQS/QdWdNyCWqQxSI54G9+TckiXw5PMlEaCl4cJwtwvDDG
 sz8qdynN1E796OMyXKIZPq5ErB6CIFnxGMLzCV+LECdJFNIc2smEXIL7IkZ+pCVrVWmZESAHb
 43cbEgoJJv1N/uhZP6aE5sRUEIBaxLEp4CKDw6gvUvAbDEw78UrhpSnh7srOMGO1tuZlj6CHv
 gUcmNvGeDJs7+r8hnMkAIqiGsjhyTaisZhMbO6FFlaLilFJqQgbQsjuiZ36agpm9SNnOrYiAZ
 vPNi3ePjrDXgHF+KT2a4urxOMKav88x3ragdJPPTnWQWIOkKgkv+JIc0+4XWTeDNdREoEms8L
 +SHHWAikfPopM8Vl8nw+nK8aEshmEYBwSPeSK0JAD4Smpl2G93qd3khWQP2vLTOpHT5q9InrQ
 IqlzqK1l3uTQqdsma76hzL8zI3DCWF5WV6+Muqb43lbgsmAfuSb8rNpCB2izk1AZGs4HfinT2
 r6pEKMw354Pyys0Rg9B2lJarl+kUjLrEyjzDCE+1qFlCn+R85ChiHgeOEweyMJNi9wWFmV+ij
 pBWhFecHA+ZvrIiOVYIOpMD4A3ekViq+B2Y0YwouZ7wvHgSi7Zz7U8v5J26N4Cko0b1KUTB3X
 w/KhxAZO0nsPXa3Jh0eXm27iGPvaa2yIDIjtUB5EVpN3Jy/4Yk4x11WOJ1sz1EJ+i7pwFqoIi
 w78RtpImFTsM7KFFAeJZeKfuhS3/TReZy11IDcDo+1ZIxncmJRJHzJjWt3C3FEBlEKME489V4
 e4FWfeNJneQj5CZYRG7MvtLLVpI03a4kXAeToAhFNyxFA1MFihQmXBk2l+UkHwfzWNupofU7g
 2suTTmpK60+UpL0XRDkINRvYHOC+PGa7oAdoRXTrSM8fUk3XdT4ltOzt+Uh1NH59zokC7rHoi
 5DPK94Zwjesm8bM36VatBICaDKLB5Cx6ly3d8U6mkBHoF8R3oVhMChoWfsuyGcPNKH7pp0QW0
 FiV9ZZGy/IpTY5ijguYzSKHWLtBF1JNtO507rImUwZNA2iKCmUhKKeJV4mls=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VcQQUEWS185MyePX4HLQiMf5k9mo89mED
Content-Type: multipart/mixed; boundary="fQ8OO9FDMMoMRNYHeNVmhtx5k2ZT5LH9A"

--fQ8OO9FDMMoMRNYHeNVmhtx5k2ZT5LH9A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/5 =E4=B8=8B=E5=8D=8810:17, Christian Wimmer wrote:
> Hi Qu,
>=20
>=20
>> On 5. Jan 2020, at 01:25, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2020/1/5 =E4=B8=8A=E5=8D=881:07, Christian Wimmer wrote:
>>> Hi guys,=20
>>>
>>> I run again in a problem with my btrfs files system.
>>> I start wondering if this filesystem type is right for my needs.
>>> Could you please help me in recovering my 12TB partition?
>>>
>>> What happened?=20
>>> -> This time I was just rebooting normally my virtual machine. I disc=
overed during the past days that the system hangs for some seconds so I t=
hought it would be a good idea to reboot my SUSE Linux after 14 days of w=
orking. The machine powered off normally but when starting it run into me=
ssages like the pasted ones.
>>>
>>> I immediately powered off again and started my Arch Linux where I hav=
e btrfs-progs version 5.4 installed.
>>> I tried one of the commands that you gave me in the past (restore) an=
d I got following messages:
>>>
>>>
>>> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
>>> checksum verify failed on 3181912915968 found 000000A9 wanted 0000006=
4
>>> checksum verify failed on 3181912915968 found 00000071 wanted 0000006=
6
>>> checksum verify failed on 3181912915968 found 000000A9 wanted 0000006=
4
>>> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
>>
>> All these tree blocks are garbage. This doesn't look good at all.
>>
>> The weird found csum pattern make no sense at all.
>>
>> Are you using fstrim or discard mount option? If so, there could be so=
me
>> old bug causing the problem.
>=20
>=20
> Seems that I am using fstrim (I did not know this, what is it?):
>=20
> BTW, sda2 is here my root partition which is practically the same confi=
guration (just smaller) than the 12TB hard disc
>=20
> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] sd=
a2: rw=3D2051, want=3D532656128, limit=3D419430400
> 2020-01-03T11:30:47.479538-03:00 linux-ze6w kernel: [1297857.324658] BT=
RFS warning (device sda2): failed to trim 1 device(s), last error -5
> 2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: /opt=
: FITRIM ioctl failed: Input/output error

That's the cause. The older kernel had a bug where btrfs can trim
unrelated data, causing data loss.

And I'm afraid that bug trimmed some of your tree blocks, screwing up
the whole fs.


> 2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] at=
tempt to access beyond end of device
> 2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] sd=
a2: rw=3D3, want=3D421570540, limit=3D419430400
> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] at=
tempt to access beyond end of device
> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] sd=
a2: rw=3D3, want=3D429959147, limit=3D419430400
> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] at=
tempt to access beyond end of device
> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] sd=
a2: rw=3D3, want=3D438347754, limit=3D419430400
> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223680] at=
tempt to access beyond end of device
>=20
> Could this be the problem?
>=20
>=20
> Suse Kernel version is 4.12.14-lp151.28.13-default #1 SMP
I can't find any source tag matching your version. So I can't be 100%
sure about the bug, but that error message still shows the same symptom.

I recommend to check updates about your distro.

Thanks,
Qu


--fQ8OO9FDMMoMRNYHeNVmhtx5k2ZT5LH9A--

--VcQQUEWS185MyePX4HLQiMf5k9mo89mED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4SdmAXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgZKAf/XXiVU3XmKdVmlQTsLLA8YRxE
0W1py7afilK2NL/FHF621yKBrd5UZs1QO+PCzjtxX3nlkUvXNmitwkFASnR1CCVG
Dux7Bdf3b0dnHw4U7wzF0Icc9yK7HWKWw7+IzpnDaYYVigprxq9tF5HJ++i5oykw
ILezG2GhQbYoPXrWDdTwBGE7/WHwBaBAo7/QwosVQF043fK12KLJ8cv2PLXSyUbj
DVjwQCIMDY7+RVSFchPe0CJpPJ3ebvtzZtXaN2dN3aRF8O/1klOG5r5qv5PUfOuy
M8w85XsSDJLbXvtG61w0Fq8G41l3Y7Y1yF2VMLZ5k+1tUA7niSS5fFgS/aoNFw==
=jXfe
-----END PGP SIGNATURE-----

--VcQQUEWS185MyePX4HLQiMf5k9mo89mED--
