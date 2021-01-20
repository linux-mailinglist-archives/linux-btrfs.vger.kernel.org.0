Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EDE2FC8A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 04:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbhATDUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 22:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbhATDUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 22:20:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC3C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 19:19:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so11722577plh.12
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 19:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mLtlOUG39CPJVc6ee+wqOlFOv5CgCiEUTvlNq98aWgQ=;
        b=Rh4uBiNPZQawtD3A8c4Eau8c9epdNo83ZDQwyuwFqnUMjT/WgJC4zyBJtxpfEOCqpk
         1BMhRmyr+vavQVoBY7Q4lsgUk4jVtRwmn7k9B/FO26UM7aX2CVyxMO8sFTigXHNXQAQp
         qWC7nLiDA3vOH1RAT8e3nwcI5QHEm5BPlh8l6E5ANj/A7l4i/aAvjUeeDJ8C61VX5fIT
         seza5IjTlUQ7G7z4T+uuUPScmtpVuEo6oSxk5XmzDnXSTd+1YSZPa7Q42c3Rto2W3W3r
         WnVWKsejLKx763qoTJSB3CxAVnc96MD52SlawchYHATkcsJ7YKbzVQCoi6KlGG/Z9nZD
         q4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mLtlOUG39CPJVc6ee+wqOlFOv5CgCiEUTvlNq98aWgQ=;
        b=rD3rbaZ9g7Z8kzjkSHBd6oDdS8rO9veCM41TxeP8FWjFgllaw7joyQq6fQF675HJyl
         ACP1tcJUnvzFIySteg2qnnhqhNHTf5sRUbjuHyTM55H689oM9qQLTZaDOA7svQe9YNyY
         Ivy0da3SWmSHepiruk+UYpRDH6j9XdSL4ooEFpFNq+rqc4Do1f98nenHoE+Qdg+cNeS+
         30vyYUr2Epc3hwC70UAAs4+FjGYOaA9dCMAtchBvL7snbGTWCRsj3UnCMLqg+xS7jetj
         ZzXV9bJa+YOC/WVtn3xEshnbzT7ds/ALH6/at3hPjHCD8QYd6yyss7aiIwO5fm8ja/Bs
         KwzA==
X-Gm-Message-State: AOAM532dER7Xt/6/WR9arzqx+llDQ/jxVkPuaXJ6uKJJAw5gMkkPkRzp
        zSIh83LsqsMhOHJ7376O5pO0QlawGuM=
X-Google-Smtp-Source: ABdhPJwsU8iPjzoohIPZDJ56F8Hd9ZwyVKZHl7TplOTppExWKc7xVdhvJG6G9ScQJYOOrUv8bysrEA==
X-Received: by 2002:a17:90a:5581:: with SMTP id c1mr3273090pji.86.1611112761423;
        Tue, 19 Jan 2021 19:19:21 -0800 (PST)
Received: from [192.168.1.74] (d206-116-119-5.bchsia.telus.net. [206.116.119.5])
        by smtp.gmail.com with ESMTPSA id v9sm449805pff.102.2021.01.19.19.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 19:19:20 -0800 (PST)
Subject: Re: received uuid not set btrfs send/receive
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
 <CAJCQCtRydKSXoYSL15=RHfadWESd_N-ed3eknhbX_95gpfiQEw@mail.gmail.com>
From:   Anders Halman <anders.halman@gmail.com>
Message-ID: <fc89cf76-022d-caff-23a6-d7456210c686@gmail.com>
Date:   Tue, 19 Jan 2021 19:19:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRydKSXoYSL15=RHfadWESd_N-ed3eknhbX_95gpfiQEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-DK
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for answering so late. I compiled a more recent (v5.9) version of 
btrfs-progs first.
The unpacking/receiving took about 2 days on the raspberry.

$ nohup btrfs receive -v -f splitter . &
$ tail -n1 nohup.out
ERROR: short read from stream: expected 49233 read 44997

thanks to your -v suggestions I got a little bit more information.

first I figured the files on the local and remote host are not the same, 
by md5sum.

So I will solve this issue first. Is there any recommended way to 
transfer btrfs subvolumes over an unstable connection?


Am 17.01.21 um 13:07 schrieb Chris Murphy:
> On Sun, Jan 17, 2021 at 11:51 AM Anders Halman <anders.halman@gmail.com> wrote:
>> Hello,
>>
>> I try to backup my laptop over an unreliable slow internet connection to
>> a even slower Raspberry Pi.
>>
>> To bootstrap the backup I used the following:
>>
>> # local
>> btrfs send root.send.ro | pigz | split --verbose -d -b 1G
>> rsync -aHAXxv --numeric-ids --partial --progress -e "ssh -T -o
>> Compression=no -x" x* remote-host:/mnt/backup/btrfs-backup/
>>
>> # remote
>> cat x* > split.gz
>> pigz -d split.gz
>> btrfs receive -f split
>>
>> worked nicely. But I don't understand why the "received uuid" on the
>> remote site in blank.
>> I tried it locally with smaller volumes and it worked.
> I suggest using -v or -vv on the receive side to dig into why the
> receive is failing. Setting the received uuid is one of the last
> things performed on receive, so if it's not set it suggests the
> receive isn't finished.
>

