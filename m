Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA476731
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 02:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhLPBAr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 20:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhLPBAr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 20:00:47 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F63C06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 17:00:47 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 06A069B800; Thu, 16 Dec 2021 01:00:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639616444;
        bh=n3nIOu0EfJnYAzPkkRZ+QRd8UWmnjWTMXIk5YsFMdLQ=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=kU6cIoPGK7yd5d+RFUw8vHQtu7EVtyQNaOet1TlGHxVzAkXZ816XujdCdH7uSdZdk
         1FRl1GSOZg+SLJ4GGr2+wO8qLvggg8qaHFjN26hHISNoK8iqn63eJaE9aybiaDWcgd
         fh/MBHGTGWa7NZcio6HwOuJ4avg7vQ2tDhE2iOsoScxtstiVmkxCde0eG6WT/4+9bs
         f6WeOX7ndqQMS4qA2ms40vpLVYjYMpFbzWrKYvBmNXypIugWmTr5CfyCdx6Spd9IB8
         1Pdsy/i6WIIAqHazIT1wH6zu/9+c1wpOLndue/p+bwULZ1oq529XFOu0Fw4EQyUuYk
         Wy5FZYMxD51uw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.5 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 13DF49B800;
        Thu, 16 Dec 2021 00:55:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639616143;
        bh=n3nIOu0EfJnYAzPkkRZ+QRd8UWmnjWTMXIk5YsFMdLQ=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=v/xG7O2PDrvubhTypxwCEd6R43zL4A47kDHZSpTX5fXp8Jh4zCUnENvk+Npdh/V93
         MVlBQPmzrU0vzkYe01OR+1KVhHIswQduXtzRnRgBfBFTwyNw4MJtGP4u+KfrMBwF6j
         XkEDua2ASxhAr+st6p3W9/RHYn/vAdjvjMdI+Wxlok6yxHkXUlNKASL2hCuMxMqJ6V
         gq9brVNAeFM7qwLIXvd+/2BkG+DySUnoo5HlKVDgTr8BeVgDUHmzyeWxRa1fI8ajOF
         683w75s5LGJVI7nFbDRUWdevdiH6Rgr7ndxJJMg98Bt6UxDcFp1NoBBQXtd4UO7txt
         +ejyOwbvkH6ug==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id C77322D63C1;
        Thu, 16 Dec 2021 00:55:42 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
 <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
 <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
Message-ID: <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
Date:   Thu, 16 Dec 2021 00:55:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 15/12/2021 23:52, Eric Levy wrote:
> Thank you for the reply. Please see my questions, below.
> 
> On Wed, 2021-12-15 at 23:35 +0000, Graham Cobb wrote:
> 
>> There is no such thing as an incremental stream. Send sends all the
>> information necessary to create a subvolume. Some of that includes
>> instructions to share data in other subvolumes but it is not
>> incremental.
> 
> Perhaps you would clarify the distinction, as to me an incremental
> backup is a minimal set of data needed to recreate the original volume
> when combined with the previous capture.

Maybe it isn't a real difference. I mean that the stream is not intended
to make **changes** to an existing subvolume to create the new version.
It is intended to **create** a new version, reusing some of the extents
from the earlier version (but, not changing the earlier version at all).

> 
>> You don't. Receive will create a new subvolume - which will include
>> unchanged data from the initial stage and whatever changes have
>> happened. If you want, you can then snapshot that (read-only or
>> read-write as you wish) into any position you want in your
>> destination
>> filesystem.
> 
> How should I use the latter stream? From the stream length it is
> obvious it does not contain most of the data from the earlier one.
> 

Imagine you have a subvolume called /data on the source system. One day
you snapshot it to create /data-1. You then send /data-1 to the second
system to create a read-only subvolume on that system - let's call it
/copy-data-1.

Later you snapshot /data again to create /data-2 on the source system.
You btrfs-send /data-2 to the other system again and it creates a new
read-only subvolume - you tell btrfs-receive what to call it and where
to put it, let's say you call it /copy-data-2 - using the data in the
stream and reusing some extents from the existing /copy-data-1.
/copy-data-2 is now a (read-only) copy of /data-2 from the source system.

How you use that copy is up to you. If you are just taking backups you
probably do nothing with it unless you have a problem (it will form part
of the source for data for any future /copy-data-3). If you want to use
it to initialize a read-write subvolume on the destination system you
can take a read-write snapshot of /copy-data-2 to create a new subvolume
(say /my-new-data) on the destination system.
