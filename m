Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0364ED835
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiCaLJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiCaLJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:09:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CD205BDD;
        Thu, 31 Mar 2022 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648724862;
        bh=+dV+EoUnXu4gqfokgsxfhwdJxygHbTwokTskhNYoX0A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k1cHKNJcFa0Q6Qnti6ftAK5g5JtkMDAMXeuZMfin2zqrR9++/S2Ex5dZhMz0ITr5h
         z//ZxoATUhPie1tPVijOCXB8I9MrG6mKWlPrmxCF9hV4TFy8Y8dBctljEYoLi24+UV
         F4PLEwXwO3rYKWTtpf25Wn96TncTqT5zZ5qhweqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1nO8O10MOt-00QEOw; Thu, 31
 Mar 2022 13:07:42 +0200
Message-ID: <bc671baa-f2bc-5c6f-63d5-28ac87eb08e1@gmx.com>
Date:   Thu, 31 Mar 2022 19:07:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: remove unnecessary type castings
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
References: <20220331103408.31867-1-yuzhe@nfschina.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220331103408.31867-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SA5OIFuHugMkcK4LC/uDml2zM9oemrQEVmXA4zgY9EE6KNRpKzT
 idAoScabHd3dxfpqiBSlN2zzyD1defdT4XbAXzQUe94kDTsy7l2SOiiFUWf2oYPcWAEf8Fl
 kYpqxokmKUbcNp7VZT0o4C5fZ3YLWEI7b4m/YleiRtJmuSweQGGm+ED4n3CiNOBkyqANurS
 v5B530Rbgt8aPCQP5O+QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aqIUE2+eDBI=:EFIXC37jm5ZQGLz5WliUmU
 G3YXgHruYLLlzOzkz0TKdKkIBFWkPiGGcZzEejJWD90bOnT7Y5tjoEf3Zoaf/sJ83G1psqRiW
 23GiA8uq7qHnlXqtpc/L/Tiaj3LqFRtn4SI9MNrGmIN84K6DIm+O6gT/SFittXiUb8RQeXj31
 4MZO6VarQvp05ahZ9fIX8RzOaVQKNvbcgzC8rEXKlYoN4xWOEWq3blxGLFXCNEhZw6WrA7b6c
 a/BdM4S9isXpouUv3fQ8PXWAvnDKtkcamQs8edhDgx6LX8iGN9eQbtcqDYgUcHQP8ToYw89qK
 ptdj+7Am9RpPnaQmWC8BWkDM0tV6VV9lXRxJtifL7VmB3+jqvaOEKvwJE7k5+UGqlX96r3pLZ
 LfEBdTeYONqGr5pYARdvO6au6AM/3YzxDC2xZMo7AEP49Th7monCbXc5NR1/5Z9hwdaY2Qj2/
 zRs5/cdblfMWeVuG/wNCoLbqzzBn667C7jPmSF70vh42U3UMZItXMykxvFNSKwJv7nsJx8QsK
 VcCphaej455XZq7z1OU55mj/JSJZVRa178sQ8u6amxN6o9nl8Vpe+8vzWiWIpzBG35LOrLCKM
 gCwZ0gn7a99b9XGOHPGny4HhFcTrEqkEFV3oAzGg4VSsVKwHv3a4HJNEPLzCE8JRmH6tYiGk8
 QuQylTk0N7pYaxn+qlwSYe/ItEsK0/Ef7tx5XtMDkKvPSX9IOrWLHIT7ISKl3T/S1XTPCLJpJ
 sKbB2TVYKSOcnHw5OtXS6Sulfbo3F4+DK5rM9jtR/Zg7FJgx1YqvaQXWgKEKtTjSN8nv16dCL
 Wpq6qrik8OCfuwQhCwClwxyWhj28Oeo24lGwdVR3GdQueDFmlz5/3TYABxd6ofbSUai8yNzFC
 YscDvO6i65Qr1DtGEL8FfyY4QlQu5d3xqLPQBPoemCl/DdyN+f/q5sXVkiGzazh/r3JGU3plD
 gXu1bRdklYgz+flKd3YI4a6ZXSw+A1I4qw5AjsxI/alXm7fTybHHES7ee7Ib9gIQ3wTYUJM97
 qJcmqTLLcAJssw0wF+Y8OyT1s/0WmteHnY3HKdv0H7uJP5KaF/Ym/M+xVK66HJXQXxTYs2OMi
 GhZFGRauWuglvc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/31 18:34, Yu Zhe wrote:
