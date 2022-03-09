Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823B4D30A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiCIN6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCIN6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:58:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C270717DB94
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:57:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DE831F380;
        Wed,  9 Mar 2022 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646834248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mr40WyARyl2Fnu4XopSJoXX0v02z+BQpF8/JODCvn90=;
        b=mEk7GJ9eUuov7vMu2wo3viUWnrphvmjwA1+oz27isvgwBdrwSOO8bKHcA9bw5SBV2vSKWz
        wWY2Adu+WCZQ7HeMus+asvfmTGiTkwAEka2tNAXy9sEwBUWFmfR+HN/Yd40H9eTtd1lGMr
        b/1ptX4XFvU6aO+J/wiNc/XNXXZ5+iQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B20C13D7A;
        Wed,  9 Mar 2022 13:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pSrMCkiyKGLqMAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 13:57:28 +0000
Message-ID: <ebaefb10-2d76-85fe-1c7b-75f885baf5b7@suse.com>
Date:   Wed, 9 Mar 2022 15:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/12] btrfs: item helper prep work for snapshot_id
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
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



On 8.03.22 г. 0:33 ч., Josef Bacik wrote:
> Hello,
> 
> I sent a bunch of patches previously to rework a lot of our helpers in
> preparation of adding the snapshot_id to the btrfs_header.  I missed a few
> important areas with those patches, so here's the remaining work to make it
> easier to expand the size of the btrfs_header.  These are general fixups and
> cleanups that don't rely on the extent tree v2 work.  Thanks,
> 
> Josef
> 
> Josef Bacik (12):
>    btrfs: move btrfs_node_key into ctree.h
>    btrfs: add a btrfs_node_key_ptr helper, convert the users
>    btrfs: introduce *_leaf_data helpers
>    btrfs: make BTRFS_LEAF_DATA_OFFSET take an eb arg
>    btrfs: pass eb to the node_key_ptr helpers
>    btrfs: pass eb to the item_nr_offset helper
>    btrfs: add snapshot_id to the btrfs_header and related defs
>    btrfs: move the header SETGET funcs
>    btrfs: move the super SETGET funcs
>    btrfs: move BTRFS_LEAF related definitions below super SETGET funcs
>    btrfs: const-ify fs_info for the compat flag handlers
>    btrfs: use _offset helpers instead of offsetof in generic_bin_search
> 
>   fs/btrfs/ctree.c                | 151 ++++++------
>   fs/btrfs/ctree.h                | 411 +++++++++++++++++---------------
>   fs/btrfs/extent_io.c            |   6 +-
>   fs/btrfs/struct-funcs.c         |   8 -
>   fs/btrfs/tree-checker.c         |   4 +-
>   fs/btrfs/tree-mod-log.c         |   4 +-
>   include/uapi/linux/btrfs_tree.h |   1 +
>   7 files changed, 303 insertions(+), 282 deletions(-)
> 

Overall LGTM:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
