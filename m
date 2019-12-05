Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBA113D0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfLEIdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 03:33:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:53991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEIdF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 03:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575534782;
        bh=I8v8Xd0yAnmqz09cQakg/xuOvPyDREKF6rXjNOWb7i8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YJxtOHacLOeA4LwTpxPZIXPmXqlU+kRullLeRZVq920sOjC8I43nyb8WC3QHsq6/c
         GisiXQJ1YnJswWXiNyhSDCkM4W2LrPokO30/G/uXhzE6UJXd+ybtgQCemsg/pI42oU
         6dVxZHMEzzRKWO7gvsBD4cyjQF0onsjGN0IIYdQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.169] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU9Z-1i8gwQ2qSB-00egwF; Thu, 05
 Dec 2019 09:33:02 +0100
Subject: Re: [PATCH 03/10] btrfs-progs: port block group cache tree insertion
 and lookup functions
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-4-Damenly_Su@gmx.com>
 <d75b62a9-b88b-d44c-16b5-55ebef426534@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <f84fa08d-219e-3ea7-7f11-7153a2045af1@gmx.com>
Date:   Thu, 5 Dec 2019 16:32:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <d75b62a9-b88b-d44c-16b5-55ebef426534@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kfewxswLf3NdUVI+7h4KInK4Wui8Ig9nghaFRwzVyUlGvJsdVFJ
 H0HECW2dIP+0Au68BzdbYa7TCV3YW8ojXZRpEmfUWI7DuY9EgK0RaqQmvI6bn/94WfUc6m3
 ZQ3hUqfXdhdo8/qcVyGIWF36acUNtiSPsSku4CcsL+8wZHogkgcJgo5NDDztLTIS8RUapIg
 f5DfserWMYL4ER/bcB4Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oqfxCN8Klq8=:tbMCa1+PwwwBmT5uSpSf4w
 fOfhhOYZOooeTtyTa5MBcDxXlv/QKadNmXw1MuIsN0Du9I106q1qvmYMy2k8/x/LyFwA+V2lN
 Ae2tZ86bQKOUAlgK3wMIvdeeiFR43oSkKnAkFciWu4S40wK991zl3pqAUd4adstyDUTp2X4IR
 1lMRA1QjsyeuXy/pJIfjrOEC1HXylIISqPDtuGYdID4tv6bPI/CfFfI8rj0xuoDceZW1ji7VI
 eRqITO4SdxltMeNcKcN6PpPdOtAlWk1KK2QPXdLthY3jXqrL0EULrQBF6aDlFI1s2BuNZbNE9
 gHWa/n4lCrTZpQOWGi8EJW3P30UV4X9nNm0yRbN8iBlJUjTM+jxbRcV5F/p/pPXagUdcTHgOd
 TJonCHTUPyPD8CblmjrkrLVKmNOxQWYcsFtRzqJKxOVQXB1pTifE24PFLmzitgL+xWePe5uyp
 Zel5f8gBqvhrerQzsOCv7fU2wT5PUl7KXNRlPcLk9kyiSrk1rCFnS/Jo+Om+/Z/BqQtS15/4H
 Cjp/AMB9CE/0OIy6CcpBFmTQHvumKOjHEAWudKpafF1gCGkY69ucCO+9uqQcLwzaeS6EOvFnR
 vBZ2i1kWRfjjeQ+RQo3c9GMwk7MeEnqob1eQXwb67bZZV1odVhkxgadsoJ1RVUQu+DhKpSk0U
 NvekTM4GAI2uW25kxF0pnUITBqBfqpQNcbU3BEPLLYHptfISNj8gUpmna2MJxp8CD+8fL1hPo
 CzAJlnYh6rOj0/l4AI4I1eiw/0xdXDZbVtuJ30RLxf3jR+vIwVPeN6IS2pSgqvWk7R9flDqgj
 SOjmRs6PcL6C/M9j4infykoMWxzNXCeQnxORz78J9b9Wi7FNce9aSXuVdSgSf+ZTGlTawUm9W
 V5rG/oeEri+uC9acjUcqB5yV0DG9n0HInVlrXU1sL5ieMj2cxVUwXVGev0rPyncP6gmT5FI4O
 S8dtvlPF3p9x5ofkbcSy2AwL723kX4se0Uge0yuBuQuZzFMJH2rj1WIS23Nnn6RdzzCY6kQ55
 0vmRknz0k5Wlxu8THU/30+HpLYiJ4MCPtjNlNFC1lwgxDtgXp7h2LPBrSS221VzQ1Gr55HAzS
 OmEvofaNqWuB7keSca3NKOAcU3TuE9ZKvaOuCuwWoI8ecuHO6ix866Wg7/zUeyPGa1srsCQJ/
 OWrCmZ2/y3w2jKlQjo2MZ4wydnB4+1JkJooTcxrcuR/Q+bC7PBv5C+t7FfCHwjwEwZ3b9qkGH
 RWD4R4ZBOacH6FGOxdAuD4UgJxeXp1zr23R+JptdhdvzWDhBLS3/ovK3baIA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/5 3:29 PM, Qu Wenruo wrote:
