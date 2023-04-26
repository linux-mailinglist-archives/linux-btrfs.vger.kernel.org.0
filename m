Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5B6EF342
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjDZLSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjDZLSw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:18:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDEB5592
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:18:36 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1qcHnh1Rgh-00pdAK; Wed, 26
 Apr 2023 13:18:31 +0200
Message-ID: <a6097029-68f6-266a-c820-00bde56cdeb6@gmx.com>
Date:   Wed, 26 Apr 2023 19:18:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] btrfs: abort transaction when sibling keys check
 fails for leaves
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682505780.git.fdmanana@suse.com>
 <df0094379bdfae431142657c27dd00a854a4b402.1682505780.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <df0094379bdfae431142657c27dd00a854a4b402.1682505780.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m6xFPO48sMMHDMIEM90igAAp97iwVS8mDEV9jfmy9Fq6MbJ/2wf
 rCJldVabM8FAyY8Z7InDBmtUWUxxTfamCqiz4fqfydUhS4leyUL6Wqb8mh8NLna4OxHoCBW
 b7ZF1yRDejvhCQnbB4cEjooHIaCQFLvSKASZg42Sm3BPtUR5EqsyIviBlTukyGg8pr5HpS1
 sJz4D1D+sLPdPxmQwqAvg==
UI-OutboundReport: notjunk:1;M01:P0:ugtp7y5AfPM=;ca8oZdi4DgbNrmTTcKsCjX25f6q
 3+3UEztzTGLROngmQVU3WGMj7as0N5iS0sUfPNnec8dBVoT7HkAQ21T+tmYGnuhKqNDGDB0yg
 plsVbaMzNqg5wtiQmOXFEn10KgtY3PJO6LI6XJ8LWYoe/WY1zhciNh1SC4O8D5ATUD6T4lnUN
 nT0A7F43gzkB9i3MpK4QsxCnLo7gXvDF7tIhXDC4fD3/nP68MEbAbRphgzQd+kXQBi1oT780H
 pmy6Pq4LpuvP27pKvAsNvzT0O5t47JPQCUkeHpC7JHVVGreVJDOmfLNnZTJ38XCkZUj0EsJ8L
 76x3xiQEE04YoANCyl7S9q82V2b8lQxl7WmujjYFJJEQ2gdwQ/+4IWWIxxzbNyFGkOLD2GtUQ
 5Je2hD4AEooqc/I16Wnx74gQQ84G1eUeJ6Wn/H3mmQmtMbQ8SzbG2iJBRUliCT0MobJ0aaphR
 4ozt2qDkuf2OWBQdMMstf/KIDH4p9++xhIrGFf6K5w3cIPwkFCvvuDz5iF494W1PDxrm7b849
 AgWC+U6qejn6LsntUTmcDbPHF0lN1JFQ7xKHYcZbiMkkGG5KSEXs5QC4u6vJDxKIMMeEs+FeH
 rVCKOECrjaO9pG/8sh9khWzPstowBQ2rAG5nw0Pzkw9o7uN4SOicnKz1etoeqTw9uZ5rGhYZA
 dBFB9ZYw+qN8qwCbaleK4LOFkJCCnUDCukyVYJOidM0UnvwXjby5KGa+YcGpYXea8ZiijPhqv
 Gv7LEeP6ACO3hAbHglZmpNm5Y0bSqwLNCfvT+Hwbfw+6RpOJGZM14IcDLE/pmvitoOYjmEkEC
 UH+ZRjYixbiXklvR5Vwp8++2uiK4z+X1hbf3/rUCFI7xr1EhOkjTxXMzzVQEwW1tVqVl09RAc
 LY4c/DN9K6vXL2+HmPPkNxfZ88CPAbIA6Y54xtp66Bh2GGBUegz3dAIzidXUD//1DZ5uGvTHk
 tVWOh49bGIaW9wrD6QdjuAWjCIQ=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the sibling keys check fails before we move keys from one sibling
> leaf to another, we are not aborting the transaction - we leave that to
> some higher level caller of btrfs_search_slot() (or anything else that
> uses it to insert items into a b+tree).
> 
> This means that the transaction abort will provide a stack trace that
> omits the b+tree modification call chain. So change this to immediately
> abort the transaction and therefore get a more useful stack trace that
> shows us the call chain in the bt+tree modification code.
> 
> It's also important to immediately abort the transaction just in case
> some higher level caller is not doing it, as this indicates a very
> serious corruption and we should stop the possibility of doing further
> damage.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d94429e0f16a..a0b97a6d075a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3296,6 +3296,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
>   
>   	if (check_sibling_keys(left, right)) {
>   		ret = -EUCLEAN;
> +		btrfs_abort_transaction(trans, ret);
>   		btrfs_tree_unlock(right);
>   		free_extent_buffer(right);
>   		return ret;
> @@ -3514,6 +3515,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
>   
>   	if (check_sibling_keys(left, right)) {
>   		ret = -EUCLEAN;
> +		btrfs_abort_transaction(trans, ret);
>   		goto out;
>   	}
>   	return __push_leaf_left(trans, path, min_data_size, empty, left,
