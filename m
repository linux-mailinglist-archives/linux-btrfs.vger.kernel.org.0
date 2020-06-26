Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D420B0C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFZLnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 07:43:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:41803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFZLnQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593171793;
        bh=TCdwt5ISLVX8G3WlCxWhmFAxKPumdbsp7gsxNsY4fkE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fozmYXilgqMAbGNeIgnOBfYQBqYMLZOJzsnUlGquSMBcjaK/J76+PQL8QsBu+293U
         5nRj0Opl178MQDxmWjR8CpovWyTTvjdJaaFD+sCR+FgjB92cRTwoDWoR2HEU8++Tdp
         K3nBckH2GuLqDPgcpicgfYH+RcT2Tu5Y4pi9svjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4zAs-1inuiK15SG-010rQN; Fri, 26
 Jun 2020 13:43:12 +0200
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200626104628.GB27795@twin.jikos.cz>
 <8e086b89-b76e-7441-494c-ec33cf133959@gmx.com>
 <20200626114008.GD27795@twin.jikos.cz>
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
Message-ID: <8fe83372-b078-9c21-a66d-42fa14512e2a@gmx.com>
Date:   Fri, 26 Jun 2020 19:43:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626114008.GD27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HhVtyTaiLenvxRD8dCggieRbcQ6JSARDt"
X-Provags-ID: V03:K1:r65TqZL/q60uJ3w40CBz0jurHM9hZLurv4bJ/sfYYAo3abB/bBv
 z8W+IomhwRn66g8nVwrDrhW3VL9jQA04gHV+WWG7Dt8SK+nrln0xAUpRLhtLmeFYktMGPeI
 M5m6ra085AAuETDTf5dZxJliupn3ZrXfRYNndtXNl8qLWtvqXzpT1JHqkBCLGWYXO99fTyj
 Oigp1/Ug65fxcfAQAbanw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ekfkb34A3Qw=:Jz5NSGzDiwYdUmn0AjihUC
 ugoGwDBUhdDM6aUm0yyWKNurLocc577ZKZ3YoabOJYNT3cLTWQwbgjHvAUDomemE/kYq+puZc
 ASH28iDg5bo7QtxGG/O6wJ82coZ7XMZazlDMHgFin8GkeQaskh2CFmMSHSVGmhGuNjCd3l1/y
 l+1/x9v4zBUCzjiy4RsLF5ZYpywX1PI6px/06mssLv9gOuJIYivMzx9dcP76vn7NjOvu2A5rM
 Hz4PK1dsRpudk+FknSJ/rUL/dm0RrjOnnaOQ/s70YtQdfEXjoltsHrDkQ7KjJStErDI4wjraL
 LZKkwr3JcVRgUCVeh6ZYJoglLCW/PfPx8H52zphKszWQHS/72cvHt4tzZ0ODAqBBIZsxIWTln
 siUShiRyLzuSLgZd4N9N0iB6rdoB1jsqmFQeMeyDLOBWRskAgIrObmwAnuy0CCCWNglsFkn0C
 eKcnhL6smIjR6NEHVHJYkr+Nq9rab4BQOsW2sWhq+fjG/CRTq+tloDsr1WLXK756mPNGO38RW
 VVp+97OgqVnFj6DXuRqESAwIfpQukTWBclKK6dNMyoGeOwEo7VnDsHIvZSvDxiaHgQ2jkHDfH
 bkudzr6fXa1QvTCok0yp5W3tcfnsPwrdhAbjBuSWNTAMDhH9pWssJyUWuo1cRjL3026xjYoIB
 Rk0Urt7w5pasUxSdKfB3QXLLD4FZ6TVTa/6qK6Vg6s9//jmyPMZewWBbInJXtDdZXy/EFvemS
 Xpwl22k8j75oHbWkzq5nKvywo+HSFQi/cB1FDVXB1dR10DaawENWOiLduwisUD+Uvju71LBYP
 lWUnCRVD7LqQ3BQw/vtikkc7SkUTmDidGIL1EpanRSghH9GyiCaueTlgHKQhDTaegLP5vvM5P
 GBU+Yu0LI0xk5fE1k0NWlCE/o7x/kwPIMUpiLfibDSOLwDF41mIntPgHWN0S1C/IylkD2BDU7
 T53P4vnHWqXhxHyUylg0rkdANYE8pwFz5blth6xeTFVTwEwtgIy0hX4Zr+qJR+xRD8lDd0e9e
 Gfkq0JHuH6GgvLfaNjE91fJN+KC6vv5/PhyIgfR9JwbeicwpCU7QYw0YGWWrrVMAAvDhN2R1K
 SYDcoaIifNqLQFSi2jIAi80SB8ugKX+ff8cbw2R9flQsVNMCA0UBAHZpY79xDdi61mGsaiilG
 uWaqI8zJ/3eN075okhUGmmNb0pdlcAwQuxIoiuGIgpaAi8Gz8pBdkJ92samOidTSbf6pk9X8q
 WKpv16tW1RTTtU6y/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HhVtyTaiLenvxRD8dCggieRbcQ6JSARDt
