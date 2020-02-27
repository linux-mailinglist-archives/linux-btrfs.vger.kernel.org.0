Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78E51711E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 09:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgB0IDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 03:03:34 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35627 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0IDe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 03:03:34 -0500
Received: by mail-wr1-f48.google.com with SMTP id w12so2110929wrt.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlFDL2UUwNWwo5674IByS3m4F7/GrQttAulWyPob46E=;
        b=JrPzVYPi1Cyf9T+MTTSXlKY3c4iewEWCbEvI/zMIXy/iXncS6MiqoaeBtLq4Ar10Y7
         bGwtRJf9hoDaXzvUX87bM29jTxHmtS6sk4Y6OHA3jCNiUh56jzbnBK3ZJO27wXcIRxaF
         QjyPbMsRTiTrfOyvxmCm9VWueyQU9OxRFxR88jYr8b6dDSRCYXnPi8xEwqp4aE9lpTzp
         cKLVug9TT/f0OEDlPdjimZvXaz1e0jNxBokdI/uUvP6ZW3IpHB1gy2QbWs/DqDwZIFlP
         zIz11xJ0jPbu+ZxnY4q+cAMCAWtmAtg7P5M5y2YLnk4nvCQTHVAnGZYdEPZSLOG1sQFa
         OFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlFDL2UUwNWwo5674IByS3m4F7/GrQttAulWyPob46E=;
        b=bs7KJxy9hj/99M5svtZYkPzFFURjvvUghvzStdSFW5HTxS7Zy4Vw6KPCvojEaVtmG1
         lSdI9ghdmv785maa1xSitDh5NpkimyUdvxx3FLDc33ETX+UqSMvx1+uftlOoZt1aic7K
         q4bM4InKQnkI8J05wDbovyGXhxMWaDkpjqobQnluwR+msqV5Sgf6Nq/eVyGgqACWz3fL
         KNvPvODmt3MvHpfcSVI79aQf3keXGBLYGnakiM3yTDyPC77swOE0PrZqHRdNNhkJG2H/
         Iq1arj53hp8k3V8zvdd2eDpF6+8ykToCZy2aqZkdzWQYseu1302mUX9IFcA/NTdJZEmE
         3YlA==
X-Gm-Message-State: APjAAAUdzUEH+obSy0mgqJ5yPipGhzEIKCuT3sf0z5lyPKGvEgfhVK3M
        AZr/ftRuHwHwR+bpGF0Q2iw58bC0ugJAszw1Mss2uQ==
X-Google-Smtp-Source: APXvYqxwM2cQZZnog3d2kgzjwlPO4u++DGGTCjgjxV7lMgJ2bLbEU3U8jNNlgLvizGrNapFvGYCaq6YuG8w/cKe6Ot8=
X-Received: by 2002:a5d:6881:: with SMTP id h1mr489777wru.236.1582790610555;
 Thu, 27 Feb 2020 00:03:30 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <CAJCQCtR3r+nGU4pvRfZooAvDZemr2woWJQFDaMUZT4zMaSzQ7w@mail.gmail.com> <CADq=pgm7r8hNB3vVNgyvbf-M+028ENy85rkwkvab_T8sC4sJ=A@mail.gmail.com>
In-Reply-To: <CADq=pgm7r8hNB3vVNgyvbf-M+028ENy85rkwkvab_T8sC4sJ=A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 27 Feb 2020 01:03:14 -0700
Message-ID: <CAJCQCtSxz2qxbNj8XmYmST0o=vRTNsE04VMWYTeB5T_gvnY+kg@mail.gmail.com>
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 27, 2020 at 12:24 AM 4e868df3 <4e868df3@gmail.com> wrote:
>
> The VM is reporting the errors.

What are the details of the storage stack? What are the Btrfs devices
backed by on the host? Physical partitions, or qcow2, or raw files? If
they are files, is chattr +C set?

And what is the cache method being used for each device?

>A power failure or crash is likely to
> blame.

The host or the VM? The VM can crash, it's fairly safe, I even use
unsafe cache on all my VMs (it's way faster) and a force power off on
VMs all the time with Btrfs and never have a problem. But, it's a
different story if the host crashes.

It's a little strange that only two devices are affected.

>Scrubs happen monthly (3 weeks ago). No other BTRFS messages in
> dmesg to report, just a bunch of sudo audit's.
>
> $ sudo btrfs scrub status /mnt/raid
> UUID:             8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> Scrub started:    Thu Feb 27 00:16:58 2020
> Status:           aborted
> Duration:         0:02:03
> Total to scrub:   5.76TiB
> Rate:             853.91MiB/s
> Error summary:    csum=278
>   Corrected:      0
>   Uncorrectable:  278
>   Unverified:     0

Btrfs check might take a while on 5.7T. It depends on how much
metadata there is.

-- 
Chris Murphy
