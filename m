Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900AA6F2396
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjD2HUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjD2HTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 03:19:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39A30D6
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 00:19:02 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MirjS-1qV1wP4BMq-00evcn; Sat, 29
 Apr 2023 09:18:30 +0200
Message-ID: <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
Date:   Sat, 29 Apr 2023 15:18:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, 'Qu Wenruo ' <wqu@suse.com>
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
In-Reply-To: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VMLUBVLDnKeKwTlo0LFb716oiEdPpJyXKlkrBM2O5xzR+NQGDwT
 KIS6UNOm5oaz5Llvpl/k+hL5GetNi0ovJ1RAtIYNnGz5dRqnrwVOCwGLAMI6f+MgmHxhNyE
 Bp+w2pWGA4GSvf+m4ARqd1weF1SUpfZBtog/DyfKNCzS/UfRq+L0/rJVxGyzUAGS1NHtXR8
 qCBlYYZyhot3qKDTctzYw==
UI-OutboundReport: notjunk:1;M01:P0:cLCkoE/VZNc=;VbQn0j/WcDmnuO0DjLkR6fyxF9g
 I8q+MTNW8qE8/h0AeqVO/q1TbFtEjwxcQlP1qHxQJdeQkCGdwwU9CLGlsqbR4i1A+r3LVA8Le
 ro4JiNk4CHmXirCCyrcMTsBbzcxk/AfZf6LPkaM1s4+2cH6S8FLhdAtxV/Y6aQ7ueHz34rG5z
 HDZNYexqA8qTSgQwZT/n0bqxMse1MBckOc9zH4NpkMf53JJwmGk+VQepeyAQdIKRU59vbTzpA
 71XgFgV66JxLwnjZ/qXhx/C35Uc2b9oS1GERSK8sQrh4wcm+9oTFcJQ7S7d517afcPahHk3I0
 oEow1wOOvsoLPGL4SikmgsfatlUZIZHkbypLzThyB0eMy1x9sWg8EGD3bUwNx02Ux5uIO0hNx
 8w1lT7lae8heNYa520z/n2Rv/XUHET1TC7TpnDOZ/Nju4Z5nWoYC0QwyJhkDlZmubkhffDypy
 Pp9T7zwcfQbvWr3g5OiFhBjxX0kZMeGzWi0+3YYzuhK/QHdattXfl0SMxh+OKEi/lIr0H5PO5
 PKfRWveHIRn7lB6F2+cBKes/1sx8AMsqwfPdvD7a0zSPjRne5bL1JnzOgf+EPvclhNEpAAs5f
 +kHy10yn7ADzWFnWg3cSIZYMBJSCMF4r0VFseU+L6ZQtnsLYLfv7hrRdTg4tmSlYtY8V4SG/c
 Yr6jgxNhvK5MKebe9FIqWOKpBxDO8SA1fZFspkQblCFkJ8BrBv3vvDnA/IjbC78UVn/sVbtaY
 D/IoAeiyDRPkk8859p6HNDMcmnazpjSpKLcdEOV3Es27jrQpy4OIDdrKVu4UldwXlOgzwEtf0
 WjZCBPQ1YV+Y4ecHmq/9sruPlT4xHZhcDtfSpT9UT9ooG6e3p1lmQYjqTO4SeAcya68GjHGHL
 ag1S9+JAPEcjPFDN2AbDx04E7q3MJdwAsZFoR+OnsVVaTmNNMhzT6MoxcvqbDNwfgXbaLixW3
 Q7M7FdR4JcekVIgYk2CtfjTlGyg=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/29 07:08, Boris Burkov wrote:
> While working on testing my quota work, I tried running all fstests
> while passing mkfs -R quota. That shook out a failure in btrfs/042.
> 
> The failure is a reservation leak detected at umount, and the cause is a
> subtle difficulty with the qgroup rsv release accounting for inode
> creation.

Mind to give an example of the leakage kernel error message?
As such message would include the type of the rsv.

> 
> The issue stems from a recent change to subvol creation:
> btrfs: don't commit transaction for every subvol create
> 
> Specifically, that test creates 10 subvols, and in the mode where we
> commit each time, the logic for dir index item reservation never decides
> that it can undo the reservation. However, if we keep joining the
> previous transaction, this logic kicks in and calls
> btrfs_block_rsv_release without specifying any of the qgroup release
> return counter stuff. As a result, adding the new subvol inode blows
> away the state needed for the later explicit call to
> btrfs_subvolume_release_metadata.

Is there any reproducer for it?

By the description it should be pretty simple as long as we create 
multiple subvolumes in one transaction.

I'd like to have some qgroup related trace enabled to show the problem 
more explicitly, as I'm not that familiar with the delayed inode code.

Thanks,
Qu
> 
> I suspect this fix is incorrect and will break something to do with
> normal inode creation, but it's an interesting starting point and I
> would appreciate any suggestions or help with how to really fix it,
> without reverting the subvol commit patch. Worst case, I suppose we can
> commit every time if quotas are enabled.
> 
> The issue should reproduce on misc-next on btrfs/042 with
> MKFS_OPTIONS="-K -R quota"
> in the config file.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/delayed-inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6b457b010cbc..82b2e86f9bd9 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>   		delayed_node->index_item_leaves++;
>   	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
>   		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
> +		u64 qgroup_to_release;
>   
>   		/*
>   		 * Adding the new dir index item does not require touching another
> @@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>   		 */
>   		trace_btrfs_space_reservation(fs_info, "transaction",
>   					      trans->transid, bytes, 0);
> -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> +		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
> +		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
>   		ASSERT(trans->bytes_reserved >= bytes);
>   		trans->bytes_reserved -= bytes;
>   	}
