Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CEB1BEDD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 03:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD3Bq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 21:46:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:54927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgD3Bq4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 21:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588211213;
        bh=4URtmLtlf+RK81wlvJvrlPFlMtxGS+ECsIs1sHxA32M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UecffErNgGpH2sw+4qQwt8JLnHUk3LQDtlknmAIV7t5/pfhz26OU/2hIYJLwtu92R
         AsZv0XgCqN5hXGeMKoVZsD/hIrOs7Fok8NGFuemov5qUeeOarzrna1jyFBMDGs+1pw
         djHs8gVAE5wTMGG4TynZWb97Whg0o/lDwf9eIMHM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1j5xES3lM0-016M2g; Thu, 30
 Apr 2020 03:46:53 +0200
Subject: Re: many csum warning/errors on qemu guests using btrfs
To:     Chris Murphy <lists@colorremedies.com>,
        Michal Soltys <msoltyspl@yandex.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
 <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl>
 <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
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
Message-ID: <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
Date:   Thu, 30 Apr 2020 09:46:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2elsNlWMoDLS1naF3lapWn8fAybx4NJLC"
X-Provags-ID: V03:K1:v5SIylk+s1HQ2oCRJk7IvlqyNHvlKCpkBm/K1Dp1AR3dUrwTjyL
 eu7FTLNqM2mFJq5afO9KuW1pY38M0MBvBc9s+I30cM/CIGyRXfb8WR224A6oAmRt9Sic3+V
 a0pGyuwF6T7Yjinp7Ul5s6mHnYm6xFJD3b5om01f6UgN4zCR5ERZsfLQRIloNzI/6YM38n0
 7ef/BIeetnkotSi8Zdcpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+dplnMF8ZqU=:IzORSRGwf2Kmxvq0TOPal3
 8A81qKRo6OGboAj7jkd3VnC059ITCRVSVW6JhZgotdLeHvei1Yhmvl3iP0i+oyVsqVZgiHAWb
 IPW/oF9wiei3TNgOm/D/4PnrzXfWodOIqDSV6M5SyHa8lejrvlyyvVHz6EnqgsafBblzTgbNU
 LM0PjtkMtAB76p+mhzNMaD2sS+tJxONhgBM9msWN4/o5bB8tmbQQmXBRDifabX8wr2YQUOnSs
 KxL6K9QC5pF/ozwaa8EqlPX2sKe2q70e8jVMTzui+loB0HXDmg0hkBf24vh9Oh2Abn9Y99P/B
 x7S84kupq48CORhNNoc8hz/3BRgHacryZK6y5vG38jo/vkb2s56tbFti0GWOuUpaNrvMdKuo/
 25f2Q8IBs5vu8zwwJT2z9ryYJqcBqZZzFJQxDj3tBffNG63z0A90Frv42u72K4BvQvV6Z1n0W
 QMChYom99RsOsQQBbN4USUo+ww5RDFKJeesW3eLaf5dEHzZMp45VqxvY//jqRKqYvDXA/aDK7
 eMDizv+HNMlwmcOXEcKwSEkWTxVgZaXoB13GT3IVHBBD9t9kQgRrfJDuWkoNY0suuqUWqcMhg
 gpKj1dIEuyqj9ULAFuggiVZhaOyt1v1e8sJyLGQDZ2mFvKs+rgiFUwbrbyNSfTsazpembM9VG
 FIDYh0TFtjsGaLKJBs69a8DzBcXvl6fkWo+TFP+N+Vp3xLFhiMO9j+1esMgSD856hZj8zLWZ+
 CHnQzGGFZ0idkK+HgpPZkbafJvOM26SBWZ8EXAQ4Fd1Ev9RKk7Kl5IH95u3NbQGW35/f+I0dA
 pFohlbOv4BBYbYgOc1wkY27Culb+kXLnSmFMrDB88n6uxxc8UbHzAdYozJLQvH7Z4DATj15j4
 esEFGuribp9mbZHpocxk+GOoxQHZgBMG/zfqmQtRAZxU5Ikuq6kVCcA9uQzIZEKOvsH3q5esQ
 X+wQJYJmScpKl6ZXkL5EB3ixNZv6F+eM5rl/P1PEiGZrOc8AGdHOpPEwMDw7Tz/rJxqLZjWY2
 nZTClHkGRkd3KssC6bzM5fpbTh5Ow83ChDFVzCI6zgLE0l/aTZxUCm1hyCQExek+6fn4ujfHk
 PinmJ3Bgp9anH4SJaNyy4FKcbZhkIhmXxbgvcl5NNVmBw2B5yLcmmSkQMFaGlpBybrnfQmb5q
 NEIO7DNayK2fiJ/heNAvnssRrZdqiJsB2ctZCRuknVFUJxcYYlxUo2wyNCzMJy8wdVr0sykB5
 KtLhJyOOD4bJXNVn0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2elsNlWMoDLS1naF3lapWn8fAybx4NJLC
Content-Type: multipart/mixed; boundary="MsOWPtIYmuHjtIRoze0J1hffUOZSwJlaT"

--MsOWPtIYmuHjtIRoze0J1hffUOZSwJlaT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/30 =E4=B8=8A=E5=8D=883:21, Chris Murphy wrote:
> On Wed, Apr 29, 2020 at 9:45 AM Michal Soltys <msoltyspl@yandex.pl> wro=
te:
>>
>> Short update:
>>
>> 1) turned out to not be btrfs fault in any way or form, as we recreate=
d
>> the same issue with ext4 while manually checksumming the files; so if
>> anything, btrfs told us we have actual issues somewhere =3D)

Is that related to mixing buffered write with DIO write?

If so, maybe changing the qemu cache mode may help?

Thanks,
Qu

>>
>> 2) qemu/vm scenario is also not to be blamed, as we recreated the issu=
e
>> directly on the host as well
>>
>> So as far as I can see, both of the above narrows the potential culpri=
ts
>> to either faulty/buggy hardware/firmware somewhere - or - some subtle
>> lvm/md/kernel issues. Though so far pinpointing the issue is proving
>> rather frustrating.
>>
>>
>> Anyway, sorry for the noise.
>=20
> It's not noise. I think it's useful to see how Btrfs can help isolate
> such cases.
>=20


--MsOWPtIYmuHjtIRoze0J1hffUOZSwJlaT--

--2elsNlWMoDLS1naF3lapWn8fAybx4NJLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6qLgkACgkQwj2R86El
/qgeawf8C0LZ/EVioR1X4cA8PxrSKal/WrbExTuE1olrsyOVO/l6AtZ7ZgIGQMDe
tiNPv11wut/k+gIwLkMD5nkaoMNVBE9totdtwsTOEF6QcL+BQWofU3BMPtAxnp7y
NTAnmUImy5MoZCEiK7mCN59yOKRGhKRJqZDGF1COnjroudh2aeW5QIEbhuJmUw7R
RYPm+12KA22yL1+5+3mq8NrKCD/NaQ53VqZcILe6DbURFFjcwAXQp9ZxDz5InfN8
K5/smWgFTfPt1eeJZDEu1ffq4eToJ7dHlkFGt5wo8/yhgfaVUw6YYWdhDTQ4vgM8
114evnkvsbBt4PpooYuBJjOet/bDrA==
=d0rw
-----END PGP SIGNATURE-----

--2elsNlWMoDLS1naF3lapWn8fAybx4NJLC--
