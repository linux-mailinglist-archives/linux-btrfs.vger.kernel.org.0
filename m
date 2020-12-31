Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E92E812B
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLaQJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaQJt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 11:09:49 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F5C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 08:09:08 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d189so22185247oig.11
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmCgK8p/GcP+wqoRxCvgmV0r3hyXcGJg2ckeNc5ptfE=;
        b=qyMQsjLX5Gj1yQAJ1skhTJvTPz3IhiBvLS7F2Cr5qVCjoc8r7pOFnArW1qv6xYixkl
         XgATeQn6SaIZs1yzITS5oVH++FtSz06ZOmG8f/N900YExgSjz6ZwAKa9ESPqTdC8L7R+
         tDHO+lLSXwg81HYLxhoWvIYkg9JkWjq0GUDwDaCXMYV3c0WNQZI3mc7TVBbTfLiHm2fH
         ZwkcNGTs9FfHduhKvOsfiwZP3regr7guHZ3eVTPffnmGbImZQRhLA5NT9jfiOhX9GJsl
         0dEF7RBQ1ouKXcKqiYBw29ZH0s2R7rYO99MkCiX9C+6cwBQ24qG3L4Nyf+Bow8iGQvB0
         /eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmCgK8p/GcP+wqoRxCvgmV0r3hyXcGJg2ckeNc5ptfE=;
        b=cOhaAN//ZtH8SYP6SsUCAN1WWs2T3knuJ4XOCq/Pi+BkUsheCKhguIDD2TOlDO/OwR
         i3f6+npjz5tbtbb7G3tZH6cTrGpB6ZB4K0haCghJPbD0ddHbNcmVMliDITuMrjNUdyD2
         NclXjQk1SSW9CbP3hMLscdEaiLDoMH+dX/ZGfg1TL/Usk0dXJZ1rjDHWGQX47FkW0Kj6
         QR8I5pFMsSW/PVcSVjq+vpCB44zajtf6xaVpnqFFn9xooVUfx3MvjutvzcQTLwMgjaPD
         RKkFMh54EG0jz4Y/UBEvp0L+j+dtIsSTYPYhFefAnU7pvGu5OVeq2VXwHdO9mX1CR4J1
         cxrA==
X-Gm-Message-State: AOAM532fM6r/DYAaUhF3s6duKRXxlcFNQex/yY+Weu5uWKTKYez8rxlH
        vUjys14cxFdOC5ZOw767eQqKPI+rGEiYIK+tRpKq21pNWoGOzg==
X-Google-Smtp-Source: ABdhPJyk1kWZe4bzxAiaUWSbV3tSRFTc9N1VseV1vXaeHBzfJXGj+eth9IXI4Ib+qiT4JikdX+8XEmcyzsXiaH+XwsM=
X-Received: by 2002:aca:af8b:: with SMTP id y133mr8380283oie.87.1609430948327;
 Thu, 31 Dec 2020 08:09:08 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se> <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
In-Reply-To: <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
From:   john terragon <jterragon@gmail.com>
Date:   Thu, 31 Dec 2020 17:08:57 +0100
Message-ID: <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 31, 2020 at 8:05 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>

> >
> > OK, but then could I use Y as parent of the rw snapshot, let's call it
> > W, in a send?
>
> No
>

Of course I didn't mean to use Y as a parent of W itself but to a
readonly snapshot of W whenever I want to send it to the second FS.

And I just tried the following steps and they worked:

1) created subvol X
2) created readonly snap Y of X
3) sent Y to second FS
4) modified X
5) created readonly snap X1 of X
6) sent -p Y X1 to second FS
7) created readwrite snap Y1 of Y
8) modified Y1
9) created readonly snap Y1_RO of Y1
10) sent -p Y Y1_RO to second FS

So, as you can see,

-in 6) I've used the RO snap Y of X as the parent of X1 (and X) to
send X1 to the second FS

-in 10) I did the opposite, Y is still used as the parent but this
time I've sent the RO snap of a subvol that is a snap of Y.

So it seems to work both ways
