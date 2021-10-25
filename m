Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305A9439383
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhJYKVb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 06:21:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhJYKV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 06:21:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11E3A2177B;
        Mon, 25 Oct 2021 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635157140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwKvtU6HSukiwhPBwCuQfoZ74fATVV0RH9W7mo5XZO8=;
        b=uDzNWTyR/nHK0aGJm69Rg8cGnKJnzJR5TiMfxLx1CypP6Wfp/L+J9wAXyp9iRt6D6DJjga
        JG13ooTIlHXRzJi4slYL9DC1uPRwdU4M/AOt+UdpshmZkhP9JLZSvz6UlBIzP4NbyPYMHF
        YqCdsV3obV3tmhg0swPsylDFAHCgTwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C037A13A86;
        Mon, 25 Oct 2021 10:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uk3oKpOEdmHUcAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 25 Oct 2021 10:18:59 +0000
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
To:     Graham Cobb <g.btrfs@cobb.uk.net>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
References: <20211022145336.29711-1-dsterba@suse.com>
 <4f3f2444-66fd-5fa3-e078-b223a9bab5e3@suse.com>
 <86e14649-5d1a-4218-667d-fedb7dccac95@cobb.uk.net>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a7574a30-4a3c-8a30-2d7d-62910198b500@suse.com>
Date:   Mon, 25 Oct 2021 13:18:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <86e14649-5d1a-4218-667d-fedb7dccac95@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.10.21 г. 12:34, Graham Cobb wrote:
> 
> On 25/10/2021 07:48, Nikolay Borisov wrote:
>>
>>
>> On 22.10.21 г. 17:53, David Sterba wrote:
>>> This is the infrastructure part only, without any new updates, thus safe
>>> to be applied now and all other changes built on top of it, unless there
>>> are further comments.
>>>
>>> ---
>>>
>>> This is preparatory work for send protocol update to version 2 and
>>> higher.
>>>
>>> We have many pending protocol update requests but still don't have the
>>> basic protocol rev in place, the first thing that must happen is to do
>>> the actual versioning support.
>>>
>>> The protocol version is u32 and is a new member in the send ioctl
>>> struct. Validity of the version field is backed by a new flag bit. Old
>>> kernels would fail when a higher version is requested. Version protocol
>>> 0 will pick the highest supported version, BTRFS_SEND_STREAM_VERSION,
>>> that's also exported in sysfs.
>>>
>>> The version is still unchanged and will be increased once we have new
>>> incompatible commands or stream updates.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> I have a question about how this will work from the point of view of the
> sysadmin.
> 
> I have a number of different systems between which I need send and
> receive working. Some are stable machines - many using distro stable
> kernels. Some are new machines (most running debian testing but
> occasionally with a newer kernel for some other reason). Some are
> managed by other people and I don't control the kernel or progs versions
> or am even told when they change.
> 
> I need to be able to generate a send stream on any system and receive it
> on any other system. However, I don't want to be limited to just the
> very oldest version of the protocol: for some tasks I am willing to take
> into account the target system capabilities when generating a send
> stream for that task.
> 
> So, I think what I need is:
> 
> 1) A mechanism to query a receiving system to find out what protocol
> range it supports for receive (taking into account *both* kernel and
> btrfs-receive capabilities). And when I say "protocol version" I mean
> feature level - the reported "version" must define not just encodings
> but also what capabilities it can handle.

Receiving is handled entirely in user space by btrfs-progs so that way
it's easier to upgrade the receive side. The send stream is generated by
the kernel. Regarding the report capabilities it would be an overkill to
also report capabilitiee because eventually we'd run out of usable space
in the existing ioctl and we'll have to simply add _v2. Instead I think
we should stick to version numbers and documenting the capabilities in
release notes out of band.

Having said that current proposal (that is Boris' patches in the ml) do
propose to also add flags in addition to send stream version switch
which allows for scenarios such as:

"Use v2 protocol stream which implements fallocate/setflags and
optionally encoded read/writes", so the "support encoded read/writes"
would be predicated on the protocol version AND the feature toggle.
However I'd like some rationale why we want this flexibility, because
all of this just blows the test matrix and maintenance burden.

> 
> 2) A mechanism to select what protocol version (in the sense above)
> btrfs-send should use in the stream (again, kernel and user space).

That's already there in the proposed patches which implement v2 that is
btrfs-progs is going to have a command line option to instruct which
stream version to use.

> 
> 3) **Preferably** filesystem features on the sending side which require
> protocol features outside the selected range would be emulated using
> features in the earlier protocols. If that cannot be done,
> **definitely** abort the send and report an error. If the send completes
> without error the stream must be within the specified protocol range and
> work on a receiver which claims to support that range.

I'm failing to parse this? We shouldn't be having fs features which are
outside of the selected protocol version, that's the whole idea of the
protocol versioning.

> 
> That way, I can check which version the receiver supports (maybe in a
> script in real time or maybe as a config option I change when necessary)
> and generate a send stream which it can use. And if I can't do that, I
> get a clear error. I would also be able to request tools like btrbk to
> use this information when taking snapshot backups.
> 
> I am not sure I can do that with the mechanisms being proposed here. Am
> I missing something?
> 
> Graham
> 
