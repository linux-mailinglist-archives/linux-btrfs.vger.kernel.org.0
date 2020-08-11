Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE6241490
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 03:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHKBbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 21:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgHKBbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 21:31:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C5C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:31:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so9900635wrx.9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09mYl6APaMP5Fe/He4yW7Ic8Em19Ngci0Uj71lDKT/o=;
        b=tCJJ3rh9vWy9ilqwXLfDxGWjlhQ7ZaL43u+1JWNSeQW63HXQBxn1k1vOw7zcHrKi2u
         n7YqtV8+R3A7v1rZVBOrqiw7MbOttYYhSD4MJYW6iwWkMnFhK3usuELMItSM6PM6I/B6
         r5Cmpwof+wQUi/LXef2piFFABT0o+t5E7BIBHzkBDrGm5yfwkqwmNYCP+rxYcaVzbJyd
         CvD3fgaJn340CjhTupQNuKlRuA5PUay9jpG/Pzuz1iTMh7j2oLb3HTjsw1c0UhZayRhx
         T6dxYxCUU4wcd50AETQZYnLutB8u0HPXYx15ztO7TdBbsZlTr4zD3fBygUFnGOxDE+gt
         QUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09mYl6APaMP5Fe/He4yW7Ic8Em19Ngci0Uj71lDKT/o=;
        b=lLq82AN8+yvOdAqLEdWrY8VePBFSuL4J2UQLXQrWvAD7/24cGRKeKC5O9fBlgO2j8X
         7P5nLnD6BMgeQWFGm7GlGbMT90cQu7SKycwId7v2KMdXUqAvx0FOqxOst3t4tY/D+RW/
         aS5nUd/9iTtRW26V7fDFSE1qB8rAV9vZRx8w7qu+kFxZkUV/Fi+2KnNYYW759hf1iYAy
         xSxsk+r6+k9LHNSfOm1jY0oF6FINp9XxfCzdjKa7VMSEWZhNIzFj4pKTjtFnzkM2m3UR
         uDudElHSIyS5XCQGnrZ9t/Y+B+6FVitedvvxJhJCmSDkGcOlxXsh5n2b/mI3i7SstxsP
         2zjw==
X-Gm-Message-State: AOAM531/FAPl148zWigx9kq/K2SExAUfaINxQSMo39jeBvpoETGjhd70
        JBZqaCyCk02DAN+BuvVU+p9o/+cN6FFZuQS8g5pGXOkS6wE=
X-Google-Smtp-Source: ABdhPJw8V4iLTXZf7RHF4KGF0dPrOfZDDrGvh+mtoF/ULeEgKmXnjX0B+Du8+ISR3W8xkgRXjpf1XAgsB/Foy34jKgo=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr26635650wrn.65.1597109474750;
 Mon, 10 Aug 2020 18:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <ac06df32-0c18-c17c-64c9-45a04fc82057@suse.com> <16328609.DpnNoz7ane@merkaba> <376677b3-0e2f-3c53-c706-4362738e6d3f@suse.com>
In-Reply-To: <376677b3-0e2f-3c53-c706-4362738e6d3f@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 Aug 2020 19:30:45 -0600
Message-ID: <CAJCQCtSnqX-QGA8iiUqAv-b7adBce8EyFXuSJfcyN3Qd_x9fGg@mail.gmail.com>
Subject: Re: raid10 corruption while removing failing disk
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 1:51 AM Nikolay Borisov <nborisov@suse.com> wrote:
> Fedora for example
> spent the time to test btrfs for their use cases + they have the support
> from some of the developers to fix issues they find because they
> themselves don't have the development expertise (yet) to deal with
> btrfs. Furthermore I *think* fedora is sticking to using unadorned
> upstream kernels (don't quote me on this, I have never used fedora).

Fedora has explicitly listed btrfs in release blocking criteria,
meaning related bugs (i.e. some btrfs bug related to the installer,
not even necessarily kernel bugs, but that too) get fixed somehow,
since 2012. Fedora btrfs installations use mkfs.btrfs defaults, and
default mount options.

Also Fedora doesn't carry any special patches for btrfs. Although, if
there were an upstream tested important fix that's intended to head to
current stable anyway, it'd likely be taken as a patch and thus early
fix. Right now we're carrying one planned for btrfs-progs 5.8, which
is mkfs.btrfs default for multiple devices, using -d single instead of
-d raid0.

The other thing is that Fedora users have fairly up to date kernels if
they accept the recommended updates. Right now everyone on Fedora 31
and 32 should have 5.7.11. And 5.7.14 is heading to stable updates.
Anyone can opt into updates-testing to get the most current upstream
stable kernel version, or even rawhide kernels to get the upstream
mainline kernels which now have CONFIG_BTRFS_ASSERT=y and
CONFIG_BTRFS_FS=y instead of built as a module.


-- 
Chris Murphy
