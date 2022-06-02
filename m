Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7975553B61B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiFBJep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFBJen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 05:34:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE8DEEB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 02:34:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9B21F8C7;
        Thu,  2 Jun 2022 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654162480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmsXga4iF9TSzmAWjx0SbRQ6OB3JaoJnWIjvrVVwumg=;
        b=C4fpttPCMmWpZrV+mc8O6oBWMtmDQXtF8zjGEl3T3AXX84dOGJCP5E2vky52Zu5syQXgr8
        lTKSRZoxrKaseJMqhflfDBlp+1AgDNlaDxi7zaJ3EcP7vk0ValzACt7EVcCpsQv95/jChm
        DqzZXlUheezQgEmOFs1tdWSUW2opq/4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72227134F3;
        Thu,  2 Jun 2022 09:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pecMGTCEmGLgRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 02 Jun 2022 09:34:40 +0000
Message-ID: <c3fdc841-74d6-01af-aae8-c9006c2b1fd5@suse.com>
Date:   Thu, 2 Jun 2022 12:34:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 00/12] btrfs: some improvements and cleanups around
 delayed items
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.05.22 г. 18:06 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This series does some cleanups and performance improvements related to
> delayed items. These are also preparation work for some other changes
> coming in the near future.
> 
> Filipe Manana (12):
>    btrfs: balance btree dirty pages and delayed items after a rename
>    btrfs: free the path earlier when creating a new inode
>    btrfs: balance btree dirty pages and delayed items after clone and dedupe
>    btrfs: add assertions when deleting batches of delayed items
>    btrfs: deal with deletion errors when deleting delayed items
>    btrfs: refactor the delayed item deletion entry point
>    btrfs: improve batch deletion of delayed dir index items
>    btrfs: assert that delayed item is a dir index item when adding it
>    btrfs: improve batch insertion of delayed dir index items
>    btrfs: do not BUG_ON() on failure to reserve metadata for delayed item
>    btrfs: set delayed item type when initializing it
>    btrfs: reduce amount of reserved metadata for delayed item insertion
> 
>   fs/btrfs/delayed-inode.c | 341 ++++++++++++++++++++++++++-------------
>   fs/btrfs/delayed-inode.h |   7 +
>   fs/btrfs/inode.c         |  25 ++-
>   fs/btrfs/reflink.c       |   8 +-
>   4 files changed, 260 insertions(+), 121 deletions(-)
> 


FOr the whole series:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
