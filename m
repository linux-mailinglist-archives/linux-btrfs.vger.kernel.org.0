Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C0439299
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhJYJmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhJYJmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:42:10 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4168C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 02:39:47 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 512449B6F5; Mon, 25 Oct 2021 10:39:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1635154784;
        bh=ttnAvLHLhj6CMCzsdMlpSfHIrA3nYpveBF8uy5oxzWI=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=oBuHtHHL1D3MjzAI031Ov44r2gRURQpWiXz3sr5U6c2hOrOc9Qn62vsWQLOqDp3IP
         3IbhOxOjEp/S5YKK+b7a1AeQKK88CqsjTNo/zChWqtnnAu1tBpo1pswOoHERV/tZpf
         Qwz4UZ4YK3tV8EAGiT4GWYU6d5XII3ax69jExDZm9ic+irJ48bcLUQGWYYd3INk0Gm
         fRyS2J89b5bHyeUHUYSUUhu6f6owLY5dGC2FknJdZArcTvKWqVK0MXb+Dzbq8OPrsQ
         6FqqIgVblIb701dndyD6DAXm2f4w/ns1WXc0Z1WeblBfJc+Xh/MJEO+rSeyZXynLRq
         Ug0N4iNAaXOOQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.7 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 5A2FB9B6F5;
        Mon, 25 Oct 2021 10:34:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1635154483;
        bh=ttnAvLHLhj6CMCzsdMlpSfHIrA3nYpveBF8uy5oxzWI=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=YNfKGVnBrE1OKIgdbiAnmXimrx0wqVJs74F5ZmJhJGCXZGfDs7/sxREPMXWLu2bjJ
         Ao3m6GQE63qJR8RLK66LgyGo4k51TbBJtkbmyS6v+LANJbtPxhq1Ji5zin8PsA/jnu
         C1KeWwvvLNG+E27Mz6d9VDQOvtEjc2r0ZBKdF9YEP0nLwlqO65uvEFBhvvr3sU7HsA
         zqf2nspneHarReudsXrxVbq9hTn96e1f+5HfqawtdFEXX3gIr2ediY4hDkQ+JKEKMW
         VzsA4vQo83fXUgCFoieAutalYfPlIkrqTWg9XgLn3vvm2+QaDOLENj8OYjCnTqDoMU
         3PPR9FXJinRZg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 259382B3D61;
        Mon, 25 Oct 2021 10:34:43 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
References: <20211022145336.29711-1-dsterba@suse.com>
 <4f3f2444-66fd-5fa3-e078-b223a9bab5e3@suse.com>
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
Message-ID: <86e14649-5d1a-4218-667d-fedb7dccac95@cobb.uk.net>
Date:   Mon, 25 Oct 2021 10:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4f3f2444-66fd-5fa3-e078-b223a9bab5e3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 25/10/2021 07:48, Nikolay Borisov wrote:
> 
> 
> On 22.10.21 г. 17:53, David Sterba wrote:
>> This is the infrastructure part only, without any new updates, thus safe
>> to be applied now and all other changes built on top of it, unless there
>> are further comments.
>>
>> ---
>>
>> This is preparatory work for send protocol update to version 2 and
>> higher.
>>
>> We have many pending protocol update requests but still don't have the
>> basic protocol rev in place, the first thing that must happen is to do
>> the actual versioning support.
>>
>> The protocol version is u32 and is a new member in the send ioctl
>> struct. Validity of the version field is backed by a new flag bit. Old
>> kernels would fail when a higher version is requested. Version protocol
>> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
>> that's also exported in sysfs.
>>
>> The version is still unchanged and will be increased once we have new
>> incompatible commands or stream updates.
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
> 
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

I have a question about how this will work from the point of view of the
sysadmin.

I have a number of different systems between which I need send and
receive working. Some are stable machines - many using distro stable
kernels. Some are new machines (most running debian testing but
occasionally with a newer kernel for some other reason). Some are
managed by other people and I don't control the kernel or progs versions
or am even told when they change.

I need to be able to generate a send stream on any system and receive it
on any other system. However, I don't want to be limited to just the
very oldest version of the protocol: for some tasks I am willing to take
into account the target system capabilities when generating a send
stream for that task.

So, I think what I need is:

1) A mechanism to query a receiving system to find out what protocol
range it supports for receive (taking into account *both* kernel and
btrfs-receive capabilities). And when I say "protocol version" I mean
feature level - the reported "version" must define not just encodings
but also what capabilities it can handle.

2) A mechanism to select what protocol version (in the sense above)
btrfs-send should use in the stream (again, kernel and user space).

3) **Preferably** filesystem features on the sending side which require
protocol features outside the selected range would be emulated using
features in the earlier protocols. If that cannot be done,
**definitely** abort the send and report an error. If the send completes
without error the stream must be within the specified protocol range and
work on a receiver which claims to support that range.

That way, I can check which version the receiver supports (maybe in a
script in real time or maybe as a config option I change when necessary)
and generate a send stream which it can use. And if I can't do that, I
get a clear error. I would also be able to request tools like btrbk to
use this information when taking snapshot backups.

I am not sure I can do that with the mechanisms being proposed here. Am
I missing something?

Graham
