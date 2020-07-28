Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4404D2309B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgG1MM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 08:12:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:44783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgG1MM4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 08:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595938366;
        bh=XbXOWjugcr+40QzGoD21V5IRyGsdVi+7b/agbYj2ZZk=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=M93zaKkbd+igZugRjU6TLD0VlMI0jXzzrYXfMI0eLSll8Hy1ebNwKKdrLDtmg9YKx
         OFglNZ/CjzieYW+gxE7Xx1k6mO1Waf/P5lNyRzERaJH492zhj/Kz8YYPkUrtM6XwJ3
         G401JGq5yKh9JwcAsjEm4CtpM5eX0SM6fj5iusUA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5mGH-1kq2yN2hMB-017HP1; Tue, 28
 Jul 2020 14:12:46 +0200
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200728015715.142747-1-dxu@dxuuu.xyz>
 <20200728113837.GR3703@twin.jikos.cz>
 <0ccb18f3-d4eb-9978-b4b6-157cd7c922f0@gmx.com>
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
Message-ID: <0f91c4fa-e9b4-c170-78d8-0e8fe932ccd0@gmx.com>
Date:   Tue, 28 Jul 2020 20:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ccb18f3-d4eb-9978-b4b6-157cd7c922f0@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NwMXmNbzlZUN2IOQ66CSBw14BdKcoAv4c"
X-Provags-ID: V03:K1:/MpkFR0wPhYvZtOdaxqhzYPHu2d7iO4kbuTtUfqGRQtLqkGgXNo
 fOpwFqAcVXn7REFxxNVZuvUVXBZh+oIeosTOdHJm+DMftDkd2LN8fFdpjfcXKHho+KMjyJa
 jYl+zWu8RInWE7kW5z9dlSEdScGMNd404/GzBH57av2HmZgfQU75lU+fnLaza7xBg9DZZHM
 aHzHpCfcPwrGGZYKDWDoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4no9mDzOGyY=:zDmGOOfKz5cnFZpzrR9DcY
 ZRWbIOvE3uWKTfc5qnXNNTp/LUuGX3xxAIVQp2pI/TaXUnbZ7HGaCZbLRdGsxOqtpJIltWD0G
 JUWPo+gEuQtAbcBi/9egi5X+PkDZybPcFWA65h0l0nIH55GRqa4XnroJTU6VK4bnwP6XJxXvQ
 eK2EQ/ak9CSuAjxD8tjIsVmxgAEdgD2X6hFZFzLEdLkYyZGzqgTF0DdTrbkZIy0SEvbdj+Bcu
 5hXOL0WNXJ8kVCoEYovkW1R2JNnM3g2OFjt+n/TwvNJnlmEMWGp02eoHsD+B+T6E5WHAhv2iu
 hPrJoKwBxPBLDOzftrM2sm1Hny9UmYkM9duXYAf0j6JicMztEkNZgkIQ1wCPuPzYxB3rwsV9n
 99nbAEnDaxCzjYgI4JX8aH11FcgEFek4D3gG3akYnUuofywYy0Ww300V0XeXB4V/pzF4nHDUt
 gEahTciOZEkgoQqMhKEQRBobYL3jLvIzo56H4HaW2v3p6ifz7W5UsRPpALJJA2QjQ2MRVMHkx
 4aekLFTKLCyTye7DcxuTC1b4dWdiFJGaGEiafwkaTukI7W9NmH2NaprHDSIwPuQhiikJQ5g+A
 /857REN/r3DQL/Un4Mk2TRW7I9CcPrfSXVPuXWDCvBuhxT6e+VrU4joYpblowsslw25YXAUN1
 OLFwWSSt9xNzpaqh1HZlTMP1JBixAbt2XWjIShay2Bq4pQIVClqGEGZPVZbfUohDr6HyN7ByV
 xR0+9LV8B1rz2M/U1TJkqxnzhpvnDHB+ObndGuz2iWD+7PcrSyjolf0KqmqD186N98cYprDD0
 ZF2QrXEX1FLQrIHJxZehQ/cVMZkryw6nkusCTSGojetNzDOPXvf5opHvxRIrfoVQhokJnUha4
 r2N//PSw8pPmpH4U8HlK1WmTZeeVROiQTc2KoWm6DXn4vfwpj0je98PFBPBz+Q1V+xacBVMqp
 m2WbHO5h2Hd9X1Hvz6ImyRipQM0VoM71Uj/1H2/BeIZiZ/O8DQHt6pvzfLFmqpCZbjFoXYYJA
 HQbBgF1DEYRanaiCBIaR68wfqgkpfmd4WnL6kuQlrvTKxqe+NiqsFN7f4vJA8F+m5uHcg0pqV
 UoiJ9hQjeWN3fEPoKeLWnR63FwoX7Zr3cAVGHdXiJEqV23VnE7zrMSOKlUt5m9i/83qwZstsa
 e1kecK6WoRddnBuUynSUhTNj+ODfh8/DmWULCvXBXpDe3ynom85hCeMwizOB4XCcY1lBMCGdc
 Do9DZ05UnoC8CeICcdgsGihspCY2lvb8T28aWAw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NwMXmNbzlZUN2IOQ66CSBw14BdKcoAv4c
