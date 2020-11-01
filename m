Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803882A1BC2
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Nov 2020 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgKAD0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Oct 2020 23:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgKAD0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Oct 2020 23:26:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E5C0617A6
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Oct 2020 20:26:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so8059554pgk.4
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Oct 2020 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YhcmvDa00P7VgFHzLeGktWkrt1O6MPZgOnm7RyXSxsg=;
        b=gABUnXbevMGuAVvfdCDzPAzH8a1EmTiIs/LnGpx8Z8LTlm8ZjRAMvway8UKc2XW3sv
         H2NmvvmSolavCHD1yiioU64hQS382efCoa0wW6L7GQ8eubzFhMyEUqIo9ED5cj2a2baJ
         3Xso63DnPwFuc4kj7Mvs34IU53yaksJj1CJf8QmWP4xmaGAaAaXh+th8V67aHvQuPsiO
         169PuSwMAliLw06erGVRoRh2ZM4+kOyzEmoS1zzWUcH1iSyt9x5JB5hZfvOWCZ7zp3nd
         l5haMtiuZ0AXLuwOoxeqtv/TbbSnhLSAgdL4qlBjZOdtscGnWKg/5rvp4qrft+epNgCp
         tq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YhcmvDa00P7VgFHzLeGktWkrt1O6MPZgOnm7RyXSxsg=;
        b=lE8PJnzkYbGbi7nxsV5h8B90gfFXkgL9ljPvRJs4ZhnSHGchuXHlTRjk3fA9SIsljy
         rrtNycpeeKCWMcFJa6xoTFk5NM+Gfm+8ITg/mpD/QXDokUnxZcjNyBCR1r8Pt252esVX
         qtg4eNfWXuPsr2T57W4r5X1sxZ2FMeSzhzwHA7QnIvGVMFhm2K9GcfIgopEGoBAv4m+f
         wEdmqn0EUVU2BvPSOsvzgHuroJjJ/eTdcg7oOFI2x+QJzR3p1rDoorURAaxxMX2HKhx4
         roPvsPZtfpxv47klQu3Srz9QgqKFtobAFs7A0Rc39bjqy/bTh9V4j4ZbgR+q8y7n5wDS
         mQUg==
X-Gm-Message-State: AOAM533mg28XQc9c5G2z11y3Zh0VYa6PkvXOh3PUJB3he5imnqWQ+7Pq
        6KEfKe/2sqUzFIylNccflGU9hT2Ajmnw9A==
X-Google-Smtp-Source: ABdhPJy/VP4WmFWKDDl7bcoQ+axkV08FU4HpgUI1Nwy/1NFHFnb+rM2e8vyBkRxkMrMkM8qVikQaWQ==
X-Received: by 2002:a65:6109:: with SMTP id z9mr8692542pgu.112.1604201197322;
        Sat, 31 Oct 2020 20:26:37 -0700 (PDT)
Received: from realwakka ([175.195.33.253])
        by smtp.gmail.com with ESMTPSA id s18sm9027148pgh.60.2020.10.31.20.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 20:26:36 -0700 (PDT)
Date:   Sun, 1 Nov 2020 03:26:22 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: device stats: add json output format
Message-ID: <20201101032622.GA1015@realwakka>
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

Hi David!
Thanks for review.

> 
> The overall structure looks good, ie. the separate object 'device-stats'
> and then the contents. For that the device id should be either key to a
> map, or we can put it into an array (where device id must be present
> too).

Thanks, You mean that devid should be key to json map? And I think that 
using as key is better than using array. Example should be like this.

{
  "__header": {
    "version": "1"
  },
  "device-stats": {
    "1": {
      "devid": "1",
      "device": "/dev/vdb",
      "write_io_errs": "0",
      "read_io_errs": "0",
      "flush_io_errs": "0",
      "corruption_errs": "0",
      "generation_errs": "0"
    }
  },
}

If so, I'll write a new patch for this.

Thanks,
Sidong

> 
> A check if the format is usable you can try to write a sample tool that
> parses some of the data and prints them. So eg. using python or jq and
> print stats of device 1. Which points out that device id is missing for
> example.
