Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF013576B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 11:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgAIKw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 05:52:57 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:32926 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAIKw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 05:52:57 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id EED129C366; Thu,  9 Jan 2020 10:52:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578567174;
        bh=50/IjVZQRy72li/NoQBokHLC15Tw3Hvb0NOWPVjtwEo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=C8jsttaTJgRK1YPIBVQJyE5ZrXD0yezPSOh5u/C1a4wqC62hihKcdSTxaqxq5mi4u
         pd1K6s897+7IieFOEAPS3fXtPsJDkwPZpRfCL8Im3Sq2sryodIeS9IDtQeJh/FD9iG
         PQge6WlQYV8vXEFjSlhDwupTuQUKziZSbd93P/3cIrDusTXDONSvEq95BZ+ZZaBi52
         ddBxyaT4IF4ZXe4KQGgRXmUR0L1CHuSJGtwyDYMSGEL7bA6qt/Z5uOahEKkOL03T0v
         PQrsS9ILCPR+4JSVUvlalC3Z17gwtmTG30rRM2JR0JAhqRjyX/86aBKFkmrcXwZyfT
         xaV76G7ITkMKQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id C9F019C357;
        Thu,  9 Jan 2020 10:52:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578567169;
        bh=50/IjVZQRy72li/NoQBokHLC15Tw3Hvb0NOWPVjtwEo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=uuFKKH6kPOTjOCntouMiL/JnUz3qj4vVYKz04YF99L4oGdT6KGms4rBg4PSCXv8ZG
         vrVsvTmX8nMDoZAsLzUhmhdDQiRnF/5ac6UUdbL45Y6VVLsjer1VV/Hzy34PCxgyY0
         wYOK84gKLnzeZ+XFhkN6BhpTeseG5JZSNSK2NHaV5vxA3ZQPGLBzLNYrwvz24Ygavf
         Bonrp/x0jlq0fAYn2k8fD1vF1K+6IVT0n7EXLIpNavcEEyxJ6k2RBIzGcW5u9d1Nwd
         esi9N/yHU5f0fSgLGL69HGu8z4gg0rA33HXJ1SLK2T/NYr+5rMzqotEVDg79tWrSas
         QBOVbUbN1oJDA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 867ECA0193;
        Thu,  9 Jan 2020 10:52:49 +0000 (GMT)
Subject: Re: btrfs scrub: cancel + resume not resuming?
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
 <b031f351-2a9c-83b3-7e4b-ac15791d96e6@applied-asynchrony.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <71add409-04ad-c6be-4f4f-5eec4ffb167c@cobb.uk.net>
Date:   Thu, 9 Jan 2020 10:52:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b031f351-2a9c-83b3-7e4b-ac15791d96e6@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/01/2020 10:34, Holger Hoffstätte wrote:
> On 1/9/20 11:03 AM, Sebastian Döring wrote:
>> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
>> scrub resume' to work properly. During a running scrub the resume
>> information (like data_bytes_scrubbed:1081454592) gets written to a
>> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
>> relevant fields are zeroed. 'btrfs scrub resume' then seems to
>> re-start from the very beginning.
>>
>> This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
>> this for a while now.
>>
>> Is this intended/expected behavior? Am I using the btrfs-progs wrong?
>> How can I interrupt and resume a scrub?
> 
> Using 5.4.9+ (all of btrfs-5.5) and btrfs-progs 5.4 I just tried and
> it still works for me (and always has):
> 
> $btrfs scrub start /mnt/backup
> scrub started on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312
> (pid=25633)
> 
> $btrfs scrub cancel /mnt/backup
> scrub cancelled
> 
> $btrfs scrub resume /mnt/backup
> scrub resumed on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312
> (pid=25704)
> 
> ..and it keeps munching away as expected.

Can you check that the resume has really started from where the scrub
was cancelled? What I (and, I think, Sebastian) are seeing is that the
resume "works" but actually restarts from the beginning.

For example, something like:

btrfs scrub start /mnt/backup
sleep 300
btrfs scrub status -R /mnt/backup
btrfs scrub cancel /mnt/backup
btrfs scrub resume /mnt/backup
sleep 100
btrfs scrub status -R /mnt/backup

and check the last_physical in the second status is higher than the one
in the first status.
