Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAA474575
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhLNOpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhLNOpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:45:50 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBDC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:45:49 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b67so16919461qkg.6
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1X77fw6KGk0geHqCNrqLTVHZHUkwiv0W3e3LGSjmrbM=;
        b=5Ko3soYmMJYmnWmqXc1CKStLJmSwWd+GD8TTrsyrPq4azgykZC64NlNU5LvkpjbxuJ
         bMR5BelOmZDx/ZQ2uO1U5rjf99f0pw5PpAtzPqm9suMSp0OvQrYv55xLZT0Db8wksooh
         6IBT2sPqw5QtB4Ng8rxHYmsbjRoxyrVcyscSqmA3rG/xE+lDIGKT0K9p/DMsOYnDfIuN
         YSQHbvSwZm5Mc3UWMLkoCpXr02aHiWisk7XVfowTS7FQ+iEgv9ODdBLXW2Y2qi8QjyC2
         0z6nUHywOhPGf5H6m3xoP56APwFVHqJMgB3hg0+8tKaPIyGGpbNbiqZal+jjvlLs3mWR
         YukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1X77fw6KGk0geHqCNrqLTVHZHUkwiv0W3e3LGSjmrbM=;
        b=tHVfaqplVeDyx/30GsbCKUJgdFibEbZrQlaJ0d2ZzgeS1RIzRBtmMWD0cio28/TPfE
         sn9fJQ93lvFxsfWo4mQx5fuOjGbMBFF2/pB6zXjVc9nf2z9s+am+JAA/ZWTXJUIdm2Sa
         XfbanYMkifWAWk9Xw42KnCcsdjeG3bH+cAEfwZ33AcYbVkXBXcYEOKjvT+6nExbeoclb
         K/LiyE1W/Q1q1uHKSREA5ignEZkFh3sCCaFqhLVyJdaBTyH235BLriDKMEl6BKT/11Af
         3maLO4CbW98UO3wY1GYqsylfT8DrwU3gTVytPMdCG9IXyqr3/XEjF05qvVm4GLzApuS+
         fdBA==
X-Gm-Message-State: AOAM530jiC2d2m8bE+eKjaIiNZSDZiyAX7O5PQyM8RwxckSJCOi/kbVj
        dhG9a4lq8xltbXSsvV3/6h/agyord9tp5g==
X-Google-Smtp-Source: ABdhPJwJU99Pd0brJrH95f6sWP6qnHILpKn7HRPOpJYh5Xk08YYjTkEtoVS9iwOVr9LhoNg6Iz0vpA==
X-Received: by 2002:a05:620a:4006:: with SMTP id h6mr4427266qko.559.1639493148943;
        Tue, 14 Dec 2021 06:45:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18sm65468qtw.64.2021.12.14.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:45:47 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:45:46 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Refactor unlock_up
Message-ID: <YbiuGuFdSM/BWHzk@localhost.localdomain>
References: <20211214133939.751395-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133939.751395-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:39:39PM +0200, Nikolay Borisov wrote:
> The purpose of this function is to unlock all nodes in a btrfs path
> which are above 'lowest_unlock' and whose slot used is different than 0.
> As such it used slightly awkward structure of 'if' as well as somewhat
> cryptic "no_skip" control variable which denotes whether we should
> check the current level of skipiability or no.
> 
> This patch does the following (cosmetic) refactorings:
> 
> * Renames 'no_skip' to 'check_skip' and makes it a boolean. This
> variable controls whether we are below the lowest_unlock/skip_level
> levels.
> 
> * Consolidates the 2 conditions which warrant checking whether the
> current level should be skipped under 1 common if (check_skip) branch,
> this increase indentation level but is not critical.
> 
> * Consolidates the 'skip_level < i && i >= lowest_unlock' and
> 'i >= lowest_unlock && i > skip_level' condition into a common branch
> since those are identical.
> 
> * Eliminates the local extent_buffer variable as in this case it doesn't
> bring anything to function readability.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

This was weirdly difficult to review in both diff and vimdiff, had to look at
the resulting code to see how it worked out.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
