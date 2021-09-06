Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272A340161E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 07:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhIFF6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbhIFF6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 01:58:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E9C061575
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Sep 2021 22:57:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so5674796pgf.5
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Sep 2021 22:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hkn91udIkldYGs/d0DcsITcmtG9k3LaXfmAddPhrYmY=;
        b=nWb0fKqpxeH3PzRAbzOzdd72VPSN7IoVDl49PEkPz96zIQzzS7geUXkyIgWs+SfEFl
         gvz0jYlPL5/iK4hDyinE7UzfCZ+IqYJGPReV7pMb0OZaq06PK7yaEo7ZxBRhCWwAhh19
         Xr0pb5EW5SV5O0XW6MxJWcV28JJk89IE08kwzjAHvphw0WRwWEXu19LsFeZPx/qTFB1/
         AcfQYNvbeyI28jx2zXjXW8usxu8dJmPeYoS7WBEom9QWHwp3USyXhAMNXJMd2gIgf1wc
         p8B/ObNNrF5wfXWzxfctqVqC/Y+/IIzmgsgz/TFNq7Y0Jv80vpLjPKoYPel+zXt3M32R
         hU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hkn91udIkldYGs/d0DcsITcmtG9k3LaXfmAddPhrYmY=;
        b=Ppk10nXlHvC7n/ealX4EOMluOLy1fDZe3EXQ6Xiuln6reI1as8wR4uzm2pltBmzsUP
         c0E+wwIysDKM6PJsJ98F01wxu5ScnyiZWwCC7jAbJvkG4Pw4GDeJ8lcxoOCBegz296Xg
         dOPKmiodWbbIpm04AoEWP7bodLzQM2+6wwImR4my4clRymEu39DaCOak66tndIWWoq9J
         jVTWY7qkpfKPRSxO6KcNns3NFYMHsKYxEZvdPnWfLu0DzHvg31XGFQNT7SCoBlc+UPdB
         Qu1KO/1yMhFiXM7GyZz9RoM7Ybux+EVM6SETBVmUo+w7kpmO3gTHWPPYsiFifdix/FY7
         v8Uw==
X-Gm-Message-State: AOAM5337ngXbSrdRf7X6B9QARYRPMzHPdFd0UGILNRQHp1zylItlrdkC
        ltr3/19V17RNOaFbG97+jky/3WOV9Fg=
X-Google-Smtp-Source: ABdhPJydZ39R44byjaBOHeZ87wMsxum5Jf+HNkAJnzmVUYj3bvPAK6FCSRoSurCqtzq/m1/p3h44ig==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr10917009pgm.324.1630907833002;
        Sun, 05 Sep 2021 22:57:13 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 22sm7599455pgn.88.2021.09.05.22.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 22:57:12 -0700 (PDT)
Date:   Mon, 6 Sep 2021 05:57:04 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: An question for FICLONERANGE ioctl
Message-ID: <20210906055704.GA2467@realwakka>
References: <20210905121417.GA1774@realwakka>
 <526c81c1-1362-e24d-6664-2028c46f6353@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <526c81c1-1362-e24d-6664-2028c46f6353@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 06, 2021 at 09:13:06AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/5 下午8:14, Sidong Yang wrote:
> > Hi, All.
> > I've tried to handle btrfs-progs issue.
> > (https://github.com/kdave/btrfs-progs/issues/396)
> > 
> > And I tested some code like below.
> > 
> > src_fd = open(src_path, O_RDONLY);
> > if (src_fd < 0) {
> > 	error("cannot open src path %s", src_path);
> > 	return 1;
> > }
> > 
> > dest_fd = open(dest_path, O_WRONLY|O_CREAT, 0666);
> > if (dest_fd < 0) {
> >      close(src_fd);
> >      error("cannot open dest path %s", dest_path);
> >      return 1;
> > }
> > 
> > range.src_fd = src_fd;
> > range.src_offset = src_offset;
> > range.src_length = length;
> > range.dest_offset = dest_offset;
> 
> Mind to give an example of the value?
It was src_offset = 0, src_length = 10, dest_offset = 0.

> 
> One quick hint to the invalid arguments is:
> 
> - Range alignment
>   The src/dst offset must be aligned to the block size of the
>   filesystem.
>   For btrfs, the sectorsize is currently the same as page size,
>   thus both src/dest and length must be aligned to 4K for x86.

I think it's because of this. I set too small value. It works with
length 4K. If reflink cmd in btrfs-progs exists, Users should set the
length aligned?

Thanks,
Sidong
> 
> Thus a more detailed example can be much better for us to understand the
> problem.
> 
> Thanks,
> Qu
> > 
> > ret = ioctl(dest_fd, FICLONERANGE, &range);
> > 
> > And this ioctl call failed with error code invalid arguments when length!=0.
> > I tried to understand FICLONERANGE man page but I think there is no clue
> > about this. I traced kernel code and found out it goes fail in
> > generic_remap_checks(). There is an condition checks if req_count is
> > correct size and it makes test code fails.
> > 
> > I don't know about this condition but it seems that it can be passed for
> > setting REMAP_FILE_CAN_SHORTEN. Is there any way to setting remap_flags
> > in FICLONERANGE ioctl call?
> > 
> > Also it would be pleased that if you provide some documentation about
> > this.
> > 
> > Sorry for writing without thinking deeply.
> > 
> > Thanks,
> > Sidong
> > 