Content-Type: multipart/mixed; boundary="UKUpuKO9Weh8NDzJC840w53EVjvdNkNLR"

--UKUpuKO9Weh8NDzJC840w53EVjvdNkNLR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/26 =E4=B8=8B=E5=8D=887:40, David Sterba wrote:
> On Fri, Jun 26, 2020 at 07:09:41PM +0800, Qu Wenruo wrote:
>>> [   26.508136] BTRFS: selftest: running qgroup tests
>>> [   26.509820] BTRFS: selftest: running qgroup add/remove tests
>>> [   26.511566] BUG: sleeping function called from invalid context at =
mm/slab.h:567
>>> [   26.514058] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:=
 117, name: modprobe
>>> [   26.516671] 2 locks held by modprobe/117:
>>> [   26.517980]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.=
+.}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
>>> [   26.521114]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2=
:2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
>>> [   26.524120] CPU: 1 PID: 117 Comm: modprobe Not tainted 5.8.0-rc2-d=
efault+ #1154
>>> [   26.526439] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>> [   26.529612] Call Trace:
>>> [   26.530731]  dump_stack+0x78/0xa0
>>> [   26.531983]  ___might_sleep.cold+0xa6/0xf9
>>> [   26.533290]  ? kobject_set_name_vargs+0x1e/0x90
>>> [   26.534674]  __kmalloc_track_caller+0x143/0x340
>>> [   26.536122]  kvasprintf+0x64/0xc0
>>
>> But according to the call trace, it's indeed allocating the memory.
>>
>> And my test machine has lockdep enabled, not sure why this is not work=
ing.
>=20
> CONFIG_DEBUG_ATOMIC_SLEEP
>=20
Oh... You're right, that got disabled...

Thanks,
Qu


--UKUpuKO9Weh8NDzJC840w53EVjvdNkNLR--

--HhVtyTaiLenvxRD8dCggieRbcQ6JSARDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl71300ACgkQwj2R86El
/qjAEAgAiPZDYtNZUxFB8BuvoO2z+HhvLPB4X5DJZHDLYnFZr91YAFzy+QctV11R
V4HpF2MM5sWOh/br6RJiBs10PxrugmLUj8UEL56o4BowsQmq2G5JyMAVSwysuoLH
ODe7ECHK57wmDJKimJHQ3SHlUJeKB/j1tO/mGNZGNF2rS0yFEpAfDzBSUqkytH4o
xjYtzaRaar4lV9/vpwk5tE7RB6bbtDEnQwDO2sD3VLSE2lZ5JIfqaObJZ5MrCaw/
0yr1l24DnTcuI7eZtvl8qzB6HNYIP9KMoOcokgUzc7/wXShCe/s7VtYPlyieSN2e
XQincb6pbEu1637HV8yEzDYaD8G9nA==
=BI3n
-----END PGP SIGNATURE-----

--HhVtyTaiLenvxRD8dCggieRbcQ6JSARDt--
