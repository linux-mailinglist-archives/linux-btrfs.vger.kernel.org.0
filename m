Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97363797F56
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjIGXvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjIGXvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:51:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA31BCB
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694130665; x=1694735465; i=quwenruo.btrfs@gmx.com;
 bh=dCKpkk8ZG/ICTve0CAOEsSweIFaGCMMsF/6pK09t7cw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=j+vr7R/IQA9a/r+aj+1AXXZjn5KQiQCpYS8hXXg58MBj2h30jqEBres6bJXnmqACwGsZB7x
 fHa4GFWaCXDE1913OlYshSfhOM/bc1ijiMCxDPhZvoAD1fGjJSgVVZo2WUBmrPdtehATImmjC
 5uiW3cJMmOLrZpAPoJwy3Zaa635Kk2wNfbmUVQP8pZch3NSZfSzeK42aX7V07PgIH07+B4UMO
 MyhKZ3AqT871/GJVJLfPPfWpmWEsMD0RFF5Y5jY6IL2m2zDzS/mGSnbLgZf54tieStfkoKuXf
 5rU3MxZY+J4Oalh4Z/GZwCARRGOAUItMXiWFwxwmtLwEwHQDZazg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1prqbj0wmh-00nPZz; Fri, 08
 Sep 2023 01:51:04 +0200
Message-ID: <d7d73c93-1565-4cf5-8710-48e61e79d466@gmx.com>
Date:   Fri, 8 Sep 2023 07:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] btrfs: reformat remaining kdoc style comments
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <6f4732200ecc2a0722323f68c91549c10c858c22.1694126893.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <6f4732200ecc2a0722323f68c91549c10c858c22.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W7XvIkwHUduyZ78EHKe+XWEyC8b8rbfDKDS2awzvZg8A6/TUp4f
 4tq6XoKDAnSA1tzKtX/3hi+TjlVfXdx6j44UaIUitdhCnxNou8mFVFK7U1D3ORqcmoDjSHI
 xJCWQjmscjW2fKoGoP+1RbPeDV72RIXgUgQEOU2dBvfV3lY4ENDfUYjBAt8dgESTSVdXGc7
 7UAa1gWAK1wdCkSwkfefA==
UI-OutboundReport: notjunk:1;M01:P0:xD6Qo0UH9qM=;9z6Kn7nP8fLjIcvRxrj7Ia/6j7P
 QMeCIvSTcEBqftkB6Cuq/WaVEpWqnHXCsZcQ+C3Vuv3xwYwt+rAYGygeYJJsKkqKA9N+utbwL
 NbrMQbGOWWL85JY+ByvIfICWU+bOBtZ45e6IS6G1F44+JoM+TvluaDfny5qLlezL0koNv0v2f
 4cUQUBpmVJxrmUD5CCP+Iy6oxmvdmWVNpaLywCYCvW5G21URgljzzCoUxNzkcPmpd0pQQR27w
 tBZwOw3uhqJ1xQ1m60lok+x/mq8UyyOHAV5uv4tVyNbZusG/Ekrx8XMjYxhyFJYNQQPBv97E0
 wQ/6CNzfQO4WzTpkhpbI8ZSGKowEX/cIiEZEz2NEfoRT4t8Bl7/vxTT28xMRgqYVdXyeIzBg1
 X0DN4HutAYMpeHFtnEHQZ3O60yFBLf3QMcmdPmpCMWQYlzk66gkXAzwGXEnHQ3fZXrgRurxzc
 7WsbEbTqMvQItROtyqqA3AYWuF3ytKUVddk0GaQIsy8BjfA33klCpsayfSvjJKg43mAgUJK4+
 qH4lcoanT6OSUa6RLSc3+f8+Ffm9Cy6Zyg9N84MxMQKNQiEjfbUUIJ/1hzDsV/418arQIaoP3
 ExHdevWw5W5Yqt6ngY9wVW4M8slwmzEHdYwlMAVpK67aKXMBAyemjOCmd8EHovWuue83fhpU9
 CMPwJSOYzmeV63Jv+quJcLxSi4k41DahVg1ONBX+UbvC0tlgvSHn5ebM4IrO2FIMLWSS8+442
 /01XW5hgUsNEmmmf0kt8+Bd36+kriVBN/yap5cdEI5dL2cuNTSBVVdORHfGNu07dLz5miWnwP
 zz1kgxYkW9ejhVTluqU+scM8WyqKjCu1mNzuhI35eRLe10SwzNtThzDPThmqZhHVwvH0rDNNf
 2G/b/N2/HFNccfnTb7bfylS9eg1jWODmMiO4Jmw6VGy9vImAxC6SxgXbyLORIO6CwvF2pH4RG
 wz8WrVt+9E0N+Svv3YZRH1bPw2c=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> Function name in the comment does not bring much value to code not
