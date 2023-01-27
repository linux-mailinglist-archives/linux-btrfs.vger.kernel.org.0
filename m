Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6467DAAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjA0AVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 19:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjA0AVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 19:21:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288D65AD
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674778830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU69JRvJMCkqKVDkC+A6LiHt+DPJENzucWZepo2NoXY=;
        b=OWu35ePMOQmJrwy7qXhjbmtZDT13j8diQlKkUgFxXAzkS055K6Sm7k0M5znkKLWDfbWMla
        8Y3rx3nBXdP6L7+iBJqm3X5FnRwCrfHc8sHK2AR28XfqjoEXD/rQfe1ZecJILP4cz9q8gQ
        BRAl+l5dxEMLa+xmq9E7dfCBBYGb9O0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-ak2sVfZHN7GyERjEH34m9Q-1; Thu, 26 Jan 2023 19:20:26 -0500
X-MC-Unique: ak2sVfZHN7GyERjEH34m9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E2E81991C42;
        Fri, 27 Jan 2023 00:20:26 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B69F8C15BA0;
        Fri, 27 Jan 2023 00:20:25 +0000 (UTC)
Message-ID: <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
Date:   Thu, 26 Jan 2023 19:20:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 1/26/23 17:42, Mikhail Gavrilov wrote:
>> I'm not sure whether these options are better than just increasing the
>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
>> you have large enough memory to test.
> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> be done? In vanilla kernel on kernel.org? In a specific distribution?
> or the user must rebuild the kernel himself? Maybe increase
> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> to distribute to end users because the meaning of using packaged
> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> config and rebuild the kernel by yourself).

Note that lockdep is typically only enabled in a debug kernel shipped by 
a distro because of the high performance overhead. The non-debug kernel 
doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough 
when testing on the debug kernel, you can file a ticket to the distro 
asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build 
your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.

Cheers,
Longman

