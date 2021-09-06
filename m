Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C194019B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhIFKXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbhIFKW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 06:22:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A4C061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 03:21:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so6347796pgp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AeqEjAjoVtdDfMWVAl3b+HRpioWUyzx2K+dqmlkc1WY=;
        b=X3RWfHG0gMnPiT6NR/djXNXiD/vy5aXU5oIVoeNrzT/PhJfPyc6fR9+uZ2EfnSZZnN
         fPQOSACgxodv1rKeTtj3A1yb7Po6tOIb5j/srqLWN0yW6azqioa7KZIA4ON5+SYDWNVp
         Tf46Kc778N26sZaQ3iegwUeXMqC0G0O9HG8U1XjP1vYErlYTZ4KUhRl2YYZGqcRIfb6r
         3WjkA1hgSEdQW2Bkd0K/aSduQnSEmozou4MmBd3EJtZL6rNaaBSwTG4sOpjmY1xjrErQ
         Ts7LCLNh2mOB8lhnIisInlZUoyiyvb6MSVDbKn+IZjBLNlxYfjikz+JozWia3QUlAeyR
         4R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AeqEjAjoVtdDfMWVAl3b+HRpioWUyzx2K+dqmlkc1WY=;
        b=AfiSnxdPWP5n0YV6Us+a3fHd3GAXjfrS+weyJcLfpZHW8OFH3yicWrG0tJJfyMvltD
         UotmrjcHo0w8L9G7RwA9nn5bR32QQRN6prxkHd2XGz3jyYGZiS0hOoPLjZ9//go7AQeQ
         LufgL7eEoig2UosBuNANhLxyOUrUQQI+fFZBa0vq4DLcFzUyHdfuG6h7JI5aYQmNpLMJ
         anWqS6D5kxWuFTEU6Yb33FqzV/5pSQS2W8/ol48rncx0aDUBtdKFjZ1rngWU8V76qWQ/
         8OAzj5FYV7dAKHikkEZR2aGvNoo/IOih+lcDy3UGucNEJ6+CKmmtUCbmsaWmGlrqr/sx
         wgXw==
X-Gm-Message-State: AOAM530fdHo49SogGzGyo3mAtzYC9FkgFEBVTLZ24S0RNnfA+TLuS/wz
        Lv/bCYHiccrAMkuKDP1utmPCoEuBjkE=
X-Google-Smtp-Source: ABdhPJzNYSITVXOUwzjF1ZDJdb0LR8BPJbrySsu3BxSnZeG4mnc++Lj15PUTB87Iv3+mKnc9DokSaA==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr11493088pgl.67.1630923714380;
        Mon, 06 Sep 2021 03:21:54 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n15sm7471359pff.149.2021.09.06.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:21:54 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:21:50 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: An question for FICLONERANGE ioctl
Message-ID: <20210906102150.GB2467@realwakka>
References: <20210905121417.GA1774@realwakka>
 <526c81c1-1362-e24d-6664-2028c46f6353@gmx.com>
 <20210906055704.GA2467@realwakka>
 <3544e1ef-7723-0de2-471b-658bc1ba145e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3544e1ef-7723-0de2-471b-658bc1ba145e@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 06, 2021 at 02:30:21PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/6 下午1:57, Sidong Yang wrote:
> > On Mon, Sep 06, 2021 at 09:13:06AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/9/5 下午8:14, Sidong Yang wrote:
> > > > Hi, All.
> > > > I've tried to handle btrfs-progs issue.
> > > > (https://github.com/kdave/btrfs-progs/issues/396)
> > > > 
> > > > And I tested some code like below.
> > > > 
> > > > src_fd = open(src_path, O_RDONLY);
> > > > if (src_fd < 0) {
> > > > 	error("cannot open src path %s", src_path);
> > > > 	return 1;
> > > > }
> > > > 
> > > > dest_fd = open(dest_path, O_WRONLY|O_CREAT, 0666);
> > > > if (dest_fd < 0) {
> > > >       close(src_fd);
> > > >       error("cannot open dest path %s", dest_path);
> > > >       return 1;
> > > > }
> > > > 
> > > > range.src_fd = src_fd;
> > > > range.src_offset = src_offset;
> > > > range.src_length = length;
> > > > range.dest_offset = dest_offset;
> > > 
> > > Mind to give an example of the value?
> > It was src_offset = 0, src_length = 10, dest_offset = 0.
> Oh, that's the case.
> 
> > 
> > > 
> > > One quick hint to the invalid arguments is:
> > > 
> > > - Range alignment
> > >    The src/dst offset must be aligned to the block size of the
> > >    filesystem.
> > >    For btrfs, the sectorsize is currently the same as page size,
> > >    thus both src/dest and length must be aligned to 4K for x86.
> > 
> > I think it's because of this. I set too small value. It works with
> > length 4K. If reflink cmd in btrfs-progs exists, Users should set the
> > length aligned?
> 
> Reflink/clone/dedupe all work based on block size.
> 
> Currently all these major files systems (ext*/xfs/btrfs/f2fs) in linux
> are block filesystems, which means block size is their minimal unit of
> read/write.
> 
> For data stored on-disk, they are all aligned to block size and smaller
> ranges are padded to meet block alignment.
> 
> So is such ioctls (and things like direct IO).
> 
> Thus no matter what the user-space wrapper is, the kernel ioctl still
> requires block size alignment.

I understood that all datas are aligned to block size.
Thanks a lot for detailed description!

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Sidong
> > > 
> > > Thus a more detailed example can be much better for us to understand the
> > > problem.
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > ret = ioctl(dest_fd, FICLONERANGE, &range);
> > > > 
> > > > And this ioctl call failed with error code invalid arguments when length!=0.
> > > > I tried to understand FICLONERANGE man page but I think there is no clue
> > > > about this. I traced kernel code and found out it goes fail in
> > > > generic_remap_checks(). There is an condition checks if req_count is
> > > > correct size and it makes test code fails.
> > > > 
> > > > I don't know about this condition but it seems that it can be passed for
> > > > setting REMAP_FILE_CAN_SHORTEN. Is there any way to setting remap_flags
> > > > in FICLONERANGE ioctl call?
> > > > 
> > > > Also it would be pleased that if you provide some documentation about
> > > > this.
> > > > 
> > > > Sorry for writing without thinking deeply.
> > > > 
> > > > Thanks,
> > > > Sidong
> > > > 
> > 
