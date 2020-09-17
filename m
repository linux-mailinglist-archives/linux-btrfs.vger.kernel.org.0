Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804CA26D2E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 07:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQFM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 01:12:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:54415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIQFMz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 01:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600319572;
        bh=cC1mzoifImlMIekdKtKwxDDHJFxwnAzzPY4uciGzIl4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bvhEtlGYJVXjZ4QcVoB/eAFtGqPB29NEaI8XA/57PExOBJ+ectqc0iqirB2lyU0Mn
         rZspIoMwuMQX63fwQJvVeaq9jI3k8m63hrQskEzrUyss6x0ExraU64hNcn+IOdwEyQ
         qnhhcMLH2Cc7IluKL7d4mMILZx9Gd/jbSR+lMSiM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQiS-1kAV212I3q-00AWgM; Thu, 17
 Sep 2020 07:12:52 +0200
Subject: Re: Need solution: BTRFS read-only
To:     Thommandra Gowtham <trgowtham123@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
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
Message-ID: <9b5706c1-fe21-6905-9c42-ffdc985202d9@gmx.com>
Date:   Thu, 17 Sep 2020 13:12:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Noi5lA3yXZL6BUdDLgPxWC4wUzmuixMZh"
X-Provags-ID: V03:K1:H7kv3qSiTjT3HuaEk8ElD+VfbvMvFp79gCuwaRF51FEEeVruLRG
 RIUigpfR8oh9U22AlpqehaEF+f2eXCXlDAZc2IoOXER/d2wy+gc1acRzCDHhFmpQd+GaxVI
 fnoDBtDH4rUlN1XAVNoNjse4SSrKVCbK+Zhy41w57i+aqNk8MhvK5qCc2xZJq2NJaDK0FJm
 2EkrlZjbECjXSvsSSOa8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcJ8kUGRdUA=:+OwNQGUXTOP/1CYbpn4jei
 jezPOieMGDFw7a83xFSSaVK8kkOx5eP4dvcGADBdijNZwCI2AkcoqeyS57PlRmRYUXp4oQT1r
 Z8fs0g6Ii7sJA/AQICwJooRnTmJtcFPIpQYdHUIvtcQF7LvArBCbaVOKzbCqctgVn2zg+ZGI8
 wRZ5BklD1g+MIfoduX1wAzNes28tTTcP3LKCULfDebXGfyIPUfBon7syMqFvhEZtXxrCghRDd
 LuqZPD/zzANLwuqCpHNc/Lmcp4mgKUc6z5Z+EmhT8Fj53TzcAXY2jHw3y3KNLJCZtHIW6+VQL
 NoM3ybllp3norxtFMf2uqVIwETLZcETHTUBNH5d5R9cO7ndGcp38904SIsTPZHvZ9L/26wjW0
 jFfUp+x1ebVxtQfZ0dcZo5/3n1Tkrg784XxupZ1hw40JzChGnYI8VNV0ESEH84x8S/WAJ6kb8
 sAkvsNOwqIMWmDNLrisvlCMuwHjgAiBFVGkBlZ07TX9HNWEL3iIEQN0Ynd4JhtoA2PbkuwkJA
 s1xRPNMhSfJZ3spZw5Xwa08Kb6ATlggEjvZwlkFG31lGR9o/e+t7IdZ/cqfGHy84Vad9XgwZF
 R+gowq2GqcRE3ncjW7KsSXLjsp6wlkz3+yVB068/rwjemqolmJXFddcFyDsbeDX+7LSp/9TYb
 C0ShbMZ7gQdlor2EGaEdJ7YwWte3wS4ZLxBYAGNyWNYGWwRpBi0X++18oLr98yuu5F+Ti9y8F
 bLs/9ERDvMt3Jx85K8GMh7IAfOiwEWtLzVaCol6ciJv3kFESp0j+Vguj0DXpVXHpn5/AF83iM
 DutpJfKybjop4SYyb3mw4brbX61ShxPiU1NmQLIrouokOCnxrX1P4KxegmaV6zBvZSU7BY4Tw
 ZxqS+wgUaZDW9+I8dSVAMUpAVG7NltiZkg8xtDnyEtAusUWykQevCI7tCLXBv7Jwe3pYxngDc
 3lXDVyilnEkV9mStGGKjiL7GjwMNUW8Eo5wnsLdJtAAZ/lzuALC+LYNe893P0aB0TV0vUyJFY
 nwTOHIX3VIP77EwZ1ciGOSBDTbeizyThSHOXXadJMURsGKuvLpEfbubYXOcj0T2SBVE8+Fxt0
 OyjnRe7lPYRwPeQKsqhwvGAuqMu+PR6ury3G9WvrtHxCRMHU1y7M/WggEfsxiRRYg9bmEFYa1
 rDvh/I1GbhZmE5T705X4wQ5ByjKElXWyxIsm9AbyCpz4RBHs0gtg91HIjlI2R9OYYR4ko9zG2
 HEWJzlX+C0su3ZWuSiwm6e3SOZAXTdVTaI1wk+g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Noi5lA3yXZL6BUdDLgPxWC4wUzmuixMZh
