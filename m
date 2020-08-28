Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE4256380
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1X3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 19:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1X3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 19:29:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8868C061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 16:29:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f7so618303wrw.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 16:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2oMNV1/mTr/jZEW7HcjOSyo5p5NSbmeKQDIWFbP2oM=;
        b=R5/RM2dmjEllKIB4l2PbH8gGI7q1sSXk0q9/CarrJ82/wGAR2iDgD3K+EX50n5Or16
         f06oXrvcJRLU2fAnL79DlLSJzHOSSs1nesOWQytph5Rr5FlmOdOd0bPHOSQ6cjOSPrN4
         5c8dv/43Bu0osxaZuNmOLqZ9P6QBWkrYdxabZQBVGANhvCTQwLJOuL5OwrMaRe4vBzpL
         A+zYogTMjaBcFWcsTiMeZ33chC9iScTO4GWndxsZiXfGhXNlY1wzPwKuS7UIGtY7NR6w
         dO5ou6Ai7u8gstRK5WR6Qg5URiNqO3faohk8++8eYTd4KhLRm8hiADvBej71ba/Bo/nE
         M+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2oMNV1/mTr/jZEW7HcjOSyo5p5NSbmeKQDIWFbP2oM=;
        b=bVsSIBz6Z+7OJ5+ffwIZ9M3IS+vx7xGJnuC8jPGVgMLBQ6ri2vqdFjQVNdvxsyWXBL
         bb2nnig1t+qTqXk8lGhjg0Ha8RBITpsAFZ38LCY1nSq6mJDgQsKXP96q2/LPAXw4Y+A0
         PkYrfdiDPhxUmCxtiLCZKCVdRa0UuJHKSSQ4gBEM2vm4c28jXdYZwWwtqA1opLGtx0oa
         4e73aMurjkksHZHa27Vhvq9hyUP/+EwQACQlJuOyij6E0JUmGLWae8unxlNWq+96roSR
         299LXuXMIwiBYsOlzmzgSowOt5IC0YGsIC7Yb+Gt+r5kkJ7JfRz9XcHxbHroPdIPj2XB
         ED1w==
X-Gm-Message-State: AOAM531RnDF1yvoYnAQGfCY2d1MvAT1ECvqcEPRxSU07wQcqRmmIzAXF
        JVSnohejgvKrOMsnNSDIrsMF/Q3d7q/A3K6rvfEIgA==
X-Google-Smtp-Source: ABdhPJzxAVhFHsj7ysoosIS/IySXHY1KPeN6Sd8bUqpWZ3dSp+SVOxb3eqLrb9nRqyLT0jf3+IdlSQqMikebQ/HdlAA=
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr1126260wrx.252.1598657348100;
 Fri, 28 Aug 2020 16:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
 <CAJCQCtQrHXLzUM3gGR8ng_cYXfKuQ+jJY=2To=6L6XMeMWWmZA@mail.gmail.com>
In-Reply-To: <CAJCQCtQrHXLzUM3gGR8ng_cYXfKuQ+jJY=2To=6L6XMeMWWmZA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 28 Aug 2020 17:28:22 -0600
Message-ID: <CAJCQCtTa+eWXm2EvaZNdN8zKMUOxBvstCWyXr5LUDqM6yD_55w@mail.gmail.com>
Subject: Re: Optional case-insensitivity
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Mark Harmstone <mark@harmstone.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 5:26 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, Aug 28, 2020 at 1:44 PM Neal Gompa <ngompa13@gmail.com> wrote:
> >
> > Hey,
> >
> > So I saw today on LWN an article about ext4 gaining the ability to do
> > per file/folder case-insensitivity[1]. I can see some value in this
> > property existing for subvolume/folder/file level for Btrfs for things
> > like Wine and Darling, which could take advantage of this to help
> > support Windows and macOS applications that expect insensitivity to
> > work properly. In particular, I'm looking at how games are glitchy
> > with case sensitivity because it's rarely tested (both Windows and
> > macOS are case-insensitive by default).
> >
> > Has anyone looked at what it would take to do this in Btrfs too?
> >
> > [1]: https://lwn.net/Articles/829737/
>
> It might also make virtiofs on Btrfs more compelling across
> virtualized Windows and macOS.

i.e. virtiofs pointed at a subvolume; suggesting if possible making
the behavior enabled not just be feature flag (if required) but also
xattr set on the enclosing subvol.


-- 
Chris Murphy
