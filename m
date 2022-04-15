Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AA502A5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiDOMob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354260AbiDOMnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 08:43:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F86ACD317
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 05:39:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E66A31F74D;
        Fri, 15 Apr 2022 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650026350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGlpUmE6qa9Yq+w+Duv3ofHHfU5MsdoZglqDNf9mrD0=;
        b=qrh3H152X1XbKdi4roox/T4kysO1jIT5JSkdMpnYimggmArfO2ArNgs+8nqhq8qaFR4u1H
        C6qfDYHKqmV1XxnaY0uqoPqJV5sKxVZreu+sYXDIO5hTAp8nMHp8hUk3W9r+sQ3DiHE/WE
        9HVg9bF1PEOftXJ9WUW04eJYvsbKsnA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1C4B139B3;
        Fri, 15 Apr 2022 12:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7zVfJG5nWWKEUQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Apr 2022 12:39:10 +0000
Message-ID: <a8644d3a-599a-a8a6-9936-368114962f96@suse.com>
Date:   Fri, 15 Apr 2022 15:39:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] btrfs: avoid some block group rbtree lock contention
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1649862853.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.04.22 г. 18:20 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset allows for better concurrency when accessing the red black
> tree of block groups, which is used very frequently and most accesses are
> read-only, as well as avoid some unnecessary searches in the tree during
> NOCOW writes. Details in the changelogs.
> 
> Filipe Manana (5):
>    btrfs: remove search start argument from first_logical_byte()
>    btrfs: use rbtree with leftmost node cached for tracking lowest block group
>    btrfs: use a read/write lock for protecting the block groups tree
>    btrfs: return block group directly at btrfs_next_block_group()
>    btrfs: avoid double search for block group during NOCOW writes
> 
>   fs/btrfs/block-group.c      | 130 ++++++++++++++++++++----------------
>   fs/btrfs/block-group.h      |   5 +-
>   fs/btrfs/ctree.h            |   5 +-
>   fs/btrfs/disk-io.c          |   5 +-
>   fs/btrfs/extent-tree.c      |  29 ++++----
>   fs/btrfs/free-space-cache.c |   2 +-
>   fs/btrfs/free-space-tree.c  |   2 +-
>   fs/btrfs/inode.c            |  26 +++++---
>   fs/btrfs/transaction.c      |   4 +-
>   9 files changed, 114 insertions(+), 94 deletions(-)
> 


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
