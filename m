Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67911406A5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhIJKvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 06:51:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhIJKvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 06:51:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91E6320056;
        Fri, 10 Sep 2021 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631271028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAi86FRg72FJL29PTwuDJrwUhm4FUOID18ym9QdFvTE=;
        b=G2vMsUH8fkAGJCvfln8wCRRczibdRnR1VdAoCM+LM0LfNmTrHZRWCb38NWe5axqwk5wJid
        iX5uNRIeuxhK19rjHG7fnar0o7GMeRvd5DrwqEbtvDxF1STj6hn7mYgbuz7UMKlYRUKml/
        SzaOsQUbdsH/R4LW3NCqtyuesPDK40k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55E3D13D27;
        Fri, 10 Sep 2021 10:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MK5/EnQ4O2FOHgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 10:50:28 +0000
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
 <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
 <20210910094510.GB15306@twin.jikos.cz>
 <7485b65e-84d0-31dd-3891-16363c8ea790@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7b412d8b-0206-e72e-d544-89d7acfbdeb7@suse.com>
Date:   Fri, 10 Sep 2021 13:50:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7485b65e-84d0-31dd-3891-16363c8ea790@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.21 г. 12:59, Qu Wenruo wrote:
> 
> 
> On 2021/9/10 下午5:45, David Sterba wrote:
>> On Fri, Sep 10, 2021 at 09:33:41AM +0300, Nikolay Borisov wrote:
>>>
>>>
>>> On 10.09.21 г. 9:03, Qu Wenruo wrote:
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>   Documentation/btrfs-property.asciidoc | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/btrfs-property.asciidoc
>>>> b/Documentation/btrfs-property.asciidoc
>>>> index 4796083378e4..8949ea22edae 100644
>>>> --- a/Documentation/btrfs-property.asciidoc
>>>> +++ b/Documentation/btrfs-property.asciidoc
>>>> @@ -42,6 +42,12 @@ the following:
>>>>
>>>>   ro::::
>>>>   read-only flag of subvolume: true or false
>>>> ++
>>>> +NOTE: For recevied subvolumes, flipping from read-only to
>>>> read-write will
>>>> +either remove the recevied UUID and prevent future incremental receive
>>>> +(on newer kernels), or cause future data corruption and recevie
>>>> failure
>>>> +(on older kernels).
>>>
>>> Hang on a minute, flipping RO->RW won't cause corruption by itself. So
>>> flipping will just break incremental sends which is completely fine.
>>
>> I'm still not decided if it's 'completely fine' to break incremental
>> send so easily.
>>
> 
> Then even we just keep the existing behavior, we still need some
> educational warning here.
> 
> In that keep-recevied-uuid case, here we just need to warn the users
> about that, later incremental receive may fail and the recevied data may
> not be correct, and call it a day (without any kernel modification).
> 
> In that case, it's all users' fault and except the corrupted data and
> receive failure, everything else should be fine.
> 
> Kernel won't crash, users get their "expected" corrupted data, and we
> won't need to bother the kernel behavior change.
> 
> But I don't think that would be any better than a sudden behavior change...

I wholeheartedly disagree. If we do a behavior change then users must
just adjust which really means they have to make 1 full send. If we keep
the current behavior we are bound to be getting reports of corrupted
data/failed receive of subvolumes. And in the end this would end up
being a huge time sink for the person who ends up investigating this...

> 
> Thanks,
> Qu
> 