>
>
> On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> Simple copy and paste codes, remove useless lock operantions in progs.
>> Th new coming lookup functions are named with suffix _kernel in
>> temporary.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just an extra hint, it would be much better if we backport this
> functions to block-group.c.
>
Considered it, then porting functions moved will not require
any suffixes to avoid conflictions. It will be more clean while doing
reform work. But I wonder if it's a proper timing to create
block-group.c in progs.

Thanks
> Thanks,
> Qu
>> ---
>>   extent-tree.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 86 insertions(+)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 4a3db029e811..ab576f8732a2 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -164,6 +164,92 @@ err:
>>   	return 0;
>>   }
>>
>> +/*
>> + * This adds the block group to the fs_info rb tree for the block grou=
p cache
>> + */
>> +static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
>> +				struct btrfs_block_group_cache *block_group)
>> +{
>> +	struct rb_node **p;
>> +	struct rb_node *parent =3D NULL;
>> +	struct btrfs_block_group_cache *cache;
>> +
>> +	p =3D &info->block_group_cache_tree.rb_node;
>> +
>> +	while (*p) {
>> +		parent =3D *p;
>> +		cache =3D rb_entry(parent, struct btrfs_block_group_cache,
>> +				 cache_node);
>> +		if (block_group->key.objectid < cache->key.objectid)
>> +			p =3D &(*p)->rb_left;
>> +		else if (block_group->key.objectid > cache->key.objectid)
>> +			p =3D &(*p)->rb_right;
>> +		else
>> +			return -EEXIST;
>> +	}
>> +
>> +	rb_link_node(&block_group->cache_node, parent, p);
>> +	rb_insert_color(&block_group->cache_node,
>> +			&info->block_group_cache_tree);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * This will return the block group at or after bytenr if contains is =
0, else
>> + * it will return the block group that contains the bytenr
>> + */
>> +static struct btrfs_block_group_cache *block_group_cache_tree_search(
>> +		struct btrfs_fs_info *info, u64 bytenr, int contains)
>> +{
>> +	struct btrfs_block_group_cache *cache, *ret =3D NULL;
>> +	struct rb_node *n;
>> +	u64 end, start;
>> +
>> +	n =3D info->block_group_cache_tree.rb_node;
>> +
>> +	while (n) {
>> +		cache =3D rb_entry(n, struct btrfs_block_group_cache,
>> +				 cache_node);
>> +		end =3D cache->key.objectid + cache->key.offset - 1;
>> +		start =3D cache->key.objectid;
>> +
>> +		if (bytenr < start) {
>> +			if (!contains && (!ret || start < ret->key.objectid))
>> +				ret =3D cache;
>> +			n =3D n->rb_left;
>> +		} else if (bytenr > start) {
>> +			if (contains && bytenr <=3D end) {
>> +				ret =3D cache;
>> +				break;
>> +			}
>> +			n =3D n->rb_right;
>> +		} else {
>> +			ret =3D cache;
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Return the block group that starts at or after bytenr
>> + */
>> +struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
>> +		struct btrfs_fs_info *info, u64 bytenr)
>> +{
>> +	return block_group_cache_tree_search(info, bytenr, 0);
>> +}
>> +
>> +/*
>> + * Return the block group that contains the given bytenr
>> + */
>> +struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
>> +		struct btrfs_fs_info *info, u64 bytenr)
>> +{
>> +	return block_group_cache_tree_search(info, bytenr, 1);
>> +}
>> +
>>   /*
>>    * Return the block group that contains @bytenr, otherwise return the=
 next one
>>    * that starts after @bytenr
>>
>
