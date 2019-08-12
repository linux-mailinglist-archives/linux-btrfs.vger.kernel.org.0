Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4C8A683
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHLSsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 14:48:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39034 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLSsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 14:48:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so49932442pgi.6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NesY3V4Ru88D+BdnCrDPAX2h7pz4iaqx1uEOPTIuto=;
        b=NLdzLNfeJm+NUGz6JV+aMlLfh8k1BWMvvuxbxDwNTKC7IbMkK0qxb8ogV20BTnt0oc
         TYeKMrjCnnuuxuo+EjUa5d0OO06oy3zOprom551QHhKZ5cBCsWMSUw3YV42RPe0a19Cf
         u5mSAEVt+dflT9US8GYaKBh7pqDkbQK+lq7fpzVR+mM2Ic0FTAo1cAU/6es6/c7PY803
         KOwp0lXvOj+AFEJRO/kH5xMbRNBJyY4B14Fes2D5pf/gIgQx41ySr55iP/36h0b8Fyy1
         mnaVL1IZZBqcQQAr+ZYvGFDEMoY9NTz4CBHP+XJ+2pYGSE3YwZD6EOs167VNYK9Z0+WN
         aZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NesY3V4Ru88D+BdnCrDPAX2h7pz4iaqx1uEOPTIuto=;
        b=BBtj26wmAB8eHgHp/E9n+mcg6ER4QIcLLyJVHd/zwpAhBwO5b0NWr7RaG7dAmUZ2eB
         zK/Vk/9RFC/4O2Wetr0Zd8APY2tEEyxbRvFS0td2ZRdtPooM3v7ITy7IwjyumOIXTF78
         R4w/dY3Alu6TnxTgTafFi0qGaU7XQ/9GpQ9k0BXrizoutMLdrSqTyjWozcqA6MvS2ISe
         S/znV3ZNSIdJ2Jr4/aOleboAVQxv1UMfhdLu0qP3nBnFcVzMl6+Auz2rLnYWe0dfWNOT
         MK1uv86n/eAQ1Jq6zvtZ75CAKBuYujjVEgVfmFtUUiauqaSD5pd68wzC5BvyXP97WUCE
         9ciA==
X-Gm-Message-State: APjAAAX88g+5dnsyPEgIvPOxYF0DJp66/4D3VN/oeFFIg4rYmzRrFo9I
        wFty3b5KcxohnTje107C7gnyzg==
X-Google-Smtp-Source: APXvYqzewEhz5ULMYniBBSHFqxZ7Okb5JiVZaFjY3IpRJgvLRKptsnpIdqFd40A/9Hvz2vXXxAdvWA==
X-Received: by 2002:a65:6281:: with SMTP id f1mr29593143pgv.400.1565635693813;
        Mon, 12 Aug 2019 11:48:13 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3ef0])
        by smtp.gmail.com with ESMTPSA id r4sm3165576pfl.127.2019.08.12.11.48.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 11:48:13 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:48:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
Message-ID: <20190812184812.GA4142@vader>
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
 <CAL3q7H4cSMNSKfQKtFk9Q5Shw3VxMFZQ0E7uusL0efHzyN3MXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4cSMNSKfQKtFk9Q5Shw3VxMFZQ0E7uusL0efHzyN3MXw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 12:38:55PM +0100, Filipe Manana wrote:
> On Tue, Aug 6, 2019 at 6:48 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > We hit a the following very strange deadlock on a system with Btrfs on a
> > loop device backed by another Btrfs filesystem:
> >
> > 1. The top (loop device) filesystem queues an async_cow work item from
> >    cow_file_range_async(). We'll call this work X.
> > 2. Worker thread A starts work X (normal_work_helper()).
> > 3. Worker thread A executes the ordered work for the top filesystem
> >    (run_ordered_work()).
> > 4. Worker thread A finishes the ordered work for work X and frees X
> >    (work->ordered_free()).
> > 5. Worker thread A executes another ordered work and gets blocked on I/O
> >    to the bottom filesystem (still in run_ordered_work()).
> > 6. Meanwhile, the bottom filesystem allocates and queues an async_cow
> >    work item which happens to be the recently-freed X.
> > 7. The workqueue code sees that X is already being executed by worker
> >    thread A, so it schedules X to be executed _after_ worker thread A
> >    finishes (see the find_worker_executing_work() call in
> >    process_one_work()).
> >
> > Now, the top filesystem is waiting for I/O on the bottom filesystem, but
> > the bottom filesystem is waiting for the top filesystem to finish, so we
> > deadlock.
> >
> > This happens because we are breaking the workqueue assumption that a
> > work item cannot be recycled while it still depends on other work. Fix
> > it by waiting to free the work item until we are done with all of the
> > related ordered work.
> >
> > P.S.:
> >
> > One might ask why the workqueue code doesn't try to detect a recycled
> > work item. It actually does try by checking whether the work item has
> > the same work function (find_worker_executing_work()), but in our case
> > the function is the same. This is the only key that the workqueue code
> > has available to compare, short of adding an additional, layer-violating
> > "custom key". Considering that we're the only ones that have ever hit
> > this, we should just play by the rules.
> >
> > Unfortunately, we haven't been able to create a minimal reproducer other
> > than our full container setup using a compress-force=zstd filesystem on
> > top of another compress-force=zstd filesystem.
> >
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks good to me, thanks.
> Another variant of the problem Liu fixed back in 2014 (commit
> 9e0af23764344f7f1b68e4eefbe7dc865018b63d).

Good point. I think we can actually get rid of those unique helpers with
this fix. I'll send some followup cleanups.
