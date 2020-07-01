Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1521153D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 23:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgGAVhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 17:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgGAVg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 17:36:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4DC08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 14:36:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so9395852pgf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KdzPCdEF2xqQ/MwHa7ag9m/LKgCMBzVHeQWYnxMv+vE=;
        b=o3s9N+iF6IcDvl/u3CFd76UqThA1yIp4RFzwnBQyoFMXqQyp1FLerUm9w0eDSkXXRx
         IQaBXPUPYoW/SR/W6Iue+0bocllazUGekDAstqsEwacX84MjrfWPudJDabfC8gM4n7pP
         273cmG3quTRh0CoC3aya2rCDzFmogb22nnFwtCRrzUMs+zMX4GBtYUzBday9W2XiVm8V
         YXVcTzQK2KLCMWd6N1TA4NCywzAUVzRQSxf1OIogUS96KuMNapNCsmjIWZ2NhYlpA95i
         9EgUge87oQRaZlZqcdt+BtdrDz/n+iJ3DR0Ptetr6YFLoLMh9o3e81L7dXzVX1mRUlw6
         RM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KdzPCdEF2xqQ/MwHa7ag9m/LKgCMBzVHeQWYnxMv+vE=;
        b=GlUipJuUTf70WnbWcTH/78PADicJz6Wt19oeYmqCGP7CKHD0QZZg/6tWB6eCyd6yAu
         he5U05e01/NMCJB2dtw4mN+thgLngsoKDUvQ3sczD2dr4eZdMwxQ7Jqh4Ojs4FoRyp4x
         4sQIsuGBGWGcqMTM3OLpjPumBagZ2PIEXX7ynGX+dKgHzIr1PwvarEReQGwmPVJUYIyU
         DDn4XRV3AvX0oU5qypKkIwIJc5JNthPGeTIPmazV3XmXcwPz//+lzDlr4ZXnUqg2uNPQ
         BUvcSjvj80CUJ6PDZlNGss2FZuD6g+YewT0i7qyji10hpnqw9wPLLVmBFxxjxjC7N5nP
         tQNw==
X-Gm-Message-State: AOAM532/J8yW7IXRRWhf2KRenUIbznLfTpIhVXwDvxVFFfEZZq1euq5f
        Voq0o+75hga5wC6+hAvrdHjkgwGhoQw=
X-Google-Smtp-Source: ABdhPJwMspAzmENq6oepJLg3uOn92kETOW7YER8J0yCZOUIwM9Pmd0ZtJOYttbLi6MtQjfLfgxl2ag==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr9553900pgv.230.1593639418762;
        Wed, 01 Jul 2020 14:36:58 -0700 (PDT)
Received: from [192.168.0.23] (c-24-4-127-117.hsd1.ca.comcast.net. [24.4.127.117])
        by smtp.gmail.com with ESMTPSA id m20sm7081041pfk.52.2020.07.01.14.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 14:36:58 -0700 (PDT)
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
 <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
 <2f22bd0a-aa48-d0f1-04d0-cb130897249d@gmail.com>
 <39558ad7-dfb3-05f7-1583-181f76f2a93d@gmx.com>
From:   Illia Bobyr <illia.bobyr@gmail.com>
Message-ID: <f6fcf7b7-37c8-8a0e-e373-03b8c828ce09@gmail.com>
Date:   Wed, 1 Jul 2020 14:36:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <39558ad7-dfb3-05f7-1583-181f76f2a93d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/2020 3:48 AM, Qu Wenruo wrote:
> On 2020/7/1 下午6:16, Illia Bobyr wrote:
>> On 6/30/2020 6:36 PM, Qu Wenruo wrote:
>>> On 2020/7/1 上午3:41, Illia Bobyr wrote:
>>>> [...]
>>> Looks like some tree blocks not written back correctly.
>>>
>>> Considering we don't have known write back related bugs with 5.6, I
>>> guess bcache may be involved again?
>> A bit more details: the system started to misbehave.
>> Interactive session was saying that the main file system became read/only.
> Any dmesg of that RO event?
> That would be the most valuable info to help us to locate the bug and
> fix it.
>
> I guess there is something wrong before that, and by somehow it
> corrupted the extent tree, breaking the life keeping COW of metadata and
> screwed up everything.

After I will restore the data, I will check the kernel log to see if
there are any messages in there.
Will post here if I will find anything.

>> [...]
>>> In this case, I guess "btrfs ins dump-super -fFa" output would help to
>>> show if it's possible to recover.
>> Here is the output: https://pastebin.com/raw/DtJd813y
> OK, the backup root is fine.
>
> So this means, metadata COW is corrupted, which caused the transid mismatch.
>
>>> Anyway, something looks strange.
>>>
>>> The backup roots have a newer generation while the super block is still
>>> old doesn't look correct at all.
>> Just in case, here is the output of "btrfs check", as suggested by "A L
>> <mail@lechevalier.se>".  It does not seem to contain any new information.
>>
>> parent transid verify failed on 16984014372864 wanted 138350 found 131117
>> parent transid verify failed on 16984014405632 wanted 138350 found 131127
>> parent transid verify failed on 16984013406208 wanted 138350 found 131112
>> parent transid verify failed on 16984075436032 wanted 138384 found 131136
>> parent transid verify failed on 16984075436032 wanted 138384 found 131136
>> parent transid verify failed on 16984075436032 wanted 138384 found 131136
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=16984175853568 item=8 parent
>> level=2 child level=0
>> ERROR: failed to read block groups: Input/output error
> Extent tree is completely screwed up, no wonder the transid error happens.
>
> I don't believe it's reasonable possible to restore the fs to RW status.
> The only remaining method left is btrfs-restore then.

There are no more available SATA connections in the system and there is
a lot of data in that FS (~7TB).
I do not immediately have another disk that would be able to hold this much.

At the same time this FS is RAID0.
I wonder if there is a way to first check if restore will work should I
will disconnect half of the disks, as each half contains all the data.
And then if it does, I would be able to restore by reusing the space on
of the mirrors.

I see "-D: Dry run" that can be passed to "btrfs restore", but, I guess,
it would not really do a full check of the data, making sure that the
restore would really succeed, does it?

Is there a way to perform this kind of check?
Or is "btrfs restore" the only option at the moment?

