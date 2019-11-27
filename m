Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2309510C0AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 00:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK0XhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 18:37:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:59495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfK0XhO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 18:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574897638;
        bh=dDJzgGeN77ou4TbDl/YBjXu8zKlbOsi8g1Nz+ygEsRg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q4wUtsmh232uiXcCCwC9e3hW7Vf327c1al219Eb3ahCaLHh+KfqBq7zUbaaXKdg2G
         NrVneBdWAfwm4RIJMXSZsB8QJnh5PPlms9MjttaaqM3e+4pVL/qg2lrD5w0jjGSa8F
         mvxUQw1mGuS350bNsCIIWitgfzNLhGQsAd9XrHeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1iTG8K2NJp-006yQe; Thu, 28
 Nov 2019 00:33:58 +0100
Subject: Re: [PATCH RFC] btrfs: space-info: Make over-commit threshold to
 87.5% of a new chunk
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191125100450.43599-1-wqu@suse.com>
 <20191127185916.GZ2734@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <78fe9dab-46bc-1367-0cae-41296ae9f7b9@gmx.com>
Date:   Thu, 28 Nov 2019 07:33:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127185916.GZ2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CVKl9ljwyYSCtMjCZzJrnoKhEOo242jvf"
X-Provags-ID: V03:K1:yolMQ4AnR2YQb/iC/22g4nVn2ccn7vmZ7Obbu45YDpAZ7wx+OP3
 egBmXlnrtoGx0rl6gLpYdCbqrCjroHNhczPsB2Nd461Vy8pRMQLDS8o6H65hR4TE+0voiUu
 U/CJ58kKKOHn1daehOT6ZLV4/hIefHrOdnq00Ly4lH+wlkUiDMiTUDNC4oTHPfFFR2VH7/0
 SRHEzBt35q3vjt/1KeCWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a/xvAWydyTM=:9UYITITbj9r2SBQj2BAFOx
 lr9flUiLPF28u7q0lGTIemYtcf6do1Mxmr0KqsDQ5tbiWRJGefyCMQt7mhxHtQsAiuHX3ps4H
 VYfU9pyH9w3Z/UQ+EAJvwZKctt2iOjfOfplJ4pE2aMOYh4XEo+UFm8+arTAvFLfyUjMNrLU9z
 yw1bKNwJWSytR8//kBXo8Qz/I15QNmf8ViGYCVdA8LciGCjJ8mJFk8lLW7eg0TIYTzlLwnDxi
 RE3QEfBvgDChGyrIqvwVNiTrD7cT54pyjh4qTOr1rNDWlzBKRa0pTRam5nOvN6a/ummKL7J87
 OEDaR/mgHTFMstxSu1nyhsFdFZB3F2ool6SyFByQmOYGQVyZsFreJQ4kwWDS/FsOBNynmP1OI
 wDvrQTvjUqTdeT8tnHqZ5/mjbQLShjZ0eec0sJLnYvvJd44NsmMrKEoFVx9g+xbr5otqx6gNU
 WAuSqAUPSlhvJS9MsP9StmUzPEYEVlezwFsALWTj14+LtiAliznUEqXDJaKdTXbIKVDT++RAm
 8/DUAUMCAuV1C2ZwyryPQAnhngERFb845b2r48EMjWm3XNJo/BFGq2LZqZ1OPk3urV6cCdT3W
 sSpQLwwba94eQdtxW0MokBVj/0q47AiP/4dsiWdaYYC/Ib8xd1XqFMCuAgvT4pykK4JGPQ5F0
 YpbUvBN8jvnQDf8vG7npjX8l2gqdmkLFdOiefpJmocuO+TavgTOMmB9iYQdDpNDFDaAU8/ecD
 MSTRiH5Bv4Dg/VFNvloi94Nxydm1wUi680HOpdad8A9xL3ccMu4g1WGpHq2KpUsuBYKsPHCxF
 kbzNi5UqweQvYRzlsYeycMsXrUUOFDCT91IpTkS+eybUQ/Q0qO91TSw8VtrcxmftuOdE7W2O1
 XiqhnFffx1bR0AE2dOocohOLgvL4VxQ09TKREIAKb0Z1X5XpY7Kpgx7rJg2aewVLwROoLpjGs
 OJdqx2SajkLKBO0CMllaYSvrpf7WgZ7pA/be3uo7GkeTKINa6eYtEcOOmNPoYuD3u4OOUJC3B
 3tCS0js/3NvssaXlKixPEpg5+lYkmSQqOiVRXizc6qtXToSMImfbcbDVZG44PEKTMLOan6Vn+
 uXriXPXoR6gNpaM6OIPMg5uYXhTr3owmWBYXAhAZc8GBfQ/jIBiDFoz8q337zOSygne+0GME+
 kMyXqkC7xcOUCh9LjPSpocTDzq9rpHUZy6bG1rqRgS3mBEaWkLzDy+GtP1oVBlSO3ayA5ouvk
 luSwF9o9iEitOVEVYYC1A39f4AAwPlN67up9JuwJinxsCWXY9kuere7IrsPA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CVKl9ljwyYSCtMjCZzJrnoKhEOo242jvf
