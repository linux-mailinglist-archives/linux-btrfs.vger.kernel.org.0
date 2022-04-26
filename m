Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23C50F94B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbiDZKAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbiDZJ7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 05:59:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCA434B8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 02:18:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5577210E8;
        Tue, 26 Apr 2022 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650964696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2KMZvut3Ec2mEJS4RzYIsRdgT19u+ZZz4b9CmWbFfY=;
        b=XEajHTXkDsNldg4IXHKqcUlwOviQl0p7t/9JZtRNmcCReQY5rQXQ1ga49fompRp6RP9SRT
        SykMPTxu9egC5GUxVEncK24aqfBwNxiM8C8BQWEfzXMsmaa/Z8hyKDE0YJE+8tcScaWHKT
        4yGiPM5Us4jjgr0VXM5NDO/wIEmIqEI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3B8A13223;
        Tue, 26 Apr 2022 09:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEwrLti4Z2JRMQAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 26 Apr 2022 09:18:16 +0000
Message-ID: <690614f8-2cec-907e-7a19-41f9d0d6e83e@suse.com>
Date:   Tue, 26 Apr 2022 11:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
 <70c5e257-55d7-ff0a-8b6b-1051734aa1d5@suse.com>
 <c1cfd599-b730-c96a-c4f3-06de77c2c1bf@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <c1cfd599-b730-c96a-c4f3-06de77c2c1bf@suse.com>
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

Am 26.04.22 um 09:40 schrieb Nikolay Borisov:
> [...]
> You are right, the code as-is is correct. I have 2 more suggestions but 
> at this point they can be considered "bike shed" so you might as well 
> disregard them in which case it's only the whitespace issue that remains 
> and David could probably fix this. Here are the suggestions:
> 
> 1. The 'n' variable could be defined inside the while() loop:
> 
> int n = 0;
> 
> That makes it obvious its lifetime is within the loop and it's always 
> initialized to 0.
> 
> 2. The kernel now moved to using -std=gnu11 (starting with e8c07082a810 
> ("Kbuild: move to -std=gnu11"))  meaning variables can now be defined 
> inside for() loop bodies like:
> 
> for (int i = 0; i < n; i++)
> 
> IMO it would be good if we gradually start moving code to using this.

I like both of these suggestions and will implement them.

> Again I consider those 2 minor and the patch as-is is good to go so it's 
> up to David to decide if they are worth it.

David has already asked me to resubmit with the whitespace fixes in 
place, so I will just do that with your suggestions added in.

> Thanks for sticking with it.

My pleasure.
