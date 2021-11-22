Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84789458CD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 11:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhKVLAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 06:00:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44910 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhKVLA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 06:00:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1ADB6218EF;
        Mon, 22 Nov 2021 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637578639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRj5G/aRygb9cwCcVx3mXZTiMPw/wgsHiu6zFFeZJiU=;
        b=kLPcFX3T8GRhc++RcMArXpzHkhkXxFyTd0pTNL9xHY2ttr2/qVzra+oesr+URnWIIjQztH
        HDE1GaSTSoVdXSGpwQLK3zFfEptWDixrE/2mPPaty8u5UDbvToH1x9sGl4JKCD2dwIu1Fh
        Sac/2qg7ZYytumtmKZYWYrXgsDjBXFU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D52A613C56;
        Mon, 22 Nov 2021 10:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VsCNMY53m2HeBgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 10:57:18 +0000
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that permission
 denied
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
 <20211122083240.GB8836@realwakka>
 <a28e62b7-f1ee-858f-990b-678ab21312d9@suse.com>
 <a5cd8f64-066e-8791-5de8-a2263d50f597@cobb.uk.net>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0a7ce0b1-300c-233b-d844-012dfc771efe@suse.com>
Date:   Mon, 22 Nov 2021 12:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a5cd8f64-066e-8791-5de8-a2263d50f597@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.11.21 г. 11:53, Graham Cobb wrote:
> 
> On 22/11/2021 09:32, Nikolay Borisov wrote:
>>
>>
>> On 22.11.21 г. 10:32, Sidong Yang wrote:
>>> On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 21.11.21 г. 17:15, Sidong Yang wrote:
>>>>> This patch handles issue #421. Filesystem du command fails and exit
>>>>> when it access file that has permission denied. But it can continue the
>>>>> command except the files. This patch recovers ret value when permission
>>>>> denied.
>>>>>
>>>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>>>
>>>>
>>>> The code itself is fine so :
>>>>
>>>>
>>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>>>
>>>>
>>>> OTOH when I looked at the code rather than just the patch I can't help
>>>> but wonder shouldn't we actually structure this the way you initially
>>>> proposed but also add a debug output along the lines of "skipping
>>>> file/dir XXXX due to permission denied", otherwise users might not be
>>>> able to account for some space and they can possibly wonder that
>>>> something is wrong with btrfs fi du command.
>>>
>>> You mean that it would be better that print some debug message than
>>> skipping silently. I agree. So I would add this code in condition.
>>>
>>> fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);
>>>
>>> I think it's okay that it prints when ENOTTY occurs. Is this code what
>>> you meant?
>>
>>
>> I meant to print only if we have EACCESS, but now that I think about it,
>> printing something when we have a non-fatal error and simply skipping
>> some dirs/files makes sense. OTOH printing it by default might be too
>> verbose so perhaps usuing a pr_verbose call would be more appropriate.
>>
>> This is one of those things which don't have a clear-cut answers so it's
>> useful to get as many perspective as possible to arrive at some workable
>> solution to a wider number of people.
> 
> I must admit I just assumed it worked the same way as /bin/du. I have
> just created an inaccessible directory and got:
> 
> $ du -sh ~
> du: cannot read directory '/home/cobb/permtest': Permission denied
> 61G	/home/cobb
> 
> And when the directory was accessible but the file in it was not, I got:
> 
> $ du -sh ~
> du: cannot access '/home/cobb/permtest/file': Permission denied
> 61G	/home/cobb
> 
> In other words, I think any error should be printed but the error is
> then skipped and the du continues. No need to tell people the file is
> being skipped - that is obvious. But the error must be printed by
> default (if there are really cases where the error should not be printed
> but reasons not to redirect stderr to /dev/null then add an option to
> suppress printing it).
> 
> Just my opinion.


That actually works for me, I'd rather btrfs be as consistent as
possible and not give surprises to users. So just mimicking what an
omnipresent tool does is as good as it gets :)


> 
> Graham
> 
