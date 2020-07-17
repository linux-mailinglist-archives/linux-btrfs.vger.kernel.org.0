Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3604224714
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 01:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGQXih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 19:38:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:49585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgGQXig (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 19:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595029111;
        bh=aJ1HCpoe69lYzTpI4HRJ7HFliTI64quYeKWaU8m3I/M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DoBxHSKa/G7cXXxt4R7qUKCxK1b8hDHhe10vs+TkweVc3ldexEuESOr9LN93gmA+8
         zDw8JCQhagOSeNMlzXkEMmnsTjYlmSTlqxBkb65hRiLK9oWe6B5A0yiWt45eHr/PHi
         hRipDRYH58wnePeukNbZWJjbclLcUqInqkPC6Duo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1kVMWK2QsM-00ZuDJ; Sat, 18
 Jul 2020 01:38:31 +0200
Subject: Re: [PATCH v2] btrfs: qgroup: Fix data leakage caused by race between
 writeback and truncate
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200717071205.26027-1-wqu@suse.com>
 <9b03ca60-e56f-442c-7558-3ca1b2b1df77@toxicpanda.com>
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
Message-ID: <dcc47e7f-53e0-e832-0e39-e8c1d82e318e@gmx.com>
Date:   Sat, 18 Jul 2020 07:38:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9b03ca60-e56f-442c-7558-3ca1b2b1df77@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="msiJ0Z0O4oaAlHjb7CfsmtUP37tO2AHj7"
X-Provags-ID: V03:K1:wvmFOJqdh1tu4gAUn/ed7aH2+bkH5JS7suXWfIpNoaWGeLhsnTp
 vFdRZ/7GVgA/QcDJmEJ9h7hEOfDZu5cNxw0JhHn8/3Ob36pgX8/m1SakZS4hdV2Z3qLOe9K
 ZvduPonIgyhXP8SsHSWz/ca2p9BbsD8CZRa6mgSqW5PtipDqfVt2O1UGz41cBNUATZmRqPg
 d3cJeleePKT6QnHeUU/9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qbo7hwRO8AU=:M5cRQSYdoDPgj43Dt25CDE
 HMDVy48ACto5ZGz7/+58onjNy+sOZCfJptd9my1yEcAoBakPUZblOGf88nvvdtBZF6+m+8FYX
 oR5wS1unVDx1PXddEtFyYr8TauJodjU0z3nptNluMjhfTw4Wcu9tZGRNDTYOa3HeNCbVPTu93
 3xISe0RKt0w47waPDHWavNmSD/6ST4J9LofWhydiFRaUGvvWBsxUVvhhgGn9gA7bAVvSb/3cQ
 2s4fEQhQnjn2BRJ8DPnli+MquPx+fhA9q3VfP15HlzkKc+77aOFvAzVV61AvUqIwPf0TWRIkE
 L5Kx16WeaPfBcXS0vEF25I/vDGE4MWDi+YhUF+nFY89tOwbEIoMQhdp7o+lgqH/qbvFInjAQn
 g/+LFVMMm/+o077VT+Ei6I57Ph8vDTbCLK2gd0GNJSmCuv1VzwyMhVPk0jSnu0BnUiV7P4fBg
 aFPg8nQudBRVl5tG/xDWBkrehMNeryIkGM86B93F36AXlrLCKRQ6GJf0/WgJGZ4aqQenDGU3Y
 gIo744VuMXogVUroM0DzD1NqSeskHQisy7VI6zszx8+bQopovV5HjMynCrq/eR0Wmly6PBld9
 rYaLTYKcs3CU7+7whueTdhpHX0YvNb5zPF6M58bwkRrA0ome4gU/sSPRJK8c8gXF9McXvZORU
 1gnX4koyWRAblyVuLnv3LR86bnPYdoKEHdoUDFYJeqR9onJFtMBnn9qGjM8/Y7Pyot8r7MCHo
 YP1Y6iaaFhx17IljhC639fwpLBzqM5AIPQwfXOjZjNl8I6AR+trsLnkFSYKC2E4O678VO7Oyd
 VFYjp78UAj5jzJo5PcYrTUZpD60aj4lwhwhW1alQxzzBsVtUN1acdoQBWuTEXNmoV4rraE8tj
 CDWfNwrLbz0YN//PAjLaV/OUsv0yEzZ1YPixx/9ddf1LTgdadvzl5r8OK+58jkcuGN64PhF4p
 a1WR0R5Gluz5bCT0lIaKec4VptlWKsV+wfWdm1Wr66bRknD0sZjMOnIftD+/+WbxZKSCM83iF
 5dU+Rbct3bhKZumegoA/nnXQvfqhJhhi5EjhS7rdo3qtTXw40BigvbviEMiYt+C0VdBiTnKFj
 v1ObJ6wwEzdYLsEamvkDfL0k+TUUutPQir+ReDdBW1Pl4kCokhh8WgRbK0lDnfdNCiALPhKkd
 wQqIAA4/7v+QTlCONGnGmJNp+JImZTqws0r1pTVde4MlOuLxr9++Ty26im2QyT9v5s7kagWKE
 5YS6lwuExhvl3GHskYiNkAO5wTv3ahJXycds4aw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--msiJ0Z0O4oaAlHjb7CfsmtUP37tO2AHj7
Content-Type: multipart/mixed; boundary="9i33XKukeXMUwbwXBc1mXNZ4ra2Gh5OUH"

--9i33XKukeXMUwbwXBc1mXNZ4ra2Gh5OUH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/17 =E4=B8=8B=E5=8D=8811:30, Josef Bacik wrote:
> On 7/17/20 3:12 AM, Qu Wenruo wrote:
>> [BUG]
>> When running tests like generic/013 on test device with btrfs quota
>> enabled, it can normally lead to data leakage, detected at unmount tim=
e:
>>
>> =C2=A0=C2=A0 BTRFS warning (device dm-3): qgroup 0/5 has unreleased sp=
ace, type
>> 0 rsv 4096
>> =C2=A0=C2=A0 ------------[ cut here ]------------
>> =C2=A0=C2=A0 WARNING: CPU: 11 PID: 16386 at fs/btrfs/disk-io.c:4142
>> close_ctree+0x1dc/0x323 [btrfs]
>> =C2=A0=C2=A0 RIP: 0010:close_ctree+0x1dc/0x323 [btrfs]
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
>> =C2=A0=C2=A0 ---[ end trace caf08beafeca2392 ]---
>> =C2=A0=C2=A0 BTRFS error (device dm-3): qgroup reserved space leaked
>>
>> [CAUSE]
>> In the offending case, the offending operations are:
>> 2/6: writev f2X[269 1 0 0 0 0] [1006997,67,288] 0
>> 2/7: truncate f2X[269 1 0 0 48 1026293] 18388 0
>>
>> The following sequence of events could happen after the writev():
>> =C2=A0=C2=A0=C2=A0=C2=A0CPU1 (writeback)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU2 (truncate)
>> -----------------------------------------------------------------
>> btrfs_writepages()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> |- extent_write_cache_pages()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
>> =C2=A0=C2=A0=C2=A0 |- Got page for 1003520=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 |=C2=A0 1003520 is Dirty, no writeback=C2=A0=C2=A0=C2=
=A0 |
>> =C2=A0=C2=A0=C2=A0 |=C2=A0 So (!clear_page_dirty_for_io())=C2=A0=C2=A0=
 |
>> =C2=A0=C2=A0=C2=A0 |=C2=A0 gets called for it=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 |- Now page 1003520 is Clean.=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | btrfs_s=
etattr()
>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- btrf=
s_setsize()
>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 |- truncate_setsize()
>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 New i_size is 18388
>> =C2=A0=C2=A0=C2=A0 |- __extent_writepage()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 |=C2=A0 |- page_offset() > i_size=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- btrfs_invalidatepage()=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 |- Page is clean, so no qgroup |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 callback executed
>>
>> This means, the qgroup reserved data space is not properly released in=

>> btrfs_invalidatepage() as the page is Clean.
>>
>> [FIX]
>> Instead of checking the dirty bit of a page, call
>> btrfs_qgroup_free_data() unconditionally in btrfs_invalidatepage().
>>
>> As qgroup rsv are completely binded to the QGROUP_RESERVED bit of
>> io_tree, not binded to page status, thus we won't cause double freeing=

>> anyway.
>>
>> Fixes: 0b34c261e235 ("btrfs: qgroup: Prevent qgroup->reserved from
>> going subzero")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>=20
> I don't understand how this is ok.=C2=A0 We can call invalidatepage via=

> memory pressure, so what if we have started the write and have an
> ordered extent outstanding, and then we call into invalidate page and
> now unconditionally drop the qgroup reservation, even tho we still need=

> it for the ordered extent.=C2=A0 Am I missing something here?=C2=A0 Tha=
nks,

As long as the ordered extent as been started
(__btrfs_add_ordered_extent()), then the QGROUP_RESERVED bit is cleared,
either freed for NODATACOW write, or released for COW writes.

IIRC this recent change is suggested by you, and that paved the road for
this fix.

Thanks,
Qu
>=20
> Josef


--9i33XKukeXMUwbwXBc1mXNZ4ra2Gh5OUH--

--msiJ0Z0O4oaAlHjb7CfsmtUP37tO2AHj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8SNnMACgkQwj2R86El
/qgnFQf+OcU3UVJ0XCpPhWqh2gC5REZmcOTp+CIKFDsmlXgLaBlQSjBTK9B2WI03
5QxWTOC+TMBl20EX0cfWGpUa4GUSeAVPKsL8frRmjHLqEntsIM3vI2VsWs9tghmg
G8IYzkKK8aK3oEe2TF+iukxtUmf/ADgC7g3dL05C8iKj/tB5svTeruhpLX3+Ey2z
T3yj1RlNyx+zFT6T6EbaDFzhDGaQZONwCWwLRpC01AQTkm5F9zcQDJz3vOng1g80
TwHquWhFa6cjR2Uh9GLG5o4d/sdGMZ0HLqSIGnKSWi0CWTegozvfFqeOi1C1vojn
YTFpJgOvQMbfFRx/1oBG3xAXGKIrDA==
=mHdA
-----END PGP SIGNATURE-----

--msiJ0Z0O4oaAlHjb7CfsmtUP37tO2AHj7--
