Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF90C149251
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 01:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgAYAg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 19:36:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:39985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAYAg3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 19:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579912579;
        bh=iAvvAMJFVRBL9WGvzVXg27c3Xaokr7RehT860kP4FDk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=J47X7Fc9WsZiBVsDj+y9bJ5Mem5zA1g4rUPTu3eQAm0uFaZS//CRdwX040jfKkjfy
         CVKVaZpit1ZTHK32M8Hnxle8Ms2eiOOQ5LWgEEpmL/BjhiMMXMeYBRneoTMN54HLkd
         rsrl8EkxfzaYzJ4/ls5zmmXFiWz2LByD/0wPAfto=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1jY51U2Qc6-00eLHL; Sat, 25
 Jan 2020 01:36:19 +0100
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
To:     fdmanana@gmail.com, dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200123235820.20764-1-wqu@suse.com>
 <20200124144409.GM3929@twin.jikos.cz>
 <CAL3q7H5+pTzLM7=5gxORWi6CcPB1YGR8=8bVUWeogq8a2rno-Q@mail.gmail.com>
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
Message-ID: <a76b187d-678e-1b02-b388-2ab12b9c221c@gmx.com>
Date:   Sat, 25 Jan 2020 08:36:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5+pTzLM7=5gxORWi6CcPB1YGR8=8bVUWeogq8a2rno-Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5jlYTtCp445N4OjTsKNm4lVPWjuxLpXUh"
X-Provags-ID: V03:K1:TAuwo82qiHcDlAsZmef1UySo1AtrZTei7xNtO6w4USM8+6xTZXi
 CVlUu6bl9DtvhuEhOc8pSd2KhILTL8Oz87m9WsyNw7Jim0PjvoWmiphmLMIH0238zUXzwPH
 53RaJ7omOQvPxTfQfGFwKK+VHvhJspQaZC6BIWBaQJdNzxAONXonooFWjcR7sCTKI0fTrJ7
 4y53xtLsTMHBMOlKUE1Kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYAmjTIVBP8=:tP/mzI2dyDQ1YS2g+Sd7vw
 thCnOd5qdE2uzhUVZDQnq9TMytre6nmib50tXYlNFBgWzZRqB9w90M6UybvkG80A0SCGGFuuf
 qiIcZKRzrZq2Jbme9FWhjJuUxSdQi+7CDtn4IB0FlEnVss6qHa2OkfVUOKwp66JeB1s9BdgTB
 /7JeIrNuwhqOFAoGZJnglEC2PVHh28aD7mWlUc7chL3U3J2kBXDjyyt+qfoCLtf2B2/AwNa5x
 L1F4S+mFbFXlWxBHhfcUS66jpKqXZlvyxn6VKe/szDGED0LRivZGkJT5Ax+7heaf7Qk3C108O
 9VDYjzIg8p4DqWGL60V77wiJR6mmqiMZ6rKBnZMWAT+iDYzVaQ1xgN/25cpetsnUcyRnzxbDi
 lHGr8YYxpXFMKrrDl7WMW67IykHE3iVqd6hXqKInt9X++fAcN0zAUdaIUikIrxzaTlZizgL5D
 KmxdUTPJoWRvDttssEq7gTWIhRI4CwdMeW6K/MMIRqSDspyQzr/btjKwmkLEqsP7yBD98Q4Y9
 FGuvnhhiz/Dp0Hag7iNhPJbQQylqHWoqTmIYdmZGpiTj+nWfdIJbTi7cwLlqUWyQy49zlJozO
 yFUa7Gk5GLC6fC6UOLHnpw+nA9rkiusXHY7XQV+BRpLKX7bbFCQ7G2J+GngnaB0yCIQoehNhU
 hfS9MWEPT3lX+qtqaWmgsei2ap92ZS9nME0B3S/M6XYSaLYY0T9F/IlRy8akA/14xmauf768U
 GI9vWDbRKuDuVAzM3LvSssx1TX9okM+m2D67UBfhIX3mKUbQ1pKXpVuRhQQLBBv1ueHRpCBAI
 dklW8WzV7ZBdnQMJx4nh+qRCuffQbV2/GzX/zioL8DYxPPDg0BMmKcNQFXHADZcsDV1zf6qoK
 n7kZ78uOlyiCgzg5UdYUocIFHpIWxc6eY58gYvwZ5E5qGQw8Ft8zzIqKBtDkpLhg0fCVGkCj8
 tKaNkIMNKk3R/4EesyujsgWRJrjpqVQ44+YixIaONS6nkUFr62OZOQAQ/JL9sN23FAMTSpQMg
 OrgtoJfyoxGzy1+f7kMb7wLEwqI/ICd9N8gx6uNkoEBvE1t7/13kuWxAOM4RFtWc8W934Thyq
 Guniwk/6XbQsGX0lN3S5nJ8zCbVXkIxMcnlqHPGyPbrQYr0VYGMgcNkK/LhyPklcLF7h+E6fC
 RaqMb7O94Y5ARQat6YjZ3c5Vx7k0+B8s1J8i4bg1TtVhYKazHnCnW5bUMxRrnak58LTwPllgj
 kksIFbdhiK3p7QpnZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5jlYTtCp445N4OjTsKNm4lVPWjuxLpXUh
