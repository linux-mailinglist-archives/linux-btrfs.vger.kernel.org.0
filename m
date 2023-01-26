Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD567D518
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjAZTIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjAZTIL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 14:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E531470AE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674760031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAzPuEtZNKjq1ETKDrru2udxiQbSs8Nq94l8Ylte7oc=;
        b=YZzK3eutY4l4Hs8tk92djc2MekEIqZ3c8hv7iHrX3aBG6Rvx5ZV2TLALGhouV3we5zhy45
        2akujpFTXd4wZEssnIATlnsYpdXHSkgwoJs6vFpEiX7mUxE3+hlDALm2ZmwcGJUeKR1Xco
        2lEM8ef4XGNh8VCHl5K9NSxOpO403+Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-SSu0E1y2OGuDi9AFpIeu1Q-1; Thu, 26 Jan 2023 14:07:07 -0500
X-MC-Unique: SSu0E1y2OGuDi9AFpIeu1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 564F81C05AFC;
        Thu, 26 Jan 2023 19:07:07 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14112166B26;
        Thu, 26 Jan 2023 19:07:06 +0000 (UTC)
Message-ID: <2d0483b4-f94f-8935-1a05-91417e3bfe8d@redhat.com>
Date:   Thu, 26 Jan 2023 14:07:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, dsterba@suse.cz,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
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
 <017f7b9e-323c-f9aa-12fa-9c9a16dabd35@redhat.com>
 <Y9LNoDtOK4nun968@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9LNoDtOK4nun968@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/23 13:59, Boqun Feng wrote:
> On Thu, Jan 26, 2023 at 01:30:34PM -0500, Waiman Long wrote:
>> On 1/26/23 12:38, Boqun Feng wrote:
>>> [Cc lock folks]
>>>
>>> On Thu, Jan 26, 2023 at 02:47:42PM +0500, Mikhail Gavrilov wrote:
>>>> On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
>>>>> On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
>>>>>> On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
>>>>>>> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
>>>>>>>> Hi guys.
>>>>>>>> Always with intensive writing on a btrfs volume, the message "BUG:
>>>>>>>> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>>>>>>> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
>>>>>>> tends to work.
>>>>>> Hi,
>>>>>> Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
>>>>>> low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
>>>>>>
>>>>>> ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
>>>>>> CONFIG_LOCKDEP_CHAINS_BITS=18
>>>>>>
>>>>>> [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>>>>>> [88685.088124] turning off the locking correctness validator.
>>>>>> [88685.088133] Please attach the output of /proc/lock_stat to the bug report
>>>>>> [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
>>>>>>     -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
>>>>>> [88685.088154] Hardware name: System manufacturer System Product
>>>>>> Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
>>>>>>
>>>>>> What's next? Increase this value to 19?
>>>>> Yes, though increasing the value is a workaround so you may see the
>>>>> warning again.
>>>> Is there any sense in this WARNING if we would ignore it and every
>>>> time increase the threshold value?
>>> Lockdep uses static allocated array to track lock holdings chains to
>>> avoid dynmaic memory allocation in its own code. So if you see the
>>> warning it means your test has more combination of lock holdings than
>>> the array can record. In other words, you reach the resource limitation,
>>> and in that sense it makes sense to just ignore it and increase the
>>> value: you want to give lockdep enough resource to work, right?
>>>
>>>> May Be set 99 right away? Or remove such a check condition?
>>> That requires having 2^99 * 5 * sizeof(u16) memory for lock holding
>>> chains array..
>> Note that every increment of LOCKDEP_CHAINS_BITS double the storage space.
>> With 99, that will likely exceed the total amount of memory you have in your
>> system.
>>
>> Boqun, where does the 5 figure come from. It is just a simple u16 array of
> 	#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
> 	#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
>
> 	#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
>
> I think the last one means we think the average length of a lock chain
> is 5, in other words, in average, a task hold at most 5 locks. I don't
> know where the 5 came from either, but it's there ;-)

You are right. I missed that when I looked. So 5 is assumed to the 
average length of a lock chain.

Thanks,
Longman

