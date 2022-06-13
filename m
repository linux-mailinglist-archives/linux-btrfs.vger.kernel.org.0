Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2B547FA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 08:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiFMGiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiFMGiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 02:38:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC66568
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 23:38:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69B3B1F91C;
        Mon, 13 Jun 2022 06:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655102279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1TnXQlW0xlDn03O8GjcT6L2e9WBFWomlVu5vLqhy64=;
        b=PDIb3gLkhb+7fRjgxzd759knpd9iTAa7PeFGzL+LByQv18q+1m8X5n7v2aUMnMiE4EhYwq
        ulJWbpDnk6VZ5kybeqXgX4Y21h0GAm+Qsn+ZKN6N6GWe+SkpQEZyzE3pDhyZpcviGZfHm/
        0vppqH4r2YYrWQ4X4Z9dhD+SuTccVtY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E338134CF;
        Mon, 13 Jun 2022 06:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IQyjCEfbpmLVfgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Jun 2022 06:37:59 +0000
Message-ID: <f70a8379-53a7-1450-d764-990447759f12@suse.com>
Date:   Mon, 13 Jun 2022 09:37:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <27a7a857-7845-438f-a1e7-733423385252@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <27a7a857-7845-438f-a1e7-733423385252@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.22 г. 16:30 ч., Anand Jain wrote:
> On 6/9/22 22:16, David Sterba wrote:
>> Currently the super block page is from the mapping of the block device,
>> this is result of direct conversion from the previous buffer_head to bio
> 
>> API.  We don't use the page cache or the mapping anywhere else, the page
>> is a temporary space for the associated bio.
> 
> 
> We use mapping for SB reading.
> 
> btrfs_read_dev_one_super(...)
> ::
>   page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> 
>   So isn't find_or_create_page() re-using the same page?

Good observation, the page cache is also used in 
btrfs_scratch_superblocks. IMO this change should also eliminate the 
usage of pagecache in those contexts as well. And this is actually 
critical, since the writes bypassing the pagecache means all readers of 
the sb form page cache would see stale data as the pages will never be 
set to  !uptodate

<snip>
