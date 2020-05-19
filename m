Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD3C1DA512
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESXAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 19:00:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:38551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgESXAh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 19:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589929230;
        bh=jP4KFdh4imixYkR5ffe6P8Ofjcf1og2o16EKusj1HhM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UtT3qiWfbJlV3hTFQxaBttZbc4urjWvz1gKGuy9FL1RTXnACpNZEfVBKEslWdDdWS
         AAnipWLf8ZK+NkTfjcbH5/NFpiaNDzgfQXiTv9xTjRnkZWz4GCiXEqdeslMIWHXFCH
         4zL6k4uOtUmarqkHaf0CIU/4s9U+zHRGQ5K0h7bA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1jl37h3plM-00CAYU; Wed, 20
 May 2020 01:00:30 +0200
Subject: Re: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200519021320.13979-1-wqu@suse.com>
 <20200519140414.GD18421@twin.jikos.cz>
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
Message-ID: <49d73606-df91-d030-cb70-c34796c792b3@gmx.com>
Date:   Wed, 20 May 2020 07:00:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519140414.GD18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kj0lTTYfb8ECCysYD39CDRCO81hDhtgbk"
X-Provags-ID: V03:K1:S0u5OJxOIgNQwU+IQlsNAQJ2DQa53l0DkVOao1zLTQgVJ/CU2l0
 MSxSLEZZiS2rmmqWuEbmXiZB9PgAEtpEi+HEe6oABG7Iy0cWWKAmhcZbuB9dHFXylK2/ddx
 41carbODS91ect+QmeOWXYP2Sc5yy0OoDy7C6tvohe1gfQ/SDPu1t97mlCYFc8JuBQtpStH
 mUy/Jn1++DNCX60b7effg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eY6V7H79BWQ=:Fr2fOdYs9n/tcKyw5392qS
 L7c1axcOlgNUjRpekytZ18uxisaWIP3VhMPPPxgPyc+z9cBWGrSBQb9GEmdCP5PMPryEH797f
 XaLiLFBvHvn5ffkxCPseOMktqO30J6Yzk8bI7EKtAbKcSr3m3qRa4dR3TC9rcG8PrURy74Xx5
 Moyt90HYHOZFHnymKgp/dLoL/Wuqvc+CV9tLbKRiWE5bFSw4vnyaUs5XQgewkp6K9cxOMdHd3
 PGezdwbh4D9uEOvkjejknICPj4Ki1sVEybdF4PXmZHfRKyyqz3O+kXc8ljVuQN7VAoUbo5moQ
 BwKTe7VY9gdogKv1KcfShsV+O0zBzPCmd+pgMYDtURLgTN/h9z7X0Zt8L1lb6QcGMM+BoS739
 Zwy1MV+6pgMApZh1mJSk7cHhkGjx2eUV7IaEE5hI8Y4Gqw2M4MvpVQeJbyq+YDeW2qaib+2Ra
 wTjyDvDKSrF1tfjlRCKYqplmNlkEv96EEboRMU4g+5CtV/4FXX4PATP6lj4GIf+2UJu4Z36FY
 gtOL8ce+j5Y3y4r95UKSDymNZklyzyvp561YtdDd8N01mTnO/99rvg1jl7tjua3zkQuCBaZhG
 NfHQhg0sNn7fxBEauz6uX1uGt9yUu/fAHgKBJuixxKonGlubr3IFbxHciO+7gVZMAV7dmmTvi
 m1jW5pDbvgjyOz0v01Sr1iyK5sdlbQLCeIc8nBJS2W9c0LCxHGH1yRcxuXxB11Fn2iJAzfOcB
 0qkc+2ow0T6VP30/E0sYzofKQEIfs2rwSA3RIdz9M3Jf87/Qh5PLkjHgnQdkwrLNP9rCu6jZN
 88JgaMBJemQ/Nc7f6ETQsif3w63SAYldtP5NM/JC4Oy0rIyNgcEk7mGi+nkIPdmuQNBUI+MtF
 Pk8N9liJbJPc2orvoBiT1OazTGwM2la54iDo9gJ0I9lQnNt/KXvoCV4d9oVu700Q5xPpVA2XZ
 1TEACagpReXt87+04aGgcwXjHZYfDijWCxTYHxBz4fOmcAEQbpYOGxDR2OO1091jYUT3i+OkP
 gupwDzyiZLg7TGufqvMo6g9PZn44C+S7+KXs7iSyIbHQNdujSxni1XHmXvUyh6FO195cwDPur
 xfOA3Z92/YJ9tbE0GpPbBj/53eoU40QaZgO3CiNXs9pMbmAdIt/4UzE1R1jR+Tm5URA6eoDUV
 5rO2laldsXWXD/mKFut8l4cCtX5btGHBntdS9NsIiIAgLWI/JijjWZMwoV0waYXfvdVNfnnLf
 2c5+Sqy/H+JFQT7F5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kj0lTTYfb8ECCysYD39CDRCO81hDhtgbk
Content-Type: multipart/mixed; boundary="3Df4YASSaQNeELJoZNqOqZ16Nr9zD5Lo8"

--3Df4YASSaQNeELJoZNqOqZ16Nr9zD5Lo8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/19 =E4=B8=8B=E5=8D=8810:04, David Sterba wrote:
> On Tue, May 19, 2020 at 10:13:20AM +0800, Qu Wenruo wrote:
>> [BUG]
>> When balance is canceled, there is a pretty high chance that unmountin=
g
>> the fs can lead to lead the NULL pointer dereference:
>>
>>   BTRFS warning (device dm-3): page private not zero on page 223158272=