> exposed as API and we don't stick to the kdoc format anymore. Update
> formatting of parameter descriptions.

Mind to share which tool did you use to expose those comments?

>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c         |  4 ++--
>   fs/btrfs/delayed-inode.c |  6 +++---
>   fs/btrfs/delayed-ref.c   |  3 +--
>   fs/btrfs/disk-io.c       | 11 ++++++-----
>   fs/btrfs/extent-tree.c   |  6 +++---
>   fs/btrfs/extent_io.c     | 22 ++++++++++++----------
>   fs/btrfs/inode-item.c    |  2 +-
>   fs/btrfs/inode.c         |  9 +++++----
>   fs/btrfs/locking.c       |  3 ++-
>   fs/btrfs/messages.c      |  8 ++++----
>   fs/btrfs/ref-verify.c    |  2 +-
>   fs/btrfs/root-tree.c     |  6 ++++--
>   fs/btrfs/space-info.c    |  3 ++-
>   fs/btrfs/transaction.c   |  4 ++--
>   fs/btrfs/tree-log.c      |  7 +++----
>   fs/btrfs/ulist.c         |  3 ++-
>   fs/btrfs/volumes.c       |  3 ++-
>   fs/btrfs/zstd.c          | 11 +++++++----
>   18 files changed, 62 insertions(+), 51 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a4cb4b642987..792f9e3afad8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2054,8 +2054,8 @@ static int search_leaf(struct btrfs_trans_handle *=
trans,
>   }
>
>   /*
> - * btrfs_search_slot - look for a key in a tree and perform necessary
> - * modifications to preserve tree invariants.
> + * Look for a key in a tree and perform necessary modifications to pres=
erve
> + * tree invariants.
>    *
>    * @trans:	Handle of transaction, used when modifying the tree
>    * @p:		Holds all btree nodes along the search path
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index d7ac39a3dd10..3e4fd354d458 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -328,7 +328,8 @@ static struct btrfs_delayed_item *btrfs_alloc_delaye=
d_item(u16 data_len,
>   }
>
>   /*
> - * __btrfs_lookup_delayed_item - look up the delayed item by key
> + * Look up the delayed item by key.
> + *
>    * @delayed_node: pointer to the delayed node
>    * @index:	  the dir index value to lookup (offset of a dir index key)
>    *
> @@ -1760,8 +1761,7 @@ int btrfs_should_delete_dir_index(struct list_head=
 *del_list,
>   }
>
>   /*
> - * btrfs_readdir_delayed_dir_index - read dir info stored in the delaye=
d tree
> - *
> + * Read dir info stored in the delayed tree.
>    */
>   int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
>   				    struct list_head *ins_list)
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6a13cf00218b..c468148fc437 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -813,8 +813,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *tran=
s,
>   }
>
>   /*
> - * init_delayed_ref_common - Initialize the structure which represents =
a
> - *			     modification to a an extent.
> + * Initialize the structure which represents a modification to a an ext=
ent.
>    *
>    * @fs_info:    Internal to the mounted filesystem mount structure.
>    *
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6404b17a5bdc..489589052f27 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1403,7 +1403,8 @@ struct btrfs_root *btrfs_get_new_fs_root(struct bt=
rfs_fs_info *fs_info,
>   }
>
>   /*
> - * btrfs_get_fs_root_commit_root - return a root for the given objectid
> + * Return a root for the given objectid.
> + *
>    * @fs_info:	the fs_info
>    * @objectid:	the objectid we need to lookup
>    *
> @@ -1700,11 +1701,11 @@ static void backup_super_roots(struct btrfs_fs_i=
nfo *info)
>   }
>
>   /*
> - * read_backup_root - Reads a backup root based on the passed priority.=
 Prio 0
> - * is the newest, prio 1/2/3 are 2nd newest/3rd newest/4th (oldest) bac=
kup roots
> + * Reads a backup root based on the passed priority. Prio 0 is the newe=
st, prio
> + * 1/2/3 are 2nd newest/3rd newest/4th (oldest) backup roots
>    *
> - * fs_info - filesystem whose backup roots need to be read
> - * priority - priority of backup root required
> + * @fs_info:  filesystem whose backup roots need to be read
> + * @priority: priority of backup root required
>    *
>    * Returns backup root index on success and -EINVAL otherwise.
>    */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index e4d337b78e76..5ef4e852ae2e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1435,7 +1435,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle=
 *trans,
