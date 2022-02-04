Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60894A91B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 01:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353012AbiBDAj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 19:39:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:40735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236660AbiBDAj0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 19:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643935160;
        bh=RhKuVdJs0oys5fyXaZYArMWGoqFSFxLWhDRXBvvYKyo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=YnmMGdRBZB4YN3+8Z510Hmx9+eM4THBrFxPNlTB5Z52937nkggpc/fifREPwsN1NU
         hrkbeSuJ6QgL/vzThxEgo5vqyvpZMrll2UAlFp1exz71Xivn3X4ISESGEASUwnuWRi
         FhhEDDdC/ncFpMDCeqm1w9QS00M6CHI40tvAVg/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1n1has3mtx-00EcJX; Fri, 04
 Feb 2022 01:39:20 +0100
Message-ID: <26a4cefb-0cb9-c49b-0cea-880dff7a57a4@gmx.com>
Date:   Fri, 4 Feb 2022 08:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1643357469.git.wqu@suse.com>
 <fce83045d775e59ab8a6746e5ad09c474a0c90a2.1643357469.git.wqu@suse.com>
 <YfwTUlD3okcrD4Zw@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 4/4] btrfs: defrag: allow defrag_one_cluster() to large
 extent which is not a target
In-Reply-To: <YfwTUlD3okcrD4Zw@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PbwKk8d3zGAzL8BGp/eCaEly/U8u2CnCwoC9fnagjOIUjroj1cC
 oBZv/FUXnDkp8wi41V8pgpvuX7h24D8WKSqH56R0TUZgEatRSXiTai0InuYZ4/mjDhxOhGO
 1jVyZMsEt0bD8RS4yDQMq2OUKnb0BnQWg7A+itqW3V5slv47VzixxEYadJW7IksAzepyh2M
 n2390WLGKyBTc2WPnMEBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZpVsW12ovsc=:VfDDmHmBJnPpOd0Kz5h9ZG
 sgr2NSKDtplvZyHlWE8Hn52kC6z+HlnnvdR8N3x+d9BoBvuUa7eEAM6Th1BmJCKSualGGwQMa
 vld74QGHij40skolp0gX0v3K1+4pmhO3ysipA1fTQfM8WErtf413nAxyxiP5CHDFlFt75ZUtG
 9/OBQFjA65xHtEyJN3Y/X0jUK2wosiOj2wme8wv7mTUDaxY2CTA1RDefwuMX7nN2cJVX1+qp7
 4TiqffcaQfyt5AAitllJPL+ypIt+pf4rvB4CmIzCAmqZb74MBfgnudaIAcbHw1i6aPXwFWYmN
 rBf7X/Kd6BxYb6UM4Ell7+z8CfwqSH+f6WFzfSwGPeFz/6LdNgGs9WlPKT52Grrj5c5rr8GZQ
 LrB1nF1ENO1/Vv/BpHIDAnMlrfJumdjCDztjBE2nsPR6Ubv4G22vedscCTF+nVjO8Ro/tMi74
 pL1hNn/mc0Fbx5Zg0iChRIOxs+/5I/zbYQrGeXttaKJRDyJkQIFPHIHbDU/OzN1UPCMlUhVMu
 vqeJrGUfPxAtnZ8hzgDT2EICuE1P5/dtNToen8OZhkBTgEYih8HebITtUWi+vlMp20u/Otnj/
 cPi7sNwCt3gVrvghWuhiZOVsAU2STh/itOv7QbMeOGVTM2eZ3WKMXX5c38jEXl+PuHrdAuBtL
 smLejDwQoDKxL7mK4OV4/vEYnkiZcEtsSpxkoA7keHxqcdWLsw7zt5+irsq1Qa2pOuzX4jBfd
 N+RFGfop8DoLvDA8INjj/rGHC94Y9rQpRym+VzoLqgLgWRuoP2oMa6BD4QhGtvAGw6GDRMqID
 /sNeQF6mAewCTkZrrd70+rfBw0T0bDsr2gLglxNqro3L62er1xSmjDwHB1rkzkSePmJuyhgkd
 RVgZ1a7NWwRz+bU5cG8VXojoFGgpEbsk4YIgQDTrkaN1xWCTD9uRmIQikwspVY2CQLhhP/ci+
 exz7c+qlc+OWZjda+/LWyRwT+zLfrjGS6FpXr27adi/vDARVcqeLPVKSdrZaT+LJtAGZd+trD
 msehpsW/Ded0/kLS50sQjQju5n5M6cQSkLnWszS35e363z5f6K1mWMJ6RVA7SfCYddm4PdPNm
 MJ7SBFYHZXtR8Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 01:39, Filipe Manana wrote:
