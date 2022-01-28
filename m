Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99849FE01
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiA1QZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 11:25:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45415 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbiA1QZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 11:25:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5440F5C0107;
        Fri, 28 Jan 2022 11:25:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 Jan 2022 11:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=Wpmu+nVTmUlia0
        7RCCdWefHXqSvC0i3YjoXufJr7zE8=; b=hHMKFsHjsXpeojWEms9fB2sXOQ4b9P
        WT7EGQhNvP/LAQrPlleUc4pIctc3Ke6/JUs5pA9a3MspuLyTmUf9nFJ8Qzyu7bk/
        DbKmLqY+kxvPTZraCriXeZlQ7ftab/+mFp0CYAvrMBXNTMe5GR1NyFjbFYqvrNTT
        AF0UNqQd70w4UDAl0y32AoP+hGhjGEQkWwSUAe/rQx09Qm2WV9btaKrKHobIf0lm
        Pyn7/IfOg7Hxnas13EEecS3fx0DGFh3rSe5HkuHEGtHp9f83zwaBmiqqzWH8nNUW
        GuT3k4lRXIaFx8NJMsSNjnuqz9OLZUyLl5q0rgS4iuA63Nj4ubhQv+XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Wpmu+nVTmUlia07RCCdWefHXqSvC0i3YjoXufJr7z
        E8=; b=MvVC5dedkpEgHrRH/sNcAnCsnG6eG5DmaQXu5fDCDuRvD/KrXqwKVU26x
        MpU2x2UE4uhQ0cBKf1aB5TZeusBI8+WsgO+Sw+AEirmPxs9tV3mi2VmXzCpfE9nC
        px4s+YFtK2fdb8aCMnp+ESuZJlfXmY4f++tBbyTvHlrVRqZirimc1BeEL+7ybqfH
        CZfOgqslyl1BdTYU6VJkWH81KcGfx6Hfsj6W6S7BF3P+zTybVxOZbOeogfpT7c0h
        X2dqxzm0YK//uARyXk8o3f9jX4BvedPvZ/WyH6I2yovlxYxwETLDgVkhDIqgEWgi
        I0ZknpJfuu/p5jUiJj6mD6gxeY4pA==
X-ME-Sender: <xms:Dxn0YT8NsYyMdSOfSxWkdPqLJTIMRx7wD81CpYcOuW-reKO4ktgPqg>
    <xme:Dxn0YftZUxlrAnlvibvvR4SBQ9DyOYLCen6c1zF0w2xtNSLoB9F7MjkZZBar1MpwL
    DALf-gsAVV4tckzQQ>
X-ME-Received: <xmr:Dxn0YRAqGUB7wBWfqkpvJ6t56FxPNhxG-9B_cF2WOJMnFmBO6Vm1S7s0DjmJLvsiOLIQlHgmsRl4uYLqMNtqqHp-fq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepvfhfhffukffffgggjggtgfesthekre
    dttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeehjefhteduudfffffgudehieevtd
    elkeffledukefhheehffeugfeggeekjeeiudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:EBn0Yfe0JNLM5o-u25Jq_vALZaO6L4J8OVRdhYfeSqh-9TewOlAYVw>
    <xmx:EBn0YYO7LraRey1M3PPJ2feu7ZWhZU0ciPXaBhhe6rzcu-ra3RXVSw>
    <xmx:EBn0YRklCIbVPXZqRZm_-2_eD7EjDkuy-tU_0Io8mtezbX--Ig-1mQ>
    <xmx:EBn0YS3IKo-QkapVEuXDNmURPUOj9QzVYwH3mJNfPiNDatrSDNhzcQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 11:25:51 -0500 (EST)
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>, piorunz <piorunz@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Message-ID: <5e538d4d-e540-0dfd-0ad6-286bbe5739e8@georgianit.com>
Date:   Fri, 28 Jan 2022 11:25:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-28 6:55 a.m., Kai Krakow wrote:

> Yes, it will. You could run the bees daemon instead to recombine
> duplicate extents. It usually gives better space savings than forcing
> compression. Using forced compression is probably only useful for
> archive storage, or when every single byte counts.
> 
>

I have also found compress-force  (with lzo) to be very beneficial for
SATA SSD's.  Not only does it improve the sequential read speed, but
forcing the smaller extent size makes it easier to reclaim space lost to
fragmentation.

I found that heavily fragmented files, (with no snapshots or reflinks.)
could take almost 2X as much space as the file size unless they were
defragged with a large (100M) target size, which causes senseless wear
on SSD.  With compress-force, autodefrag (or manual 128k defrag)
alleviates this issue.

Conversely, compress-force on HDD completely destroys any semblance of
sequential read speed.



