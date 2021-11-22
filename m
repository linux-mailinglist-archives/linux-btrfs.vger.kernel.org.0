Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE5458B9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 10:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhKVJfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 04:35:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhKVJfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 04:35:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2D58218CE;
        Mon, 22 Nov 2021 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637573559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/F1HEn+CZCLILOxUsirGHYU97lV4rkbwFYT4Uask5pI=;
        b=bFr5VSCFbEELiGrejgY9zU0Kj/QrW7ZCwHks33pTMqJxofPBdrmAKGJ0ZQcYcAl6xKRJmv
        /MX2l5FYlBY1Oyjml6JI8FKFlSVh1lDAXZMQ1EMuJv/LiHHawXuqDeaPzppqO7wxd3H3pA
        GEML/YmxkNB5KMKHFc6bty2mE+ohdeE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CE1F13C23;
        Mon, 22 Nov 2021 09:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MYhH7djm2F3VwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 09:32:39 +0000
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that permission
 denied
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
 <20211122083240.GB8836@realwakka>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
Date:   Mon, 22 Nov 2021 11:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122083240.GB8836@realwakka>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.11.21 г. 10:32, Sidong Yang wrote:
> On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
>>
>>
>> On 21.11.21 г. 17:15, Sidong Yang wrote:
>>> This patch handles issue #421. Filesystem du command fails and exit
>>> when it access file that has permission denied. But it can continue the
>>> command except the files. This patch recovers ret value when permission
>>> denied.
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>
>>
>> The code itself is fine so :
>>
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>
>>
>> OTOH when I looked at the code rather than just the patch I can't help
>> but wonder shouldn't we actually structure this the way you initially
>> proposed but also add a debug output along the lines of "skipping
>> file/dir XXXX due to permission denied", otherwise users might not be
>> able to account for some space and they can possibly wonder that
>> something is wrong with btrfs fi du command.
> 
> You mean that it would be better that print some debug message than
> skipping silently. I agree. So I would add this code in condition.
> 
> fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);
> 
> I think it's okay that it prints when ENOTTY occurs. Is this code what
> you meant?


I meant to print only if we have EACCESS, but now that I think about it,
printing something when we have a non-fatal error and simply skipping
some dirs/files makes sense. OTOH printing it by default might be too
verbose so perhaps usuing a pr_verbose call would be more appropriate.

This is one of those things which don't have a clear-cut answers so it's
useful to get as many perspective as possible to arrive at some workable
solution to a wider number of people.




>>
>>
>>> ---
>>>  cmds/filesystem-du.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
>>> index 5865335d..fb7753ca 100644
>>> --- a/cmds/filesystem-du.c
>>> +++ b/cmds/filesystem-du.c
>>> @@ -403,7 +403,7 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
>>>  						  dirfd(dirstream),
>>>  						  shared_extents, &tot, &shr,
>>>  						  0);
>>> -				if (ret == -ENOTTY) {
>>> +				if (ret == -ENOTTY || ret == -EACCES) {
>>>  					ret = 0;
>>>  					continue;
>>>  				} else if (ret) {
>>>
> 
