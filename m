Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF83E0E6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhHEGdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 02:33:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:40481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhHEGdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 02:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628145188;
        bh=M0g8B3KRWfIiB1VQxqlUWpm2uumn4ZYzRN0joa+1/Y8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cd1ei332v9Gq8dJOs+RPV071r+evSn6TC8y3CdJ74XMWjxei+xi+8MD2AUBBWbZRb
         qsjrW41lqcfiuXZOz5Mupgd8tiGib0drXFUxqFcfb6naFOjXrjF5iviuligWZwXkey
         wVIsUvmfX4jMc8RLt9+IFT6Hp9rZPFwAsXDRadfU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTN9-1mYR9C0rIb-00NVW8; Thu, 05
 Aug 2021 08:33:07 +0200
Subject: Re: [PATCH 2/7] btrfs: backref: Use btrfs_find_item in
 btrfs_find_one_extref
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-3-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <037aeb68-72f8-4ea3-e29b-145567df64f9@gmx.com>
Date:   Thu, 5 Aug 2021 14:33:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184854.10696-3-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lqzj4hNKaJcI8aBmwR15ZPFqgbhekASubyb0HKHGtEwovc4ze4R
 5fxxgRrjeLiPzL7nXy/jlzNQRXe7pf0JYl8fyS3ZJ90zCRswjR7QTfsDT03GkEZE1jAfpLo
 UKco1lTIM6Dl4+dSrHNXofzijbvURfTMSQ7Tu5ukF8PpEUu4TaYfQ1mSMaqXupdYBW5fFx1
 1SpWzABM0Y7tO4yYjXhOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fWLKtAhu9zc=:PyC0GxaIjFf7MM6mS7uxcO
 bulxv5Et/ogRa+MNk5gbFb5IMrY/0xpCD5qzUbEAVZ7BqJMT+WDt1dQQb9hMJO6H3ctDiLa4f
 n176HVeomiP2D8LDhm2fuYkwTqyHe2PFdgwMWkTbd7iKJoL45T3bga/aI32D8cOkdlaI5obkN
 KZQZuMuI7Shae/9jq+97i7iiC6TauZMDM4IYOYj2K8kndFaUiPh9vkQrappI8Ojwsq+B50NXX
 yBSN340ln4xGp4YR+g+aMLbyw9uUiv+AQlNBWamY3abt0HkQPq3xDsQXf3Pr39GZ+EoxBXSek
 9WZ0IKm6kEriTSvK2lqUzEE/6KheErP1VI4gxiBNrWrrm8aheUFJvtlu31FMm4IcOTE3vcRmJ
 GB/lXcBXdtPNontnsPLU3lFDgqrOqGfkrgtQ1qM+YaL/+WPLtAkL1vsA7/8Hc6g/9KcnpWDNE
 Lmu9ztu9f1Ca+HVC5fQl4LcaU2r2piXMuGPSEVswYd8d6qlKNb6P5LBDa+h/evitGYbDABOiv
 UDyfSmiEE8379bmGRs8Ipf6WygiiA8KsoHUGJ/SLAjXc539+bWlY+oWeF9jlq+EDke3TN0rQ5
 bHYDMYzHGLR2JS8TDznoNtkH09vJYaQ2SX1w4nuM3ulT74d6X6oUQDWg7IGjjO+g1aakMIh7c
 QIWulxtHDRcUpao06AgkT8jjyE+D1WfJzSmiKSS68ei0XyLkMnfP+ohZ71QgZdiag6bugvrC/
 cgcW3JMj49fvfAhwqHPVFRMiXhqwjd5vGi8uVMCZscLqDK428C/yW4fVWGFvdVfGaWJ0xZhT9
 u6dDHdXBuZ0ZjaHS8RG5eUlbb6HBDmpH5bDhmQkQAs5ntjyxJ2/dHcbXJlH8gv/h1IJFCFJPN
 7H57A7RqPMKh/KlPzvVPa8LKoeS7hqUu5JOnMAg1Hrkoe5gKXdYjNe48q+OSJwIQu+oYBQ4QN
 ESjWrRodifDXEi5Th7mH5ctEdFgPxu888t/w1B/nalQIj8dybWA4KPz6cZ8kdNdJOnBuuvxp7
 uVWQyqro5tTA6n1XPI1bWplQ+iboVziVEijTvE4zEJm5Hx6Kq7NjC5GXWok/s2GM4kYUUp5OA
 tVaRCs4sBmixpl6TV9K0pMkF+dqLu8Atl39309zOyrnJseSQAp8jy/CMw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
