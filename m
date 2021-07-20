Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3507F3CF0CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 02:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhGSXwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 19:52:25 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44747 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379500AbhGSXpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 19:45:04 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 804E086780F;
        Tue, 20 Jul 2021 10:25:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m5dZo-008Wuz-5h; Tue, 20 Jul 2021 10:25:36 +1000
Date:   Tue, 20 Jul 2021 10:25:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720002536.GA2031856@dread.disaster.area>
References: <20210719071337.217501-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719071337.217501-1-wqu@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=A28zH0UQg-Nq1e7uk5gA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> This patch will allow fstests to run custom hooks before and after each
> test case.
> 
> These hooks will need to follow requirements:
> 
> - Both hook files needs to be executable
>   Or they will just be ignored
> 
> - Stderr and stdout will be redirected to "$seqres.full"
>   With extra separator to distinguish the hook output with real
>   test output
> 
>   Thus if any of the hook is specified, all tests will generate
>   "$seqres.full" which may increase the disk usage for results.
> 
> - Error in hooks script will be ignored completely
> 
> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>   And the variable will be ensured not to change for both hooks.
> 
>   Thus it's possible to store temporary values between the two hooks,
>   like pid.
> 
> - Start hook has only one parameter passed in
>   $1 is "$seq" from "check" script. The content will the path of current
>   test case. E.g "tests/btrfs/001"
> 
> - End hook has two parameters passed in
>   $1 is the same as start hook.
>   $2 is the return value of the test case.
>   NOTE: $2 doesn't take later golden output mismatch check nor dmesg/kmemleak
>   check.
> 
> For more info, please refer to "README.hooks".

This is all info that should be in README.hooks, not in the commit
message.  Commit messages are about explaining why something needs
to exist or be changed, not to describe the change being made. This
commit message doesn't tell me anything about what this is for, so I
can't really make any value judgement on it - exactly what is this
intended to be used for?

FWIW, if a test needs something to be run before/after the test, it
really should be in the test, run as part of the test. Adding
overhead to every test being just to check for something that
doesn't actually have a defined use, nor will exist or be used on
the vast majority of systems running fstests doesn't seem like the
best idea to me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