>   }
>
>   /*
> - * __btrfs_inc_extent_ref - insert backreference for a given extent
> + * Insert backreference for a given extent.
>    *
>    * The counterpart is in __btrfs_free_extent(), with examples and more=
 details
>    * how it works.
> @@ -4440,8 +4440,8 @@ static noinline int find_free_extent(struct btrfs_=
root *root,
>   }
>
>   /*
> - * btrfs_reserve_extent - entry point to the extent allocator. Tries to=
 find a
> - *			  hole that is at least as big as @num_bytes.
> + * Entry point to the extent allocator. Tries to find a hole that is at=
 least
> + * as big as @num_bytes.
>    *
>    * @root           -	The root that will contain this extent
>    *
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ac3fca5a5e41..8156dcc4b1fa 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4249,14 +4249,14 @@ void copy_extent_buffer(const struct extent_buff=
er *dst,
>   }
>
>   /*
> - * eb_bitmap_offset() - calculate the page and offset of the byte conta=
ining the
> - * given bit number
> - * @eb: the extent buffer
> - * @start: offset of the bitmap item in the extent buffer
> - * @nr: bit number
> - * @page_index: return index of the page in the extent buffer that cont=
ains the
> - * given bit number
> - * @page_offset: return offset into the page given by page_index
> + * Calculate the page and offset of the byte containing the given bit n=
umber.
> + *
> + * @eb:           the extent buffer
> + * @start:        offset of the bitmap item in the extent buffer
> + * @nr:           bit number
> + * @page_index:   return index of the page in the extent buffer that co=
ntains
> + *                the given bit number
> + * @page_offset:  return offset into the page given by page_index
>    *
>    * This helper hides the ugliness of finding the byte in an extent buf=
fer which
>    * contains a given bit.
> @@ -4615,7 +4615,8 @@ int try_release_extent_buffer(struct page *page)
>   }
>
>   /*
> - * btrfs_readahead_tree_block - attempt to readahead a child block
> + * Attempt to readahead a child block.
> + *
>    * @fs_info:	the fs_info
>    * @bytenr:	bytenr to read
>    * @owner_root: objectid of the root that owns this eb
> @@ -4654,7 +4655,8 @@ void btrfs_readahead_tree_block(struct btrfs_fs_in=
fo *fs_info,
>   }
>
>   /*
> - * btrfs_readahead_node_child - readahead a node's child block
> + * Readahead a node's child block.
> + *
>    * @node:	parent node we're reading from
>    * @slot:	slot in the parent node for the child we want to read
>    *
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 4c322b720a80..c19c0f10f0e2 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -247,7 +247,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *t=
rans,
>   }
>
>   /*
> - * btrfs_insert_inode_extref() - Inserts an extended inode ref into a t=
ree.
> + * Insert an extended inode ref into a tree.
>    *
>    * The caller must have checked against BTRFS_LINK_MAX already.
>    */
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f09fbdc43f0f..032265d0946a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -348,7 +348,7 @@ static void __cold btrfs_print_data_csum_error(struc=
t btrfs_inode *inode,
>   }
>
>   /*
> - * btrfs_inode_lock - lock inode i_rwsem based on arguments passed
> + * Lock inode i_rwsem based on arguments passed.
>    *
>    * ilock_flags can have the following bit set:
>    *
> @@ -382,7 +382,7 @@ int btrfs_inode_lock(struct btrfs_inode *inode, unsi=
gned int ilock_flags)
>   }
>
>   /*
> - * btrfs_inode_unlock - unock inode i_rwsem
> + * Unock inode i_rwsem.
>    *
>    * ilock_flags should contain the same bits set as passed to btrfs_ino=
de_lock()
>    * to decide whether the lock acquired is shared or exclusive.
> @@ -3310,7 +3310,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, st=
ruct btrfs_device *dev,
>   }
>
>   /*
> - * btrfs_add_delayed_iput - perform a delayed iput on @inode
> + * Perform a delayed iput on @inode.
>    *
>    * @inode: The inode we want to perform iput on
>    *
> @@ -4645,7 +4645,8 @@ static int btrfs_rmdir(struct inode *dir, struct d=
entry *dentry)
>   }
>
>   /*
> - * btrfs_truncate_block - read, zero a chunk and write a block
> + * Read, zero a chunk and write a block.
> + *
>    * @inode - inode that we're zeroing
>    * @from - the offset to start zeroing
>    * @len - the length to zero, 0 to zero the entire range respective to=
 the
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 79a125c0f4a2..c3128cdf1177 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -182,7 +182,8 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb=
)
>   }
>
>   /*
> - * __btrfs_tree_lock - lock eb for write
> + * Lock eb for write.
> + *
>    * @eb:		the eb to lock
>    * @nest:	the nesting to use for the lock
>    *
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 7695decc7243..5be060cb6ef5 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -110,8 +110,8 @@ const char * __attribute_const__ btrfs_decode_error(=
int errno)
>   }
>
>   /*
> - * __btrfs_handle_fs_error decodes expected errors from the caller and
> - * invokes the appropriate error response.
> + * Decodes expected errors from the caller and invokes the appropriate =
error
> + * response.
>    */
>   __cold
>   void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char=
 *function,
