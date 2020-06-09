Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADF1F30A4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 03:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgFIBBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 21:01:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:50701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbgFIBBW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 21:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591664475;
        bh=o52laFJCMzyEAVJh7ap9uP5HTp7raUUxx9vSTW0liYI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LxzIdUWtFq4a+W7dfmQeZVg6J4IHhd0gmGmVCI40eYr99YvraWx5ifkuypfsaHwuL
         sr5Zzwk0e+/NEMwShVAQf0nPeNdG92kxHcNEopfWmv0P+gvQbIJCrkrdmmfNWR/dev
         nfTE7SCkFT1XDFRzY9mdRzBCR1Z39JGsHgJNqGEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1HZi-1jfhTs3JJy-002p1I; Tue, 09
 Jun 2020 03:01:15 +0200
Subject: Re: [PATCH 1/2] btrfs: extent_io: fix qgroup reserved data space
 leakage when releasing a page
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-2-wqu@suse.com>
 <2d098492-b927-fc01-d33e-9f89452d26fa@toxicpanda.com>
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
Message-ID: <f6015ca7-5ab4-b924-e734-7574d12d795b@gmx.com>
Date:   Tue, 9 Jun 2020 09:01:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2d098492-b927-fc01-d33e-9f89452d26fa@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5AF4cBT5OW0qeu3eObhdLaoofQTR8Nl7J"
X-Provags-ID: V03:K1:1k83A91fl90PHdRYLu14+wtMi9weQWQlOoyB3fDpyZI3zEt0PXc
 rqlODh1sExKgALR2SLAobSvjMIJ00bDK9jxolDHp+fqmYG13V/8s1+/8ZxOkbyGYt6HHWbH
 UcHqemm/hYyKtPcUo8SbdBRtww7tsv9RTdGPwEazw58MzZHaEQ+JxeZpDzeGNXva3JxuRbm
 dDSw4Eel+ZcUUIZGxR14A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jbnyNiBLF44=:ArFhjHXX3JPpCWEciXGZAq
 JTQw7a0MGnUOwVBbUhn0MmeFP375Xre3za9Ttv7h7dfRp0Ku5weYMwjpEmsRHFpKHJgDbRv3+
 TBBv/VXaukoQ+kHbZceQdycnORSKi2K39/ZP8P1dR6lvd5BIyJGTAAtyeHh9cJfRMnw9qasG4
 WJQ8pkq1VvdN04p+rlxre78EfzyLM3gUQw/5orhO68/Xdnn7bFIYNTFj15sV8RQqUUc4bcs/o
 fF5lc14+YHe3WJBKPBVq3wrOmpcNu80GNTXe0KIUXKXBzxjg8AzHFyjzDV4n1+hHHQbEOVLLs
 iYGOrk+7Fcd5j7gm3GbM0A7nCWzT5h9Km4Jw9pF8Y9XeO9QtKvofS7eewCDhMr+YuZxLDkXlx
 wGmnbb+VpIAQ97J6ezp/o6WP7+h+gmbT1VY9v4iprvhLCvIn6ZqLmZFllkqxbnlMz3lbklzqt
 eFSabPTRkJhVwlf/HDmcg6AqKMGOfaXRMoFWwaLF+UfpwVlI7L6PJ6Eel5SWkJu/WAkWAq5Rc
 D/rBx+QdVcpUTSBw1It6X861fGGExHzcKAmQmb3y4+9ccXY3ZdUKRJ1f9U5bXb+sKusKZs+wM
 WWOhXuYA7cua9UP+4ZpXgWgIo0sDbas/N0brglLAAg1g+vt6V7YmN6bGQ7PoBRwBxihyiT2R8
 4cNR9mARqw0H5AzUm9JZ58cUZcnhd5fYmodjW3bhVPikQrJfsdtSiVyEdnJhT/uKV/Fu35ghW
 vxQjiy/TUro11nRZ9Lv3p2Icj9O3icq59QGYqtCCiCzmXlYDdrMarMVL/q2ronF4/ovpUU+1A
 xGICCFBFY0e5aaqO2grWfyOFcNVmsNabTgC9ZHHkKtc2WuM/WctQEYdDiIPrs0FYusMugDNto
 h4E8S9WIFh99nMyz9OWV2hfyGL2j8KvqKIQY3uQcV/Ma9s5V5q40upYznYgQ4vQVJAzSXuGjk
 MJATmpQOYzbbP/7ASsdQFwgbLWBGHEdtInt2MI41+ayaBSaHYAbYSEwddv5o7pQGlWrUxGIXB
 3PcCaZxBWRBvMbab/HkS0lMebU9zE/DNG7cZU6qQsVhLwHGcnXQvP+9qcM+CycYyqOx8P0Uly
 uHGqww7ND73yMaEjBf6DPuyCIg5WvMZMTmaEZi/Y9rSvAtVCZZxl1oFksYmOBD9IYZU7Kd7Tf
 bR7on+JQikNP2gKLZpOPOz08pOUDhuxyil6IXCuYrxVbEhCt4za9W3rj4oe72lhaDnD5Ah4uH
 tKFeEpp0rzCOQQFg/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5AF4cBT5OW0qeu3eObhdLaoofQTR8Nl7J