> On Fri, Jan 28, 2022 at 04:12:58PM +0800, Qu Wenruo wrote:
>> In the rework of btrfs_defrag_file(), we always call
>> defrag_one_cluster() and increase the offset by cluster size, which is
>> only 256K.
>>
>> But there are cases where we have a large extent (e.g. 128M) which
>> doesn't need to be defragged at all.
>>
>> Before the refactor, we can directly skip the range, but now we have to
>> scan that extent map again and again until the cluster moves after the
>> non-target extent.
>>
>> Fix the problem by allow defrag_one_cluster() to increase
>> btrfs_defrag_ctrl::last_scanned to the end of an extent, if and only if
>> the last extent of the cluster is not a target.
>>
>> The test script looks like this:
>>
>> 	mkfs.btrfs -f $dev > /dev/null
>>
>> 	mount $dev $mnt
>>
>> 	# As btrfs ioctl uses 32M as extent_threshold
>> 	xfs_io -f -c "pwrite 0 64M" $mnt/file1
>> 	sync
>> 	# Some fragemented range to defrag
>> 	xfs_io -s -c "pwrite 65548k 4k" \
>> 		  -c "pwrite 65544k 4k" \
>> 		  -c "pwrite 65540k 4k" \
>> 		  -c "pwrite 65536k 4k" \
>> 		  $mnt/file1
>> 	sync
>>
>> 	echo "=3D=3D=3D before =3D=3D=3D"
>> 	xfs_io -c "fiemap -v" $mnt/file1
>> 	echo "=3D=3D=3D after =3D=3D=3D"
>> 	btrfs fi defrag $mnt/file1
>> 	sync
>> 	xfs_io -c "fiemap -v" $mnt/file1
>> 	umount $mnt
>>
>> With extra ftrace put into defrag_one_cluster(), before the patch it
>> would result tons of loops:
>>
>> (As defrag_one_cluster() is inlined, the function name is its caller)
>>
>>    btrfs-126062  [005] .....  4682.816026: btrfs_defrag_file: r/i=3D5/2=
57 start=3D0 len=3D262144
>>    btrfs-126062  [005] .....  4682.816027: btrfs_defrag_file: r/i=3D5/2=
57 start=3D262144 len=3D262144
>>    btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=3D5/2=
57 start=3D524288 len=3D262144
>>    btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=3D5/2=
57 start=3D786432 len=3D262144
>>    btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=3D5/2=
57 start=3D1048576 len=3D262144
>>    ...
>>    btrfs-126062  [005] .....  4682.816043: btrfs_defrag_file: r/i=3D5/2=
57 start=3D67108864 len=3D262144
>>
>> But with this patch there will be just one loop, then directly to the
>> end of the extent:
>>
>>    btrfs-130471  [014] .....  5434.029558: defrag_one_cluster: r/i=3D5/=
257 start=3D0 len=3D262144
>>    btrfs-130471  [014] .....  5434.029559: defrag_one_cluster: r/i=3D5/=
257 start=3D67108864 len=3D16384
>
> Did you also measure how much time was spent before and after?
> It would be interesting to have it here in case you have measured it.
> If you don't have it, then it's fine.

I don't have the exact time spent.

But the trace contains the timestamp, and even with the old behavior,
the time spent before defragging the last cluster is pretty tiny, only 17n=
s.

