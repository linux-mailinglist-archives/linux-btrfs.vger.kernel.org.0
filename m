Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E320B0AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFZLkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 07:40:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:47633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFZLkV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593171616;
        bh=6jczb5XjX6DOWuBVD1ThSPqgPT3MgPunrKTNZUMdXxw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CoZVJlussmGXsXR1ecmNtVd7JPG5NY2w+IxWNSMcN8bclpCnu4n1paQ1qS1LHODHr
         jprt2s2ISkU7kHZdBoE/sKpeFMpkSST/m8q5xwoBQZIz5RGd64u7htCd+9CTjFbbrz
         1yk/1ws+d6y1mvsu6hwFv8+YzwDxCVjjqmzVSm1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVN6j-1jNWQq1ndv-00SLfl; Fri, 26
 Jun 2020 13:40:16 +0200
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200626104628.GB27795@twin.jikos.cz>
 <8e086b89-b76e-7441-494c-ec33cf133959@gmx.com>
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
Message-ID: <1c2b33c3-3f39-94e3-16ca-2098dd107338@gmx.com>
Date:   Fri, 26 Jun 2020 19:40:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8e086b89-b76e-7441-494c-ec33cf133959@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GQaJjMEJvQgxcP2d1cYJ9Xt90lgFjMX2C"
X-Provags-ID: V03:K1:CCt4oO+1h9GUJme6WCthVi5Au4ZAmkVs1xy4ObzHh/5q2es5gHo
 DA7+pJ7k5pEdCE696o4VH0eaBcIbP9eu67dh10JUPB9Nw1e0AQeFNnzQsgDu4Iq6PaXjIcN
 yPbCALbfAUShFpOY7uTDPFyCBCfRwugXbC8/DRB4r2AuIRrPbM8z+Sbg/PT/ZpM2K+2jiEm
 bxjPqIGcpsC12fVtj4ThA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nOiWvkergv4=:oFXjMt4WSXdYGGcG29e5ND
 7dwJgVBrOuAlNzXvWu6oZqjwTgnJ3y5jZE/F6wVJ2mcXH5FTAhxlDEaoYCXGjv3W6Y++h6FmE
 ybLvUsAMP2/E/cplAsNShSscalUwymImMdF5YHv6cBT01gtFMBz05dSLPS48nj3Dgi6h210UD
 QMJcwagXAFhWwANM6xCNBy69yfIMj2jCyxy8/PixjpeuUGTkPFALfV4WtVkm4jZH6aIGjwQUV
 wRGRg1TikMeCXsfyvu54NXqQ5NJNTHaQlvHVICID/lr8KP0esMoLDcoHKGAXEeWF/zy5OkIR/
 Wvz25UsHlfqG/MTubSzd4arV7v11daQAOdR+bUkjLjl1wdaVa9+8w0qe5EKoeMpDe8tO+19Wu
 ozsgMHlOPl27CqQd3RICqP1hGF8yePDTcEV4Hv32iXBg6kuHyC94ZoBe/RYwdZ8MADewiQctA
 TSIKDqgfp7apmBRNIIz4NOdexsmPNFgONsfYW7eQp8iqBhrkJ0gvuq8zOY/bAYJXoKB+st2MX
 28Mg68yAbhnBYS7deFjCsPkv7H7pW+VhLGfpcOnfkx2dOo6SyhvfZIKq+9PluoySFxofCsBJo
 4OWk2QCSF2O676t5/NsG9YQTXxJ2gYoGS7Dhsim9qj6ho1HkbBPXi9xn6Q+WN8TeurPgV/ssJ
 AjNw4g2LXXXM5DUJ7409mDEwJSSuGvHIotqbjuRuXmIUCLTf6gxyQxenRPwZYnAnq3NmTZL7t
 4A1I5Tfp7XRajF9eFQv4VP9kg/e23eQJgkCUldltl1LIVHQuQbFZ6aGzJNceynQvHo6uWnQW5
 kAPpir7GhpwhMmUeU9b+JdCzlYhUaXh9XzjFZ3v3v8tqKmku3jKuvQyJcg4vpjSRBNcAgYHUv
 9nNTQdE0blmk1QPReRAYwLiz0Agh2Zsy8Ky6TKpPjtkC3RE8ANrjuDat54vNw79ukhkmhmeHE
 gH7cLZ7FmHgx9P3P2eyHEMsSwZZR/9K7gwPIDI0+11btYjjI/C4OK2k0iYDTKgCZxrcwc8kxn
 6kN6MPO/OgticQQBu4t5Z5oJVKSlcDVIIXD9sIxkAcXHli8MjXcJBu8SpI9wz26qbZ7q8Q9cW
 eOhKLu97/DJV08daAAvH137TrQe/01Sh22QcaPNaluahf4xF7Oc6EpG3lXredGIWdg5SMnuz6
 qFCPJ8FBw1UH1lFvKzwoVa5wOowz959r7OmfQuA8b7Pxw+3/e5L0Rj0+PiHSHpL+6KckNH5Ds
 Ggwr3+cuimYvzwng/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GQaJjMEJvQgxcP2d1cYJ9Xt90lgFjMX2C