>>   ...
>>   BTRFS warning (device dm-3): page private not zero on page 223162368=

>>   BTRFS error (device dm-3): leaked root 18446744073709551608-304 refc=
ount 1
>>   BUG: kernel NULL pointer dereference, address: 0000000000000168
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 2 PID: 5793 Comm: umount Tainted: G           O      5.7.0-rc5-=
custom+ #53
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06=
/2015
>>   RIP: 0010:__lock_acquire+0x5dc/0x24c0
>>   Call Trace:
>>    lock_acquire+0xab/0x390
>>    _raw_spin_lock+0x39/0x80
>>    btrfs_release_extent_buffer_pages+0xd7/0x200 [btrfs]
>>    release_extent_buffer+0xb2/0x170 [btrfs]
>>    free_extent_buffer+0x66/0xb0 [btrfs]
>>    btrfs_put_root+0x8e/0x130 [btrfs]
>>    btrfs_check_leaked_roots.cold+0x5/0x5d [btrfs]
>>    btrfs_free_fs_info+0xe5/0x120 [btrfs]
>>    btrfs_kill_super+0x1f/0x30 [btrfs]
>>    deactivate_locked_super+0x3b/0x80
>>    deactivate_super+0x3e/0x50
>>    cleanup_mnt+0x109/0x160
>>    __cleanup_mnt+0x12/0x20
>>    task_work_run+0x67/0xa0
>>    exit_to_usermode_loop+0xc5/0xd0
>>    syscall_return_slowpath+0x205/0x360
>>    do_syscall_64+0x6e/0xb0
>>    entry_SYSCALL_64_after_hwframe+0x49/0xb3
>>   RIP: 0033:0x7fd028ef740b
>>
>> [CAUSE]
>> When balance is canceled, all reloc roots are marked orphan, and orpha=
n
>> reloc roots are going to be cleaned up.
>>
>> However for orphan reloc roots and merged reloc roots, their lifespan
>> are quite different:
>> 	Merged reloc roots	|	Orphan reloc roots by cancel
>> --------------------------------------------------------------------
>> create_reloc_root()		| create_reloc_root()
>> |- refs =3D=3D 1			| |- refs =3D=3D 1
>> 				|
>> btrfs_grab_root(reloc_root);	| btrfs_grab_root(reloc_root);
>> |- refs =3D=3D 2			| |- refs =3D=3D 2
>> 				|
>> root->reloc_root =3D reloc_root;	| root->reloc_root =3D reloc_root;
>> 		>>> No difference so far <<<
>> 				|
>> prepare_to_merge()		| prepare_to_merge()
>> |- btrfs_set_root_refs(item, 1);| |- if (!err) (err =3D=3D -EINTR)
>> 				|
>> merge_reloc_roots()		| merge_reloc_roots()
>> |- merge_reloc_root()		| |- Doing nothing to put reloc root
>>    |- insert_dirty_subvol()	| |- refs =3D=3D 2
>>       |- __del_reloc_root()	|
>>          |- btrfs_put_root()	|
>>             |- refs =3D=3D 1	|
>> 		>>> Now orphan reloc roots still have refs 2 <<<
>> 				|
>> clean_dirty_subvols()		| clean_dirty_subvols()
>> |- btrfs_drop_snapshot()	| |- btrfS_drop_snapshot()
>>    |- reloc_root get freed	|    |- reloc_root still has refs 2
>> 				|	related ebs get freed, but
>> 				|	reloc_root still recorded in
>> 				|	allocated_roots
>> btrfs_check_leaked_roots()	| btrfs_check_leaked_roots()
>> |- No leaked roots		| |- Leaked reloc_roots detected
>> 				| |- btrfs_put_root()
>> 				|    |- free_extent_buffer(root->node);
>> 				|       |- eb already freed, caused NULL
>> 				|	   pointer dereference
>>
>> [FIX]
>> The fix is to clear fs_root->reloc_root and put it at
>> merge_reloc_roots() time, so that we won't leak reloc roots.
>>
>> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion aft=
er merge_reloc_roots")
>=20
> Thanks. I've applied it before my cleanups (read_fs_root) but the fix
> still depends on the refcounted root trees so it's no applicable to any=

> older stable trees.
>=20
No problem, I would craft fixes for older branches.

But for that case, what's the proper tags to specify the stable kernel
ranges?

Thanks,
Qu


--3Df4YASSaQNeELJoZNqOqZ16Nr9zD5Lo8--

--Kj0lTTYfb8ECCysYD39CDRCO81hDhtgbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7EZQoACgkQwj2R86El
/qi+WAgAnbXykYomELAHDjlapZztW9w5ytLUfENqa4WhWrAFQyAMqrRbLfMLtrz8
u5yCy+GSu1lM1wNz71TfT4Z8LRJ7kDMnV1hQMmUYSPyQOWTgq4Ur6P0JNByJ4n79
C2BejaHaXtBjwSnT8hhk77ZuuVb2QfNA+i8WBPyWhvZBZ467NgcSqIOArH6nuMxk
rMrI2JvfnC1t3xCgvbmuUOW4Re7mZrtHZ+NvcWQi61yt7w8AhOMWmtargReaEO6h
qeYhZI8BO9gol92cetYnp3sQuq/iyStAcqcNdmWy/bf5kzy5Uw01yJ5gkF22syal
KB0eInv0mLIEPsv05qMMhsa0YfP1iA==
=XZXk
-----END PGP SIGNATURE-----

--Kj0lTTYfb8ECCysYD39CDRCO81hDhtgbk--
