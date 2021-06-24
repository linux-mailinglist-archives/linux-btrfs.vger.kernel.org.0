Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60963B274C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFXGRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 02:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFXGRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 02:17:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF21C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 23:14:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e33so3869806pgm.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 23:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1OJqZ/QIcBDy8sybu98JPQTBBJnoCTUnMzw1F6ER0So=;
        b=0FG5lPc1+hCO8lyN+ScMXNSFrKPUfkzushS6MV+G1DcGXg/cN/4o+ssceHVkn/BSH8
         w+NlPMHiyGG9JakM0+ZweeixZhjWbDbbS7BblCCiQGeHkfcgwfEWmFZjtZAdL8fZ9aU1
         Rj6YhNcZIyc3u93zXlpXWT/MlXRPADUH86lv+YAwdoWRwuYKQ+i8bHuF4b/p1noGcvPC
         ejBH8Ko3OptDf0m/rifDNRWVxPJpTiGfidxbk+wUbmVgd8TSWqfZBMu7yvlJMz0Lz1Fm
         Fwrk7Wa9IDhTthhEkOTCRo4Bk/PaE/KMnF8V989jISLO6V8ScaHJISAsuOpUseJOeAVK
         /yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1OJqZ/QIcBDy8sybu98JPQTBBJnoCTUnMzw1F6ER0So=;
        b=KCOXw0DkeKtMu7BJlZXzuoLuJZIWdsKX7dRpW7t6oLXgEUwNVMGbmpPuoTKy1zo2nu
         TPi1oIMFpRfqdA7a9j8odDruK49VLre/vWG6QzyE3xjCIH/tQPldsw8E4j5hB+S/AClZ
         k60K/rR2dhKOiuZ0zDvClJEZJa2J2b7Xf3NEpgGNyU0i/HCPMRrh8OaWmmK8NBr8WE8A
         GMyqFNLMeQlMDsn9o9+uUceqJkb+jOXBeZ2KsjQBQyf77a8BqYzTme9xjB9l2IkEd/SE
         lykwTw5X2WtxmK3XyGAEhhzeNLAtLOHNE4133ZRKJ6b9Ezf02m4ZcSX1XoBB9E3LXnsf
         FIsg==
X-Gm-Message-State: AOAM531Pq7Owt5l+siz56bVn/duqm3/S/iq4ct2vOUG4rbKdpV/GkITm
        o3gQZ+js7UC2yCouzu5n0BKBUA==
X-Google-Smtp-Source: ABdhPJzvJif9dvfXZXH1pxwSpQAluO7dKKyV55/1jIcfUr2aXYMHZnvlLjRepXqVmW0ITeKoFf27bg==
X-Received: by 2002:aa7:8615:0:b029:303:4428:9dbe with SMTP id p21-20020aa786150000b029030344289dbemr3511287pfn.17.1624515297163;
        Wed, 23 Jun 2021 23:14:57 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e167])
        by smtp.gmail.com with ESMTPSA id c22sm1619576pfv.121.2021.06.23.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 23:14:56 -0700 (PDT)
Date:   Wed, 23 Jun 2021 23:14:54 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNQi3vgCLVs/ExiK@relinquished.localdomain>
References: <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNPnRyasHVq9NF79@casper.infradead.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 24, 2021 at 03:00:39AM +0100, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 02:58:32PM -0700, Omar Sandoval wrote:
> > But what you described would look more like:
> > 
> > 	// Needs to be large enough for maximum returned header + data.
> > 	char buffer[...];
> > 	struct iovec iov[] = {
> > 		{ buffer, sizeof(buffer) },
> > 	};
> > 	preadv2(fd, iov, 2, -1, RWF_ENCODED);
> > 	// We should probably align the buffer.
> > 	struct encoded_iov *encoded_iov = (void *)buffer;
> > 	char *data = buffer + encoded_iov->size;
> > 
> > That's a little uglier, but it should work, and allows for arbitrary
> > extensions. So, among these three alternatives (fixed size structure
> > with reserved space, variable size structure like above, or ioctl),
> > which would you prefer?
> 
> Does that work for O_DIRECT and the required 512-byte alignment?

I suppose the kernel could pad the encoded_iov structure with zeroes to
the next sector boundary, since zeroes are effectively noops for
encoded_iov. (As an aside, RWF_ENCODED is always "direct I/O" in the
sense that it bypasses the page cache, but not necessarily in the sense
that it does DMA to/from the user buffers. The Btrfs implementation
doesn't do the latter yet.)
