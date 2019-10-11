Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE4D3C56
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJKJb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 05:31:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:48369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfJKJb0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 05:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570786280;
        bh=H1oAQSM+Agn2MHrh6QHjBI9D2HScNq1mEqrwtYcsI0c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kjyqTczLJYS5cd1ulV3s7KKEOk0KkWEcBY3ZwORgT7nNchEN3xA+WRdCvUD7qePbB
         I2auB+Kh50Wn+Q2LwXzglyvgm3dp2JbMnFAlCLGBkwzRbk0nJIeXqOSzB7aNDxJrT7
         a07kvDkTQ26o3PBPFwS7+/wwnaNxXuwB6+71TrCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MORAa-1iieFt0rV8-00Puoj; Fri, 11
 Oct 2019 11:31:19 +0200
Subject: Re: [PATCH 1/3] btrfs: Factor out tree roots initialization during
 mount
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191010150647.20940-1-nborisov@suse.com>
 <20191010150647.20940-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f8789a0e-ec6b-51b0-34a5-238eaebf0205@gmx.com>
Date:   Fri, 11 Oct 2019 17:31:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010150647.20940-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTtvoExmYJFiMOoehGSnzgNUvqDPh6FU6Rbdpcj6ITJDPnoEh0d
 rzSZnFjH4Gu6ehZ6Jk8KnamKt6ndSnNbNHm6AkIwkV3EduyTdTQyoSYwoGdHjh9457wz5cz
 ba3uSMu6S8R4IXuXnmz9z5iq+ILj5qGaV5jCbKzv86FoGePgjXpMXjBT3mojBpkU5nxpwWk
 iYf/FFU83EPQ0sx1MEkiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRbGUPMpMDY=:fgsXC3e+Cj7GpVWq1Kz1P9
 4emKUrJZ3brAw1RE5lszguHcXeGb8e2fXuKocch0U9zo1bEN3gFqQsnc02rrv0iM1Yp/ziPGV
 U0MLnniz/+FGqOfAoubN2tClJLTMrWX5wL8al6T6uBagIZypfN0mRnBvOV7LSQDIxZn2LR2d0
 lozli10R3JzdyMP4A21MA3htadv46NwV1cktOAoJLnxzyf5oI44cSK3tyWvAMsubWkHjBOMAo
 ROytuUoWV/gibq005nGB+ENum/jgSxX340FtEIA0Nhh4NK6QU5tj0YuEwoIri7dNpLnvWfr0Q
 9lmyrrnJoprjUCY//x+kNrhjrYTxuWybiii4BGYbC8BBgkcGwQCF6l0AaK7Wco9wuOpwY54sW
 hxgpop5xx5RR4Zj3ATxAj7RzqeuHN2Tx3zgNk0ma0Im1gO88+SFUwD3K7dB2hr6YUB9z6JQGi
 bl8Yu5KqdXLtABmY7qwrA0fig7If5M3g7z+3UeN0eoVG9Oyi2pxkO4d4I3jpkKemNTVgZBf0i
 OD+kBleqPUWB10wQMErcIUbsVANtFE0utjy33crStebInuyKgC1yCi4TWMqZzR82mGZLpua93
 K9Aoo0YDkciK9zIs1S+BmOfVQchTYHizdEKwFDA773k3wSr04jkzX+zfichDrmgjSFEY3+/1L
 DpGqMh1j25uTwH845LJmC+2McGssq+krEvcdRk4Tu7STOXoIB4tGeSwsgZchDsLQVtHsUy7B5
 StwzxhMLjKZJTrFqLJSajr/YNNP2STyYVqi6gMBHwgEmmMmdOXDiOlQ+7YQsE/Ck4Dnn+X0w9
 D2bAFX6EF4soYMjc06na1khnDuXu2NCc9dxWilhxgNCdebumHTwsrjLSz62yLpEHuEfEzxzWg
 c1cDwdgZiOslSisyp9W0PyK8zJexigeYmgAJhszHZgDg+dFbvtopeRC4usLvr+gE4hozC6Lmq
 8MiUeXd603/WZIvdszqdc8q2qo7kO3+3QY+wK1K7BF7cWIstEsXyI5p9tZlf9l0vvKmuVTFEG
 TaVF6ko2+99Z5G4IYUUsgjx4tDOd6wSIpCYEKk9eHrFpnHYz3nYVHr5Yh0NH/zMdNymuuQwKt
 c/DNbRn9oFOphkIb+MyNTdpwWBZ388Zt6B8tNjxqRDESBodODCZdtDl7eZXh563KiRa2/ewZ+
 7R5hUXbqQ163lPdJvnvEchZ58FI4x+q8UY1RhpU+mOFFLsBTDEz7Th3vHtY2ayAvN4T709m7I
 FxBPjrQOqb/gwJuzHprmCTNJ4TpAblzgILDjvq89aOAjgaRQFSdgOjYINgJA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/10 =E4=B8=8B=E5=8D=8811:06, Nikolay Borisov wrote:
> The code responsible for reading and initilizing tree roots is
> scattered in open_ctree among 2 labels, emulating a loop. This is rather
> confusing to reason about. Instead, factor the code in a new function,
> init_tree_roots which implements the same logical flow.


The refactor itself is great, but maybe we can make it better?

Extra comment inlined below.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 136 ++++++++++++++++++++++++++-------------------
>  1 file changed, 80 insertions(+), 56 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2c3fa89702e7..b850988023aa 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2553,6 +2553,82 @@ static int btrfs_validate_write_super(struct btrf=
s_fs_info *fs_info,
>  	return ret;
>  }
>
> +int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
> +{
> +
> +	bool should_retry =3D btrfs_test_opt(fs_info, USEBACKUPROOT);
> +	struct btrfs_super_block *sb =3D fs_info->super_copy;
> +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> +	u64 generation;
> +	int level;
> +	bool handle_error =3D false;
> +	int num_backups_tried =3D 0;
> +	int backup_index =3D 0;
> +	int ret =3D 0;
> +
> +	while (true) {
> +		if (handle_error) {

This two part doesn't look good enough to me.

Can we do something like this?

/*
 * change next_root_backup() to:
 * - Don't modify backup_index parameter
 * - Accept @index as 0, 1, 2, 3, 4.
 *   0 is regular sb tree roots, 1~4 is the backup roots, 1 is the best
candiate
 *   while 4 is the oldest candidate
 * - Check if we should try next backup (usebackuproot option)
 * - Return proper error value other than -1.
 */
for (backup_index =3D 0; next_root_backup(fs_info, backup_index) =3D=3D 0;
backup_index++) {
	/*
	 * do the heavy lifting tree reads here
	 */
 	if (some_thing_went_wrong)
		goto next;

	/* Everything done correctly */
	break;

	next:
	/* Do the cleanup */
}

To me, that would look more sane other than strange error handling
creeping around.

Thanks,
Qu

> +			if (!IS_ERR(tree_root->node))
> +				free_extent_buffer(tree_root->node);
> +			tree_root->node =3D NULL;
> +
> +			if (!should_retry) {
> +				break;
> +			}
> +			free_root_pointers(fs_info, 0);
> +
> +			/* don't use the log in recovery mode, it won't be valid */
> +			btrfs_set_super_log_root(sb, 0);
> +
> +			/* we can't trust the free space cache either */
> +			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
> +
> +			ret =3D next_root_backup(fs_info, sb, &num_backups_tried,
> +					       &backup_index);
> +			if (ret =3D=3D -1)
> +				return -ESPIPE;
> +		}
> +		generation =3D btrfs_super_generation(sb);
> +		level =3D btrfs_super_root_level(sb);
> +		tree_root->node =3D read_tree_block(fs_info, btrfs_super_root(sb),
> +						  generation, level, NULL);
> +		if (IS_ERR(tree_root->node) ||
> +		    !extent_buffer_uptodate(tree_root->node)) {
> +			handle_error =3D true;
> +			btrfs_warn(fs_info, "failed to read tree root");
> +			continue;
> +		}
> +
> +		btrfs_set_root_node(&tree_root->root_item, tree_root->node);
> +		tree_root->commit_root =3D btrfs_root_node(tree_root);
> +		btrfs_set_root_refs(&tree_root->root_item, 1);
> +
> +		mutex_lock(&tree_root->objectid_mutex);
> +		ret =3D btrfs_find_highest_objectid(tree_root,
> +						&tree_root->highest_objectid);
> +		if (ret) {
> +			mutex_unlock(&tree_root->objectid_mutex);
> +			handle_error =3D true;
> +			continue;
> +		}
> +
> +		ASSERT(tree_root->highest_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
> +		mutex_unlock(&tree_root->objectid_mutex);
> +
> +		ret =3D btrfs_read_roots(fs_info);
> +		if (ret) {
> +			handle_error =3D true;
> +			continue;
> +		}
> +
> +		fs_info->generation =3D generation;
> +		fs_info->last_trans_committed =3D generation;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  int __cold open_ctree(struct super_block *sb,
>  	       struct btrfs_fs_devices *fs_devices,
>  	       char *options)
> @@ -2571,8 +2647,6 @@ int __cold open_ctree(struct super_block *sb,
>  	struct btrfs_root *chunk_root;
>  	int ret;
>  	int err =3D -EINVAL;
> -	int num_backups_tried =3D 0;
> -	int backup_index =3D 0;
>  	int clear_free_space_tree =3D 0;
>  	int level;
>
> @@ -2995,45 +3069,13 @@ int __cold open_ctree(struct super_block *sb,
>  		goto fail_tree_roots;
>  	}
>
> -retry_root_backup:
> -	generation =3D btrfs_super_generation(disk_super);
> -	level =3D btrfs_super_root_level(disk_super);
> -
> -	tree_root->node =3D read_tree_block(fs_info,
> -					  btrfs_super_root(disk_super),
> -					  generation, level, NULL);
> -	if (IS_ERR(tree_root->node) ||
> -	    !extent_buffer_uptodate(tree_root->node)) {
> -		btrfs_warn(fs_info, "failed to read tree root");
> -		if (!IS_ERR(tree_root->node))
> -			free_extent_buffer(tree_root->node);
> -		tree_root->node =3D NULL;
> -		goto recovery_tree_root;
> -	}
> -
> -	btrfs_set_root_node(&tree_root->root_item, tree_root->node);
> -	tree_root->commit_root =3D btrfs_root_node(tree_root);
> -	btrfs_set_root_refs(&tree_root->root_item, 1);
> -
> -	mutex_lock(&tree_root->objectid_mutex);
> -	ret =3D btrfs_find_highest_objectid(tree_root,
> -					&tree_root->highest_objectid);
> +	ret =3D init_tree_roots(fs_info);
>  	if (ret) {
> -		mutex_unlock(&tree_root->objectid_mutex);
> -		goto recovery_tree_root;
> +		if (ret =3D=3D -ESPIPE)
> +			goto fail_block_groups;
> +		goto fail_tree_roots;
>  	}
>
> -	ASSERT(tree_root->highest_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
> -
> -	mutex_unlock(&tree_root->objectid_mutex);
> -
> -	ret =3D btrfs_read_roots(fs_info);
> -	if (ret)
> -		goto recovery_tree_root;
> -
> -	fs_info->generation =3D generation;
> -	fs_info->last_trans_committed =3D generation;
> -
>  	ret =3D btrfs_verify_dev_extents(fs_info);
>  	if (ret) {
>  		btrfs_err(fs_info,
> @@ -3327,24 +3369,6 @@ int __cold open_ctree(struct super_block *sb,
>  	btrfs_free_stripe_hash_table(fs_info);
>  	btrfs_close_devices(fs_info->fs_devices);
>  	return err;
> -
> -recovery_tree_root:
> -	if (!btrfs_test_opt(fs_info, USEBACKUPROOT))
> -		goto fail_tree_roots;
> -
> -	free_root_pointers(fs_info, 0);
> -
> -	/* don't use the log in recovery mode, it won't be valid */
> -	btrfs_set_super_log_root(disk_super, 0);
> -
> -	/* we can't trust the free space cache either */
> -	btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
> -
> -	ret =3D next_root_backup(fs_info, fs_info->super_copy,
> -			       &num_backups_tried, &backup_index);
> -	if (ret =3D=3D -1)
> -		goto fail_block_groups;
> -	goto retry_root_backup;
>  }
>  ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
>
>
