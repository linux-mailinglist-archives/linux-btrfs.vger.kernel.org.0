Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0983BC618
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGFFbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 01:31:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhGFFbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 01:31:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA4E72266A;
        Tue,  6 Jul 2021 05:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625549334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/X8HrMbaJWG7wSYNwMyW5Lr1N0trWRlCMxmQ5/l1QWw=;
        b=dq5FitwesSAwvYISQIqNuLK4QUEEX3sZZXIhO8AbOn/5dxOBHnM7VZfZBeMOjXal0XafTR
        LpKkNc15BuYUhbiHE3E0w+5O+UoaTeVu7+V95OSvPWvfB9adZMTzZ7PpGy2li2mKSMKkxW
        JkpLokRUVyacoCRZd9TMGYLlM4NJRzA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D51913480;
        Tue,  6 Jul 2021 05:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wnBdHxbq42D7TQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 06 Jul 2021 05:28:54 +0000
Subject: Re: [PATCH 2/2] btrfs: change btrfs_io_bio_init inline function to
 macro
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1625237377.git.anand.jain@oracle.com>
 <0ae479ebdecf5501937b5d93449a782d96864cce.1625237377.git.anand.jain@oracle.com>
 <05870252-7ab1-0306-7360-a6edeed2b168@suse.com>
 <a9f156a1-354b-6555-ba71-da6c92235d09@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7ba26789-f98e-adb2-a6d9-7979e519e802@suse.com>
Date:   Tue, 6 Jul 2021 08:28:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a9f156a1-354b-6555-ba71-da6c92235d09@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.07.21 г. 7:34, Anand Jain wrote:
> 
> 
> On 5/7/21 10:05 pm, Nikolay Borisov wrote:
>>
>>
>> On 4.07.21 г. 15:04, Anand Jain wrote:
>>> btrfs_io_bio_init() is a single line static inline function and
>>> initializes
>>> part of allocated struct btrfs_io_bio. Make it macro so that
>>> preprocessor
>>> handles it and preserve the original comments of the function.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 9e81d25dea70..8ed07cffb4a4 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -3110,10 +3110,7 @@ static void end_bio_extent_readpage(struct bio
>>> *bio)
>>>    * new bio by bio_alloc_bioset as it does not initialize the bytes
>>> outside of
>>>    * 'bio' because use of __GFP_ZERO is not supported.
>>>    */
>>> -static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
>>> -{
>>> -    memset(btrfs_bio, 0, offsetof(struct btrfs_io_bio, bio));
>>> -}
>>> +#define btrfs_io_bio_init(bbio)    memset(bbio, 0, offsetof(struct
>>> btrfs_io_bio, bio))
>>>     /*
>>>    * The following helpers allocate a bio. As it's backed by a
>>> bioset, it'll
>>>
>>
>>
>> What do we gain by this change? The compiler is perfectly able to inline
>> btrfs_io_bio_init.
>>
> 
> The gain is macro is guaranteed to be inline-ed. A function with the
> inline prefix isn't.
> 

In this particular case it's guaranteed that the function will be inlined.
