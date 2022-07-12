Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C125718CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiGLLpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGLLpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 07:45:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF8B1CDF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 04:45:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3894C1FA40;
        Tue, 12 Jul 2022 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657626341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1S8qogZiRC80TfH0l8t4zL3x9N9mKGcMQ45SdoKZTc=;
        b=fRbOwQ6Nsb12sWz48kQ8UyAeW8a1uuOixRlta7T/z9Neb5mC4XFCPSNJ5biI7wyvc7YoF2
        kZ+nZZ97ixgFA8HdH1OhFzUH0R8Y/GnHeyaEzGgJbvNT9O4kbAGfGRJW7iKSMY/S81h/Wk
        LZtmIUI9WrfK4MYojTvBTUnZT+z8u1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02A1313638;
        Tue, 12 Jul 2022 11:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LN1DOeRezWL/EQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 11:45:40 +0000
Message-ID: <a03f8feb-b235-adeb-3981-2a21205734ea@suse.com>
Date:   Tue, 12 Jul 2022 14:45:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1657097693.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1657097693.git.fdmanana@suse.com>
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



On 6.07.22 г. 12:09 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the recent conversions of a couple radix trees to XArrays, we now
> can end up attempting to sleep while holding a spinlock. This happens
> because if xa_insert() allocates memory (using GFP_NOFS) it may need to
> sleep (more likely to happen when under memory pressure). In the old
> code this did not happen because we had radix_tree_preload() called
> before taking the spinlocks.
> 
> Filipe Manana (3):
>    btrfs: fix sleep while under a spinlock when allocating delayed inode
>    btrfs: fix sleep while under a spinlock when inserting a fs root
>    btrfs: free qgroup metadata without holding the fs roots lock
> 
>   fs/btrfs/ctree.h         |  6 +++---
>   fs/btrfs/delayed-inode.c | 24 ++++++++++++------------
>   fs/btrfs/disk-io.c       | 38 +++++++++++++++++++-------------------
>   fs/btrfs/inode.c         | 30 ++++++++++++++++--------------
>   fs/btrfs/relocation.c    | 11 +++++++----
>   fs/btrfs/transaction.c   | 14 +++++++-------
>   6 files changed, 64 insertions(+), 59 deletions(-)
> 


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
