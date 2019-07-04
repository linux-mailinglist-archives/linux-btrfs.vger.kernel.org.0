Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5F5F31F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfGDG5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 02:57:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:51923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDG5L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 02:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562223425;
        bh=A3E0JQ054RmsOmPT/ZcRom6mi/9D8LkTwskOQgzroYI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jxI+ph0yJec04cqmZLCyXu4X/zPnTZTj3PS2cYMMPjVmq03744IInT5mXg1KltIis
         1QcezjXDqXI9wcM1eWHxp/eDNt4VSKKdSoCdI/QOFvf1XGowhuHLUUwKCYLFsKMEeu
         luE1FhMndUGmc0nOFBrIhu0d7KDb1W+QTdPrNqtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MADqP-1hpE9B2F8D-00BLNf; Thu, 04
 Jul 2019 08:57:05 +0200
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
 <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
 <20190604174329.t5iissthayiywyq6@roberthasiphone.dhcp.thefacebook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <656d0208-93e7-f81a-7a7b-bc378f23b070@gmx.com>
Date:   Thu, 4 Jul 2019 14:56:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190604174329.t5iissthayiywyq6@roberthasiphone.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y553smeeMuUZBj0WXOJKKbZ2iT6j4cvj1"
X-Provags-ID: V03:K1:nQJSc+M2wOP6d3owf404FVS35uFdnIuw9Zq4lT44CrQclKl0Bmh
 k6unkkZE7xx5sVMEGnr8L4dRKqeZUeqQFp9Y2/XexujUE+7gB6LYDd1uJ8hpQ2160U/xpBq
 5m1MzaijrI3rAucU3b002OH2l582za9IQT+H0LA6x5WujyFwO3qUQsF5nJYGhBRD9yenuX3
 fZ9xmJ24n76tVwfqhpPdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QMkVsGVODKU=:5PNpwM/01ZW3mJkCdaTe1a
 TT2AAeWlPKxQs3pMI9N9AXghIt1k46bPbwcgwt/5Irsbm8U0/DIgGPbPkcDHEGlEeOCYsB54c
 z0JNFdJn0sw5PdQ9b7zlDSWScX6+r/e6YE+NVE9Y0R976vWbuIWrH8wpGadIrtMkiFX68pZK2
 2s+b+5sz/jN4QFBgwGjkejY7HzzbLg5eRf6mos/0k4CrskpiNB8obytQ0ueIZ5IlomW+LslDs
 lzjyzNofmzTaEyLKIe6u9UcDjzT4sTX3x+P8XWBU7t6vAdCBdcIW6aPpWlOwOQyibY6I+8OTX
 T9hKugNeBgfNYgcuhhfChTSuASBXZzqXuyNFh65s5zQokglTUr1zwS7qabyoPCGlVNCgxrKDi
 p9tjYn6iLehsD6ieiT/TgqVwhpDT7woKjokTBDtofunWMxjOu5vuyR4mnrFn+r5ubfHgxq73B
 yC3iS5oSL/1laj1lyck2JcToTvNhmHGGS106cv7y7wPu+8ssgWWu1YEZCYjEa8MuLxKDyTBhV
 qYCZxY6phSOi6LyZ7BRLkpFhp8f6lGzpfg+Y9nePn1kVJAvvE33zRzdiPinR3XUEfOcZdtj0R
 6l5673vxjwGs5Hn+kwCjTIg2eDCD9X8HUBPJovZlS+4at/RGnklm45hZ8oqKN32l54RQBpZ1B
 7VOUx8oUePZTcTbCFWkvzca5ECyD7ru+uRA7j5/mQ7CSk/PBGLr2pfA8DdcAFGjrlj6zYXQTq
 sMSbV539jXAfufQdIx80z/Swo0bLXVS+eiasz2FV+VeY+aiQrj0NxI1DnYwg8RuYF3ierLAFG
 GLXEtkyNcONygEvjCFGkHnTZnfwqAme9Gz66ChISttoG1dJaMhfJfS8JzPiCqs3XO9F2eB4Oj
 caEoUGpQ0vxIQQcwZ2gLPCskqxkskUM1QKpdxPHpVg7rcF3G6BFzAU8DxCNqBL+F/ay/pVhuR
 SF1xZjNuEYWsw5mPN1hxA7RxzekaDoceih21lU8j/Gyyew+L8I+5FswouZMZOTPNUWDnr5zd9
 FkaACzdlYoSn66A0uqkVAUoY7DASzgvu65/EuINu3H2iDUK04ENQuLBgFEgRy62mhwvl4/Vbg
 8WZCZPaLTJ7dbs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y553smeeMuUZBj0WXOJKKbZ2iT6j4cvj1
Content-Type: multipart/mixed; boundary="x9PRp1EUzvFqpWSzcqf9euBKJInVBiDpN";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <656d0208-93e7-f81a-7a7b-bc378f23b070@gmx.com>
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
 <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
 <20190604174329.t5iissthayiywyq6@roberthasiphone.dhcp.thefacebook.com>
In-Reply-To: <20190604174329.t5iissthayiywyq6@roberthasiphone.dhcp.thefacebook.com>

--x9PRp1EUzvFqpWSzcqf9euBKJInVBiDpN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/5 =E4=B8=8A=E5=8D=881:43, Josef Bacik wrote:
> On Tue, Jun 04, 2019 at 08:31:23AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/6/4 =E4=B8=8A=E5=8D=881:36, Josef Bacik wrote:
>>> On Mon, Jun 03, 2019 at 02:53:00PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2019/2/13 =E4=B8=8A=E5=8D=8812:03, David Sterba wrote:
>>>>> On Thu, Jan 24, 2019 at 09:31:43AM -0500, Josef Bacik wrote:
>>>>>> Previously callers to btrfs_end_transaction_throttle() would commi=
t the
>>>>>> transaction if there wasn't enough delayed refs space.  This happe=
ns in
>>>>>> relocation, and if the fs is relatively empty we'll run out of del=
ayed
>>>>>> refs space basically immediately, so we'll just be stuck in this l=
oop of
>>>>>> committing the transaction over and over again.
>>>>>>
>>>>>> This code existed because we didn't have a good feedback mechanism=
 for
