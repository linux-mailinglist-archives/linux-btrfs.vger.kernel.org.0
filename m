Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583FA1B3971
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDVHwo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 03:52:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:49991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgDVHwm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587541952;
        bh=09fw0tQo5OnyHQWIBQqNIl8Egw3RUXoDDBFdUtne7LI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QAW6y+UPNjVlp4BB0ZUpcKeB6YXvNUnn6xZrgUgAwAL7Wl9outGOvb29p9sHvejKP
         fsfNXlQiEOyLbfgJLSD/ub/KyUSwIjggDq9azThuKzxuFvFR2cVEqt32qI9xEYF5R8
         JxyMWEv4PprDRpU+ZZ28BX8pm/2etK7F98gBPVUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1jQt4A3bph-000JVV; Wed, 22
 Apr 2020 09:52:32 +0200
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support using
 the more widely used extent buffer base code
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
References: <20200422065009.69392-1-wqu@suse.com>
 <20200422094607.1797ce2e@nic.cz>
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
Message-ID: <fa3177ef-c264-2fc0-4793-d35209d05d2b@gmx.com>
Date:   Wed, 22 Apr 2020 15:52:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422094607.1797ce2e@nic.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1VIq5kFMnmbGpKyoi2UenbvDucHUTOiBF"
X-Provags-ID: V03:K1:H8yHkruEhcjGaBgw7Yl2dmL+a+N0VHfi3m7A1hDXecYhsB+pR5Y
 chN94KMiKkppFnbNWsrYwgV2z8JAfGwjKy4x3ygVySmlJay74v00UqM8IMw9bATU7MGUB7Y
 Vf4x//DdqGnSNsIOePtH7ykmRWJVzrksapv1FePKL/LRxgfAXfIGC4g6Uwx9btIpQb/kCLq
 SgRjVA3EJ6+sFC913j8RA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CjE0ZG5Imzw=:S9o0FLS45KYF+iqO4hm2c/
 1I5oPPsvlMZdK09GEZ3QqTDpRI9fk8LPtNYXXm5lHoscbEEDYF96tNVfjt4l+XBE8hrggdjuT
 ZBD7DVmSvFe4HRMrS8o8s5Say5cyyEqteUtDRiBLewDR0vsOge26Qa5zXqqKdHCRnHCwhFMH6
 fr4CBS/I8h6JB2xbRfiec/f4FxNhwm2hFafHub14HEc47X9RVQ3nDpuviY8HU7SFQrF4lCv1g
 UaW+3lHP95MyX6U+uQWepU3JLxK6XM8GBww//X0p85XhVRVxn+8fXDl5O6hj+PeyUklUpKk8C
 v083daJwo/sy645styZ8BVnVD2jVy/BtmGD0aq0JjULn9y2UxLF5qaKTr+JexnMkEpvR3b9z1
 nqDoF/CJ2vcrzLPxHj438X4ebz9UBhIj44ruyBPeChvXgTDP+4/uffxE76FCTS06l1MonuRL5
 abGsEx1qEVMursnzfHipYQBGYqgwOsQlEu4e75OfTfbf04/5KsWdfrtTFMHM/aSvy38e+6mjK
 5DsKPiDI597wrY7OsIP1Ihne1DKGNxEOu7AuuEtINobuum72P1jxln3LfIuLtfYCvt892pS84
 zmwTFXGWjuo7h8fU8ym6SKSit1yYtw5IUEz6EcqJfjDQ6NKevixvLqZnWt5nAorazQC179Mja
 CcTpWYGXRpBrTirzdwE1NnWOdaIhrC4jpyuK2QL+7djVYRMuZr5H90C6bDSf+IUBGROF2Koss
 NcfBiG4RHBnlMOLzLvltxmJ3nILkuFZnaFICqUH4UGSYi7XD+UxXJbJ8y72iKSiITSZUnIfyM
 G8P4DuqCniyaaNVyn9bAdFPv/CLCem7T4cBwMVQlHK9g7YSYNfRo9fuc2xOBlW/p1pvtCPkwI
 SZcUSIqmRLFwwrLxwmXF+Xpqbf1nWPjuj2KCvjuHZoKlkH0VW+qH0JghE7HSIDyysDJOUzwWo
 jQmyv6ZSDrL9O8S0ZL4N+zT4OF/Plq/sG+Yyhi60ctLMaVJIsSQ7Qe6/fyWu7+1vFtG7fz0c4
 7/4hotkyGYve2j6dth+HGzQYSx+nYXreMbDBSSQtMAIfRUs76Q4r5L4P61dBeSVF31Xc8IyB4
 UsyAPlRsZS8n82uhUOjHzfKsSqpH+LgNFBvDlZW0HIr8HO+l9FnsAytGjJbPbCtQT5RIYaW/q
 DRZ07qKf2MMlfk9EG25nbmKYfWQ7FJzXCtHY6GQSpnhvBN4vQ/adBzMFW64nNIsdC3s+T9/XZ
 e8NjHqMpWlHSWxSMq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1VIq5kFMnmbGpKyoi2UenbvDucHUTOiBF
