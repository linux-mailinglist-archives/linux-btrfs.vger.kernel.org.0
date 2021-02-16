Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E015131CFEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 19:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBPSM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 13:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBPSMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 13:12:23 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF2C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 10:11:43 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o21so7714073qtr.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=irwhJdx/cFWGU41yvbGj3EgeW3fbqSR33w+W7m4LvII=;
        b=uL8qW4vG8jGZRbX+/yIdjVRMAObxuaPt0X2W9QOKY253BAT35qCDPC9gVaerhZRDWq
         U7HsQmKi6723vkfV//N8LLg9U5f52GBBEYMS3qhwPAKsTyFcR6RZVIxsgfxhf80uK5+r
         oWu5cbYemcHNSF7uH0xX8qLwJ215/NNaBHcfKJA2F+zu12NqGn2crmlPX1CUdgd87K8i
         vi7658khDSOULDEbjL3ORIMMtvSo9aAaj2UVlejYWvZvNRSGQyhY3GyH8Psqzd/g30s3
         O7sdamS8otKylecTz/pzKka9u3XyGS3wWfI32AcT71JQAB405eQDbJypw7+NNUZs0e9l
         q6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irwhJdx/cFWGU41yvbGj3EgeW3fbqSR33w+W7m4LvII=;
        b=srk+DTvMdgl8LaTitVbZm4/TZxVqRGOK02EUr7sSPO+fOzSkpwmEFMApcV935ZW2kN
         GZMSDkWO0La3PulMxFIrEBaqCUf1sJUrhA+jiC6yJX0yT3v/5UWmPjOpiJc9sB3gnlyf
         f5FNi76TNXJS2lDi0/NeLheamudfle4Y21DmozCudYm6vaN0okeJqR9RseFzhppV3evO
         2AX2lG55PhS2n8B9C224pmiLs0iyGkvXhmyMf276AQDyAZxt9PQDKSGEJg/ZDI3E+7Re
         UNi2ABlV91qy8GDkUWpnJWPG9bCRib2xCXLEuH4widCwyWtt7htEXzO+jW65HhfuzYpt
         U1RA==
X-Gm-Message-State: AOAM531r5QXC/TnemNHHxjfPbikvuzxt7lrIZaBUbvolfVj/2cbUoaVh
        a8wod8L5uxZta+4YZ82ccL5+ynWqZYjoNSLQ
X-Google-Smtp-Source: ABdhPJxMR3yqZgGopkRfhZDaV6/mpZ1L1YLQoAGq8/Qvn76zimswx7ERBqc6n16OOCVif+0R0qTSow==
X-Received: by 2002:ac8:524a:: with SMTP id y10mr4117870qtn.376.1613499102205;
        Tue, 16 Feb 2021 10:11:42 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k8sm7342569qkk.81.2021.02.16.10.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 10:11:41 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
 <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
Date:   Tue, 16 Feb 2021 13:11:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/16/21 11:27 AM, Neal Gompa wrote:
> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>> Hey all,
>>>
>>> So one of my main computers recently had a disk controller failure
>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>> mount. I tried to do a mount and the following errors show up in the
>>> journal:
>>>
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>
>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>> seem to find any reasonably good information on how to do recovery in
>>> this scenario, even to just recover enough to copy data off.
>>>
>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>> using btrfs-progs v5.10.
>>>
>>> Can anyone help?
>>
>> Can you try
>>
>> btrfs check --clear-space-cache v1 /dev/whatever
>>
>> That should fix the inode generation thing so it's sane, and then the tree
>> checker will allow the fs to be read, hopefully.  If not we can work out some
>> other magic.  Thanks,
>>
>> Josef
> 
> I got the same error as I did with btrfs-check --readonly...
> 

Oh lovely, what does btrfs check --readonly --backup do?

Josef
