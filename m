Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA86DE96B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 04:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDLCaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLCae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 22:30:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7DC1BC8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 19:30:31 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1qBt5i2UDM-00jJFc; Wed, 12
 Apr 2023 04:29:55 +0200
Message-ID: <1d0ac981-99a6-1f3b-68d0-93e64fdbf95d@gmx.com>
Date:   Wed, 12 Apr 2023 10:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IHq5dEUy4QsBZZRGjVpM5ImRA0sZ+wix1z1Ia7tk7husJxtSluv
 VT9/MEn53yOP7F7CUF/zJLdofWiirIjFCMJ18HaIs/5QMuLDQAhV1UnhWRcLSPOG4zCs0hP
 MYOFHxU5MQ6hZ6mez66uubTOv2/5kIJVzkFt6t0T6GTrxwScZ8X6QF7+DHsC4RCpvaMgQtN
 FHLE5WeDVR8APgXmVYa2w==
UI-OutboundReport: notjunk:1;M01:P0:g88e6UE4eIo=;07B7aOfcZBctiqEdZfxy0g9Rue9
 P4l4KBjn39Y8lnITi9nkhXStlxJQjuxTl3UEdNHb63pe6qPW4lN6FZzmLe6tDZBNc0QH1NpXB
 3HxrJ7AfQnecJP58Dy3X1fTS2rsmvk2J4Fu+BSIaNDaCETFj0WfXMfHZGYaJJM/+HXKqVxPl1
 toT6EMbWqkeHbonDcKYm1ESQ6oi4QMGlel/1hHSVhHDqqX9dBfnvuRZrV59kECkTB8C7X9Fnm
 2ztEurTO08QLN2XPi7oPGoC8i9sXMv7e5hpTwBrQj5KxVeVRfTzhxJ2DivqA6uxhSRXZJR/8r
 nrXBKoUZ7FJ1+g5N2s0FAtBnmyNqimgQiGqYQQNWqeOPXkKrasGnh/TFnVEL6LdoVEXmkKiBU
 8IWUbdWDoJl7eQzluDnnP6jen1ZM2DdX+bxLHapyg2L//vlikh7ah7KRd+DYKDWVGjNxSOJnD
 KTIFWt/JVeSrvSG78mR0cctTiR1ANHairInTG+IOJe2jYzBkDxNlmNr/IKoTTmzyTpV3DfHrt
 cQQQc6skEaltzlCJrYDBEmSwd7KKsGgFz5K3LPhg9Xbwn9XEZBlxgZtAMLXpZzEP59gl6FGxj
 cY4rzZ1qbairDZ6nNThvXEE5wY5H2v8CvGN5lhqsJEG8Nz6syblR4wYzxXFZa38rzJezajtcy
 HXh6ddP/CaXH7Qzx/sl+PdbAdtjpow5w2fpBfQ3oDYiQvN40jKn/c+0sr4ZUCp9PpYdv0meN6
 xVTlyn4Z+bhD/2wkd9YGUAkPGBdo6Otd+eoqFP3ldWggKnTxKgyAifndc3617WtDf+uP0dPg6
 nudhj8hByI7nZwB/rv53pbNoKyViEsPGJ7JFam0zGLIEjDePpUP1nsuXLdFd9IlE7GWxSN+iN
 AE86mWb3ErbjzOd6/DhouAcDWWndWETA8xBOG13n96pMleZvl2NHHYGNM7w/ab6/EgSYK/uqB
 YZVHJVL1FH6sGXJXy031jimRLrA=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/12 03:10, Sweet Tea Dorminy wrote:
> Recently a Meta-internal workload encountered subvolume creation taking
> up to 2s each, significantly slower than directory creation. As they
> were hoping to be able to use subvolumes instead of directories, and
> were looking to create hundreds, this was a significant issue. After
> Josef investigated, it turned out to be due to the transaction commit
> currently performed at the end of subvolume creation.
> 
> This change improves the workload by not doing transaction commit for every
> subvolume creation, and merely requiring a transaction commit on fsync.
> In the worst case, of doing a subvolume create and fsync in a loop, this
> should require an equal amount of time to the current scheme; and in the
> best case, the internal workload creating hundreds of subvols before
> fsyncing is greatly improved.
> 
> While it would be nice to be able to use the log tree and use the normal
> fsync path, logtree replay can't deal with new subvolume inodes
> presently.
> 
> It's possible that there's some reason that the transaction commit is
> necessary for correctness during subvolume creation; however,
> git logs indicate that the commit dates back to the beginning of
> subvolume creation, and there are no notes on why it would be necessary.

For subvolume creation it looks fine.

My main concern related to this topic is mostly around snapshots:

- Snapshots can only be created during commit transaction
- Snapshots qgroup accounting
   For now we only support quick path (aka, inherit the old numbers from
   the source, and that's no other qgroup level involved).

But for subvolume creation, those are not involved at all.

So the idea of skipping transaction commit looks solid to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>   fs/btrfs/ioctl.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 25833b4eeaf5..a6f1ee2dc1b9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -647,6 +647,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   	}
>   	trans->block_rsv = &block_rsv;
>   	trans->bytes_reserved = block_rsv.size;
> +	/* tree log can't currently deal with an inode which is a new root */
> +	btrfs_set_log_full_commit(trans);
>   
>   	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
>   	if (ret)
> @@ -755,10 +757,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   	trans->bytes_reserved = 0;
>   	btrfs_subvolume_release_metadata(root, &block_rsv);
>   
> -	if (ret)
> -		btrfs_end_transaction(trans);
> -	else
> -		ret = btrfs_commit_transaction(trans);
> +	btrfs_end_transaction(trans);
>   out_new_inode_args:
>   	btrfs_new_inode_args_destroy(&new_inode_args);
>   out_inode:
