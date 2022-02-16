Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F04B86BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiBPLeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 06:34:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiBPLeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 06:34:16 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282D1B78A
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 03:34:01 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id DE69E9BD1E; Wed, 16 Feb 2022 11:33:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1645011237;
        bh=jrvU1bvLDq21EWtvy5xpDBSxaoO3QUFyY/zndJkj1Cc=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=uwc2nUACL1kFOWHOQ49qA+sgXt3945+lFJfBfro3L4qRwxb3BYX6gYzI6KAnZ7TCc
         0PYaKUHKqiDEjo7chDfCNC/B7zlJG7A8bPenNRgmkkhU7hXgTLAadBCSwHgJ3bhFZb
         6Rr9MtUq2kVi8sGnR1quX7XZG87nqWTSKSW9xSYHL2rvDpPg6kciMn7WjzZtC1qLiq
         ixmsKLQmsQTm9W+FS7gINmfJpWPxr4Cwn15JW34nuCDYtouTYuVI/3nJTLda88JNff
         rO874ycA6RCPLBHIV1yxaXXpDYk3095FatCG/NyhjPcf42ubDBQ0TNs+Rcfjeoj6Ew
         slnAuBC+yD1rw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 042BA9B6F5;
        Wed, 16 Feb 2022 11:33:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1645011210;
        bh=jrvU1bvLDq21EWtvy5xpDBSxaoO3QUFyY/zndJkj1Cc=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=RNEK764OcwFDxgf7ZhaFCV3ntMuMOfbtsoZvKLWQ+hseQGMcb+SpLztlCZz42XLo6
         RpjtqMRIDKZChpEeI0Re2kF3eh5n4pBAlYfW3TNASmrkYkyikSZX3Va3rYzsMuQ1jc
         G7BYH82ET+u2GALWjDGtd+zKZngGlWRhwpm4g7fUEK/Rq5ip7j1epbaKPDbhRl9f4d
         482W8qJdLMjCKlGnVs0JoMrodEzl9dv20j0LTb77bW2ZK2jmPLCo33EY4OBpELNCqQ
         5Z9LEZftsu7hrHrIWPHuUCvYwxsgrOeKuFxMX05FZwPQSxCP0XXdWT/4OF/bMEVNBh
         LFYyri7WUBhRw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id D6D14121A54;
        Wed, 16 Feb 2022 11:33:29 +0000 (GMT)
Message-ID: <d1d5f904-f8d1-d328-edfa-f918dca728eb@cobb.uk.net>
Date:   Wed, 16 Feb 2022 11:33:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] btrfs-progs: Doc: update autodefrag mount options
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <90c29d3ce0096d1de56c898b63c40ebcdeafbba0.1645009831.git.wqu@suse.com>
In-Reply-To: <90c29d3ce0096d1de56c898b63c40ebcdeafbba0.1645009831.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/02/2022 11:10, Qu Wenruo wrote:
> This will add the following contents:
> 
> - Add how autodefrag works
> 
> - More detailed cases which are not sutiable for autodefrag

Typo: suitable

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/ch-mount-options.rst | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
> index f4ff0084d00f..f2dd12e6f841 100644
> --- a/Documentation/ch-mount-options.rst
> +++ b/Documentation/ch-mount-options.rst
> @@ -28,9 +28,23 @@ autodefrag, noautodefrag
>          (since: 3.0, default: off)
>  
>          Enable automatic file defragmentation.
> -        When enabled, small random writes into files (in a range of tens of kilobytes,
> -        currently it's 64KiB) are detected and queued up for the defragmentation process.
> -        Not well suited for large database workloads.
> +        When enabled, small random writes into files (in a range of tens of
> +        kilobytes, currently it's 64KiB for uncompressed write, and 16KiB for
> +        compressed write) are detected and queued up for the defragmentation

As I think the target audience for the mount options documentation
includes system admins, not just btrfs kernel developers, I would avoid
the term "compressed write" because of the plans to add a mechanism to
write pre-compressed data which the admin may have heard about and be
confused. How about something like:

"currently it's 64KiB for writes to uncompressed files, and 16KiB for
compressed files"

Sure, this is hand-waving over the precise decisions the kernel makes
but anyone who cares about that will check the actual code anyway.

> +        process.
> +
> +        Then btrfs-cleaner kernel thread will try to defrag all those files.
> +        The defragmentation process will scan the whole file from offset 0,
> +        finding out mergeable small writes since last modification, and
> +        re-dirty suitable targets (small, newer than last modification, mergeable)
> +        for next writeback.
> +
> +        Thus autodefrag, just like regular defrag, will cause extra data write.

Typo: "writes"

> +
> +        Not suited for heavy random write workload (including database and
> +        torrent), as such small random writes can get re-dirtied very
> +        frequently, causing amplified data write IO, while the file can still be
> +        heavily fragmented by the new writes.
>  
>          The read latency may increase due to reading the adjacent blocks that make up the
>          range for defragmentation, successive write will merge the blocks in the new

Graham
