Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A562218D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 02:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgGPA1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 20:27:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:54631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPA1b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 20:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594859244;
        bh=gilU3343Xm11W++hYSgjUMzPGe7JLv216V554GS2iiY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eS8KAR0F19E9uVMeVL3ZaH4/s9aUIgOlI3KnL26UtcPhevi1WCvCmvS7OM7OE1F6N
         +/jPOSGrWGYnIvUE5wec2yA834lvMDfLLe8BJInr4TUvEhM2R08ZjbwebO2Y8cePeB
         JjiK4OmR+K4DDiOFeFHUoJ1qJtYP60FcM3FLAg28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSt8W-1kIVBl3aKU-00UHaM; Thu, 16
 Jul 2020 02:27:24 +0200
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200715134931.GA2140@chrisdown.name>
 <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
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
Message-ID: <e6cc556e-c830-fa28-486f-e23d520fe98e@gmx.com>
Date:   Thu, 16 Jul 2020 08:27:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3QCc7O97boHuIXZL3P30pcz0OkVKCAPg1"
X-Provags-ID: V03:K1:LTlAfY8iBqF4BWUsL2IR+Q6/nmGmpb/ohb2GVrok5zhrsTsCWKM
 HDfiolZHd/0Dm55GFiwS0SNB1vmgXhAJ0QNgsZ4HUHRrHE//Xx0lpE3D/KcKKAtq6NVuJwT
 fnSqedKeqqFWZvxuKV4kX0EO1fwcCCJgUMalHtVE4MGGWlSNhHr6lnciKfbviyuAX8fNULi
 WEHe/aPAI5q8ZqveoAzKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V/Z+rgFTkU0=:EHw0q2XlvZIZd4hKg6FRzE
 aK/cTTlhsW4wAkb7rMF1S0v91DjTK8x5/D7HCSi6DRlf8JM6YZ5RS5wgQvPI6iZ0j6ieSGkPe
 tK4oDPOUIV/+ir02RejWwEVsy3eEpwuh1bF4udaLzPJygymoIEm63KlW/j95P3x2g8BtBTqVk
 w1WVQib+Q75Pa+qCrZ9Cajp9zk/7J1fcX4OVRazkX9W6JdW7S0W7Hqw9tUruB4omFy4e60BLF
 BHQ52P2SEuSZoxgJFLRsfcFJ/JxXl7+RwUhPHXxGiYq9kpCRkgS5gRXao9GMDrUJzZ9iAMtrr
 3vllUF86dCuz6wecyvoq8YDmclKG7aVApcNWNf2D7dpIIvXeuSOKAuBwYfTamQHn+AdoFl91N
 ryaldOrtkStX/kmw+7r66XtORFwbvTXcSR0ai1J2uIPivo2d+9qHaOzVPtRbQh02SIxJ3268p
 fA5c2LZsghVhfboyjOM2UCaQj/rXAVyFFXNHCJyfOQMbUBM2crbCzyGC7+hgk6/olt9rBvGk8
 2S4qK/Nz1XGi+kClqLYhlkd9JcWpn+1Vxek5ESjNUe//f0qG0/t6rDpnAcPoCiYSDh1tx2AuJ
 CuDVV83d9AS9U4eM18yeZP6z4tfXZf57mwdHIQYCw92ITv42v3b3MuXDyHUf5epEasO8PQyx1
 vr7sIbfjCABafzC1JA9dtLNjUtJbeP0ZyfNbMOWnSSpUV2sevT++yeGyAsyFObZaLbJ1KVsCJ
 tkKOyhu5WRBDtLg49HoeFr9xF9lnS0dMfcQ1ca/3v6BZV3YIemiXYD8GgUirTO1GZ5kLIaf6V
 awTHET/7Qk4XUGeBwivmCWC0GQKFfOOzVcsKzsoE9pqYPZfMI1DOZal7ByiqZC4yZXGrzQfEm
 dmyjMVEOdrMKcjh0cMIOhEAuLDvcr761dry3wIwp2he/9Yvr81xjRmkedizGhStWs+ErmgF8Y
 iHacFlFvvp1q3Fv0bBJOne90ZEx5cDHDz3ssv5qLdx5ua8R1KVGePoXng2PhjJwRpX26OW3vY
 mZhyfmWgvYI3tjJ6hqP6twroKlI+7UcNaUP2l50q/d/0NvwwHQzTCtp2RLfeYzWYoDC5gOC3D
 anakg14KEoraola8n3ablsKds2KOyqBpnxOE3vW91T5F+fpIkneOIunZFi9+QTxnnbMMTnK39
 bHmUjSonq7liwNqSLa9xXBYua5vUSFcTGCG+uGpUXmpU1faMcSYpef56C89ibfoYvLDHlo9gt
 C2VMijdYVgbYeBo4oLXS7YdEiIc0zYu9LyzQTLg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QCc7O97boHuIXZL3P30pcz0OkVKCAPg1
