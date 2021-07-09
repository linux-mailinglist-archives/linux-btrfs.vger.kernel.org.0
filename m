Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E53C1C61
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhGIAIF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhGIAIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 20:08:00 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80829C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 17:05:17 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 8FAA09C351; Fri,  9 Jul 2021 01:05:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1625789111;
        bh=jWa2hI0dizCsfEGW6vVAQ95lDFvgo6TiN+tPSMr+Tvs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=SNoB8nBUCDvqItz8K7ZYNDIdWj6k+InDK5jsc4OoCWVmktOVHLLxIMEWWO1o1fUtR
         esCt57LMTJeLEjrIaz6W3ZYoxop1sEeCY/Gn3hsCpZOi1A0mHPNmA003M1+MGzlsA5
         1lIQZ0vCSJjhzPvpLJJFKWukvZFlK2IEpJA8d0cMkFmWVkfH/rzLa9HKdOaMPyL0UT
         1FaTuS8y+cWCkDKI5Y2zjysHRFSDHS+5s9zGtrth9npedYE/73CAT7zUH98SLXcIrU
         /eN8M5I/h7gEwSbn1zhADNsgwrxRksUkgFGEveQapBLhY5FXk8nW2oYqbXY3CnYNKg
         k58KD+fxkB0zA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 8E41C9B97A
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 01:05:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1625789109;
        bh=jWa2hI0dizCsfEGW6vVAQ95lDFvgo6TiN+tPSMr+Tvs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=ZJlwr2QMTto44wJBqrNPCaUq2Ckv1I8NX4uLUPJtdftQ/dAQ3jge0oqF0RofwXGtD
         Tqd95hg//9kBenLjlT1LnPFV6eywI8LrBkEB0bd8hiS9gni/29zDXcXB03vNWXdIi5
         5e/tOh8/38qsLZgjV9eWYy3WLXKES6Wl6qPTkQ7vQXqSlkr7uvr8ERlbwXpzZOW1H9
         6Ua7UO/SrbR2M1I0JEC7RvejsY6mzP/NtgsrcOqW5iymN0xrrdkrIYJttlFmxhcEXs
         5T7ynCqpKrv045dekjJnG+d5fiJmNb4oQNCxpxi7mYAj65kTLi7kJzUya1KjR14L30
         8IekdyB5kGwAw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 527AE26D695
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 01:05:09 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
Date:   Fri, 9 Jul 2021 01:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708221731.GB8249@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/07/2021 23:17, Ulli Horlacher wrote:
> 
> I have waited some time and some Ubuntu updates, but the bug is still there:

Yes: find and du get confused about seeing inode numbers reused in what
they think is a single filesystem. However, the filesystems are not
actually corrupted, and all normal file and directory actions work
correctly. The loops and cycles are not there - but find and du can't
tell that.

I use NFS mounts of btrfs disks all the time and have never had any real
problem - just find and du confused.

You can eliminate the problems by exporting and mounting single
subvolumes only - making sure that there are no nested subvolumes
exported, or that the subvolumes are all mounted individually.

> This makes btrfs with snapshots unusable as a nfs server :-(

No, it doesn't. I use it ALL the time: my main data lives on btrfs
servers and is exported to the clients. I use tools like btrbk and
btrfs-snapshot-aware-rsnapshot on the server and then access those btrfs
snapshots from the clients over NFS as well (for example to retrieve
accidentally deleted files). You just have to be careful with subvolume
structure and what you mount where. And I recommend only using find and
du operations on the server, not the client.

> How/where can I escalate it further?

Try complaining to NFS. It might be that it would work better if NFS
assigned different NFS filesystem IDs to each subvolume - I don't know.

