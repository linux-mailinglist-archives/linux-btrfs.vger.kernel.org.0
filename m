Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB93B9DC3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGBIy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 04:54:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhGBIy5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 04:54:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF50B2005F;
        Fri,  2 Jul 2021 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625215944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AO9No1ANmw6vVXxIbsNXZhA3yP5G22TYw5yf0xUm17Q=;
        b=PDkGu02dXl6KBYtKQuW4/M4RRuGOoNtKP9hwk6pmrkP7TxnrlQYHlpEA/qmSt1LkkyNIC/
        VhrmaeUHCSbncYBCgSrjtdcGRtomB5Qco9pRzeWYIGOOHEbn/dIqP0Dvqw3Xa5FEOY4t8w
        bXt4Ks/MaC+ao930IyBmlF9GYoNlkMg=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A6B0411CD6;
        Fri,  2 Jul 2021 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625215944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AO9No1ANmw6vVXxIbsNXZhA3yP5G22TYw5yf0xUm17Q=;
        b=PDkGu02dXl6KBYtKQuW4/M4RRuGOoNtKP9hwk6pmrkP7TxnrlQYHlpEA/qmSt1LkkyNIC/
        VhrmaeUHCSbncYBCgSrjtdcGRtomB5Qco9pRzeWYIGOOHEbn/dIqP0Dvqw3Xa5FEOY4t8w
        bXt4Ks/MaC+ao930IyBmlF9GYoNlkMg=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iU3XJcjT3mCGLQAALh3uQQ
        (envelope-from <nborisov@suse.com>); Fri, 02 Jul 2021 08:52:24 +0000
Subject: Re: [PATCH 2/2] btrfs: rework chunk allocation to avoid exhaustion of
 the system chunk array
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     naohiro.aota@wdc.com, Filipe Manana <fdmanana@suse.com>
References: <cover.1624973480.git.fdmanana@suse.com>
 <6a715978a2539344e0c795754817746e06b73438.1624973480.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d3a3fa99-b55d-7bae-4fdb-f3b2f5c7d98f@suse.com>
Date:   Fri, 2 Jul 2021 11:52:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6a715978a2539344e0c795754817746e06b73438.1624973480.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.06.21 г. 16:43, fdmanana@kernel.org wrote:
> |However that commit also introduced a deadlock where a task in phase 1
> of the chunk allocation waited for another task that had allocated a
> system chunk to finish its phase 2, but that other task was waiting on
> an extent buffer lock held by the first task, therefore resulting in
> both tasks not making any progress. That change was later reverted by a
> patch with the subject "btrfs: fix deadlock with concurrent chunk
> allocations involving system chunks", since there is no simple and short
> solution to address it and the deadlock is relatively easy to trigger on
> zoned filesystems, while the system chunk array exhaustion is not so
> common. |

nit: Wouldn't the deadlock constitute of the task in phase1, holding
chunk_mutex sleep on chunk_reserve_wait and having set
space_info->chunk_alloc = 1 and this in turn causes task in phase 2 to
to deadlock on chunk_mutex in btrfs_alloc_chunk due to
btrfs_create_pending_block_groups (phase2) happening with chunk_mutex
unlocked BUT chunk_reserve_wait still not woken up ? Your previous patch
explains this situation but this paragraph seems to mention extent
buffer locks which I don't think are involved in the deadlock.
