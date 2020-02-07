Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06429154FB6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 01:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBGAYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 19:24:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:54097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBGAYr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 19:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581035079;
        bh=aZPs6gmn6UQDaHK2Rsyp/UBkbSo2Z9xkNXV3AS5sKO0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=D8/iKj24xENW23tVwB3Z9LydEDO1sfUbtivG/Hhkpuu7Wo4OOQx1IcnLQp4Zi8AAv
         YQm47UvPW4mn9kJsm6l/HYXqyBNeQ20s+bkM52wSxMAlXYvjhdCjJvsl5ywGHdvBWx
         1PcB0oM5JI/JnCYGaawUL4hwdmB8/pZhvWots0Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf078-1jSsXt0P50-00gVV5; Fri, 07
 Feb 2020 01:24:39 +0100
Subject: Re: [PATCH v3] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200205071015.19621-1-wqu@suse.com>
 <3dce6f8a-c577-66b7-d104-b8409255b49b@toxicpanda.com>
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
Message-ID: <443a3b4a-c751-741c-1f27-f39f16ad1ded@gmx.com>
Date:   Fri, 7 Feb 2020 08:24:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3dce6f8a-c577-66b7-d104-b8409255b49b@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5DmM3Cp5UiqYIF8mFVH1NNDZCldGeVkDT"
X-Provags-ID: V03:K1:t1oN454GlRiU46JvQE1FoCKnBUl+Vt3mDEsrcxYCAlmw/KraPQo
 zIXNevwjXLoHuIll8+PiOZHiFraw4ugP5IGqV3/B+vxY7f8F7EhLDrNK3UpFKGm+g1UZALV
 IQJHwSGYQo8CYFIBdhNLNU9uoOSjYSp+K8lvQp25/9+RUABkVoySVf3DEmHON5KFENtHf5f
 b4nm7x6z98DpxiEq6e+9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixYu7PZQPtg=:xhkbohxEmRbxop8cETqNib
 EG3YDFfZbuexdiCRNyUniij58nhHltQcmP6DNRFybeXZ9mZcmGoJJoIrI59vrWZMdOfF9iAMv
 VZ3o8M1eIAG3Xi8pP2MfaGdB1tnmT+KIl4snlZ2ggebLs6+Xxg6wR0R4k+HIHAYQU2qcn0PAM
 IsZrytOfmrkDtrjZg37rVDF2G/r2EajkcbAibmQDCSqk6X70N9D7VQAGlkAslkAxS0/O9DUyT
 jHJITuB0zn3ghhTetKsEeohn+pGfHwRZGxEcemmn4bdL2GryIYy9/4tKLjiBEnCtoizVsIRPw
 /iyTaF3ufbET0eeTpd2VMXM3nsdssqpqUq+sg+wTAVIqX8DrMC8OvUQYZLvL/tG3j742OIHxK
 g6SW/ZmQD4lwUQWOa/r0xNESPgPpBHJ2mUJwzjuJIcFzWpsoO7nZjoQ/CwsHessYmMuro3lEd
 r9BdQ1toMoXJIL2lcO6Q8ti11dC3VHTTG5Foazc1nNwfrK90iznIlSJ2T0lHyUJo7hPLwU+qn
 6UKVzwvyiFM9tLxBIxykMEOHyYSeoA3xLwY8A+C2SOiyjHLH1qctSK5ntRYXYfGFBkTW0E/Gf
 JoEu0/B6ISoe6pO8jIIKT8kYfGEfseYC+uqJT+9MThTXXhl8Qgr8QK17ysRI0ZhvUa9BU7exr
 w2SFt1NQtOx+NbnbGKY/cIoCcciUOOx8hf9L2uCFvIkwf+CUk34BS4tk2lSXKiFIwjOFFOH8K
 5P8/6CwubfQ9R0wW3IsrAF3lqTJV2ouJcRAcAY8jH7ay2pFcdD4Kvm6avr4JYerLx1zqhuaZ8
 +w8LVTjoVnlOCiOVjM98geYfWgvRxHlmWreAYMfKXd2LUtVz55ph4T0dVnC/WkQZoLY8HEZEU
 fNau1WC/hivz9QUju4mFGALa+RJzoauTskY51N7vX2/FvdVj3FfNvhzBMCUVwlDgiWSZY4eSu
 AhdwTU6QSduVMbzFCpDYAf4xxXb12nMvWbkRwmxobwg1Pik2Xbo3Ovu1VJxB6dWykTjl4lhlM
 3YgVn74wI2vngj9d/8CbOwp+gHtiupUD6x4voWTZ9RIKrl76gDaQ0Pgu7qOwbGulmH0vwmkmF
 wipdmV/MUiLH8LKebwFO8Uk/Hb2uG4EMqatlw8JNS3E9rmrNtGhCfFiG9vyhoc4TTSLFYjal9
 rWpJHvHqB496wRA51cnZxsvLDxp9zxIMswHYPrZ9VP9iuXvwAFIRpgrEL1eh2dimHOMvjgc8+
 FOlXN87IH54NWW+Op
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5DmM3Cp5UiqYIF8mFVH1NNDZCldGeVkDT
Content-Type: multipart/mixed; boundary="QgxOsLL01B7qpQt9FUyGamWmWqgadJ3IM"

