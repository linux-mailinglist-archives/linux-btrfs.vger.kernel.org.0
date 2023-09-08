Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52F797F8B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbjIHAL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjIHALy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:11:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD261BD2
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131907; x=1694736707; i=quwenruo.btrfs@gmx.com;
 bh=9l2Ju9+Pam9D6ZODFhsN5S++vmBNYIfuqfOMI3DkKOo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=IdfIB88CfQi2B4JMomayfqIyNWbVCqxCyfVXGxAi/vbhPargZ8Oo4Nm/kUtJilvDeyuapXQ
 Ajlxrjkg3Jb77jjwVQdLK0Vo/NA5ZUJvo4w/LP0CWOAxFQHnbdEZvdCNddx5InkolcO8JQNyH
 SdPR+r97crWqgTGUTVI9EgiJHG4jHJCSZjfdOscsz7r+vVuVRaYDU0nuKBh+cdCKXdgsUOg+g
 h1NRz68gXHhXY6DreZBDe6IIegP0naYKmhd52AKQC/96acwo6ix0rD3cOXqbIGENE6nl/Xs8o
 +qBmOLT15b7zAuWMkacDIkOYoZ7j8DwBx70oxoZYoYJa697gSGcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKGZ-1qPGxP1ukz-00FnpT; Fri, 08
 Sep 2023 02:11:47 +0200
Message-ID: <f941ac57-3daa-4246-bdeb-b12ab37ee26b@gmx.com>
Date:   Fri, 8 Sep 2023 08:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] btrfs: move extent_buffer::lock_owner to debug
 section
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <3f96e9c3d06ed846b19b63cd9001cb0c66bd8a00.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <3f96e9c3d06ed846b19b63cd9001cb0c66bd8a00.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+BfZxgmQJRvYlIs6QoyqCqNiZLXkaZHspSTZCBMpu7CHzg+Nsaj
 S4PJcVCKWuDn3dG+FdI+7jDFfE4/Bu2Wv8aDaAfnL2PMdbQgDaWEoMwl8melacMaThRUKZn
 MQCBQVu0fE8EokPwhkxDy3IHz5DjB3aL9Zu+KWJGX3O/hM/ZfV/uo9mT9LKFzpTFCVOw6uk
 1k+Wfu9+/Juc9PBA1DyxA==
UI-OutboundReport: notjunk:1;M01:P0:pfgxIXXga6g=;HR5tg+d9fqdKnJyZzb6VhOKPFBW
 gr+pcAVbKRlvmz3I6DfjBkw4ONvivh1Kd5S07lAUSg8Vo68R0F06FCysWKn5bMTQUtOx/OnOL
 i7XBN77zAqFBi8NNmovfLaetCLHSgMrcbW2R79zaYaPj7syhJjjoy34dUlSEUBsaw9j0IERae
 SDXnwO1EPlWwBu3UOXOU6QqT3zgvPtA4CJ421SKy505JPGXfHZJAxKpsVrbwM0F7k9f0h2LLz
 aU25CRmWk+I8o9R3vF5vCirIdp2CbwbU+MS18z47hk2AoDwEkYNyQAl6trEC+qGVssoTbhMd6
 GXqYYJ3r4GZzXAQm8o/NpOLK4zMVNjE9UlTfEvDbpVqDBgL+G0DRnAxJ+jAkO+QWspCbMM6B7
 CpzwURtWBTDdQCWJl8uTM1Ti/WCUhuDRsvaPQYaRTtQ4oNor/cZhA2i+HMdRHpq7Hofb9KYd/
 oBcS1LbUJxU1JP4AjqmAuVTAQIYSZu3GhwX3lr42uyEKkAz+HvA8sLQ3h99ijN1aU0vIE4XrT
 gvLVrFSBgzW0o+bsZEvDv4pnPrUgS6NeoGr7W4TSD6iKFe20INCYPdBERzZY6PePepdNlLPNh
 NrZErvnI3lLwj0iz55pAGjERl28cn7RTYnAjv5VaSLtc56rqst6W5tPv/sg6kTDOqfRiHbETA
 RlOxQo8b7bmBWEeEdsDFg/CwzOV8FWzZkep2CS8c3L5hteRePLkMNAas1a7TcE3rHdQgCOtqK
 45Wp7E8/YW2HyJ578BL1D24LtWbJfG/Y+RzeYbGfKXhAs9UDRUAzFJEaEHbZLstmEifEPXHQs
 24ABp8ngDmvCpivaM1JmiuEBxgdlYZ5qu7G5rCn04jWeUconlWtLFMWl4LFiml3H+AjJ5IdYA
 LiISgWUJkVTJtJPqAIcrVP5cOboddIcNoMnP+/ZwE6vQ8bMm/p702cbx3uRGut+ddpG87l5QJ
 WV/VPs6oEvTwm1YcaGsK5EybnX8=
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
> The lock_owner is used for a rare corruption case and we haven't seen
> any reports in years. Move it to the debugging section of eb.  To close
> the holes also move log_index so the final layout looks like:

Just found some extra space we can squish out:

