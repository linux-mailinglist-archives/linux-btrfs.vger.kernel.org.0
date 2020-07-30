Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F631233C3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgG3Xla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 19:41:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:34713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgG3Xl3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 19:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596152482;
        bh=u1gH0jDAhOUjg2Oo1o3JdkQOKWig/0IkuYePvDpMlSw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Rs3qwQ3S+L4lnkSoPbcxhxD4g1vESqb5RBuc7U4sKmW2PAJm6vB0auWrqyCbgQAtA
         D+VvvhTdoT3Ysy285AjI0C9Cy43kgICVumpINpq+7cNyYp7w/LSeS6IYP0PO+UjX4Q
         db4OisY2BR+vslPMoNXjVEwiZArxancxp8074GLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1jrhWE2XNT-009kLD; Fri, 31
 Jul 2020 01:41:22 +0200
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
 <20200728144346.GW3703@twin.jikos.cz>
 <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
 <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
 <20200729161344.GB3703@twin.jikos.cz>
 <0c64dfd6-7846-babe-b7d2-12decddce4cc@gmx.com>
 <154a35f8-9a21-371c-1afa-ccf2e90ef316@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <07491f84-b26c-dc11-90ec-458fd572ae88@gmx.com>
Date:   Fri, 31 Jul 2020 07:41:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <154a35f8-9a21-371c-1afa-ccf2e90ef316@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SPdjpJv4bRSuZpp5IEjKjznTONKesnFBo"
X-Provags-ID: V03:K1:vuo2omofg+azlatJ4g6QK1w+CCX5ismYENQDl2eILPA7H61HlZE
 GIRzOxauQr0XRPSfm/5YdZ4vvINsnZgjd1d15g3EaSQWbBKhqSQfUC79tJSqBma2GCN0oaR
 5NvaZiJ15JgbD5t2G2wSC+zcZS6JlWsIz9/Lqzjn2OePNEl5tzLWMsRtaVj1QXRxIDKWzJ/
 TWusLW3D7ghHQN5oMokyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xr6DKUlzp4c=:M/U+nyA1PJ8jdDgtQO1NB4
 0zpCW5FnW8K3Do1HQQIFoW9f+/jePEaxFTSBZhphG3SQ7SB3cmTqPmQfRuFF1m7ZaoZkeQtTj
 WdUnmr3pPE8T9XyZY+BRtyjja5QkBGB6SmwdPM2+K62CGaYwPoRkAKRY0TKxh3ynxE5qlPMvo
 scOLk+fWgufbWm/hILs24NcxMCmZBEEuYaJcg/tQ+R7Lscobu5SleCwQTYCVek7VUVT7+TYIR
 Go4y49gkLIt6yZofsuI1U/M8HWPBMyadnq2cOVmZfeExk+cwjoBgFBUMyiL3DLXZRaW1q2M79
 KhClAaOZ+xd3aFkGPafVcEjyzSWhWP6y9epBjulpLtfCZx8YvGWxyP9GajLXo2vDWawLPp4Co
 D9FZmqOPdEwkuqJZXiUFm/YKDBhu7cIV1w1Rx+z4HvqhzGc8Qz/U74u9Pc+rQEkcT7fCBoZ51
 7cHco2ieIjZUvES2Zdt2M7JOpcB7pHvf6Y4hZ0XB1tIRmDOCzAcTdkUET9tGiuXWGYdXgM20e
 8NRAN6zm1CFQC5Ep6jZaaX8epGf64OGQXslzfa3fvVaCSydC4s/qTSIrM1FGufM39jE4WaUJ5
 5KkKH6OX6JTwMor5WTBhIW4HXSyb5pH8i164UyN13gtcBSOOBuGwWdkEb7b9GwMRQrdUD7q08
 u5HmdoOavGue5yPh8MFwtvAQlin8HW8hAMCtEst16YYi5X+XyPvxGm/CA+r44DrVXU+D11Y3n
 tpNxBwUye0R+nqN1T6TndDBae6xoo589kwZPN5Ad5vlhwlaBjfaHWlnBdCtdBd2iEPNP5aJ85
 /iXWAylf2AkvytsNlDGlz0QZtOmi8O0lnwbSRlJR9YxmOkkywP/Az1zdKaLR4lzutEHcqGo03
 B52Tb2Tm/zgxennCHv61iw4OaGi6nxcAmLybsqEBLlFIyxmxI/pCAMtdYqfOzPOn9G/61l15w
 tuo5QMaPGO1tmXG20kcrABXJYJXrBpDaGj07FZ+PxPXbn+uk3+UcahYL1pm5A5Xqj/RYEL8A8
 lU6DbW2lArzy/gbMCmZscu7RaFkHBa+iiqMM8p20tG7nU7HNRiAFS6ZNwIoKILUwA8NlTpWBO
 YFBQPEk56QEsn0udKe5BH0WuhIBxksxsRbYX+csOp+KePTkVYS7icjy8yGSbScBpa0YELt9eY
 uNDVJ7iaaURLwCGfLFPzI9ClGT4v1d8C+I3euSCoB/OAapGcHkqGxOgOc3gBLyNOFJJUyCI47
 LnWquZ7pclqtIIERRijv0NNpvXvcYZ/lnS+k5iQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SPdjpJv4bRSuZpp5IEjKjznTONKesnFBo
