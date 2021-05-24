Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA538E716
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEXNGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 09:06:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:42757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhEXNGR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 09:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621861484;
        bh=gVpbFj5xPkw8yRzFaxniCAJbbwGzwuRF3jnM++k/M54=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=QkBIAvJFOInt1OAk30gnvg4/pfEFxFxwjhilh1trxQY6hzuCtTLUN4aJRGfMwjnR3
         qLZma4GvVakH2ni+wRcKC9UEerCuK0oygiSIQ1CztifaLwG8KPKhbbx79vaFX3LICM
         /laM+KgacXKc0P23KjakeuCnILrwzykoi2ls0bQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KPg-1lK7DN3lgI-010LHX; Mon, 24
 May 2021 15:04:44 +0200
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
 <92273193-366c-8121-c2f6-26c885d77ead@gmx.com>
Message-ID: <3cba8426-5574-0da7-28bd-aa90eb9f18b8@gmx.com>
Date:   Mon, 24 May 2021 21:04:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <92273193-366c-8121-c2f6-26c885d77ead@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n9RuQZ43DvALb5pGF6AzqKRx4lWWBJv81Jawkv8trSNeTt0CsiB
 6Z9uTPRu4+sftIiPg/3uXbmScvPxKRuxm+B8LBceeMFsXFHNxEOwxJazA9i5qc/N9b6nC9Y
 v/ASZhMEXVfC8Ou54umijXz36i8VlDuSrJVDIzmxSSofDuR0qMA2UnX+oePzQtf+fs5ch7S
 5p/oxpt3xioKCqq52WHxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xLLLkdt2Bg4=:ySxZ/LLp3+tVKQYD4cpgjp
 F7wSnmfoK5ZRpA1SWXiIzvtmXapLMTwQETFYHGsNGuMt/wyakTvYhzHVjUG3unkrma7+aUk3o
 3uA4fQrtQIY1s6YLXDVwP4jrfMgTkq+cJv6+F9u2E8yueikqnauzThY+OOlYYw6q97F1DHtps
 y94CBIwXQ2KL4dZVjLhRy3GN2E2CArswMtuoYUJht12NIwK0o/D3MJJbjxQafF8ad+uOnk3q+
 KBIARzvnZhOvPzXoQFUcMvp9r8gU0SFahPKrrUzX5UF/e6Bgv+S5ecrUlMfqAEpvb/H83f4mj
 M36D6UIvLi5/1PyBucEQ1Xpm4D5p1Dw/eLfLJCPWYPAsE8ZpliLeOubUa5kWgRbWL6CjC/deo
 ya6E7wy90yhqMNIjdlpslhuahmtPL2ZfOzmGjGMaVVelbK+W8btLO11+QMBt2fqq5JhTXjdwq
 YmxNX8Qve+CkJ8cBe/WYzNt7AghophCB9Xo3DZL4Cq7DSuo24+EQO4i8FghZAz56m6s0coY2l
 GzlEzqptPJ7v0g8d9BVmY/rd89Cc94zGNCk3XUGQ1eMfIblhBBpf1cilPavccnUoG3VGYk2pl
 zZPR+cjs78Kfz+/pLBshXcMsfHlQD5n/o3nZohhk9EmK9SGLKFSSE7SVTh90JHAq22P5A3RBm
 SJwsMKhtcWLyk2LN3lzM6mqtgt2MuXO1iCADPDhQPjKc4Oj+BaBKTuQ+oqpuVGENh0VG7h9l4
 wt9bYemg6AT5cqr8Ddbj9VJgUADeWO0Cg94yz0vmui1DFsj1EsQXMh4/XYU66h82W6fB1seNW
 55aNRwFEBQ7I3GGkSzwTwUdZwB4Np0pEBChR+5vPiz9zTCKS/C8XOA54f25WnA/orI53XhoxE
 IhXtnyC7l3yqORL9pf2KZflS3w6KPRqlSoSs1a97VKp9nh9JnHgCP9lpnM9TMS0aYqo/8hsq5
 97iSGDToJj8wRQXUh9pbmLaI0+KEwtz2ZV0JWsWVKnQDxp9/4WIBKCmCZkctmmraYvPjRxRTm
 NrE7tmhdYpypScT0GyV5vO9bfDT3ROc89SY7HaBKQHWQq7jXxoBO9XqFkDGIpyezQSNAC9kOv
 n10z9rjlK+FWkB9Mt6KGfl32H2K5eqL1CADwiQyJzf+l+MrsxjIHqDiBD1Z8wgU5sGB9Ju3T7
 i2o/r0WCAZKZNe9BiO5au2pFrFTI4RWwRd0mdGtZEXVIfVkWc5ZI/mXcSUvo8c3reUrI6WTaV
 lYLSn1WrM9Je+Waa6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/24 =E4=B8=8A=E5=8D=887:09, Qu Wenruo wrote:
