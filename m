Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A350DB9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiDYIw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiDYIwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 04:52:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725EB1887
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 01:49:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 638AD1F37D;
        Mon, 25 Apr 2022 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650876560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8a1iOWGEDf9FvmzagjTrVOgGAuKdya1LxTlGesDD6c=;
        b=ckfu+zuI4iu0+KeV7p+nPBOmcq3nUEtqqVB9fiaEtfh+8wseEWl1gDAhgreyzEYJW1YYRF
        vcyRiwRP9fnDcvsEKCU1fPS9VdWQTqWuTtU/7PZiInG8cYiQoZ6vfz95H4pOoDyMO9aDvA
        MquDr+vXNS4+079fJnLtCtFFVtu9jbw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 407CC13AED;
        Mon, 25 Apr 2022 08:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OqpEDpBgZmITCAAAMHmgww
        (envelope-from <gniebler@suse.com>); Mon, 25 Apr 2022 08:49:20 +0000
Message-ID: <730c253b-e595-b898-cf2d-54aa5ade8eba@suse.com>
Date:   Mon, 25 Apr 2022 10:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 20.04.22 um 09:09 schrieb Nikolay Borisov:
> On 19.04.22 г. 18:57 ч., Gabriel Niebler wrote:
>> @@ -1870,29 +1863,33 @@ void btrfs_kill_delayed_inode_items(struct 
>> btrfs_inode *inode)
>>   void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>>   {
>> -    u64 inode_id = 0;
>> +    unsigned long index = 0;
>> +    struct btrfs_delayed_node *delayed_node;
>>       struct btrfs_delayed_node *delayed_nodes[8];
> 
> Actually in order for the new code to be correct this array needs to be 
> zero-initialized upon every iteration of the while() loop. That's 
> because as it stands ATM delayed_nodes would retain the value from the 
> previous iteration. What this could lead to is on the last iteration we 
> potentially have 8 nodes in delayed_nodes which have been freed, so if 
> in the last iteration of the xa_for_each_start we copy only 3 nodes the 
> array would still have 8 nodes in total - 3 from the  last iteration and 
> 5 stale from the previous since they haven't been cleared out. So the 
> final for() loop which does the freeing would incur a double free on the 
> 5 already-freed entries.

Oh, you're right! I must not have thought about the *last* iteration, 
but yeah: that's a problem!

> To fix this you either need to clear delayed_nodes[i] in the final for 
> loop, so simply define it inside the while() like so:
> 
> struct btrfs_delayed_node *delayed_nodes[8] = {};

I will do that. Thanks for introducing me to this neat trick how to 
initialise an array to all NULLs, BTW. I admit I had to look it up, but 
now it'll save me from writing another loop...

<snip>

I'll also use the opportunity to fix the whitespace issues.

Sorry for the delay, BTW, don't know why I didn't see the message earlier.
