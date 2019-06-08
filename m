Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A23A0A9
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2019 18:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFHQdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Jun 2019 12:33:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52922 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfFHQdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Jun 2019 12:33:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so4815991wms.2
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2019 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nn9sDzgPkR0HabZ31EILcxUmldc30Ih3BqI8IrawHLY=;
        b=nYhFEYoR1lu0BkTY7WHbXXvOZsZhLVA3CoRdDg4f5sDVL1R4bSCV0Cpmoj9BvcRD8o
         JEjXX6qpEZnl4eZBuLrt1BV4E+nvFxt7x/5FVoI9o1AECCBxb9Y2CGpKtWrbwTyrj6P6
         WtLBuXjL2y2TV4i47PrIRZD33itrVhxCj1rw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nn9sDzgPkR0HabZ31EILcxUmldc30Ih3BqI8IrawHLY=;
        b=GWPkNgRjQgVBwOwa4+e6DK4ZKIvmpzNlNg3JK4qmfyk+BO6+G2wdlYMX2XsPM3x0wU
         2dwIHq9LK4uPDOgpj1ilFPdcY1OHlZi4EUx2gqX7peV4koA6vGca1TLQFD+mK+3moIem
         tj+ZGn3e3oLPpK53h1yQMXhac8Tj3ngcefOQr1jZIO+0wXl1IDP6ITN09Ihqi9j1NuoM
         6xoagGeBIiSZLStPCFKTtxgrLI1DZJyDGxIiT/3eDoTi0tbXkIZvH2tfP51WL5/d2kr0
         P8YBzw2JcEtE04TzVFMwFnQXvo8zFC7Q18x+6gCT0owVeS+v1s6VRBGJlpWS3j8BYd7B
         7xfg==
X-Gm-Message-State: APjAAAU9V96HMShKCzNeVqIFlPbOE5g+pzDU2UqygJ1GQwo606HHLQKf
        euex3jvyfgBlxJqTLRsr8XMKcEMLT0P+1A==
X-Google-Smtp-Source: APXvYqwQh0ycELc4L2qCosigqNjSAGvgffgKCVuDNsK1MWHM5TfYBKDPRrE0rmxdcYVJOCaNfXfBVA==
X-Received: by 2002:a1c:5f85:: with SMTP id t127mr7494161wmb.104.1560011616260;
        Sat, 08 Jun 2019 09:33:36 -0700 (PDT)
Received: from andrea (ip-86-49-3-71.net.upcbroadband.cz. [86.49.3.71])
        by smtp.gmail.com with ESMTPSA id q14sm3930265wrw.60.2019.06.08.09.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:33:35 -0700 (PDT)
Date:   Sat, 8 Jun 2019 18:33:26 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, paulmck@linux.ibm.com
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Message-ID: <20190608163326.GA6573@andrea>
References: <20190606135219.1086-1-nborisov@suse.com>
 <20190606135219.1086-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606135219.1086-2-nborisov@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 04:52:18PM +0300, Nikolay Borisov wrote:
> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> to have multiple readers or multiple writers but not multiple readers
> and writers holding it concurrently. The code is factored out from
> the existing open-coded locking scheme used to exclude pending
> snapshots from nocow writers and vice-versa. Current implementation
> actually favors Readers (that is snapshot creaters) to writers (nocow
> writers of the filesystem).
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Interesting!  Thank you for sending this over, Nikolay.

I only have a couple of nits (below) to add:

[...]

> +
> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
> +{
> +	/*
> +	 * Atomic RMW operations imply full barrier, so woken up writers
> +	 * are guaranteed to see the decrement
> +	 */

Not every atomic RMW operations imply a full barrier (as exemplified,
e.g., by the atomic_inc() in btrfs_drw_read_lock()); maybe simply

  s/Atomic RMW operations imply/atomic_dec_and_test() implies/

FYI, checkpatch.pl issues a few warnings on this patch (you may want
to address some of them in the next version).

Thanks,
  Andrea


> +	if (atomic_dec_and_test(&lock->readers))
> +		wake_up(&lock->pending_writers);
> +}
> +
> +
