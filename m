Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A551E210910
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGAKQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgGAKQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 06:16:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18CC061755
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 03:16:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so11481767pgb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V/GsqvGlG4StC60CWbJJlV7qdSTAtwPOPueOBXRPYwo=;
        b=L6joxJoz9CSCfXl12rk59ZgUTTS+axiXllOQimSptE1CYUwqiFIHCg8rmzjx/GRqb4
         TOwp7WTl9dKETg9UcxAxcIxUxesgdQWtF8/skzlJ1YnPvsdUjwWqX//qYt/WlI4OD0xO
         83LaxwT4/bAbCqmfkJDeYrMnRZV0icprxtyxwDcfaSilznakCGIsLPlxI9nigbOEolGy
         6A3Z1Rr5T9DXxDiVdpdIe4aSgcfdqXhfyG3lQSMXdhrxcer2xGZKvNrmGShZZpLIqDNO
         FC2QrQAXa04LhJs/LNa0ujrmLl/nDBPqlAXk5zRhX82lvwMb2T6eg5n8lkGLMJI5ctmZ
         GOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V/GsqvGlG4StC60CWbJJlV7qdSTAtwPOPueOBXRPYwo=;
        b=f/seDVBsb+xyRdt2GSYxfmTTvA2Cdfli5AOY/MDyPScjSnq8Mziryg1eQtdQbfYT5N
         6RDCTpNe1zN0nT4SE5U6F1C33QPl30IHmvQ8Oic9JBz7Rc3cvKYt8OdCGU/v8l+5+gQ0
         J1PuOLR4TWcIv8gN/lz93cJQZVp06c0ReJCgiKR3crIGygtcHk1dXNzj8fhdsBe5fCbi
         1IPo/P0XGPzo3qKTyZkvNMfRFiVFl8soHyN6/wToj5NP9Sbwyt2QAXb10eWRcBCndIgl
         vah0VdDOG2JXwGmNdYve7r9rC/nXu4oh492w8TpQxX6D783UEOlGfetrQEZ1PytV8isJ
         UbTw==
X-Gm-Message-State: AOAM532lPlYUYFodCelRZpJu1XUJRSN9Rww0q6yCHz1N2aID2EYr7LZn
        gRMbCxg0UbnYF7AjKaSCls7DvUSIEQk=
X-Google-Smtp-Source: ABdhPJxj/Z4oUpe39KtoBHm+iFfpATEZJxJYJH8YqUN1DBinOkODcva+DNHLokYEnDw3rfPZdMuJtQ==
X-Received: by 2002:a63:b915:: with SMTP id z21mr20021154pge.145.1593598570233;
        Wed, 01 Jul 2020 03:16:10 -0700 (PDT)
Received: from [192.168.0.23] (c-24-4-127-117.hsd1.ca.comcast.net. [24.4.127.117])
        by smtp.gmail.com with ESMTPSA id q20sm5564671pfn.111.2020.07.01.03.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 03:16:09 -0700 (PDT)
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
 <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
From:   Illia Bobyr <illia.bobyr@gmail.com>
Message-ID: <2f22bd0a-aa48-d0f1-04d0-cb130897249d@gmail.com>
Date:   Wed, 1 Jul 2020 03:16:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/30/2020 6:36 PM, Qu Wenruo wrote:
> On 2020/7/1 上午3:41, Illia Bobyr wrote:
>> Hi,
>>
>> I have a btrfs with bcache setup that failed during a boot yesterday.
>> There is one SSD with bcache that is used as a cache for 3 btrfs HDDs.
>>
>> Reading through a number of discussions, I've decided to ask for advice here.
>> Should I be running "btrfs check --recover"?
>>
>> The last message in the dmesg log is this one:
>>
>> Btrfs loaded, crc32c=crc32c-intel
>> BTRFS: device label root devid 3 transid 138434 /dev/bcache2 scanned
>> by btrfs (341)
>> BTRFS: device label root devid 2 transid 138434 /dev/bcache1 scanned
>> by btrfs (341)
>> BTRFS: device label root devid 1 transid 138434 /dev/bcache0 scanned
>> by btrfs (341)
>> BTRFS info (device bcache0): disk space caching is enabled
>> BTRFS info (device bcache0): has skinny extents
>> BTRFS error (device bcache0): parent transid verify failed on
>> 16984159518720 wanted 138414 found 138207
>> BTRFS error (device bcache0): parent transid verify failed on
>> 16984159518720 wanted 138414 found 138207
>> BTRFS error (device bcache0): open_ctree failed
> Looks like some tree blocks not written back correctly.
>
> Considering we don't have known write back related bugs with 5.6, I
> guess bcache may be involved again?

A bit more details: the system started to misbehave.
Interactive session was saying that the main file system became read/only.
And then the SSH disconnected and did not reconnect any more.
It did not seem to reboot correctly after I've pressed the reboot
button, so I did a hard rebooted.
And now it could not mount the root partition any more.
>> Trying to mount it in the recovery mode does not seem to work:
>>
>> [...]
>>
>> I have tried booting using a live ISO with 5.8.0 kernel and btrfs v5.6.1
>> from http://defender.exton.net/.
>> After booting tried mounting the bcache using the same command as above.
>> The only message in the console was "Killed".
>> /dev/kmsg on the other hand lists messages very similar to the ones I've
>> seen in the initramfs environment: https://pastebin.com/Vhy072Mx
> It looks like there is a chance to recover, as there is a rootbackup
> with newer generation.
>
> While tree-checker is rejecting the newer generation one.
>
> The kernel panic is caused by some corner error handling with root
> backups cleanups.
> We need to fix it anyway.
>
> In this case, I guess "btrfs ins dump-super -fFa" output would help to
> show if it's possible to recover.

Here is the output: https://pastebin.com/raw/DtJd813y

> Anyway, something looks strange.
>
> The backup roots have a newer generation while the super block is still
> old doesn't look correct at all.

Just in case, here is the output of "btrfs check", as suggested by "A L
<mail@lechevalier.se>".  It does not seem to contain any new information.

parent transid verify failed on 16984014372864 wanted 138350 found 131117
parent transid verify failed on 16984014405632 wanted 138350 found 131127
parent transid verify failed on 16984013406208 wanted 138350 found 131112
parent transid verify failed on 16984075436032 wanted 138384 found 131136
parent transid verify failed on 16984075436032 wanted 138384 found 131136
parent transid verify failed on 16984075436032 wanted 138384 found 131136
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=16984175853568 item=8 parent
level=2 child level=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system
Opening filesystem to check...

As I was running the commands I have accidentally run the following command:

    btrfs inspect-internal dump-super -fFa >/dev/bcache0 2>&1

Effectively overwriting the first 10kb of the partition :(

Seems like the superblock starts at 64kb.  So, I hope, this would not
cause any more damage.

P.S. Thanks a lot for your reply Qu Wenruo!

Thank you,
Illia

