Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A277C26CFF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 02:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQA3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 20:29:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:54401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIQA3c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 20:29:32 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:29:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600302570;
        bh=mz+7DqUt7EPSV4LH/TXdVCY6AtmOXsmPgRnPaWLcpew=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PGVfvuH72aoNr2up1L/Q+dmjbgbxsy+iglkKnqVCPRXoHld2PTtqZ4V01XY85X35H
         GM6dDSVfg4zl+oN37tbnE5S0B/kSzl/pZUyqgCM1HaE389CVPY//Hqg2dLeyiNklVM
         Ui0EVxGTtZSVxtocqHsTSgqGx3euBH7QB7pjXJp8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeQr-1jwUA32fzP-00Vcwn; Thu, 17
 Sep 2020 02:24:21 +0200
Subject: Re: [PATCH v2 00/19] btrfs: add read-only support for subpage sector
 size
To:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <CAEg-Je-y6BaXYbfDOdoeF_H85E2+PqRQ-PCJrW6KPHe9Haz6MA@mail.gmail.com>
 <6802c45f-16eb-90a3-4ad5-b3bb92dc4cbd@suse.com>
 <CAEg-Je-204GbuVRyrAK+jSYN9YPpCJf8e7CneyYz+PtRxbM1EQ@mail.gmail.com>
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
Message-ID: <a50bcca5-3704-c7f3-6358-5015d797adf6@gmx.com>
Date:   Thu, 17 Sep 2020 08:24:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-204GbuVRyrAK+jSYN9YPpCJf8e7CneyYz+PtRxbM1EQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t2SPohldi8OmUrFOIuaYXXvEh286ADwGR"
X-Provags-ID: V03:K1:cK5VlPrtsb0rwugVyZQwCj8qAsvgG1Xo+yZeMkAh8F5cSiX9d6j
 Eu1zICDdmZiH5nWQNWBs04RE/OsbiwqWvTo1bfPqSaLtDxEDnOpEdHKzWwt3AbbG7YDXUZ0
 4mIAPbu9Sa2Mr4K+sjoyYnYFRG+NQlhOVEjotabYOxLqVq4wxLxIsHLYLthowKo1GDsRsE1
 Qk/RLNOvrPBJdIK0AzCxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z7l6FwzHhGo=:FGP56ndPjJgp5w3dlgZ30K
 3iCud7xpgLtyN7kREGgVxvMqEgQjtyBYwHQhBvzi3qW9KmuuZCDvHw43R/ZDn/4e57BJA4PNB
 O9rqdFXl2mJZI/FuFPj+QzbImUBrTj22b3q5oQ4Pup5YW84FH+9QHTUX89odcsx0P14mOi8VC
 wg70EcTPmmG9CtoZKsOsX2vj2QyeC2TcA17luMVCG4f1NfwfOd4GgK9d6fDaXc896IhWTXBKb
 SEdlL6skXiy0lRcYC54GAhKmlnZk53YXnqWgMkgQ4FGefJxgqTjyvSp+WCJ3oPDbRCJ3GggHU
 oQIO/CpFkTU6CrL59C7/c2JT9cfCFERCdWRzzf9TOqqu8psaCJ0GJwknHJ61C+esz5f3NiDAG
 aiydXMe9TX9Em5rfE1mnVNkallSZWxfor9cgDsj+mqAbeSjjlerJzm1lehxr82v8109a8If0s
 7iuqPR5ULm5K4QaeHUeCd2yHpHZRw6gcR3DR3HS07w36XsTE/ecF6pJZrEezAH9Y3GSkw7DIJ
 J6tsZChXJGa4dp+dfHYdpG/6PeLQelUFhylzQJid1Tdd5gsg9m++D5u3LUA5vDTW0vcvH2b1Z
 mtjjpMucEpMR1vkfPGKL7T/pp3Pn7bHHOz5xWJwZMwNk48VrfbLleaTW9/El/CqtExzhdsgi+
 Z/e0Efi7gWIx+/RXcdEhLSwkBhw7qsgUcZ24MYOhAdW1RX9597il5KvzptG+l8sWSGz7JRpIk
 2O8vUHTsjjnBWSoSxaYFc/LbC+Ggzc+psaDdqkF+5/hA1M++oe+s74XJqAmZDFBK/ju5B8qbA
 DMkDMP0bLjpo0/xN8b86nDBTwY8JQ2iNoCg5G88r8yJz2Mji9Wgj2MqyEvyhG/+D++5ht3uPF
 13bgjvs/XNc8sr8PvCLtFO+bXe8NcqcivWK0I93VXicxH1azbAxdlQJm2ahWRNMm4KvM9OCWH
 Omrz7pfXMS8rfGsxBzWs3UmKsHm9DyOI/7iHb/rJ/iJzZvIrbsV8z2dPkVZycvuwbdDuuzHZv
 k8R9whyS5PDtaYNmm89E3Bbx9ykFMN7Y0E1xodB4I93QHhXzttqSxwCSI9giwAEY7ELX9yrhc
 pIDEQnrfLlawk0obOKsAJ9tWSzFvDPVFFbZ0fQd7u9tsLNcATQxTo/4Cfv2+S1JGF8d+8UZCz
 LO9JhucmX3TMOJryRrC67twiYQYobbF7EMVypAYzHZHpnZn/ISLBht2LSfy75v3lPQbjuDnLn
 YwxU6zyQq8xAZZEbddnWaQ38b7QA6v9V6oJ1Qmg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t2SPohldi8OmUrFOIuaYXXvEh286ADwGR