--QgxOsLL01B7qpQt9FUyGamWmWqgadJ3IM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/7 =E4=B8=8A=E5=8D=8812:00, Josef Bacik wrote:
> On 2/5/20 2:10 AM, Qu Wenruo wrote:
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
>> The fuzzed image has a completely screwd up extent tree:
>> =C2=A0=C2=A0 leaf 29421568 gen 8 total ptrs 6 free space 3587 owner EX=
TENT_TREE
>> =C2=A0=C2=A0 refs 2 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 cu=
rrent 5938
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 ke=
y (12587008 168 4096) itemoff 3942 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref root 5 ob=
jectid 259
>> offset 0 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 ke=
y (12591104 168 8192) itemoff 3889 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref root 5 ob=
jectid 271
>> offset 0 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 2 ke=
y (12599296 168 4096) itemoff 3836 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: extent data backref root 5 ob=
jectid 259
>> offset 4096 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 3 ke=
y (29360128 169 0) itemoff 3803 itemsize 33
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref root 5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 4 ke=
y (29368320 169 1) itemoff 3770 itemsize 33
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref root 5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 5 ke=
y (29372416 169 0) itemoff 3737 itemsize 33
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 9 flags 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: tree block backref root 5
>>
>> Note that, leaf 29421568 doesn't has its backref in extent tree.
>> Thus extent allocator can re-allocate leaf 29421568 for other trees.
>>
>> Short version for the corruption:
>> - Extent tree corruption
>> =C2=A0=C2=A0 Existing tree block X can be allocated as new tree block.=

>>
>> - Tree block X allocated to log tree
>> =C2=A0=C2=A0 The tree block X generation get bumped, and is traced by
>> =C2=A0=C2=A0 log_root->dirty_log_pages now.
>>
>> - Log tree writes tree blocks
>> =C2=A0=C2=A0 log_root->dirty_log_pages is cleaned.
>>
>> - The original owner of tree block X wants to modify its content
>> =C2=A0=C2=A0 Instead of COW tree block X to a new eb, due to the bumpe=
d
>> =C2=A0=C2=A0 generation, tree block X is reused as is.
>>
>> =C2=A0=C2=A0 Btrfs believes tree block X is already dirtied due to its=
 transid,
>> =C2=A0=C2=A0 but it is not tranced by transaction->dirty_pages.
>>
>=20
> But at the write part we should have gotten BTRFS_HEADER_FLAG_WRITTEN,
> so we should have cow'ed this block.=C2=A0 So this isn't what's happeni=
ng,
> right?

=46rom my debugging, it's not the case. By somehow, after log tree writes=

back, the tree block just got reused.

>=C2=A0 Or is something else clearing the BTRFS_HEADER_FLAG_WRITTEN in
> between the writeout and this part?=C2=A0 Thanks,

It didn't occur to me at the time of writing, is it possible that log
tree get freed, thus that tree block X is considered free, and get
re-allocated to extent tree again?

The problem is really killing me to digging.
Can't we use this last-resort method anyway? The corrupted extent tree
is really causing all kinds of issues we didn't expect...

Thanks,
Qu

>=20
> Josef


--QgxOsLL01B7qpQt9FUyGamWmWqgadJ3IM--

--5DmM3Cp5UiqYIF8mFVH1NNDZCldGeVkDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl48rkMACgkQwj2R86El
/qhzdwf7BBKr5EgQb5L2+1ftfIsBnLUkCoe/7jtCU7Bp4JG5WKeZFbhVyEY4EvOJ
/Ju3vUqY1bHcAGwmkMcR45kvjQ+CrKKqJRPAhWVlhnyP3YRm1Al0FudQPSILoM/L
zSYVMWdlWPlrHuQdS4Lp9sdVcKrjMvBxh+k0asH5yBSxjZLfr2CPbBajZTvKoP8R
Xybfpvh2e84vxdpR7wVANsb7Ni/0Sbbh1c3ZwqTiKPpeWNGewEk3b4f5SBc/CoYT
ztHj4HBJccDDZu4GAEwQ2D7A9vj+QBL0o5eNNmcrHWEAVHCUjXy0d6ZT9QNcBGKe
uec8JyvBL0aiSlpX9wa8G56Lhw16YA==
=4p8v
-----END PGP SIGNATURE-----

--5DmM3Cp5UiqYIF8mFVH1NNDZCldGeVkDT--
