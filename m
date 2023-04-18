Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C596E5742
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjDRCCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDRCCO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:02:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07C10E
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:02:12 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1pti1h0Ljp-00TzKA; Tue, 18
 Apr 2023 04:02:04 +0200
Message-ID: <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
Date:   Tue, 18 Apr 2023 10:02:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i98m1bxECYEBw6j95wLk/RqW6LlNpGeTMkQqsvWjNOXioImHufF
 i2JZvCj58wYRuZX6vuCAY0KvVY0tY8JHyM8C3YGsKiBOhvdqrpEdGveAVeOEZoHKtShy5ka
 A4beKpTUskVTp/Aq3YXmFArCaB3O77vcdbXPM0Ir54BPikTWffaoBpbvHWYEaGsOltnP0nD
 rZVlty+kKvTvRyaTbRO4g==
UI-OutboundReport: notjunk:1;M01:P0:sqNRxw9FfPY=;ba/MeI72bedv8/qOWnXUmZayPo3
 5q0z7S6goiJZckZJsnX19qrHpNkwJ0FhjugEMkFXUih1uK62/Qs18dv8tLNu4mgdkJlYvFqZb
 J5Jy3zNJgrcRvwir9/KTYRF+VdighBwPTUFkjD/GguHSSzyiuQNCprn1a/AUSI++ATPqA9dm7
 3HARNepqd/z1Wr7i297fkGp7h5qyCROEOnE/rRjhoVzHt7TTlc58yp1/BDbQryxh1ZBdKR0wD
 4QYkF4IKuxaXQA6sec+G09+THB+VRuacJzjOzQUyYF4hhh7ARwG9l3d+JGriqfm/1htgdk6L5
 xm5JKU0hVqVg8brTyXG6QaWeGY/JNvrQ2CCsg3nezUmba32ANFd5PuQh8rxsGc5RjKZGQWBSI
 lWbAZh5j4sOvUUxYkGTeLVJjOwCVYMD4F+c64TsTsphhjJ12zWV05Xkx6L+56yTBcCUXpe07p
 fa0PROq4Uc94ks0PXDjpZAF09vuSQ2OO5ciXoa7Z5hz4FbANj0lKX+SysXUDjISn+wqpTdP3O
 8Fd99PE+16jkiAmWJyLvDqIEbnTOu0jRCy0IPErZjlQiSH7wVvvXWVpL4IUIMRejt0ow9n2A9
 P5DrfJkMsdcGtTGM+jzICLDTteUXJGpDaVX1udQbYakR8ViTUxRuSKJGayvXAwzWrVyQq7r72
 snaSRIXDiNbNuoQoTPOqum2BSJ3etMZXOzA01DB+5IoURsRVG4EPBQrrwne8MUZTXRU5a+XO9
 N6AP9Y4Bs99hnwK9n0/pTldq1Ub1p3w9N06m8/7KY6CACUcwtJ/pCmDvPZRfF9UMfzAeDqsjq
 lV4KSBNdTmg9EJKMObtWHHsJAKduBs3B+aJ1vWF98NpEDgHmvLk8YnazXBUXVKPZeU3QdYs8T
 KwRosZRwuySaxLUfn3jiZ4w24WG2bHTwTT2QuKER8alXs7zxluMZt5u41xA3kx8Jp3NWGGYp5
 FzXzlXS5NH1DU84nWXYjgmUl2ZY=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 09:17, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> btrfs_file_read main 'aligned read' loop would limit the last read to
> the aligned end even if the data is present in the extent: there is no
> reason not to read the data that we know will be presented correctly.
> 
> If that somehow fails cur only advances up to the aligned_end anyway and
> the file tail is read through the old code unchanged; this could be
> required if e.g. the end data is inlined.
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>   fs/btrfs/inode.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3d6e39e6544d..efffec0f2e68 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -663,7 +663,8 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
>   	struct btrfs_path path;
>   	struct btrfs_key key;
>   	u64 aligned_start = round_down(file_offset, fs_info->sectorsize);
> -	u64 aligned_end = round_down(file_offset + len, fs_info->sectorsize);
> +	u64 end = file_offset + len;
> +	u64 aligned_end = round_down(end, fs_info->sectorsize);
>   	u64 next_offset;
>   	u64 cur = aligned_start;
>   	int ret = 0;
> @@ -743,26 +744,26 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
>   		extent_num_bytes = btrfs_file_extent_num_bytes(path.nodes[0],
>   							       fi);
>   		ret = btrfs_read_extent_reg(&path, fi, cur,
> -				min(extent_num_bytes, aligned_end - cur),
> +				min(extent_num_bytes, end - cur),
>   				dest + cur - file_offset);
>   		if (ret < 0)
>   			goto out;
> -		cur += min(extent_num_bytes, aligned_end - cur);
> +		cur += min(extent_num_bytes, end - cur);
>   	}
>   
>   	/* Read the tailing unaligned part*/

Can we remove this part completely?

IIRC if we read until the target end, the unaligned end part can be 
completely removed then.

Thanks,
Qu
> -	if (file_offset + len != aligned_end) {
> +	if (file_offset + len != cur) {
>   		btrfs_release_path(&path);
> -		ret = lookup_data_extent(root, &path, ino, aligned_end,
> +		ret = lookup_data_extent(root, &path, ino, cur,
>   					 &next_offset);
>   		/* <0 is error, >0 means no extent */
>   		if (ret)
>   			goto out;
>   		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
>   				    struct btrfs_file_extent_item);
> -		ret = read_and_truncate_page(&path, fi, aligned_end,
> -				file_offset + len - aligned_end,
> -				dest + aligned_end - file_offset);
> +		ret = read_and_truncate_page(&path, fi, cur,
> +				file_offset + len - cur,
> +				dest + cur - file_offset);
>   	}
>   out:
>   	btrfs_release_path(&path);
> 