Content-Type: multipart/mixed; boundary="6YpGylukv1bBNpJaMMdU0AxOLNnuxrrTT"

--6YpGylukv1bBNpJaMMdU0AxOLNnuxrrTT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/8 =E4=B8=8B=E5=8D=8811:17, Josef Bacik wrote:
> On 6/7/20 3:25 AM, Qu Wenruo wrote:
>> [BUG]
>> The following simple workload from fsstress can lead to qgroup reserve=
d
>> data space leakage:
>> =C2=A0=C2=A0 0/0: creat f0 x:0 0 0
>> =C2=A0=C2=A0 0/0: creat add id=3D0,parent=3D-1
>> =C2=A0=C2=A0 0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
>> =C2=A0=C2=A0 0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627=
318]
>> return 25, fallback to stat()
>> =C2=A0=C2=A0 0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0
>>
>> This would cause btrfs qgroup to leak 20480 bytes for data reserved
>> space.
>> If btrfs qgroup limit is enabled, such leakage can lead to unexpected
>> early EDQUOT and unusable space.
>>
>> [CAUSE]
>> When doing direct IO, kernel will try to writeback existing buffered
>> page cache, then invalidate them:
>> =C2=A0=C2=A0 iomap_dio_rw()
>> =C2=A0=C2=A0 |- filemap_write_and_wait_range();
>> =C2=A0=C2=A0 |- invalidate_inode_pages2_range();
>>
>> However for btrfs, the bi_end_io hook doesn't finish all its heavy wor=
k
>> right after bio ends.
>> In fact, it delays its work further:
>> =C2=A0=C2=A0 submit_extent_page(end_io_func=3Dend_bio_extent_writepage=
);
>> =C2=A0=C2=A0 end_bio_extent_writepage()
>> =C2=A0=C2=A0 |- btrfs_writepage_endio_finish_ordered()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- btrfs_init_work(finish_ordered_fn);
>>
>> =C2=A0=C2=A0 <<< Work queue execution >>>
>> =C2=A0=C2=A0 finish_ordered_fn()
>> =C2=A0=C2=A0 |- btrfs_finish_ordered_io();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- Clear qgroup bits
>>
>> This means, when filemap_write_and_wait_range() returns,
>> btrfs_finish_ordered_io() is not ensured to be executed, thus the
>> qgroup bits for related range is not cleared.
>>
>> Now into how the leakage happens, this will only focus on the
>> overlapping part of buffered and direct IO part.
>>
>> 1. After buffered write
>> =C2=A0=C2=A0=C2=A0 The inode had the following range with QGROUP_RESER=
VED bit:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K
>> =C2=A0=C2=A0=C2=A0=C2=A0|///////////////|
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 20K
>>
>> 2. Writeback part for range [596K, 616K)
>> =C2=A0=C2=A0=C2=A0 Write back finished, but btrfs_finish_ordered_io() =
not get called
>> =C2=A0=C2=A0=C2=A0 yet.
>> =C2=A0=C2=A0=C2=A0 So we still have:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K
>> =C2=A0=C2=A0=C2=A0=C2=A0|///////////////|
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 20K
>>
>> 3. Pages for range [596K, 616K) get released
>> =C2=A0=C2=A0=C2=A0 This will clear all qgroup bits, but don't update t=
he reserved data
>> =C2=A0=C2=A0=C2=A0 space.
>> =C2=A0=C2=A0=C2=A0 So we have:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K
>> =C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 20K
>> =C2=A0=C2=A0=C2=A0 That number doesn't match with the qgroup bit range=
 anymore.