Content-Type: multipart/mixed; boundary="PYMzNUE1uXLX5gEvECqMjwdgB9iCxDh6f"

--PYMzNUE1uXLX5gEvECqMjwdgB9iCxDh6f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/30 =E4=B8=8B=E5=8D=8810:02, Josef Bacik wrote:
> On 7/30/20 7:42 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/30 =E4=B8=8A=E5=8D=8812:13, David Sterba wrote:
>>> On Wed, Jul 29, 2020 at 11:43:40AM -0400, Josef Bacik wrote:
>>>> On 7/29/20 11:42 AM, Sebastian D=C3=B6ring wrote:
>>>>> For reasons unrelated to btrfs I've been trying linux-next-20200728=

>>>>> today.
>>>>>
>>>>> This patch causes Kernel Oops and call trace (with
>>>>> try_merge_free_space on top of stack) on my system. Because of
>>>>> immediate system lock-up I can't provide a dmesg log and there's
>>>>> nothing in /var/log (probably because it immediately goes read-only=
),
>>>>> but removing this patch and rebuilding the kernel fixed my issues. =
I'm
>>>>> happy to help if you need more info in order to reproduce.
>>>>>
>>>>
>>>> Lol I literally just hit this and sent the fixup to Dave when you
>>>> posted this.
>>>> My bad, somehow it didn't hit either of us until just now.=C2=A0 Tha=
nks,
>>>
>>> Updated misc-next pushed, for-next will follow.
>>>
>> I guess it's still not working...
>>
>> The latest commit 2f0cb6b46a28 ("btrfs: only search for left_info if
>> there is no right_info in try_merge_free_space"), shows it's now the
>> updated one.
>>
>> But still fails at selftest:
>> https://paste.opensuse.org/41470779
>>
>> Have to revert that commit to do my test...
>>
>=20
> I'm looking at misc-next and the commit is
>=20
> c5f239232fbe749042e05cae508e1c514ed5bd3c
>=20
> Do you have a
>=20
> struct btrfs_free_space *left_info =3D NULL;
>=20
> in your tree?=C2=A0 Thanks,
>=20
> Josef

Now it's there and no longer crash.

Thanks,
Qu


--PYMzNUE1uXLX5gEvECqMjwdgB9iCxDh6f--

--SPdjpJv4bRSuZpp5IEjKjznTONKesnFBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8jWp0ACgkQwj2R86El
/qg8QAf8CbgzVs1JR0ef65iZ+1sBS06PpyzljkWHY0g7xdSIwOaOSAT06MliEkvz
3wD5CASkyg9XyUkglQZlwLuK4EKdHlkvWilcYeoazHrOk3yQaVEZJtWBPsX9qT9o
RcZH63V11l++fmKE3R3ZUrMCMhAql1WO2Ckx3cqr4o/y9oVSWMUbpuTOa0T3VaTz
xRhX103JbUgYGT60cYvVR3P6ZmHxVzvs6EIc4Sue9aQuypuZZ9+S8OC7tRP5au2W
JONvSBOExkWTU1BNbQsU95AvzRtSTUf0VNofWlo4SsVR5hlxeGXpU1vwRJmtBQCZ
RPbUjQGZkQGgC8uc/D3BtblrPHiWJw==
=IAHB
-----END PGP SIGNATURE-----

--SPdjpJv4bRSuZpp5IEjKjznTONKesnFBo--
