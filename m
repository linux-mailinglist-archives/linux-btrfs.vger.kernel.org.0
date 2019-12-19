Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0265127155
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 00:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLSXSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 18:18:49 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34221 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSXSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 18:18:49 -0500
Received: by mail-wr1-f46.google.com with SMTP id t2so7670107wrr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sd4pHFU/HBBSxfkh+l+hIjzqHs+9q1iO+zgvNi6tVNc=;
        b=Z9GPzilbsfoLN9wQCb+Mz9145xv+v+sGO04LlmUQpu5qPW0ZJ11n42r8bxm4dpi4Cb
         XOhpDy0Z0xku5PDEuwF3+2Jo148W3XNuMRdeXhkeWItOesZ/hrWPnzyQI4s1lFP8WgHI
         lj6ifI1vF2SfLThAxjBwbDssDctEC2sGG/w376LhAE2UrwR95SLN5h8xneScwiliUOSf
         dekdK5OS0ceTl+HvuO0EtiHqFQDHa7j58Hzrj03GZ9g7P9XfM1jRlBJcxKZpwMvv9UUG
         caVV9Go//L5PTogsUpcFXcSIP3rdpGYDkaSmM706jmrUiD4hWHtZJHhhmZiovaGtyjcd
         YTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sd4pHFU/HBBSxfkh+l+hIjzqHs+9q1iO+zgvNi6tVNc=;
        b=Txq/vKh2d3Wt8BsY5b6D+aASazg0yd6C3AtIExE7MoQM8Km/En3S8HUCiNuU87IkNL
         6uVn/Cy/ydgnFS5vuQKMFGrSD6JMUKDMcWCjChGJ1qUMVnZ3u6yNGfTaSM0lMy5pe7li
         Fbz8aCEVy+Z+TOYFxDEw1znWT+STP1AxaWv8t029lYB6FpJkQVnekrG6uw6eoJRKXC81
         fffGMV3NTPNCMYJwOPnpDNdK9MH3iCUfJGNYTrkpfEb5iNiuS8DK5bLy8RZ+C0H6JV8m
         tZR6QNmm2XH04WpFxRzLtR1tY35JvyteKa0U98Nw+gpi1gjdRWPmQhQPaVWwDlgFa+cb
         9dRA==
X-Gm-Message-State: APjAAAX1JWFsgAdm/KCbB3+9K5FY5FAxOd6qVGNPAd7n8AofjW37Cz4s
        pHAe1eNQwIVHZH3UlV4aPUcFtHsbRfaJesJszgoLx0np8hU=
X-Google-Smtp-Source: APXvYqwfbQRyu1cm9oh4kPoGDfsYEm9kDCQyUGSbOYQMpD5t6eL3L1eeSMjUoakvCRgxjne8le5e6VNdj0rIwj/mRwI=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr11943043wre.390.1576797526977;
 Thu, 19 Dec 2019 15:18:46 -0800 (PST)
MIME-Version: 1.0
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
 <1774589.FgVfPneX5p@merkaba> <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>
 <992c672c-75d9-27fd-0819-a3735a7eea89@georgianit.com>
In-Reply-To: <992c672c-75d9-27fd-0819-a3735a7eea89@georgianit.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 19 Dec 2019 16:18:31 -0700
Message-ID: <CAJCQCtTtOHWwEHw6DtGfbRBvYVmBe3TYAp4VtfKh2KDSjD2PDg@mail.gmail.com>
Subject: Re: How to heel this btrfs fi corruption?
To:     Remi Gauvin <remi@georgianit.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 3:34 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> On 2019-12-19 4:43 p.m., Chris Murphy wrote:
> > It's bogus.
> >
> >> #    Free (estimated):            134.13GiB      (min: 134.13GiB)
>
>
> Perhaps not.
>
> Lots of free space, but it's *all* allocated.
>
>
> #    Device size:                   7.27TiB
> #    Device allocated:              7.27TiB
>
>  Metadata,DUP: Size:21.50GiB, Used:14.31GiB
> #   /dev/<mydev>       43.00GiB
> #
> # System,DUP: Size:8.00MiB, Used:864.00KiB
> #   /dev/<mydev>       16.00MiB
>
> # Unallocated:
> #   /dev/<mydev>        1.00MiB
>

True. The more recent cases of enospc seem to happen with plenty of
unused space in allocated block groups available. As is the case here.

It's possible a newer kernel will produce helpful error reporting, and
additionally mount with enospc_debug mount option.


-- 
Chris Murphy
