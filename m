Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A966B3750
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCJH24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCJH2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:28:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5787EA026
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:28:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1qOMwZ0jbW-00tnrw; Fri, 10
 Mar 2023 08:28:45 +0100
Message-ID: <c37f58bf-014b-d4fe-103b-1bf27e1d296c@gmx.com>
Date:   Fri, 10 Mar 2023 15:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/20] btrfs: merge verify_parent_transid and
 btrfs_buffer_uptodate
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m22tq/xlLvDryL7gZ2WhOluNU0N4FN9EIkrmjey1+J7fiOvMbUB
 yRO8jThqcoISiJov6Tl/gDL3q0xdEws0bvjcfsSVpxkDHLqLAU62n0k7IwYieIUt5xrqhSC
 YKmp7H7AO+VHnBV3wkoHVQaIMVWGt3lss/hn2QUZofKKzRO51gwtNzI2TOVRj442ds5gB/9
 llPzVJOExIHs5etaLpzFQ==
UI-OutboundReport: notjunk:1;M01:P0:FdJoUSjC5ZM=;TAJyApofb2VNf1O8ov5gGNgKanx
 sRlOpcqMgB7Bo7YVOlof1EhVoQyjT6tS4KlvOf0X6k43B2u5qD8oelxMU57xKozRzcRwDLUPe
 BWV0UKDsCO5vScZVObnCXw7z9GJAkO2EMc3zRpPSnwjGZ++yDUF3rlSgNg9ubFARRynVXG+OD
 i3sgLarAH7wm1q35KpJygYfjxascOONCmq3+omVHrbgRt5D0IrICkZYGev4G787WVcY1940Jb
 JgbORY0bn6dlUSQ4yOzeqaatsmozxTmCtybwFp8Wcn4yJVn9ieiB3+shwijUNEnG/+tgG7kgj
 fE1YaQ2PwA930pmaor5MuIJzpE19rrHYlEKq4L9u0HZuoh/6+sFhM4maZCsV1BcjwJFio0YDn
 4cOehZT51ejB8sRMwnW1Bl27VfWq11z342iknOINB6KCdBI9lzDtvRMQ3W5i3Zo3Nke3pjlic
 x/GNRRUWn2Wlc2gfKoK0YyHFAtpr1cFSgMnVLkDtcyQfSptoyALHqkozg5UKxOOZq4ZbNYwYZ
 L+LTIuZFe1JSj1KSw1581/ZCehMcGcY54TjDXVHzis/En8kfWCD2AR8AIM4fochmY2zIeyfE4
 qlH9ocSpFQnVYf946jh3Qe5UmLBNczNU8i6eJZqrHwn8wL96J61Zs7HM387T7HTgH8refm+RV
 Ov7QosW/aCgwo0BnORYZh1QLDqjaXWh2sAmsBl957gqXw5deJq9Spz6wgV8eiMWrXJ5YTSQ+x
 hsa2bbSlitXNOogz0WYrmbGLfNEh4EafVVDIZ+NpBddMgXDrXNN0F8BrJJs+WDnAjsX2bIS0v
 SpqSZzQwHuXUGJBgA7VILBu2ZCUKBUaCQTdfkq5AIoqG5Aj2wQM/2Ci2iz5TLCXEDcupeimP6
 fWKqPyiJuC4Qq1UDCmOgiX6tBfKlAmZHRKwtOVswIBx32NySA8czGU8NHBIbNvJt8CeAhYHwv
 EyRDLCmn6gZrsEU9Cf5DaTDnHtY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> verify_parent_transid is only called by btrfs_buffer_uptodate, which
> confusingly inverts the return value.  Merge the two functions and
> reflow the parent_transid so that error handling is in a branch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 46 +++++++++++++++-------------------------------
>   1 file changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7d766eaef4aee7..d03b431b07781c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -110,32 +110,33 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>    * detect blocks that either didn't get written at all or got written
>    * in the wrong place.
>    */
> -static int verify_parent_transid(struct extent_io_tree *io_tree,
> -				 struct extent_buffer *eb, u64 parent_transid,
> -				 int atomic)
> +int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
> +			  int atomic)
>   {
> +	struct inode *btree_inode = eb->pages[0]->mapping->host;
> +	struct extent_io_tree *io_tree = &BTRFS_I(btree_inode)->io_tree;
>   	struct extent_state *cached_state = NULL;
> -	int ret;
> +	int ret = 1;
>   
> -	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
> +	if (!extent_buffer_uptodate(eb))
>   		return 0;
>   
> +	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
> +		return 1;
> +
>   	if (atomic)
>   		return -EAGAIN;
>   
>   	lock_extent(io_tree, eb->start, eb->start + eb->len - 1, &cached_state);
> -	if (extent_buffer_uptodate(eb) &&
> -	    btrfs_header_generation(eb) == parent_transid) {
> -		ret = 0;
> -		goto out;
> -	}
> -	btrfs_err_rl(eb->fs_info,
> +	if (!extent_buffer_uptodate(eb) ||
> +	    btrfs_header_generation(eb) != parent_transid) {
> +		btrfs_err_rl(eb->fs_info,
>   "parent transid verify failed on logical %llu mirror %u wanted %llu found %llu",
>   			eb->start, eb->read_mirror,
>   			parent_transid, btrfs_header_generation(eb));
> -	ret = 1;
> -	clear_extent_buffer_uptodate(eb);
> -out:
> +		clear_extent_buffer_uptodate(eb);
> +		ret = 0;
> +	}
>   	unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
>   		      &cached_state);
>   	return ret;
> @@ -4638,23 +4639,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>   	btrfs_close_devices(fs_info->fs_devices);
>   }
>   
> -int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
> -			  int atomic)
> -{
> -	int ret;
> -	struct inode *btree_inode = buf->pages[0]->mapping->host;
> -
> -	ret = extent_buffer_uptodate(buf);
> -	if (!ret)
> -		return ret;
> -
> -	ret = verify_parent_transid(&BTRFS_I(btree_inode)->io_tree, buf,
> -				    parent_transid, atomic);
> -	if (ret == -EAGAIN)
> -		return ret;
> -	return !ret;
> -}
> -
>   void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
>   {
>   	struct btrfs_fs_info *fs_info = buf->fs_info;
