Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD13749DFDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiA0KyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 05:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiA0KyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 05:54:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E63C061714
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 02:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9061616A6
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 10:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C76C340E4;
        Thu, 27 Jan 2022 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643280842;
        bh=IaFsRAG3IAz/SC9QtDWWkSyxa6T3LpiqcHCKBTC2PhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NahD6uHjNENBAt1QhimgkxOamZhkpfG37p+i6c9xkFLuAf6hIJP4iIBUExohk+kKN
         4CpSF8opjcUDclcpv2ZcgNLht+5hbOPMu9Hnl+WR4oKH9OPRH2IFzQz4OvmkZ510YT
         kOTgNQThcuh5I1QOQzlZ+9YJY5g2Ot07oSFkdXh7pa5wLJGAgeEyL+bZAhJPoLTRej
         XvwKj41Itg26IJOZ4QnRJEyOmlFW8Iaqu6mQazW2v+E0lC7jrdC0jEN8hlUM0fSyHy
         qxMxFWZL9i/oVgDdz6jLhDPJ9jqB7amA9e5IRf2fnib/WGzMNBDaq/+QhYhz+aIZhm
         OaUna7pzFgY8w==
Date:   Thu, 27 Jan 2022 10:53:59 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: defrag: don't defrag extents already at their
 max capacity, then remove an ambiguous check
Message-ID: <YfJ5x+IY90FqkUBy@debian9.Home>
References: <cover.1643260816.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643260816.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:24:41PM +0800, Qu Wenruo wrote:
> Thanks to the report from Filipe where he found a new bug in compressed
> defrag, that we will try to defrag all compressed extents even it's
> already at its max compacity.
> 
> This behavior is from the beginning of btrfs defrag.
> 
> The first patch is to fix the behavior, by just rejecting extents
> which are already at their max capacity, nor allowing extents to be
> merged with extents at their max capacity.
> 
> The second patch is to remove an ambiguous rejection condition.
> The condition is believed to reject compressed extent, but it never
> really works due to the check is > 128K, not >= 128K.
> 
> And the physically adajcent check may prevent users to reduce the number
> of extents.

With so many patches sent in such short periods of time, with some in series
and others not in properly formatted series, it's likely hard for other people
to follow what's going on.

So this patchset, applies on top of the following patch:

https://patchwork.kernel.org/project/linux-btrfs/patch/20220126005850.14729-1-wqu@suse.com/

That patch is part of another series consisting of 3 patches, but this
patchset here makes the patches 2/3 and 3/3 of that other patchset
obsolete.

Thanks.

> 
> Qu Wenruo (2):
>   btrfs: defrag: don't defrag extents which is already at its max
>     capacity
>   btrfs: defrag: remove an ambiguous condition for rejection
> 
>  fs/btrfs/ioctl.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1
> 
