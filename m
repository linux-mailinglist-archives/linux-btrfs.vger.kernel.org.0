Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B911A649B19
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiLLJ0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiLLJZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:25:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C08DEF2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:25:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1p1dBx1eph-0083xU; Mon, 12
 Dec 2022 10:25:41 +0100
Message-ID: <7014fee8-ed91-2748-264d-d7937473cfad@gmx.com>
Date:   Mon, 12 Dec 2022 17:25:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] btrfs: directly pass in fs_info to
 btrfs_merge_delayed_refs
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
 <49459983637681dd5d1b4c04d0f9dc2e6ada301c.1670835448.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <49459983637681dd5d1b4c04d0f9dc2e6ada301c.1670835448.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xw1uPsRlnj659hnKSZNapP6Dr6+Ggr22Ij2VtEVkC4Rw1nbfzAO
 7o6AxoiLiR3p7f74MkaKXJwDfZadGzylnl02qslJytFQhtV9ZDjj6ii6aXWhFWTKmdlhYLP
 gNebv57yuLkapx7aLu0t6lsFWhn0lgJsVz/p63hIISlpr/+ZsCEFnbXtfhlMIXDK/iZb+Lw
 9mwMADVCrjOngJ5tdtenQ==
UI-OutboundReport: notjunk:1;M01:P0:X+NT1dAuTuU=;vN0Yhn9tf5fIpsHmnRrwRMR+Wkt
 3//gn10dxGUxqcBUX2HHQb2XwUbAndvYNgUeJk38G+LKlAaOR5WINDOtmdKRqIc4/V+y24GeD
 DGuSX3lcZqUXsic0dckYBeMToEJXBUAAAbwhNe6gnSWfl5Sx40CJHtHILzfiILHQZjuXI+WSF
 sqY2mVtghO3QBKMGHfPj3LJUzmdlkJH/WLKgCAcUqnhzDRYnO1nlD4M34KSyc3XcS1OmJKBIB
 bEW4ojZko+IZG658aTB21D7HFD8FdBBHgq7ClUxwAzCSFKEPhL8ZylF0V+aerf5DSEPHrhj11
 JkW5n02DtW1rtRUgIS4RRB627bw7cp153ZDIeeO3nUbRAnjqDn/kpLOMtK00ZBH1bjbcEDtqx
 T5nvkqUEXV1ynkTozaQgfvkV3jbCeqcdsU2vOjnZRD3j12IqkZyIvfld2kxOFXS6FmEVU1bkp
 PO0dUr+3+YFpsqMuXMHGYlkc+mpybRqjCrNpZG18fr76M/XGaS8BVbhCAJJQfZW6OCWQ0xbUT
 s7DEmS6lUYhSs3Tv9CNbsQ5dR0q9sFNRpSMfCCyjuSBxLThRFEhvabJX8e6yWGOcC2ljDBbRl
 ouQrr+8KQoAcpjvkc8D714H9crrp1ofWXbYs1AisSfnMD1A1QSSel3fvyrsUe/yaQZHxj/QqJ
 cfh5WbOAA+7MnQBHtHbWk0TxZIyE7IENrZGG6UcmJ4+7FddeLAFHWNQK8ijxpijtV0LBU5JP3
 fLl4IxNrSzpo/028T78gKLNvazXl2U3UlmXlnRUx1ryGVLwODccJOZ4MjEaAtaEXwglzz5SLQ
 GO2Fx2/sxgghm6QFfJ3BpC67HCqFpHh1NS5L9DZn/TCmD2r2SXm+yOUGZSL9CTcX9Tk+qZ+gl
 38bW70DUE1ctZW1qwC5pDsb3I/L3f9MSOm/sSGWltVE2X3TB7YBm9GRr4+Slwo6JQPyoPtuWD
 eSiATzs3didSawuK7XbZfVM4Ysk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 17:02, Johannes Thumshirn wrote:
> Now that none of the functions called by btrfs_merge_delayed_refs() needs
> a btrfs_trans_handle, directly pass in a btrfs_fs_info to
> btrfs_merge_delayed_refs().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 3 +--
>   fs/btrfs/delayed-ref.h | 2 +-
>   fs/btrfs/extent-tree.c | 4 ++--
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 678ce95c04ac..886ffb232eac 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -497,11 +497,10 @@ static bool merge_ref(struct btrfs_delayed_ref_root *delayed_refs,
>   	return done;
>   }
>   
> -void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
> +void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
>   			      struct btrfs_delayed_ref_root *delayed_refs,
>   			      struct btrfs_delayed_ref_head *head)
>   {
> -	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_delayed_ref_node *ref;
>   	struct rb_node *node;
>   	u64 seq = 0;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index d6304b690ec4..2eb34abf700f 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -357,7 +357,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
>   				u64 bytenr, u64 num_bytes,
>   				struct btrfs_delayed_extent_op *extent_op);
> -void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
> +void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
>   			      struct btrfs_delayed_ref_root *delayed_refs,
>   			      struct btrfs_delayed_ref_head *head);
>   
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 892d78c1853c..eaa1fb2850d7 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1963,7 +1963,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
>   		cond_resched();
>   
>   		spin_lock(&locked_ref->lock);
> -		btrfs_merge_delayed_refs(trans, delayed_refs, locked_ref);
> +		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
>   	}
>   
>   	return 0;
> @@ -2010,7 +2010,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
>   		 * insert_inline_extent_backref()).
>   		 */
>   		spin_lock(&locked_ref->lock);
> -		btrfs_merge_delayed_refs(trans, delayed_refs, locked_ref);
> +		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
>   
>   		ret = btrfs_run_delayed_refs_for_head(trans, locked_ref,
>   						      &actual_count);
