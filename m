Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB681649B05
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiLLJXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLLJWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:22:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02607F71
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:22:40 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1opL5W1Hpp-00tTiH; Mon, 12
 Dec 2022 10:22:36 +0100
Message-ID: <e7f70125-280d-87d3-0975-693a9a36f769@gmx.com>
Date:   Mon, 12 Dec 2022 17:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] btrfs: drop trans parameter of insert_delayed_ref
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
 <d47bb8668e2d3307923d653d781eda65582a6a1a.1670835448.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d47bb8668e2d3307923d653d781eda65582a6a1a.1670835448.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dVL5iImwOfmyJdhswS6k13dwo9y1VLzAQFPVXCF5A7x0/z/bFBD
 18Qf/uZua7k7kdShx0w/pB24LtfOpwMSEUEbSFoLHT2luBs16JpRahmqPiMgpx1nf8t6V8x
 yUEmbJeFQnQj48b80vhDz1iuE4Pu+Oib9IQswqDGewVu8ouP/ugHxxZcB2VOCafy6PqdIhx
 f8UmZBqBnz/OseM7jCdYQ==
UI-OutboundReport: notjunk:1;M01:P0:Dp+3bbzgo/A=;aGwEzUsku8bvZWQkIHvgmmXWhoY
 y1ur7l4YplK6MDhJkTX6AnB8NHnUgbNwgOSJlAyE6xVuGWwfhV+MfBSsKUD4/MtbZKaItE1lJ
 ppggiJvt8XDA1KeKB6NgyDvSENdJEMnJK8mQZc//E1vRd86HyebroZXNgc5zy5VPaUcD+6CH+
 UPvMAvyhkW5FcD3CUvYuOyiCjLGgw9Zc2hW463XAb9j9ibjKlg3WgOoOcPnTo3iKj2gwbIBvh
 yrAgXWoDDkRu44iHb7RPP8vmAJufuM0NehIecBWCkocI7rU6P5BkGdgu2snypg2hzvcWhRO9/
 1z/4MnpXjhvcVXmzGimid3u1on5/IotXe0mAYW3nbvxtAFr48+PvTCneraHd6k/4mD6aR1h4S
 FVa3kocQvhInHyxYAsV8lvPeO5tEJNDuvova3uxNzh6EDERBF9PFgzYnG05MsKblEd3yDs5mk
 KdpV8X2ROkshZTsrMP1iEU8/MVHquc4rnrhWHQr5UTQbWurzF0huZ6pY7UallD9wh73aLNIl9
 EHtUiox4wl7nzKSliEKGqoXZt8j+89TU10QLNqrQ/Dp9btcNNHyrh8Y9GtU5cXd9wNnUyCt2v
 90rMuC2tCGHOz5z0W3/rlH8YdDcAuvYT/C8GNLI5rCul7UEDiVMVV0jZASEO32fwDfXclgjIO
 aFxJXRdtZhKtzN+tB7Cgn9c/URNw8SO4uJK0+tS/9mfB9//0WqSzhevqb9igBvBi1tALYUkjE
 db+zJaCfAg/XgNRE5+P15bcKjTvg8wzGfaY1sHSRG4h+wGzbRH2H1Knlj8DExDoHm56nd3Scl
 HkegEKrzTEkYDRuMgY3ARcQpF85Rgn8IyPCavk28t6CD/WH1IkJWEfqUcmyzz+c0YTKyvTa5/
 wXSpRuxRCJJwNgWu77LcgsyZB94Kt/J2wzS+U51Eu7rG2I8sAs2X57lps527cDSbOvRsgYW5/
 Tpm6K4r3YFsER0c+/q1ocByc0XM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 17:02, Johannes Thumshirn wrote:
> Now that drop_delayed_ref() doesn't need a btrfs_trans_handle, drop it
> from insert_delayed_ref() as well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 046ba49b8f94..678ce95c04ac 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -599,8 +599,7 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
>    * Return 0 for insert.
>    * Return >0 for merge.
>    */
> -static int insert_delayed_ref(struct btrfs_trans_handle *trans,
> -			      struct btrfs_delayed_ref_root *root,
> +static int insert_delayed_ref(struct btrfs_delayed_ref_root *root,
>   			      struct btrfs_delayed_ref_head *href,
>   			      struct btrfs_delayed_ref_node *ref)
>   {
> @@ -976,7 +975,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   	head_ref = add_delayed_ref_head(trans, head_ref, record,
>   					action, &qrecord_inserted);
>   
> -	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
> +	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
>   	spin_unlock(&delayed_refs->lock);
>   
>   	/*
> @@ -1068,7 +1067,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	head_ref = add_delayed_ref_head(trans, head_ref, record,
>   					action, &qrecord_inserted);
>   
> -	ret = insert_delayed_ref(trans, delayed_refs, head_ref, &ref->node);
> +	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
>   	spin_unlock(&delayed_refs->lock);
>   
>   	/*