Content-Type: multipart/mixed; boundary="rxJGM1gxsCcgGm9eDgrKMAIdcMRKJuovB"

--rxJGM1gxsCcgGm9eDgrKMAIdcMRKJuovB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8A=E5=8D=888:13, Neal Gompa wrote:
> On Wed, Sep 16, 2020 at 8:03 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2020/9/17 =E4=B8=8A=E5=8D=8812:18, Neal Gompa wrote:
>>> On Tue, Sep 15, 2020 at 1:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> Patches can be fetched from github:
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_=
SIZE.
>>>>
>>>> That means, for 64K page size system, they can only use 64K sector s=
ize
>>>> fs.
>>>> This brings a big compatible problem for btrfs.
>>>>
>>>> This patch is going to slightly solve the problem by, allowing 64K
>>>> system to mount 4K sectorsize fs in read-only mode.
>>>>
>>>> The main objective here, is to remove the blockage in the code base,=
 and
>>>> pave the road to full RW mount support.
>>>>
>>>
>>> Is there a reason we don't include a patch in here to just hardwire
>>> the block size to 4K going forward?
>>>
>>
>> Did you mean to make 4K sector size the hard requirement?
>>
>> That would make existing 64K sector size fs unable to be mounted then.=

>>
>=20
> I mean, make the 64K variant a legacy one and force 4K for all new
> filesystems. That then simplifies this work to making it mountable and
> usable as a legacy filesystem format.

That's the plan.

But not for now, since currently the subpage support is only read-only.

>=20
> I guess that would be an incompat flag, no?

No need for incompat flag.

For older kernel they just can't mount subpage fs.

Thanks,
Qu

>=20
>=20
>=20
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
>=20


--rxJGM1gxsCcgGm9eDgrKMAIdcMRKJuovB--

--t2SPohldi8OmUrFOIuaYXXvEh286ADwGR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9irLAACgkQwj2R86El
/qgwQAf+N973Mb/9jztN0qrQBpJ1IaPtoN44tP2Ym65EV0VM566uXfgO/wXtZSXV
kodQRvVHgo6YzfvREgbrWWshRdNEgY1fkzYqrWFJvG2k9SHOODwQA68IUY7+knfM
X78ofJc45qVya4HGNLt3kX2WLQhPzxcXrQ6lXzJLf8mijFTpz3pXDddo8l5lPWq7
HQVPDGtaz+OOacHmZITtiVkzaLqYH3XXaQh+ZMCx4FHnHKzJzUF7EQW+LJdFRuwu
PQQx/qF2OQSdvZl0NVxVwxuM2/4KBhZkh+cpNiB5gK5OsnpsPXsggMXUhZyaw0CL
D5qz6vFuMOt3EQ2QPFw0XykYoCgD2w==
=zpp7
-----END PGP SIGNATURE-----

--t2SPohldi8OmUrFOIuaYXXvEh286ADwGR--
