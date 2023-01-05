Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52965F36E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAESHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjAESGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 13:06:17 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41092564EC
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 10:04:51 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bt23so39453789lfb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSeynfWVWBeTNbHbJNOROUp3GtNVBaByp9rRIw3VfTM=;
        b=EQKB4IiOECTtiXgypB24+gfma/EOc2Hpke9EEXABtHUF3Q1j/I3vTZJ+F+b05VGcAg
         77fBfEcBwokXxaXYKGt+PHq0VRKzsRaYllk40KyI+026Ny6GcsvLEDiXmgCmZE6o883D
         82b9VjT8trg3Xws+6h1gyqsQmk8con1nnozCevSPaxPFq0edXwcDTBenAyGSAtU5z2Qg
         jcw3/15U7D/K3x/YJvJtPRUp4kapFCqCW6WL4VA8sr7flv8udETixZfVhBGdfC0vMleo
         nzdTDRzUwBSNAi6HbOSLHIUlPp1z9dSkIfeebukgh5FYHnHSZzeVqAK1HxUjxFG0O/L4
         QEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSeynfWVWBeTNbHbJNOROUp3GtNVBaByp9rRIw3VfTM=;
        b=kQCP6UGMgxN3JbqsLu75KR0Yp448Ao9uz5hwWpyWXUp0bpEmlBfucA3P+c5e7T52nF
         9ZAvoWJ1Mn4vvArPpVTAlwSVx8WWH8Tu9M3SfMaQiIZ/d5bZNu/RYhYxgIBf3qZgkPXM
         fNipFJ1l9luIuwVkF8CQmg2rbaJGQQp5P48OnBtNnGWeGKONKdJ1MvRooFsiVcu74r8L
         5MkXys+H8BtDc2iqigtM0EiAXl7Gf9+wOuN/Ruo+SA/ZOJVhzsORLaT+4jwivbRwC1Hx
         e52qgCfIcwWrGBG4C50jmfkeR0oeZuGRxKvQLazRoARfwGKkcrODbto9YIXDmm+nmbhs
         XfUg==
X-Gm-Message-State: AFqh2krtIcMhZrI4v1glTH3D2Bzm2GpMYORpjvZDYtpLmBqtoH2ZZXxP
        o/q6haGPhn2EMJ8OZaXjgF9tZzlR+yc=
X-Google-Smtp-Source: AMrXdXvFRyklEVDxRCdWyvKE0+moeZqsWwfj0OowbmWbjgsInUfgYhsSD8wKhRc/iZprcR7o1XYBCw==
X-Received: by 2002:a05:6512:c10:b0:4cb:430d:2b98 with SMTP id z16-20020a0565120c1000b004cb430d2b98mr3937769lfu.11.1672941887875;
        Thu, 05 Jan 2023 10:04:47 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.236])
        by smtp.gmail.com with ESMTPSA id s20-20020a195e14000000b004b0b2212315sm5568878lfb.121.2023.01.05.10.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 10:04:47 -0800 (PST)
Message-ID: <0fd1ae43-6605-cee0-4859-53b9226eb865@gmail.com>
Date:   Thu, 5 Jan 2023 21:04:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: btrfs send and receive showing errors
Content-Language: en-US
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
 <1539bde6-0b5d-6d15-848b-75493a6ebe06@gmail.com>
In-Reply-To: <1539bde6-0b5d-6d15-848b-75493a6ebe06@gmail.com>
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

On 05.01.2023 20:48, Andrei Borzenkov wrote:
> On 05.01.2023 19:47, Randy Nürnberger wrote:
>> On Thu, Jan 5, 2023 at 17:35, Randy Nürnberger wrote:
>>> On Thu, Jan 5, 2023 at 17:01, Andrei Borzenkov wrote:
>>>> On 05.01.2023 18:55, Randy Nürnberger wrote:
>>>>>
>>>>> I’ve attached the output of ‘btrfs subvolume list’ for the source and
>>>>> the target filesystem.
>>>>>
>>>>
>>>> You have a lot of source subvolumes with the same received_uuid and
>>>> you have at least two destination subvolumes with the same
>>>> received_uuid. This is wrong, received_uuid is supposed to be unique
>>>> identification which explains your errors (incorrect subvolume is
>>>> selected).
>>>
>>> I guess many of my source subvolumes have the same received_uuid,
>>> because I created new snapshots from a snapshot that was previously
>>> received and the received_uuid just did get copied.
>>>
>>> I just did a small experiment on another system, created a snapshot
>>> from a snapshot that previously was received and could confirm that
>>> the received_uuid does indeed get copied. Is this a problem?
>>
> 
> No, it is not a problem by itself. Subvolumes used for send/receive are
> supposed to be a remain read-only, so any clone of any subvolume should
> have identical content and you can use any of the clones with the same
> received_uuid. But as soon as you made subvolume read-write, you got
> multiple subvolumes with different content and the same receive_uuid.
> "Doctor, it hurts when I stab myself in the eye".
> 
> Never, NEVER, ever, change  subvolume involved in send/receive to
> read-write to use it; clone it (create writable snapshot) and use clone.
> 
>> Ha! This seems to be the problem! I’m able to write a small script that
>> reproduces the bug! Give me a couple minutes.
>>
>> If this is a bug in the kernel,
> 
> It is not so much a bug as the consequence of unfortunate design.
> 
>> may I write the patch? :D Would be my
>> first one :)
> 
> The problem is known for years (just search this list) and there are
> patches to clear received_uuid on ro -> rw transition but they are still
> not applied. Personally I would just prohibit such transition completely.

Correction - it was decided to implement in btrfs utils, not in kernel, 
so "btrfs property" will by default refuse to make read-write subvolume 
with received_uuid. This is implemented in 5.14.2.
