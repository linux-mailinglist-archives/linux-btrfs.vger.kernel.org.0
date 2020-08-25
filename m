Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9225116B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 07:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHYFSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 01:18:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:60685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgHYFSR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 01:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598332694;
        bh=bS2lVDmNKB2q1Enrx42pV+sdjlV3QJE8pHErydZ/Eho=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ae9lxbYe5tkLPaUaq9nIt9iEVQ0cXQaZaWJvJSb9/pETrVP69ikC0UIiNjKGOQLpr
         K5Jn55EdSPiffKHK1EhSm/fgRhKwyBjssXNfCGzYcU3PkFkZQg3HNgTjVIRnsAQnG8
         zlxX2hv/cv8ZMuBiuiSI//UxCG/dRW+3/Ps19R6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1ky4ue1nvp-00q7qH; Tue, 25
 Aug 2020 07:18:14 +0200
Subject: Re: [PATCH 2/2] btrfs: qgroup: fix qgroup meta rsv leak for subvolume
 operations
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200724064610.69442-1-wqu@suse.com>
 <20200724064610.69442-2-wqu@suse.com>
 <d90d08f5-0205-09a8-efb3-49950494c314@toxicpanda.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <f85d356a-1809-d530-7fe6-90c77ff71f4f@gmx.com>
Date:   Tue, 25 Aug 2020 13:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d90d08f5-0205-09a8-efb3-49950494c314@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:doLGvSySazprr9ldFc1ekKA0LyyKN6drAKdmzKkBpMFos+v3O4O
 dobXFqlSm+DF0eIedB9F1vBRI4O8cKlw4BstQMrpskUubr1jCzmF1rWE9Inf3yJSWnTTqr6
 DPUQT4jY70Hyr1jiLyB5ggkijSzqAz40JlJcf3m0h4RD1DDHubJJV3eNPoCUEosV7Uln9ub
 Pk2Z2TCK3blIc56SkIOTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YqIpAPiVbDQ=:2jwWARw/v2DpWDHhKdGhT+
 yBl+Z8wNo3rFk3An8XrqqymanmE0sdDSEBZ3kjo9gn7eqv8wJYJVD6rYF+qF3E8Qenq8iZEkL
 0SL4iBDaDl8D0DWA1q1LUyz1PhlEJAlO8b56OwrVeujIFmuc38ibdsL6vkD9+oZIGtCNxS1pW
 +ITv8UhY5LpTkQcNLTxX6u+6puJveqBVfZRxCr3ICazF2d9bk7l5xzrflIjCU4fVnbU5Mwche
 m2oRofJnPPgqEN6hhq2YwFpv1nvXU/E1vDwJ8dFb+NrUomF7qFJM4PnfMAQRM8xjuKGWqpGGE
 OwafTeep6g/HTuWoyfXCJujt/jZoqCwkvblKhfkedVUljLqJ2EMdkIuDBkETMcdtZzaaQVlcN
 eHKOUUE7N6dn/nNSa+dD8c+kkY/u9wL1FmtJysDhJtURa3TZ68tAdntFrjz4Pdh9Ya1j25prR
 CiIyo5B/WjJ87xp28v1usqWevqLsuheHJ/66n21xEOvBbBCH7KNXjX24eTP2VdiJhZA09MAAS
 vJrmmELz/DINnbmMQ4Y5uk8iaiHFW44/e2JcVUYpVrU74NODgNt8HO6ROkvnWxp0kO6N61eMd
 d98op64/131+Zydv3etgwZKeNjquah12zmOPalbxl1eL8bgTynjFVjYRTy6KT0RoOWYJiOe2H
 AfHkc49URrqNo/J4fiE+ZCRrVkJhHIUel3Lf9uDpItHH4R7MClkLGxPqINxzuqCQV2yqmH2q8
 lw5j7XBZXuOrLQro4dURdRsLsDUHh6t66VKgb/B2hogBq/JaEQOqrkp3N2D6M9TKb/rSXrYyf
 iY1tQaawWUpToep4DXOu3CVAEUB4AV4Czk6uz1OBi4zX80XfSJzcuGTyHZojs96/WX8tumWKK
 8rQaUq4nZii6mnrEpECFzZnr5OUq8rJf4qKSA7Q6elOaw1ytsZRri5y3Dc94NGWGhh0tQtTzi
 wMTXOdwQ9FA2hvr6HYd0vqgR3Z14scLa2GHLkJpaHBN26PgNJXpwYJtkuJYRZA9jycAoEHF4G
 QawxjhFlos/japgWYHvaBayaCuFxqKYM9vRwA/htJWYGWD4TMNO+bafVT878UiU2Jp9WWYdXJ
 YqKYrMy4cuMLrdB8ZCjb/vCcOvuBH5+Cv4iDR+SN+6WDgo0TkVzfBgkGvHpu7LZIFdSixLYPP
 q84ZMjz3veAlNs8hZRKU6v9vpJwMXSj4CdNbVNYnHtfb+TfwRnOIjLitS0oWy5AG1cueqfpD0
 B4GBirgbQ9qkOyi+s7KYNHNmU1U/hKFJ79bxHlA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/25 =E4=B8=8A=E5=8D=882:08, Josef Bacik wrote:
