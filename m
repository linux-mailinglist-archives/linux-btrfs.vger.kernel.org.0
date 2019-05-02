Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09C111C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEBDB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 May 2019 23:01:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:56055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfEBDB1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 May 2019 23:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556766080;
        bh=+iofHjJ87PqFvINOVr7MksWcbaOJCJ9m29lNw7bD0X0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f1AIN+0Q75on3MNkVStROOb03R7VPJOcwKf53MvkjZqiGqucCs0vUSeAq0TJzSTbt
         OVQJK1TUAXFJfLaDDa3YR3euf5Jhh6DlxXplI06A+0u1NW5X2Fl0u0inFmEifGRm3x
         gPDRFEfAl1hTgrR4nFnxISYk0y35oDYlVJ0H46QQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ld0fQ-1gvnxP3J1k-00iAfX; Thu, 02
 May 2019 05:01:20 +0200
Subject: Re: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
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
Message-ID: <e9a8cd0f-7fc0-0a68-859a-5d2c8b860915@gmx.com>
Date:   Thu, 2 May 2019 11:01:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iElGqCIeT6GsRrXQBmF6hq0IQEIk3HcnS"
X-Provags-ID: V03:K1:O81jhv+N5CPDdUj6LQrLPnuWioSuFfYJBBaPJjVLayL6FfB7HDb
 KL4Mna0XsOjrjvuwvu8rMWZ854QryNOX8fNufgFfcMIAiH7yXdtYJUY/RJCjxEhXAiRBFwt
 Y+JM2eznPsCTt8T19RCFmfg0YotWbGg6LiuoVZM3V9Bo0bRpmVdowXwDMgGyxi7U5aDSt8X
 01yFR2NnHm9JFFj78lP0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oXUoh6IvpZ8=:jCRznnqRR8s1dY8fd/BVnI
 jxquPRb8QDm2xYFryEZFhJR/y4PTy3x12bBgPu9rM9+HjAtxHUw8c03X0fe7v+LCCfwu6ykaQ
 HjbL0/SiZV5ptEqawV8/QG30TLVxBYyKvqS+nL4ithM/9n1F/0lJCnMM8xnkxt5Kkre8Z2ETj
 PcNeqcUjm7cS0KHsDQ0w5xBNZZLpN1UnKdtVRUk/b5F7Gmn6VPoZkdJ9X58yqHoiF2+UMjoTH
 NH0wmBvKS2OuAPFJqaPQ7IEsFr2yc8EHNw+43zJ6wgfmvipykwlAze8Pz0J4pQuj2a2fv2qls
 rdVP8GlIzyEgY+daRWTx3EouftDkRZJwYvvXWChVgXTmNo3pEku6nvaBkU0a9PJPMdv91jBVe
 Zqcg87tKKSesXQI5XQkZ9JSXQDker4hJdELC3BHAFLyTE9A10bFcAQsdaSn8aVdC5pr5KGXdX
 SExjakn8g8GyGq92wirYV/7nVZhqtlWyfwfzQfdU5hsN02SCMG7Tsg/vnwQIxVAa2CmGoWXgh
 FoEvDGcnDg4NFPLzyLvq75vn2IezKxBtpP+CrIl8MoAmRwLD2NpFMYDy8JR6Xvsdp/5pjeXs8
 YhuG2qhvVMjYqynuBH+lbUQaHeiYp8iK3Hfsm15cNNKxelcU+6eoLa7mmZgdHrrHKbHkzqRc4
 egQeCn1OWYm9u0nG6mpxUzI0sWGpYapdb41FrgqLxvR12IWPfpAizus7CexYnLxGDfvBPNRxq
 ZDGCyqXxV4WaLJ0MMzViLIIFmoKNNHFEzYMtHy2bCiINlWfmDczNdGxVAnp7bpNbrUJy4HhET
 DfXuBcDEUdaUSVE4EFG7Yq5cwimkujb3wriQRfeCxkx04i71HtVVvZi/YpIvkcvrYfjaTj9wA
 SXcicXkJsEXaRMfhpkPH9ZvHM3RweJkGdqT6lOdeMzZ2usyauR94K7QglUorC3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iElGqCIeT6GsRrXQBmF6hq0IQEIk3HcnS
Content-Type: multipart/mixed; boundary="oZ9LvH5TUfOTiwSTAqfmuVbFB8QQ1mfhQ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <e9a8cd0f-7fc0-0a68-859a-5d2c8b860915@gmx.com>
Subject: Re: Rough (re)start with btrfs
References: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
In-Reply-To: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>