Content-Type: multipart/mixed; boundary="xywIIlwYs7Rp0jEio2dI1IRT66ppLYEdU"

--xywIIlwYs7Rp0jEio2dI1IRT66ppLYEdU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/26 =E4=B8=8B=E5=8D=887:09, Qu Wenruo wrote:
>=20
>=20
> On 2020/6/26 =E4=B8=8B=E5=8D=886:46, David Sterba wrote:
>> It does not pass even the self tests and qgroup creation:
>=20
> Very strange, as it passed my local tests.
>=20
>>
>> [   26.275106] Btrfs loaded, crc32c=3Dcrc32c-intel, debug=3Don, integr=
ity-checker=3Don, ref-verify=3Don
>> [   26.278075] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
>> [   26.279861] BTRFS: selftest: running btrfs free space cache tests
>> [   26.281735] BTRFS: selftest: running extent only tests
>> [   26.283317] BTRFS: selftest: running bitmap only tests
>> [   26.284966] BTRFS: selftest: running bitmap and extent tests
>> [   26.286842] BTRFS: selftest: running space stealing from bitmap to =
extent tests
>> [   26.289587] BTRFS: selftest: running extent buffer operation tests
>> [   26.291507] BTRFS: selftest: running btrfs_split_item tests
>> [   26.293401] BTRFS: selftest: running extent I/O tests
>> [   26.295059] BTRFS: selftest: running find delalloc tests
>> [   26.475777] BTRFS: selftest: running find_first_clear_extent_bit te=
st
>> [   26.477812] BTRFS: selftest: running extent buffer bitmap tests
>> [   26.499493] BTRFS: selftest: running inode tests
>> [   26.501164] BTRFS: selftest: running btrfs_get_extent tests
>> [   26.503599] BTRFS: selftest: running hole first btrfs_get_extent te=
st
>> [   26.505971] BTRFS: selftest: running outstanding_extents tests
>> [   26.508136] BTRFS: selftest: running qgroup tests
>> [   26.509820] BTRFS: selftest: running qgroup add/remove tests
>> [   26.511566] BUG: sleeping function called from invalid context at m=
m/slab.h:567
>> [   26.514058] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: =
117, name: modprobe
>> [   26.516671] 2 locks held by modprobe/117:
>> [   26.517980]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.+=
=2E}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
>> [   26.521114]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2:=
2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
>> [   26.524120] CPU: 1 PID: 117 Comm: modprobe Not tainted 5.8.0-rc2-de=
fault+ #1154
>> [   26.526439] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> [   26.529612] Call Trace:
>> [   26.530731]  dump_stack+0x78/0xa0
>> [   26.531983]  ___might_sleep.cold+0xa6/0xf9
>> [   26.533290]  ? kobject_set_name_vargs+0x1e/0x90
>> [   26.534674]  __kmalloc_track_caller+0x143/0x340
>> [   26.536122]  kvasprintf+0x64/0xc0
>=20
> But according to the call trace, it's indeed allocating the memory.
>=20
> And my test machine has lockdep enabled, not sure why this is not worki=
ng.

Damn it, my previous tests triggered something during selftest and
disabled lockdep during development, that's why it never triggered
lockdep warning.

And after that happening, never rebooted the VM kernel.

Would learn to reboot before doing final test...

