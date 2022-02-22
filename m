Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5444C056D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 00:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiBVXmo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiBVXmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 18:42:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9525599
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645573329;
        bh=ahQ+ZWAsSW6mN0aTVTGFnBsVEitMcE/G7fD3QxbnyBI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=kY7IWgGfz4IGAFp+2ZrMUG7UvvUwfKF/seIMJpBjE13f7eNzpXyKdyXk/o4R+9zfw
         YtIdm70VKNpNpAmMBDPFAOenSxXwNXYRHCZGFzul+QlTZVVT7hDbO2LcGM2eZ0vs5b
         JJbqa81HT6SS8nA06DYW06vkvdtnUQFXL6n8MsSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1npiFG2dSM-00TCev; Wed, 23
 Feb 2022 00:42:09 +0100
Message-ID: <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
Date:   Wed, 23 Feb 2022 07:42:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220222173202.GL12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KXZKgWY6yBSE73WY5oEJzsWA86ajE0xbkLhsGsIZ2xJvoZcHRri
 VA1EueD3ihEb/uRER23stqyjjCgac0dzteSgnR5La8xP8iTqXKd4vOY7picP9BZYDLar8c9
 ZNH4LU8TuElnyosfICFzbZ1EbIYYRXOdH1IhSZNciR9cT3A9FeE+N+5v/jzwHDcP1D4p7c+
 XABZlv8k9M39abIx3/LrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bfvkpSJuH4o=:IxvFnC3L7i6154fzH4HK7s
 Y1PA3M7wjpQaHa/QTLLGVFmsKi9lFHptwFpY7EMYEjOjPigV7ohW7L8XH9c6PjVbiN1iuYvw/
 KCJpyLTYv5Dwk390ipE5eZuABb8QFZxPyB5VKImyn1M2Mj495E0mOSjwcd5vLwTMdE/Frq7tk
 IlaA2SZTgceX5CqN7CPCVPmksfQ9A1VWwaZWCfmCvXUAc9gIw/V2pUuYzM3g88XFcLTHV6VBC
 FCDnXAQbGARjlYKL3Irx2SXUOaWzgsas7hse7Z8Xu5cK4EkMC7EH5tgvV+NqSJfHCLq23S5LD
 3frS1Rn84oR92RFSsHsqhJvDFq8EPCxgW9mxEy+pYbPrxwmGjHfH0XkOR2cipkMBp+gVQdyWM
 jDWI4EK7xmtkTnkJE/zq3EfmQIbOZ/w5DlmHOspmZVY21i9KE3v2W9VXVcpcgfVdUFOSzrTHU
 /1afNdCwjl8bAcEQDhnO/zs3Ot6YsmOVXcKQ8SaJ4SqqGHbmzaqT7uycgIh04bULJfgHkOzgh
 +u7wooB/qwyMP5Cq7q31jx2Bwp34DGK527rg52+TJP3nWIDCNxNPE221V5XnFYuwgxmCoqWCt
 BB8c2i0r11fqOzIQsoJyA7DNKhCe/i5SDAYgzCbyLERvF5UQplAFPFxnOSlmKgA3BRMo2BxsO
 ZBYftagl/M6wgAsCczJLAgLWBbeGIv1CO3GPqJhp2rvAe2+JMFDowzktY6lEPqZFjV9Cb1fwj
 meVGXPoDnyitl/EclAg5xXUf5q6PxNoquFz4JMtmFWccDVbB9b60kbZVnFTiJVCASadm59cIW
 0CAeTvTAiZf82OAlB4TuY9luEE75K7d/GHuWnL5TGJxWiuQ+Ue6N4487UBe/wAjg8xdxCWvwT
 XWAztMEshJS6vQ1wPyUAz20m+wM5pGpql75uO8L91TkgVpukoh3QEIEWUSmy39XeT0fh+el6p
 lkjcjAC1w5jRlR5jLs8sY0CP34+nY9yLE+twGjcopGrAEDcgVDG0R5dy8LWauvmxuGARY0uQJ
 OSQ2GlbJRUPz4JC6l/vuZV+AeYRP96Pc+mvG40oaffRlGsub5IdIT9Snp5uQR7u7N9+DJ/CyG
 pd4xpkmr4GaSDc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 01:32, David Sterba wrote:
