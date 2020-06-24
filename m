Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B92072A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbgFXL4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:56:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:49829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403793AbgFXL4L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592999765;
        bh=a3VUrHimByzG7D21RDRI07vbGsbnEqjlH0U9yTKZTwA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eZXDPte0pwxH4rlWRUE52v/MmhNiHKPiVRtknUWRtMRa84Y2IAHXt8Z37E0W0AlDA
         BJ1iDUA5Boi569lTs5NkvgyHqKu/MzUovUKv+ZWzQ69GPTdiTjZ8NZgtaAkDLmdvtT
         WdLDFiGJycdnXCsCaGnJgdKu9l0jQ0Nb/VJjAokQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O6Y-1jqnZC0bxm-003uk6; Wed, 24
 Jun 2020 13:56:05 +0200
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
 <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <18267791-0fb1-52be-9538-ad32940bc451@gmx.com>
Date:   Wed, 24 Jun 2020 19:55:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZB03XIrWYdx5DjForMrIaipnafq3Gwuxf"
X-Provags-ID: V03:K1:PO3ioKlS39+yNWDr+ZcYuhhne1HVpn0d8rZj2zCD1GvgGwaEigr
 AeXzoO1/H/0nwc61ks6jGtaXN/94wX8znoy+cSjRLUHr5h8mMIsRgP92tjkRbRvW+xB8OO3
 g/ImuHSQsIRpheZnNGwKqG7BzabIKhYm/aipnksX/4d3gXElAy6UxIlkbdrirwzOOipjVO2
 90Y4PxDCqVfn2Mzh/o+KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ybKq1K9mv4=:abzIraPVWg85iwuJOqxMfS
 +L+hdQ2ZHi20V5ZcEca+2Y33LSLBQOa8DxfrJndTqJsaSLM0LQVvUsSqLp5gZFv+3njXstG2W
 NVzhMk2OVS/ej/eaGOt5LYxG16NlzAz1yBVos/g3PrjasS/JmwV2cFCbkeRc50HBT6V+Kx1Y/
 8/Q+kb2Kezaqq+VNJFy9GZzKF1/si8sIrXHWWTRfnkyEwxj8HbeIWLvMEj4KnNjXP/ybusmdh
 UoT35R4aDrLYWKrBA9aohpg55i+R1eA/Nd+YqtIOCuo8/u7ViP3xXtnLtefs/f4BSeDmc19Y5
 6SBmFbFfuMnvj6rKqzCMRAIXCqdBJJApX36VaA02ypS8o83wLt23ZxG6zbCZHPCQqEU7FXSYq
 LNm5sLWTi6QmxDZIpOb80+rYGBH/zZ+M+WiuPFuWeumY5qoudZctlJ5IEuX5bY5cU5I5gup9p
 7rKJF5CTazLF6gpqx90n9flfYjU6RBHUDmHdfl6P6ftVBgwiMKA/b/htGrp3eyWPd3POxYJCo
 0vBpAk3eTiiSIP5XFRdjD1tIROBfBFbIjB8GbptytpfUkIVNI8+v2PuVVMF/MQS/ATJ/lnSHH
 OieZpFqtwMMn46itRm71ZGLaZNl1LrB8RTc1fzqioe3KEIMm8u7vl6gZPt8UhORZjeIXvMzcD
 Bi7QSIcI5k3NS/0GIRswSKNkuzOw7LNJULNBe3HfGSnTuXiPvKnJHEy0VMJhxOJfKU0aT+SlL
 1B/Mxad0niJUhO4Ldk9p+HLZrJenE+I9JMKzLUHqmoyALilSXMnGG0cefrfG2mpzs5mZxhEHf
 kgdlz+I2dTI2iO/Y9YHjP1R9QFVWs2FGMQQi4YxrqP7SrIKQ6lf2Mjz3OO/1zbzBa/ViB6Ly3
 xGZVZl07278YWlT37aMt4gVnGD8VO2LZZ/VfiF+eA38art781qOImxKJDWJP1GEQnMppstN4J
 LYloK+eUHU/Jfaja1cChgC1+R0xq58Y8firEPOSrQPeVX+swbRuXbu+IE1oUHZhNjSvuqnE+a
 OfUZ2j6iyKkR/H1r1LEs0bUYkJ5hFpCWPMl4ecVBhz9sSkBL2B6Tpz4XDC+LQzvsJO4nb3klM
 BJV+oCa8mIMa2aRTjqbUVqShv6MuWGSln47aTPZ/liF7RVbEqP/BzpSe2hHE/VMzZHqBvCvp3
 twV9mlUAdmaBQ326JN6573SRaLwV/XklhHIH4nTxuF5EkaDXwff2rJCRoE0U+U+u70Lt3TpKy
 LlCcjFHainnbrcp6B
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZB03XIrWYdx5DjForMrIaipnafq3Gwuxf
Content-Type: multipart/mixed; boundary="9Hp4t86L4SQzretnrJshGbey8rYIYvJsk"

--9Hp4t86L4SQzretnrJshGbey8rYIYvJsk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8B=E5=8D=887:41, Johannes Thumshirn wrote:
> On 24/06/2020 13:03, Qu Wenruo wrote:
>>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
>>> index e6b6cb0f8bc6..161d9100c2a6 100644
>>> --- a/include/uapi/linux/btrfs.h
>>> +++ b/include/uapi/linux/btrfs.h
>>> @@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {
>>>  	__u32 nodesize;				/* out */
>>>  	__u32 sectorsize;			/* out */
>>>  	__u32 clone_alignment;			/* out */
>>> +	__u32 flags;				/* out */
>> The flags looks a little too generic.
>> What about extra_members or things like that?
>>
>> This flag really indicates what extra info the ioctl args can provide,=

>> so a better name would be easier to understand.
>=20
> Maybe version and for each new member it gets incremented?
>=20

That looks even better!

Thanks,
Qu


--9Hp4t86L4SQzretnrJshGbey8rYIYvJsk--

--ZB03XIrWYdx5DjForMrIaipnafq3Gwuxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7zP08ACgkQwj2R86El
/qgukwf+OxJhrRf1tYuMh446eQc2sqzrpGdT/mLEp4GIjYrGhGivGq4JYj/zs3UD
81e69zi+a8WYD1/Nd0uN6Yc7Qmwu2ECz8y3vkgbWJaUx18Y7iCxhnlg+l9SB4K6P
Mos0F59A9mFd7RilwztQadBJm1xNEkhcJo4wcqxOZcrOLKXXNtT9ijfE4CADmrND
+bLFQuNxKwdbURYfK3kH7ttDm9FdAR+/2qKH0cNmf/b2t+gPH/ylV45BAJVS5Bwh
sxHV1kCwDey/Emp+IT34BPYzjUfMT4BwuLaAvxyDN/R702ds7FViHPYCtgPuA1IS
z+S4lf18m2o667t/Q1OiIng2+EmnNg==
=GOak
-----END PGP SIGNATURE-----

--ZB03XIrWYdx5DjForMrIaipnafq3Gwuxf--
