Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A885B0FC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIGWVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiIGWU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 18:20:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289258991F
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662589240;
        bh=CdVO2QdP0Ab/r+J1XF8fM5miGxGYJuezyUbOHFvYK/g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J9J5hcGgzXQP4mJhMLlGhMzU4B+akO0d+ygvdypa5lSEgK173jea1EVYT/oTxVDpz
         S0o8FAI3XMFtdk3HnlYDP1hLeynCuqcODXv+bMe5sOXHcGZ1ArEt1AUh3c3wp43/if
         Z5JHmxfDCx3sHwRe+KWCmA/Ts5vTA/3HUqKCuTbg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGyxX-1oakMO3I4B-00E21c; Thu, 08
 Sep 2022 00:20:40 +0200
Message-ID: <8fe1128c-ebd9-87b6-a2ac-0a427223b456@gmx.com>
Date:   Thu, 8 Sep 2022 06:20:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <YxirXjl1Ur3VV3B6@localhost.localdomain>
 <YxjVDY7jIH3Vv/il@localhost.localdomain>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YxjVDY7jIH3Vv/il@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a3eqoyfzXe9MwG4FhdYkyDNVnInoMDQvexGoTTgntvHK+E5Tjks
 gQ+kq88TdC/yJ/SFADrVYM/O8rqcVXDybcdgaAuRwybNS0fuEIeiWx/v11q4VjLc5p24s8B
 dDVlBg6ypHgfK+Rid3MJ2WA9MhmCguJ16qNtJUtERMair5n3vgx9HoV2A9DjjCDIBDoRv/y
 CxMsWaVH+MNNzfNOi7zZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XlpXqTC1DUk=:Bn/gBqYmaXfCCFNYbUbSrn
 nFwSSt2C7gTQHlM7CkGI3jnsI5kvh/Yx4M/YSrArmW0U3hJiWUPdBHgabIs3x9k5RdA4A+43l
 uUni40Dvu1TnPqxUuEbMFq7ZZf/zvMVrszfhLJSWHadyhY1GBfh0FCJr4GAxc8+eKj8rI5CgI
 KHEhvsxgx6/cliVsWkxeptmOvtPJEaLPPcDGNxc53MuPn/XHMMsAgdhFONqf7pj/FafV7hAle
 LGfy+st3so3j1FMvMHsX/apM7qCa5Yj4DM0QKaX5QMa/GMxTlI7XnoC32rdTgZ16e6Z2h81R6
 6jm/DnAzRSICESmvE0J6N6i9pBV5N3QUnlQSpm6RDHBGS8O5fRsxMcBLFvmjnJP47p+t1otlv
 qP5NGJtHvypqvnQPzFHZ+2Scu3qsQKIIjnOSPjNsiznO3E7E+opFSBfjz9sDpGEBPDJoD1ET0
 +pakWReRbl6kuiyaU4eC11HIHRn6EsWSWJd1czgEFpQH7lYhHh3tYXn1l+RReT+qbJiJtNbLs
 HBvIN2oRqcBLD7JUhYiw0+ePGX66Y2KzJyjbx9Cr2Nvgm+vP1so8D96MKpsYtJU7jgvmxjRtZ
 5CPByKAbvj6LKXVHIYEOg8Tpqcq0RTpl69PkJ/KlSxyfoY8anurlpI2TykipHg9t34tVuYUVT
 wcHRdcKqgrd6bKoHt/uNLNmwHZNucwL+cS01TqLZGJCuhoLtjTS0IYs/y3uK4yORSfkfxkNWK
 SnVbuP+agLe9WhC9cqgHs0xK2nc3esGqKmqOz+zVYURhfdk6MfUVFBxHShAvC7Z6t76o1DMWP
 ajA0B8uod3Q+7MEAh9bF9VNAyoabWhFiXjuYBmFnSvUVVnLP+4aTVcmkznB2bpmOVmHDKgbAe
 MvJSAd9L6Z2/5emGiehSYWMWtItiBX9n6eQpnUgARmjizkMiyyFiH2+5IjoBjgFTFWb9VLWkJ
 HhqYKz5SzaO0JK6RcR1Hw+PgQEue2ItLbiLBy03XWb54TI+V/3T44CnLqCA/pedKdjJifArsv
 5pGkKfG6Zp9LK4fkvHrfgzVFHoxJvXg2JBgMxOeRqQfAlPICwDQ2ifTy1dvw30ZBxzFVis0Y9
 edGYMJmKmv3Rz/SI6UC49neNO8IIxhl+dn06GifwOz5+1tBQ5tZqjX8fCrqG0M346YlYn5m2f
 S3hk1yf/xSz4dKmQJIa56JtN+s
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 01:29, Josef Bacik wrote:
> On Wed, Sep 07, 2022 at 10:31:58AM -0400, Josef Bacik wrote:
>> On Mon, Jul 11, 2022 at 02:37:52PM +0800, Qu Wenruo wrote:
>>> When committing a transaction, we will update block group items for al=
l
>>> dirty block groups.
>>>
>>> But in fact, dirty block groups don't always need to update their bloc=
k
>>> group items.
>>> It's pretty common to have a metadata block group which experienced
>>> several CoW operations, but still have the same amount of used bytes.
>>>
>>> In that case, we may unnecessarily CoW a tree block doing nothing.
>>>
>>> This patch will introduce btrfs_block_group::commit_used member to
>>> remember the last used bytes, and use that new member to skip
>>> unnecessary block group item update.
>>>
>>> This would be more common for large fs, which metadata block group can
>>> be as large as 1GiB, containing at most 64K metadata items.
>>>
>>> In that case, if CoW added and the deleted one metadata item near the =
end
>>> of the block group, then it's completely possible we don't need to tou=
ch
>>> the block group item at all.
>>>
>>> I don't have any benchmark to prove this, but this should not cause an=
y
>>> hurt either.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> I've been seeing random btrfs check failures on our overnight testing s=
ince this
>> patch was merged.  I can't blame it directly yet, I've mostly seen it o=
n
>> TEST_DEV, and once while running generic/648.  I'm running it in a loop=
 now to
