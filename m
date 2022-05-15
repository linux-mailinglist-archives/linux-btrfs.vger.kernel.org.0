Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991C52790F
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiEOSPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiEOSP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 14:15:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6702AE19
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 11:15:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 486DA21EC7;
        Sun, 15 May 2022 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652638525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdbXvQcLLp+3o5q/msEzGp7NU43c39XAsjOzCdImmUQ=;
        b=CylctswPbxI/EQhsMiG+LL98dzKvCwnPaPOyH3ow8RIESiHeDB9MbHsXTrAr3z9yaomxqH
        N2tH7nPcj+4O/e4LC1vjTxqisrZwE3VmiSjrCoy5KpZuktaRu8yjv0IAnNtsjlEVWqMAms
        o6JnMuJxVAO/pw+MosQsaTH4J1zPTOM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2110A13491;
        Sun, 15 May 2022 18:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YoB8BT1DgWJfagAAMHmgww
        (envelope-from <nborisov@suse.com>); Sun, 15 May 2022 18:15:25 +0000
Message-ID: <53afe0f3-6465-21cf-b7d6-babbadf48860@suse.com>
Date:   Sun, 15 May 2022 21:15:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] btrfs-progs: check/lowmem: fix path leakage when dev
 extents are invalid
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1652611957.git.wqu@suse.com>
 <4c3548e63a9e42482cbc2c277b15cf3eeae700bd.1652611958.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <4c3548e63a9e42482cbc2c277b15cf3eeae700bd.1652611958.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.05.22 г. 13:55 ч., Qu Wenruo wrote:
> [BUG]
> When testing my new RAID56J code, there is a bug causing dev extents
> overlapping.
> 
> Although both modes can detect the problem, lowmem has leaked some
> extent buffers:
> 
>    $ btrfs check --mode=lowmem /dev/test/scratch1
>    Opening filesystem to check...
>    Checking filesystem on /dev/test/scratch1
>    UUID: 65775ce9-bb9d-4f61-a210-beea52eef090
>    [1/7] checking root items
>    [2/7] checking extents
>    ERROR: dev extent devid 1 offset 1095761920 len 1073741824 overlap with previous dev extent end 1096810496
>    ERROR: dev extent devid 2 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
>    ERROR: dev extent devid 3 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
>    ERROR: errors found in extent allocation tree or chunk allocation
>    [3/7] checking free space tree
>    [4/7] checking fs roots
>    [5/7] checking only csums items (without verifying data)
>    [6/7] checking root refs done with fs roots in lowmem mode, skipping
>    [7/7] checking quota groups skipped (not enabled on this FS)
>    found 3221372928 bytes used, error(s) found
>    total csum bytes: 0
>    total tree bytes: 147456
>    total fs tree bytes: 32768
>    total extent tree bytes: 16384
>    btree space waste bytes: 136231
>    file data blocks allocated: 3221225472
>     referenced 3221225472
>    extent buffer leak: start 30752768 len 16384
>    extent buffer leak: start 30752768 len 16384
>    extent buffer leak: start 30752768 len 16384
> 
> [CAUSE]
> In the function check_dev_item(), we iterate through all the dev
> extents, but when we found overlapping extents, we exit without
> releasing the path, causing extent buffer leakage.
> 
> [FIX]
> Just release the path before we exit the function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


This can go completely independently from the raid56j code.
