Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43345281A36
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgJBRxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJBRxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 13:53:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05550C0613D0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Oct 2020 10:53:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j19so1320704pjl.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Oct 2020 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oeKycZ4gU7n+VjfDRSRQbumah+85SXx0dTwIh1FC43o=;
        b=lbdkCX0sB/P/xswFyzgDkiXK/mrhPTRu4NcwbtuM0B8LYzgdStq5YaMgcaDmBod9G/
         BdXjDxmO2eUaV6fTJKXDO+qg9TYmghAlPL3tz5JSkWJba168jeoLGlDcePSofy2/iBmh
         6hk+3wkc+xj+pDp/klVMpCctq0dTaacjhttVu4VWCWUOSz1r4wqciikvlx3S/uJc5e8S
         JViJGBEdo0J6PBiRta14WkZl6i/X4FPd63rW4YXgv896CxeAYYPxLAUiHh4zt6r722dw
         EYXA7jpeazDIo0BHUnIkaLJb8hPG0ItUI6E+NxsFA9Wl0OWMj2UnNfnlgmAUjGXOyx1O
         vDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeKycZ4gU7n+VjfDRSRQbumah+85SXx0dTwIh1FC43o=;
        b=sqOXVwNnQ3druw6fl4lTB/ULGIXbjTjRKKx4wRMqFLWLg1DKzYk6WdNEqzlkVsHq4v
         Og6Pd+HJLx/x/cLF1Gw3VOotc0VC19oZ5IpXbdhrllPqTO4qYSBAT4qYdVsJkE3TLG+4
         hWtHm37zA8LVuUDfb7p828pXFXEke1hmviZdgGqBKQuQdNuwftRP4dAvq1Or7C8govDo
         46kfB2DoqT8incS00QSX//9kZXjNgFzHAzGbrWsKqPwXt1CuUTRJX5l8UaTbWScUx4iw
         rZPn/AsOT6lCn0/baTZfzQmNj+/pjMgLCRX66E69st8ecttj1JcWW9idHn2cV20e33iS
         b6ZQ==
X-Gm-Message-State: AOAM530+ZJHXc1m6AYYTFxxU7C/PIMGixOBn+D6kHbb++3nXPl/1m/Tk
        TP+CGwSMCJ36BB+3nB/yNUQaP/AUaC4=
X-Google-Smtp-Source: ABdhPJwgZ98iRG/R0pWqM5OQ0Y1oU/EVYKYbp6ee30pXkE8B5r74dkm/R9RCyMGGAaHsLNo5QDJnQQ==
X-Received: by 2002:a17:90a:6309:: with SMTP id e9mr3734984pjj.115.1601661229429;
        Fri, 02 Oct 2020 10:53:49 -0700 (PDT)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id h11sm2252029pgi.10.2020.10.02.10.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 10:53:48 -0700 (PDT)
Date:   Fri, 2 Oct 2020 17:53:39 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Support json format in device stats
Message-ID: <20201002175339.GA1420@realwakka>
References: <20200917072948.3354-1-realwakka@gmail.com>
 <20201002162110.GX6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002162110.GX6756@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 02, 2020 at 06:21:10PM +0200, David Sterba wrote:
> On Thu, Sep 17, 2020 at 07:29:47AM +0000, Sidong Yang wrote:
> > This patch supports the feature that printing device stats in json
> > format. So textcollector like prometheus can parse the output easier.
> > This patch implements option for json format and print in json when
> > the option enabled.
> 
> Thanks, but this got a few things wrong.
> 
> > This patch implements enhancement for this issue.
> > https://github.com/kdave/btrfs-progs/issues/291
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  cmds/device.c | 46 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 34 insertions(+), 12 deletions(-)
> > 
> > diff --git a/cmds/device.c b/cmds/device.c
> > index d72881f8..3e4bf837 100644
> > --- a/cmds/device.c
> > +++ b/cmds/device.c
> > @@ -467,6 +467,7 @@ static const char * const cmd_device_stats_usage[] = {
> >  	"",
> >  	"-c|--check             return non-zero if any stat counter is not zero",
> >  	"-z|--reset             show current stats and reset values to zero",
> > +	"-j|--json              show stats in json format",
> 
> The output format is a global option like:
> 
>     $ btrfs --format=json device stats ...
> 
> >  	NULL
> >  };
> >  
> > @@ -482,6 +483,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
> >  	int check = 0;
> >  	__u64 flags = 0;
> >  	DIR *dirstream = NULL;
> > +	bool json = 0;
> >  
> >  	optind = 0;
> >  	while (1) {
> > @@ -489,6 +491,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
> >  		static const struct option long_options[] = {
> >  			{"check", no_argument, NULL, 'c'},
> >  			{"reset", no_argument, NULL, 'z'},
> > +			{"json", no_argument, NULL, 'j'},
> >  			{NULL, 0, NULL, 0}
> >  		};
> >  
> > @@ -503,6 +506,9 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
> >  		case 'z':
> >  			flags = BTRFS_DEV_STATS_RESET;
> >  			break;
> > +		case 'j':
> > +			json = 1;
> > +			break;
> >  		default:
> >  			usage_unknown_option(cmd, argv);
> >  		}
> > @@ -574,18 +580,34 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
> >  				snprintf(canonical_path, 32,
> >  					 "devid:%llu", args.devid);
> >  			}
> > -
> > -			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
> > -				/* We got fewer items than we know */
> > -				if (args.nr_items < dev_stats[j].num + 1)
> > -					continue;
> > -				printf("[%s].%-16s %llu\n", canonical_path,
> > -					dev_stats[j].name,
> > -					(unsigned long long)
> > -					 args.values[dev_stats[j].num]);
> > -				if ((check == 1)
> > -				    && (args.values[dev_stats[j].num] > 0))
> > -					err |= 64;
> > +			if (json) {
> 

Hi! David,
Thanks for review!

> Two separate implementations that dump the data, so both would have to
> be kept in sync, which is error prone.
> 
> I've implemented data dumper that automatically picks the right format
> based on the --format option from a specification.
> 
> Last time the json output was discussed, there was not a consensus how
> exactly it should look like. There's a preview for subvolume command
> (https://github.com/kdave/btrfs-progs/tree/preview-json), you can see
> how it's supposed to be used.

Yeah, There is a great function I didn't know. I should reimplement a new patch 
with this format infrastructure. It's okay to output json like this?

{
  "__header": {
    "version": "1"
  },
  "device-stats": [{
    "name": "/dev/sdb",
    "write_io_errs": "0",
    "read_io_errs": "0",
    "flush_io_errs": "0",
    "corruption_io_errs": "0",
    "generation_io_errs": "0"
  }]
} 

> 
> Given the output is not finazlied, the json output is still a bit of
> research how other tools eg. from util-linux do it and also to have some
> sample use cases, eg. examples with 'jq' extracting the data. The hard
> part here is to specify a reasonable format that won't have to be
> changed in the future.

You mean that there is no consensus with this problem?
