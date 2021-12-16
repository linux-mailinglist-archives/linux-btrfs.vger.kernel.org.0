Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B7476ECF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhLPKZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 05:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhLPKZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 05:25:03 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F2C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 02:25:02 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 518829BB43; Thu, 16 Dec 2021 10:25:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639650300;
        bh=GXbtyW+5JRE2OXssvoUdWwwkg8jJbmaWzouNbQNcD40=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=aNgp2x+o/iQUr+XUS7MPk2drAQl3VaWAeQgf2QKn/4dA4ydELtGqC9RSBaiFYUuu/
         RjpbcT931B5poylXwaERH2yxIFfEQfFBxBTr7htBOq/l6o17QeSv5XJKySy95z3zig
         6Rsp+0RArXPtX9JTJqqOIroP7A9ePMIOTgW7KCsAVREVjWqQUWdms5SfdOUaeInDES
         S8++mCTL+wBSr6OkNzBZqEH1DquBbZWVwjCvplgrkiFkc0wb2UmQZbUDoHao0H6jBr
         bNRhWsYBHCL4A6B4OyHRfNkBpFJE6rdKA0RxogKVFNnm8GquryTQTy61tR2zMd4q7u
         lWC8PtlihWoJg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id B6D4F9B86D;
        Thu, 16 Dec 2021 10:24:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639650249;
        bh=GXbtyW+5JRE2OXssvoUdWwwkg8jJbmaWzouNbQNcD40=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=KTQPpmgrELWQ5V5A+UHw5WBOQaGZgJ++MNkTCgOlsnpNuXApc9XQXQS7net8AObRP
         W7ZfBi3bqt1rhe9uP51ddpY7vXFb5tHuzVoptwMo5iljQJeeRXcryI0N2B6sENhmyn
         BWh+CI14ZELqJz5RpbMDf66E3Ptr5kBV/vW68rXoC/ph80ir2uaP85UbqiZu/58HAZ
         cmfE4fhonfLijFBDwvNpu+8H2Z2eTnLzlKBNZsoJ3KYu3hHwCdkKH0RVqu/THon8NN
         VjTBxWve/B3mA4vdDDHdWNtRk8FLq7SLbADiSVFy9eXXAWk2bGEqJkHh448H8+oHqJ
         +epcjlc26iOqw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 784D72D6621;
        Thu, 16 Dec 2021 10:24:09 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
 <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
 <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
 <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
 <70553d13e265a2c7bced888f1a3d3b3e65539ce1.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
Message-ID: <e479561d-98be-5da2-4853-e697eb9690b3@cobb.uk.net>
Date:   Thu, 16 Dec 2021 10:24:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <70553d13e265a2c7bced888f1a3d3b3e65539ce1.camel@ericlevy.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/12/2021 01:13, Eric Levy wrote:
>> Later you snapshot /data again to create /data-2 on the source
>> system.
>> You btrfs-send /data-2 to the other system again and it creates a new
>> read-only subvolume - you tell btrfs-receive what to call it and
>> where
>> to put it, let's say you call it /copy-data-2 - using the data in the
>> stream and reusing some extents from the existing /copy-data-1.
>> /copy-data-2 is now a (read-only) copy of /data-2 from the source
>> system.
>>
>> How you use that copy is up to you. If you are just taking backups
>> you
>> probably do nothing with it unless you have a problem (it will form
>> part
>> of the source for data for any future /copy-data-3). If you want to
>> use
>> it to initialize a read-write subvolume on the destination system you
>> can take a read-write snapshot of /copy-data-2 to create a new
>> subvolume
>> (say /my-new-data) on the destination system.
> 
> Such is close to what I have always understood about receive, but the
> confusion is that the second receive command makes no reference to the
> subvolume created by the first command. How do I ultimately create a
> restore target that combines the original full capture with the
> incremental differences?

It's just magic. Seriously, as long as you have already restored the
parent (and any clone sources, if you have specified those) to the same
filesystem, btrfs will find them and clone the necessary files into the
new subvolume.

> 
> When I ask how I use it, I mean what commands do I enter into the
> system.

Assume subvolume called /data.

On the sending side...

btrfs subv snapshot -r /data /data-1
btrfs send /data-1 -f data-1.send

Later, to generate the incremental stream from /data-1...

btrfs subv snapshot -r /data /data-2
btrfs send -p /data-1 /data-2 -f data-2.send

When you want to restore...

btrfs receive -f data-1.send /recv-data-1
btrfs receive -f data-2.send /recv-data-2

If you want read-write access to the data you need to create a new
subvolume...

btrfs subv snapshot /recv-data-2 /new-data

[I haven't tested these so sorry for any mistakes - hopefully you get
the idea]

> 
> Note in my case I archive the streams into regular (compressed) filesm
> for later recovery.

I considered doing that but I don't recommend it. The biggest issue is
that you have to keep all the incrementals since the last full backup,
as all the steps must complete in order to restore. This means that if
something has gone wrong with the archive (even a single bit corruption,
or an unexpected truncation) all the incremental streams after that
point are useless. btrfs receive doesn't have a "try hard" mode - it
will just fail unless all the sources it needs, and the stream it is
processing, are perfect. And you don't know, unless you do regular test
restorations.

In the end I decided I would keep the archive subvolumes themselves, not
the streams. Even in the worst case, this takes very little more space
(assuming you have turned on compression) - after all the cloned data is
still cloned. And even if something has been corrupted you can still get
at undamaged files in the various subvolumes. And if you make sure that
each send stream is only using the directly previous snapshot as its
clone source, you can remove any older snapshots that you like without
making later subvolumes useless.

Once I decided that, I ended up using btrbk - which makes a good job of
managing the backup and archive subvolumes, on both the source system
and the destination system. Of course, many other tools are available.

