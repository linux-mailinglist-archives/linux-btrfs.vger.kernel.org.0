Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614A49C8B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 12:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiAZLdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 06:33:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:51119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240752AbiAZLdK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 06:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643196784;
        bh=97/IhRhKyvJiQCGpCyS6S/mHr4CsMCYt1U5Zqr3ggbY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A9NsC96j4SB2PaZitjUQy29HbPhVsgvKbdNAhwTZyZf9/ZN7bjTrReiYaU5Cq0YbK
         s0LVFUEZVBoxfIHM+vO9lvAAn1FDl3TQZ88ZmoljJsGmOoCLWsBuHC/7MNV6TZ8o8w
         uec0ScL5w/ZzqGU7BDYMatrcj6MrmF3Yhagj3xbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1m97We28rD-0154qI; Wed, 26
 Jan 2022 12:33:04 +0100
Message-ID: <a4e09bf5-7919-1935-98f4-669484df4c62@gmx.com>
Date:   Wed, 26 Jan 2022 19:33:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] btrfs: defrag: don't try to merge regular extents
 with preallocated extents
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220126005850.14729-1-wqu@suse.com>
 <YfEv5THyUX/UoNZa@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YfEv5THyUX/UoNZa@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m/ldV09AcGfnpOvjSQvuWGY9G4WfNwbb65P2GUL0/4PtqauBW7N
 1/24Bnb6pnj+zCYZL6ezWWR5Cw4oWaoOMcVHzWA1/rRVUN1k/FkkVIYlqsFih25paFPs/S6
 /JCTxMOOPQR+3eRWGmYXWZHxhPoeeGTALxA4jMXLPF0OHl54C312P75sK1F4Leeimv6wxXd
 HRZV6UYpWGM4CNauuSAzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h69Kqxrd4tc=:qtspJ5AaCFmc3X8uK5XnDv
 ujsHXiQLbit1X70SyKUMjJHVgVu68pnBCkQa+klabNxzR53q+qRocaMUpiMGh2/tw9EGSe5u7
 /GyIwu4/ninzw61fJh2iIToZ4LsxIfGgDWFZ5YtMgqTEmsdAZ64UdRpFH/SPYlP/g8WU4JH7T
 DawyTnaQ0pEyxcnL8c9JYeYUO3vMdc5U0DrDolfbMhCuAUEv2Uqn9UQmbgGZG44+0yXkYB1+C
 jWiYJhYq0hA38jAG5wgB5G10LAjNEwypBAh9C/npjOJkWVfxiDq76qDP/zQL5kXRaJmBo/fts
 s8rKacKcPYe3OpsioziFyWYXruaAzafC4cQQPv1bPsbdE/EvRXuI/p14M6G1s7Sw6mVGucU1C
 unwTyTKc3Q9F8oln6HrHqS9ABJ3hLD5y/8JKju8FH9I7q2dU8e8B8HllyAFqcM9vX9mMkodUA
 qfB19P4vsvlqf6GTsU7zRBSfckR/08YQYZcuMkyxyULvlJZCOFAq/jJemeIiAXm5Q60AUgFvH
 ypekneBDGQYVuoKF+RZVWu9cm00jRlTXs4b9HSqA4TNarqJveiyVmA5tGS/ZYDo6WPhmH96Fb
 VdFY0y3ZwVKGc8bQ7kGCWe0rrJxmH0Q0DKGBm8ikAJdTwSQV/zetRU/Eoa9e4BqLOI9nQAI4U
 WkzcYp8lEKNPbrF5ZrsW/m8OTOLJljD4fhdc/4M1dLk4NdCbsDCfJI3c59FssEC41DaK2ljoR
 7pmSBoToiv5+CQdS1AEFtlOSQbW94yQA35Nly0Uq/3ZWcWe9QQAMaRx8/UJXvOCthw3ioHJta
 441Ytl9OV4lJr/ecAanUCb7XdJl3Y5iQgxGR+iyCCWrDlrwtirhh1PXw8SZHUrNyr3kz6/pWh
 2Uy2O2SHHluvWuEarXi3Ff+hOlJPZvf2Z2crdYSK5kFhpy+3fY96zyJlBRVWZbm2y9b4o+MQt
 N8jSuBT71S/r889yKiUKUnKStrWayJWW0Z+njk6xqwB5A+Mn53Ab+jM4JY+atTdPvKaSTeAzw
 FVy4zE2ePqNv3b4qKeEmRP/6XeBiZUhUS35CS4M3BceQ6wJks5VQPq8mBUot8IrvCvq5Eslb+
 8112CrcdkI0VZk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 19:26, Filipe Manana wrote:
> On Wed, Jan 26, 2022 at 08:58:48AM +0800, Qu Wenruo wrote:
>> [BUG]
>> With older kernels (before v5.16), btrfs will defrag preallocated exten=
ts.
>> While with newer kernels (v5.16 and newer) btrfs will not defrag
>> preallocated extents, but it will defrag the extent just before the
>> preallocated extent, even it's just a single sector.
>
> In that case, isn't a Fixes: tag missing?

The function defrag_check_next_extent() is reused from older kernel
code, dating back to 2012.
(And even that 2012 commit is not really the root cause).
Thus it's missing preallocated check from the very beginning unfortunately=
.

Does it still make sense to include such an old commit?

It would make more sense to CC this to v5.x stable branch, though.

Any advice on this situation?

Thanks,
Qu
>
>>
>> This can be exposed by the following small script:
>>
>> 	mkfs.btrfs -f $dev > /dev/null
>>
>> 	mount $dev $mnt
>> 	xfs_io -f -c "pwrite 0 4k" -c sync -c "falloc 4k 16K" $mnt/file
>> 	xfs_io -c "fiemap -v" $mnt/file
>> 	btrfs fi defrag $mnt/file
>> 	sync
>> 	xfs_io -c "fiemap -v" $mnt/file
>>
>> The output looks like this on older kernels:
>>
>> /mnt/btrfs/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>     0: [0..7]:          26624..26631         8   0x0
>>     1: [8..39]:         26632..26663        32 0x801
>> /mnt/btrfs/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>     0: [0..39]:         26664..26703        40   0x1
>>
>> Which defrags the single sector along with the preallocated extent, and
>> replace them with an regular extent into a new location (caused by data
>> COW).
>> This wastes most of the data IO just for the preallocated range.
>>
>> On the other hand, v5.16 is slightly better:
>>
>> /mnt/btrfs/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>     0: [0..7]:          26624..26631         8   0x0
>>     1: [8..39]:         26632..26663        32 0x801
>> /mnt/btrfs/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>     0: [0..7]:          26664..26671         8   0x0
>>     1: [8..39]:         26632..26663        32 0x801
>>
>> The preallocated range is not defragged, but the sector before it still
>> gets defragged, which has no need for it.
>>
>> [CAUSE]
>> One of the function reused by the old and new behavior is
>> defrag_check_next_extent(), it will determine if we should defrag
>> current extent by checking the next one.
>>
>> It only checks if the next extent is a hole or inlined, but it doesn't
>> check if it's preallocated.
>>
>> On the other hand, out of the function, both old and new kernel will
>> reject preallocated extents.
>>
>> Such inconsistent behavior causes above behavior.
>>
>> [FIX]
>> - Also check if next extent is preallocated
>>    If so, don't defrag current extent.
>>
>> - Add comments for each branch why we reject the extent
>>
>> This will reduce the IO caused by defrag ioctl and autodefrag.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Use @extent_thresh from caller to replace the harded coded threshold
>>    Now caller has full control over the extent threshold value.
>>
>> - Remove the old ambiguous check based on physical address
>>    The original check is too specific, only reject extents which are
>>    physically adjacent, AND too large.
>>    Since we have correct size check now, and the physically adjacent ch=
eck
>>    is not always a win.
>>    So remove the old check completely.
>>
>> v3:
>> - Split the @extent_thresh and physicall adjacent check into other
>>    patches
>>
>> - Simplify the comment
>> ---
>>   fs/btrfs/ioctl.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 91ba2efe9792..0d8bfc716e6b 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1053,19 +1053,25 @@ static bool defrag_check_next_extent(struct ino=
de *inode, struct extent_map *em,
>>   				     bool locked)
>>   {
>>   	struct extent_map *next;
>> -	bool ret =3D true;
>> +	bool ret =3D false;
>>
>>   	/* this is the last extent */
>>   	if (em->start + em->len >=3D i_size_read(inode))
>> -		return false;
>> +		return ret;
>>
>>   	next =3D defrag_lookup_extent(inode, em->start + em->len, locked);
>> +	/* No more em or hole */
>>   	if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
>> -		ret =3D false;
>> -	else if ((em->block_start + em->block_len =3D=3D next->block_start) &=
&
>> -		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
>> -		ret =3D false;
>> -
>> +		goto out;
>> +	/* Preallocated */
>> +	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>
> The comment is superfluous, the name of the flag is pretty informative t=
hat
> we are checking for a preallocated extent. You don't need to send a new
> version just to remove the comment however.
>
> For the Fixes: tag, you can just comment and David will pick it.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>> +		goto out;
>> +	/* Physically adjacent and large enough */
>> +	if ((em->block_start + em->block_len =3D=3D next->block_start) &&
>> +	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
>> +		goto out;
>> +	ret =3D true;
>> +out:
>>   	free_extent_map(next);
>>   	return ret;
>>   }
>> --
>> 2.34.1
>>
