Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F13D2FF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhGVWNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 18:13:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:34283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhGVWNK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 18:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626994421;
        bh=WNo9weF7901SWBgpCzZip8kc0M/DaLX+x9k6aEThJiI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aBlRwremDt69CJcSOc9mRQ51G5r8S9Ini5iFUU7S2Smt4FVWCac0vG9Q6A73fk3vC
         nte/xPRG9AYKejwlIVI5LNoDGD7IO05GsXcKD3b3+UyMy7WkPFOtlW1rwa9Ct7qNZy
         asqcSJe5fuMbsKovV4B1BTjuDURtoQYnARNRO4mY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1kzywv3TZZ-016eXM; Fri, 23
 Jul 2021 00:53:41 +0200
Subject: Re: [PATCH] btrfs: remove ignore_offset argument from
 btrfs_find_all_roots()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <c36aede8c9c171c1153e3a153c4112222919985a.1626965759.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <afca30fe-2027-76fe-1237-1cb433e8f3e3@gmx.com>
Date:   Fri, 23 Jul 2021 06:53:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c36aede8c9c171c1153e3a153c4112222919985a.1626965759.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jhxAKlcicwaAzG/9PYl0cy+SYg7xXeHrg4MX7U/if/+oWIAzHZj
 td2JE7h9wdzc7UAiVVbojFIljSYvZyPJRwspHBcnKL3ccEXj9CMtWjmmf1oyRQdoZ4mj4X0
 jxffsQeGH+sRktJkfb/EpKvSS8qatMO8QZJetjfLV5Ktzrh9c4pRaE1q4Js/C2hVXF20j85
 Pdkk7ljr7W999K1xqcejQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0t0RcwOoxw4=:ku7bUvCyF+CjYhwlQPlAfW
 Sa5fE+50XeFfTiVu+XST8xqUqj1zzuRR8PjKBr7Fj0YpEAy97m9p+3R+vRAlrpgf7jEeXhEKu
 kHDyGMiAkeOmP4VtC/gvyvwth7OknMP5VzRl4Vo3Nine20QThbDnLhska+yOS4+Ic+5k2Fmyp
 N7hY1N0u7cSQgYfoj3JL7q6kvYYJU1ajPCn3bRTlZBeGc0y8HPIWuj0VT7ysOf5w/x7VUz2Cy
 aDDh0+C+77h1XIg25kHgYftetzvTPN2u8F94ifgZC5/OqLSm0bgpPW9FeeLwdM3MHWNfWFFt0
 dXXAwHSMIEa/EATX0wN6XttM6Mbw5bxCLsYWFrxeF5FG7Z1GJOxCoQV/SAaRYQAjwnbYWcVvW
 +MaABzceNBlb6wJuNJIyGOaacQMw0I88w6EWjm7tgyY8NEveDVEI12jw+1KOqnp+fGKXlew2c
 sYKRKme6YNpSUPfff71+iZKlpr+FrySjVBjAIDkv87BsGDy/iXUQqhzjXiUh8E2KJFPiTz++T
 s/Vka4Uk/K+BMUnd8bt+gF+a34HPDiryobewnWDuY5THAx2yP/Bzvs0gv2A1YjFeArlQS0G5M
 63HchUHBHO0mv4u5azUpfGnVnusehwf0LWf68AxF7Lxr5oMOO0CEjpH2iH0AIFUxNLL95Qk9V
 T64090esujPZ18JtLicuB6Qsgs9Vct+PrWG01TAX0HEotY9k8JIWiyW2k2omRoSV+61zaaQHy
 HBqLvHepZDy9nNmWg2Yt5kEeX/K3qD6Baiuy9l5Hm4Fv3xhghyFmkawPzDKvmxAc1/WaVJF3B
 gT7Mca0hHD0LziJdvA/GkQ7uZHVTXmoKrXZQ+kb0nNs/xQOCxTOWu32nH8y1Ymelvv/Et1r08
 WOyfox4oPt5InGFJXB1F6I0GwzNQ3LoZR/CBvozrPI30nbqME+UIBlhbHCkE+Cio20+pvAre7
 CMRtKSOLLR9NrgepASTtprBCkso4P/uQ8hguR/rWRGzDlffJE12fizPpP8NOxNfEKi8zk9BRX
 zjP+6cTVgmjwwtNKL1wUOkYF1n34naO0pmrclurFCi/5nr5ua7E7YmgyyhNsupk0AFN44jZTB
 wO5PjpadYI8lXA2BM0TZ0co4Cb67GuT99EZdRRSqUDweZZRGUuS50+MWA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/22 =E4=B8=8B=E5=8D=8810:58, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently all the callers of btrfs_find_all_roots() pass a value of fals=