> On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
>> Although we have btrfs_requeue_inode_defrag(), for autodefrag we are
>> still just exhausting all inode_defrag items in the tree.
>>
>> This means, it doesn't make much difference to requeue an inode_defrag,
>> other than scan the inode from the beginning till its end.
>>
>> This patch will change the beahvior by always scan from offset 0 of an
>> inode, and till the end of the inode.
>>
>> By this we get the following benefit:
>>
>> - Straight-forward code
>>
>> - No more re-queue related check
>>
>> - Less members in inode_defrag
>>
>> We still keep the same btrfs_get_fs_root() and btrfs_iget() check for
>> each loop, and added extra should_auto_defrag() check per-loop.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Below is a version of the patch without the control structure and with a
> manual while (true) loop so there's not that much code moved and it's
> clear what's being added. I haven't tested it yet, but this is what I'd
> like to get merged and then forwarded to stable so we can finally get
> over this.
>
>   fs/btrfs/file.c | 84 +++++++++++++------------------------------------
>   1 file changed, 22 insertions(+), 62 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 62c4edd5e2f9..1efc378e4bbe 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -49,12 +49,6 @@ struct inode_defrag {
>
>   	/* root objectid */
>   	u64 root;
> -
> -	/* last offset we were able to defrag */
> -	u64 last_offset;
> -
> -	/* if we've wrapped around back to zero once already */
> -	int cycled;
>   };
>
>   static int __compare_inode_defrag(struct inode_defrag *defrag1,
> @@ -107,8 +101,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_ino=
de *inode,
>   			 */
>   			if (defrag->transid < entry->transid)
>   				entry->transid =3D defrag->transid;
> -			if (defrag->last_offset > entry->last_offset)
> -				entry->last_offset =3D defrag->last_offset;
>   			return -EEXIST;
>   		}
>   	}
> @@ -178,34 +170,6 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handl=
e *trans,
>   	return 0;
>   }
>
> -/*
> - * Requeue the defrag object. If there is a defrag object that points t=
o
> - * the same inode in the tree, we will merge them together (by
> - * __btrfs_add_inode_defrag()) and free the one that we want to requeue=
.
> - */
> -static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
> -				       struct inode_defrag *defrag)
> -{
> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	int ret;
> -
> -	if (!__need_auto_defrag(fs_info))
> -		goto out;
> -
> -	/*
> -	 * Here we don't check the IN_DEFRAG flag, because we need merge
> -	 * them together.
> -	 */
> -	spin_lock(&fs_info->defrag_inodes_lock);
> -	ret =3D __btrfs_add_inode_defrag(inode, defrag);
> -	spin_unlock(&fs_info->defrag_inodes_lock);
> -	if (ret)
> -		goto out;
> -	return;
> -out:
> -	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> -}
> -
>   /*
>    * pick the defragable inode that we want, if it doesn't exist, we wil=
l get
>    * the next one.
> @@ -278,8 +242,14 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs=
_info *fs_info,
>   	struct btrfs_root *inode_root;
>   	struct inode *inode;
>   	struct btrfs_ioctl_defrag_range_args range;
> -	int num_defrag;
> -	int ret;
> +	int ret =3D 0;
> +	u64 cur =3D 0;
> +
> +again:
> +	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
> +		goto cleanup;
> +	if (!__need_auto_defrag(fs_info))
> +		goto cleanup;
>
>   	/* get the inode */
>   	inode_root =3D btrfs_get_fs_root(fs_info, defrag->root, true);
> @@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct btrfs_f=
s_info *fs_info,
>   		goto cleanup;
>   	}
>
> +	if (cur >=3D i_size_read(inode)) {
> +		iput(inode);
> +		break;

Would this even compile?
Break without a while loop?

To me, the open-coded while loop using goto is even worse.
I don't think just saving one indent is worthy.

Where can I find the final version to do more testing/review?

Thanks,
Qu

> +	}
> +
>   	/* do a chunk of defrag */
>   	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
>   	memset(&range, 0, sizeof(range));
>   	range.len =3D (u64)-1;
> -	range.start =3D defrag->last_offset;
> +	range.start =3D cur;
>
>   	sb_start_write(fs_info->sb);
> -	num_defrag =3D btrfs_defrag_file(inode, NULL, &range, defrag->transid,
> +	ret =3D btrfs_defrag_file(inode, NULL, &range, defrag->transid,
>   				       BTRFS_DEFRAG_BATCH);
>   	sb_end_write(fs_info->sb);
> -	/*
> -	 * if we filled the whole defrag batch, there
> -	 * must be more work to do.  Queue this defrag
> -	 * again
> -	 */
> -	if (num_defrag =3D=3D BTRFS_DEFRAG_BATCH) {
> -		defrag->last_offset =3D range.start;
> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> -	} else if (defrag->last_offset && !defrag->cycled) {
> -		/*
> -		 * we didn't fill our defrag batch, but
> -		 * we didn't start at zero.  Make sure we loop
> -		 * around to the start of the file.
> -		 */
> -		defrag->last_offset =3D 0;
> -		defrag->cycled =3D 1;
> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
> -	} else {
> -		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
> -	}
> -
>   	iput(inode);
> -	return 0;
> +
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	cur =3D max(cur + fs_info->sectorsize, range.start);
> +	goto again;
> +
>   cleanup:
>   	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>   	return ret;
