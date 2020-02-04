Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3478D151B9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBDNq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 08:46:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:56775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgBDNq0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 08:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580823979;
        bh=oWLpa09n3gtgeFE4Gw6fLnglMBiQ37Fla0JfWTYw7sI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dc8pjrjk6sGZlHcT+o1lnCuWjp+S5/zdIRZqWKQ0l0PDB6rNaGG5tO+jn/dcJ9dsT
         0qe5QeloUtkt73o/fcSTGmbYGERwkgKbSFVUjgTmzi6YUJHWr5m0+kQdU7pMjSYNiY
         rDutW6NKNra2LNKRHBRisTLZcGN6oqy0XFgYCjuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfJX-1jp1Lq3Jdf-00v6SL; Tue, 04
 Feb 2020 14:46:18 +0100
Subject: Re: [PATCH v2] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200204090314.15278-1-wqu@suse.com>
 <36dbfbd1-5206-0eeb-2b73-308b0c19c76b@toxicpanda.com>
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
Message-ID: <a02edfad-3bdb-61c5-9374-76537f325d94@gmx.com>
Date:   Tue, 4 Feb 2020 21:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <36dbfbd1-5206-0eeb-2b73-308b0c19c76b@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2Mi2lVuXWXlWImiIW32SNjgsJJpm8K78Y"
X-Provags-ID: V03:K1:DBzIDVrPPdthHjntriVbzcHchGWN52ZEehPTqp8/oUq844RSm6P
 87P8MqlM64sR0kaO6vZiuAvc4ozErnFdSxxz+zHWFLjstxe94fVnQGWf9JmiIfSL3llFWu4
 EmM9B+ZiHeo6UE0w+i/yvF/1uphHJ1byKCft8hI2jkjVim82k3lsnojjEVCZEPnq0xt3lIf
 n3Diq5VB145YCRUO4iLTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TTBSC6F2rws=:GP6scsJOsn8LKR6OqrqWy5
 TaPmjqvVvZrbuFsj5vtsvsrfddHW3At5bB4BB6NfWXV6+FU65HV7dUSbAfh0dk8ztl2Pq0dLr
 CCAMnWNIKvtkKEcgsePGhNfWFYQOJTrrwzIf6RqkerZHfT1agL8Rd2A2cYdt8MUfCHUrOImXn
 vW1TOOPHE8l6acUVVj/QEW5xD9VTKRmGOeTaojchN3IB7PxoXKHckBCnBwnNbDO9BAZZha8/k
 hIIHSnkCztFPQT7xdfKZH8pojLE92QpWWzGVjHf+kqQ/kre3zlh5MD20rYCFgCBvO9uQpFraf
 kbQo3y0beKbIrATb+XaVdTOQ+0ReR4o7s0v4Fa9Q6suUfo5s4D8JWlfegn4CdIMXD6n8OVU/Z
 jTVpP3Dcj3XgEtv5Zx7vy4FKel/mmvh/Z9gM1AzR0/Cy7iV0IABZfK/O3f9AFxhlDP5rBJOFe
 lL0ZAYetgJQajG9Hzd6YmCq4b4QL84m6Me2uw7owDKMPwWgpIyLDexYQl2MgS7a0otfiB/ZK/
 Z4HwozsGc/Hb3ore2RWG/w8J4EKkv34RYzN4g6TFcbTmKAF4zJIBWdnZe4hNFmbkd5pm94XbN
 Vs9ny/3AfFPI4wjeoMn30aor15YGM9sOPkTs0dAut8W9AdCnXmKYFAVBzref+UjT4HnzxoTku
 PR+0qRQ1iu6RSD0REkw5O5qamokUB0klN4b0Na5ud2h3AbPVQYO9E4ZxdcIg7+PsNmLje5w5z
 IR6b5QUZYlqVl4TOGKLvBdng9Eh8wUkuiDmAgo4Jrne0lAqB2/slbyrfbafaK3zkM58TLP+la
 nzJFgZI+nuGcRxNOhK25KnhIsdKL6vasdAZ2FiIEJQYiPTBfGIapzTaAWziJnPYZjMZ6ZCeSp
 CHLnjcH8fKZogYu/cpOZ3jYnpfLkeEkTUhZrFpFFzxeSnCf3M6CRjGVuphjDepEsmtLuvDvW3
 GmQhF8pSwKbSEr4gi7P4n/OvOpCpvFr9EyxcGW1rzp1AHGV8jXbmTJGdYmLXIWOPVcIAdVyNZ
 8yagnjeClMatBJ+n2kBAhi+ZXI/gMefbhYtRT1AgcdchtgLTQ6jdZ4aQE8Og49Ks8xyKXHrJj
 meq1rx1zhHhXzSf2vqD05D9wEZu4lPwJubbJLacSNNzERhcwW/nvxbDcQ8952ZSxsYqGUBlTb
 2qBQdP4xYJO06OUGxbEDCanSNDhIKdNcK13myPdGc7PAaJdwtwtRTLII/ORn61gGXezPMpWYJ
 iy/ZPv9Vcjo8Ho1b/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Mi2lVuXWXlWImiIW32SNjgsJJpm8K78Y
Content-Type: multipart/mixed; boundary="MEWTsneRz454ANr3TJfGzYlprvjpp0EBU"

