Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995E1446B8A
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhKFAX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:23:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:58843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhKFAX5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636158071;
        bh=saNlXqDZzllZa4wAJt9mqUDovxs/Wk4UYbwRVckQREU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=JPsWUxP6nxbKFjtu2YNZtlMiePhn4V99WbYiXMQosqqBqXBYfgjUP5sVZ+z4HW3k4
         yyBvGgiCB006eprHkEpriO88Xp9w8xBs2YGMD0i7rBdXNK8WpV7vfb1HHeOpxeldKZ
         T4kmyqC4hQG8X17mAdpkfYfOcStPr5L3aGjXFO84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDysm-1mqtDG2klQ-009wNY; Sat, 06
 Nov 2021 01:21:11 +0100
Message-ID: <48a2c568-7c4e-e4a6-4145-3c154086ceeb@gmx.com>
Date:   Sat, 6 Nov 2021 08:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 06/20] btrfs-progs: check: stop passing csum root around
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <d3f2065cdfc56e6fe96e7cf1b736899ef7699111.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d3f2065cdfc56e6fe96e7cf1b736899ef7699111.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uAifzX1fP51te5AqsAjzP7q7eBUSESEhM1am4KptKtNgBNdOXuU
 xF12r76yIavWl3QC4G184eAROcyp6tkZf9/kH4L7SNGoLzQcxrzvOyUbRXbD4bkd0Nxtmv5
 VBRC9lyyjMqJwqRuO7gZ/0BT/FfHF+SCDOQ1ORWGuhDubYBFsT59Ce8MJcLl7Qwxk4hrykE
 MFpViEaIgvtaNWBw9uefA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jbhuRdK8weU=:3repXETiIYBCe7DMhcZ8ha
 LQA9mRw1YBSeetrwy5824/ZOHy3zgBrBC2063vZLptwiwoa/DtwyLYhgaadWy0xaQ1EA/lsgi
 bNBlcsOOczjfPO2geouDFsFlE08evvT9bgjS3Nn2C9l3YNPTlP2ipYQMX0Ici8bWsJwB+Twny
 YK5qAU2gyO2VC14hLvFWamY/2cmf6qJub3E11CShXewmhCHJrE7tHhx8Fd78OpTIugs9WZkDX
 KA+m6Gvi0q9MiN7bguLwogubDYRpKtLX8FHCwy6psNF77GKykapyPc/X75C0WwsoNmqBEdGLm
 picjiQ4QI2eHBBcXvGBjIlWlOdyXqHmAl61aqlJ7guucXYVDAO7IJ3gGYB2Lz77je/1AlHzzb
 76KgFNGb+osVZ2pnzT3XR6Z4B0+pFgDPOElMtUMsfdJlQC24jNBvi3Hn+41fefKuXUMeSeeh8
 dT7o7KtfhqOIocSwpfkNYNl1VYZnwuB1qByUJ5/k86McA9To732yZLOYF7jnDfVR1IxyBJny1
 AYaalhFuq9ErAlYyXbXjqG2GNSNIsK+5UBdgkgxf1i8giI5lBfKTYfpnmGFMYERvB/zV95xby
 Svo7MfONuhPgvsymzQhMWE9N475RcUo3Z5CFfx0B6IrYfSLSFfkTsGIKpB2F2CcPZJ7/UKPRp
 5DX2L1Ab2dRQ+QVUozOuJEc5cGdJbGvJ4REWF1h3pJkC88RpFv051AzpAMiLoi0Gn57JPhhPH
 42gL+w+V4X/MQOcqqsyDE3LO5pHJUn0JR3oWsUUZgrqgTv6P9IC5e7RjuxhZ+2p4NooOoHgZu
 LDMjwoocMehQj/38+9s2aFE3XmW4HXxWEAp77oEKa33aie0J3xC7hMIbx/xElqKLpWYp12pap
 zyjMIxa/izl/OvyX5Ahjfo9SRv6OBg4RDcVHbFsBY8PfEmzZaht172XJOMZY+6uglINsxer5c
 UIikoH461H6LcQ3xW0j/xBSPqCZc5hUn8jLLFLkacuV+aDaQSyDNPn0lLOGb+h357BmV52rlk
 0576wuHTAbPwO45XjSUc7JGq9dB7JCDDtp3DhmjHsnuZGjwOTa2pe81rg9sVQE1L8RhNPNCrn
 XNonduz4ibI1tk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We pass the csum root from way high in the call chain in check down to
> where we actually need it.  However we can just get it from the fs_info
> in these places, so clean up the functions to skip passing around the
> csum root needlessly.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   check/main.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index 08810c5f..22306cf4 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9494,9 +9494,9 @@ static int populate_csum(struct btrfs_trans_handle=
 *trans,
>   }
>
>   static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *=
trans,
> -				      struct btrfs_root *csum_root,
> -				      struct btrfs_root *cur_root)
> +					   struct btrfs_root *cur_root)
>   {
> +	struct btrfs_root *csum_root =3D gfs_info->csum_root;
>   	struct btrfs_path path;
>   	struct btrfs_key key;
>   	struct extent_buffer *node;
> @@ -9557,8 +9557,7 @@ out:
>   	return ret;
>   }
>
> -static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans,
> -				  struct btrfs_root *csum_root)
> +static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_path path;
>   	struct btrfs_root *tree_root =3D gfs_info->tree_root;
> @@ -9598,8 +9597,7 @@ static int fill_csum_tree_from_fs(struct btrfs_tra=
ns_handle *trans,
>   				key.objectid);
>   			goto out;
>   		}
> -		ret =3D fill_csum_tree_from_one_fs_root(trans, csum_root,
> -				cur_root);
> +		ret =3D fill_csum_tree_from_one_fs_root(trans, cur_root);
>   		if (ret < 0)
>   			goto out;
>   next:
> @@ -9617,10 +9615,10 @@ out:
>   	return ret;
>   }
>
> -static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
> -				      struct btrfs_root *csum_root)
> +static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> +	struct btrfs_root *csum_root =3D gfs_info->csum_root;
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
>   	struct extent_buffer *leaf;
> @@ -9690,13 +9688,12 @@ static int fill_csum_tree_from_extent(struct btr=
fs_trans_handle *trans,
>    * will use fs/subvol trees to init the csum tree.
>    */
>   static int fill_csum_tree(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *csum_root,
>   			  int search_fs_tree)
>   {
>   	if (search_fs_tree)
> -		return fill_csum_tree_from_fs(trans, csum_root);
> +		return fill_csum_tree_from_fs(trans);
>   	else
> -		return fill_csum_tree_from_extent(trans, csum_root);
> +		return fill_csum_tree_from_extent(trans);
>   }
>
>   static void free_roots_info_cache(void)
> @@ -10700,8 +10697,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>   				goto close_out;
>   			}
>
> -			ret =3D fill_csum_tree(trans, gfs_info->csum_root,
> -					     init_extent_tree);
> +			ret =3D fill_csum_tree(trans, init_extent_tree);
>   			err |=3D !!ret;
>   			if (ret) {
>   				error("checksum tree refilling failed: %d", ret);
>
