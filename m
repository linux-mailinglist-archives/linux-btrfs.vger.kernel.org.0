Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154426A8D0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCBXbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCBXbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:31:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16B028845
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:30:57 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1qMqJu1hwB-00pcXd; Fri, 03
 Mar 2023 00:30:50 +0100
Message-ID: <f6d8adda-e527-d01e-e960-d3030205e255@gmx.com>
Date:   Fri, 3 Mar 2023 07:30:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/10] btrfs: simplify finding the inode in submit_one_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9ekR2U1KDvXm8WK4yRrzPtaBkWKsD1B0PeL9mPRuxZXcPuG6xZH
 PWjcYpJj71vhzmhmF+uCoXqhKprNhgWZsYspZkoDRd+APDO28Knrbzepur+lqaCdisy1sPz
 Kz/Ba/MIroTvM73edbnAfLdo+bDO0/xMjDBOtv5YU/BguYePhtkEBpBgOS/W3Uim7luXzzZ
 4Cu067XDmFufYTSq7AjIA==
UI-OutboundReport: notjunk:1;M01:P0:DV3/rKbMcpo=;QNsGm/3vtCAL1OFK7ZWt4vXeDJb
 nARIxIGo8judgCVJHtIqxyLid7GwwW5r6u/PRgfBJhMwaf2+Mb9MkIaJul3sQG8su0CwXUyS8
 lBbLXyP5IS52lm3ct8+W7ojjrik6AyjS8Hl9cW13qa9d0hjrzkambXeqSYchkZFLl6hKmaRjM
 jX5XdCm3NtctHAMue/c3DvKrhvFx5nIZHRLjXNNqVSDtKMf6aQHp3KZ7vzA2kn7OejNN8xgdG
 2NAh2oiKx91+uIdJHnpVp6uJnHlvAMyIVpiAEGYQw0DcfIo3MfZA8OvnVJ6VyT8byGXuLtUHB
 tYialqj0cJsM7GiVst4JLslnT3OAyf3GK0rsalXnm1AW+Po2KVFA9q2HxUFFpZNv61kVKrEIK
 CbvSLULO2/JZn7BPGN/a2VFJQ2z3rPVAgGKdxnHzz0tC+jQ+tXq73Pd26Rcl0USvIOoePogC+
 bgoWcMBR82Pj2+TygRUjP1ZHjfDdAmTchGNbFVNdiGJxWWmNtK2TcopF2Xh4zAnN3B1tq1I5K
 3co5S6NI/sAcOgnMPk7n/GzS417I9Do6/osfdYU7jLKKw9D/mKjkilnCVRfPD0r2hJgZvpTDv
 s6TuRPuDHVc8dh2YyCWF7ECB3+2/cTcaqUbWFbOEgqf5/r1GOXK1UfW9AVt2518oYnACJ6PrK
 xY+gNsk5zsmAOyTK56whSINB6BAFJ5NE5MrwCVOmZDBglg2sMwhX4+zkUfJH0RSuufJ9yDBVt
 XhMpnti1VckvMSJz97hqSwGIr9sv3OsYTxLT4C7nRbtPCy0LahwSmM75CT+KukIJy8bbVQFgA
 2sCaqt5LbpkwrxKKJiNftL/3jZBe7yglmgDsLv2208KOrijrjFUo/LuSdAzTCzxq7MbVlJWRa
 g0Sb08BzjJUW1UShpPaCDI9L3TQ9cJ0yt9HLtUgl3k0siRYBy5n35aoTPkiXVynXwIuBzulZ+
 aEPaV/3R9wavuRLacgxhleXSOxI=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> struct btrfs_bio now has an always valid inode pointer that can be used
> to find the inode in submit_one_bio, so use that and initialize all
> variables for which it is possible at declaration time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Initially I want to recommend to also make bio_ctrl->bio to be 
btrfs_bio, but that would be done in the next patch already.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6ea6f2c057ac3e..05b96a77fba104 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -123,23 +123,16 @@ struct btrfs_bio_ctrl {
>   
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
> -	struct bio *bio;
> -	struct bio_vec *bv;
> -	struct inode *inode;
> -	int mirror_num;
> +	struct bio *bio = bio_ctrl->bio;
> +	int mirror_num = bio_ctrl->mirror_num;
>   
> -	if (!bio_ctrl->bio)
> +	if (!bio)
>   		return;
>   
> -	bio = bio_ctrl->bio;
> -	bv = bio_first_bvec_all(bio);
> -	inode = bv->bv_page->mapping->host;
> -	mirror_num = bio_ctrl->mirror_num;
> -
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
>   
> -	if (!is_data_inode(inode)) {
> +	if (!is_data_inode(&btrfs_bio(bio)->inode->vfs_inode)) {
>   		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
>   			/*
>   			 * For metadata read, we should have the parent_check,
