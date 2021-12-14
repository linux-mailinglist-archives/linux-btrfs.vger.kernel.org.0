Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14434740CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 11:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhLNKua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 05:50:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:59731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhLNKu2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 05:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639479020;
        bh=uwJLzdFTz1L6I21rYFvBHOxz7PzHf9UOZRltOa38T3M=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=IVRWx23+/VvsN/BIe+n86JCKSoUeGfGjp7u9DNZTEE0jEYpzaWR9sHuhAqsG1kQgS
         vsyD6N9yr0WkhoSNlhkcH1kYA6ogoSwEpTd2DpN3rxkU1e31Mzlrj25mWSwHdtRa79
         sNzw2CBZjNODaQ75XVmpFV0Pk0cTWQ8uH1PgXydY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1mImxN0OLd-00hRiL; Tue, 14
 Dec 2021 11:50:20 +0100
Message-ID: <0a61338e-fd6f-0500-b395-a1d4a868aa21@gmx.com>
Date:   Tue, 14 Dec 2021 18:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211214071411.48324-1-wqu@suse.com>
 <Ybhxngswi6vN+vH4@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove some duplicated checks in
 btrfs_previous_*_item()
In-Reply-To: <Ybhxngswi6vN+vH4@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZFnsK57U/cxW29cTNgzoRf+T+/XoJz82tL0KK2TWAN0WonAlkaQ
 FVJNHzGSL8AAQQJKCSsRbEm5CzTuUouGUPYy4bcPjzX+9BE1PZuYNv/kvkuCseTPsCA3XeL
 CBBAIZ4DqlxnQ57IFe/BF/TnMdbSTaKVuoj8BuM0CY6qq0glzGo41DjDUqq9uY31bhIEa5z
 sClvwhEnK6zkYKKwVRj1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7bDQtLRnk9I=:aVIVy2yy7kqnZxYv5YucJK
 2IvWn+mkm4EkqX3gTcLLE81pl/WMcDwaX43N1R+B0D8mukxST/WclLNkhtC+D4le9kXUKmmPW
 Kp2aFviB+rhei9DeKanuHtM8ucE3VJAcd49X9a3La0skoGivZRfKIKtMlI2JeBkeTpAMVawVO
 AyT4GdQ0dOx9jkISgS6Ps2SXAQJ0tm8sblhcVWQrE+mlhIRtItt6Mdx7SVWP6hTfxuBWLI2mt
 I/CDkneQNGXWXwk1MOWxsG9DRzzZOWfVNvuFCDIqsxgfKHrrJL+1EinJkJlqzPZUsq42l3WsT
 wQ1t/P51+xLenbdLGKb+NWVj9mLjU/4scE/O/ZLH/YxVBfcCT8trXUWkAlWLkKwwB3lRJJu3N
 +d3ik1o5lrgeJU8HaIb/9pKvwUtWJct0Z51+BrwqnpsF8o6J5wFlKLuB6q0+jXOwwey7IrNtx
 DML98fbqKgM1yuNGN3deQCLdYuKCAoN7dxFzRjDBExrB/UkH2OUbFfIjMC1zC/pX6bltBTshz
 tUUCHv/OEdkN9HLttlr4h4B6lOwaOkAQ6Z+e+m0Pedt36lQ+ozWOC/s+8GEDOgw0lcatll1dB
 bj2BjHxfqr9B/XGuQ0jp3ROcis0HYB+4pBMyG8FC5c5XfEQDYm+sE4IthBoEae6NbN8d9n7+f
 5IXCLnlls/2L2VCqBV0AQtmXRUtOzFWxK/ydrgF49rkdPnQ5LmB62GKNU9XziyaRabWym4Ct5
 X7hhazv3ADMaaBwatZgQ/O52mNimfQmEqaYrSdy79mVU8J3p/KILCWYIa0vu62cECSZpPwwKG
 s3uyzV4ZXry8D4Kfyz7+YXZ4Ak6srTtOAiGMiEJ23om2VXttWPVbIWErBLvBLDb80kFZACRam
 GJPkwAWsZ7fs+dlNA28r2rhZiYxSsbqGTVwlcF7CAZyoGx66YVGQc+sm7LmGBxvvBsribBQcK
 KOaUFrMlZj7or80w4T/5jOZqN5PCxWMUr0j5Rk7ljLtxUOVbgBWQaXMQH5hpLVKSGXaqqS7Qe
 nlIWBNHZObJzy1QE0xRizSEA9mSyLaRlZgrWD1N9JPtNRntQphkpjgNxA5c3qtRuJ9IYNa3Md
 AY97D95BRshJnU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/14 18:27, Filipe Manana wrote:
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
> No, this is wrong.
> btrfs_prev_leaf() computes the previous key and does a search_slot() for=
 it.
> With this unconditional decrement we can miss the previous key in 2 ways=
:
>
> 1) The previous key exists, and btrfs_prev_leaf() leaves us in a leaf th=
at has it
>     and the slot is btrfs_header_nritems(prev_leaf) - 1 -> the last key =
on a leaf;
>
> 2) The previous key exists, but after btrfs_prev_leaf() released the pat=
h and
>     before it called search_slot(), there was a balance operation and it=
 pushed the
>     previous key in the middle of the leaf we had, or some other leaf, a=
nd the slot
>     will be something less than btrfs_header_nritems(), it can even be 0=
.

You're totally right about both cases.

I totally forget that btrfs_prev_leaf() is using serch_slot() other than
going up several levels to find the sibling leaf.

Please discard the patch.

Thanks,
Qu

>
> That's why we have the call to header_nritems() in the loop, and check i=
f slots[0]
> is =3D=3D to nritems before decrementing...
>
> Thanks.
>
>
>>
>>   		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>>   		if (found_key.objectid < min_objectid)
>> @@ -4745,23 +4761,27 @@ int btrfs_previous_extent_item(struct btrfs_roo=
t *root,
>>   {
>>   	struct btrfs_key found_key;
>>   	struct extent_buffer *leaf;
>> -	u32 nritems;
>> +	const u32 nritems =3D btrfs_header_nritems(path->nodes[0]);
>>   	int ret;
>>
>> +	/*
>> +	 * Refer to btrfs_previous_item() for the reason of all nritems relat=
ed
>> +	 * checks/modifications.
>> +	 */
>> +	if (nritems =3D=3D 0)
>> +		return 1;
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
>> +		path->slots[0]--;
>>
>>   		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>>   		if (found_key.objectid < min_objectid)
>> --
>> 2.34.1
>>
