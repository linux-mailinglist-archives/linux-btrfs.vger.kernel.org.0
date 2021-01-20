Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532502FD4E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbhATQFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 11:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391171AbhATQEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 11:04:48 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6AC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:04:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p18so15458275pgm.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EI0rvlMUphBcia5tzrkEDnuP3tBA6vi2HfYJj8/btg4=;
        b=dH2cE8WgAa7VBubCpdZFcR93ZQ5mwa0amyyj5WyQdjeRmBYZRxseHP6gTrLuOsoPe5
         irDYlXfiGA9ZW5DFjqQwOWPf+9hXfv8d9wcSBJp3G0VoGvHoFkAU8UHtjnU5BDC/A2+j
         UXVaYBtPhihuBVZrBav5Hs2DahOfM4cY98zn1Hu5dvgRWDanEiLDP0FP6y/nHnDWFOHB
         d0DeznLOQAXBgZgDOIP/iZXLFMQTCU8gLyXFpI26hlgIWArtUwKbvxiEYKz/hB3YYhSI
         4UbnHUfKgYEv+ofItvV+j91L763kmV4rAHGQ98XbgV4U0U8z0ddcPnnPxMhFTlmy/+ez
         7Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EI0rvlMUphBcia5tzrkEDnuP3tBA6vi2HfYJj8/btg4=;
        b=MyRr0IoCMuQ1yC2iDioy6hB8nD7YbWGbXbCWBDFTUs5ZjKDk5qos0n9cmBqDAhoViN
         gJDkMkP/2b/wFY5jRKXxBHCm5IHsIvNIhsoqndKZoyG18h1l1susly9MKM3kpJm6uUXv
         nrq2KS8bE7YF32DF9x6jdmo5sGxjXxvjvNl17+W4OeDpgKe1FZartD3sIT6RghpKG4wB
         PoXS+FNplXcNX/ew/C+huRrm/2d0jcA+5bHWM1m8YKoIn22ujJY3nDusnOgsSjx9Xu+j
         felJxC4519GOhDnQd7PlafJ5l6lCfrXcNlARhnuFKwjlQIAWud99anp3R5Tj2a5vvuaS
         SEbA==
X-Gm-Message-State: AOAM5303kr663jIJsgWKoTwc7OLEkeSgKyoJSN7tEgm2sLZF6ewD3kU1
        +635Mq9aYTNrLrTycTmuVkfMCsRqZYztOw==
X-Google-Smtp-Source: ABdhPJzTBA8+yLfDQ+ZBDLAZgteN+LszPe9PkJ2m2FCCLSFDw2keIpkTtCLC4/Z5wOfyAf6bj1wdRw==
X-Received: by 2002:a63:e246:: with SMTP id y6mr9859953pgj.412.1611158646030;
        Wed, 20 Jan 2021 08:04:06 -0800 (PST)
Received: from realwakka-Lenovo-IdeaPad-S340-14API ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id l12sm2791116pjq.7.2021.01.20.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:04:04 -0800 (PST)
Date:   Thu, 21 Jan 2021 01:03:55 +0900
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: filesystem-resize: make output more readable
Message-ID: <20210120160346.GA1506522@realwakka-Lenovo-IdeaPad-S340-14API>
References: <20201216034240.2029-1-realwakka@gmail.com>
 <20210114234859.GG6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114234859.GG6430@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 15, 2021 at 12:48:59AM +0100, David Sterba wrote:

Hi David, Thanks fore review.

> On Wed, Dec 16, 2020 at 03:42:40AM +0000, Sidong Yang wrote:
> > This patch make output of filesystem-resize command more readable and
> > give detail information for users. This patch provides more information
> > about filesystem like below.
> > 
> > Before:
> > Resize '/mnt' of '1:-1G'
> > 
> > After:
> > Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  cmds/filesystem.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index fac612b2..53e775b7 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -1084,6 +1084,14 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> >  	int ret;
> >  	struct stat st;
> >  	bool enqueue = false;
> > +	struct btrfs_ioctl_fs_info_args fi_args;
> > +	struct btrfs_ioctl_dev_info_args *di_args = NULL;
> > +	char newsize[256];
> > +	char sign;
> > +	u64 inc_bytes;
> > +	u64 res_bytes;
> > +	int i, devid, dev_idx;
> > +	const char *res_str;
> >  
> >  	optind = 0;
> >  	while (1) {
> > @@ -1142,7 +1150,58 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> >  		return 1;
> >  	}
> >  
> > -	printf("Resize '%s' of '%s'\n", path, amount);
> > +	ret = get_fs_info(path, &fi_args, &di_args);
> > +	if (ret)
> > +		error("unable to retrieve fs info");
> 
> The helper 'error' is to just print the message so the code has to
> change flow to an exit otherwise it would continue, which is what we
> don't want here.

Thanks, I didn't know about error(). I'll fix it.
> 
> > +
> > +	if (!fi_args.num_devices)
> > +		error("num_devices = 0");
> 
> Same and everywhere below. Also the error message is too cryptic, think
> that there's a human reading that so it should say what's the error,
> like "No devices found". Which would be a weird and likely impossible
> error anyway but it's good that it's handled.

I have to fix the error messages for users to understand what's the error.

> 
> > +
> > +	ret = sscanf(amount, "%d:%255s", &devid, newsize);
> > +
> > +	if (ret != 2)
> > +		error("invalid format");
> 
> I'm not sure this covers all the possibilities the resize format
> provides. The "%d:" part is not mandatory and there doesn't need to be
> ":" at all, eg when it's "max" or any number.
> 
> There are some examples in manual page of btrfs-filesystem so would be
> good if we have at least that covered by tests.

Okay, I'll make it to handle various cases.

Thanks!
Sidong
