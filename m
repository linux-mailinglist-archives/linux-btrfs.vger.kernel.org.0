Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23C4A5D98
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiBANor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 08:44:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBANor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 08:44:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 512A8210F9;
        Tue,  1 Feb 2022 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643723086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB3Bp1aJhgWWNLv6ltfplCtpkBV98eNeLAWHPrPu7V0=;
        b=iw3WHKD4gPD5ih7KkiTtOnecrRTr1i2kbo1SYkBVc3q2wKQcg7JMyy/TlKt0GY+VRtJbcu
        AYL/DWH7XBajIRflx69C6LMeSrEcn4xbPjTKCYeQrrikN4jl2eTnA8EGg0abeIzNDGdVeZ
        OBcXdHYE2JoHkmPszb5OEqxJ4TzbW5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643723086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB3Bp1aJhgWWNLv6ltfplCtpkBV98eNeLAWHPrPu7V0=;
        b=AKUW5/GiI8hT9dgjkkcMdq/zvlMeBeCCafr87hOh/ozFi96BW4RUrt5h/VrtEfthtemdZ8
        SKe/9R7lKg89dZDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 48C78A3B81;
        Tue,  1 Feb 2022 13:44:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52380DA7A9; Tue,  1 Feb 2022 14:44:02 +0100 (CET)
Date:   Tue, 1 Feb 2022 14:44:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Message-ID: <20220201134402.GM14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
 <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 08:58:55PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/1 04:46, Rosen Penev wrote:
> > On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
> >>> The kernel uses unsigned long specifically for ppc64 and mips64. This
> >>> fixes that.
> >>
> >> What do you mean? Uses unsigned long for what?
> > kernel's u64 is normally unsigned long long, but not for ppc64 and mips64.
> >>
> >>> Removed asm/types.h include as it will get included properly later.
> >>>
> >>> Fixes -Wformat warnings.
> >>>
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>   cmds/receive-dump.c | 1 -
> >>>   kerncompat.h        | 4 ++++
> >>>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> >>> index 47a0a30e..00ad4fd1 100644
> >>> --- a/cmds/receive-dump.c
> >>> +++ b/cmds/receive-dump.c
> >>> @@ -31,7 +31,6 @@
> >>>   #include <stdlib.h>
> >>>   #include <time.h>
> >>>   #include <ctype.h>
> >>> -#include <asm/types.h>
> >>>   #include <uuid/uuid.h>
> >>>   #include "common/utils.h"
> >>>   #include "cmds/commands.h"
> >>> diff --git a/kerncompat.h b/kerncompat.h
> >>> index 6ca1526e..4b36b45a 100644
> >>> --- a/kerncompat.h
> >>> +++ b/kerncompat.h
> >>> @@ -19,6 +19,10 @@
> >>>   #ifndef __KERNCOMPAT_H__
> >>>   #define __KERNCOMPAT_H__
> >>>
> >>> +#ifndef __SANE_USERSPACE_TYPES__
> >>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types */
> >>> +#endif
> >>
> >> Is there a cleaner way instead of defining magic macros?
> > no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/uapi/asm/types.h#L18
> 
> Really?
> 
> I have the same issue in btrfs-fuse, but it can be easily solved without
> using the magic macro.
> 
> See this issue:
> 
> https://github.com/adam900710/btrfs-fuse/issues/2
> 
> including <linux/types.h> seems to solve it for btrfs-fuse.

Ok, so it's just the asm/types.h, once it's deleted it should all work
with linux/types.h (included via kerncompat.h).

Rosen, could you please verify that this is sufficient (without the
extra macro)?