>
>
> On 2021/5/23 =E4=B8=8B=E5=8D=8810:13, Josef Bacik wrote:
>> On 5/18/21 11:40 AM, Johannes Thumshirn wrote:
>>> When multiple processes write data to the same block group on a
>>> compressed
>>> zoned filesystem, the underlying device could report I/O errors and da=
ta
>>> corruption is possible.
>>>
>>> This happens because on a zoned file system, compressed data writes
>>> where
>>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
>>> operation. But with REQ_OP_WRITE and parallel submission it cannot be
>>> guaranteed that the data is always submitted aligned to the underlying
>>> zone's write pointer.
>>>
>>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a
>>> zoned
>>> filesystem is non intrusive on a regular file system or when
>>> submitting to
>>> a conventional zone on a zoned filesystem, as it is guarded by
>>> btrfs_use_zone_append.
>>>
>>> Reported-by: David Sterba <dsterba@suse.com>
>>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat
>>> flag")
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> This one is causing panics with btrfs/027 with -o compress.=C2=A0 I bis=
ected
>> it to something else earlier, but it was still happening today and I
>> bisected again and this is what popped out.=C2=A0 I also went the extra=
 step
>> to revert the patch as I have already fucked this up once, and the
>> problem didn't re-occur with this patch reverted.=C2=A0 The panic looks=
 like
>> this
>>
>> May 22 00:33:16 xfstests2 kernel: BTRFS critical (device dm-9): mapping
>> failed logical 22429696 bio len 53248 len 49152
>
> This is the interesting part, it means we are just one sector beyond the
> stripe boundary.
> Definitely a sign of changed bio submission timing.
>
> Just like the code:
>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pg_index =3D=3D 0 && use=
_append)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =
=3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =
=3D bio_add_page(bio, page, PAGE_SIZE, 0);
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page->mapping =3D NULL=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (submit || bio_add_page(b=
io, page, PAGE_SIZE, 0) <
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE=
_SIZE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (submit || len < PAGE_SIZ=
E) {
>
> The code has changed the timing of bio_add_page().
>
> Previously, if we have submit =3D=3D true, we won't even try to call
> bio_add_page().
>
> But now, we will add the page even we're already at the stripe boundary,
> thus it causes the extra sector being added to bio, and crosses stripe
> boundary.
>
> This part is already super tricky, thus I refactored
> submit_extent_page() to do a better job at stripe boundary calculation.

BTW, I can also reproduce the problem in btrfs/027 using the latest
misc-next branch.

Thus to workaround the problem, I'm using the following diff, feel free
to fold in to the offending patch.

Thanks,
Qu

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 831e6ae92940..26e2dceda1fc 100644
=2D-- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -455,10 +455,13 @@ blk_status_t btrfs_submit_compressed_write(struct
btrfs_inode *inode, u64 start,
                         submit =3D btrfs_bio_fits_in_stripe(page,
PAGE_SIZE, bio,
                                                           0);

-               if (pg_index =3D=3D 0 && use_append)
-                       len =3D bio_add_zone_append_page(bio, page,
PAGE_SIZE, 0);
-               else
-                       len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
+               if (!submit) {
+                       if (pg_index =3D=3D 0 && use_append)
+                               len =3D bio_add_zone_append_page(bio, page=
,
+
PAGE_SIZE, 0);
+                       else
+                               len =3D bio_add_page(bio, page, PAGE_SIZE,=
 0);
+               }

                 page->mapping =3D NULL;
                 if (submit || len < PAGE_SIZE) {

>
> We definitely need to make other bio_add_page() callers to use a better
> helper, not only for later subpage, but also to make our lives easier.
>
> Thanks,
> Qu
