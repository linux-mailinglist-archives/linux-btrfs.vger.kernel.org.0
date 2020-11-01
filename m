Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FE2A21E1
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Nov 2020 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgKAVY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Nov 2020 16:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbgKAVY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Nov 2020 16:24:29 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC8C0617A6
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Nov 2020 13:24:28 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 13so9314868pfy.4
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Nov 2020 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPo0oUNlxK9SIYHNl49zYd9L6Z1ZjSxWCoiFbvzOXXU=;
        b=OU6Kl5ntKR8Yp37fhLFJDsuhwYNm3YG5JppNT7W7ZuMfeBeQamri3GjnnZnpL9Ggts
         h428qqIPnjxTRBUN2AxR+507aEBQG7wV67gkCDRltKNzqruAI5Z3Yw1dynOi6UJi8Q1p
         H+H3Fwdjp7N8+760yidK43UDHmKaoQqLTug6ZBfaLdqzhrjUypljtmONn9+B6Ybuw80r
         mrRey3x8y9zzVHQqCFhjjodh0NZ5ZHNNWjWAp5MGfIoVGmIGmeVe980SziqRsSBOTuGb
         Qte46GoxvNwrTc5z5FWVM5VnY9fisFrca+SXj6b5srWaCon/JVW1Z6f2VsrjuHtUtORG
         mrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPo0oUNlxK9SIYHNl49zYd9L6Z1ZjSxWCoiFbvzOXXU=;
        b=V4dBvwjJYGfVdnGliKMOULjw4gsvkq4usdzopwZ1nkDznOJFKlnvS4Eglpa1Jo1M1g
         OqZCGDmiYH1DsIH1mpD47VQT/xTgY9yxZAve8Gx3lVUzhXE5LfbJDRONuUpEofgrfzob
         s8AokhhuB1+MmXyHmJXsQp3uIBlY8ksUFsqgt9meznCuu+UmYR34x5owjQUPThWAz4UW
         UtO0RNsat0cFwbLsQzpxlbBO9bCBeY9Ke0ROOcpHb88ifTUR4SIY3FpD2plJx6yIF3SF
         29nYoBEmQATMlu5p4ccvUrQq/KWwwDFiVqD+mc3v5G/wca1FLsPvVqIIjVCsvGgocOQi
         I8Jw==
X-Gm-Message-State: AOAM530v9qy5FMSeOQY/TcksnKm9O7XgNgDsk59qQFPSxVrNaCO7oZom
        6ibfRwBNtbm58AprkjyPiyc=
X-Google-Smtp-Source: ABdhPJwN1vsWzMsNAbNYhMqzMXVLGYvbIzMAvRES/6fOrCjZdiT4eAy0Xj52S2hQqoAzn0m9S2wImA==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr14429600pjb.228.1604265868520;
        Sun, 01 Nov 2020 13:24:28 -0800 (PST)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id r8sm8492244pga.33.2020.11.01.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 13:24:27 -0800 (PST)
Date:   Sun, 1 Nov 2020 21:24:16 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: device stats: add json output format
Message-ID: <20201101212416.GA2637@realwakka>
References: <20201004112557.5568-1-realwakka@gmail.com>
 <20201030175525.GZ6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030175525.GZ6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 06:55:25PM +0100, David Sterba wrote:
> On Sun, Oct 04, 2020 at 11:25:57AM +0000, Sidong Yang wrote:
> > Add supports for json formatting, this patch changes hard coded printing
> > code to formatted print with output formatter. Json output would be
> > useful for other programs that parse output of the command. but it
> > changes the text format.
> > 
> > Example text format:
> > 
> > device:                 /dev/vdb
> > write_io_errs:          0
> > read_io_errs:           0
> > flush_io_errs:          0
> > corruption_errs:        0
> > generation_errs:        0
> > 
> > Example json format:
> > 
> > {
> >   "__header": {
> >     "version": "1"
> >   },
> >   "device-stats": {
> >     "/dev/vdb": {
> >       "device": "/dev/vdb",
> >       "write_io_errs": "0",
> >       "read_io_errs": "0",
> >       "flush_io_errs": "0",
> >       "corruption_errs": "0",
> >       "generation_errs": "0"
> >     }
> >   },
> > }
> 
> The overall structure looks good, ie. the separate object 'device-stats'
> and then the contents. For that the device id should be either key to a
> map, or we can put it into an array (where device id must be present
> too).

IMHO, It's okay to put 'device-stats' object into an array like below.

{
  "__header": {
    "version": "1"
  },
  "device-stats": [
    {
      "devid": "1",
      "device": "/dev/vdb",
      "write_io_errs": "0",
      "read_io_errs": "0",
      "flush_io_errs": "0",
      "corruption_errs": "0",
      "generation_errs": "0"
    }
  ],
}

but I can't find the way to insert an object like 'fmt_start_object'.
I think we need it for this.

Thanks,
Sidong


> 
> A check if the format is usable you can try to write a sample tool that
> parses some of the data and prints them. So eg. using python or jq and
> print stats of device 1. Which points out that device id is missing for
> example.
