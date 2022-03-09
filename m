Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8564D2F52
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiCIMrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 07:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCIMrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 07:47:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA6F17129D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 04:46:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 600BC21115;
        Wed,  9 Mar 2022 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646829966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+64EyL7qbmxsEG9svAgx7SMwIQP4kDstpqdA/zIcAtA=;
        b=Rrst8C829W0U+85GmfS1nvXAL+PX5+dihmAWGJnQa+HGudaIBDBEa2DDQb5z4I8lyeI7Su
        WjBfuhMMuScqv6d4RLZyB3kYDW73XuE++OwiLIQU9A3csT/yi4xOiP2Z4IArqDgmUxPDuQ
        2kfwHZBuqi69vlW10OPHtLwxowXvzPE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDB313D79;
        Wed,  9 Mar 2022 12:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cUnDA46hKGJdDQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 12:46:06 +0000
Message-ID: <9247d881-3fed-6871-1852-6f635425913e@suse.com>
Date:   Wed, 9 Mar 2022 14:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/13] btrfs-progs: cleanup btrfs_item* accessors
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
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



On 23.02.22 г. 0:26 ч., Josef Bacik wrote:
> Hello,
> 
> This is prep work for me adjusting the size of the btrfs_header.  This is a
> mirror of the work that was already merged into the kernel.  The only extra work
> that I've done here is add some compiler switches that I used to help me catch
> all the different users of the helpers to make sure I didn't make any mistakes.
> Thanks,
> 
> Josef
> 
> Josef Bacik (13):
>    btrfs-progs: turn on more compiler warnings and use -Wall
>    btrfs-progs: store LEAF_DATA_SIZE in the mkfs_config
>    btrfs-progs: store BTRFS_LEAF_DATA_SIZE in the fs_info
>    btrfs-progs: convert: use cfg->leaf_data_size
>    btrfs-progs: reduce usage of __BTRFS_LEAF_DATA_SIZE
>    btrfs-progs: btrfs_item_size_nr/btrfs_item_offset_nr everywhere
>    btrfs-progs: add btrfs_set_item_*_nr() helpers
>    btrfs-progs: change btrfs_file_extent_inline_item_len to take a slot
>    btrfs-progs: rename btrfs_item_end_nr to btrfs_item_end
>    btrfs-progs: remove the _nr from the item helpers
>    btrfs-progs: replace btrfs_item_nr_offset(0)
>    btrfs-progs: rework the btrfs_node accessors to match the item
>      accessors
>    btrfs-progs: make all of the item/key_ptr offset helpers take an eb
> 
>   Makefile                    |   3 +
>   btrfs-corrupt-block.c       |  17 ++-
>   check/main.c                |  90 +++++++--------
>   check/mode-common.c         |  12 +-
>   check/mode-lowmem.c         |  37 +++---
>   check/qgroup-verify.c       |   2 +-
>   cmds/inspect-tree-stats.c   |   3 +-
>   cmds/rescue-chunk-recover.c |   4 +-
>   cmds/restore.c              |   7 +-
>   convert/common.c            |  33 +++---
>   convert/main.c              |   1 +
>   image/main.c                |  31 +++--
>   image/sanitize.c            |   4 +-
>   kernel-shared/backref.c     |  10 +-
>   kernel-shared/ctree.c       | 219 ++++++++++++++++--------------------
>   kernel-shared/ctree.h       | 110 ++++++++----------
>   kernel-shared/dir-item.c    |  10 +-
>   kernel-shared/disk-io.c     |   1 +
>   kernel-shared/extent-tree.c |  12 +-
>   kernel-shared/file-item.c   |  12 +-
>   kernel-shared/inode-item.c  |  14 +--
>   kernel-shared/print-tree.c  |  29 +++--
>   kernel-shared/root-tree.c   |   2 +-
>   kernel-shared/uuid-tree.c   |   4 +-
>   kernel-shared/volumes.c     |  10 +-
>   mkfs/common.c               |  52 ++++-----
>   mkfs/common.h               |   1 +
>   mkfs/main.c                 |   1 +
>   28 files changed, 333 insertions(+), 398 deletions(-)
> 

For the whole series :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
