Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6483D474E96
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 00:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhLNXdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 18:33:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:57983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235236AbhLNXdz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 18:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639524832;
        bh=RrB5x/T2QNGV5mat+2vYymymduK18YSohYiZh7x23Is=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NIxJ6dMxPucNogmEFbbjVJ9u4/uQoMIYG/eQVFUF2I1gWl1xhw0SQIvnNeh9Jm8uW
         zLYCgREMniAO8orv6SYD2Duqcw6t181vl+3LV5O+bsU1y//Gk5+Lw/TX9a1PkIMxZh
         WdXEadJqPXN3USclPDzIyEeOcEAb3C0tO2nPLTy0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBm1e-1mnL9P2fIy-00C6Xb; Wed, 15
 Dec 2021 00:33:52 +0100
Message-ID: <6cca74a6-4c1d-c07d-93c0-67a3a95d1154@gmx.com>
Date:   Wed, 15 Dec 2021 07:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs: remove some duplicated checks in
 btrfs_previous_*_item()
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211214071411.48324-1-wqu@suse.com>
 <YbisMuAVHVnCxYg7@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YbisMuAVHVnCxYg7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lu1s6CyaLTfF7Ic6wNo9CUSpr+5MyqFuYyOYrnVQwh1pfNEez9W
 Og4BQj6+2jFS2cGpVulp9w+aEx1RqW2T61OxNPnkCRF24ruOc13BJTDNK/+vZL/kbS3S0A/
 v1DUEPU8iC5NTjCKL7qAU8ra66gjo3Q5SnJ19sT5LMoJaCWuL9SDktbXr15tamR++iTbyOI
 yVOqjXKnPP8AP0aDp6DNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OeiZ9oLo1VE=:TxYDWBxDwQ2qkhU4qsRRJF
 qGli/4PDyhal7zGqOitGwh9uEzNZHNmFYtXtnmnIrdpxrISL+YAYbDBHxJbN4Tu3NG2kH1tHe
 rx0o8FIloNDTw91P4bV/v/d0Od3o57lZfEJPIDim9+djkCnDox6H7XxL8+F4RdYEowUZf+YYL
 GieFyMtGLUT7DlmK1ealpdKDvYoeJF+McESBPa0D9+2yg1uXtSqj+HlbFI341Mp06PKZKN0Hi
 x3gM+Z2UVQszvUwunge2kcNVctpV1M4thi8dkTEOtTOPL9ZFwAOipazTm7E8AMyNTbQvuXEYu
 M5rC2hxmedsKsyXyJ23xJSYh+G31Scf0GQdswt7XXvtHWwvZwDm4reE99uscdqvjdURfNOxC5
 RyTIFUEww5Js2H0u66e7LobXBOytGV8L2pMFIkH3nVcQEuM39UuEbO5PAFTvz7mJo9gGuYoS4
 mpisXcs5MQ7ENl1OES/SDxqCyZFjK8L720TrUZiI0eSGI68OUkOHzdCGkLvHG57F0QUZgvUxi
 AKvQhw947yChun6VoqTUNNTh6AaqyHkJGVOYaSOJPutGK/4o/536EW7HPKE084Bw8BUUeM9x4
 aj61mIbojA1Hw2187hsid8F6xnNWOGhHeQfQKtCQAHorxY6r+WHdPxY5pMjgRXCxE4Wb2FH0e
 Gy7jxzaB4YUNSVEC5zuNsTwNdEbDppkI/Bx599iEhLraVgXibXWKD7TpceRPgcBnLdadaf/cB
 YvnqncsSAY40QzBAq9p9JeYkxuOP9wuEeduBl3YtX8yrEy/Nxl50Zu0ZRg0dGKowKJria47dH
 WxWrXEHmw/iSgS/M5yCM3OKldj1QDtwE4RTpSOzeMAhI7zcpYzHxT/lxuBtRIZZEkFh1PMKGf
 oOr1v4DmouaJY4TOfdpOFYU3+yjxTkM8dhgICYTzTLh6j9UXdvJo4/uIb/SlW9c2aM/RIJbVa
 4QY8WMizU9BeqU4kI4PSnUroitaqRc8YluaMWWRgGkgJ+5lIhxFVYCOHhStZWdeXk4WOCZT4C
 ApcDHINJn+muX56NNeeNG2E2Qs1TixxvYUlgKxLU1/tl5c7/KJLZbHxt0S74mDnNpS9uK2SJ5
 chDEm0iTpUOmeg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/14 22:37, Josef Bacik wrote:
> On Tue, Dec 14, 2021 at 03:14:11PM +0800, Qu Wenruo wrote:
>> In btrfs_previous_item() and btrfs_previous_extent_item() we check
>> btrfs_header_nritems() in a loop.
>>
>> But in fact we don't need to do it in a loop at all.
>>
>> Firstly, if a tree block is empty, the whole tree is empty and nodes[0]
>> is the tree root.
>> We don't need to do anything and can exit immediately.
>>
>> Secondly, the only timing we could get a slots[0] >=3D nritems is when =
the
>> function get called. After the first slots[0]--, the slot should always
>> be <=3D nritems.
>>
>> So this patch will move all the nritems related checks out of the loop
>> by:
>>
>> - Check nritems of nodes[0] to do a quick exit
>>
>> - Sanitize path->slots[0] before entering the loop
>>    I doubt if there is any caller setting path->slots[0] beyond
>>    nritems + 1 (setting to nritems is possible when item is not found).
>>    Sanitize path->slots[0] to nritems won't hurt anyway.
>>
>> - Unconditionally reduce path->slots[0]
>>    Since we're sure all tree blocks should not be empty, and
>>    btrfs_prev_leaf() will return with path->slots[0] =3D=3D nritems, we
>>    can safely reduce slots[0] unconditionally.
>>    Just keep an extra ASSERT() to make sure no tree block is empty.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.c | 52 +++++++++++++++++++++++++++++++++--------------=
-
>>   1 file changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 781537692a4a..555345aed84d 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -4704,23 +4704,39 @@ int btrfs_previous_item(struct btrfs_root *root=
,
>>   {
>>   	struct btrfs_key found_key;
>>   	struct extent_buffer *leaf;
>> -	u32 nritems;
>> +	const u32 nritems =3D btrfs_header_nritems(path->nodes[0]);
>>   	int ret;
>>
>> +	/*
>> +	 * Check nritems first, if the tree is empty we exit immediately.
>> +	 * And if this leave is not empty, none of the tree blocks of this ro=
ot
>> +	 * should be empty.
>> +	 */
>> +	if (nritems =3D=3D 0)
>> +		return 1;
>> +
>> +	/*
>> +	 * If we're several slots beyond nritems, we reset slot to nritems,
>> +	 * and it will be handled properly inside the loop.
>> +	 */
>> +	if (unlikely(path->slots[0] > nritems))
>> +		path->slots[0] =3D nritems;
>> +
>>   	while (1) {
>>   		if (path->slots[0] =3D=3D 0) {
>>   			ret =3D btrfs_prev_leaf(root, path);
>>   			if (ret !=3D 0)
>>   				return ret;
>> -		} else {
>> -			path->slots[0]--;
>>   		}
>>   		leaf =3D path->nodes[0];
>> -		nritems =3D btrfs_header_nritems(leaf);
>> -		if (nritems =3D=3D 0)
>> -			return 1;
>> -		if (path->slots[0] =3D=3D nritems)
>> -			path->slots[0]--;
>> +		ASSERT(btrfs_header_nritems(leaf));
>> +		/*
>> +		 * This is for both regular case and above btrfs_prev_leaf() case.
>> +		 * As btrfs_prev_leaf() will return with path->slots[0] =3D=3D nrite=
ms,
>> +		 * and we're sure no tree block is empty, we can go safely
>> +		 * reduce slots[0] here.
>> +		 */
>> +		path->slots[0]--;
>
> This requires trusting that the thing on disk was ok.  The tree-checker =
won't
> complain if we read a block with nritems =3D=3D 0.  I think it would be =
better to do
>
> 	if (btrfs_header_nritems(leaf) =3D=3D 0) {
> 		ASSERT(btrfs_header_nritems(leaf));
> 		return -EUCLEAN;
> 	}
>
> so we don't get ourselves in trouble.  Thanks,

Please discard the patch completely.

Filipe pointed out that, btrfs_prev_leaf() is a btrfs_search_slot() call
in fact, by searching previous key (current leave's first key value - 1).

Which could lead to a search slot hit (ret =3D=3D 0), thus this patch is
completely screwed up.

Thanks,
Qu
>
> Josef
