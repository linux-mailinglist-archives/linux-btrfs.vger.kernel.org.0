Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EB439823
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhJYOLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhJYOLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 10:11:16 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8DC061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:08:53 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 341499BB3C; Mon, 25 Oct 2021 15:08:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1635170931;
        bh=0dNnVMr1QbznVxa156TyGrD4zOzwQZQH63u+sorqRcY=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=SsqjdlVSAKZVbj/WB5tYchbntJqUlsa3f7ig50aUdw/HfKVYn6pMjTkRiPAp68nPI
         2DD/CQgh2W8qD/nL85NE3sOBSvBX1L0Vtyt5GLeGxte7tJXgJn6rfZxR33BN3Iu33Z
         cGJFRGHh7NCprKCFsGuvPfsuvfo3p8XmcgMWYaj5vyzeMIuY4S9DefVZYIy+F3J5AI
         Rme7bNPk2jeuaL2NkOM6h9REhpoYCeC90ZTU81yl2UEv4ZH6WPORD8mHU7aaNsb9gE
         P13DDkBc6WffpRrjRDxMEY6FwOJ9z4mWVLXjkdKBV5D/yFN68sJLQWEJKDWKJ9+L61
         rkEKFWLGNt/vg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-7.7 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id E8D029B984;
        Mon, 25 Oct 2021 15:08:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1635170887;
        bh=0dNnVMr1QbznVxa156TyGrD4zOzwQZQH63u+sorqRcY=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=XMJvQ6DV8pFJMDsRu4RfAKRG+EhmVOJMXQZH5WAfIipf2T/G+SIhg15BP5XxkiQn+
         vr1tvnTLDShuUazb6tQNr1/wMWYr/S0+2t4AWR+aYfckWTJVoC2tTKJtIVcuWYl8d3
         wi4DZmplJNy9mVW5H3hWgaUsleGvUB3iYhMHK9HG5y9Vsjd5D8RrJmmKpXEoyVePaK
         rzs5uJm49ttKVskU1bLvf8VlNvvOw22meTFtM0aERz9hk84Ow8bCbgpDEBZAF1SA5y
         Hpf4GAnD4OLrDiXcnRiElkq4cqiOiLEtAHS/s/xtfspNR3Y1a/kJT4mxl93b4YzGrG
         LAfaLR7/N6dxg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id B1C222B3E6A;
        Mon, 25 Oct 2021 15:08:05 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
References: <20211022145336.29711-1-dsterba@suse.com>
 <4f3f2444-66fd-5fa3-e078-b223a9bab5e3@suse.com>
 <86e14649-5d1a-4218-667d-fedb7dccac95@cobb.uk.net>
 <a7574a30-4a3c-8a30-2d7d-62910198b500@suse.com>
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
Message-ID: <1b59b56d-815b-c8b5-2bc0-0739e05ae427@cobb.uk.net>
Date:   Mon, 25 Oct 2021 15:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a7574a30-4a3c-8a30-2d7d-62910198b500@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/10/2021 11:18, Nikolay Borisov wrote:
> 
> 
> On 25.10.21 г. 12:34, Graham Cobb wrote:
>>
>> On 25/10/2021 07:48, Nikolay Borisov wrote:
>>>
>>>
>>> On 22.10.21 г. 17:53, David Sterba wrote:
>>>> This is the infrastructure part only, without any new updates, thus safe
>>>> to be applied now and all other changes built on top of it, unless there
>>>> are further comments.
>>>>
>>>> ---
>>>>
>>>> This is preparatory work for send protocol update to version 2 and
>>>> higher.
>>>>
>>>> We have many pending protocol update requests but still don't have the
>>>> basic protocol rev in place, the first thing that must happen is to do
>>>> the actual versioning support.
>>>>
>>>> The protocol version is u32 and is a new member in the send ioctl
>>>> struct. Validity of the version field is backed by a new flag bit. Old
>>>> kernels would fail when a higher version is requested. Version protocol
>>>> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
>>>> that's also exported in sysfs.
>>>>
>>>> The version is still unchanged and will be increased once we have new
>>>> incompatible commands or stream updates.
>>>>
>>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>>
>>>
>>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>
>> I have a question about how this will work from the point of view of the
>> sysadmin.
>>
>> I have a number of different systems between which I need send and
>> receive working. Some are stable machines - many using distro stable
>> kernels. Some are new machines (most running debian testing but
>> occasionally with a newer kernel for some other reason). Some are
>> managed by other people and I don't control the kernel or progs versions
>> or am even told when they change.
>>
>> I need to be able to generate a send stream on any system and receive it
>> on any other system. However, I don't want to be limited to just the
>> very oldest version of the protocol: for some tasks I am willing to take
>> into account the target system capabilities when generating a send
>> stream for that task.
>>
>> So, I think what I need is:
>>
>> 1) A mechanism to query a receiving system to find out what protocol
>> range it supports for receive (taking into account *both* kernel and
>> btrfs-receive capabilities). And when I say "protocol version" I mean
>> feature level - the reported "version" must define not just encodings
>> but also what capabilities it can handle.
> 
> Receiving is handled entirely in user space by btrfs-progs so that way
> it's easier to upgrade the receive side. The send stream is generated by
> the kernel. Regarding the report capabilities it would be an overkill to
> also report capabilitiee because eventually we'd run out of usable space
> in the existing ioctl and we'll have to simply add _v2. Instead I think
> we should stick to version numbers and documenting the capabilities in
> release notes out of band.

