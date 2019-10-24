Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD67E31D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439597AbfJXMIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 08:08:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42868 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439581AbfJXMIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 08:08:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so37434646qto.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eC/w8mQK+hZrHsnMW7E4ac2ts2YTrwLSa7+MG4nYjwM=;
        b=ck6+K4QJtLeZFS9RTm3mH2ov4n87jfZQKKpRuPqDzwfctAJRVs3Dv8URtm98OTaXpD
         03ZUBaiYLRj3iNzInUNBDOiTZkvu/F6kYFjACSYLRA/er2HsqHo8tJQTBmAX4VBt2ggc
         ZQOgKNfnP0EH9WH+LKp8w2Anfmq0WvXXNYafG96ihc5rjnSmVYgtOpLhWpQ3Tl94XwFJ
         n+2xrTSib2pLqPowZCoc9PdYeMd3SX2NILMA/iosadDCAtFgEc8TgZkK7J9UvYg5EL3q
         d6LL1yd8Z/IPzgCG3l6tt8k6/5YnDNEc+1Cv9huInQLV5xJmp++IETSLA9j9H03azAlc
         yL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eC/w8mQK+hZrHsnMW7E4ac2ts2YTrwLSa7+MG4nYjwM=;
        b=RmCDplTBg9rosZE+NkII/3RnaRzwS6aZpvkVdjfrvBs/PKlUNutRGxOjQCUNLjagh/
         LJO2mvo//IAOdIRI7IV6VY3YXf5dQjMEAyExeUyDL7NgTCxLUCAzKgd1APWO8zg/uMNx
         yCvfsGgLkymC9RSh8/XpffUObKRukHm7MAg/Twq3J6zfU/hBfUwVWGESjBeomQa+fCaK
         Jor/Q2q8Qfzyjfmpccv7IIJKvicjOK+bKdBJyjrMnZRNlRorXX4R/GPcVktgQZQMUuZg
         c28V3NipU648MuYUQvFNxuzOHXNWJ32vggvUW+6aIRRGX/vxMXLSQce/dyxq67mrGAlc
         3sxA==
X-Gm-Message-State: APjAAAXFcIT3y4TtQE/cnbxoz868RGT54mtz+WrpJ3kYJNLS7T0VZnMu
        BEz2ImBdAjl1aLctRaMCZlhmNA==
X-Google-Smtp-Source: APXvYqx/scmYLPmcPxpQx06VEhfgZsONXdUJ/28ijwReIXoNNADGXFcKP6gObqWKRGe3TraNSLPZXg==
X-Received: by 2002:a0c:814d:: with SMTP id 71mr2666443qvc.226.1571918927303;
        Thu, 24 Oct 2019 05:08:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y28sm12905980qky.25.2019.10.24.05.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 05:08:46 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:08:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com, jack@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: use READ_ONCE/WRITE_ONCE with the i_size helpers
Message-ID: <20191024120843.4n2eh47okn4c635f@MacBook-Pro-91.local>
References: <20191011202050.8656-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011202050.8656-1-josef@toxicpanda.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 04:20:50PM -0400, Josef Bacik wrote:
> I spent the last few weeks running down a weird regression in btrfs we
> were seeing in production.  It turned out to be introduced by
> 62b37622718c, which took the following
> 
> loff_t isize = i_size_read(inode);
> 
> actual_end = min_t(u64, isize, end + 1);
> 
> and turned it into
> 
> actual_end = min_t(u64, i_size_read(inode), end + 1);
> 
> The problem here is that the compiler is optimizing out the temporary
> variables used in __cmp_once, so the resulting assembly looks like this
> 
> 498             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff814b08c1 <+145>:   48 8b 44 24 28  mov    0x28(%rsp),%rax
>    0xffffffff814b08c6 <+150>:   48 39 45 50     cmp    %rax,0x50(%rbp)
>    0xffffffff814b08ca <+154>:   48 89 c6        mov    %rax,%rsi
>    0xffffffff814b08cd <+157>:   48 0f 46 75 50  cmovbe 0x50(%rbp),%rsi
> 
> as you can see we read the value of the inode to compare, and then we
> read it a second time to assign it.
> 
> This code is simply an optimization, so there's no locking to keep
> i_size from changing, however we really need min_t to actually return
> the minimum value for these two values, which it is failing to do.
> 
> We've reverted that patch for now to fix the problem, but it's only a
> matter of time before the compiler becomes smart enough to optimize out
> the loff_t isize intermediate variable as well.
> 
> Instead we want to make it explicit that i_size_read() should only read
> the value once.  This will keep this class of problem from happening in
> the future, regardless of what the compiler chooses to do.  With this
> change we get the following assembly generated for this code
> 
> 491             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff8148f625 <+149>:   48 8b 44 24 20  mov    0x20(%rsp),%rax
> 
> ./include/linux/compiler.h:
> 199             __READ_ONCE_SIZE;
>    0xffffffff8148f62a <+154>:   4c 8b 75 50     mov    0x50(%rbp),%r14
> 
> fs/btrfs/inode.c:
> 491             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff8148f62e <+158>:   49 39 c6        cmp    %rax,%r14
>    0xffffffff8148f631 <+161>:   4c 0f 47 f0     cmova  %rax,%r14
> 
> and this works out properly, we only read the value once and so we won't
> trip over this problem again.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Al,

Will you pick this up, or do you want me to send it along?  Thanks,

Josef