Thanks,
Qu
>=20
> But thanks anyway for the report,
> Qu
>=20
>> [   26.537257]  kobject_set_name_vargs+0x1e/0x90
>> [   26.538588]  kobject_init_and_add+0x5d/0xa0
>> [   26.539878]  ? lockdep_init_map_waits+0x4d/0x200
>> [   26.541398]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
>> [   26.543146]  add_qgroup_rb+0xb0/0x140 [btrfs]
>> [   26.544556]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
>> [   26.546006]  test_no_shared_qgroup.isra.0+0x66/0x2b0 [btrfs]
>> [   26.547583]  btrfs_test_qgroups+0x1da/0x220 [btrfs]
>> [   26.549015]  btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>> [   26.550759]  ? 0xffffffffc0518000
>> [   26.551911]  init_btrfs_fs+0xf1/0x159 [btrfs]
>> [   26.553306]  do_one_initcall+0x63/0x320
>> [   26.554609]  ? rcu_read_lock_sched_held+0x5d/0x90
>> [   26.564925]  ? do_init_module+0x23/0x220
>> [   26.566180]  ? kmem_cache_alloc_trace+0x17b/0x2f0
>> [   26.567721]  do_init_module+0x5c/0x220
>> [   26.568978]  load_module+0xed8/0x1490
>> [   26.570252]  ? __do_sys_finit_module+0xbf/0xe0
>> [   26.571618]  __do_sys_finit_module+0xbf/0xe0
>> [   26.572955]  do_syscall_64+0x50/0xe0
>> [   26.574221]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   26.575812] RIP: 0033:0x7fc269fa6649
>> [   26.577191] Code: Bad RIP value.
>> [   26.578341] RSP: 002b:00007ffffdc63a88 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000139
>> [   26.580890] RAX: ffffffffffffffda RBX: 000055c8d63eba50 RCX: 00007f=
c269fa6649
>> [   26.582850] RDX: 0000000000000000 RSI: 000055c8d63c49d2 RDI: 000000=
000000000a
>> [   26.584887] RBP: 0000000000040000 R08: 0000000000000000 R09: 000055=
c8d63eedf0
>> [   26.586923] R10: 000000000000000a R11: 0000000000000246 R12: 000055=
c8d63c49d2
>> [   26.589341] R13: 000055c8d63e6f10 R14: 0000000000000000 R15: 000055=
c8d63ee530
>> [   26.591720]
>> [   26.592542] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   26.593931] [ BUG: Invalid wait context ]
>> [   26.595453] 5.8.0-rc2-default+ #1154 Tainted: G        W
>> [   26.597191] -----------------------------
>> [   26.598478] modprobe/117 is trying to lock:
>> [   26.599887] ffffffff8a11e370 (kernfs_mutex){+.+.}-{3:3}, at: kernfs=
_add_one+0x23/0x150
>> [   26.602366] other info that might help us debug this:
>> [   26.604184] context-{4:4}
>> [   26.605379] 2 locks held by modprobe/117:
>> [   26.606868]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.+=
=2E}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
>> [   26.610376]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2:=
2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
>> [   26.613764] stack backtrace:
>> [   26.615038] CPU: 1 PID: 117 Comm: modprobe Tainted: G        W     =
    5.8.0-rc2-default+ #1154
>> [   26.618100] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> [   26.621610] Call Trace:
>> [   26.622731]  dump_stack+0x78/0xa0
>> [   26.624089]  __lock_acquire.cold+0xa0/0x16c
>> [   26.625593]  lock_acquire+0xa3/0x440
>> [   26.626951]  ? kernfs_add_one+0x23/0x150
>> [   26.628531]  __mutex_lock+0xa0/0xaf0
>> [   26.629958]  ? kernfs_add_one+0x23/0x150
>> [   26.631496]  ? kernfs_add_one+0x23/0x150
>> [   26.633669]  ? kernfs_add_one+0x23/0x150
>> [   26.635813]  kernfs_add_one+0x23/0x150
>> [   26.637438]  kernfs_create_dir_ns+0x58/0x80
>> [   26.638987]  sysfs_create_dir_ns+0x70/0xd0
>> [   26.640328]  ? rcu_read_lock_sched_held+0x5d/0x90
>> [   26.641799]  kobject_add_internal+0xbb/0x2d0
>> [   26.643162]  kobject_init_and_add+0x71/0xa0
>> [   26.644452]  ? lockdep_init_map_waits+0x4d/0x200
>> [   26.645889]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
>> [   26.647602]  add_qgroup_rb+0xb0/0x140 [btrfs]
>> [   26.649053]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
>> [   26.650521]  test_no_shared_qgroup.isra.0+0x66/0x2b0 [btrfs]
>> [   26.652225]  btrfs_test_qgroups+0x1da/0x220 [btrfs]
>> [   26.653787]  btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
>> [   26.655338]  ? 0xffffffffc0518000
>> [   26.656510]  init_btrfs_fs+0xf1/0x159 [btrfs]
>> [   26.657905]  do_one_initcall+0x63/0x320
>> [   26.659167]  ? rcu_read_lock_sched_held+0x5d/0x90
>> [   26.660563]  ? do_init_module+0x23/0x220
>> [   26.661841]  ? kmem_cache_alloc_trace+0x17b/0x2f0
>> [   26.663226]  do_init_module+0x5c/0x220
>> [   26.664428]  load_module+0xed8/0x1490
>> [   26.665607]  ? __do_sys_finit_module+0xbf/0xe0
>> [   26.666952]  __do_sys_finit_module+0xbf/0xe0
>> [   26.668253]  do_syscall_64+0x50/0xe0
>> [   26.669422]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   26.670981] RIP: 0033:0x7fc269fa6649
>>
>> And creating a qgoup fires the same warning:
>>
>> [  145.501257] BUG: sleeping function called from invalid context at m=
m/slab.h:567
>> [  145.506681] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: =
152, name: btrfs
>> [  145.521473] INFO: lockdep is turned off.
>> [  145.523000] CPU: 2 PID: 152 Comm: btrfs Tainted: G        W        =
 5.8.0-rc2-default+ #1154
