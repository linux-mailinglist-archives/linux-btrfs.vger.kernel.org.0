Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267241753CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCBG3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 01:29:18 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39648 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBG3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 01:29:17 -0500
Received: by mail-wr1-f54.google.com with SMTP id y17so10988207wrn.6
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gELKFDNVRrqSmcdKHM0shifx4+tSXhnuCymHXPouo6c=;
        b=RrViUeWEgVmYsgB1OSk9mxZcp+Yt012/QY2rUWZ2sc8tRk2vOHZANGBbvuTv0UjL3M
         Dj9H3ycRXKkLfzNg5wAriDsJg/dCvgEEQ8qd7zK0rHAqPWCkJFtL8GS6pCJ16ooOn1Hj
         oiRZgWiyFLTlikTD0o6LVJEh/xLF08VsZZs781pIJ5jQ+18c1TLiGm4CBvCkYH/WC90G
         MbTgSrRDRyH2RlBrpxZ58hr9OiOG6/hnBIADLi2Git3TxxEaFRtETPVGqbDGi7o7LNZH
         lviQd2Nt6d2RwEzccnLf0yHSvJHwIyif6587nSnnSpfmtXTTP1uAVSB3vV3nTRwmaGj/
         qTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gELKFDNVRrqSmcdKHM0shifx4+tSXhnuCymHXPouo6c=;
        b=g/HuAReZsr6KDFigP1gz3Dp7luInIrFqmfJPy2G3o9dOUxeQYG54Xt5WpRwB6Owug6
         TCEFJF/Z3MmpCacd2yqUCeQt+V/nfLhnBE/VGw2C1CkinfnKEWlA3EnHJTlkLeCf+ITZ
         Jjzv8ZILu9GFQPGPvBzip8nHvFd0g1Kik89tAQBcWg8PoYT3RGc363+10VQTjuHTgfwa
         i4xYBG67E3+v7129YV/Y0nb1Rxuun4t5nz7bCp6YCJCpjFFBfojmkMzihZ/QIyd8wYAz
         vI9VcGjXRV5VEUxMtq5Dg+J4sH47sCmPxcB5wAhkeGBQD7sW1ntQocUKGWKfmJUNbFpL
         +V1g==
X-Gm-Message-State: APjAAAW93jmhK0JF35NXJxqE+QBoL56pCaYCP9ZfS43fdNW67FPvOGfv
        bdDDfm2vCYAfLQQG6/V9+CgexLhS6VmunwzNFD6b2VxU
X-Google-Smtp-Source: APXvYqzOtGAkihRp6QCBXFywJa86510VX67kMW/1Hco7IJIR1D2Mok/iTxQ2KtdtNDLQx7kClwKf5Y/mOAQA4j1DQMg=
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr20042273wru.65.1583130555955;
 Sun, 01 Mar 2020 22:29:15 -0800 (PST)
MIME-Version: 1.0
References: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
In-Reply-To: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 23:29:00 -0700
Message-ID: <CAJCQCtTq_ccnhV9BPU3CA08=m6LDtSxgyve_GUckpPB2HKC1fw@mail.gmail.com>
Subject: Re: balance conversion from RAID-1 to RAID-10 leaves some metadata in RAID-1?
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 3:41 AM Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>
> To my surprise, some metadata is still RAID-1 - is it expected?

I'd say it's not expected but also balance is pretty complicated. Try

'btrfs balance start -dconvert=raid10,soft /mountpoint/'

What does dmesg report for that command? And are those raid1 bg's
converted to raid10? I don't think it should matter in this case, but
what's the btrfs-progs version?


-- 
Chris Murphy
