Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCB440E81
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Oct 2021 14:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJaNDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Oct 2021 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhJaNDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Oct 2021 09:03:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5BC061570
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Oct 2021 06:01:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l1so7410200pfu.5
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Oct 2021 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SSDzLDbKBSnl1K/psS5SioJYzZOLhD1KzJZ11evAPn0=;
        b=P9ONgZSIANH6HW67KlTakk26wvNMeyP2P0Yp35C01HRa40aXxTDRaa/tldx8DZYHlL
         z5R6ldVe2NGU68prjLrq9tcFdZjbyex+icugsKwHe0ymydwp7qxNuwkcIkJehuAwzCLF
         ChOVwtHbClBbKc+kSbriflRuzVaJTMIRfgOa084SLzoocYpXhZp8Gaoxl7GxzHGrfDy/
         /nB9Fbuz0SnBSjzBZfhiBg3w6Xs5VIe58ZaZi9qOJATFPyhwFqgfSPp3ISbarwe1E1dg
         xdzTWCpdQ6LIUHlfqYzxpPZB6M1KCr0u+JBmrFvALGt+7KsbomWr9+5nYRQ+K6F5XxJ3
         SMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SSDzLDbKBSnl1K/psS5SioJYzZOLhD1KzJZ11evAPn0=;
        b=R8TIidg7r/+8aBcg4/iB3GYEtpGkohSOxacHySsWtllFVwD+/mbAImMRxa0KspkGtq
         Iuxu+cuWu5e8+dfAdVmh47JpXDuf1TrchLmapTX5vbBqEU+bP2bXrkEGRMt80HxlPOpm
         RAoWTI5L1Je2pR3LsnHLwvfpTdfICeYu8Cvugk3G4bz+JQOx72A/ReKDZ8HizBgOzMib
         gPn69u66Bho3VElIBVvUf6uLEwPiPTCnG4o0xN/Kp3BrupnbrnNCsQbwGCCwFUbOPBWg
         bTIv8L+DV4AanTZUgM4aL1qAkuQYwatFsq2As2jOMtZIefmAO2MV2EQ90p4QBVr8uRll
         8AJg==
X-Gm-Message-State: AOAM530t00OKo/+F3R/B/taId+gT2R4jGi1iSziK45hm96vijj1u3ggP
        hMT9BtLHUUYp5tFm8I97/ND8LdOHhVPVJg==
X-Google-Smtp-Source: ABdhPJw04nwnJkmhvfchVurUCf4ak+T/GLHKNsLS4Sltm16LNZeWTEEOkX9TsKImm8/tX4yexC3ddw==
X-Received: by 2002:a05:6a00:21c1:b0:47c:11e0:84e9 with SMTP id t1-20020a056a0021c100b0047c11e084e9mr22369705pfj.23.1635685283132;
        Sun, 31 Oct 2021 06:01:23 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id x26sm12219967pff.25.2021.10.31.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 06:01:22 -0700 (PDT)
Date:   Sun, 31 Oct 2021 12:55:18 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: balance: print warn mesg in old command
Message-ID: <20211031125518.GA42183@realwakka>
References: <20211031022152.41730-1-realwakka@gmail.com>
 <d084bb90-72e5-0d7f-b89d-7334fc45de28@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d084bb90-72e5-0d7f-b89d-7334fc45de28@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 31, 2021 at 07:28:17PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/31 10:21, Sidong Yang wrote:
> > This patch makes old balance command to print warn mesg same as in start
> > command. It makes a function that print warn mesg and commands use that
> > function.
> > 
> > Issue: #411
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>

Hi, Qu.

Thanks for review!

> 
> The patch is indeed solving a problem, so good job.
> 
> But I found something weird which may worth some refactor before the fix.
> 
> > ---
> >   cmds/balance.c | 37 ++++++++++++++++++++++---------------
> >   1 file changed, 22 insertions(+), 15 deletions(-)
> > 
> > diff --git a/cmds/balance.c b/cmds/balance.c
> > index 7abc69d9..8d8db8a2 100644
> > --- a/cmds/balance.c
> > +++ b/cmds/balance.c
> > @@ -303,6 +303,25 @@ enum {
> >   	BALANCE_START_NOWARN  = 1 << 1
> 
> We have such flag for do_balance(), but it only checks START_FILTERS, no
> check for START_NOWARN.

Yes. I've checked do_balance() that it doesn't check START_NOWARN.
> 
> So can we handle it better for the warning in do_balance() other than
> cmd_balance_full() or cmd_balance_start()?

Totally agree. It would be better that it prints warning message in do_balance().
Also it's a way to simplify the logic.

> 
> And fully utilize the START_NOWARN flags?

I'll send you v2 soon.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> >   };
> > 
> > +static void print_start_warn_mesg()
> > +{
> > +	int delay = 10;
> > +
> > +	printf("WARNING:\n\n");
> > +	printf("\tFull balance without filters requested. This operation is very\n");
> > +	printf("\tintense and takes potentially very long. It is recommended to\n");
> > +	printf("\tuse the balance filters to narrow down the scope of balance.\n");
> > +	printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
> > +	printf("\twarning. The operation will start in %d seconds.\n", delay);
> > +	printf("\tUse Ctrl-C to stop it.\n");
> > +	while (delay) {
> > +		printf("%2d", delay--);
> > +		fflush(stdout);
> > +		sleep(1);
> > +	}
> > +	printf("\nStarting balance without any filters.\n");
> > +}
> > +
> >   static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
> >   		      unsigned flags, bool enqueue)
> >   {
> > @@ -548,21 +567,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
> >   	}
> > 
> >   	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
> > -		int delay = 10;
> > -
> > -		printf("WARNING:\n\n");
> > -		printf("\tFull balance without filters requested. This operation is very\n");
> > -		printf("\tintense and takes potentially very long. It is recommended to\n");
> > -		printf("\tuse the balance filters to narrow down the scope of balance.\n");
> > -		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
> > -		printf("\twarning. The operation will start in %d seconds.\n", delay);
> > -		printf("\tUse Ctrl-C to stop it.\n");
> > -		while (delay) {
> > -			printf("%2d", delay--);
> > -			fflush(stdout);
> > -			sleep(1);
> > -		}
> > -		printf("\nStarting balance without any filters.\n");
> > +		print_start_warn_mesg();
> >   	}
> > 
> >   	if (force)
> > @@ -886,6 +891,8 @@ static int cmd_balance(const struct cmd_struct *cmd, int argc, char **argv)
> >   		memset(&args, 0, sizeof(args));
> >   		args.flags |= BTRFS_BALANCE_TYPE_MASK;
> > 
> > +		print_start_warn_mesg();
> > +
> >   		/* No enqueueing supported for the obsolete syntax */
> >   		return do_balance(argv[1], &args, 0, false);
> >   	}
> > 