Content-Type: multipart/mixed; boundary="KoYagtIPqWd2VIV9Yd41qybbUOILSHC0u"

--KoYagtIPqWd2VIV9Yd41qybbUOILSHC0u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/22 =E4=B8=8B=E5=8D=883:46, Marek Behun wrote:
> On Wed, 22 Apr 2020 14:49:43 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>=20
> Hi Qu,
>=20
>> The current btrfs code in U-boot is using a creative way to read on-di=
sk
>> data.
>> It's pretty simple, involving the least amount of code, but pretty
>> different from btrfs-progs nor kernel, making it pretty hard to sync
>> code between different projects.
>=20
> do you think maybe btrfs-progs / kernel would be interested if I
> tried to convert their code to this "simpler to use" implementation of
> conversion functions?

I don't think so, the problem is kernel and btrfs-progs all need to
modify extent buffer, which make the read time conversion become a
burden in write path.

>=20
>> Thus only the following 5 patches need extra review attention:
>> - Patch 0017
>> - Patch 0018
>> - Patch 0022
>> - Patch 0023
>> - Patch 0024
>=20
> Anyway, this patch series does not apply cleanly on u-boot/master. I
> tried with the first 3 patches and then gave up :(
> Sorry about this but I will review and test if you send a series that
> applies cleanly.

That's strange, the branch is originally based on an older master, as
you can find in the github.

I guess there are some more btrfs related code change since then, I'll
rebase them to latest master, and update the github repo then.

Thanks,
Qu

>=20
> Marek
>=20


--KoYagtIPqWd2VIV9Yd41qybbUOILSHC0u--

--1VIq5kFMnmbGpKyoi2UenbvDucHUTOiBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6f97oACgkQwj2R86El
/qhJDgf+IX9yCRSL8SJYO7dLuk5GgnDdntjM3R7LqMbMfVPfp5ZDb7P0hsj9ixGm
/tCNfsvHUYK0xBCedM0m6HnpPmwjIt6tAt/vaxKvX9Hi6NdyCmk7NfkuphDuGiCJ
odzd+ozR8vCL2HS2i2N8KXDw3S5OJAm/pCqG6S6gLW3+E+DmIyf3ScRe8FfYZwYO
Q/erOFTLvcXILLLtls1Pr95J27Zi0dM+Ysa0iKDIVVhQhfHI37HgFaL0h3UM2/EZ
ZdDw7tyKbN8KLsLcSCKWieR0++cWgnjKg2VUTFtkyTwK5VYEEfkvmk2aIfpfh8nj
BhKKkZbg0KS+We7+4Pu7i7AGd3xnog==
=26+b
-----END PGP SIGNATURE-----

--1VIq5kFMnmbGpKyoi2UenbvDucHUTOiBF--