>>
>> 4. Dio prepare space for range [596K, 700K)
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space for that range, we got:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 700K
>> =C2=A0=C2=A0=C2=A0=C2=A0|///////////////|///////////////////////|
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 20K + 104K =3D 124K
>>
>> 5. btrfs_finish_ordered_range() get executed for range [596K, 616K)
>> =C2=A0=C2=A0=C2=A0 Qgroup free reserved space for that range, we got:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 700K
>> =C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |/=
//////////////////////|
>> =C2=A0=C2=A0=C2=A0 We need to free that range of reserved space.
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 124K - 20K =3D 104K
>>
>> 6. btrfs_finish_ordered_range() get executed for range [596K, 700K)
>> =C2=A0=C2=A0=C2=A0 However qgroup bit for range [596K, 616K) is alread=
y cleared in
>> =C2=A0=C2=A0=C2=A0 previous step, so we only free 84K for qgroup reser=
ved space.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 596K=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 616K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 700K
>> =C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0 We need to free that range of reserved space.
>> =C2=A0=C2=A0=C2=A0 Qgroup reserved data space: 104K - 84K =3D 20K
>>
>> =C2=A0=C2=A0=C2=A0 Now there is no way to release that 20K unless disa=
bling qgroup or
>> =C2=A0=C2=A0=C2=A0 unmount the fs.
>>
>> [FIX]
>> This patch will fix the problem by calling btrfs_qgroup_free_data() wh=
en
>> a page is released.
>>
>> So that even a dirty page is released, its qgroup reserved data space
>> will get freed along with it.
>>
>> Fixes: f695fdcef83a ("btrfs: qgroup: Introduce functions to
>> release/free qgroup reserve data space")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> This seems backwards to me, and not in keeping with the actual lifetime=

> of the changes.=C2=A0 At the point that the ordered extent is created i=
t is
> now in charge of the qgroup reservation, so it should be the ultimate
> arbiter of what is done with that qgroup reservation.=C2=A0 So fix
> try_release_extent_state to not remove EXTENT_QGROUP_RESERVED, because
> it's going to get dropped elsewhere.=C2=A0 Thanks,

Indeed, doing the qgroup rsv work in ordered extent looks more reasonable=
=2E

Although that change would make a lot of timing completely different,
and won't go as smooth in the first run, it still looks like a more
proper fix.

Thanks for the advice,
Qu

>=20
> Josef


--6YpGylukv1bBNpJaMMdU0AxOLNnuxrrTT--

--5AF4cBT5OW0qeu3eObhdLaoofQTR8Nl7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7e31cACgkQwj2R86El
/qjm2Qf/QU6kQq5iOzDtjgv0vpZL2R83zxsfXnUtMAPOazDiqzxXzK7NNGbTND05
kI1NxTJTwg8VV7c1HeExojJeRpE78GpOGHqfzEXbnKlzrZ08s4oamAKt8ZSATSL4
hqymkP5fqO3O/Vfnim79ztahSwJPmCD12qt+XrE3pAtU6L3kv0BNugkTkrj3w1se
1vBWn5Qkkxxz+J6TYJ92pPdPMgIXJ5QDV2MGTp/9nf0SNDyM/fzj595RNnouLvb6
Lavq6X/JsvZ3VG6p9uOS2Wgc8Scpt6vY97MFo5hJXlE9Alyauj9P/qOBF3fQeb1f
5DSUgxCxZltupujuNAzY9XfHtOAcWg==
=To1u
-----END PGP SIGNATURE-----

--5AF4cBT5OW0qeu3eObhdLaoofQTR8Nl7J--
