Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C633E74C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 04:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhCQDAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 23:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhCQC76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 22:59:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C20C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 19:59:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso2572141wmq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GW8iy72N3/xGHZIlBWBafrTN6/WYUht+E+/7lgbzg8=;
        b=SJg2+3LGPdaNlMRdk2wSFrcFRSx1SkWmD1M1HKRZtCaai7FwuOgrcblxs639iqsOTo
         Y6GPesgVuG/P48QCn+kqfqIrVmE865wmlnHH8iaHdsnPPoSQ1gaGjYy5V9HMxAlzPIgz
         6MksteDE5UBu9l/mr0NcNCstHBp077VaewYf+EkQ3F1hu41vPF0MCfFfjfsz3HTrhaXA
         71eqgiuo9RmYN+uu9vLngrE0vEqMRNSREFn8eDQHVYecY86C4aOBfxPbAyPDq38oXDfP
         Bu5TlzqqgdecczfxIzbEfpF91avScLaaOGKkOcczWm+sOkfF9+w5mCqX6nRiUBFVBoY5
         bNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GW8iy72N3/xGHZIlBWBafrTN6/WYUht+E+/7lgbzg8=;
        b=H+Ji/+YROb/qMR+y4nFi0zYcwBSpu0BPf0Os4uMdFvEZcWjbrT/4x05AjNxr/QkeMD
         Hvcp3BmQLW+FKykHY7pKn8f2hoV0DvtjuHBQxWUzN9NFcbhpsuzl9+QylVDgHZCM7LXQ
         dtiXI+3r3g1SxXiYvAAV2mZp95EACvX21KmfMN2jJ5lmpd8vpVIN0HxwobKCgZ5w/ax2
         DqHgD0hr6FJ8YDu2JgNESkuqMgyya29YnzSBNVGWJrrmKp7JCw9apYcmFqizGtrhaZCs
         b1vDh6aL8CK55RgBOXWoY16sigH+b34LC64yLv1lbPsgYAOLXywxsNpUb/IzWetw0ZCb
         qTWw==
X-Gm-Message-State: AOAM5328Svk2yhEyZQ5dT7lai2Ifoz1G4tKHHa88wLRvSlrEOEzf4171
        FVUEIGlI60X3Tu0Qz9aK7OcBdmL2NqdyXcR/qFFGs6SmuJheY4O7
X-Google-Smtp-Source: ABdhPJxBa8CykfGOw4PL3nP/GM2MeuqDq+sGpKs+qSXjUEYXRzQhPoBCMdCduqj2enf4eGOEfIvKEo2r9NvM86ScCSQ=
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr1467894wmq.11.1615949996941;
 Tue, 16 Mar 2021 19:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <2411012e-0b50-ff76-2710-5fa55b8487eb@gmx.com>
In-Reply-To: <2411012e-0b50-ff76-2710-5fa55b8487eb@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 16 Mar 2021 20:59:40 -0600
Message-ID: <CAJCQCtQ7o1_Kkxf3Gh8bM+r4-e3tXuZsFM1mHUQakRvJUA9mqA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sebastian Roller <sebastian.roller@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 7:39 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > Using that restore I was able to restore approx. 7 TB of the
> > originally stored 22 TB under that directory.
> > Unfortunately nearly all the files are damaged. Small text files are
> > still OK. But every larger binary file is useless.
> > Is there any possibility to fix the filesystem in a way, that I get
> > the data less damaged?
>
>  From the result, it looks like the on-disk data get (partially) wiped out.
> I doubt if it's just simple controller failure, but more likely
> something not really reaching disk or something more weird.

Hey Qu, thanks for the reply.

So it's not clear until further downthread that it's bcache in
writeback mode with an SSD that failed. And I've probably
underestimated the significance of how much data (in this case both
Btrfs metadata and user data) and for how long it can stay *only* on
the SSD with this policy.

https://bcache.evilpiepirate.org/ says it straight up, if using
writeback, it is not at all safe for the cache and backing devices to
be separated. If the cache device fails, everything on it is gone. By
my reading, for example, if the writeback percent is 50%, and the
cache device is 128G, at any given time 64G is *only* on the SSD.
There's no idle time flushing to the backing device that eventually
makes the backing device possibly a self sufficient storage device on
its own, it always needs the cache device.


-- 
Chris Murphy
