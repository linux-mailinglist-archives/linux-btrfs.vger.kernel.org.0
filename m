Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABDC851BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbfHGRI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 13:08:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35697 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388816AbfHGRI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 13:08:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so41735798plp.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6BpKP3vLVzOIJQvbku5iz000RW/wTStqWNBDYg4+HEQ=;
        b=unb+LlK5qgXerYuJjTEFek9tHyUeszgxYN2A71aZ9ZVlYidWEFlnOcphNYB4DiUqLa
         HQRHZebSzQKAva4AIrZ+0euAweLiKGetQIObeWlM71P1RgRqqhoNQWPx61rBoTTdkseY
         SpH8SU9PBv9BcnKKLxSKtvvQnxsFvfxJtQTIIP5ByuB4ofKkL49pEQkICLjvrTB+4TH3
         ptEDV9ErWUCefxjuHQyp+ALjTMUHRFreNgti3+lasp5dMpV4tjsdSstgm1cRuimNXtjv
         ztIzLvijs+VllBM3RiRYSo9+oRk6hx4rIdogf7TLBaRxBQPzaE7Fzt7N7UjKQUAn7PwE
         CZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6BpKP3vLVzOIJQvbku5iz000RW/wTStqWNBDYg4+HEQ=;
        b=VySzhOmpQLFffZbsGk4bfNQD0fAEyUNVq/nzxJsHAW2mmwUxZioSS1flk4krGZQDny
         RktHBmZdra0xCPm38Pin9Z8fNvHtQocD70zqri6jNsdfKGEUO5jahttkfcMORbP9Jhk9
         9HJEPlEPqYJqXoOASFFKLoMk2QO9d7Bq+zWa9FhBAB43VAd2vpCMFSbQsvS4+eZNsKWx
         VhWWo/PTthDGppLcW3VpQ9xLcFXa/zB7fscCqzs6iBytoOSBT1YJBaRjuaFUlHYuL8O0
         q8Xj9lLqndhJuZNTJX0gH+D1LdQ07ACJYhurWadSVkIKoSOjoQfCBT1U8OKy5pAonglE
         avVw==
X-Gm-Message-State: APjAAAWmFrjeifbccKEaSEP+xrJpVJZFjdtHc+Ab1OEEpRxIxSy9t2Ad
        8Tk8PThNspid0UOIgi/fV7QAuw==
X-Google-Smtp-Source: APXvYqytUNBUD/Qe72ZtrbmjCokhqf9LBLEDOdiG9LY8Et12MH3nkBz7NDyKEWSBY9W96wbRMzEfaQ==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr8813858pgc.12.1565197738474;
        Wed, 07 Aug 2019 10:08:58 -0700 (PDT)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id v14sm98191869pfm.164.2019.08.07.10.08.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:08:57 -0700 (PDT)
Date:   Wed, 7 Aug 2019 10:08:57 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
Message-ID: <20190807170857.GA18948@vader>
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
 <70f6b4fa-26b1-9225-7509-aa89bb7e067c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f6b4fa-26b1-9225-7509-aa89bb7e067c@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 10:17:26AM +0300, Nikolay Borisov wrote:
> 
> 
> On 6.08.19 г. 20:34 ч., Omar Sandoval wrote:
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
> 
> Isn't the bigger problem  that a single run_ordered_work could
> potentially run the ordered work for more than one normal work? E.g.
> what if btrfs' code is reworked such that run_ordered_work executes
> ordered_func for just one work item (the one which called the function
> in the first place) ? Wouldn't that also resolve the issue? Correct me
> if I'm wrong but it seems silly to have one work item outlive
> ordered_free which is what currently happens, right?

We can't always run the ordered work for the normal work because then it
wouldn't be ordered :) If work item N completes before item N-1, then we
can't run the ordered work for N yet. Then, when N-1 completes, we need
to do the ordered work for N-1 _and_ N, which is how we get in this
situation.
