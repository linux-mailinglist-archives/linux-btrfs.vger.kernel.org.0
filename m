Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0298565F31A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjAERsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 12:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjAERsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 12:48:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295024C713
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 09:48:07 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x11so15024130ljh.12
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 09:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FigTqaJiYFBsgnTdsD/b8/Szh7PMt8FnjAC5VEea2O8=;
        b=XnfkfzRJfnOPF1ykG33P3C4Ag9/a4ktmI+VOosYscfHvw6Q4eOY02R48Jts6EtKeNC
         zE7rz8Dgwdr3EWtI4CuYOeiQEi3xvdZbEzpRbe7O3RKTdL8TAGZwJOYdTDjCMoDDIuzN
         iwPq7Kr+PuP7JXMvWxzrQkWO5tKSkGtCbtjHrTsfjbIlG6Wdyngt8AqHR8ktNINR4DLQ
         u7W1TieiedtcW0uccfONgjkhebMGyZO23v2sINHjRuf+qFkh2Ww0mSWKu4GE9hgN/FJ4
         y/WgoKxP0H5kzwLaNoMf2ZJXVb0Y6yGAgsAZCZdqGjICpm50ykGHXML/0Gjqo+UG1pRQ
         CVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FigTqaJiYFBsgnTdsD/b8/Szh7PMt8FnjAC5VEea2O8=;
        b=fJiBHI+nviG9ytjeAXDpyakj8YeT1qImxYpvAN+0WQPvqrnnurtw5A161o+VKB3bRc
         AYd3lluFahs3Z3PoOdSWzpJKUQsI7EAb5XhFkDs+h3s6Tm2+ruutd2CVQWi3V1pX6UwH
         PI8Spk2NLHZOknOPefkpSPXOyuz3MQ0nh7QUvN0aqHDGpsaHAELJPRHUffmMLEEuaWRb
         rvfixO9L5jyWNA+p6422VMKG+nbVSlQc2uuSF0zMLCqvHjUYQ9toCDr8AEGZGX45o8qL
         LjoewcOvqE/8WPLrj7kOMGERt4geD0PGwgc94hbGRI2sl/UmMjBjSXbx4+Jp5PkJMafb
         UpKA==
X-Gm-Message-State: AFqh2kq/HMh29+Q2BZdXHp1705njNIEavM1bhUSuQPJ/QpLT5o0Xhxwq
        c/1pE3Hg+IFh/RiaZGRxZIx3JF9aRn0=
X-Google-Smtp-Source: AMrXdXtz9fMjm7mvZXGF+QkEcAhjwcXos18FOOwFJQudOeXCI/fiwQ5tdesV03jF/SYiUrBOaNTD6w==
X-Received: by 2002:a2e:a90b:0:b0:27f:f1ef:d0c7 with SMTP id j11-20020a2ea90b000000b0027ff1efd0c7mr4849993ljq.38.1672940885395;
        Thu, 05 Jan 2023 09:48:05 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.236])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e9a95000000b0027fc14cdfa5sm2957666lji.42.2023.01.05.09.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:48:04 -0800 (PST)
Message-ID: <1539bde6-0b5d-6d15-848b-75493a6ebe06@gmail.com>
Date:   Thu, 5 Jan 2023 20:48:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: btrfs send and receive showing errors
Content-Language: en-US
To:     =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>,
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
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <63e8183f-dffb-3ac9-e791-f59e85d2f093@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.01.2023 19:47, Randy Nürnberger wrote:
> On Thu, Jan 5, 2023 at 17:35, Randy Nürnberger wrote:
>> On Thu, Jan 5, 2023 at 17:01, Andrei Borzenkov wrote:
>>> On 05.01.2023 18:55, Randy Nürnberger wrote:
>>>>
>>>> I’ve attached the output of ‘btrfs subvolume list’ for the source and
>>>> the target filesystem.
>>>>
>>>
>>> You have a lot of source subvolumes with the same received_uuid and
>>> you have at least two destination subvolumes with the same
>>> received_uuid. This is wrong, received_uuid is supposed to be unique
>>> identification which explains your errors (incorrect subvolume is
>>> selected).
>>
>> I guess many of my source subvolumes have the same received_uuid,
>> because I created new snapshots from a snapshot that was previously
>> received and the received_uuid just did get copied.
>>
>> I just did a small experiment on another system, created a snapshot
>> from a snapshot that previously was received and could confirm that
>> the received_uuid does indeed get copied. Is this a problem?
> 

No, it is not a problem by itself. Subvolumes used for send/receive are 
supposed to be a remain read-only, so any clone of any subvolume should 
have identical content and you can use any of the clones with the same 
received_uuid. But as soon as you made subvolume read-write, you got 
multiple subvolumes with different content and the same receive_uuid. 
"Doctor, it hurts when I stab myself in the eye".

Never, NEVER, ever, change  subvolume involved in send/receive to 
read-write to use it; clone it (create writable snapshot) and use clone.

> Ha! This seems to be the problem! I’m able to write a small script that
> reproduces the bug! Give me a couple minutes.
> 
> If this is a bug in the kernel,

It is not so much a bug as the consequence of unfortunate design.

> may I write the patch? :D Would be my
> first one :)

The problem is known for years (just search this list) and there are 
patches to clear received_uuid on ro -> rw transition but they are still 
not applied. Personally I would just prohibit such transition completely.