Content-Type: multipart/mixed; boundary="IEFEJQqnqMfefKvkZ2yyQM6NHRXzFthGR"

--IEFEJQqnqMfefKvkZ2yyQM6NHRXzFthGR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8B=E5=8D=8812:52, Thommandra Gowtham wrote:
> Hi,
>=20
> We are using BTRFS as a root filesystem and after a power outage, the
> file-system is mounted read-only.  The system is stuck in that
> state(even after multiple reboots) with below errors on console

Please provide full dmesg.

The provided dmesg doesn't provide much help to show the root cause.

Thanks,
Qu
>=20
> [   35.099841] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> rd 0, flush 0, corrupt 1, gen 0
> [   35.109822] BTRFS error (device sda4): unable to fixup (regular)
> error at logical 166334464 on dev /dev/sda4
> [   37.500975] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> rd 0, flush 0, corrupt 2, gen 0
> [   37.510993] BTRFS error (device sda4): unable to fixup (regular)
> error at logical 440860672 on dev /dev/sda4
> [   37.522128] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
> rd 0, flush 0, corrupt 3, gen 0
>=20
> Is there a way to make BTRFS delay moving the filesystem to read-only
> after a reboot so that we can scrub the FS? Or is there a code-change
> we can use to modify the btrfs module to affect this change?
>=20
> Regards,
> Gowtham
>=20
>=20
> mount options used:
> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
>=20
> #   btrfs --version
> btrfs-progs v4.4
>=20
> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
> x86_64 x86_64 x86_64 GNU/Linux
>=20


--IEFEJQqnqMfefKvkZ2yyQM6NHRXzFthGR--

--Noi5lA3yXZL6BUdDLgPxWC4wUzmuixMZh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9i8EwACgkQwj2R86El
/qjBAQf/VU0GYE0lRGRuKk3HiMdkou0AE0vu0gseRibx453buUZ/xkB8uM9915rj
iJtQRYf6V168Z5QBzNH+dK0JRpRRTqrs6YUiJa5wHUvR25D8LRVl/3KVODFIIaPH
aAlKfG8cQ5ypRhmfZkpS0nxxrWTM+pmz7HwTELeEx2Fz8TJx8ukU2dIKNiIl9YF6
VC+d1TlXcJF11mkmPGzUbR1BP9nJRn5BSJi/oht4v4dazhdSPkSUh1rswk03SZmx
kxBSWQetAcBgqrWAW8mGDvQU3KTjy4Rs2Yjl0snSLh4bsVyYsHW/3rhvmwdz2wkk
e3ZU6ylKl6TO4pck5/P6P2NH8asfzA==
=XoY7
-----END PGP SIGNATURE-----

--Noi5lA3yXZL6BUdDLgPxWC4wUzmuixMZh--
