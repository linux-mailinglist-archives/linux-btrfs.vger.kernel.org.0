Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A2710A20
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbjEYKbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEYKbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:31:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B71AC
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685010691; i=quwenruo.btrfs@gmx.com;
        bh=9yBG8oORAqB1SutpsKhgF6+qIGd1tBCq6JM1dJozBYM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=G96XeCzDXjjx4WNtzD/u31haO7ce3YtZ9hNQykYufAbB4EBqvJYtS2gLx29Cvv+Cj
         ms+90nxDYMZRcQj9MmMxciVmdKd5Y4mSvXVC3fwQhkzPE35xssaHjegv48uYwZQ2Sk
         1YbWsHnZeJjKectHoBsIJuubPK629D6rmiG4ug2/V1l2sV9sP9A3snr/ax3ZhJcFjB
         rQ/mtABl7vdVjp8k0CSDapydmre4bLA0CYSz/dXBMoQYKzKXL7/bcgnARoDbiBKo5g
         HMNEYWi7NPuxf0H7Nkio9hnsccsjR8QTnfq/zB+c97UpMrpbkdA+P2zcR2y81C72Xi
         3RRSl/9VxMyHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2O1-1qfZg32wiH-00e6g4; Thu, 25
 May 2023 12:31:31 +0200
Message-ID: <083c9ccd-4f01-c4fe-4e03-0528e3cdeaa6@gmx.com>
Date:   Thu, 25 May 2023 18:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/9] btrfs: open code set_extent_defrag
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <14705ec263c747043811d070f32c77a6ab838336.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <14705ec263c747043811d070f32c77a6ab838336.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xht9/tddTADm9M5FEsoIKp8zL/1O5B6rQlFZ7YHmO1blVuMf6He
 OWTV8pdhPanbPhflXWQpeNxUoadXi+MPHLEMxt3gBu2WBpLoOXb99u704jcXNbvUHFm/9Kf
 05jYsCkRHLypHYYuvcvr0apERo+8op7KwmD01eWVwnRXIYSUxLGw4HHO5PpGOIlbzzF52lc
 GIGUni8Ra4dcdy27ISfww==
UI-OutboundReport: notjunk:1;M01:P0:tXgUaTIpENQ=;MuXh0+hS/CLn9jRY/mFK/xJqdrU
 cHzUadO84ykoU8GqleMfkfnNyEks0BiVjE+s9Gb/i20jZA+o3ZBSHi6DH3o8fIlQVxZxyOAwG
 UgWUu/E9Q7ajh/weBzSC7uYJFRu4Hrcrq7RTGYzf7O52uLljOOeoX4au4z1/IZ6ijqrQbqCtm
 NJQbqOA0xhaDtV4o8a8qqttruIiTVS+IXbk9xCuQamiXIYKrohFWgVWlE6u+xb6ftw5W4Fk2w
 Jwt6vq2V9M3bYoR1rEa5Iv9R9MovoZlzckanY732IplMA6HrNx2erpKvRUd3KZu4xAx7nQB9m
 HsR4L6Nym6Ke747Viy+jwQPOB2ujLeK/Kcv2YEvS9bL9yyxyw/urYIPUEPHvmcCPxJk+DkOHm
 FWzTJUC9Z3RJNbliUMbeWrTnecCDZ714yr6xlrRDK6Ar30Um6KimMTff7vaYzzkacpphg7exL
 RLmWFCYreFCCc22pfEjmPm7gN53W2+rflkPDQ5TbWrS++U8HhbTxLrHYrIChDbpPIJK8NDwjD
 NBNzzec1M5m8krR5cx6MCiP4DpVgk9jZyVcfkn6afpeY4kRKjPVDwOJUMM5DQWCPX+3yzxRzY
 1+p/SEteOA0drUPWIHJbdqIShEQQSI5HnjVm3RNYRK8qv0tTFWPAkThjNos3U6ki9dYVshiaD
 uWdxyN0H42f81lYZoYLFuNszpiNFyID/gv2pU60qDg4FH0g5N5wmVsaUCeuaIbJxnq2tcto6+
 7m0YTvk18lHSg2Z3o4ttN6RNtdMCqDRI17Nj9gyrCxu35aVsnLF2gKE2wbDRlhpfdQV5OhTC9
 SqXOnXDtGomX1+5mHWgbHcVjBIUwtP/OmVZpynq4OzT15rlRvtQmWaAZ713QbB8lZrt1yT6Hj
 lnBwEE1etPCuQbhsAF8iMG+Lue4wwOYdYOud9a/DVhnVLBGoC16Vy2c4wgGsggFV5BSvqPmTd
 /gIhy+VUE9LY4DtfrTDSpo8PJmc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The helper is used only once.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/defrag.c         | 4 +++-
>   fs/btrfs/extent-io-tree.h | 8 --------
>   2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8065341d831a..4e7a1e0a0441 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1040,7 +1040,9 @@ static int defrag_one_locked_target(struct btrfs_i=
node *inode,
>   	clear_extent_bit(&inode->io_tree, start, start + len - 1,
>   			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>   			 EXTENT_DEFRAG, cached_state);
> -	set_extent_defrag(&inode->io_tree, start, start + len - 1, cached_stat=
e);
> +	set_extent_bit(&inode->io_tree, start, start + len - 1,
> +		       EXTENT_DELALLOC | EXTENT_DEFRAG,
> +		       cached_state, GFP_NOFS);
>
>   	/* Update the page status */
>   	for (i =3D start_index - first_index; i <=3D last_index - first_index=
; i++) {
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 21766e49ec02..ea344e5ca24f 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -202,14 +202,6 @@ static inline int set_extent_delalloc(struct extent=
_io_tree *tree, u64 start,
>   			      cached_state, GFP_NOFS);
>   }
>
> -static inline int set_extent_defrag(struct extent_io_tree *tree, u64 st=
art,
> -		u64 end, struct extent_state **cached_state)
> -{
> -	return set_extent_bit(tree, start, end,
> -			      EXTENT_DELALLOC | EXTENT_DEFRAG,
> -			      cached_state, GFP_NOFS);
> -}
> -
>   static inline int set_extent_new(struct extent_io_tree *tree, u64 star=
t,
>   		u64 end)
>   {
