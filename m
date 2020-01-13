Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF01392BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgAMN5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 08:57:44 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:49774 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgAMN5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 08:57:44 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 5A5C49C3DD; Mon, 13 Jan 2020 13:57:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578923861;
        bh=ynS5vvGryFs8ANc8gKxQgBUe1Vg+G+3tcrHylvETfIc=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=XjZAuxTj19LwE6c+dtDs5VDaqNfx7pXiAtubYTrMOhHlztmtdcLY2ZVhV3D8llBCC
         XvH7aWmdkcXEvc1wTs3S6xd7gDGeygNy3z45pXykFmiO3YKcPS1ZJd9+qy87qWOeQl
         /AvR6fFOZNsi1gXuXke2HJa6hUfgqUsixH+c4E0RKTiYFPhgQy8pvQYvmUdeZcYxD0
         J179swvj8Q7ohCzcApKg2goicFetJx5au4T3mSfwTSJ3Oj6ggoKSamFPgr7sWi1pJV
         pFWtTAzOm53bAmZNKa7QpOUDHC3ro8jT/A9AM2nPumqg6BJCvhGys6oA+6G6DlVo7D
         x/mgFeuvPGbZA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 72A8C9C3CA;
        Mon, 13 Jan 2020 13:57:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578923856;
        bh=ynS5vvGryFs8ANc8gKxQgBUe1Vg+G+3tcrHylvETfIc=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=Dc6uqvf6KMlmQgXrubmQFs1ocKYi78EhBXQUXmrn55/hPtQZoR2mIXUhD82mqo/Jb
         c+m0yd3gltgfMbZFQxcZQ7EKeom9k6FxYL4o3kspjIp07/tbEbXSXli6qjIKNlrYD/
         Jl0wffJhWBKpgXKuhLIiwv5AxTw+bA8CvD3YU+5Zd5fEsIUjy0T34ZE1fr9BSxkZTk
         +aNJgDnMh5WAFSlyESnFrB2VJGUCdu77NjlKh5ykFGOXLDiLqAvQ9bkj3NiD/fL87F
         6oOaFohdYi1404kH/grZCQ0WgXySupXMv7QvYNEvPOtBxAu3gr/pscImc7DgK9Ent9
         yDjQi4Xwf8bbw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 335EFA2093;
        Mon, 13 Jan 2020 13:57:36 +0000 (GMT)
Subject: Re: btrfs scrub: cancel + resume not resuming - kernel regression
To:     linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
 <654bf850-65bf-65f5-2ed2-90a0d4058e74@cobb.uk.net>
 <b1ef69cc-0861-ec6c-aa98-54bb66b2471f@cobb.uk.net>
 <81000b63-3fa8-a892-b4a8-79218f05d08d@cobb.uk.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Cc:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>
Message-ID: <c6d878d7-0c41-b731-f6d9-e0a9e112feab@cobb.uk.net>
Date:   Mon, 13 Jan 2020 13:57:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <81000b63-3fa8-a892-b4a8-79218f05d08d@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/01/2020 20:35, Graham Cobb wrote:
> On 09/01/2020 17:06, Graham Cobb wrote:
>> On 09/01/2020 10:19, Graham Cobb wrote:
>>> On 09/01/2020 10:03, Sebastian Döring wrote:
>>>> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
>>>> scrub resume' to work properly. During a running scrub the resume
>>>> information (like data_bytes_scrubbed:1081454592) gets written to a
>>>> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
>>>> relevant fields are zeroed. 'btrfs scrub resume' then seems to
>>>> re-start from the very beginning.
>>>>
>>>> This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
>>>> this for a while now.
>>>>
>>>> Is this intended/expected behavior? Am I using the btrfs-progs wrong?
>>>> How can I interrupt and resume a scrub?
>>>
>>> Coincidentally, I noticed exactly the same thing yesterday!
>>>
>>> I have just run a quick test. It works with kernel 4.19 but doesn't with
>>> kernel 5.3. This is using exactly the same version of btrfs-progs:
>>> v5.3.1 (I just rebooted the same system with an old kernel to check).
>>>
>>> As Sebastian says, the symptom is that the file in /var/lib/btrfs shows
>>> all fields as zero after the cancel (although "cancelled" and "finished"
>>> are both 1). In particular, last_physical is zero so the scrub always
>>> resumes from the beginning.
>>>
>>> With the old kernel, the file in /var/lib/btrfs correctly has all the
>>> values filled in after the cancel so the scrub can be resumed.
>>
>> I have spent the last couple of hours instrumenting the code of scrub.c
>> to try to work out what is going on. 
> 
> I was over-complicating it. The problem is simple:
> 
> In kernel 4.19, BTRFS_IOC_SCRUB fills in the (final) progress values in
> the scrub args EVEN WHEN THE SCRUB IS CANCELLED! If the errno is 125
> (and presumably most other values) the output arguments are valid.
> 
> In kernel 5.3, THAT IS NO LONGER THE CASE! If the errno is 125, the
> progress values are all 0.
> 
> This ABI change breaks btrfs-scrub -- in particular the scrub
> cancel-resume handling. This relies on the scrub ioctl reporting the
> progress values when the scrub is cancelled: those values are written
> out to the file in /var/lib/btrfs and read back in for the resume.
> 
> I haven't attempted to look at the kernel code to see why the behaviour
> changed.

This regression in btrfs-scrub is a kernel problem: the scrub ioctl ABI
seems to have been broken some time between kernel 4.19 and kernel 5.3.

Do we need to provide any more information? I am not in a position to do
a bisect at this point, but if it is not obvious what change has caused
the breakage I can try to do so later in the week.