--MEWTsneRz454ANr3TJfGzYlprvjpp0EBU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/4 =E4=B8=8B=E5=8D=889:11, Josef Bacik wrote:
> On 2/4/20 4:03 AM, Qu Wenruo wrote:
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
>> =C2=A0=C2=A0 leaf 29421568 gen 9 total ptrs 6 free space 3587 owner
>> 18446744073709551610
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
>> 1. Wrong owner
>> =C2=A0=C2=A0=C2=A0 The corrupted leaf has owner -6ULL, which matches
>> =C2=A0=C2=A0=C2=A0 BTRFS_TREE_LOG_OBJECTID.
>>
>> 2. Missing backref for extent tree itself
>> =C2=A0=C2=A0=C2=A0 So extent allocator can allocate tree block 2942156=
8 as a new tree
>> =C2=A0=C2=A0=C2=A0 block.
>>
>> Above corruption leads to the following sequence to happen:
>> - Btrfs needs to COW extent tree
>> =C2=A0=C2=A0 Extent allocator choose to allocate eb at bytenr 29421568=
 (which is
>> =C2=A0=C2=A0 current extent tree root).
>>
>> =C2=A0=C2=A0 And since the owner is copied from old eb, it's -6ULL, so=

>> =C2=A0=C2=A0 btrfs_init_new_buffer() will not mark the range dirty in
>> =C2=A0=C2=A0 transaction->dirty_pages, but root->dirty_log_pages.
>=20
> That's not what it checks though, it checks the root that was passed in=
,
> so I assume this means that the root that is cow'ing the block is a log=

> root?

Oh, right. That's the same. The eb is for the log tree.

>=20
>>
>> =C2=A0=C2=A0 Also, since the eb is already under usage, extent root do=
esn't even
>> =C2=A0=C2=A0 get marked DIRTY, nor added to dirty_cowonly_list.
>> =C2=A0=C2=A0 Thus even we try to iterate dirty roots to cleanup their
>> =C2=A0=C2=A0 dirty_log_pages, this particular extent tree won't be ite=
rated.
>=20
> But what about the original root that actually allocated this log root?=
=C2=A0
> That should still be on the dirty list, correct?=C2=A0 And thus be clea=
ned up
> properly?

I tried that solution, by going through all dirty trees, and clean their
root->dirty_log_pages (both EXTENT_NEW and EXTENT_DIRTY).

But strangely, only csum tree is dirty.
Even we have CoWed tree block for extent tree for delayed refs, it's not
in dirty cowonly list.

That's why my initial attempt to clean dirty_log_pages failed miserably.

>=20
> I'm not quite understanding how we get into this situation, we have the=

> above block that is pointed to by the extent root correct?

Yes, the initial image has 29421568 as extent root.

>=C2=A0 But the
> block itself isn't in the extent tree, and thus appears to be free,
> correct?

Yep.

>=20
> So then what you are seeing is
>=20
> fsync(inode)
> =C2=A0 log the inode, which attaches inode->root to dirty_list
> =C2=A0=C2=A0=C2=A0=C2=A0 create a log root, attach it to the root
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allocate this bogus block, set it =
dirty in log_root->dirty_log_pages
> <some time later, boom>

By some reason, it's not that easy.

We abort trans as run_delayed_refs() from btrfs_commit_transaction().
At this point, we dump extent tree, which has generation 9 (8 + 1, so
it's the current running transaction), owner is -6ULL.

So yes fsync() happened and allocated the extent buffer, which is also
extent root.

> we try to write out the above block
>=20
> Why isn't the log root getting cleaned up properly?=C2=A0 It doesn't ma=
tter
> who owned the block originally, it should still be attached to a log
> root that is attached to a real root and thus be cleaned up properly.=20

Then this is the problem.

I don't see btrfs_cleanup_one_transaction() doing any log tree related
cleanup.

And since it's log tree, my previous check on dirty_cowonly_list doesn't
make much sense, as those trees aren't updated if they have log tree.

I'll check how to iterate through log roots then.

Thanks,
Qu

> Something else appears to be going screwy here.=C2=A0 Thanks,
>=20
> Josef


--MEWTsneRz454ANr3TJfGzYlprvjpp0EBU--

--2Mi2lVuXWXlWImiIW32SNjgsJJpm8K78Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl45daUACgkQwj2R86El
/qimmAgAslqqDcuqseuAGixLLLvKuw2l/zbo4S0R+MdjBzUywiZ559TKTBeuxnuC
s0iKrASTKZ2Xf0YfCGntOOF/oQ9kV7NXT3T3HEcvLzSQia75xT+9NdnSlofZ68Jn
ESw/N1N7/VCwUG83UATEBe845brTxiMYAaBuf93/5GYJgL4b9X3FmubhmsI46UIj
QqNcp/5YVk384AA1acoqOuH/eXrryXpr12/mRLSY+wonqHm9zSfW5RA7HeF4q+wD
380jZgXB9OY7ab3JzOHCP/VhT+1CJwwqHpmLCQy0LFpJKlWRTZRLRupP2tac/luZ
8PYcAKK5Uwip7A8orYK/0voJhNKWBw==
=yW86
-----END PGP SIGNATURE-----

--2Mi2lVuXWXlWImiIW32SNjgsJJpm8K78Y--
