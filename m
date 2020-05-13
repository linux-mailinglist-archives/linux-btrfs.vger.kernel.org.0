Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6461D1200
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgEML5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 07:57:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:60631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEML5f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 07:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589371045;
        bh=jdp3QUO5OX7K+qdWHKKz8FAPiQ7ESwp2qkoh2btlFB0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PjB0mUx+0jRz2FvCXuipDZx43p+VUWLrR8wwfX7Hln7ORrR0/qv25Uc2z9MraE1MQ
         2r65dYSkT+1DRBPBXSAystjHKyp6blsfkPO24gI3S3nrvozC2IqU63WlQ3tHPGfZ5h
         dqDWuzdm7ReLN7dF5T/Gq9y85XdyQQwgK/+kulRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1jFOig2lwM-00uo0V; Wed, 13
 May 2020 13:57:25 +0200
Subject: Re: Bug 5.7-rc: root leak, eb leak
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
 <20200512230333.GH18421@twin.jikos.cz>
 <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <fa11e7ec-d785-455e-02f9-c45d607c0b52@gmx.com>
Date:   Wed, 13 May 2020 19:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IiCfQmMP9DyCyIqdvn24OFoE5zeH3Xrva"
X-Provags-ID: V03:K1:yBEuvW5T4nBdRoxJ0gZ7chVEDa/SKBYQn6nLivmvRLdrcAEkmLV
 lnYKKLo48d6s1AjYpCdyoJZoU6VQ7IBE/E5OO2nvlsIcELx1DV6lcgM+QSyTFCFjkjGMjjZ
 JvHUz4U4Q0EP26nhrjjiNht9wRar2wMqH4aj7/mUeZqy/+yVAufM3VwOOBCBKkvWO8UlQLS
 4ikvGoyLTKAjCyVd+Qu9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5/5YIoiIzr0=:IJt2U4LWhbBfXcAbifJI0c
 MubBl6wVX5zKd3G+Cjkh1Etj6p7YnfXXVgVnrC94FeUITL4lrsgQ+FbDYmAgvhcCBSoZmjSsC
 J7Pcoo+s42RfLxDnayp9ldB2L5VcIQ/v7U33ArNyG2ynUwaJGwl/rvARVykqT+bm63j9j0GvR
 1A239gWhXtabK9kcZys5at6DRwzYXyoTfLkah2ZBy25vZqw/u3VW7+G5qW9i1opDBBnnXRNEZ
 alBsc+IRDiqXu7A2SFFjUD41UdcyX/nklpFIMFtlo+lGj8kMFE+rY5jcW5EGNZEr2I75+0+Is
 mzwVJZuvKjQ3GxzRumwl/xJ59GrH1oNbVf7w627q6FyUZd7BJH2M1n5ZDG2Bo4AIv8tKZfhbZ
 aRAwv7qxlq3qqoA42EuBo9ESsQPBd4M57RiVu3tS4k4wPBEKEt7f6Bv/kW8sJrFPYUyxr2+N9
 SmuXDzvJANJg3c2D66eq0rfuVNhQy39TYZk5DUzgDckWh39KCGOxUPEUw8m3IuNk43B7g8AxC
 xBkNRDpr9SjKQBlxet3NxO6mLXhKudz9DkaFyuQ5hWCSYmwZSYlKk4wMn4fv1BRFZd1ueDPza
 94hBDINlQMN7qSEZ5XiS7ln20V22bRQHQUfjC4ryDAbFixZHpSzc94htf5WLaBl20QiDeIjBm
 TD7I0HcQuj8n3mUhFxjSffmH84p63zZQD18Bs2X79ty22X+CmTGo7DeAkZIuEbXlc+WJDYdsm
 W5wbLdR3Ujly4qj3h3pSgdG9xmHL0pjwGoYKiKwQhIok2u6nUI+TXADR264yrNYxsfhjIoTy9
 6lp5526Lu+2aMU0Zwlo1YwQyAsBkeqNpsj4ZVFhBlHJlo17Xfwm1EAUU9iZdWNMp6ySLyLxCG
 ibGj1U62PptJnXCeLlLPlAM/XC/v0muTwflzgSo0P8lYbY8hBOzO8cqQoo0j3AvWP1cxVDVu6
 vGLR0WqOK1xx6V558bv5L1Aql5nC5x7o5J1+LSVlodgfsSA4wwCO/cLm5KvF0yZrOwdOBFRUY
 35hDhD3+BpJtAV15/37xZszkY8Yobhe9bmwsCdFjdAUf36l5WhSjyBoe1/xgm7GnhVZM4PHdq
 z1BOpIDOSpJuwQIQjCkKQ0DUCEceovPOHe52vVU1+9m1Re6tTn0yjx3VFvd1H35z+tRrbcJyZ
 z8rj1OlQcjKfo7YMeuoFGxu9kmC6f5zB1tVekWUX1LYR919M31Wq1kPyOPAkstp0Oze0s3gOT
 l/N3L/eMlZDWgLv0P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IiCfQmMP9DyCyIqdvn24OFoE5zeH3Xrva
Content-Type: multipart/mixed; boundary="q6C8kmJxP2khNvYAMLxyt33ZpFA9SdAwX"

--q6C8kmJxP2khNvYAMLxyt33ZpFA9SdAwX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/13 =E4=B8=8B=E5=8D=887:54, Johannes Thumshirn wrote:
> On 13/05/2020 01:04, David Sterba wrote:
> [...]
>>
>> Johannes, do you have logs from the test?
>=20
>=20
>=20
> I recreated the logs for btrfs/028 (dmesg, kmemleak and fstests log). P=
lease find them attached.
>=20

BTW, what's the line of open_ctree+0x137c/0x277a?

Thanks,
Qu


--q6C8kmJxP2khNvYAMLxyt33ZpFA9SdAwX--

--IiCfQmMP9DyCyIqdvn24OFoE5zeH3Xrva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl674KAACgkQwj2R86El
/qhDVgf/eblzCcogzbwMcfBiRuCC+bcQO+kJdNzjQyS/2MGJtmYwrrG6iwMeJ5Ue
1wFvx06oL7PMWdxhY6edoIrcpeS5xgdF/7DeiGxDFVl8Z1umQjHB7e4svQDlLpMT
1DlujGuIIAAwkCk2KvWb95Ulrz7d9Kh6hhB/u+ywv7WAj4muazIbaNFFsCl2t4ir
UhYV8RMjH4FcHf/Z9qfE7DNaBxu68pzLYuXvadyqTWbA6pzUGbrWOoTen6e27n6I
8Xgl7LPwLSs3x2kYMm3fIE0VsTmwrgAV3HT495dXMsV25cOcltjgylG33vs6XWoh
/7CHaqhhboft3qnEo9tZFy9BmxeZVw==
=0mBj
-----END PGP SIGNATURE-----

--IiCfQmMP9DyCyIqdvn24OFoE5zeH3Xrva--