Content-Type: multipart/mixed; boundary="8327t0DPrwO1yRBcDQNPA9BDWsD9IBGFH"

--8327t0DPrwO1yRBcDQNPA9BDWsD9IBGFH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8A=E5=8D=882:59, David Sterba wrote:
> On Mon, Nov 25, 2019 at 06:04:50PM +0800, Qu Wenruo wrote:
>> [BUG]
>> For certain fs layout, a full balance can cause reproducible ENOSPC.
>> With enospc_debug, we got the following dmesg (BTRFS info and device
>> info ommitted to save some space):
>>
>>  disk space caching is enabled
>>  has skinny extents
>>  balance: start -d -m -s
>>  relocating block group 1104150528 flags data
>>  found 14659 extents
>>  found 14659 extents
>>  unable to make block group 30408704 ro  <<< from inc_block_group_ro()=

>>  sinfo_used=3D2386411520 bg_num_bytes=3D1046888448 min_allocable=3D104=
8576
>>  space_info 4 has 18446744072434089984 free, is not full
>>  space_info total=3D1073741824, used=3D24281088, pinned=3D1277952, res=
erved=3D1245184, may_use=3D2322333696, readonly=3D65536
>>  global_block_rsv: size 3407872 reserved 3407872
>>  trans_block_rsv: size 0 reserved 0
>>  chunk_block_rsv: size 0 reserved 0
>>  delayed_block_rsv: size 0 reserved 0
>>  delayed_refs_rsv: size 2318401536 reserved 2318401536
>>  unable to make block group 30408704 ro <<< double inc_block_group_ro(=
)
>>                                             failure, means
>>                                             btrfs_inc_block_group_ro()=
 failed