--oZ9LvH5TUfOTiwSTAqfmuVbFB8QQ1mfhQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/1 =E4=B8=8B=E5=8D=889:54, Hendrik Friedel wrote:
> Hello,
>=20
> as discussed in the other thread, I am migrating to BTRFS (again).
> Unfortunately, I had a bit of a rough start
> [Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for
> more than 120 seconds.
> [...]
> This repeated several times while moving data over. Full log of one
> instance below.
>=20
> I am using btrfs-progs v4.20.2 and debian stretch with
> 4.19.0-0.bpo.2-amd64 (I think, this is the latest Kernel available in
> stretch. Please correct if I am wrong.
>=20
> I understand that this was a 'timeout'. Is this caused by hardware?

Transaction get blocked for 2 minutes, depends on the load, it can be
either normal or a dead lock.

Have you tried stop the workload, and see if the timeout disappears?

If it just disappear after some time, then it's the disk too slow and
too heavy load, combined with btrfs' low concurrency design leading to
the problem.

Thanks,
Qu

>=20
> In the SMART logs indeed, I see that errors happened (Full log below)
> 84 51 20 df 27 81 40=C2=A0 Error: ICRC, ABRT 32 sectors at LBA =3D 0x00=
8127df =3D
> 8464351
> But this happened after 44h. I am now at 82h, so that was long before
> the error -infact during my 'burn-in test'.
>=20
> Is this a case for an RMA of the drive?
>=20
> Greetings,
> Hendrik
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> [Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for
> more than 120 seconds.
> [Mo Apr 29 20:44:47 2019]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not taint=
ed 4.19.0-0.bpo.2-amd64 #1
> Debian 4.19.16-1~bpo9+1
> [Mo Apr 29 20:44:47 2019] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mo Apr 29 20:44:47 2019] btrfs-transacti D=C2=A0=C2=A0=C2=A0 0 10227=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 0x80000000
> [Mo Apr 29 20:44:47 2019] Call Trace:
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __schedule+0x3f5/0x880
> [Mo Apr 29 20:44:47 2019]=C2=A0 schedule+0x32/0x80
> [Mo Apr 29 20:44:47 2019]=C2=A0 wait_for_commit+0x41/0x80 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? remove_wait_queue+0x60/0x60
> [Mo Apr 29 20:44:47 2019]=C2=A0 btrfs_commit_transaction+0x10b/0x8a0 [b=
trfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? start_transaction+0x8f/0x3e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 transaction_kthread+0x157/0x180 [btrfs]=

> [Mo Apr 29 20:44:47 2019]=C2=A0 kthread+0xf8/0x130
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? btrfs_cleanup_transaction+0x500/0x500=
 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? kthread_create_worker_on_cpu+0x70/0x7=
0
> [Mo Apr 29 20:44:47 2019]=C2=A0 ret_from_fork+0x35/0x40
> [Mo Apr 29 20:44:47 2019] INFO: task kworker/u4:8:10576 blocked for mor=
e
> than 120 seconds.
> [Mo Apr 29 20:44:47 2019]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not taint=
ed 4.19.0-0.bpo.2-amd64 #1
> Debian 4.19.16-1~bpo9+1
> [Mo Apr 29 20:44:47 2019] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mo Apr 29 20:44:47 2019] kworker/u4:8=C2=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=
=A0 0 10576=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 0x80000000
> [Mo Apr 29 20:44:47 2019] Workqueue: events_unbound
> btrfs_async_reclaim_metadata_space [btrfs]
> [Mo Apr 29 20:44:47 2019] Call Trace:
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __schedule+0x3f5/0x880
> [Mo Apr 29 20:44:47 2019]=C2=A0 schedule+0x32/0x80
> [Mo Apr 29 20:44:47 2019]=C2=A0 wait_current_trans+0xb9/0xf0 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? remove_wait_queue+0x60/0x60
> [Mo Apr 29 20:44:47 2019]=C2=A0 start_transaction+0x201/0x3e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 flush_space+0x14d/0x5e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? get_alloc_profile+0x72/0x180 [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? can_overcommit.part.63+0x55/0xe0 [btr=
fs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 btrfs_async_reclaim_metadata_space+0xfb=
/0x4c0
> [btrfs]
> [Mo Apr 29 20:44:47 2019]=C2=A0 process_one_work+0x191/0x370
> [Mo Apr 29 20:44:47 2019]=C2=A0 worker_thread+0x4f/0x3b0
> [Mo Apr 29 20:44:47 2019]=C2=A0 kthread+0xf8/0x130
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? rescuer_thread+0x340/0x340
> [Mo Apr 29 20:44:47 2019]=C2=A0 ? kthread_create_worker_on_cpu+0x70/0x7=
0
> [Mo Apr 29 20:44:47 2019]=C2=A0 ret_from_fork+0x35/0x40
>=20
>=20
>=20
>=20
>=20
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 FLAG=C2=A0=C2=A0=C2=A0=C2=A0 VALUE WORST THRESH TYPE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> UPDATED=C2=A0 WHEN_FAILED RAW_VALUE
> =C2=A0 1 Raw_Read_Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0 0x000b=C2=A0=C2=A0=
 100=C2=A0=C2=A0 100=C2=A0=C2=A0 016=C2=A0=C2=A0=C2=A0 Pre-fail=C2=A0 Alw=
ays
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> =C2=A0 2 Throughput_Performance=C2=A0 0x0004=C2=A0=C2=A0 128=C2=A0=C2=A0=
 128=C2=A0=C2=A0 054=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
> Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 116
> =C2=A0 3 Spin_Up_Time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0007=C2=A0=C2=A0 198=C2=A0=C2=A0 198=C2=A0=C2=A0 024=C2=
=A0=C2=A0=C2=A0 Pre-fail=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34=
9 (Average 317)
> =C2=A0 4 Start_Stop_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=
012=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old=
_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=

> =C2=A0 5 Reallocated_Sector_Ct=C2=A0=C2=A0 0x0033=C2=A0=C2=A0 100=C2=A0=
=C2=A0 100=C2=A0=C2=A0 005=C2=A0=C2=A0=C2=A0 Pre-fail=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> =C2=A0 7 Seek_Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x000a=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 067=C2=A0=C2=A0=C2=A0=
 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> =C2=A0 8 Seek_Time_Performance=C2=A0=C2=A0 0x0004=C2=A0=C2=A0 128=C2=A0=
=C2=A0 128=C2=A0=C2=A0 020=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
> Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 18
> =C2=A0 9 Power_On_Hours=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x0012=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=
=C2=A0 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 82=

> =C2=A010 Spin_Retry_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=
012=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 060=C2=A0=C2=A0=C2=A0 Old=
_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> =C2=A012 Power_Cycle_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=
=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=
=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=

> =C2=A022 Helium_Level=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0023=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 025=C2=
=A0=C2=A0=C2=A0 Pre-fail=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=
0
> 192 Power-Off_Retract_Count 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=
=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27=

> 193 Load_Cycle_Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0012=C2=
=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=
=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27=

> 194 Temperature_Celsius=C2=A0=C2=A0=C2=A0=C2=A0 0x0002=C2=A0=C2=A0 250=C2=
=A0=C2=A0 250=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0 Alway=
s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=
 (Min/Max 24/55)
> 196 Reallocated_Event_Count 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=
=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> 197 Current_Pending_Sector=C2=A0 0x0022=C2=A0=C2=A0 100=C2=A0=C2=A0 100=
=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> 198 Offline_Uncorrectable=C2=A0=C2=A0 0x0008=C2=A0=C2=A0 100=C2=A0=C2=A0=
 100=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0
> Offline=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
> 199 UDMA_CRC_Error_Count=C2=A0=C2=A0=C2=A0 0x000a=C2=A0=C2=A0 200=C2=A0=
=C2=A0 200=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0 Old_age=C2=A0=C2=A0 Always
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>=20
> SMART Error Log Version: 1
> ATA Error Count: 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CR =3D Command Register [HEX=
]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FR =3D Features Register [HE=
X]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SC =3D Sector Count Register=
 [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SN =3D Sector Number Registe=
r [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CL =3D Cylinder Low Register=
 [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CH =3D Cylinder High Registe=
r [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DH =3D Device/Head Register =
[HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DC =3D Device Command Regist=
er [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ER =3D Error register [HEX]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ST =3D Status register [HEX]=

> Powered_Up_Time is measured from power on, and printed as
> DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
> SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.
>=20
> Error 2 occurred at disk power-on lifetime: 44 hours (1 days + 20 hours=
)
> =C2=A0 When the command that caused the error occurred, the device was =
doing
> SMART Offline or Self-test.
>=20
> =C2=A0 After command completion occurred, registers were:
> =C2=A0 ER ST SC SN CL CH DH
> =C2=A0 -- -- -- -- -- -- --
> =C2=A0 84 51 20 df 27 81 40=C2=A0 Error: ICRC, ABRT 32 sectors at LBA =3D=
 0x008127df
> =3D 8464351
>=20
> =C2=A0 Commands leading to the command that caused the error were:
> =C2=A0 CR FR SC SN CL CH DH DC=C2=A0=C2=A0 Powered_Up_Time=C2=A0 Comman=
d/Feature_Name
> =C2=A0 -- -- -- -- -- -- -- --=C2=A0 ----------------=C2=A0 -----------=
---------
> =C2=A0 35 03 20 df 27 81 40 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:54.0=
41=C2=A0 WRITE DMA EXT
> =C2=A0 35 03 01 ff 27 81 40 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:54.0=
40=C2=A0 WRITE DMA EXT
> =C2=A0 25 03 20 02 00 00 40 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:54.0=
40=C2=A0 READ DMA EXT
> =C2=A0 25 03 20 02 00 00 40 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:54.0=
40=C2=A0 READ DMA EXT
> =C2=A0 25 03 01 af 2a 81 40 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:54.0=
11=C2=A0 READ DMA EXT
>=20
> Error 1 occurred at disk power-on lifetime: 44 hours (1 days + 20 hours=
)
> =C2=A0 When the command that caused the error occurred, the device was =
doing
> SMART Offline or Self-test.
>=20
> =C2=A0 After command completion occurred, registers were:
> =C2=A0 ER ST SC SN CL CH DH
> =C2=A0 -- -- -- -- -- -- --
> =C2=A0 84 51 00 00 00 00 00
>=20
> =C2=A0 Commands leading to the command that caused the error were:
> =C2=A0 CR FR SC SN CL CH DH DC=C2=A0=C2=A0 Powered_Up_Time=C2=A0 Comman=
d/Feature_Name
> =C2=A0 -- -- -- -- -- -- -- --=C2=A0 ----------------=C2=A0 -----------=
---------
> =C2=A0 47 00 01 00 00 00 a0 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:37.4=
34=C2=A0 READ LOG DMA EXT
> =C2=A0 47 00 01 13 00 00 a0 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:37.4=
33=C2=A0 READ LOG DMA EXT
> =C2=A0 47 00 01 00 00 00 a0 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:37.4=
32=C2=A0 READ LOG DMA EXT
> =C2=A0 ef 10 02 00 00 00 a0 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:37.4=
30=C2=A0 SET FEATURES [Enable SATA
> feature]
> =C2=A0 27 00 00 00 00 00 e0 08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:37.4=
27=C2=A0 READ NATIVE MAX ADDRESS EXT
> [OBS-ACS-3]
>=20
> SMART Self-test log structure revision number 1
> No self-tests have been logged.=C2=A0 [To run self-tests, use: smartctl=
 -t]
>=20
> SMART Selective self-test log data structure revision number 1
> =C2=A0SPAN=C2=A0 MIN_LBA=C2=A0 MAX_LBA=C2=A0 CURRENT_TEST_STATUS
> =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
> =C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
> =C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
> =C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
> =C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 Not_testing
> Selective self-test flags (0x0):
> =C2=A0 After scanning selected spans, do NOT read-scan remainder of dis=
k.
> If Selective self-test is pending on power-up, resume after 0 minute de=
lay.
>=20


--oZ9LvH5TUfOTiwSTAqfmuVbFB8QQ1mfhQ--

--iElGqCIeT6GsRrXQBmF6hq0IQEIk3HcnS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzKXXoACgkQwj2R86El
/qgaeAf+K5IePB/sUTa3bxLvZ+aP4Tsc4lL9jmAsqjhDJKxgwKarSARQv44MPAut
ZFHQ4+HtvTcWYgQhbHkKQ5OenanOxd4aX82aqw4GUeRj/cGHn/ZZGQct3D7AxAtG
tFvJIqmIuuqi5OkspxdLJ76ptOJHrhAONoWN51u4mG2IdslkBGcSMhI2XKTwr/x2
17tb8sSsiCFA12ptrJNumvPUhXz/uIR7CX2iTD9rOBfeQkffPej9gApNUVC4rvXR
CnavN0x/FGmSjt5FH7LmhDDVYnjjixEe5fqN3EhefUiFB0HZTN20gG82YEk9oAgJ
ZZlKB3ZhdgSuHEaodAWTMD46/Hytyg==
=O8S2
-----END PGP SIGNATURE-----

--iElGqCIeT6GsRrXQBmF6hq0IQEIk3HcnS--