>> reproduce and then fix it.
>>
>> We can start updating block groups before we're in the critical section=
, so we
>> can update block_group->bytes_used while we're updating the block group=
 item in
>> a different thread.  So if we set the block_group item to some value of
>> bytes_used, then update it in another thread, and then set ->commit_use=
d to the
>> new value we'll fail to update the block group item with the correct va=
lue
>> later.
>>
>> We need to wrap this bit in the block_group->lock to avoid this particu=
lar
>> problem.  Once I reproduce and validate the fix I'll send that, but I w=
anted to
>> reply in case that takes longer than I expect.  Thanks,
>
> Ok this is in fact the problem, this fixup made the problem go away.  Th=
anks,

This fix means, a bg members can change even we are at
update_block_group_item().

The old code is completely relying on the one time access on cache->used.

Anyway thanks for the fix.

Thanks,
Qu
>
> Josef
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6e7bb1c0352d..1e2773b120d4 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2694,10 +2694,16 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>   	struct extent_buffer *leaf;
>   	struct btrfs_block_group_item bgi;
>   	struct btrfs_key key;
> +	u64 used;
>
>   	/* No change in used bytes, can safely skip it. */
> -	if (cache->commit_used =3D=3D cache->used)
> +	spin_lock(&cache->lock);
> +	used =3D cache->used;
> +	if (cache->commit_used =3D=3D used) {
> +		spin_unlock(&cache->lock);
>   		return 0;
> +	}
> +	spin_unlock(&cache->lock);
>
>   	key.objectid =3D cache->start;
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2712,13 +2718,14 @@ static int update_block_group_item(struct btrfs_=
trans_handle *trans,
>
>   	leaf =3D path->nodes[0];
>   	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	btrfs_set_stack_block_group_used(&bgi, cache->used);
> +
> +	btrfs_set_stack_block_group_used(&bgi, used);
>   	btrfs_set_stack_block_group_chunk_objectid(&bgi,
>   						   cache->global_root_id);
>   	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>   	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>   	btrfs_mark_buffer_dirty(leaf);
> -	cache->commit_used =3D cache->used;
> +	cache->commit_used =3D used;
>   fail:
>   	btrfs_release_path(path);
>   	return ret;
