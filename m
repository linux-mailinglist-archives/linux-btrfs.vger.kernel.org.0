Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FA421882
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhJDUjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhJDUjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 16:39:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07DC061749
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 13:38:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i84so40603911ybc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpOiIjR+9VvVk6bfroZvLR8cok37OjVi4cg7HJMLR2M=;
        b=E+4Pa2krdIcxnwjn2r4XhkSy+sOLxpV+Wsf0b5kp+kTDWC4l86me8ZJc3nXpPadAVh
         /ef7qvCUxLySu5u3mHPgfnjtRlXqiTkKcZiwooRs8aZGpqee1CDTUgklG+Upkdpo1Krh
         x+FeIfUfK+rWCc/hVLEsRkllBXaFFGsy+XFyehwDW9Wl3LZJtKcR/P8NLFCv5CgzX4jx
         2loizVvykJ4R0TgY3qnCVR3b5brkCvZQ+hZI3jJeA0UHAynY9169dcPxia7zLrCgxvUD
         jjpC1t9Og4OWcZCrtVWVTnyCu59uTpc9zzLvijfbWLiflncjJeYG+GCGEZgx4ZtKCjaH
         eoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpOiIjR+9VvVk6bfroZvLR8cok37OjVi4cg7HJMLR2M=;
        b=CkAk/+76C006VPGTb4hLi98CGNrkg49rbzY/u7/VV7QXSV1XNuK6GgYD7OOTsQDsxT
         Yev0M3anq9Twzn/mVydq+18pbzTDeSIv5Hnpzf/yMfLSMo9dy6Y8R/pX/j4ecG9TM0pj
         dPZekR24VxHAS0OM1NJykONZSRDlcrvDEmbyMofKaPiHOG7g3hjS7ZoZS3slJgmQWpYf
         Myd9kUtYc3zpcw9693XxpmrU7uQkmIMJ2ndJxrye22nfnDekGpoJyC2br9RXnKRLSNWX
         f1Vyghac8F88v7KVMEjdVePSXm6i2Z3D3LtLAL9NEeuhadFKGrz1lloLkjaRSo2Tn7k2
         +Y7g==
X-Gm-Message-State: AOAM531dEnJjeegzWch0aSxOCnbktzGkjJj3c+6focJddMAEheMVvfRd
        rt/NYlg+UAiTzILP2/snzta/ZPNFIHYnKMa53dKqrQpTFvt1XQ==
X-Google-Smtp-Source: ABdhPJxj8rM80iF0DowA3q9h79wmK6Fr2bcIuCFLKuLXkU1Dbina10pm4KeUZdlnqoQl3NAL3+Qv4JZ5kX+LYb7BmJA=
X-Received: by 2002:a25:8690:: with SMTP id z16mr17262563ybk.493.1633379884206;
 Mon, 04 Oct 2021 13:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
 <20211004095146.GU9286@twin.jikos.cz> <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
In-Reply-To: <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 Oct 2021 16:37:48 -0400
Message-ID: <CAJCQCtRCr+xHBSGZEV+KTY+S+79ZhJ1rWZUByecTUdjOJiLQTA@mail.gmail.com>
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 4, 2021 at 12:02 PM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> I don't know how btrfs is layed out internally, but is checksum tree
> separate from file (meta)data or is it part of the (meta)data? If it's
> separate it should be possible to build a second csum tree and then
> replace the old one once it's done, right?

Yes, but the other trees still use the old checksum algo. The simplest
way to do this and ensure it's atomic and thus crash safe is offline
conversion. And of course offline conversion doesn't really scale.

-- 
Chris Murphy