Content-Type: multipart/mixed; boundary="x3CSmE6VnoW2r18PCUyjxtiP2mxWlimu9"

--x3CSmE6VnoW2r18PCUyjxtiP2mxWlimu9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=888:03, Qu Wenruo wrote:
>=20
>=20
> On 2020/7/28 =E4=B8=8B=E5=8D=887:38, David Sterba wrote:
>> On Mon, Jul 27, 2020 at 06:57:15PM -0700, Daniel Xu wrote:
>>> Not all contributors work on projects that use linux kernel coding
>>> style. This commit adds a basic editorconfig [0] to assist contributo=
rs
>>> with managing configuration.
>>>
>>> [0]: https://editorconfig.org/
>>>
>>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>>> ---
>>> Changes from V1:
>>> * use tabs instead of spaces
>>>
>>>  .editorconfig | 10 ++++++++++
>>>  .gitignore    |  1 +
>>>  2 files changed, 11 insertions(+)
>>>  create mode 100644 .editorconfig
>>>
>>> diff --git a/.editorconfig b/.editorconfig
>>> new file mode 100644
>>> index 00000000..7e15c503
>>> --- /dev/null
>>> +++ b/.editorconfig
>>> @@ -0,0 +1,10 @@
>>> +[*]
>>> +end_of_line =3D lf
>>> +insert_final_newline =3D true
>>> +trim_trailing_whitespace =3D true
>>
>> Does this setting apply on lines that get changed or does it affect th=
e
>> whole file? If it's just for the lines, then it's what we want.
>>
> At least from the vim plugin code, it's just for the new lines:
>=20
> https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5eb=
adcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
>=20
> It just call the replace on the current line.

My bad, %s, it replaces all existing lines...

>=20
> Thanks,
> Qu
>=20


--x3CSmE6VnoW2r18PCUyjxtiP2mxWlimu9--

--NwMXmNbzlZUN2IOQ66CSBw14BdKcoAv4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gFjgACgkQwj2R86El
/qhkjgf/eDeBQqDjHInQsYxePsnAUdiOG6aYbjPkVIaGMikNQ/Ab9t+QlEdNQpZG
f2ji3u8HoABVTgwcsH04pohgJHcL8Wjv8Zlr3NyFVN8HpFhLbSQJouK2oB2bFoDT
qpnbUZgqKNgbtxutS9SkVkE1p6hYJHukK7bn5xr1vOhyMHW1geiQW4E1D2M2xJOE
Er39upenCZJIRStYGcqmZTLg/ZoQKA+KmTRy4LkZemf3r5eGMpp8DzjovfFQA//j
ua+8XR49lsNhHJKORHQ8Il1gTgqkyzoPxcLiujBwz9Wu7kBz1kVmxs/gFQCjx+AR
zQTzDxlNut90zD8XW2nn/neA7dJB5A==
=zST/
-----END PGP SIGNATURE-----

--NwMXmNbzlZUN2IOQ66CSBw14BdKcoAv4c--
