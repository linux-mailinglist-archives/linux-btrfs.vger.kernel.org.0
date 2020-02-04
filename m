Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7265715152E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 06:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgBDFAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 00:00:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:39403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgBDFAb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 00:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580792424;
        bh=BRfCAv9GzjVx6VhEmrhpleOKWOl8YTEcE//Zg+aZXMI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BM1ZGdARSsFP81SL8TTjKbaHU6lEbJIbWLBXnRH9t83px5yUgmm5PWx8BnalJSdsI
         jJ7/FhsW8hbnQ0yMCHOmHJTpXXEAaAxYQHogblCkBA7QqHd9k1/w9LTfv9RroiTkH3
         6siC2DyWDrR5rWTz5onmeqQpO7wOKOmFJOh20qJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1jBOpd3Ure-00Pr3w; Tue, 04
 Feb 2020 06:00:24 +0100
Subject: Re: [PATCH] btrfs: Don't submit any btree write bio after transaction
 is aborted
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200203064558.27064-1-wqu@suse.com>
 <4587d936-07c6-1319-22a1-ceb8dd7cbeff@toxicpanda.com>
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
Message-ID: <8e08048d-91ca-5dc7-fba2-63d563617e3b@gmx.com>
Date:   Tue, 4 Feb 2020 13:00:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4587d936-07c6-1319-22a1-ceb8dd7cbeff@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2FAIMU5ce1GK3fTZJOg7pE5h10V149FuY"
X-Provags-ID: V03:K1:GQkQEOr5i6thbcxyCv4Lk7fEFUE4Bm9kaNWeN97SAx6b/lS/S+s
 gCdY13To588dwCtKrT9bzy0E4ZUHZVIIJww8Ln9PcpToO/4ftVy1XRe06jdevOiRpw2Amlp
 /nD/Xc2hYMWQ2aCcV33M3pCYCCx2QMHhacIjUdd/9co3fkRcFX6dZ1kUqF84EmoPwoTg0NF
 787kuG1aULQZMwYebvNVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A5NU2t7q/8M=:Bk0gA9AUk1BwTydHx3+4xQ
 VEVzn9+cIFr1TqW3cbj/JMkWlc0hZtyrjy3br7TgMOvMvq+70qmJF5KS0X0eRCeg1RmcCAFk3
 URNxQp5C745IImeEmT6/vcTA0wnQgMYPRtuEtwOGEP6bsGGClrpO97od4WQ/3mDIEjG4quB1X
 d+a38bAQupRQ8unvT9Lu45msFGCI912P3VYeVH5GNLH/QtLmH2/yta0SzqkM4LpNHzGQWElyU
 07v1QdOGSJMARf1GA59+RJ+ybkkMOjc+XI7ljqhVWDr+ZORcFx2SB2XiPVDRvSHm4qLDAPHo/
 UkLokzy64vS0lIX3obi1hR8x8rAD5hN1XYaTQ7o7DCRjBZUuban85WpI3npxK1EkhFumCgcdT
 aPSyhakhDwG51eoEWyLCrBS+ijD/rqQLhVoJy98YewQyyObyQHoZAbGjWJtVjj0UYEJf8sGd2
 LjX/uxgfwi+m7aAZWuXToiUt1DeRi7RxYjcTcwY7HIc55hXtuOPi+0BIDrwQU16ZB4YC4wn4U
 6mzxvs/oyRoqMs7cH4zQVlD6/Ni61P1GATYEWj1rWXMBRHsHACIty7UR2vcoszsaz99ezAuLq
 EbLo8x1yxy8o8gmWy5l/vKJCC5c+301f46Cm6NucLRPcFE3U06djkXuHclgHN1QtluwvJt5xq
 VFEFSr02s81TiwseXs1oB3PE1ILpl0wG+XEEQc58739MRowBLbxAKF54LFA9EgYcD4wjZPi0a
 5vSH00tiA3luhVdSjN9aaX5zS98NyaPAQf0KoZGsnuT6nHhdB1/iFOvp+SeS1GxuVY2EGgg2h
 IRsmpomO6/GAeRKcaBAz+ki3VVNQhSNPM+z83cdzHAG4PWKMh4ZHJ7BmhjCYZZGOs8RnEBSQ7
 ewF5yjXuCNSNU1rkxIftA3+pFgctt6OxA6B7+UBZipJyKjBwD3QWk5I3e/BRyR5Yg5w1XVb1b
 jdvCBXIR0K6YqKCejyUGHB9gA8ql6tkhJMDCWLpq4jkGRWOWRL0ICDh2NUDdJlLiSL55weIed
 i2/f5A3AtCXTOHpgk01BJhlmH4VRaFntSryCHXEvXithb8OKBNim73UlCrDHWnUNQ/xUW5Xqg
 oeIz5Oi4CJUzNje7eNXtYPKZR6iWey7dURVgWZ+1sUqLHRHusjpQ/rp61I8C6dAuAl14A0NXs
 Wh6dakFZAaD/vVQNi73R78GpIv1aHjPtfdFQzGOGb/FzgBTsNpcTYmuTIcFITxbDJSev90GiR
 K7jlXI6nKH3Rvzaoh
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2FAIMU5ce1GK3fTZJOg7pE5h10V149FuY
Content-Type: multipart/mixed; boundary="cuJp8TiyMEDpMR8Up14w8n4np7LZ3Vor1"