>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 67ba934be99e..592a542164a4 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1197,10 +1197,11 @@ struct defrag_target_range {
>>    */
>>   static int defrag_collect_targets(struct btrfs_inode *inode,
>>   				  const struct btrfs_defrag_ctrl *ctrl,
>> -				  u64 start, u32 len, bool locked,
>> -				  struct list_head *target_list)
>> +				  u64 start, u32 len, u64 *last_scanned_ret,
>> +				  bool locked, struct list_head *target_list)
>>   {
>>   	bool do_compress =3D ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
>> +	bool last_target =3D false;
>>   	u64 cur =3D start;
>>   	int ret =3D 0;
>>
>> @@ -1210,6 +1211,7 @@ static int defrag_collect_targets(struct btrfs_in=
ode *inode,
>>   		bool next_mergeable =3D true;
>>   		u64 range_len;
>>
>> +		last_target =3D false;
>>   		em =3D defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>>   		if (!em)
>>   			break;
>> @@ -1259,6 +1261,7 @@ static int defrag_collect_targets(struct btrfs_in=
ode *inode,
>>   		}
>>
>>   add:
>> +		last_target =3D true;
>>   		range_len =3D min(extent_map_end(em), start + len) - cur;
>>   		/*
>>   		 * This one is a good target, check if it can be merged into
>> @@ -1302,6 +1305,17 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>   			kfree(entry);
>>   		}
>>   	}
>> +	if (!ret && last_scanned_ret) {
>> +		/*
>> +		 * If the last extent is not a target, the caller can skip to
>> +		 * the end of that extent.
>> +		 * Otherwise, we can only go the end of the spcified range.
>> +		 */
>> +		if (!last_target)
>> +			*last_scanned_ret =3D cur;
>> +		else
>> +			*last_scanned_ret =3D start + len;
>
> Might be just me, but I found the name "last_target" a bit harder to
> decipher. Something like "last_is_target" seems more clear to me, as
> it indicates if the last extent we found was a target for defrag.

Indeed sounds better.

>
>> +	}
>>   	return ret;
>>   }
>>
>> @@ -1405,7 +1419,7 @@ static int defrag_one_range(struct btrfs_inode *i=
node,
>>   	 * And this time we have extent locked already, pass @locked =3D tru=
e
>>   	 * so that we won't relock the extent range and cause deadlock.
>>   	 */
>> -	ret =3D defrag_collect_targets(inode, ctrl, start, len, true,
>> +	ret =3D defrag_collect_targets(inode, ctrl, start, len, NULL, true,
>>   				     &target_list);
>>   	if (ret < 0)
>>   		goto unlock_extent;
>> @@ -1448,6 +1462,7 @@ static int defrag_one_cluster(struct btrfs_inode =
*inode,
>>   			      struct btrfs_defrag_ctrl *ctrl, u32 len)
>>   {
>>   	const u32 sectorsize =3D inode->root->fs_info->sectorsize;
>> +	u64 last_scanned;
>>   	struct defrag_target_range *entry;
>>   	struct defrag_target_range *tmp;
>>   	LIST_HEAD(target_list);
>> @@ -1455,7 +1470,7 @@ static int defrag_one_cluster(struct btrfs_inode =
*inode,
>>
>>   	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
>>   	ret =3D defrag_collect_targets(inode, ctrl, ctrl->last_scanned, len,
>> -				     false, &target_list);
>> +				     &last_scanned, false, &target_list);
>
> So I would revert the logic here.
> What I mean is, to pass a non-NULL pointer *last_scanned_ret to defrag_c=
ollect_targets()
> when it's called at defrag_one_range(), and then here, at defrag_one_clu=
ster(), pass it NULL
> instead.

The main reason to pass it to defrag_one_cluster() call site but not
defrag_one_range() one is to reduce the parameter for defrag_one_range().

>
> The reason is simple and I think makes more sense:
>
> 1) defrag_one_cluster() does a first call to defrag_collect_targets() to=
 scan
>     for the extents maps in a range without locking the range in the ino=
de's
>     iotree;
>
> 2) Then for each range it collects, we call defrag_one_range(). That wil=
l
>     lock the range in the io tree and then call again defrag_collect_tar=
gets(),
>     this time extent maps may have changed (due to concurrent mmap write=
s, etc).
>     So it's this second time that we can have an accurate value for
>     *last_scanned_ret

One of the design is to not use so accurate values for accounting
(again, to pass less parameters down the chain), thus things like
btrfs_defrag_ctrl::sectors_defragged is not that accurate.

But since you mentioned, I guess I can update them to the most accurate
accounting, especially after the btrfs_defrag_ctrl refactor, there is
already less parameters to pass around.

Thanks,
Qu

>
> That would deal with the case where first pass considered a range for
> defrag, but then in the second pass we skipped a subrange because in the
> meanwhile, before we locked the range in the io tree, it got a large ext=
ent.
>
> Thanks.
>
>
>>   	if (ret < 0)
>>   		goto out;
>>
>> @@ -1496,6 +1511,8 @@ static int defrag_one_cluster(struct btrfs_inode =
*inode,
>>   		list_del_init(&entry->list);
>>   		kfree(entry);
>>   	}
>> +	if (!ret)
>> +		ctrl->last_scanned =3D last_scanned;
>>   	return ret;
>>   }
>>
>> @@ -1624,7 +1641,6 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>>   		btrfs_inode_unlock(inode, 0);
>>   		if (ret < 0)
>>   			break;
>> -		ctrl->last_scanned =3D cluster_end + 1;
>>   		if (ret > 0) {
>>   			ret =3D 0;
>>   			break;
>> --
>> 2.34.1
>>