> On 7/24/20 2:46 AM, Qu Wenruo wrote:
>> [BUG]
>> When quota is enabled for TEST_DEV, generic/013 sometimes fails like
>> this:
>>
>> =C2=A0=C2=A0 generic/013 14s ... _check_dmesg: something found in dmesg=
 (see
>> xfstests-dev/results//generic/013.dmesg)
>>
>> And with the following metadata leak:
>>
>> =C2=A0=C2=A0 BTRFS warning (device dm-3): qgroup 0/1370 has unreleased =
space,
>> type 2 rsv 49152
>> =C2=A0=C2=A0 ------------[ cut here ]------------
>> =C2=A0=C2=A0 WARNING: CPU: 2 PID: 47912 at fs/btrfs/disk-io.c:4078
>> close_ctree+0x1dc/0x323 [btrfs]
>> =C2=A0=C2=A0 Call Trace:
>> =C2=A0=C2=A0=C2=A0 btrfs_put_super+0x15/0x17 [btrfs]
>> =C2=A0=C2=A0=C2=A0 generic_shutdown_super+0x72/0x110
>> =C2=A0=C2=A0=C2=A0 kill_anon_super+0x18/0x30
>> =C2=A0=C2=A0=C2=A0 btrfs_kill_super+0x17/0x30 [btrfs]
>> =C2=A0=C2=A0=C2=A0 deactivate_locked_super+0x3b/0xa0
>> =C2=A0=C2=A0=C2=A0 deactivate_super+0x40/0x50
>> =C2=A0=C2=A0=C2=A0 cleanup_mnt+0x135/0x190
>> =C2=A0=C2=A0=C2=A0 __cleanup_mnt+0x12/0x20
>> =C2=A0=C2=A0=C2=A0 task_work_run+0x64/0xb0
>> =C2=A0=C2=A0=C2=A0 __prepare_exit_to_usermode+0x1bc/0x1c0
>> =C2=A0=C2=A0=C2=A0 __syscall_return_slowpath+0x47/0x230
>> =C2=A0=C2=A0=C2=A0 do_syscall_64+0x64/0xb0
>> =C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> =C2=A0=C2=A0 ---[ end trace a6cfd45ba80e4e06 ]---
>> =C2=A0=C2=A0 BTRFS error (device dm-3): qgroup reserved space leaked
>> =C2=A0=C2=A0 BTRFS info (device dm-3): disk space caching is enabled
>> =C2=A0=C2=A0 BTRFS info (device dm-3): has skinny extents
>>
>> [CAUSE]
>> The qgroup preallocated meta rsv operations of that offending root are:
>>
>> =C2=A0=C2=A0 btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc ro=
ot=3D1370
>> num_bytes=3D131072
>> =C2=A0=C2=A0 btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc ro=
ot=3D1370
>> num_bytes=3D131072
>> =C2=A0=C2=A0 btrfs_subvolume_reserve_metadata: rsv_meta_prealloc root=
=3D1370
>> num_bytes=3D49152
>> =C2=A0=C2=A0 btrfs_delayed_inode_release_metadata: convert_meta_preallo=
c
>> root=3D1370 num_bytes=3D-131072
>> =C2=A0=C2=A0 btrfs_delayed_inode_release_metadata: convert_meta_preallo=
c
>> root=3D1370 num_bytes=3D-131072
>>
>> It's pretty obvious that, we reserve qgroup meta rsv in
>> btrfs_subvolume_reserve_metadata(), but doesn't have corresponding
>> release/convert calls in btrfs_subvolume_release_metadata().
>>
>> This leads to the leakage.
>>
>> [FIX]
>> To fix this bug, we should follow what we're doing in
>> btrfs_delalloc_reserve_metadata(), where we reserve qgroup space, and
>> add it to block_rsv->qgroup_rsv_reserved.
>>
>> And free the qgroup reserved metadata space when releasing the
>> block_rsv.
>>
>> To do this, we need to change the btrfs_subvolume_release_metadata() to
>> accept btrfs_root, and record the qgroup_to_release number, and call
>> btrfs_qgroup_convert_reserved_meta() for it.
>>
>> Fixes: 733e03a0b26a ("btrfs: qgroup: Split meta rsv type into
>> meta_prealloc and meta_pertrans")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Seems like this class of issues could be avoided if the qgroup
> reservation stuff actually took the block_rsv so they could update the
> ->qgroup_rsv_reserved counter, and then the reserve/cleanup functions
> would do the right thing themselves, instead of needing to make sure
> they adjust things as necessary in all the callers.=C2=A0 This would be
> reasonable follow up work.=C2=A0 Thanks,

Exactly.

Especially the old qgroup specific reserve calculation is completely to
reduce early EDQUOT, but now we have retry mechanism, we can completely
rely on the blk rsv numbers.

That would be my next qgroup work objective.

Thanks,
Qu

>
> Josef
