Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE250571C49
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiGLOWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiGLOWM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 10:22:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AEC7D
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 07:22:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94F6E20212;
        Tue, 12 Jul 2022 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657635729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzgLHCmHxhCKhnS1udpjdgg85qg28AUm6csRd8wUkcw=;
        b=IWurbvTCL/dHk30pgHJ9EcIzDHn4ebWa1FTsTkHxomK0ETu/kEv14ATaKk4yVbbD4oAXRC
        yFFZ4jkxsAtBQ0VVEWCIuPSO4jJpoHjzA1mk+r7WdTepRUxSVwCrfcxvTKkWRRgig+DJWj
        NrPW2mBqUnVmOEzWxnoUWZwQxe5vgKM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C84213638;
        Tue, 12 Jul 2022 14:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xcYlEJGDzWI2XQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 14:22:09 +0000
Message-ID: <7910d98e-a22d-4b06-42c1-1c0876a6a80d@suse.com>
Date:   Tue, 12 Jul 2022 17:22:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: btrfs I/O completion cleanup and single device I/O optimizations
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220704084406.106929-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
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



On 4.07.22 г. 11:43 ч., Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the btrfs_bio API, most prominently by splitting
> the end_io handler for the highlevel bio from the low-level bio
> bi_end_io, which are really confusingly coupled in the current code.
> Once that is done it then optimizes the bio submission to not allocate
> a btrfs_io_context for I/Os tht just go to a single device.
> 
> This series sits on top of the "fix read repair on compressed extents v2"
> series submitted.  To make everyones life easier a git tree is also
> available:
> 
>      git://git.infradead.org/users/hch/misc.git btrfs-bio-api-cleanup
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-api-cleanup
> 
> Diffstat:
>   compression.c    |   50 +++-----
>   disk-io.c        |   16 +-
>   extent-io-tree.h |    4
>   extent_io.c      |  117 +++----------------
>   extent_io.h      |    3
>   inode.c          |   57 ++++-----
>   raid56.c         |   45 +------
>   raid56.h         |    4
>   scrub.c          |    7 -
>   super.c          |    6 -
>   volumes.c        |  330 ++++++++++++++++++++++++++++++++++++++-----------------
>   volumes.h        |   19 ++-
>   12 files changed, 343 insertions(+), 315 deletions(-)


Tested-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