Content-Type: multipart/mixed; boundary="WJYE8B9IUH7O4vlfLqueMBoAhObGauqpO"

--WJYE8B9IUH7O4vlfLqueMBoAhObGauqpO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/16 =E4=B8=8A=E5=8D=888:15, Qu Wenruo wrote:
>=20
>=20
> On 2020/7/15 =E4=B8=8B=E5=8D=889:49, Chris Down wrote:
>> Hi Wenruo,
>>
>> While testing my pending patches on top of linux-next, I encountered a=

>> bug that seems related to this patch during btrfs unmount. Specificall=
y,
>> a null pointer dereference in kobject_del inside btrfs_sysfs_del_qgrou=
ps
>> from close_ctree.
>>
>> The fix may be as simple as checking if the kobject is initialised,
>> although perhaps it should always be initialised in this case, so I'll=

>> leave you to work out what the real issue is :-)
>=20
> Thank you very much for the report.
>=20
> May I ask if the qgroup is enabled? Or qgroup is not enabled at all?

BTW, after checking the code, it looks a little strange to me.

Firstly, both kobject_del and kobject_put() has extra check on NULL
pointers, thus if fs_info->qgroups_kobj is NULL, it should do nothing
and exit.

Secondly, the fs_info->qgroup_kobj is initialized to zero, by kvzalloc()
in btrfs_mount_root().

Thus unless we modified it manually, it should always be NULL.

And for the locations modifying qgroups_kobj, it's either allocating it,
in btrfs_sysfs_add_qgroups(), or removing it and set it back to NULL in
btrfs_sysfs_del_qgroups().

Thus this looks pretty weird.

Would you please provide the full call trace (especially the address
causing the NULL pointer deref) and the reproducer (if possible)?

Thanks,
Qu
>=20
> Thanks,
> Qu
>>
>>
>> =C2=A0=C2=A0=C2=A0 RIP: kobject_del+0x1/0x20
>>
>> =C2=A0=C2=A0=C2=A0 [...]
>>
>> =C2=A0=C2=A0=C2=A0 Call Trace:
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_sysfs_del_qgroups+0xa5/0xe0
>> =C2=A0=C2=A0=C2=A0=C2=A0 close_ctree+0x1cd/0x2c0
>> =C2=A0=C2=A0=C2=A0=C2=A0 generic_shutdown_super+0x6c/0x100
>> =C2=A0=C2=A0=C2=A0=C2=A0 kill_anon_super+0x14/0x30
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_kill_super+0x12/0x20
>> =C2=A0=C2=A0=C2=A0=C2=A0 deactivate_locked_super+0x36/0x90
>> =C2=A0=C2=A0=C2=A0=C2=A0 cleanup_mnt+0x12d/0x190
>> =C2=A0=C2=A0=C2=A0=C2=A0 task_work_run+0x5c/0x90
>> =C2=A0=C2=A0=C2=A0=C2=A0 __prepare_exit_to_usermode+0x164/0x170
>> =C2=A0=C2=A0=C2=A0=C2=A0 [...]
>>
>> Thanks,
>>
>> Chris
>=20


--WJYE8B9IUH7O4vlfLqueMBoAhObGauqpO--

--3QCc7O97boHuIXZL3P30pcz0OkVKCAPg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8PnugACgkQwj2R86El
/qjV/gf9FUf+bDKb8T2VOAqUl5nexv1wpzOWkgWaJJ9AOGZxa/6OyZB1L15+1fGb
CEwA79BWS5gsxtdqzQKblaHVkdn07vnzK1s+z/P3gK3HE+43LJHwBcDc8hJuH71S
6qVa/6f+U3Spcc1HixcjOiydX7hJM5gt6f/9ek4uHWsFkAvmOpgXBlQbQsx20s18
dXiYWZUnZaRzr7oLROjvbPvTmijLABvuWptyjO+HfJek+QW0WH1wNlQNi4edGBC8
J6QbJs2c6rnq4CldqB/A3E98WD4szZZl4PfZ4bApY2Jh6LhIRRMQJIjFKpY6Do7w
SrTHNpAl0yaPYaFm5BA/NAIJcaSGDg==
=Ceok
-----END PGP SIGNATURE-----

--3QCc7O97boHuIXZL3P30pcz0OkVKCAPg1--
