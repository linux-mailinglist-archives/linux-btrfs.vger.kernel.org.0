Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2DAE43C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404151AbfIJHGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:06:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:56169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfIJHGW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568099179;
        bh=aGXYwWY6mDuJui2KNeLBaPFDhZutRlTozoGDB2+z2Eo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KluXCXfynG5ArDozc+cuR+0CfY0JpUbp97edT6fzUGsebBF7Chq3kA+I/uJJnCMVs
         V/yoSUY3EUOxIQrSYbaUcv8AKFRtx35cET82qTyKtjLUuceR5feQxsJmYmv7k/xItV
         tJiy3w42ZHEsRqpGDbpJxBRwS1JOvtUmW7fa8X4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LtrKX-1iF79T15mv-0117sL; Tue, 10
 Sep 2019 09:06:19 +0200
Subject: Re: btrfs reported used space doesn't correspond with space occupied
 by the files themselves
To:     Chris Murphy <lists@colorremedies.com>,
        Daniel Martinez <danielsmartinez@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAMmfObZuWx0HR48VNnN2M1jguBsfUmyXTQ-KN5J9iCySxRapHw@mail.gmail.com>
 <CAJCQCtQ_QuE2dRLwrMKHQ6nFdNGeZghFizHdug5pbQWZqKewyw@mail.gmail.com>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <c6f99ebd-c6c5-ad0c-4346-d1400cf4bccb@gmx.com>
Date:   Tue, 10 Sep 2019 15:06:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQ_QuE2dRLwrMKHQ6nFdNGeZghFizHdug5pbQWZqKewyw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2hMGaJPcq2ymobXZFxsgYKfj0JEvupzZJ"
X-Provags-ID: V03:K1:R2zmlXkmINfuBEimUuCF1SQp2fIU7eea1Nru81FPqgwVtvc5XdF
 /sVPgxMO0aHl7hGNjx0Gi69IwPd/NuBvQbQjcs6S+KFtBBoYYx4xjm66xsKJ+qmJuvlRQvG
 pDbLR/o2jzRFEirtbRxpp+7wvZz4Hig+L++5XlrDdVgVCwIsnajmPHCqcjriZ6e6adqjhye
 5EtQYxFTjfL3J+rRj8NSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R+A2Z28omLs=:g/dIzcD+Kn/X+yJuz5zEjh
 XGaY8St0noYVFhgTMJyupzaQXTT8SygDhLZv2A5+tJ9aEko3Cu8WrBsY4oAPRDYe/9dx0NuA3
 vWLpNZvD4/vXgPm1hQqezW4yoNYcMJHvJ4ZTwSP9cV+ju+VDNLK8DWwZ8k657XcVGiM/Gd4+J
 hSVGzi4YZRrRfnuVInn1JyL87F3l7TdylG8LDK/FJsX70IhDARqcXJRIj0VhiXf0ddd/7BIS3
 GYbmFvC7mVUSgjPxvN8SoP4hzzPwKvSyi/ofcyPzT67trMTGg82eQ65M3PxBH+5SYTN5mQiGk
 JfZIDSm1PdoEBQ6nw7HZXGhSMa3RRK6Jm9sjcuY7vlEWijd94mk+QqgYjkfPrsutvK76HWBB2
 6IJc+hxJVpDHYVMcuzJSaHyY+71CIT7aloF9G6+y/2Xiks1lY9AU2+8tX1l6ED4WrEVW2/uwt
 USma5LtZmzcOCkb8Su7HmRm7k7+wD5j48p/Jp00vN2spDkvmuDmBjsVUPpTUv46jh0Ak9K1RJ
 ro7NQu+dyfS6+osP3rUaMIDoNVKsi5JsZmnahl2U4C4Z96WK+4pZ53PJcHEBVgI3tfZD6Xu6i
 qZgGNA6gbo2nSU1LNoW850mQmY0BvVro0JBfOUb43kQP87twQ7qfpIHu4O/lKzdpTMRgi0pdH
 TLcngX/sWYpr9L5PfPkEhcrbK/rF6RfRPDn7hW0MKWPRIDmxD1q8PFZPher47cagUWMcTPBjq
 eIwNODUAQI0jIOXT7+tFayfmcHxndfKCda90mvn0KKi8Upc52efCjS9pspjS8kykwr1Haef8p
 6LC+Wp0+JIyUzu6mI7M2YToerfcvHYUgaTflylQ6Ct0/J73OGxqh7fScIvkpoQ85WKZ5ZAfWZ
 XekwlOQXGuTLXbsntz2h1nXskJLyX84bwnJXEIS8f7WUTsOYjjadPnPWRv9rKrkc4YuOPvpdC
 cS4Dp6zJqE4Jp5achweIZFAmzEqJbY6U+t+/7JM4bN5bLREbCo1n8bE1a9fL6c04UWtfRBSUA
 diTQCFN+5BKKIOt8LwHe+fkemaS+X7nTs7jabxWiSpmGkddhM7enKE54xtRK7XMLFf3xwXkEA
 Fb98pEK55BpCP9kZvLpmCvseYR16cH+zFPM4cjkt3P/SeC9XAqZFEZUoScljU087zgAcPpB98
 oWOT5Z6JaocwIF/TwvHfXuvAhDmAvMolgWjRcYiV+gKKQmDw/SOUeUUG3TNpNnrXLnAUJgxGE
 S57yW5+k0khT9ondL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2hMGaJPcq2ymobXZFxsgYKfj0JEvupzZJ
Content-Type: multipart/mixed; boundary="18iyZ5BU2jVCXd837mwlEgLPMcg8it5PD"