That sounds OK - if the commitment going forward is that btrfs-receive
can always handle any stream of a certain version, and all previous
versions then all I need is an option for btrfs-receive which prints
that protocol number. I need to be able to do something like:

send_version=$(ssh target btrfs receive --version)
btrfs send --version="$send_version" | ssh target btrfs receive

> Having said that current proposal (that is Boris' patches in the ml) do
> propose to also add flags in addition to send stream version switch
> which allows for scenarios such as:
> 
> "Use v2 protocol stream which implements fallocate/setflags and
> optionally encoded read/writes", so the "support encoded read/writes"
> would be predicated on the protocol version AND the feature toggle.
> However I'd like some rationale why we want this flexibility, because
> all of this just blows the test matrix and maintenance burden.

And makes it impossible to use in practice - the sender needs to know
what capabilities to use when generating the stream and needs to know
that the receiver will be able to handle them.

BTW, my background is networking. In the networking world we do protocol
versioning and negotiation all the time. Capabilities **can** be used
but, in practice, only when there is a real-time negotiation going on
(and they are an optimisation - not necessary for correct operation). Of
course, the design of btrfs send/receive makes it impossible to do a
negotiation so we need a mechanism for the sysadmin to perform the
"negotiation" out-of-band using command options.

>> 2) A mechanism to select what protocol version (in the sense above)
>> btrfs-send should use in the stream (again, kernel and user space).
> 
> That's already there in the proposed patches which implement v2 that is
> btrfs-progs is going to have a command line option to instruct which
> stream version to use.

That is fine as long as there are no optional capabilties in that
version which the receiver might not implement.

>> 3) **Preferably** filesystem features on the sending side which require
>> protocol features outside the selected range would be emulated using
>> features in the earlier protocols. If that cannot be done,
>> **definitely** abort the send and report an error. If the send completes
>> without error the stream must be within the specified protocol range and
>> work on a receiver which claims to support that range.
> 
> I'm failing to parse this? We shouldn't be having fs features which are
> outside of the selected protocol version, that's the whole idea of the
> protocol versioning.

I am mostly thinking of capabilities. Like, for example, an option to
send compressed data still compressed or to send it uncompressed if the
receiver doesn't implement storing compressed data (or the required
compression algorithm). But also if there is some new btrfs feature in
use which cannot be expressed in the (earlier) version of the protocol
which has been selected.

In short, the "version number" (actually it should be a range - like
"2-5" - in case V1 support has to be dropped by some receivers later on)
reported by a command line option on btrfs-receive must provide a
guarantee that any (valid) stream of that version number can be received
(not dependent on other things - like kernel version, compression
modules loaded, mount options, etc).