> remove unnecessary void* type castings.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>   fs/btrfs/check-integrity.c | 2 +-
>   fs/btrfs/disk-io.c         | 4 ++--
>   fs/btrfs/inode.c           | 2 +-
>   fs/btrfs/ioctl.c           | 4 ++--
>   fs/btrfs/relocation.c      | 2 +-
>   fs/btrfs/scrub.c           | 2 +-
>   fs/btrfs/space-info.c      | 2 +-
>   fs/btrfs/subpage.c         | 2 +-
>   fs/btrfs/volumes.c         | 2 +-
>   9 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index abac86a75840..62eb149aac98 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -2033,7 +2033,7 @@ static void btrfsic_process_written_block(struct b=
trfsic_dev_state *dev_state,
>
>   static void btrfsic_bio_end_io(struct bio *bp)
>   {
> -	struct btrfsic_block *block =3D (struct btrfsic_block *)bp->bi_private=
;
> +	struct btrfsic_block *block =3D bp->bi_private;
>   	int iodone_w_error;
>
>   	/* mutex is not held! This is not save if IO is not yet completed
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b30309f187cf..51f7ad6cadce 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1963,7 +1963,7 @@ static void end_workqueue_fn(struct btrfs_work *wo=
rk)
>
>   static int cleaner_kthread(void *arg)
>   {
> -	struct btrfs_fs_info *fs_info =3D (struct btrfs_fs_info *)arg;
> +	struct btrfs_fs_info *fs_info =3D arg;
>   	int again;
>
>   	while (1) {
> @@ -3293,7 +3293,7 @@ static int init_mount_fs_info(struct btrfs_fs_info=
 *fs_info, struct super_block
>
>   static int btrfs_uuid_rescan_kthread(void *data)
>   {
> -	struct btrfs_fs_info *fs_info =3D (struct btrfs_fs_info *)data;
> +	struct btrfs_fs_info *fs_info =3D data;
>   	int ret;
>
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index aa0a60ee26cb..6eafb46eadae 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8951,7 +8951,7 @@ int btrfs_drop_inode(struct inode *inode)
>
>   static void init_once(void *foo)
>   {
> -	struct btrfs_inode *ei =3D (struct btrfs_inode *) foo;
> +	struct btrfs_inode *ei =3D foo;
>
>   	inode_init_once(&ei->vfs_inode);
>   }
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 238cee5b5254..c05a2afb74a7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2593,7 +2593,7 @@ static noinline int btrfs_ioctl_tree_search(struct=
 inode *inode,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> -	uargs =3D (struct btrfs_ioctl_search_args __user *)argp;
> +	uargs =3D argp;
>
>   	if (copy_from_user(&sk, &uargs->key, sizeof(sk)))
>   		return -EFAULT;
> @@ -2627,7 +2627,7 @@ static noinline int btrfs_ioctl_tree_search_v2(str=
uct inode *inode,
>   		return -EPERM;
>
>   	/* copy search header and buffer size */
> -	uarg =3D (struct btrfs_ioctl_search_args_v2 __user *)argp;
> +	uarg =3D argp;
>   	if (copy_from_user(&args, uarg, sizeof(args)))
>   		return -EFAULT;
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index fdc2c4b411f0..13befafab3b4 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -362,7 +362,7 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>   	rb_node =3D rb_simple_search(&rc->reloc_root_tree.rb_root, bytenr);
>   	if (rb_node) {
>   		node =3D rb_entry(rb_node, struct mapping_node, rb_node);
> -		root =3D (struct btrfs_root *)node->data;
> +		root =3D node->data;
>   	}
>   	spin_unlock(&rc->reloc_root_tree.lock);
>   	return btrfs_grab_root(root);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 11089568b287..e338e3f9a0b5 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2798,7 +2798,7 @@ static void scrub_parity_bio_endio_worker(struct b=
trfs_work *work)
>
>   static void scrub_parity_bio_endio(struct bio *bio)
>   {
> -	struct scrub_parity *sparity =3D (struct scrub_parity *)bio->bi_privat=
e;
> +	struct scrub_parity *sparity =3D bio->bi_private;
>   	struct btrfs_fs_info *fs_info =3D sparity->sctx->fs_info;
>
>   	if (bio->bi_status)
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index b87931a458eb..4de2c82051b1 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -519,7 +519,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs=
_info,
>   		items =3D calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
>   	}
>
> -	trans =3D (struct btrfs_trans_handle *)current->journal_info;
> +	trans =3D current->journal_info;
>
>   	/*
>   	 * If we are doing more ordered than delalloc we need to just wait on
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index ef7ae20d2b77..45fbc9e20715 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -127,7 +127,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info=
 *fs_info,
>   	if (fs_info->sectorsize =3D=3D PAGE_SIZE || !PagePrivate(page))
>   		return;
>
> -	subpage =3D (struct btrfs_subpage *)detach_page_private(page);
> +	subpage =3D detach_page_private(page);

Indeed without the type casting, latest GCC doesn't report any warning.

So it's fine to now casting (void *).

Maybe it's my bad memory, but I remember without such casting the
compiler used to report warning...

Anyway looks good to me.

But not confident if slightly older compiler would report warning.

Thanks,
Qu
>   	ASSERT(subpage);
>   	btrfs_free_subpage(subpage);
>   }
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1be7cb2f955f..c7a6d290e67b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -8295,7 +8295,7 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info=
 *fs_info, void *ptr)
>
>   static int relocating_repair_kthread(void *data)
>   {
> -	struct btrfs_block_group *cache =3D (struct btrfs_block_group *)data;
> +	struct btrfs_block_group *cache =3D data;
>   	struct btrfs_fs_info *fs_info =3D cache->fs_info;
>   	u64 target;
>   	int ret =3D 0;
