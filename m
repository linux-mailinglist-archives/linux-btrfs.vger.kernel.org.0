Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0776D2161BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 00:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGFW6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 18:58:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:42249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgGFW6s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 18:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594076323;
        bh=T+BbS5ZDdZVDhkiRr8snbcGFmVwSjpDMVCefhO4yEXc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VTvFNzzNI3SMe2wLEsJG9S8GpZUI0noFpR2Lf8gxyg67Oohf5lP6LwPfsqTY6LRm1
         WW+3a83TRBvxgXGi8wby9c2VhCq6NeUn8KX7uXlcidxZZxvBAxbvn3SzTzZPqDzHkp
         rL9BomtQmvzqPz/R3X8N+YvMd7g1ii+AZHIXkJ2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V0B-1kuXS138SV-013xX0; Tue, 07
 Jul 2020 00:58:43 +0200
Subject: Re: BTRFS-errors on a 20TB filesystem
To:     =?UTF-8?Q?Paul-Erik_T=c3=b6rr=c3=b6nen?= <poltsi@poltsi.fi>,
        linux-btrfs@vger.kernel.org
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
 <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
 <e1beb547-3989-0fdd-b2e4-5491728f7dec@gmx.com>
 <7bfbcd06-f4f8-5946-c5e4-d7c7879cf122@poltsi.fi>
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
Message-ID: <446cbb5e-bb18-bb93-ee98-d480730e4508@gmx.com>
Date:   Tue, 7 Jul 2020 06:58:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7bfbcd06-f4f8-5946-c5e4-d7c7879cf122@poltsi.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wQQZ1UFpyShFGGStQ0W3zEqkKrNNvidRa"
X-Provags-ID: V03:K1:jznuC+ZgYnPHuUPE/Tt2YBjyJILXMJUqAR+hTBk+VK21YQ1mKXb
 Pga5HObhZfNUQjJOAAfrDXKF7q1XEm1/Mn/nP6f134bizGxvgtS26OjEGQGxfI50yU3088a
 o9Qv/ExQI3PjPtKbXXZtQ4gdm209X3kBXjbVcsD0KTxn/d/GxIh86eZqMBOXcQoWqmYs5Rn
 KcJWtoKGbfAiKrPLhZzgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HnfQVTEaiok=:ERSZCMdRN1AOG875pazL7/
 Hxo/4xPP3IjBLEUeU2ubOK2Y0Gro15lwwrUmBr657iij2ccW22u2fE1dZbP6/AYhT+XkVI+eZ
 UxnwqTxd7JEZkEaYUcCkwbE/RBu+w6GBmKHdwEcN1R97HIoJIiESpxM3ZJd3uSoDEGiLDiLmp
 20hvdUtZ3LUtYxp3mpA4lmz1tz3wiR1GZJD/RX6SjpY7chTWHZfrU2iV9qfMKR78mdvZ4jLPr
 YlSnbceCs4swQ1UYUrGUhF9j9q55p4iC6L2knhjTlAw18m3ALRiQ9SqlABUTL/vNwDqNf3459
 PLSeZBY3fBATAsKzqV9oZZ8vPIEKRUyAy3nVjc13GnWhVYj77ofcYRmW38NbnY5Vnfv6c+9Y9
 ADxVY5Tuzt7W3IApphxgeSn5OJ6KNMbovqw/l+C20vzXoFul6PcpdDGsrc9ZmWePZxSbYoGEl
 kSnGNCFvOsz1sXiw1xdqAJhkSESi6hx9q2yLinx92CvFREE5UczxaE7+5phArA/+zK867AIV5
 lCV87RQJUlwrTz6j+dp7PDr3u8FsTWhGuDV+3cYdVt31ankLypniAv41yNWPMg5BsSmunRSfx
 g0yILtE+KK0QVZ7wMaQCaWfbmS2fB2OXmMbdOGXC8GTk3saJ5nesB6VErclEwwWpWtIVG2Wwd
 NUTB+dNXrt0d7Sx4PcYUMuIVOYPIEXmvBj0TLqvUDqYEMu43FHGlS38eRIo04z7CBgJBTJ8od
 phJBgtHeywKCDfiMKQ1D3sKo2DpF5sa2itXnCVvHZn6zOzyStcqXIccNbDd4t+FvZw1b+4FKT
 3O4D/Wj84weXzI5Yavp0TC/vJLjsKC5hEDVsA3ge0Ss3rO0GeuSlTMjXgrXG/3Cz4WUqVhFDD
 OhY6r2cDOGmA9HcimKtNWGr15M17DC0WwVq6p9fFypOUnDBMgIy1pOok9GkOGFSXZqUS8EdnU
 HjomBbKIYWiQjNcOxpte9yOPjO9XuwA6GIL2630d210Xpbjj7qL39Bp6iT0iq5gCB/MI9yThY
 32xXOQ0PzB4oYx4Tyf/OLWJnmg8FwQ7rM2uT+b7ok1YtSNQmtI4E3jcJCDiVrIOYLC/XJzWXG
 AH5hOplKrkPdwIUhI+0Tc/yUMBiMtQ3zb9Uh+XcBEIVIgzYqD5FdTQiC4BJvfnLehC8AXW3Vz
 1UymM1ThX9lUxcDn9fYFeysbWESgP49U0gYZia1yaq28M/dcL2pTNOAiXYHRfKDl8PR8MsAbT
 fBt1RP/8gcNtg3gM40WAEe3JZ0CwqA51Jkkd5QA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wQQZ1UFpyShFGGStQ0W3zEqkKrNNvidRa