>>  sinfo_used=3D2342912000 bg_num_bytes=3D1046872064 min_allocable=3D104=
8576
>>  space_info 4 has 18446744072726380544 free, is not full
>>  space_info total=3D1342177280, used=3D24281088, pinned=3D1277952, res=
erved=3D1245184, may_use=3D2298478592, readonly=3D65536
>>  global_block_rsv: size 3407872 reserved 3407872
>>  trans_block_rsv: size 0 reserved 0
>>  chunk_block_rsv: size 393216 reserved 393216
>>  delayed_block_rsv: size 0 reserved 0
>>  delayed_refs_rsv: size 2294546432 reserved 2294546432
>>  ...
>>  1 enospc errors during balance
>>  balance: ended with status: -28
>>
>> [CAUSE]
>> When allocating block group 1104150528, since that block group has a l=
ot
>> of extents, it has a data reloc inode with a lot of extents (14659
>> non-hole data extents).
>>
>> After relocating that block group, btrfs needs to cleanup the data rel=
oc
>> inode.
>>
>> During that inode eviction, we have call evict_refill_and_join() to ge=
t
>> metadata space reserved, which will cause a lot of metadata
>> bytes_may_use:
>>   evict_refill_and_join()
>>   |- btrfs_block_rsv_refill()
>>      |- btrfs_reserve_metadata_bytes()
>>         |- __reserve_metadata_bytes()
>>            |- if (can_overcommit() || ...) {
>>            |     btrfs_space_info_update_bytes_may_use();
>>            |     ret =3D 0;
>>            |  }
>>            |  if (!ret || flush =3D=3D BTRFS_RESERVE_NO_FLUSH)
>>            |     return ret;
>>            |  return handle_reserve_ticket();
>>
>> That means, if we can can_overcommit(), we will increase bytes_may_use=
()
>> anyway.
>> And only when we failed to over-commit, handle_reserve_ticket() get
>> triggered to reclaim some space.
>>
>> On the other hand, at btrfs_inc_block_group_ro(), we will check if we
>> have enough space, and if not, allocate a chunk and retry:
>>   btrfs_inc_block_group_ro()
>>   |- ret =3D inc_block_group_ro(cache, 0);
>>   |        |- if (sinfo_used + num_bytes + min_allocable_bytes <=3D
>>   |        |      sinfo->total_bytes)
>>   |        |      ret =3D 0; # Only success if we have enough space.
>>   |- ret =3D btrfs_alloc_chunk(); # Trigger a chunk allocation
>>   |- ret =3D inc_block_group_ro(cache, 0);
>>            |- Do the same check again.
>>
>> That means, if above over-commit threshold is larger than current spac=
e
>> + 1 more chunk, btrfs will continue over-commit, causing very large
>> bytes_may_use just like the enospc debug output:
>>  space_info total=3D1073741824, used=3D24281088, ..., may_use=3D232233=
3696
>>                                                           ^^^^^^^^^^
>> The fs is 25G, DUP metadata, so the over-commit threshold can be as
>> large as 6G.
>> In our case may_use is over 2.3G, while our metadata space info is onl=
y 1G.
>> Definitely will not pass the check in btrfs_inc_block_group_ro().
>>
>> Such over-commit behavior works fine for most use cases, but when
>> btrfs_inc_block_group_ro() is involved, we will get ENOSPC.
>>
>> [FIX]
>> Change can_overcommit() threshold, to follow the
>> btrfs_inc_block_group_ro() behavior.
>>
>> Adds a new threshold check based on chunk size, so if our used bytes
>> (including bytes_may_use) exceeds current space info + 87.5% one chunk=
 size,
>> we stop over-commit.
>>
>> The 87.5% is used as extra headroom for min_allocable_bytes (SZ_1M).
>>
>> This makes over-commit work along with btrfs_inc_block_group_ro().
>>
>> The downside is, we will have much smaller over-commit threshold.
>> This means, when fs is mostly empty, performance may drop compared to
>> the old behavior.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>> This is another extreme, compared to "[RFC PATCH] btrfs: Commit
>> transaction to workaround ENOSPC during relocation".
>>
>> This patch will reduce commit threshold for all cases, just to address=

>> one case in relocation.
>>
>> While the other RFC just address one problem, and one problem only,
>> but in a whac-a-hole fashion.
>>
>> I don't know which is better, personally speaking, that whac-a-hole
>> patch may be a little better.
>>
>> So both patches are with RFC tag.
>=20
> This patch is superseded by the series from Josef, right?
>=20
Right, please discard both RFCs.

Thanks,
Qu


--8327t0DPrwO1yRBcDQNPA9BDWsD9IBGFH--

--CVKl9ljwyYSCtMjCZzJrnoKhEOo242jvf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fB+AXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgqcAf8CRwjkFJJLKQKtX6wWRldiRqJ
5jDQCOi2RvtWr4M7FCFAIoGAnxjZ6oDQoznsUMP5uvhMJOkJWtGKbiCXVqpdFArD
1mWC5CETuCUd3aDsIwPzrOfecaWVOpZ+zNclQhqj1nY3xA3WnpkADv9s0uQTnYnn
D6nXy/7UknxN1+pXqA5l8r8zG/KM/q9NmyFDBUFdZI1U7FEj63yHV9BfFMth4wE5
+FugGgzKeo7Tb47fNuHh/q9AhPN4KlYJ8YCja1rH0sJh72QRGlqL7UMEs8BD6xos
maMfRtnq/Hv92C2UsImKGwd8nzdMQ7NdEJ6fwiOEab9N7TW9GIQUQAII3dubzg==
=FlO7
-----END PGP SIGNATURE-----

--CVKl9ljwyYSCtMjCZzJrnoKhEOo242jvf--
