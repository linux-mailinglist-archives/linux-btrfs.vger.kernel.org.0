Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BC3B22DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWWAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129ECC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 14:58:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p9so2953256pgb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r2UNKgTUUs/s5pdYR+gWIgnFubX0A76AAg6/thi7cE8=;
        b=ZaHHdvguZ0xd3NmSIqoCLOKlDyQvfl5ByvylHjYV6TGQ8pbQ/NrkpPT7+r7PW/ujyR
         CM6Ub6+GpjRYmKZH6p5gu+CzpvFcydsUHKfnsdc08Hq/h999ewI9b6mfqL121QhasTXu
         G+AzOk48G6K0i70eIhgz6dGeSFxDbmWTRzza1SVsQhOLcHNjPeAD6hGleZ4c+YjAXMr4
         Ej2/6ApGDr6ASXcXsvZEU+XgpTtyF4EPeKCzoZyHpPff6LWF/5jHJ+asMuZh1QROjIvG
         2x+8DvWrhrPdCFQrqnQ9IxMwIQM96MwMyLk18j58hEMB3mzuO1kwkZOnhIizOEvcKpmz
         vtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r2UNKgTUUs/s5pdYR+gWIgnFubX0A76AAg6/thi7cE8=;
        b=GPGRj08xX/El/3Zn8ZoMVk22bBIrxEMXeqMU+Oxr5bVE+OckMM0IFJJONFvjzvH762
         pXBPC2Xh+oCW8Eq+Hp3KRi4FRAcrCFp5EnRxSf1a+p/a3Re6Lwf50U87nere22az+Tri
         a6dcJ/llrAfLWq1cY1wUmbZLG6MB88/t1F6MWViPCPc+QrKWs+r0/jyubQ4ktaKMRwKJ
         FQqfFg6snnqF5L4B6FmeFVvTqryWCoPVXAqe3nWPHRyFWJJ/GkMXAho3gMQaCBKNIlN8
         E5+X7hBvNkBt1FEYfzLAeufqKSIXUdXrPvOwnwT76ddCUEmNoBe27jRbv19htl7y3zC3
         mKCA==
X-Gm-Message-State: AOAM53036x4DfQ94e5aUpIGi3Xotl3G/8rGicLAbLKdaCth/04eDCe/f
        Ts7Lp3JtrL2iF9pMrgpVMvbm3w==
X-Google-Smtp-Source: ABdhPJw0rqSjci07+57s3OGUKYExIOG5QKf0c36rtSTIwR2b687MuR7d1m3eoskv43/ZZYiM9Bar3w==
X-Received: by 2002:a05:6a00:1741:b029:303:3cc2:b44a with SMTP id j1-20020a056a001741b02903033cc2b44amr1763328pfc.19.1624485514470;
        Wed, 23 Jun 2021 14:58:34 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e167])
        by smtp.gmail.com with ESMTPSA id j15sm715067pfh.194.2021.06.23.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:58:33 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:58:32 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNOuiMfRO51kLcOE@relinquished.localdomain>
References: <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 09:39:48PM +0000, Al Viro wrote:
> On Wed, Jun 23, 2021 at 01:46:50PM -0700, Omar Sandoval wrote:
> 
> > Suppose we add a new field representing a new type of encoding to the
> > end of encoded_iov. On the write side, the caller might want to specify
> > that the data is encoded in that new way, of course. But on the read
> > side, if the data is encoded in that new way, then the kernel will want
> > to return that. The kernel needs to know if the user's structure
> > includes the new field (otherwise when it copies the full struct out, it
> > will write into what the user thinks is the data instead).
> 
> Er...  What's the problem with simply copying that extended structure out,
> followed by the data?
> 
> IOW, why can't the caller pick the header out of the whole thing and
> deal with it in whatever way it likes?  Why should kernel need to do
> anything special here?
> 
> IDGI...  Userland had always been able to deal with that kind of stuff;
> you read e.g. gzipped data into buffer, you decode the header, you figure
> out how long it is and how far out does the payload begin, etc.
> 
> How is that different?

Ah, I was stuck on thinking about this calling convention:

	struct encoded_iov encoded_iov;
	char compressed_data[...];
	struct iovec iov[] = {
		{ &encoded_iov, sizeof(encoded_iov) },
		{ compressed_data, sizeof(compressed_data) },
	};
	preadv2(fd, iov, 2, -1, RWF_ENCODED);

But what you described would look more like:

	// Needs to be large enough for maximum returned header + data.
	char buffer[...];
	struct iovec iov[] = {
		{ buffer, sizeof(buffer) },
	};
	preadv2(fd, iov, 2, -1, RWF_ENCODED);
	// We should probably align the buffer.
	struct encoded_iov *encoded_iov = (void *)buffer;
	char *data = buffer + encoded_iov->size;

That's a little uglier, but it should work, and allows for arbitrary
extensions. So, among these three alternatives (fixed size structure
with reserved space, variable size structure like above, or ioctl),
which would you prefer?
