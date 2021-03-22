Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA18345288
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCVWsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 18:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCVWsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 18:48:08 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212AC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 15:48:07 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de [91.7.232.229])
        by mail.itouring.de (Postfix) with ESMTPSA id B9BF5124FB9
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 23:48:05 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 86E04F01600
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 23:48:05 +0100 (CET)
Subject: Re: Wrong RAID 5/6 warning when converting single -> dup
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <e8ef1ebf-704b-f494-b67b-87b234e25ee0@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <8dfa653e-c861-3515-58fa-206eb06de4f6@applied-asynchrony.com>
Date:   Mon, 22 Mar 2021 23:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <e8ef1ebf-704b-f494-b67b-87b234e25ee0@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-03-22 21:00, Holger Hoffstätte wrote:
> 
> So I just did a conversion from single to dup and got the following
> unexpected warning:
> 
> $btrfs balance start -mconvert=dup /mnt/data
> WARNING:
> 
>      RAID5/6 support has known problems and is strongly discouraged
>      to be used besides testing or evaluation. It is recommended that
>      you use one of the other RAID profiles.
>      The operation will continue in 10 seconds.
>      Use Ctrl-C to stop.
> 10^C
> 
> I let it run and it's dup now, so the conversion itself works correctly.
> Looks like this was introduced in [1] but offhand I don't see what's wrong.
> 
> -h
> 
> [1] https://github.com/kdave/btrfs-progs/commit/1ed5db8db445073eb0d8b807901b64edaac1d8c4

So..the expression

	if (!(ptrs[i]->flags & (BTRFS_BLOCK_GROUP_RAID6 |
				BTRFS_BLOCK_GROUP_RAID5)))

doesn't work because ptrs[i]->flags is always 256, regardless of filesystem
layout and to-balance args. Checking for ->flags & BTRFS_BLOCK_GROUP_RAID5
(1 << 7) is always 0 (even when setting up a 3-device fs and converting to/from
raid5), checking for BTRFS_BLOCK_GROUP_RAID6 (1 << 8) is always true.
There are more problems but this is what I found so far.

I'm on kernel 5.10.x, was there maybe an ioctl-breaking ABI change in
5.11/5.12? Any other ideas?

-h
