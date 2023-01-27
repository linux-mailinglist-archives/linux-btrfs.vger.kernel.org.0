Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A467E83D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 15:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjA0O1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 09:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjA0O1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 09:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837A1D91A
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674829580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnkJIxm2QI3DDMT3TxMvWq8lIB2hYw6fZNHH6Pyl3DA=;
        b=eaoWHnlkGXTIjeHUHt2jSkAgeETMOJuLsXji/poyRdD3brhgJ6PaxS0JClabxpqNsdXgjU
        fN9okKUGZKaGzjq9GDb3XXcnI9lIwvHtu0FyzvxxeD4oK3f2xUqsy00xPfHdL+GIBPJZbS
        jB7cDZZt/W+2+JKpucziYWmM3WKFDig=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-YDKvetHhPHWP8li8TN9dVw-1; Fri, 27 Jan 2023 09:26:17 -0500
X-MC-Unique: YDKvetHhPHWP8li8TN9dVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F1EF3C1014F;
        Fri, 27 Jan 2023 14:26:16 +0000 (UTC)
Received: from [10.22.8.206] (unknown [10.22.8.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E9B492C14;
        Fri, 27 Jan 2023 14:26:16 +0000 (UTC)
Message-ID: <b112394d-7efa-c6f9-bbef-a73c501ff02c@redhat.com>
Date:   Fri, 27 Jan 2023 09:26:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     =?UTF-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= 
        <mikhail.v.gavrilov@gmail.com>, David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
 <Y9NN9CFWc40oxmzP@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9NN9CFWc40oxmzP@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/23 23:07, Boqun Feng wrote:
> On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
>>
>> On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
>>> On 1/26/23 17:42, Mikhail Gavrilov wrote:
>>>>> I'm not sure whether these options are better than just increasing the
>>>>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
>>>>> you have large enough memory to test.
>>>> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
>>>> be done? In vanilla kernel on kernel.org? In a specific distribution?
>>>> or the user must rebuild the kernel himself? Maybe increase
>>>> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
>>>> to distribute to end users because the meaning of using packaged
>>>> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
>>>> config and rebuild the kernel by yourself).
>>> Note that lockdep is typically only enabled in a debug kernel shipped by
>>> a distro because of the high performance overhead. The non-debug kernel
>>> doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough
>>> when testing on the debug kernel, you can file a ticket to the distro
>>> asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build
>>> your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
>> Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
>> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
>>
>> If 19 the recommended value I don't mind sending an MR for it. But if
>> the idea is we're going to be back here talking about bumping it to 20
>> in six months, I'd like to avoid that.
>>
> How about a boot parameter then?

A boot parameter doesn't work for a statically allocated array which is 
determined at compile time. Dynamic memory allocation isn't enabled yet 
at early boot when lockdep will be used.

Cheers,
Longman

