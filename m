Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029972005B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjFBL1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjFBL1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 07:27:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACD918D
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685705259; x=1686310059; i=quwenruo.btrfs@gmx.com;
 bh=a+TryuK1YHET8gEa+P0IBEunkWlzo7psYt86YSRQIKA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=XLsoRdFpS1A9WeJYxTVKcryqsyzZXclreAiMDUGwmIcHIZg7ymyf0wWT6WBZco1qBXi+ws6
 zk+Em8d1MSTX4bt8woQ9mhhJ6MDtx+Ihq3wfjZ9+OY4BruC2yOK9F4CIzUNPwvGUYFCSe6rMW
 8DPiXI7k2hOAlbcTrZWFudUbxQSNDcD7n9+kpYaChNS8Pm2Ex5omysyNKxjMVNmaQdsGPrwd3
 6Q8Gnn3tiCFOI8c1ExRdd2Kpz6S+j2+nU/T72dQMt8c/+27CAL3Sj+wzfhSeCySfCekntXrEf
 VNGCyya8rwb0YkTBxQGubJ9CeMhhnRuvNeAu7xpjCouGuHrWwelQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1poD312mu5-00Iyv9; Fri, 02
 Jun 2023 13:27:39 +0200
Message-ID: <c1c3e603-5732-01a3-7851-410be723d5e4@gmx.com>
Date:   Fri, 2 Jun 2023 19:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] btrfs: make btrfs_destroy_delayed_refs() return void
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <44301b9e5e365a7b0f5bc57b72811aa4467427c2.1685704678.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <44301b9e5e365a7b0f5bc57b72811aa4467427c2.1685704678.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s/d3/2HJJSVqQ2dQnqQDL7S60W0tm9PPQk//lFCY6LMEy8nyQfR
 tMHiKfea5tNqj49Rg0Q4K+BPCtSQHvsPogPTpYEelaoPOzl8WOhhKvHsZCBiD1OiuYL29Ne
 Yq4kkuF/3Mu5mkkDcVw4WyJX/FMRUZZ13lMoUtEwDruMzyUjQqYTXlZW6/doMf+LL/Zg3IX
 TSISpP9Te7LQQ0+AQFFfQ==
UI-OutboundReport: notjunk:1;M01:P0:BB5nyH8ZBN8=;lpB6km5cPWJjONGhzoHerbMxSQY
 5DkgdwT/rHbSNTGych+aMw0c2eS3RL/rKF2Me3Ymh830NK7tnvlxwUT2t9fh77pGBuMVOLfZV
 ZfP2vQ/oRQ05NrEPgcPW6GSI+7FgxnU6mKkB5ffcfhjVhH+fePV/mni2hHS95yNex/EH4wJNG
 pWp76Nouo+cndscsIKehzhZlydPVi9D0ujWbmbtPBRnZwFVCP+fgjl0YEdav3jiPUsv3poWZc
 HUCJyaRrP3glyNo0vOcib1LnLWgvEGwR28R/uZ002zvMewx1+5P7xoYwG9VSVnhfTj71yl0+A
 snimJVpKFuxdW6OFs3lw12sdNe3v/L052tVfSvdvIswWmj+9joWCxcMVdHK3HQG5iBmImHyjI
 Og/76kg8g3AbQvYn/o3+5NEB2BZ4SGqfWOTReZv4rahZw64A1U0mHi7kAwrXcowKfbUMTEZGE
 cgxq25kedqucfzscW8zTSHZEqlTyk/z971N4s5AKxO0AMQd3qbvAyAbjjTJ35wpPuYbAwRj0M
 +obwydueanGzotegpfev9knUj5VONJvznt2wtvZz10hkmN5OqUMZ+YRux0FcZDoPS/wXxwHZs
 i/8aH0Qmz6VR1BqqqCxAs1y4IdrCt6pAqXLbarC1vssrXFg6FehO49me5igp6LrOio2g9YQyE
 S4GcUkdnQVSAlyUANl05az0qI5lEU+cfCehMVMCATtSKtS4ZbVaqFX7ghtxJrV9C0MsiHTUie
 ZCF08LWCou6OybAKVoJSHwtp6ilI65DeEF37oXPra6Kcg2KiJmFCVIg9+7K22EGdTF7MrAs/R
 qGLvicEmceDfiSN8RfPGwo9i+BXAUWAkPknu9LBkhUY62aPjquf9c7LyXkPXr9eotFELJ1QaT
 g0TQW3/cEAuhY8Xvg2rW3u26Ax4fQGInPhYouTT7YFCjRE2mAQrkG5W1Zm7aI+FNodzo4O0Wy
 HvX3ZQ6smhL9kdqi9YiF9ereHLM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/2 19:19, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> btrfs_destroy_delayed_refs() always returns 0 and its single caller does
> not check its return value, as it also returns void, and so does the
> callers' caller and so on. This is because we are in the transaction abo=
rt
> path, where we have no way to deal with errors (we are in a critical
> situation) and all cleanup of resources works in a best effort fashion.
> So make btrfs_destroy_delayed_refs() return void.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> V2: Make it explicit in the changelog that we are in the transaction
>      abort path and therefore have no way to deal with errors.
>
>      V1 was part of a patchset that was merged except for this patch:
>      https://lore.kernel.org/linux-btrfs/cover.1685363099.git.fdmanana@s=
use.com/
>
>   fs/btrfs/disk-io.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 90f998ac68f0..0bd437fbe07d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4555,13 +4555,12 @@ static void btrfs_destroy_all_ordered_extents(st=
ruct btrfs_fs_info *fs_info)
>   	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
>   }
>
> -static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> -				      struct btrfs_fs_info *fs_info)
> +static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> +				       struct btrfs_fs_info *fs_info)
>   {
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret =3D 0;
>
>   	delayed_refs =3D &trans->delayed_refs;
>
> @@ -4569,7 +4568,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>   		spin_unlock(&delayed_refs->lock);
>   		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return ret;
> +		return;
>   	}
>
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
> @@ -4630,8 +4629,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	btrfs_qgroup_destroy_extent_records(trans);
>
>   	spin_unlock(&delayed_refs->lock);
> -
> -	return ret;
>   }
>
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
