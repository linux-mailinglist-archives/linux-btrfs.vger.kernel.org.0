Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF89333FD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 15:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhCJOBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 09:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCJOBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 09:01:12 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A3C061760
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 06:01:12 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 77E0E9C1C4; Wed, 10 Mar 2021 14:01:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1615384868;
        bh=9DEYCe/wUbSlZXDsNFwV7+Qaa/K6tFFlLd75BSu45qs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=oGrp0dA4qe0u837hVuOlnZ0HpM60fySiFYd5fZ5lLU0c7wwLUUa2sPFdUPeOXkcWQ
         LAXDMDd3emAaARBcrGjVbUy7iWs348JgLxEhmwLNpuQQ+eGqVvfLrQ+Hu50A3KydiS
         +2Wy0Xb4ewVoETzJfrvctWqdtfTJ5EFYQGdnt/MfPfJj9QpdCuWmFt1g37w/+63jSS
         S9gwMF8Pj8qmjMSwfBKEddjA+rLK/QL7hGx3Jqtm0eaZ80HU223pLyK3BSHD0hZg/f
         pn0wVWlW8UHNIMA6d1Swbq1XRyaQNR/0oJbUOQd4iw9Zn8p+JB1mx/zFiA7m3KbWM+
         4srrjLWfgcJdQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id EEC499BA17;
        Wed, 10 Mar 2021 14:01:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1615384862;
        bh=9DEYCe/wUbSlZXDsNFwV7+Qaa/K6tFFlLd75BSu45qs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=FHUW7HFQP8yaNElN1y5XAsq28X18+rpg2U+qB1ZdK9s9J3h1R8jCgD+ZH3FnF+vu8
         GzFHy8/H4j5VIVTL/YvcCi+KDVUO9o3HjINxQvXRv5fJXs4Q4/FI0cI/JFKIhth7Yv
         a2sPWM5xEJi1tKskLfWQDuZ93xiBV0sg8i2CnSjt5LMYqlPbpIrMT5DCTxhLWHmv0+
         OFiY7txG1sA2Ogpy3WndMasFJEot1yclDr+14O59JYLvmDHFBRI6YuNjwXE5VOO/Gy
         3wff5AY1oF8S6mU/YydNU4K9B6J6l8uJlxmmdRHHM7ibOUC2C+t43S/q6CXHmRWYVm
         PtUR0UvOAhpGA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 9452120FA3A;
        Wed, 10 Mar 2021 14:01:01 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     telsch <telsch@gmx.de>, linux-btrfs@vger.kernel.org
References: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
Subject: Re: no memory is freed after snapshots are deleted
Message-ID: <3f1ef2ea-04db-479d-d1cd-f64892de6ef1@cobb.uk.net>
Date:   Wed, 10 Mar 2021 14:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2021 12:07, telsch wrote:
> Dear devs,
> 
> after my root partiton was full, i deleted the last monthly snapshots. however, no memory was freed.
> so far rebalancing helped:
> 
> 	btrfs balance start -v -musage=0 /
> 	btrfs balance start -v -dusage=0 /
> 
> i have deleted all snapshots, but no memory is being freed this time.

Don't forget that, in general, deleting a snapshot does nothing - if the
original files are still there (or any other snapshots of the same files
are still there). In my experience, if you *really* need space urgently
you are best of starting with deleting some big files *and* all the
snapshots containing them, rather than starting by deleting snapshots.

If you are doing balances with low space, I find it useful to watch
dmesg to see if the balance is hitting problems finding space to even
free things up.

However, one big advantage of btrfs is that you can easily temporarily
add a small amount of space while you sort things out. Just plug in a
USB memory stick, and add it to the filesystem using 'btrfs device add'.

I don't recommend leaving it as part of the filesystem for long - it is
too easy for the memory stick to fail, or for you remove it forgetting
how important it is, but it can be useful when you are trying to do
things like remove snapshots and files or run balance. Don't forget to
use btrfs device remove to remove it - not just unplugging it!

