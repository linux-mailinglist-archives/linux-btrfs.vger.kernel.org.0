Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D43A67B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhFNNYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 09:24:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58542 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhFNNYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 09:24:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF68B1FD33;
        Mon, 14 Jun 2021 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623676947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYQFtJn6nOVbaLSWQsgPW6Q2IfLiDYvUDK6CVvmX+2w=;
        b=Zbydwc64oIfEbEhUCSsB9ql1xZ6PfgM1MxavsGyvui9gLBZMzF0eqrTIfLYEjujE+MrNok
        NrLB9kYwU3UdR3O6jxgzSU9E68PQ1A8+t+zJ2WhXav+wRF85tiMFJkWeiMBkLmsWcY2l8q
        TGzlL5OonMqy+DqRLUoDtYPJHbvGL2g=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 71CE3118DD;
        Mon, 14 Jun 2021 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623676947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYQFtJn6nOVbaLSWQsgPW6Q2IfLiDYvUDK6CVvmX+2w=;
        b=Zbydwc64oIfEbEhUCSsB9ql1xZ6PfgM1MxavsGyvui9gLBZMzF0eqrTIfLYEjujE+MrNok
        NrLB9kYwU3UdR3O6jxgzSU9E68PQ1A8+t+zJ2WhXav+wRF85tiMFJkWeiMBkLmsWcY2l8q
        TGzlL5OonMqy+DqRLUoDtYPJHbvGL2g=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id W8jtGBNYx2AYVgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 14 Jun 2021 13:22:27 +0000
Subject: Re: [PATCH 0/3] btrfs: commit the transaction unconditionally for
 ensopc
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623421213.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <adf558dd-3d8b-d06e-54ff-d9260ca830fd@suse.com>
Date:   Mon, 14 Jun 2021 16:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1623421213.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.21 г. 17:23, Josef Bacik wrote:
> Hello,
> 
> While debugging early ENOSPC issues in the Facebook fleet I hit a case where we
> weren't committing the transaction because of some patch that I hadn't
> backported to our kernel.
> 
> This made me think really hard about why we have may_commit_transaction, and
> realized that it doesn't make sense in it's current form anymore.  By-in-large
> it just exists to have bugs in it and cause us pain.  It served a purpose in the
> pre-ticketing days, but now just exists to be a giant pain in the ass.
> 
> So rip it out.  Just commit the transaction.  This also allows us to drop the
> logic for ->total_bytes_pinned, which Nikolay noticed a problem with earlier
> this week again.  Thanks,
> 
> Josef Bacik (3):
>   btrfs: rip out may_commit_transaction
>   btrfs: rip the first_ticket_bytes logic from fail_all_tickets
>   btrfs: rip out ->total_bytes_pinned
> 
>  fs/btrfs/block-group.c       |   3 -
>  fs/btrfs/ctree.h             |   1 -
>  fs/btrfs/delayed-ref.c       |  26 -----
>  fs/btrfs/disk-io.c           |   3 -
>  fs/btrfs/extent-tree.c       |  15 ---
>  fs/btrfs/space-info.c        | 178 +++--------------------------------
>  fs/btrfs/space-info.h        |  30 ------
>  fs/btrfs/sysfs.c             |  13 ---
>  include/trace/events/btrfs.h |   3 +-
>  9 files changed, 14 insertions(+), 258 deletions(-)
> 


For patches 2-3:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Patch is also fine apart from the minor nit about the undocumented
FLUSH_DELAYED_REFS when flushing data space.
