Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA51D4533
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfJKQRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 12:17:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39802 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJKQRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:17:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so14628258qtb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 09:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQs2v337/x5XTKpT+aju8RDy+ScHXQZT4Vv92pflqGY=;
        b=gXK+8Pe8SQ4+jEKDVV2NqwiDV+kQToAuQ37yFrt3qKedgJ0cmFliztHixnfuLE4do0
         rodK99CRyv1dNSi+Cyy/dtrFgKAeidsckfZnMyqrF6/ICR0DROnvtg0Ipl5G7J1BD7M1
         /RbfCMN1gWC5T/hxA9qUfnmkOG+73ZSZI/7q33LBhqZxTq4ae41f78yYOW4kjIaStqhK
         JZM87duEZOQXPa3ahB8gXTRmdIVBXNWJGRiuaW32YtquluhXWD2kltdByb2x4KDS4w+G
         Io13vfT0lkDbVEwzhInyXP9Hj9vdAqrHE1iYBZslSPPsDGAzOpZbOP78/hUGH9DeQP7s
         NJnw==
X-Gm-Message-State: APjAAAUFhtjWt+isVahTtIq0EjnXev7uPOWxd2u4XiQOBwe9BCGLeYrI
        otBrQ50BBcLoO//KV5XH4RRqvJCf
X-Google-Smtp-Source: APXvYqyU9eZow8OAxQmO2REwvqwdDZ39wOb+YQweQIlhddFS0w4tusgHKrEXV5eMzZ6lv1F+f5+iaA==
X-Received: by 2002:ac8:3969:: with SMTP id t38mr17494985qtb.253.1570810632602;
        Fri, 11 Oct 2019 09:17:12 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::2:985b])
        by smtp.gmail.com with ESMTPSA id o14sm6377240qtk.52.2019.10.11.09.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:17:11 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:17:09 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/19] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191011161709.GC29672@dennisz-mbp>
References: <cover.1570479299.git.dennis@kernel.org>
 <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
 <20191010141629.xzlwkf6tn57dsdnv@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010141629.xzlwkf6tn57dsdnv@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 10:16:30AM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:35PM -0400, Dennis Zhou wrote:
> > There is a cap in btrfs in the amount of free extents that a block group
> > can have. When it surpasses that threshold, future extents are placed
> > into bitmaps. Instead of keeping track of if a certain bit is trimmed or
> > not in a second bitmap, keep track of the relative state of the bitmap.
> > 
> > With async discard, trimming bitmaps becomes a more frequent operation.
> > As a trade off with simplicity, we keep track of if discarding a bitmap
> > is in progress. If we fully scan a bitmap and trim as necessary, the
> > bitmap is marked clean. This has some caveats as the min block size may
> > skip over regions deemed too small. But this should be a reasonable
> > trade off rather than keeping a second bitmap and making allocation
> > paths more complex. The downside is we may overtrim, but ideally the min
> > block size should prevent us from doing that too often and getting stuck
> > trimming
> > pathological cases.
> > 
> > BTRFS_FSC_TRIMMING_BITMAP is added to indicate a bitmap is in the
> > process of being trimmed. If additional free space is added to that
> > bitmap, the bit is cleared. A bitmap will be marked BTRFS_FSC_TRIMMED if
> > the trimming code was able to reach the end of it and the former is
> > still set.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> I went through and looked at the end result and it appears to me that we never
> have TRIMMED and TRIMMING set at the same time.  Since these are the only two
> flags, and TRIMMING is only set on bitmaps, it makes more sense for this to be
> more like
> 
> enum btrfs_trim_state {
> 	BTRFS_TRIM_STATE_TRIMMED,
> 	BTRFS_TRIM_STATE_TRIMMING,
> 	BTRFS_TRIM_STATE_UNTRIMMED,
> };
> 
> and then just have enum btrfs_trim_state trim_state in the free space entry.
> This makes things a bit cleaner since it's really just a state indicator rather
> than a actual flags.  Thanks,
> 

That makes sense. I've gone ahead and done this for both this state and
the block group discard state. FWIW, at the time I didn't know what I
would need and flags was just easier to iterate on. I agree this is
nicer.

Thanks,
Dennis