--18iyZ5BU2jVCXd837mwlEgLPMcg8it5PD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/10 =E4=B8=8B=E5=8D=8812:41, Chris Murphy wrote:
> On Mon, Sep 9, 2019 at 10:16 PM Daniel Martinez
> <danielsmartinez@gmail.com> wrote:
>>
>> Hello,
>>
>> I've recently converted my root 32GB ext4 partition to btrfs (using
>> btrfs-progs 5.2). After that was done, I made a snapshot and tried to
>> update the system. Unfortunately I didn't have enough free space to
>> fit the whole update on that small partition, so it failed. I then
>> realized my mistake and deleted not only that newly made snapshot, but=

>> also ext2_saved and some random files on the filesystem, totaling
>> about 5GB. For my surprise, the update still failed due to ENOSPC.
>>
>> At this point, I tried running a balance, but it also failed with
>> ENOSPC. I tried the balance -dusage X with X increasing from zero, but=

>> to my surprise again, it also failed.
>>
>> Data, single: total=3D28.54GiB, used=3D28.34GiB
>> System, single: total=3D32.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D1.00GiB, used=3D807.45MiB
>> GlobalReserve, single: total=3D41.44MiB, used=3D0.00B
>>
>> Looking at btrfs filesystem df, it looks like those 5GB of data I
>> deleted are still occupying space. In fact, ncdu claims all the files
>> on that drive sum up to only 19GB.

That's not uncommon.

Since convert make the ext2 image first, then reflink files to use part
of the extents of that image.

So just deleting the image subvolume won't ensure to free all space, as
part of the space is still used by the converted data.

You need to delete some files to free up some space first, make sure
there is no snapshot of your current subvolume, then do a full defrag.

The balance won't really do much help, you need to defrag to free up the
space wasted by the ext*->btrfs convert.

Thanks,
Qu

>>
>> I tried adding a second 2GB drive but that still wasn't enough to run
>> a full data balance (metadata runs fine).
>>
>> This is what filesystem usage looks like:
>>
>> Overall:
>>     Device size:                  31.59GiB
>>     Device allocated:             29.57GiB
>>     Device unallocated:            2.03GiB
>>     Device missing:                  0.00B
>>     Used:                         29.13GiB
>>     Free (estimated):              2.22GiB      (min: 2.22GiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   1.00
>>     Global reserve:               41.44MiB      (used: 0.00B)
>>
>> Data,single: Size:28.54GiB, Used:28.34GiB
>>    /dev/sda7     768.00MiB
>>    /dev/sdb1      27.79GiB
>>
>> Metadata,single: Size:1.00GiB, Used:807.45MiB
>>    /dev/sdb1       1.00GiB
>>
>> System,single: Size:32.00MiB, Used:16.00KiB
>>    /dev/sdb1      32.00MiB
>>
>> Unallocated:
>>    /dev/sda7       1.03GiB
>>    /dev/sdb1       1.00GiB
>>
>>
>> I then made a read-only snapshot of the root filesystem and used btrfs=

>> send/receive to transfer it to another btrfs filesystem, and when it
>> got there its also only occupying 19GB.
>>
>> So there seems 10GB got lost somewhere in the process and I can't find=

>> a way to get them back (other thank mkfs'ing and restoring a backup),
>> which in this case is about 30% of the available disk space.
>>
>> What may be causing this?
>=20
>=20
> Since the 4.6 convert rewrite, I'm not sure off hand if a defragment
> is still suggested after the conversion. Qu can answer it.
>=20
> There is an edge case where extents can get pinned when modified after
> a snapshot, and not released even after the snapshot is deleted. But
> what you're describing would be a really extreme version of this, and
> isn't one I've come across before. It could be an unintended artifact
> of conversion from ext4. Hard to say.
>=20
> I suggest 'btrfs-image -c9 -t4 -ss /dev/ /path/to/file' and keep it
> handy in case a developer asks for it. Metadata is only 800MiB so it
> should compress down to less than 400 MiB. Also report back what
> kernel verion is being used.
>=20
> In the meantime, I suggest deleting all snapshots to give Btrfs a
> chance to clean up unused extents. And then you could try to force a
> clean up of unused extents by recursive defragment. The system is so
> full right now that it's likely this will fail also with ENOSPC. COW
> requires a completely successful write to a new location before old
> extents can be freed. So whether delete or defragment, space is
> consumed before it can be later freed up. But you might have some luck
> at selectively defragmenting directories that you know do not have big
> files. Like, start out with /etc/ and /usr - maybe you have VM images
> in /var? If not then /var can be next. Maybe big files in /home? So do
> that last, or do in such a way to avoid the big files until last.
>=20
>=20


--18iyZ5BU2jVCXd837mwlEgLPMcg8it5PD--

--2hMGaJPcq2ymobXZFxsgYKfj0JEvupzZJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl13S2YACgkQwj2R86El
/qhs7gf/YEtt7R2psS3sRVXjPZU5pgPIX31D/UHJwUSshKU9GeWmKNFaffqY/H/8
tu/dNjXaUVY5LdEnbN2F4mb/ELvhapJ8+Clikrp0bDqOE87kvc6qCvnXu3u3WKbZ
o1LcIf366NtLxj3scbiSyDCH7STGWdpLALCXkreRI1dJ+aHh9RBVOnUluB0MHMCB
LKUGrwuI5y1EfOkC/MrbN1Xa5s8sY0R+M5KjxlEXjXeVSEeCgvKvMbyyli391imt
806e9XFAAggBvF2zxssYkhepJfsQGooyS+lQMLELt6ZKytOAtwjF90hGDaeLmioj
gcECeRCteO0B49rQLuibQcwicfwENw==
=Bcrs
-----END PGP SIGNATURE-----

--2hMGaJPcq2ymobXZFxsgYKfj0JEvupzZJ--
