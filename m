Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607713F120E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 05:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhHSDpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 23:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhHSDpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 23:45:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC76C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:44:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 18so4227861pfh.9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46Eod5bZTfUuy05HteCnt6lrruym3g7tn9Gl1w7bPaY=;
        b=P/DhH6FddUQSUwGLMaOlyzh/xZBdIi3H87tzfb0u14hiM2Xr9hnNejb/kROGJX4mmO
         qfLtLQY2OAXYqxzFeGDiIway/+8j03G2oWuQ1WUmfU2xTfyhJS/V9noY4bv4zBPrKImH
         Up3cewRxLZQ8eatMzkJqVE94sRUO/W4iAtn7vDS8aYsVW99Fl49nNVwBqmVm4j7NnD1S
         HcJhtdS1rHOrpwsfRPwecwD2FuRC3dTGTLB5Vcgjq4iRyp8j7POYiAoJy8QIZN3oV3Sh
         s4BBHq0gbpnzZZkhQXBDOaXwxfD7OV0JKi/SsVG3QF+vqTCKtRjnQwg2FBpLUxYek5BR
         JYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46Eod5bZTfUuy05HteCnt6lrruym3g7tn9Gl1w7bPaY=;
        b=eEmMnMao93JgEQg+VWy+saFPMVKkFWfIHtYWw70rGE48cXAt/6p1AD2wIdKwIFJ4j8
         Tf9fLVAXCaKZIXRlLuETUxryQTM6RD+aipSJoG0ATUQ7HKeSUUjORTOQprqCzJIbE4jM
         IiBD9XQ0bUk7qpxPJYZLqdlnVVWlMiNb/yGABypTW2Y6ITTikW6B4zfjR81LSWiUNTg4
         hxp9KKov/dkSwp7eOCi9Am7aLXyRs11G8MwnYzF1VGshTsCvBu0wjC2Czc3DZ7PgpnJv
         XAerQoBDDi9f18iPskefxMceFdY1yhOrHnPWfJJ1bYyECBok7xYAWaOei0asm6U7oa4+
         paKw==
X-Gm-Message-State: AOAM532I/l019azw7kW4aXmazX4Qr6tEiExYP+In/Q+mO78gz0wuLRPJ
        IjlYUuj6TMi5gEDTaDqinV8=
X-Google-Smtp-Source: ABdhPJxfv07ccFHO1hhA996qFy5ySOtY71FKNsjITHEVjyCRSfTfPp9ypq1140zZVZ7YLCvLfW8P2w==
X-Received: by 2002:a63:d001:: with SMTP id z1mr12304629pgf.368.1629344678079;
        Wed, 18 Aug 2021 20:44:38 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t5sm1306957pfd.133.2021.08.18.20.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:44:37 -0700 (PDT)
Date:   Thu, 19 Aug 2021 03:44:33 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210819034433.GB1987@realwakka>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz>
 <20210818003819.GA2365@realwakka>
 <20210818165924.GV5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818165924.GV5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 06:59:24PM +0200, David Sterba wrote:
> On Wed, Aug 18, 2021 at 12:38:19AM +0000, Sidong Yang wrote:
> > On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
> > > On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> > > > This patch adds an subcommand in inspect-internal. It dumps file extents of
> > > > the file that user provided. It helps to show the internal information
> > > > about file extents comprise the file.
> > > 
> > > Do you have an example of the output? That's the most interesting part.
> > > Thanks.
> > 
> > Thanks for reply.
> > This is an example of the output below.
> > 
> > # ./btrfs inspect-internal dump-file-extent /mnt/test1
> > type = regular, start = 2097152, len = 3227648, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> > type = regular, start = 5324800, len = 16728064, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> > type = regular, start = 22052864, len = 8486912, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> > type = regular, start = 30572544, len = 36540416, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> > type = regular, start = 67112960, len = 5299630080, disk_bytenr = 0, disk_num_bytes = 0, offset = 0, compression = none
> 
> This resembles a debugging output, something like we have for
> tracepoints but I think this should be more human readable, with
> possiblity of parsing by scripts/tools.

Yes, I agree. I think It would be text or json.
> 
> So to not just duplicate what filefrag or xfs_io -c fiemap do, we can
> optionally enhance the information with the specifics of btrfs, like on
> which devices the extents are, which compression is there etc. But the
> basic output should be more or less like filefrag.

Yeah, this is the limit for this patch. for more than filefrag or
xfs_io, it should provide more specifics. compression type is already
included. But it would be better that it describe which device 
has the extents. it goes to v2.

