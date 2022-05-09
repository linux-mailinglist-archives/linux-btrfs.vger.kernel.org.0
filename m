Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A851FB09
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiEILQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiEILQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 07:16:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BF24978
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652094735;
        bh=mMuLX8ewJKScrIsUrocD6DjWkJXk3jtBT/zCBtlzqcg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=OKODGKh7Z8NnkTsDziYovcu2gZlUKyVg0e0WxDJ5TDY28bAauUVPPGw5HEO8gDLRu
         7W++98WMc/k3RB2AbT8SGT/9eYPl0HT3x2teM7imsWoa1KojHkA6tBSGhxQZ6544sU
         CzBiw/PxskRfdGxsWrelSO2SjT9dN+NQ1ymHLwU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1niVX83gdQ-007oer; Mon, 09
 May 2022 13:12:15 +0200
Message-ID: <9a9880f9-6e61-97c8-db9b-651d3518d0c7@gmx.com>
Date:   Mon, 9 May 2022 19:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
 <20220509095630.GA2270453@falcondesktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular
 extents
In-Reply-To: <20220509095630.GA2270453@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+81Hllw1BLngR11NLQrnNOb74m8Pm71/CLzn1VrEcXm1bb0tMk
 s3s2+5wtRCuHHn3ty65IoXZ4XrooVggmxZyv1m+Oi9eLCRQyMTjf09MZ4kReh3zTT05/6vy
 DWBP4sqcR/vzP5ot5Mg8qrwuihfhY6M3B4dbFdvC2BjjmTceS/HT2N5lSOHejKpeIrM28ki
 TCBmtM5cbSUJxsMJCTOsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:amNxOlcMdFw=:RmvIzefBZDCJC7wiJhIxiA
 1zl7fsO8fX0sFN7bek22RBMvP6oeytOSWUmxluw2Aa3Lxug2E3getI0kp83GrEdUbmz/aDyDV
 a8mE1xCqAAym3r/oyqSAxZEfLXOF2OJfxbjkHdJ2Douc7Wuf09hI0Ju7wYP2g/9jTiVutH717
 o7GdhXNdJCSvwwEqPVc9XxGKgqdHvMEc4qWRMp+gG17gq3vc7KM2FBvSyZLK7Ah6W0WaLRW5G
 /rJTdlfVIvn23v3Z+wccYGJ6pXsgaz0fHtVnvV+/6Vmtz789jObnu4GRZSYwkbBBo77TIMIIw
 o2ZqA+5rwmdVSzn/Aubrx3NncjhDeoURVZmgoh0sEttR3iVHb/ET9vNudT+pYGFs7ii+NBEYX
 foZRkHmnEjILDtydD1Yb9MapIm4UZCi937W9XDt/988w6Qmu+Q+TWWEFEK1Rvna6Q8zzInecP
 2smk7PzGBqBeq78Z/KQ2h4tGstinMHuQiEKsQEDaYg26tfF7xfiZDkUj/R7a9pxCv2/GcWQN0
 Bg/YGtF1pTTp03Fu2f/JgxCTBcR6qP9PA/zvvOuPI2nwkf0PRuNDfxjeDTOCPq/ng9WTtjSOE
 6M/DAVWQvbTLGEFOhgsOPFEd5MPiBUe/QEWkOKE/t1meY9wBqH7rtLezrkWKtaneICRy4gnzF
 iMkHoYIplSt/FQ2eYQymn4RVDpfIch87/9P1hcuTAeKicgsFx+EA0Y2lR4X76xxiMPrq73mcc
 uqCTQH5NmI4nia13TONUmkhAjvEQ5IjbXRuCERCtoijZDwePQBt7dIAgLEf3D/fGATI0sajkk
 NNilQr5vCOHhlG/Z2iGSFb+sTU3O4ITXC/vpr1ycUsRj+Wwxa4gpc3poW94WLdCr3zbcjqj/K
 yhVWr38am/FnVQeCh4yo0mezLWRJCpuAERxYMVcAm8zrFVzGy/Qp0GrTihPGg4XyxfZS3iYha
 gGCBvnRd+9uwKG3Gw19U1nKPN6LW4cPMv0IFe/fpYd1pRCbimLGgHWfYXY9bNBPjmaiLptuY/
 lIyxCsfNqTjXvyjQAHC6bStXNyR3hYktsc6r6OptL9a3kNvPmdSybKGlcfhmpxWi5CBco3YSM
 dmqx12pewnYMo8=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/9 17:56, Filipe Manana wrote:
> On Sat, May 07, 2022 at 02:39:27PM +0800, Qu Wenruo wrote:
>> Btrfs defaults to max_inline=3D2K to make small writes inlined into
>> metadata.
>>
>> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
>> metadata usage, it should still cause less physical space used compared
>> to a 4K regular extents.
>>
>> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
>> users may find inlined extents causing too much space wasted, and want
>> to convert those inlined extents back to regular extents.
>>
>> Unfortunately defrag will unconditionally skip all inline extents, no
>> matter if the user is trying to converting them back to regular extents=
.
>>
>> So this patch will add a small exception for defrag_collect_targets() t=
o
>> allow defragging inline extents, if and only if the inlined extents are
>> larger than max_inline, allowing users to convert them to regular ones.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 9d8e46815ee4..852c49565ab2 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>   		if (!em)
>>   			break;
>>
>> -		/* Skip hole/inline/preallocated extents */
>> -		if (em->block_start >=3D EXTENT_MAP_LAST_BYTE ||
>> +		/*
>> +		 * If the file extent is an inlined one, we may still want to
>> +		 * defrag it (fallthrough) if it will cause a regular extent.
>> +		 * This is for users who want to convert inline extents to
>> +		 * regular ones through max_inline=3D mount option.
>> +		 */
>> +		if (em->block_start =3D=3D EXTENT_MAP_INLINE &&
>> +		    em->len <=3D inode->root->fs_info->max_inline)
>> +			goto next;
>> +
>> +		/* Skip hole/delalloc/preallocated extents */
>> +		if (em->block_start =3D=3D EXTENT_MAP_HOLE ||
>> +		    em->block_start =3D=3D EXTENT_MAP_DELALLOC ||
>>   		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>   			goto next;
>>
>> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>   		if (em->len >=3D get_extent_max_capacity(em))
>>   			goto next;
>>
>> +		/*
>> +		 * For inline extent it should be the first extent and it
>> +		 * should not have a next extent.
>
> This is misleading.
>
> As you know, and we've discussed this in a few threads in the past, ther=
e are
> at least a couple causes where we can have an inline extent followed by =
other
> extents. One has to do with compresson and the other with fallocate.

Yes, I totally know the case. That's why I only mentioned "should", not
"must".

>
> So either this part of the comment should be rephrased or go away.

Since Anand questioned why we need to skip the next mergeable check, it
looks like we'd better re-phase it.

What about "normally inline extents should have no more extent after it,
thus @next_mergeable would be false under most cases."?

Thanks,
Qu

>
> This is also a good oppurtunity to convert cases where we have an inline=
d
> compressed extent followed by one (or more) extents:
>
>    $ mount -o compress /dev/sdi /mnt
>    $ xfs_io -f -s -c "pwrite -S 0xab 0 4K" -c "pwrite -S 0xcd -b 16K 4K =
16K" /mnt/foobar
>
> In this case a defrag could mark the [0, 20K[ for defrag and we end up s=
aving
> both data and metadata space (one less extent item in the fs tree and ma=
ybe in
> the extent tree too).
>
> Thanks.
>
>> +		 * If the inlined extent passed all above checks, just add it
>> +		 * for defrag, and be converted to regular extents.
>> +		 */
>> +		if (em->block_start =3D=3D EXTENT_MAP_INLINE)
>> +			goto add;
>> +
>>   		next_mergeable =3D defrag_check_next_extent(&inode->vfs_inode, em,
>>   						extent_thresh, newer_than, locked);
>>   		if (!next_mergeable) {
>> --
>> 2.36.0
>>