>>>>>> running delayed refs, but with the delayed refs rsv we do now.  De=
lete
>>>>>> this throttling code and let the btrfs_start_transaction() in relo=
cation
>>>>>> deal with putting pressure on the delayed refs infrastructure.  Wi=
th
>>>>>> this patch we no longer take 5 minutes to balance a metadata only =
fs.
>>>>>>
>>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>>
>>>>> For the record, this has been merged to 5.0-rc5
>>>>>
>>>>
>>>> Bisecting leads me to this patch for strange balance ENOSPC.
>>>>
>>>> Can be reproduced by btrfs/156, or the following small script:
>>>> ------
>>>> #!/bin/bash
>>>> dev=3D"/dev/test/test"
>>>> mnt=3D"/mnt/btrfs"
>>>>
>>>> _fail()
>>>> {
>>>> 	echo "!!! FAILED: $@ !!!"
>>>> 	exit 1
>>>> }
>>>>
>>>> do_work()
>>>> {
>>>> 	umount $dev &> /dev/null
>>>> 	umount $mnt &> /dev/null
>>>>
>>>> 	mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
>>>>
>>>> 	mount $dev $mnt
>>>>
>>>> 	for i in $(seq -w 0 511); do
>>>> 	#	xfs_io -f -c "falloc 0 1m" $mnt/file_$i > /dev/null
>>>> 		xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
>>>> 	done
>>>> 	sync
>>>>
>>>> 	btrfs balance start --full $mnt || return 1
>>>> 	sync
>>>>
>>>>
>>>> 	btrfs balance start --full $mnt || return 1
>>>> 	umount $mnt
>>>> }
>>>>
>>>> failed=3D0
>>>> for i in $(seq -w 0 24); do
>>>> 	echo "=3D=3D=3D run $i =3D=3D=3D"
>>>> 	do_work
>>>> 	if [ $? -eq 1 ]; then
>>>> 		failed=3D$(($failed + 1))
>>>> 	fi
>>>> done
>>>> if [ $failed -ne 0 ]; then
>>>> 	echo "!!! failed $failed/25 !!!"
>>>> else
>>>> 	echo "=3D=3D=3D all passes =3D=3D=3D"
>>>> fi
>>>> ------
>>>>
>>>> For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
>>>> But at that patch (upstream commit
>>>> 302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to=
 25/25.
>>>>
>>>> Any idea for that ENOSPC problem?
>>>> As it looks really wired for the 2nd full balance to fail even we ha=
ve
>>>> enough unallocated space.
>>>>
>>>
>>> I've been running this all morning on kdave's misc-next and not had a=
 single
>>> failure.  I ran it a few times on spinning rust and a few times on my=
 nvme
>>> drive.  I wouldn't doubt that it's failing for you, but I can't repro=
duce.  It
>>> would be helpful to know where the ENOSPC was coming from so I can th=
ink of
>>> where the problem might be.  Thanks,
>>>
>>> Josef
>>>
>>
>> Since v5.2-rc2 has a lot of enospc debug output merged, here is the
>> debug info just by enospc_debug:
>>
>=20
> Ah ok, sorry I'm travelling so I can't easily test a patch right now, b=
ut change
> the btrfs_join_transaction() in btrfs_inc_block_group_ro to
> btrfs_start_transaction(root, 0);  This will trigger the delayed ref fl=
ushing if
> we need it and likely will fix the problem.

Unfortunately, it doesn't work as expected.

False ENOSPC still gets triggered.

The same problem for system chunk, min_alloc is causing problem, as
pinned/reserved/may_use are all zero.
Just the min_allocable of 1M makes the check to fail.

While for metadata, btrfs_start_transaction(root, 0) doesn't solve the
problem as reserved and may_use is still relatively high.

I'll dig further to find a different way to solve it.

Thanks,
Qu

>  There's so much random cruft built
> into the relocation enospc stuff that we're likely to keep finding prob=
lems like
> this, we just need to rework it so it's still tripping over the normal
> reservation path.  Thanks,
>=20
> Josef=20
>=20


--x9PRp1EUzvFqpWSzcqf9euBKJInVBiDpN--

--y553smeeMuUZBj0WXOJKKbZ2iT6j4cvj1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0dozsACgkQwj2R86El
/qhEDQf+O8A3Z53fcVIpMqfD1x2cZq0VkDqLEUrsLqcjWKXTSFkjmW3PD6VQMycD
3mE4emL8ZwPiGrGco0w7xoTj6DNPid5YjRgXs76+nkOM16JPQN4bdcUe+A/mSeZK
oQ4Eel7Mndph3a5dkX/1TGrcMXZ/zUCBDkHHfyUBnTH8Z7asK5pjrUcE4JAUUewk
cRKq5f/q9M82YcDnvryynG/bQDOHBHJLLuy6ZEDO+kWVU9yTKS66YGrpFd9CuhYz
NzsAS4xe3aV+pC6auoEzu7Viu7hR0/aEEw6x4WTe8yOZ1FqKJIjdcY1crUYeNYMM
YwivITRf326rGomhITow2vTumjMNJA==
=IG8n
-----END PGP SIGNATURE-----

--y553smeeMuUZBj0WXOJKKbZ2iT6j4cvj1--
