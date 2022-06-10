Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E31545DAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbiFJHja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 03:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346871AbiFJHj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 03:39:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C813892E
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 00:39:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E78721EF2;
        Fri, 10 Jun 2022 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654846764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LY4p8oGup1wlKvJatAA2uCDS0svDOH1gwn91lbQGOL0=;
        b=LBYZsCF6oHTXvnitlM88st1BrBIAAOgMVWAUvDno3xFuTJREpOBdzKJXuBzRQkH4PD2XE+
        Dxar2zc7LWnq0Ur6VCGnoCwB+m11loeRrlIFrBH+dEdLhsRkqvcztGRjAPZBnATRZxt7DY
        gKoP6jvrPTRB6kWmafKY9SHRJWE2jpA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 026C513941;
        Fri, 10 Jun 2022 07:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8lNtOSv1omIvNwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Jun 2022 07:39:23 +0000
Message-ID: <237c58a0-dfc2-a99c-9559-394831de0ee4@suse.com>
Date:   Fri, 10 Jun 2022 10:39:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
 <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.06.22 г. 10:33 ч., Qu Wenruo wrote:
> 
> 
> On 2022/6/10 15:23, Nikolay Borisov wrote:
>>
>>
>> On 10.06.22 г. 3:07 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2022/6/10 00:46, David Sterba wrote:
>>>> Currently the super block page is from the mapping of the block device,
>>>> this is result of direct conversion from the previous buffer_head to 
>>>> bio
>>>> API.  We don't use the page cache or the mapping anywhere else, the 
>>>> page
>>>> is a temporary space for the associated bio.
>>>>
>>>> Allocate pages for all super block copies at device allocation time,
>>>> also to avoid any later allocation problems when writing the super
>>>> block. This simplifies the page reference tracking, but the page 
>>>> lock is
>>>> still used as waiting mechanism for the write and write error is 
>>>> tracked
>>>> in the page.
>>>>
>>>> As there is a separate page for each super block copy all can be
>>>> submitted in parallel, as before.
>>>
>>> Is there any history on why we want parallel super block submission?
>>
>> Because it's in the transaction critical path so it affects latency of
>> operations.
> 
> Not exactly.
> 
> Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
> means new transaction can already be started.

You are right, in this case then I guess we can still stay with a single 
page and synchronous writeout but this needs to be explicitly mentioned 
in the changelog.

<snip>