>> [  145.526231] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> [  145.530130] Call Trace:
>> [  145.531296]  dump_stack+0x78/0xa0
>> [  145.532703]  ___might_sleep.cold+0xa6/0xf9
>> [  145.534287]  ? kobject_set_name_vargs+0x1e/0x90
>> [  145.536066]  __kmalloc_track_caller+0x143/0x340
>> [  145.537824]  kvasprintf+0x64/0xc0
>> [  145.539157]  kobject_set_name_vargs+0x1e/0x90
>> [  145.540769]  kobject_init_and_add+0x5d/0xa0
>> [  145.542348]  ? lockdep_init_map_waits+0x4d/0x200
>> [  145.544092]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
>> [  145.545966]  add_qgroup_rb+0xb0/0x140 [btrfs]
>> [  145.547654]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
>> [  145.549266]  btrfs_ioctl+0x17bd/0x2540 [btrfs]
>> [  145.550739]  ? handle_mm_fault+0x732/0xa30
>> [  145.552305]  ? up_read+0x18/0x240
>> [  145.553623]  ? ksys_ioctl+0x68/0xa0
>> [  145.555029]  ksys_ioctl+0x68/0xa0
>> [  145.556451]  __x64_sys_ioctl+0x16/0x20
>> [  145.557898]  do_syscall_64+0x50/0xe0
>> [  145.559206]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  145.560785] RIP: 0033:0x7f13619797b7
>> [  145.562035] Code: Bad RIP value.
>> [  145.563248] RSP: 002b:00007fff11e80428 EFLAGS: 00000206 ORIG_RAX: 0=
000000000000010
>> [  145.566129] RAX: ffffffffffffffda RBX: 00007fff11e805e8 RCX: 00007f=
13619797b7
>> [  145.568255] RDX: 00007fff11e80440 RSI: 000000004010942a RDI: 000000=
0000000003
>> [  145.570208] RBP: 0000000000000001 R08: 000055cc5da232a0 R09: 00007f=
1361a43a40
>> [  145.572201] R10: fffffffffffff486 R11: 0000000000000206 R12: 00007f=
ff11e80440
>> [  145.574242] R13: 0000000000000003 R14: 0000000000000000 R15: 000055=
cc5d9d31ac
>>
>=20


--xywIIlwYs7Rp0jEio2dI1IRT66ppLYEdU--

--GQaJjMEJvQgxcP2d1cYJ9Xt90lgFjMX2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl713pwACgkQwj2R86El
/qh9/wf9FC/Iw6cQGK4wWRcrjBFWYdDlBSX92nFkVzbXbTL34etMrcsIkXJFbGfs
u7WihkxyotXQ6/0dxrQQofe5nMs8oQISabCXM7b0jqdCVUBWQj9nxHHmkDt/FBS7
S75xPMwkbox5lW/DREfcRTdBc1ub9jF2oslFcaZNLBl9f5QcJGdACAM/vhGWxfvH
nE3oKxAtj0SNe3SS7bYU9sdx+q5NP/xKli4xq2CZUvXq8fC6OuAUlCLr9sK02XdS
LB4BtC5cZgqe8uqFLTrW+9YvkTPu73b72ezrxmiNm6an40JbFc/SCCtUCb1ygsal
eEuAgkrdjtgxdkS2RAxZ4PoXQpgbOw==
=9uPx
-----END PGP SIGNATURE-----

--GQaJjMEJvQgxcP2d1cYJ9Xt90lgFjMX2C--