Content-Type: multipart/mixed; boundary="qifxSQW6MbwxvbVgiPEq9HGzkhqBpDiQB"

--qifxSQW6MbwxvbVgiPEq9HGzkhqBpDiQB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=8811:00, Paul-Erik T=C3=B6rr=C3=B6nen wrote:
> On 7/6/20 2:51 PM, Qu Wenruo wrote:
>> Or feel free the censor the filenames if you want to send it to the ma=
il
>> list.
>=20
> Hopefully attachments work :-)

Got the attachments.

Although still needs some extra dmesg context for the following bytenr:

- 2627928588288
  I see no obvious problem around slot 10

- 3154217795584
- 3154257952768
  Mentioned slot doesn't exist at all, not sure what happened there

- 3154259034112
  The offending slot seems fine

- 3154291228672
  I guess the problem is hash mismatch, but can't confirm.

Thanks,
Qu

>=20
> Poltsi


--qifxSQW6MbwxvbVgiPEq9HGzkhqBpDiQB--

--wQQZ1UFpyShFGGStQ0W3zEqkKrNNvidRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DrKAACgkQwj2R86El
/qj2lQgAnT8mW8X7LHow5lFV3dmsZcezna4X9hQ/yxjSHVevD4bi9hpmT0aYbueH
bbI8yK+1Wa/hzJ92UfVVcS5nNdFEbFMgQXIj8TmrxuerzGe3xSfhCUMzTFxzjPZf
M0U89cBnAIC/7R7CsV3Y8gz6US8n70eLlYphH4YeCyCO8g2oIuFf5xu6/02TatGt
oW8rJ0iMuzA0xOBwWl/vX4/hFGIebZ/+xDkTFti0rMfjIeGiPSh0ZXU641Z7KYbc
Axsa3UDMg9VLSqS0Ohl03ZK7NzU8rtWY7s7CugcmGqIM3vXGoI5Kj30JS63dFsA8
YJcdt56QJ8HuTOXwyAFPIKXgZCOkjQ==
=dGip
-----END PGP SIGNATURE-----

--wQQZ1UFpyShFGGStQ0W3zEqkKrNNvidRa--
