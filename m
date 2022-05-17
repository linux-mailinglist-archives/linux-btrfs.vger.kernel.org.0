Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA294529AAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiEQHXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiEQHXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:23:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE06434B1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:23:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B40B1FBAE;
        Tue, 17 May 2022 07:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652772188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+X3FEU1VeWKeyed1KU/Z3G1i/pz9UDLi+z/0/oYwYz8=;
        b=i1fv5ltKC8/MLYHTKlx2IJqCJ+KNe1LOofyRJwb/23Crbdj0ySYfCJ6+dIJXiXM04E0On0
        Woa7qSTdAqbK6ztSi7j43zw580i00PmM553PL6aWrXNUxQgOEgK57Jn51QCItdWW2g6bny
        SsXeIvygl/wauEGlOgSEdCJpv4g1K+I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1021E13305;
        Tue, 17 May 2022 07:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGAkAVxNg2KFcwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 17 May 2022 07:23:08 +0000
Message-ID: <64227525-4507-9a04-942c-e081c6550f69@suse.com>
Date:   Tue, 17 May 2022 10:23:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.05.22 г. 17:31 ч., Johannes Thumshirn wrote:
> Introduce a raid-stripe-tree to record writes in a RAID environment.
> 
> In essence this adds another address translation layer between the logical
> and the physical addresses in btrfs and is designed to close two gaps. The
> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the
> second one is the inability of doing RAID with zoned block devices due to the
> constraints we have with REQ_OP_ZONE_APPEND writes.
> 
> Thsi is an RFC/PoC only which just shows how the code will look like for a
> zoned RAID1. Its sole purpose is to facilitate design reviews and is not
> intended to be merged yet. Or if merged to be used on an actual file-system.
> 
> Johannes Thumshirn (8):
>    btrfs: add raid stripe tree definitions
>    btrfs: move btrfs_io_context to volumes.h
>    btrfs: read raid-stripe-tree from disk
>    btrfs: add boilerplate code to insert raid extent
>    btrfs: add code to delete raid extent
>    btrfs: add code to read raid extent
>    btrfs: zoned: allow zoned RAID1
>    btrfs: add raid stripe tree pretty printer
> 
>   fs/btrfs/Makefile               |   2 +-
>   fs/btrfs/ctree.c                |   1 +
>   fs/btrfs/ctree.h                |  29 ++++
>   fs/btrfs/disk-io.c              |  12 ++
>   fs/btrfs/extent-tree.c          |   9 ++
>   fs/btrfs/file.c                 |   1 -
>   fs/btrfs/print-tree.c           |  21 +++
>   fs/btrfs/raid-stripe-tree.c     | 251 ++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  39 +++++
>   fs/btrfs/volumes.c              |  44 +++++-
>   fs/btrfs/volumes.h              |  93 ++++++------
>   fs/btrfs/zoned.c                |  39 +++++
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  17 +++
>   14 files changed, 509 insertions(+), 50 deletions(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
> 


So if we choose to go with raid stripe tree this means we won't need the 
raid56j code that Qu is working on ? So it's important that these two 
work streams are synced so we don't duplicate effort, right?