> struct extent_buffer {
>          u64                        start;                /*     0     8=
 */
>          long unsigned int          len;                  /*     8     8=
 */

u32 is definitely enough.
(u16 is not enough for 64K nodesize, unfortunately)

>          long unsigned int          bflags;               /*    16     8=
 */

For now we don't need 64bit for bflags, 32bit is enough, but
unfortunately that's what the existing test/set/clear_bit() requires...

>          struct btrfs_fs_info *     fs_info;              /*    24     8=
 */
>          spinlock_t                 refs_lock;            /*    32     4=
 */
>          atomic_t                   refs;                 /*    36     4=
 */
>          int                        read_mirror;          /*    40     4=
 */

We don't really need int for read_mirror, but that would be another
patch(set) to change them.

>          s8                         log_index;            /*    44     1=
 */
>
>          /* XXX 3 bytes hole, try to pack */
>
>          struct callback_head       callback_head __attribute__((__align=
ed__(8))); /*    48    16 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          struct rw_semaphore        lock;                 /*    64    40=
 */
>          struct page *              pages[16];            /*   104   128=
 */
>
>          /* size: 232, cachelines: 4, members: 11 */
>          /* sum members: 229, holes: 1, sum holes: 3 */
>          /* forced alignments: 1, forced holes: 1, sum forced holes: 3 *=
/
>          /* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
>
> This saves 8 bytes in total and still keeps the lock on a separate cache=
line.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 32 +++++++++++++++++++++++---------
>   fs/btrfs/extent_io.h   |  4 ++--
>   fs/btrfs/locking.c     | 15 ++++++++++++---
>   3 files changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3e46bb4cc957..6f6838226fe7 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4801,6 +4801,28 @@ int btrfs_alloc_logged_file_extent(struct btrfs_t=
rans_handle *trans,
>   	return ret;
>   }
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +/*
> + * Extra safety check in case the extent tree is corrupted and extent a=
llocator
> + * chooses to use a tree block which is already used and locked.
> + */
> +static bool check_eb_lock_owner(const struct extent_buffer *eb)
> +{
> +	if (eb->lock_owner =3D=3D current->pid) {
> +		btrfs_err_rl(eb->fs_info,
> +"tree block %llu owner %llu already locked by pid=3D%d, extent tree cor=
ruption detected",
> +			     eb->start, btrfs_header_owner(eb), current->pid);
> +		return true;
> +	}
> +	return false;
> +}
> +#else
> +static bool check_eb_lock_owner(struct extent_buffer *eb)
> +{
> +	return false;
> +}
> +#endif
> +
>   static struct extent_buffer *
>   btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_r=
oot *root,
>   		      u64 bytenr, int level, u64 owner,
> @@ -4814,15 +4836,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>   	if (IS_ERR(buf))
>   		return buf;
>
> -	/*
> -	 * Extra safety check in case the extent tree is corrupted and extent
> -	 * allocator chooses to use a tree block which is already used and
> -	 * locked.
> -	 */
> -	if (buf->lock_owner =3D=3D current->pid) {
> -		btrfs_err_rl(fs_info,
> -"tree block %llu owner %llu already locked by pid=3D%d, extent tree cor=
ruption detected",
> -			buf->start, btrfs_header_owner(buf), current->pid);
> +	if (check_eb_lock_owner(buf)) {
>   		free_extent_buffer(buf);
>   		return ERR_PTR(-EUCLEAN);
>   	}
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 68368ba99321..2171057a4477 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -80,16 +80,16 @@ struct extent_buffer {
>   	spinlock_t refs_lock;
>   	atomic_t refs;
>   	int read_mirror;
> -	struct rcu_head rcu_head;
> -	pid_t lock_owner;
>   	/* >=3D 0 if eb belongs to a log tree, -1 otherwise */
>   	s8 log_index;
> +	struct rcu_head rcu_head;
>
>   	struct rw_semaphore lock;
>
>   	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct list_head leak_list;
> +	pid_t lock_owner;
>   #endif
>   };
>
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index c3128cdf1177..6ac4fd8cc8dc 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -103,6 +103,15 @@ void btrfs_maybe_reset_lockdep_class(struct btrfs_r=
oot *root, struct extent_buff
>
>   #endif
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +static void btrfs_set_eb_lock_owner(struct extent_buffer *eb, pid_t own=
er)
> +{
> +	eb->lock_owner =3D owner;
> +}
> +#else
> +static void btrfs_set_eb_lock_owner(struct extent_buffer *eb, pid_t own=
er) { }
> +#endif
> +
>   /*
>    * Extent buffer locking
>    * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -165,7 +174,7 @@ int btrfs_try_tree_read_lock(struct extent_buffer *e=
b)
>   int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>   {
>   	if (down_write_trylock(&eb->lock)) {
> -		eb->lock_owner =3D current->pid;
> +		btrfs_set_eb_lock_owner(eb, current->pid);
>   		trace_btrfs_try_tree_write_lock(eb);
>   		return 1;
>   	}
> @@ -198,7 +207,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enu=
m btrfs_lock_nesting nest)
>   		start_ns =3D ktime_get_ns();
>
>   	down_write_nested(&eb->lock, nest);
> -	eb->lock_owner =3D current->pid;
> +	btrfs_set_eb_lock_owner(eb, current->pid);
>   	trace_btrfs_tree_lock(eb, start_ns);
>   }
>
> @@ -213,7 +222,7 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>   void btrfs_tree_unlock(struct extent_buffer *eb)
>   {
>   	trace_btrfs_tree_unlock(eb);
> -	eb->lock_owner =3D 0;
> +	btrfs_set_eb_lock_owner(eb, 0);
>   	up_write(&eb->lock);
>   }
>