Content-Type: multipart/mixed; boundary="HYmE3wXafok3lIseZmbE6o620KuPGk4K9"

--HYmE3wXafok3lIseZmbE6o620KuPGk4K9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/25 =E4=B8=8A=E5=8D=8812:28, Filipe Manana wrote:
> On Fri, Jan 24, 2020 at 3:12 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On current master branch (4703d9119972bf58) with this patch btrfs/011
>> prints a warning from this code:
>>
>>  502         ret =3D btrfs_dev_replace_finishing(fs_info, ret);
>>  503         if (ret =3D=3D -EINPROGRESS) {
>>  504                 ret =3D BTRFS_IOCTL_DEV_REPLACE_RESULT_SCRUB_INPR=
OGRESS;
>>  505         } else if (ret !=3D -ECANCELED) {
>>  506                 WARN_ON(ret);
>>  507         }
>>
>> with ret =3D=3D -ENOSPC
>>
>> The purpose seems to be to catch generic error codes other than
>> EINPROGRESS and ECNACELED, I don't see much point printing a warning i=
n
>> that case. But it' a new ENOSPC problem, likely caused by the
>> read-only status switching.
>>
>> My test devices are 12G, there's full log of the test to see at which
>> phase it happened.
>=20
> It passes for me on 20G devices, haven't tested with 12G however
> (can't afford to reboot any of my vms now).

5G for all scratch devices, and failed to reproduce it.
(The full run before submitting the patch also failed to reproduce it)

>=20
> I think that happens because before this patch we ignored ENOSPC
> errors, when trying to set a block group to RO, for device replace and
> scrub.
> But with this patch we don't ignore ENOSPC for device replace anymore
> - this is actually correct because if we ignore we can corrupt nocow
> writes (including writes into prealloc extents).
>=20
> Now if it's a real ENOSPC situation or just a bug in the space
> management code, it's a different thing to look at.

I tend to take a middle land of the problem.

For current stage, the WARN_ON() is indeed overkilled, at least for ENOSP=
C.

But on the other handle, the full RO of a block group for scrub/replace
is also a little overkilled.
Just as Filipe mentioned, we only want to kill nocow writes into a block
group, but still allow COW writes.

It looks like something like mark_block_group_nocow_ro() in the future
could reduce the possibility if not fully kill it.


It looks like changing the WARN_ON(ret) to WARN_ON(ret !=3D -ENOSPC) woul=
d
be needed for this patch as a quick fix.

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> [ 1891.998975] BTRFS warning (device vdd): failed setting block group =
ro: -28
>> [ 1892.038338] BTRFS error (device vdd): btrfs_scrub_dev(/dev/vdd, 1, =
/dev/vdb) failed -28
>> [ 1892.059993] ------------[ cut here ]------------
>> [ 1892.063032] WARNING: CPU: 2 PID: 2244 at fs/btrfs/dev-replace.c:506=
 btrfs_dev_replace_start.cold+0xf9/0x140 [btrfs]
>> [ 1892.068628] Modules linked in: xxhash_generic btrfs blake2b_generic=
 libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_comp=
ress lzo_decompress raid6_pq loop
>> [ 1892.074346] CPU: 2 PID: 2244 Comm: btrfs Not tainted 5.5.0-rc7-defa=
ult+ #942
>> [ 1892.076559] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> [ 1892.079956] RIP: 0010:btrfs_dev_replace_start.cold+0xf9/0x140 [btrf=
s]
>> [ 1892.096576] RSP: 0018:ffffbb58c7b3fd10 EFLAGS: 00010286
>> [ 1892.098311] RAX: 00000000ffffffe4 RBX: 0000000000000001 RCX: 888888=
8888888889
>> [ 1892.100342] RDX: 0000000000000001 RSI: ffff9e889645f5d8 RDI: ffffff=
ff92821080
>> [ 1892.102291] RBP: ffff9e889645c000 R08: 000001b8878fe1f6 R09: 000000=
0000000000
>> [ 1892.104239] R10: ffffbb58c7b3fd08 R11: 0000000000000000 R12: ffff9e=
88a0017000
>> [ 1892.106434] R13: ffff9e889645f608 R14: ffff9e88794e1000 R15: ffff9e=
88a07b5200
>> [ 1892.108642] FS:  00007fcaed3f18c0(0000) GS:ffff9e88bda00000(0000) k=
nlGS:0000000000000000
>> [ 1892.111558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1892.113492] CR2: 00007f52509ff420 CR3: 00000000603dd002 CR4: 000000=
0000160ee0
>> [ 1892.115814] Call Trace:
>> [ 1892.116896]  btrfs_dev_replace_by_ioctl+0x35/0x60 [btrfs]
>> [ 1892.118962]  btrfs_ioctl+0x1d62/0x2550 [btrfs]
>> [ 1892.120633]  ? __lock_acquire+0x272/0x1320
>> [ 1892.122177]  ? kvm_sched_clock_read+0x14/0x30
>> [ 1892.123629]  ? do_sigaction+0xf8/0x240
>> [ 1892.124919]  ? kvm_sched_clock_read+0x14/0x30
>> [ 1892.126418]  ? sched_clock+0x5/0x10
>> [ 1892.127534]  ? sched_clock_cpu+0x10/0x120
>> [ 1892.129096]  ? do_sigaction+0xf8/0x240
>> [ 1892.130525]  ? do_vfs_ioctl+0x56e/0x770
>> [ 1892.131818]  do_vfs_ioctl+0x56e/0x770
>> [ 1892.133012]  ? do_sigaction+0xf8/0x240
>> [ 1892.134228]  ksys_ioctl+0x3a/0x70
>> [ 1892.135447]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>> [ 1892.137148]  __x64_sys_ioctl+0x16/0x20
>> [ 1892.138702]  do_syscall_64+0x50/0x210
>> [ 1892.140095]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [ 1892.141911] RIP: 0033:0x7fcaed61e387
>> [ 1892.149247] RSP: 002b:00007ffcb47fc2f8 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000010
>> [ 1892.151839] RAX: ffffffffffffffda RBX: 00007ffcb47ff12d RCX: 00007f=
caed61e387
>> [ 1892.154060] RDX: 00007ffcb47fd160 RSI: 00000000ca289435 RDI: 000000=
0000000003
>> [ 1892.156191] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000=
0000000000
>> [ 1892.158317] R10: 0000000000000008 R11: 0000000000000246 R12: 000000=
0000000003
>> [ 1892.160564] R13: 0000000000000001 R14: 0000000000000000 R15: 000056=
24ff1602e0
>> [ 1892.162736] irq event stamp: 244626
>> [ 1892.164191] hardirqs last  enabled at (244625): [<ffffffff9178860e>=
] _raw_spin_unlock_irqrestore+0x3e/0x50
>> [ 1892.167531] hardirqs last disabled at (244626): [<ffffffff91002aeb>=
] trace_hardirqs_off_thunk+0x1a/0x1c
>> [ 1892.170875] softirqs last  enabled at (244482): [<ffffffff91a00358>=
] __do_softirq+0x358/0x52b
>> [ 1892.174005] softirqs last disabled at (244471): [<ffffffff9108ac1d>=
] irq_exit+0x9d/0xb0
>> [ 1892.176555] ---[ end trace d72b653b61eb7d20 ]---
>> [failed, exit status 1] [14:22:59]- output mismatch (see /tmp/fstests/=
results//btrfs/011.out.bad)
>>     --- tests/btrfs/011.out     2018-04-12 16:57:00.608225550 +0000
>>     +++ /tmp/fstests/results//btrfs/011.out.bad 2020-01-24 14:22:59.24=
8000000 +0000
>>     @@ -1,3 +1,4 @@
>>      QA output created by 011
>>      *** test btrfs replace
>>     -*** done
>>     +failed: '/sbin/btrfs replace start -Bf -r /dev/vdd /dev/vdb /tmp/=
scratch'
>>     +(see /tmp/fstests/results//btrfs/011.full for details)
>>     ...
>>     (Run 'diff -u /tmp/fstests/tests/btrfs/011.out /tmp/fstests/result=
s//btrfs/011.out.bad'  to see the entire diff)
>>
>> btrfs/011               [13:59:50][  504.570047] run fstests btrfs/011=
 at 2020-01-24 13:59:50
>> [  505.710501] BTRFS: device fsid cd48459b-2332-425b-9d4e-324021eb0f2a=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (20824)
>> [  505.740305] BTRFS info (device vdb): turning on discard
>> [  505.742954] BTRFS info (device vdb): disk space caching is enabled
>> [  505.745007] BTRFS info (device vdb): has skinny extents
>> [  505.747096] BTRFS info (device vdb): flagging fs with big metadata =
feature
>> [  505.755093] BTRFS info (device vdb): checking UUID tree
>> [  521.548385] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc started
>> [  525.294200] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc finished
>> [  526.798086] BTRFS info (device vdb): scrub: started on devid 1
>> [  528.104425] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  528.393736] BTRFS info (device vdc): turning on discard
>> [  528.396009] BTRFS info (device vdc): disk space caching is enabled
>> [  528.398144] BTRFS info (device vdc): has skinny extents
>> [  528.597381] BTRFS: device fsid 20fd7216-ce75-4761-bb61-a5819aef05b6=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (27027)
>> [  528.626562] BTRFS info (device vdb): turning on discard
>> [  528.629852] BTRFS info (device vdb): disk space caching is enabled
>> [  528.633442] BTRFS info (device vdb): has skinny extents
>> [  528.640914] BTRFS info (device vdb): checking UUID tree
>> [  548.785255] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc started
>> [  551.256550] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc finished
>> [  557.620409] BTRFS info (device vdb): scrub: started on devid 1
>> [  559.258036] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  559.646237] BTRFS info (device vdc): turning on discard
>> [  559.649237] BTRFS info (device vdc): disk space caching is enabled
>> [  559.652122] BTRFS info (device vdc): has skinny extents
>> [  561.076431] BTRFS: device fsid e8c0f848-fd83-4401-95ff-503d3bba3c08=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (750)
>> [  561.103870] BTRFS info (device vdb): turning on discard
>> [  561.106896] BTRFS info (device vdb): disk space caching is enabled
>> [  561.110432] BTRFS info (device vdb): has skinny extents
>> [  561.113446] BTRFS info (device vdb): flagging fs with big metadata =
feature
>> [  561.121762] BTRFS info (device vdb): checking UUID tree
>> [  576.690406] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc started
>> [  581.249317] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc finished
>> [  584.252317] BTRFS info (device vdb): scrub: started on devid 1
>> [  585.192576] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  586.225905] BTRFS info (device vdc): turning on discard
>> [  586.229054] BTRFS info (device vdc): disk space caching is enabled
>> [  586.231819] BTRFS info (device vdc): has skinny extents
>> [  586.599308] BTRFS: device fsid dd789d35-4d2f-428c-aa03-88ffd5a734cb=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (6931)
>> [  586.628325] BTRFS info (device vdb): turning on discard
>> [  586.630954] BTRFS info (device vdb): disk space caching is enabled
>> [  586.634146] BTRFS info (device vdb): has skinny extents
>> [  586.636859] BTRFS info (device vdb): flagging fs with big metadata =
feature
>> [  586.645020] BTRFS info (device vdb): checking UUID tree
>> [  608.342513] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc started
>> [  611.869495] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc canceled
>> [  646.226962] BTRFS info (device vdb): scrub: started on devid 1
>> [  652.537808] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  654.148332] BTRFS info (device vdb): turning on discard
>> [  654.152563] BTRFS info (device vdb): disk space caching is enabled
>> [  654.157499] BTRFS info (device vdb): has skinny extents
>> [  655.318709] BTRFS: device fsid cc2a56c5-5371-4b14-88af-527515683491=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (14080)
>> [  655.341656] BTRFS info (device vdb): turning on discard
>> [  655.344075] BTRFS info (device vdb): disk space caching is enabled
>> [  655.346723] BTRFS info (device vdb): has skinny extents
>> [  655.355368] BTRFS info (device vdb): checking UUID tree
>> [  688.140556] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc started
>> [  696.723022] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdc finished
>> [  707.940962] BTRFS info (device vdb): scrub: started on devid 1
>> [  711.456414] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  719.263299] BTRFS info (device vdc): turning on discard
>> [  719.266339] BTRFS info (device vdc): disk space caching is enabled
>> [  719.269694] BTRFS info (device vdc): has skinny extents
>> [  722.816437] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (20268)
>> [  722.821079] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046=
 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (20268)
