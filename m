Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93F4A5923
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 10:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiBAJYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 04:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiBAJYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 04:24:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC5C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 01:24:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so2099468pjt.5
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xrOLwH6yHjFwSqIAnwu6p1khKfsuwaetmH0WZytQ+AM=;
        b=cocFpsXJO9ivhKcB4C2I9mfc3X9Z6zBZKA8IeYv6JhZVxfjFBIpcZgX3mpri24FKOD
         SwNiCBxzdX63AOB95/43fegSG+EKc9VzXuC4QFWW0i+1oLnU5UJZLdCBZ+mINUN8mOUX
         6wUsWuVZ7cb2THPa8IVHSGZHZjnVPur1JwagConDiD3db4F61309Ekt49cq4rtJrH1IH
         Mi3LKRPpwXKfPOL3XL6vjK/M5CintPAJ81d+J8+VSi7RjoP/Mt0hKzWDdr4KnW+AS19y
         wvN2PZ48/EXYZm9GTQamU0MpHTWYo6McsluXER0c3osBfWCaqTySqSOkPaiSRudfqhGO
         jVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xrOLwH6yHjFwSqIAnwu6p1khKfsuwaetmH0WZytQ+AM=;
        b=OQrT5izI1gs8kSbzxdpDnqGL13ft42QDvy0563G66dEIedyeHtIq6IEgGnveUfVX2I
         mOjW5Y9JfEQQ5A185Jq8r0U6kCBzlfr2IpuPt3DdM8ZmHxlhY1KL3F2R2qi2Wb6GU2g8
         AKzdlnWFLIKW/+vAnEuJxBTqe/ulHDqw8qSXmDEjNDTVKRD1VN1Md8fJ299ot6SkSiYO
         LRoC9eTqLxj+aw1OponXQ3ZiegWJp1GbKtCJNaAuadSwMiuKC7PpsLQDbb+Sx1C3RpvM
         iVGt1se7+xwJf9uXNWTAeS/UucGK+k55yIrMZdTufcACapFBIFnGz5HekHV0Sm9aWt2O
         0QUQ==
X-Gm-Message-State: AOAM532ExfVA450RXCQLO7OV+Ul7LhrV77YaIAxmKKfW7MzukbHOdTqc
        xTCLBNnqzth+58KjnhRddThBFtMElpvfZg==
X-Google-Smtp-Source: ABdhPJx93krc7ui/ZRId94805TlPZyeXtrHx8Zna5x1pj3DMUHTQz3R+HoCmENJelhWifzwVkxqIXA==
X-Received: by 2002:a17:90b:4c52:: with SMTP id np18mr1250383pjb.49.1643707459551;
        Tue, 01 Feb 2022 01:24:19 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id j6sm6236413pfu.18.2022.02.01.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 01:24:19 -0800 (PST)
Date:   Tue, 1 Feb 2022 09:24:14 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: A question for kernel code in btrfs_run_qgroups()
Message-ID: <20220201092414.GB25465@realwakka>
References: <20220131154040.GA25010@realwakka>
 <f5d1c08b-b843-6d5d-341d-c19890872e04@gmx.com>
 <20220201040558.GA25465@realwakka>
 <b7bc0568-d29f-0347-22f8-6aa93b6ad1fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bc0568-d29f-0347-22f8-6aa93b6ad1fc@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 03:31:03PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/1 12:05, Sidong Yang wrote:
> > On Tue, Feb 01, 2022 at 08:21:22AM +0800, Qu Wenruo wrote:
> > 
> > Hi Qu,
> > 
> > Thanks for answering
> > 
> > > 
> > > 
> > > On 2022/1/31 23:40, Sidong Yang wrote:
> > > > Hi, I'm reading btrfs code for contributing.
> > > > I have a question about code in btrfs_run_qgroups().
> > > > 
> > > > It seems that it updates dirty qgroups modified in transaction.
> > > 
> > > Yep.
> > > 
> > > > And it iterates dirty qgroups with locking and unlocking qgroup_lock for
> > > > protecting dirty_qgroups list. According to code, It locks before enter
> > > > the loop and pick a entry and unlock. At the end of loop, It locks again
> > > > for next loop. And after loop, it set some flags and unlock.
> > > > 
> > > > I wonder that it should be locked with setting STATUS_FLAG_ON? if not,
> > > > is there unnecessary locking in last loop?
> > > 
> > >  From a quick look, it indeed looks like we don't need to hole
> > > qgroup_lock to modify qgroup_flags.
> > > In fact, just lines below, we update qgroup_flags without any lock for
> > > INCONSISTENT bit.
> > 
> > Apparently it is, but I don't know surely that it really don't need to
> > hold lock while modifying qgroup_flags.
> > It has FLAG_ON that it indicates that quota turned on. I think it should
> > be modified carefully. Or it can be protected by other locks like
> > qgroup_lock or ioctl_lock?
> 
> In fact, for qgroup_flags, FLAG_ON is rarely changed.
> Only qgroup enable/disable would change that.
> 
> And qgroup enable/disable have to acquire qgroup_ioctl_lock, thus AFAIK
> FLAG_ON is less a concern.
> 
> To me, the concern is around INCONSISTENT flag.
> 
> As it can happen at almost any time.
> 
> As btrfs_qgroup_trace_extent()/trace_extent_post() can fail and cause
> qgroup to be inconsistent.
> Another location is in the future to make snapshot creation/snapshot
> drop to mark qgroup INCONSISTENT to avoid super expensive subtree rescan.

I agree. INCONSISTENT flag could be set anywhere. And it could make more
bigger problem.
> 
> > 
> > > 
> > > 
> > > Unfortunately we indeed have inconsistent locking for qgroups_flags.
> > 
> > I agree. there is a lot of codes that modify qgroup_flags without lock
> > or with lock.
> 
> So far we use it just as bit operations, thus it may be convert to
> set/clear/test_bit() to be atomic, and then get rid of the chaos of locks.
> 
> > 
> > > 
> > > So it's completely possible that we may not need to do modify the
> > > qgroup_flags under qgroup_lock.
> > > 
> > > In fact there are tons of call sites that we don't hold locks for
> > > qgroups_flags update.
> > > 
> > > So if you're interested in contributing to btrfs, starting from sorting
> > > the qgroup_lock usage would be a excellent start.
> > 
> > Yeah, I really interested in this. but I don't know good way to handle
> > this problem. is it really good way to remove the code holding lock
> > while modifying flags?
> 
> Maybe you can start by converting it to bit ops and move all the flags
> operation out of critical sections?

Thanks. I would write a patch that converts the code to bitops first.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Sidong
> > 
> > > 
> > > Thanks,
> > > Qu