> @@ -283,8 +283,8 @@ void __cold btrfs_err_32bit_limit(struct btrfs_fs_in=
fo *fs_info)
>   #endif
>
>   /*
> - * __btrfs_panic decodes unexpected, fatal errors from the caller, issu=
es an
> - * alert, and either panics or BUGs, depending on mount options.
> + * Decode unexpected, fatal errors from the caller, issue an alert, and=
 either
> + * panic or BUGs, depending on mount options.
>    */
>   __cold
>   void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function=
,
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 95d28497de7c..26a7fb655f71 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -652,7 +652,7 @@ static void dump_block_entry(struct btrfs_fs_info *f=
s_info,
>   }
>
>   /*
> - * btrfs_ref_tree_mod: called when we modify a ref for a bytenr
> + * Called when we modify a ref for a bytenr.
>    *
>    * This will add an action item to the given bytenr and do sanity chec=
ks to make
>    * sure we haven't messed something up.  If we are making a new alloca=
tion and
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 859874579456..db992f7a5d38 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -51,7 +51,8 @@ static void btrfs_read_root_item(struct extent_buffer =
*eb, int slot,
>   }
>
>   /*
> - * btrfs_find_root - lookup the root by the key.
> + * Lookup the root by the key.
> + *
>    * root: the root of the root tree
>    * search_key: the key to search
>    * path: the path we search
> @@ -485,7 +486,8 @@ void btrfs_update_root_times(struct btrfs_trans_hand=
le *trans,
>   }
>
>   /*
> - * btrfs_subvolume_reserve_metadata() - reserve space for subvolume ope=
ration
> + * Reserve space for subvolume operation.
> + *
>    * root: the root of the parent directory
>    * rsv: block reservation
>    * items: the number of items that we need do reservation
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d7e8cd4f140c..58de9a14e525 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -978,7 +978,8 @@ static bool steal_from_global_rsv(struct btrfs_fs_in=
fo *fs_info,
>   }
>
>   /*
> - * maybe_fail_all_tickets - we've exhausted our flushing, start failing=
 tickets
> + * We've exhausted our flushing, start failing tickets.
> + *
>    * @fs_info - fs_info for this fs
>    * @space_info - the space info we were flushing
>    *
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 0bf42dccb041..035e7f5747cd 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -817,7 +817,7 @@ struct btrfs_trans_handle *btrfs_join_transaction_no=
start(struct btrfs_root *roo
>   }
>
>   /*
> - * btrfs_attach_transaction() - catch the running transaction
> + * Catch the running transaction.
>    *
>    * It is used when we want to commit the current the transaction, but
>    * don't want to start a new one.
> @@ -836,7 +836,7 @@ struct btrfs_trans_handle *btrfs_attach_transaction(=
struct btrfs_root *root)
>   }
>
>   /*
> - * btrfs_attach_transaction_barrier() - catch the running transaction
> + * Catch the running transaction.
>    *
>    * It is similar to the above function, the difference is this one
>    * will wait for all the inactive transactions until they fully
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index cbb17b542131..1834a6ec12bd 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2848,10 +2848,9 @@ static inline void btrfs_remove_all_log_ctxs(stru=
ct btrfs_root *root,
>   }
>
>   /*
> - * btrfs_sync_log does sends a given tree log down to the disk and
> - * updates the super blocks to record it.  When this call is done,
> - * you know that any inodes previously logged are safely on disk only
> - * if it returns 0.
> + * Sends a given tree log down to the disk and updates the super blocks=
 to
> + * record it.  When this call is done, you know that any inodes previou=
sly
> + * logged are safely on disk only if it returns 0.
>    *
>    * Any other return value means you need to call btrfs_commit_transact=
ion.
>    * Some of the edge cases for fsyncing directories that have had unlin=
ks
> diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> index 33606025513d..b4ac2b0cd235 100644
> --- a/fs/btrfs/ulist.c
> +++ b/fs/btrfs/ulist.c
> @@ -223,7 +223,8 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u6=
4 aux,
>   }
>
>   /*
> - * ulist_del - delete one node from ulist
> + * Delete one node from ulist.
> + *
>    * @ulist:	ulist to remove node from
>    * @val:	value to delete
>    * @aux:	aux to delete
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1325f76fbd50..871a55d36e32 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3027,7 +3027,8 @@ static int btrfs_del_sys_chunk(struct btrfs_fs_inf=
o *fs_info, u64 chunk_offset)
>   }
>
>   /*
> - * btrfs_get_chunk_map() - Find the mapping containing the given logica=
l extent.
> + * Find the mapping containing the given logical extent.
> + *
>    * @logical: Logical block offset in bytes.
>    * @length: Length of extent in bytes.
>    *
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index e7ac4ec809a4..5511766485cd 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -145,7 +145,7 @@ static void zstd_reclaim_timer_fn(struct timer_list =
*timer)
>   }
>
>   /*
> - * zstd_calc_ws_mem_sizes - calculate monotonic memory bounds
> + * Calculate monotonic memory bounds.
>    *
>    * It is possible based on the level configurations that a higher leve=
l
>    * workspace uses less memory than a lower level workspace.  In order =
to reuse
> @@ -218,7 +218,8 @@ void zstd_cleanup_workspace_manager(void)
>   }
>
>   /*
> - * zstd_find_workspace - find workspace
> + * Find workspace for given level.
> + *
>    * @level: compression level
>    *
>    * This iterates over the set bits in the active_map beginning at the =
requested
> @@ -256,7 +257,8 @@ static struct list_head *zstd_find_workspace(unsigne=
d int level)
>   }
>
>   /*
> - * zstd_get_workspace - zstd's get_workspace
> + * Zstd get_workspace for level.
> + *
>    * @level: compression level
>    *
>    * If @level is 0, then any compression level can be used.  Therefore,=
 we begin
> @@ -296,7 +298,8 @@ struct list_head *zstd_get_workspace(unsigned int le=
vel)
>   }
>
>   /*
> - * zstd_put_workspace - zstd put_workspace
> + * Zstd put_workspace.
> + *
>    * @ws: list_head for the workspace
>    *
>    * When putting back a workspace, we only need to update the LRU if we=
 are of