e
> for its ignore_offset argument. This makes the argument pointless and we
> can remove it and make btrfs_find_all_roots() always pass false as the
> ignore_offset argument for btrfs_find_all_roots_safe(). So just do that.

I thought we have some user space tool like "btrfs ins logical-resolve"
needs the option for its "-o" option.

Did I miss something? Or is there some recent change removed that support?

Thanks,
Qu
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/backref.c            |  4 ++--
>   fs/btrfs/backref.h            |  2 +-
>   fs/btrfs/qgroup.c             |  8 ++++----
>   fs/btrfs/tests/qgroup-tests.c | 20 ++++++++++----------
>   4 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 78b202d198b8..4f64c366f369 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1488,14 +1488,14 @@ static int btrfs_find_all_roots_safe(struct btrf=
s_trans_handle *trans,
>   int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>   			 struct btrfs_fs_info *fs_info, u64 bytenr,
>   			 u64 time_seq, struct ulist **roots,
> -			 bool ignore_offset, bool skip_commit_root_sem)
> +			 bool skip_commit_root_sem)
>   {
>   	int ret;
>
>   	if (!trans && !skip_commit_root_sem)
>   		down_read(&fs_info->commit_root_sem);
>   	ret =3D btrfs_find_all_roots_safe(trans, fs_info, bytenr,
> -					time_seq, roots, ignore_offset);
> +					time_seq, roots, false);
>   	if (!trans && !skip_commit_root_sem)
>   		up_read(&fs_info->commit_root_sem);
>   	return ret;
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index ff5f07f9940b..ba454032dbe2 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -47,7 +47,7 @@ int btrfs_find_all_leafs(struct btrfs_trans_handle *tr=
ans,
>   			 const u64 *extent_item_pos, bool ignore_offset);
>   int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>   			 struct btrfs_fs_info *fs_info, u64 bytenr,
> -			 u64 time_seq, struct ulist **roots, bool ignore_offset,
> +			 u64 time_seq, struct ulist **roots,
>   			 bool skip_commit_root_sem);
>   char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path =
*path,
>   			u32 name_len, unsigned long name_off,
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 0fa121171ca1..db680f5be745 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1733,7 +1733,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_tr=
ans_handle *trans,
>   	ASSERT(trans !=3D NULL);
>
>   	ret =3D btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_ro=
ot,
> -				   false, true);
> +				   true);
>   	if (ret < 0) {
>   		trans->fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSIST=
ENT;
>   		btrfs_warn(trans->fs_info,
> @@ -2651,7 +2651,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   				/* Search commit root to find old_roots */
>   				ret =3D btrfs_find_all_roots(NULL, fs_info,
>   						record->bytenr, 0,
> -						&record->old_roots, false, false);
> +						&record->old_roots, false);
>   				if (ret < 0)
>   					goto cleanup;
>   			}
> @@ -2667,7 +2667,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   			 * current root. It's safe inside commit_transaction().
>   			 */
>   			ret =3D btrfs_find_all_roots(trans, fs_info,
> -			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false, false);
> +			   record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
>   			if (ret < 0)
>   				goto cleanup;
>   			if (qgroup_to_skip) {
> @@ -3201,7 +3201,7 @@ static int qgroup_rescan_leaf(struct btrfs_trans_h=
andle *trans,
>   			num_bytes =3D found.offset;
>
>   		ret =3D btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
> -					   &roots, false, false);
> +					   &roots, false);
>   		if (ret < 0)
>   			goto out;
>   		/* For rescan, just pass old_roots as NULL */
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests=
.c
> index 98b5aaba46f1..f3137285a9e2 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -224,7 +224,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   	 * quota.
>   	 */
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -237,7 +237,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -261,7 +261,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   	new_roots =3D NULL;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -273,7 +273,7 @@ static int test_no_shared_qgroup(struct btrfs_root *=
root,
>   		return -EINVAL;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -325,7 +325,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -338,7 +338,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -360,7 +360,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -373,7 +373,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
> @@ -401,7 +401,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   	}
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		test_err("couldn't find old roots: %d", ret);
> @@ -414,7 +414,7 @@ static int test_multiple_refs(struct btrfs_root *roo=
t,
>   		return ret;
>
>   	ret =3D btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots=
,
> -			false, false);
> +			false);
>   	if (ret) {
>   		ulist_free(old_roots);
>   		ulist_free(new_roots);
>
