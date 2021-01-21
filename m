Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBCF2FE0E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 05:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbhAUEkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 23:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732448AbhAUDzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 22:55:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A05C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 19:44:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c132so512490pga.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 19:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LlRAebKsvaJdpJ3H1qCQrgpMQhVoHplTIysa2z2AgyQ=;
        b=VTvLuRFNgH/SDuqwmzME0BhPtyUUtCvWkW/DPRhOqpeWbqRbhRvFShz99ksswI/Xr4
         dI9oZs+jin12TXrm7rsXfLl04WkdSz1Vqp/SfLziIqFM1h18umB/e6uGaCuFv6mC7Hqg
         l/jZhb9xacbO8natDbrHSoqvIDpRGTb7kNZvgZf9EcqFkyxGO+M9hXajPYNKtdpv6QGc
         pX9GtAAa6I8jyRReBfq8y6MWrKVfZJ7BmcnTaTanwKSF/BywMJL88aaXfa2y6nzhDEKz
         yer/krUHbAVJxclfCmfVNGMpL5k3whSmwyLzmsn0krOEdEC96qHF21kN64Vz6OlF4WGo
         f6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LlRAebKsvaJdpJ3H1qCQrgpMQhVoHplTIysa2z2AgyQ=;
        b=qcPLY7XMkSlFkk+lpzWd5qZB7Vo5vANMYOPPBCyBMBGK2qip5VpcqGxabJ1p1cjRTc
         pogjLVpCSxW+wkvVJ8lyh9x/YA4iYz8nkhFsRyX/Chpxn3S9mbzn5GjzMe1t0MXWRHxC
         7LDbu4hZND3o+Usx8m6NnXh6e0m9ksg/UPLqw6Vg0wbSdUxZ36/t1vzPLQgtvLJbqnYs
         bYjTmybxzkj5RszxdHlCeXc0fL4TaYrSGxgf9v4ELN7zmXj8yqRNlY02vUt6W8aP8Cfi
         nA/MVnW3u1mNzVviPg5lGguClW6Q9SpuN6WgROEGLn5IKraC/14fTB6Iy6rf4G+3ivAy
         cwfA==
X-Gm-Message-State: AOAM530Ma/z41PwvlUZgS4Q4GnQApIsu+wrFqGiKF1avyT1IDwoLSHFC
        oaLTSA4OjEFsCL4Hr5prsMW4Tm0z0Fc=
X-Google-Smtp-Source: ABdhPJwqooNIFFsxg3jsTGoa7fky4e9EE+oSfqX+oJidg3IHAjjNVN+Zs5VqFIS39DVjGtpK7KNrRA==
X-Received: by 2002:a63:4d41:: with SMTP id n1mr12567313pgl.147.1611200698196;
        Wed, 20 Jan 2021 19:44:58 -0800 (PST)
Received: from [192.168.1.74] (d206-116-119-5.bchsia.telus.net. [206.116.119.5])
        by smtp.gmail.com with ESMTPSA id t2sm3945128pga.45.2021.01.20.19.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 19:44:57 -0800 (PST)
Subject: Re: [SOLVED] received uuid not set btrfs send/receive
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
 <CAJCQCtRydKSXoYSL15=RHfadWESd_N-ed3eknhbX_95gpfiQEw@mail.gmail.com>
From:   Anders Halman <anders.halman@gmail.com>
Message-ID: <66c59dfb-5eaa-656c-f17e-e4ea71e53fa9@gmail.com>
Date:   Wed, 20 Jan 2021 19:44:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRydKSXoYSL15=RHfadWESd_N-ed3eknhbX_95gpfiQEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The problem was a corrupt "btrfs send file" or to be more specific, the 
file got corrupt somewhere on the line of transport
To recap the problem for further reference:

check the import (btrfs receive) with the -v option like so:

$ nohup btrfs receive -v -f root.receive.file . &

the import is successful, thus the received uuid is set when you get 
something like ....

$ tail -n1 nohup.out
BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=99a34963-3506-7e4c-a82d-93e337191684, 
stransid=1232187

... after "btrfs receive" is done.

make sure to double check the file size and checksum (md5sum) of "btrfs 
send file" and "btrfs receive file".

I don't know exactly where the corruption happened, but in the second 
attempt I successful combined the import like so:

$ cat x* | pigz -d > root.receive.file


Thanks for the support


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

