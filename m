Return-Path: <linux-btrfs+bounces-14348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C8AC9BD8
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1143189F4E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10015855C;
	Sat, 31 May 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="vdac7zgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D919290F
	for <linux-btrfs@vger.kernel.org>; Sat, 31 May 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748710864; cv=none; b=hFzUn2FPQXc0tENUxJywaGjsROJJG+QK72VE9Mbqvs0hqD8RaDf/nFZZNrg1ttauHaHRRH3PtojkpOPmCU07am2+C10M9nDYJxutgsZHVRQ9c87ABoVyRQRigtIV2NpUB6zdNo7PqR6jxUKf3m/84FTZWluHiTURyI+noO4fAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748710864; c=relaxed/simple;
	bh=qPXhLSGXYDPxQqUpm1h/OF+m/sZeXOGfLiKmqsA/shI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ggBHYLHiN6YPOu0wWeFYI+R+tljOTYPGRk0koO4+m1hn1zw9U0X1E/0t5vBwvBOohp8dUdyZXDwAPCKANyVOvxh5//TmMfjH1kfMl+FK0bsHlAsQTMiprlNT35BIkVV/fK5YxQtHvm13oJwUZiwdTBW8DYh3MTkfYozNyUbJBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=vdac7zgl; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id LPXLuzf1Vi6zcLPXLuKyZG; Sat, 31 May 2025 18:58:23 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1748710703; bh=yJbVT29M/F3f3l5Gkg8IB8+WesVQ6Ky/GSz774i9K7c=;
	h=From;
	b=vdac7zglpvlEuqhMOYFRC7TQ6XE9/Qh9qe9Sax9FEVvb9I9IBjHp4k3IJu4bUaZAU
	 V2PEkyKbyipc50DQEEuoOZJwJTkyYz7aMowX/y/85AfQ5Mv79H+pL4HKLVrOHVJo/9
	 xw6jhIgaMmu3PV/7RBpW3yZwR+1gzXQorzfl4ef9U9WmTXEnlAChS6s9xuo2FMFveq
	 SluKDhrupgtwcMPndoOGw+ojz1a0c0AywPvwAK794sRph9NTaT34p+5EyVybHim1tj
	 GrQ5n+cdjCp0OywgKp8ecJG/PMRx6kwJ7bP8JRtgPJLd+b+WdV1hgDISwbH18X38dO
	 b4nBSYHm6l7fQ==
X-CNFS-Analysis: v=2.4 cv=Z4HsHGRA c=1 sm=1 tr=0 ts=683b352f cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=CM63JDvW8x-lE0Sp0NwA:9 a=QEXdDO2ut3YA:10
Message-ID: <828702dd-33e8-48c0-85f8-455763e34ed2@libero.it>
Date: Sat, 31 May 2025 18:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1747295965.git.wqu@suse.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <cover.1747295965.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF9gszoFIKuVlj71NtG2f9e4IiPmHC94v/E4BvwgALwRAong5Mm23hrl+OZ2KeTNztMgNyRBlQ10kPUnBkfCmKe+g2/0GbSSNGSTwG0gmt8d56WHOC95
 4xmleXCodrUNWsnpN17VKbfo96xCXX0jYYM4cMF+SroTuehBX8uetdKmIceFo3LH4KMROAv4S95l7xmAQyhw9jPzCzAOFtozjdO1HIVd3Qr1jB1lrz6RY43m

On 15/05/2025 10.00, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rename the subcommand to "fix-data-checksum"
>    It's better to use full name in the command name
> 
> - Remove unused members inside corrupted_block
>    The old @extent_bytenr and @extent_len is no longer needed, even for
>    the future file-deletion action.
> 
> - Fix the bitmap size off-by-1 bug
>    We must use the bit 0 to represent mirror 1, or the bitmap size will
>    exceed num_mirrors.
> 
> - Introduce -i|--interactive mode
>    Will ask the user for the action on the corrupted block, including:
> 
>    * Ignore
>      The default behavior if no command is provided
> 
>    * Use specified mirror to update the data checksum item
>      The user must input a number inside range [1, num_mirrors].
> 
> - Introduce -m|--mirror <num> mode
>    Use specified mirror for all corrupted blocks.
>    The value <num> must be >= 1. And if the value is larger than the
>    actual max mirror number, the real mirror number will be
>    `num % (num_mirror + 1)`.
> 
> We have a long history of data csum mismatch, caused by direct IO and
> buffered being modified during writeback.
> 
What about having an ioctl (on a mounted fs) which allow us to read data from a file even
if the csum doesn't match ? I asked that because the problem usually happen on a specific file
and not to an entire filesystem. In this case I think that it would be more practical to read the block
using the IOCTL, and then rewrite the block, at the specific offset (to update the checksum).

Of course there are several tradeoff: the "unmounted" version, doesn't duplicate a shared block,
where my approach (read the data using an ioctl to avoid the CSUM mismatch and rewrite it) make
a fork if the block is shared. However, as told before, the problem is related to specifics file and it seems
a waste of resource reading an entire filesystem to correct few files. No to mention that the IOCTL
can be done on a "live" filesystem.

Said that, of course "btrfs rescue fix-data-checksum" is better than nothing.

BR
G.Baroncelli

> Although the problem is worked around in v6.15 (and being backported),
> for the affected fs there is no good way to fix them, other than complex
> manually find out which files are affected and delete them.
> 
> This series introduce the initial implementation of "btrfs rescue
> fix-data-checksum", which is designed to fix such problem by either:
> 
> - Update the csum items using the data from specified copy
> 
> The subcommand has 3 modes so far:
> 
> - Readonly mode
>    Only report all corrupted blocks and affected files, no repair is
>    done.
> 
> - Interactive mode
>    Ask for what to do, including
> 
>    * Ignore (the default)
>    * Use certain mirror to update the checksum item
> 
> - Mirror mode
>    Use specified mirror to update the checksum item, the batch mode of
>    the interactive one.
> 
> In the future, there will be one more mode:
> 
> - Delete mode
>    Delete all involved files.
> 
>    There are still some points to address before implementing this mode.
> 
> Qu Wenruo (6):
>    btrfs-progs: introduce "btrfs rescue fix-data-checksum"
>    btrfs-progs: fix a bug in btrfs_find_item()
>    btrfs-progs: fix-data-checksum: show affected files
>    btrfs-progs: fix-data-checksum: introduce interactive mode
>    btrfs-progs: fix-data-checksum: update csum items to fix csum mismatch
>    btrfs-progs: fix-data-checksum: introduce -m|--mirror option
> 
>   Documentation/btrfs-rescue.rst  |  28 ++
>   Makefile                        |   2 +-
>   cmds/rescue-fix-data-checksum.c | 511 ++++++++++++++++++++++++++++++++
>   cmds/rescue.c                   |  65 ++++
>   cmds/rescue.h                   |  10 +
>   kernel-shared/ctree.c           |  17 +-
>   kernel-shared/file-item.c       |   2 +-
>   kernel-shared/file-item.h       |   5 +
>   8 files changed, 635 insertions(+), 5 deletions(-)
>   create mode 100644 cmds/rescue-fix-data-checksum.c
> 
> --
> 2.49.0
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

