Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193444A4982
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiAaOkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 09:40:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55310 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiAaOkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 09:40:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F48B1F396;
        Mon, 31 Jan 2022 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643640014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGZjkA60KbCbqPH+WbeiDdCa9FSLAkM2zBAFI6SKF3M=;
        b=HRWN/MRgIQtcZGKpSGVzm2EWieGaykB0pGC+eYqiSUtiS83ns7d0l0lt8+dOd6quzMkrlg
        Xlct3BY4aUCqMbv2FRdzHN/5MyZKsq5+sXXUQm9WnPK/xoOD5RQ7g4efT3zf4BFJGmPVNK
        /W+RhDuWQ1Iv2RIM71tl8uxKGcrGEH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643640014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGZjkA60KbCbqPH+WbeiDdCa9FSLAkM2zBAFI6SKF3M=;
        b=GS4D/aVeXYXvcGnKh/pv4Rs+tnvtWPLMZDl5zuIlclVwKHubxfGf9YsRzEt9dNOMVUFIG1
        y4NRQyKbDHd5DBCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 17DC4A3B84;
        Mon, 31 Jan 2022 14:40:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78D96DA7A9; Mon, 31 Jan 2022 15:39:30 +0100 (CET)
Date:   Mon, 31 Jan 2022 15:39:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Message-ID: <20220131143930.GL14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130010956.1459147-1-rosenp@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
> The kernel uses unsigned long specifically for ppc64 and mips64. This
> fixes that.

What do you mean? Uses unsigned long for what?

> Removed asm/types.h include as it will get included properly later.
> 
> Fixes -Wformat warnings.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  cmds/receive-dump.c | 1 -
>  kerncompat.h        | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> index 47a0a30e..00ad4fd1 100644
> --- a/cmds/receive-dump.c
> +++ b/cmds/receive-dump.c
> @@ -31,7 +31,6 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include <ctype.h>
> -#include <asm/types.h>
>  #include <uuid/uuid.h>
>  #include "common/utils.h"
>  #include "cmds/commands.h"
> diff --git a/kerncompat.h b/kerncompat.h
> index 6ca1526e..4b36b45a 100644
> --- a/kerncompat.h
> +++ b/kerncompat.h
> @@ -19,6 +19,10 @@
>  #ifndef __KERNCOMPAT_H__
>  #define __KERNCOMPAT_H__
>  
> +#ifndef __SANE_USERSPACE_TYPES__
> +#define __SANE_USERSPACE_TYPES__	/* For PPC64, to get LL64 types */
> +#endif

Is there a cleaner way instead of defining magic macros?

> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <errno.h>
> -- 
> 2.34.1
