Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FEF301F3A
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAXW2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 17:28:41 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:38445 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbhAXW2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 17:28:40 -0500
X-Halon-ID: 68390289-5e93-11eb-a076-005056917f90
Authorized-sender: mail@hartmark.se
Received: from [192.168.1.45] (79.138.193.155.bredband.tre.se [79.138.193.155])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPSA
        id 68390289-5e93-11eb-a076-005056917f90;
        Sun, 24 Jan 2021 23:27:57 +0100 (CET)
Subject: Re: kernel BUG at fs/btrfs/relocation.c:3494
To:     linux-btrfs@vger.kernel.org
References: <b7a45b0ec2f6d034822321734de635f5@hartmark.se>
 <20210123225743.GR31381@hungrycats.org>
From:   Markus Hartung <mail@hartmark.se>
Message-ID: <67a0dcb2-9336-0745-4acc-06d792a0895c@hartmark.se>
Date:   Sun, 24 Jan 2021 23:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123225743.GR31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/01/2021 23:57, Zygo Blaxell wrote:
> You don't have enough space to convert metadata yet, and you also don't
> have enough space to lock one of your 3 metadata block groups without
> running out of global reserve space, so this balance command forces the
> filesystem read-only due to lack of space.
>
>> <snip>
> First you need to get some unallocated space on devid 1, e.g.
>
> 	btrfs balance start -dlimit=12 /
>
> I picked 12 chunks here because your new disk is about 4x the size of
> your old one, so you can expect metadata to expand from 3 GB to 15 GB.
> By moving 12 data chunks to the new disk (plus 3 more from converting
> from dup to raid1), we ensure that space is available for the metadata
> later on.
>
> Once you have some unallocated space on two devices, you can do the
> metadata conversion balance:
>
> 	btrfs balance start -mconvert=raid1,soft /
>
> Every dup chunk converted to raid1 will release more space on devid 1,
> so the balance will complete (as long as you aren't writing hundreds
> of GB of new data at the same time).

Hello,

Thanks for the quick response, I needed obviously reboot a live-os first 
as the / was already mounted, but besides that the balance of some data 
blocks did the trick.

Keep up the good work.

Best regards,

Markus

