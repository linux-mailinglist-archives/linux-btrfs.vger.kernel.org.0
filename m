Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7912845638E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhKRThl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 14:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhKRThl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 14:37:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB28C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:34:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso6703915pjb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B4LvMygTJj8QSegSj2ejFP09c4vIVt3wcnl9LGOxu9s=;
        b=XLPD9fOruqDX5hv+eluY5uzJh5N/avUwA5qaVupwEhrOwb0psPc+SvhuJ0C9k7CWHV
         XO4CjVJLsiejNw90xfdPgOnB0T+kQ4eFe6HyyulGtfZFrHLrYLsUW6GcFFF5v0ZkaQcG
         X2slvjVCrUSyAS4ZQ6fqsynnVOs6nolyE7Dya1+QYNd1QzT771X6A6/CKrSoy3k6BGWP
         W+YKd3rSj/j4XyLuvHNVlLCaz6Z79KYaSfoSIux7bF10IqEYaodxhaKbrwxQMxXlVNXS
         swY+xclQLmj2fhuVNEMx+SFNvDQfCEBL2wg6ASYON25nkzGzT20qtbH8uqGwqi4RRi01
         kL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4LvMygTJj8QSegSj2ejFP09c4vIVt3wcnl9LGOxu9s=;
        b=gRMWBUjnuBrPjQrwGYx4e4Vie/gcHRg/GAFKcUt9TdQPApVpeOsv+/BcYkPTJThoLr
         UTLpM1kwek1egWil1vpzQa+ilu6iIfu2D82DP+d2PJvM3SHQzNN4If3tmcVLX6K5VXUZ
         a087QwTc+C4oLbc/0lBT2tzxdt213aElyrNfqHblLHNt/HE/TOymp6P95RC0HPKbYNkf
         vp6ObLQJO23xrU8gFjbPUZ4UgXHpDMYSSEy4KfNCtKIAIKrHhwX3Kph4GtR7VKdxSI9Y
         Iq9HFkwMZrISuwHIxPP99YBd9h5E7U4pvS+5zbdgwGBsggwEH4mzrCGtyTQ2eiMhtXJa
         FDFQ==
X-Gm-Message-State: AOAM530i01EIs5Y21ERHTEF1mHdUerNlgZ+3Ykih0pxiOHM72O6lY4Pk
        R29Q7KvmpPtTrYoO7Zr/SpDfNT352xWkZA==
X-Google-Smtp-Source: ABdhPJyuHCTRHVhAtKU/MiiCum42dLaP9rymOIxwqOR0kv7rBkS8rtb6+ZEh5fNmkTaZ8YEcP0HXvg==
X-Received: by 2002:a17:903:2341:b0:142:1b63:98f3 with SMTP id c1-20020a170903234100b001421b6398f3mr69946719plh.49.1637264080142;
        Thu, 18 Nov 2021 11:34:40 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:174e])
        by smtp.gmail.com with ESMTPSA id y130sm353912pfg.202.2021.11.18.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:34:39 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:34:37 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 14/17] btrfs: send: write larger chunks when using
 stream v2
Message-ID: <YZaqzbXFlNLkBGYf@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <051232485e4ac1a1a5fd35de7328208385c59f65.1637179348.git.osandov@fb.com>
 <20211118155037.GH28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118155037.GH28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 04:50:37PM +0100, David Sterba wrote:
> On Wed, Nov 17, 2021 at 12:19:24PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The length field of the send stream TLV header is 16 bits. This means
> > that the maximum amount of data that can be sent for one write is 64k
> > minus one. However, encoded writes must be able to send the maximum
> > compressed extent (128k) in one command. To support this, send stream
> > version 2 encodes the DATA attribute differently: it has no length
> > field, and the length is implicitly up to the end of containing command
> > (which has a 32-bit length field). Although this is necessary for
> > encoded writes, normal writes can benefit from it, too.
> > 
> > Also add a check to enforce that the DATA attribute is last. It is only
> > strictly necessary for v2, but we might as well make v1 consistent with
> > it.
> > 
> > For v2, let's bump up the send buffer to the maximum compressed extent
> > size plus 16k for the other metadata (144k total).
> 
> I'm not sure we want to set the number like that, it feels quite
> limiting for potential compression enhancements.

This is all we need for now, but we can always raise it in the future. I
amended the protocol and the progs send parsing code to assume no hard
limit.

> > Since this will most
> > likely be vmalloc'd (and always will be after the next commit), we round
> > it up to the next page since we might as well use the rest of the page
> > on systems with >16k pages.
> 
> Would it work also without the virtual mappings? For speedup it makes
> sense to use vmalloc area, but as a fallback writing in smaller portions
> or page by page eventually should be also possible. For that reason I
> don't think we should set the maximum other than what fits to 32bit
> number minus some overhead.

I think you're saying that we could allocate a smaller buffer and do
smaller reads that we immediately write to the send pipe/file? So
something like:

send_write() {
	write_tlv_metadata_to_pipe();
	while (written < to_write) {
		read_small_chunk();
		write_small_chunk_to_pipe();
		written += size_of_small_chunk();
	}
}

And from the protocol's point of view, it's still one big command,
although we didn't have to keep it all in memory at once.

If I'm understanding correctly, then yes, I think that's something we
could do eventually. And my description of v2 allows this:

-#define BTRFS_SEND_BUF_SIZE SZ_64K
+/*
+ * In send stream v1, no command is larger than 64k. In send stream v2, no limit
+ * should be assumed.
+ */
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K

Although receive would have to be more intelligent about reading huge
commands.