--cuJp8TiyMEDpMR8Up14w8n4np7LZ3Vor1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/4 =E4=B8=8A=E5=8D=8812:38, Josef Bacik wrote:
> On 2/3/20 1:45 AM, Qu Wenruo wrote:
>> [BUG]
>> There is a fuzzed image which could cause KASAN report at unmount time=
=2E
>>
>> =C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0 BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x39=
0
>> =C2=A0=C2=A0 Read of size 8 at addr ffff888067cf6848 by task umount/19=
22
>>
>> =C2=A0=C2=A0 CPU: 0 PID: 1922 Comm: umount Tainted: G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 5.0.21 #1
>> =C2=A0=C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS
>> 1.10.2-1ubuntu1 04/01/2014
>> =C2=A0=C2=A0 Call Trace:
>> =C2=A0=C2=A0=C2=A0 dump_stack+0x5b/0x8b
>> =C2=A0=C2=A0=C2=A0 print_address_description+0x70/0x280
>> =C2=A0=C2=A0=C2=A0 kasan_report+0x13a/0x19b
>> =C2=A0=C2=A0=C2=A0 btrfs_queue_work+0x2c1/0x390
>> =C2=A0=C2=A0=C2=A0 btrfs_wq_submit_bio+0x1cd/0x240
>> =C2=A0=C2=A0=C2=A0 btree_submit_bio_hook+0x18c/0x2a0
>> =C2=A0=C2=A0=C2=A0 submit_one_bio+0x1be/0x320
>> =C2=A0=C2=A0=C2=A0 flush_write_bio.isra.41+0x2c/0x70
>> =C2=A0=C2=A0=C2=A0 btree_write_cache_pages+0x3bb/0x7f0
>> =C2=A0=C2=A0=C2=A0 do_writepages+0x5c/0x130
>> =C2=A0=C2=A0=C2=A0 __writeback_single_inode+0xa3/0x9a0
>> =C2=A0=C2=A0=C2=A0 writeback_single_inode+0x23d/0x390
>> =C2=A0=C2=A0=C2=A0 write_inode_now+0x1b5/0x280
>> =C2=A0=C2=A0=C2=A0 iput+0x2ef/0x600
>> =C2=A0=C2=A0=C2=A0 close_ctree+0x341/0x750
>> =C2=A0=C2=A0=C2=A0 generic_shutdown_super+0x126/0x370
>> =C2=A0=C2=A0=C2=A0 kill_anon_super+0x31/0x50
>> =C2=A0=C2=A0=C2=A0 btrfs_kill_super+0x36/0x2b0
>> =C2=A0=C2=A0=C2=A0 deactivate_locked_super+0x80/0xc0
>> =C2=A0=C2=A0=C2=A0 deactivate_super+0x13c/0x150
>> =C2=A0=C2=A0=C2=A0 cleanup_mnt+0x9a/0x130
>> =C2=A0=C2=A0=C2=A0 task_work_run+0x11a/0x1b0
>> =C2=A0=C2=A0=C2=A0 exit_to_usermode_loop+0x107/0x130
>> =C2=A0=C2=A0=C2=A0 do_syscall_64+0x1e5/0x280
>> =C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> [CAUSE]
>> The fuzzed image has a corrupted extent tree, which can pass
>> tree-checker but run_delayed_refs() will still detect such bad extent
>> tree, and abort transaction.
>>
>> The problem happens at unmount time, where btrfs will stop all workers=

>> first, then call iput() on the btree inode.
>>
>> Since btree inode still has some dirty pages, iput() will try to write=

>> back such dirty pages, but all related work queues are already freed,
>> triggering use-after-free bug.
>>
>=20
> This sounds like our abort isn't doing the right thing?=C2=A0 We should=
 be
> cleaning all dirty pages at this point so nothing gets submitted after
> the fact.=C2=A0 Thanks,

Yes, that's the best case. But I still remember reports like new dirty
metadata pages got created after abort.

Will look further into the case to determine how the new dirty pages got
created.

Thanks,
Qu

>=20
> Josef


--cuJp8TiyMEDpMR8Up14w8n4np7LZ3Vor1--

--2FAIMU5ce1GK3fTZJOg7pE5h10V149FuY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl44+mQACgkQwj2R86El
/qi2NAf+IxKaXFQ7/hbARYNuDSrfwcyPLgBLrvYhWYdK4zM+IQ5Ofnjcia2DysYa
crt+fu4u0Lyv8FgwGIqlkFCqSOeBdS2JQX/zx3GSxouqtS2ELgF3zQy3/RkPUbdC
e8gZKp6J1R1BWhagq4VYA/FY45a2jbI7ghfaqvQUW3/MXXbMpMDxmA/tEIxLLXgo
V+XvFuHXESznaigeRsvcwPOhLBt9cwqqZs8oQkGbl7qyxJOc5tfUlyhTqxyijpv+
+k2HEyUYPNfy9nua8q4NGgqB6jWloEqbIhtrg2//Trwjdiyo8ecpl1HgYYonlV28
ow/3BEyN0v6iy07wwU57wmP/e6w72w==
=lckf
-----END PGP SIGNATURE-----

--2FAIMU5ce1GK3fTZJOg7pE5h10V149FuY--
