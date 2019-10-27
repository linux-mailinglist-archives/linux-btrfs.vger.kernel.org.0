Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922D8E6A2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfJ0XQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 19:16:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:52127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJ0XQ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 19:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572218216;
        bh=Ng05fN6T7lZYA96+SJRwPrx5s8DTGWZgsCJD7MkDRMI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=INw3z4k8UNqOMWoozn5vxMcsyduyQrZdP/LXxONlMZXH02Wc5h6D35B7TRdDrEemK
         bAFFJ/NpEuYUy0wixeWuoIrIrIapO8m3ctGM47HC0qkMV2eof9aml2mitY8mmy6nlK
         iAduAZtOASRX/6UPaZebiaT7sU5n8ZJu34AIV/BE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1iRfJB3HLq-00WU2h; Mon, 28
 Oct 2019 00:16:56 +0100
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
 <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
 <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
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
Message-ID: <220ed79f-7028-497d-caf4-1841d5f6d970@gmx.com>
Date:   Mon, 28 Oct 2019 07:16:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xifN2FQa1E6j49rN6WCiueOsXqCRoKB6P"
X-Provags-ID: V03:K1:xEDMNEpJUM7nPH3ElhL72DR2/w4zTPRvYrwrTXTiXw1iLh5X3LO
 dcFZJWJV1KAG3jb3D6osV6e8u+BCHhJxNuwc/H6HzAiOb7V7eMGUXuohg/UkHSmSYeGa7ah
 YjuT4ydNctq/Aca9mBHk4sdLFRGLyv8IAsOYQl/Q35ljzI+zpoE3gBKCB5RCpqvE8yREgfH
 3QcBJlW3THETDkS4+oIig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P/7Ab3k4sAU=:0Ty6li+g8GKW+DYMn7zPzw
 ljbWT4ADiP4RE5wgEGLG7DLw/38AXF7iqlHe8m9TSw1WPFgv1jf6HfwCmYqZYJTonP8tUYR16
 oJJcgyRZKtb16uuFYIs8ZLTLZMEt0HVf85dSeaJXP/f/Y3Fb64oUj2UnaSNbXwdP/qKhtU4aN
 2bgsQRvkEDFCVKnkDzAotHrEzL70wtUFTambyBu9XfHvQV3fmX7Mhk7KGSRl0C2ivRALcXhWF
 520jU+je2xFgg1et3o+n46emnlZ/11kXb6vs7lSxyooWVjINmUEEZxYQbknvgxM0DMxGGKfYf
 xNgOCWkhGbkXV+AJHBS/k4I1xy2E+PX83ZfEVutZMDVEY5YQUmhe+qc3A66R2wusrfzjWZ61e
 EuA+vrS/RI4jbZVu+HWwXPeTSwnMRf7b4Q/Qos1CsuBHSUZABHDCIn2VDB4OknsiujzGbfzGW
 tRVOmm30u4I0zJUWMALxVF4oU6v3KzC/8otbqwGjfEPkFRbLpDD53aU4OR9JYtTIwS/C+butc
 t1upAwsNWodFnHqRZUVWMWnAzJBSXhU6iKKI5wJuKQrMeCU2WKOiDm6Qpp7mUyjAd3nuzMA9d
 8T4XhISTXOul4mqFEISTfkRG0v03J3MDCF16w0xI8ntHl3N4ilrgBiGfoGgDcDS0sdP6Z4i3c
 J4ePxwrhlcUWne9aMs3cru+KTlC0u2zaMKjGT3/Y3r67iwHqoZAzZagR3mLeRX//C9u+IuUjU
 utnoDaW+CI+EVZoMsAOSJQIJ0JUDDDDzKMBP8QX8yvrUBiTESUrI1fVqVs7s5B+pKFofjl6Ng
 GtJPSaH+GeRCoQCRHeS9qDd70jNIQRSZm87oo3qzlz90OwYHxYjAfRnWqWyw2WZoWbb3AxWUl
 y+fh0z36XXtTbboAYwLJqZMHP1cxxs/ezn9DsGe+8Xfst+Js2n1Z/5s0Ge672t0A03OkwcU37
 MpROJ66Nw5XXd1PQPFMC1BdioqnAL0OyoWvsKsMJwPcbYRvrXQZbvXRLLuzNQCgsm6HMvyBKH
 ev7Op29sQ8ZVZ/QkNd+hZ5s3pLeTHnql9fSU1EJdwbTS8wqExrtlQukjZ3CvrVhzk3g+sXKXy
 9sihphf3aSYru2pDUSRLZAPDfqtp3dSsxHK6IfUuBzIiAhw2fptuHAclIjd7VmG885Nb8dz/h
 0G8OAUviBohS6LZZb+HRjZypoRL1dpD2SNKqLo98qGlY86YSXonoHAABY+WEZrdKLrdMR3X+Z
 QmJwbmvITtPUujLM/8GQ4UxXdPx07KsHL/Egt30mvHw3YiLuw9rzeyivncJA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xifN2FQa1E6j49rN6WCiueOsXqCRoKB6P