> btrfs_find_one_extref is using btrfs_search_slot and iterating over the
> slots, but in reality it only desires to find an extref, since there is
> a break without any condition at the end of the while clause.
>
> The function can be dramatically simplified by using btrfs_find_item, wh=
ich
> calls the btrfs_search_slot, compares if the objectid and type found
> are the same of those passed as search key, and calls
> btrfs_item_key_to_cpu if no error was found.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But a small nitpick inlined below.

> ---
>   fs/btrfs/backref.c | 64 ++++++++--------------------------------------
>   1 file changed, 11 insertions(+), 53 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 9e92faaafa02..57b955c8a875 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1588,67 +1588,25 @@ int btrfs_find_one_extref(struct btrfs_root *roo=
t, u64 inode_objectid,
>   			  struct btrfs_inode_extref **ret_extref,
>   			  u64 *found_off)
>   {
> -	int ret, slot;
> +	int ret;
>   	struct btrfs_key key;
> -	struct btrfs_key found_key;
>   	struct btrfs_inode_extref *extref;
> -	const struct extent_buffer *leaf;
>   	unsigned long ptr;
>
> -	key.objectid =3D inode_objectid;
> -	key.type =3D BTRFS_INODE_EXTREF_KEY;
> -	key.offset =3D start_off;
> -
> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	ret =3D btrfs_find_item(root, path, inode_objectid, BTRFS_INODE_EXTREF=
_KEY,
> +			      start_off, &key);
>   	if (ret < 0)
>   		return ret;
> +	else if (ret > 0)
> +		return -ENOENT;
>
> -	while (1) {
> -		leaf =3D path->nodes[0];
> -		slot =3D path->slots[0];
> -		if (slot >=3D btrfs_header_nritems(leaf)) {
> -			/*
> -			 * If the item at offset is not found,
> -			 * btrfs_search_slot will point us to the slot
> -			 * where it should be inserted. In our case
> -			 * that will be the slot directly before the
> -			 * next INODE_REF_KEY_V2 item. In the case
> -			 * that we're pointing to the last slot in a
> -			 * leaf, we must move one leaf over.
> -			 */
> -			ret =3D btrfs_next_leaf(root, path);
> -			if (ret) {
> -				if (ret >=3D 1)
> -					ret =3D -ENOENT;
> -				break;
> -			}
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> -
> -		/*
> -		 * Check that we're still looking at an extended ref key for
> -		 * this particular objectid. If we have different
> -		 * objectid or type then there are no more to be found
> -		 * in the tree and we can exit.
> -		 */
> -		ret =3D -ENOENT;
> -		if (found_key.objectid !=3D inode_objectid)
> -			break;
> -		if (found_key.type !=3D BTRFS_INODE_EXTREF_KEY)
> -			break;
> -
> -		ret =3D 0;
> -		ptr =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
> -		extref =3D (struct btrfs_inode_extref *)ptr;
> -		*ret_extref =3D extref;
> -		if (found_off)
> -			*found_off =3D found_key.offset;
> -		break;
> -	}
> +	ptr =3D btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);

@ptr is only a temporary variable.

We can replace it with:

extref =3D btrfs_item_ptr(path->nodes[0], path->slots[0], struct
btrfs_inode_extref);

Thanks,
Qu
> +	extref =3D (struct btrfs_inode_extref *)ptr;
> +	*ret_extref =3D extref;
> +	if (found_off)
> +		*found_off =3D key.offset;
>
> -	return ret;
> +	return 0;
>   }
>
>   /*
>