>> [  722.821079] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046=
 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (20268)
>> [  722.850081] BTRFS info (device vdb): turning on discard
>> [  722.853321] BTRFS info (device vdb): disk space caching is enabled
>> [  722.855710] BTRFS info (device vdb): has skinny extents
>> [  722.857894] BTRFS info (device vdb): flagging fs with big metadata =
feature
>> [  722.866879] BTRFS info (device vdb): checking UUID tree
>> [  738.622392] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdd started
>> [  739.728325] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdd finished
>> [  740.017266] BTRFS info (device vdb): scrub: started on devid 1
>> [  740.017277] BTRFS info (device vdb): scrub: started on devid 2
>> [  740.714789] BTRFS info (device vdb): scrub: finished on devid 2 wit=
h status: 0
>> [  740.714965] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [  741.234158] BTRFS info (device vdd): turning on discard
>> [  741.237294] BTRFS info (device vdd): disk space caching is enabled
>> [  741.240088] BTRFS info (device vdd): has skinny extents
>> [  741.485130] BTRFS: device fsid ad5bec99-e695-4960-b622-18a890a2a566=
 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (26509)
>> [  741.489012] BTRFS: device fsid ad5bec99-e695-4960-b622-18a890a2a566=
 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (26509)
>> [  741.517997] BTRFS info (device vdb): turning on discard
>> [  741.522388] BTRFS info (device vdb): disk space caching is enabled
>> [  741.527084] BTRFS info (device vdb): has skinny extents
>> [  741.528865] BTRFS info (device vdb): flagging fs with big metadata =
feature
>> [  741.536809] BTRFS info (device vdb): checking UUID tree
>> [  803.614447] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdd started
>> [ 1561.888757] BTRFS info (device vdb): dev_replace from /dev/vdb (dev=
id 1) to /dev/vdd finished
>> [ 1563.133038] BTRFS info (device vdb): scrub: started on devid 2
>> [ 1563.133043] BTRFS info (device vdb): scrub: started on devid 1
>> [ 1851.421233] BTRFS info (device vdb): scrub: finished on devid 2 wit=
h status: 0
>> [ 1857.639294] BTRFS info (device vdb): scrub: finished on devid 1 wit=
h status: 0
>> [ 1869.454605] BTRFS info (device vdd): turning on discard
>> [ 1869.458972] BTRFS info (device vdd): disk space caching is enabled
>> [ 1869.461062] BTRFS info (device vdd): has skinny extents
>> [ 1891.972499] BTRFS info (device vdd): dev_replace from /dev/vdd (dev=
id 1) to /dev/vdb started
>> [ 1891.998975] BTRFS warning (device vdd): failed setting block group =
ro: -28
>> [ 1892.038338] BTRFS error (device vdd): btrfs_scrub_dev(/dev/vdd, 1, =
/dev/vdb) failed -28
>> (stacktrace)
>=20
>=20
>=20


--HYmE3wXafok3lIseZmbE6o620KuPGk4K9--

--5jlYTtCp445N4OjTsKNm4lVPWjuxLpXUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4rjX4ACgkQwj2R86El
/qjnDwf/TDe+xdQ2ZoQl5LxptLur5qdJUcIX18unhNm/qRwtDeBRR/x9xblWk0hS
X0D9Z8S3F7iuOiBn2kRsBoy+g/PSU8a0FijYWnxEUFWhX4cY2EmzUGD6ilX79knh
jYZCyieKaE7g5DGKeeZDzRYeRzV7Nx33vZYv7+sLCdIWTYtd5/Lrz6VsJDxKaaOg
b6MWmBhnZBPXFRBH0DHiSgoEbcuOo7F0BTZG8GWRrhgEvLC4DTY5UF7F4j0Qnbkf
28HcMiDyKmM+213rVHWVH18WkvTiJr8CeYJ/Hf5CiiD5pX3J1KlwqFtrM/fqz6mo
F32bXCF29ujC03K5qD9wHHEoB4ilzA==
=t5ul
-----END PGP SIGNATURE-----

--5jlYTtCp445N4OjTsKNm4lVPWjuxLpXUh--
