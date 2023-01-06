Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76DB65FF62
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAFLN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 06:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjAFLNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 06:13:24 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710171498
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 03:13:23 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 199442407CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 12:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1673003602; bh=J9P94BxtItXW6o/Iny554YNCicCoXKIp+co+M1D+aso=;
        h=Date:Subject:To:Cc:From:From;
        b=SExmUx/kJyWwtQ7cfipgJX639V6OBVc8pIMzkej3rGsmZXUR5TUNonBg/8Wv5xp1E
         p4e8jkQSaJPUWI5biDwpkQ/Z5NUeIENvyPyLeiUUskW3D9fqZsUfK6meLAfzel/Abs
         2NGlIW8Xp9Zi8wyt31oq+S7Ri2KUio9rWt2wr7bzjyd9r9sggPLBZmVLuzyG3d+6/C
         LS9w74O5ncU49H9NWiu/7Y7bCSj0tnAYY5XbYHDnkqkIT9EAqSre0bK0Cn6+vzyUUd
         MtJcOhKFrO0SsKWAilqaGqJOJzPOPLHjbj4I7pgaAzF+wgZw7bMJHnL6i+OModXdTy
         Uq24h6VY1b4aQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NpLL92y9bz6tmH;
        Fri,  6 Jan 2023 12:13:21 +0100 (CET)
Message-ID: <d2f2cc90-a84a-1054-7be9-1bf4fc77c42c@posteo.de>
Date:   Fri,  6 Jan 2023 11:13:21 +0000
MIME-Version: 1.0
Subject: Re: btrfs send and receive showing errors
Content-Language: de-DE
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
 <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
 <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
 <CAL3q7H4+A1mW5+hrVj-OZT8bGnaOQWCzwWJESquS0-aEu7teKg@mail.gmail.com>
 <58eef5ef-b066-b2cd-e465-6bab43c1c748@posteo.de>
 <82ee24b6-fa58-b03e-7765-b157556a2b37@gmail.com>
 <cba9edbc-bde4-00e4-0f73-5063f5aef11d@posteo.de>
 <76b72107-71c0-bbe7-c20e-2b26dba24abe@gmail.com>
 <13c659bb-9238-4e06-6e3f-27f9c52774e3@posteo.de>
 <63e8183f-dffb-3ac9-e791-f59e85d2f093@posteo.de>
 <1539bde6-0b5d-6d15-848b-75493a6ebe06@gmail.com>
 <0fd1ae43-6605-cee0-4859-53b9226eb865@gmail.com>
From:   =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>
In-Reply-To: <0fd1ae43-6605-cee0-4859-53b9226eb865@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 19:04, Andrei Borzenkov wrote:
> On 05.01.2023 20:48, Andrei Borzenkov wrote:
>> On 05.01.2023 19:47, Randy Nürnberger wrote:
>>> On Thu, Jan 5, 2023 at 17:35, Randy Nürnberger wrote:
>>>> On Thu, Jan 5, 2023 at 17:01, Andrei Borzenkov wrote:
>>>>> On 05.01.2023 18:55, Randy Nürnberger wrote:
>>>>>>
>>>>>> I’ve attached the output of ‘btrfs subvolume list’ for the source 
>>>>>> and
>>>>>> the target filesystem.
>>>>>>
>>>>>
>>>>> You have a lot of source subvolumes with the same received_uuid and
>>>>> you have at least two destination subvolumes with the same
>>>>> received_uuid. This is wrong, received_uuid is supposed to be unique
>>>>> identification which explains your errors (incorrect subvolume is
>>>>> selected).
>>>>
>>>> I guess many of my source subvolumes have the same received_uuid,
>>>> because I created new snapshots from a snapshot that was previously
>>>> received and the received_uuid just did get copied.
>>>>
>>>> I just did a small experiment on another system, created a snapshot
>>>> from a snapshot that previously was received and could confirm that
>>>> the received_uuid does indeed get copied. Is this a problem?
>>>
>>
>> No, it is not a problem by itself. Subvolumes used for send/receive are
>> supposed to be a remain read-only, so any clone of any subvolume should
>> have identical content and you can use any of the clones with the same
>> received_uuid. But as soon as you made subvolume read-write, you got
>> multiple subvolumes with different content and the same receive_uuid.
>> "Doctor, it hurts when I stab myself in the eye".
>>
>> Never, NEVER, ever, change  subvolume involved in send/receive to
>> read-write to use it; clone it (create writable snapshot) and use clone.

I mistakenly thought that creating a new writable snapshot and making a 
read-only snapshot writable were the same operation.

Thinking about it, I understand the difference and why it is there.

>>
>>> Ha! This seems to be the problem! I’m able to write a small script that
>>> reproduces the bug! Give me a couple minutes.
>>>
>>> If this is a bug in the kernel,
>>
>> It is not so much a bug as the consequence of unfortunate design.
>>
>>> may I write the patch? :D Would be my
>>> first one :)
>>
>> The problem is known for years (just search this list) and there are
>> patches to clear received_uuid on ro -> rw transition but they are still
>> not applied. Personally I would just prohibit such transition 
>> completely.
>
> Correction - it was decided to implement in btrfs utils, not in 
> kernel, so "btrfs property" will by default refuse to make read-write 
> subvolume with received_uuid. This is implemented in 5.14.2.

With this knowledge I managed to repare and successfully copy my filesystem.

I have learned a lot. Thank you both for helping me and for your time.
