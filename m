Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBF5703C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGKNEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKNEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 09:04:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E032A947
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 06:04:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35EB21FE21;
        Mon, 11 Jul 2022 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657544642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHCR85Z1SP5ZB2qu99hH2A4Tb+q41PyBzHkR3eY/g4o=;
        b=hIuIQiuF50zzfv3EwIUkVijl3hTAF4zazaFBn+tQ8WohYxRTvpcZZt/Dy74EWPJti7rRp/
        rzY9+yyt9v4RQkxbIoTQkLFJT6mtnP3y/aacAu9MbH0J/o/CPC68YjkyKYhuP3figjISvB
        WBrZ19B9WJ1fxYaRZtX8Gp8gI2ZPA2c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F39E013B24;
        Mon, 11 Jul 2022 13:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UfKyOMEfzGJkIwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Jul 2022 13:04:01 +0000
Message-ID: <698582cc-00b2-7cca-f5a2-e8e238de053c@suse.com>
Date:   Mon, 11 Jul 2022 16:04:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220708200829.3682503-2-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.07.22 г. 23:08 ч., Ioannis Angelakopoulos wrote:
> Annotate the num_writers wait event in fs/btrfs/transaction.c with lockdep
> in order to catch deadlocks involving this wait event.
> 
> Use a read/write lockdep map for the annotation. A thread starting/joining
> the transaction acquires the map as a reader when it increments
> cur_trans->num_writers and it acquires the map as a writer before it
> blocks on the wait event.
> 
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>   fs/btrfs/ctree.h       | 14 ++++++++++++++
>   fs/btrfs/disk-io.c     |  6 ++++++
>   fs/btrfs/transaction.c | 39 +++++++++++++++++++++++++++++++++++----
>   3 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aab..160c22391cb5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1091,6 +1091,8 @@ struct btrfs_fs_info {
>   	/* Updates are not protected by any lock */
>   	struct btrfs_commit_stats commit_stats;
>   
> +	struct lockdep_map btrfs_trans_num_writers_map;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> @@ -1172,6 +1174,18 @@ enum {
>   	BTRFS_ROOT_UNFINISHED_DROP,
>   };
>   
> +#define btrfs_might_wait_for_event(b, lock) \
> +	do { \
> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
> +		rwsem_release(&b->lock##_map, _THIS_IP_); \
> +	} while (0)
> +
> +#define btrfs_lockdep_acquire(b, lock) \
> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
> +
> +#define btrfs_lockdep_release(b, lock) \
> +	rwsem_release(&b->lock##_map, _THIS_IP_)
> +
>   static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>   {
>   	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 76835394a61b..4061886024de 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3029,6 +3029,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>   
>   void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   {
> +	static struct lock_class_key btrfs_trans_num_writers_key;

Shouldn't this variable and its initialization be defined in one of 
the__init functions (i.e init_btrfs_fs() )for the btrfs' kernel module? 
As it stands this would be called on every mount of any instance of a 
btrfs filesystem?

<snip>
