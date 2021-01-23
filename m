Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC9301398
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 07:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbhAWGac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 01:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWGa3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 01:30:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655CC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 22:29:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d16so6430124wro.11
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 22:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mc7CbAOJS0c2g6CWG5GNzbqqMaQkCdT653hC0Os1ocA=;
        b=bLiaIS+WYKJp9ZjprksxgA71Y1etTMlYCEMwmJdZSEz4AU3UhZbB6Wc5BmkGcijOQ3
         y9yYK1xmhYQXkmPx0QCGUozDxTNwdVNruEfnwDXz0y4uj81MHOi07bAWzQGaS6QhOxG7
         MZMbEUDHqgnir9Lf+tPVY+PZB+29erZMwKpfnL7iDZWpJfTSJilKtO/gFvMoEvWfYtKw
         TiOG4a5VbDKwWJiIFA9vm37qWlXgEB1QzOQVMDOPM7Zn5Ckq3CEiKUkx7QBvEovmI7E/
         NWZNaA2Ku6+EYrAoDyxVg97kKsjJKjOQ7iwqO6Gg9gwCRctarc/L6Yq5aeZEDwJofAGY
         Rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mc7CbAOJS0c2g6CWG5GNzbqqMaQkCdT653hC0Os1ocA=;
        b=d792UqFYavU4rZswPAVlBu5sWGHT9JzGPrFbT2lPwXCPak/kS9zlc55YHw465dogzm
         EQjaLowD+23SNUQqmajWHOjqM4ovWSxaOZiWUN6liOPgOJxu5+gzgziOmfJ13Mm7mb5W
         /RJFaZKGDd5yk8Bg6KBMzuUXtPpB3TlQNvtC3U5aqoogLlNuhL/F4jfz28pKWeKqU5y1
         LP4Lg0nv9HQKBSmacNjVwBEr1WehwQJ8wc9riv1D+lAuPBo3WeYfcWn+6y/0AD57yoek
         +t68gTxI9K76LlQiOCJii7/WCqI1pzZHfNowqkxraeuOTI5l8dZPbq410zUlETiQpg3K
         xlXw==
X-Gm-Message-State: AOAM5300EDBa0uwnygLhmI3cZu5xosVbpxh6EZw54DryTqFQvxdSIb2v
        96o+AkIjt7YM28SDb0oguoyMq1hrIsE9MaLMvxp5MZisYndRIg==
X-Google-Smtp-Source: ABdhPJw7vJelChwfFR+57YYS52XbeW3x2aGuJWYiePq8mDOAvJzsFDpbgw8i/ClylYnbnKbtNYJeq0kI17ISFPa/nSQ=
X-Received: by 2002:a5d:6686:: with SMTP id l6mr7693444wru.236.1611383387841;
 Fri, 22 Jan 2021 22:29:47 -0800 (PST)
MIME-Version: 1.0
References: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
In-Reply-To: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 22 Jan 2021 23:29:31 -0700
Message-ID: <CAJCQCtRndODgwdnLC6L6Mg7kfO2xEv+wmLfuYsx=kZ0rk8EKgQ@mail.gmail.com>
Subject: Re: Recover data from damage disk in "array"
To:     =?UTF-8?Q?H=C3=A9rikz_Nawarro?= <herikz.nawarro@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 18, 2021 at 5:02 PM H=C3=A9rikz Nawarro <herikz.nawarro@gmail.c=
om> wrote:
>
> Hello everyone,
>
> I got an array of 4 disks with btrfs configured with data single and
> metadata dup, one disk of this array was plugged with a bad sata cable
> that broke the plastic part of the data port (the pins still intact),
> i still can read the disk with an adapter, but there's a way to
> "isolate" this disk, recover all data and later replace the fault disk
> in the array with a new one?

I'm not sure what you mean by isolate, or what's meant by recover all
data. To recover all data on all four disks suggests replicating all
of it to another file system - i.e. backup, rsync, snapshot(s) +
send/receive.

Are there any kernel messages reporting btrfs problems with this file
system? That should be resolved as a priority before anything else.

Also, DUP metadata for multiple device btrfs is suboptimal. It's a
single point of failure. I suggest converting to raid1 metadata so the
file system can correct for drive specific problems/bugs by getting a
good copy from another drive. If it's the case DUP metadata is on the
drive with the bad sata cable, that could easily result in loss or
corruption of both copies of metadata and the whole file system can
implode.

--=20
Chris Murphy