Content-Type: multipart/mixed; boundary="H26SvfsVDgQO6eHiJfRAbmwhW7YTsoW9E"

--H26SvfsVDgQO6eHiJfRAbmwhW7YTsoW9E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8B=E5=8D=8811:19, Atemu wrote:
>> It's really hard to determine, you could try the following command to
>> determine:
>> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>>
>> Then which key is the most shown one and its size.
>>
>> If a key's objectid (the first value) shows up multiple times, it's a
>> kinda heavily shared extent.
>>
>> Then search that objectid in the full extent tree dump, to find out ho=
w
>> it's shared.
>=20
> I analyzed it a bit differently but this should be the information we w=
anted:
>=20
> https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42
>=20
> Yeah...

Holy s***...

Almost every line means 30~1000 refs, and there are over 2000 lines.
No wonder it eats up all memory.

>=20
> Is there any way to "unshare" these worst cases without having to
> btrfs defragment everything?

Btrfs defrag should do that, but at the cost of hugely increased space
usage.

BTW, have you verified the content of that extent?
Is that all zero? If so, just find a tool to punch all these files and
you should be OK to go.

Or I can't see any reason why a data extent can be shared so many times.

Thanks,
Qu

>=20
> I also uploaded the (compressed) extent tree dump if you want to take
> a look yourself (205MB, expires in 7 days):
>=20
> https://send.firefox.com/download/a729c57a94fcd89e/#w51BjzRmGnCg2qKNs39=
UNw
>=20
> -Atemu
>=20


--H26SvfsVDgQO6eHiJfRAbmwhW7YTsoW9E--

--xifN2FQa1E6j49rN6WCiueOsXqCRoKB6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl22JWQACgkQwj2R86El
/qj85Qf/SG2uMSqUZHDu+r86lrTiRy6NA01qaXNJOoZ6/XFwgWf3rp+4egW3vJKZ
kdjTPKgO5kOdLo1JNbBHFHLrDtOy1/2XUzzJb7cXeWqO0UlD3PZW4J+9AEoS9YCj
M8bSHvF6oyIxtEo71LBOjgFqOoAlyE4sm1GsR9j80D3aM53Cxu4eoTDeNph/DJZW
bGDQhsioCPiXs4Gw/zn46gF1bBV2iaVVdkleI07Idl8/TU+WBzP8jwss7lCYX2PO
b4Cv25xmpN+esefqqERotipN4N+2mCyLVhjlDQWAT70G7zQEZKwrYaaWqpq8oEDI
sxgycEbfLtdgQaNH6tvLJTSO999ffA==
=JxdD
-----END PGP SIGNATURE-----

--xifN2FQa1E6j49rN6WCiueOsXqCRoKB6P--
