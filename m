Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAF3D66CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhGZR6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZR6h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 13:58:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14794C061757
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 11:39:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so352691wrv.11
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXcjqT++w4zKZPay4A97ASsR1SsJvvXQosYpbI8UemA=;
        b=seJbc727HRVtWhPUTh8ZRq9O+2ENTOVAjyWyhjVuUFAixwp9DKsXgB5+HS7UM+0U1c
         /bzpAAH5XFnhyR3U+gPeBRcW2SITqZYCAMEAaEGaLnGlSMSOBO/5BT94uUofWlK397dt
         Ciot039LxBc3L1Tu68t/PwP8Ulnm3bdqJJYTm/SgaZ+57wRn8Z9Ax/dcv0iXggaxoHUZ
         oV87LAXCpsT+bck+KxSf4qTpXUuumNvSeiYjQh87nG5X000glIQXjV2fjOBVOHt29xEU
         SyUlyXd0lw4iYdo9WmRSAMYjWhnQb2ie2at6PRgCVZQBbzQDTi9tmNndnSpQkgfzTE5A
         KmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXcjqT++w4zKZPay4A97ASsR1SsJvvXQosYpbI8UemA=;
        b=CYhx+NEGbx4hSd9MmWC66p1/r57otbgRUfYDjIl3INPbXQEn/d1D/XyGz1ao6gBw4w
         Z4lBe4+dBkJG1Tefc4gEjcEwIQbr5p13L+bDV9eg7lgHOcQnfA1OKnIFORyENXZ1mRus
         5o/8LK0P6GZstQila1QxpFAMotVJ/GRqZoiquCqnc+2aqCIDS/vEh2EpO9pYJya8n9uU
         SG+3cUgGxHXsBLkxnEGGw+mtk2LRNeEE5MN8hdFZFGOMNHmdQK/H5WG7/uGAC76ZkiO9
         qeeQqp9XRWzTaKj/VYL9gKCWb6byMKwNuyrLGR45J1b2imJxQPpLt++rGIhkNnJktFb3
         OcmA==
X-Gm-Message-State: AOAM532STUa5jqeh/ItFl3TDiO9WT5QTxw7wiHpKqq4tryL9z/US8ec7
        xcwzm+fvXH/u1mKvd6XyC96xLhOl7QPpMPBdS7y0OQ==
X-Google-Smtp-Source: ABdhPJxIfeMK3+ToUwQD7TPtrVyeqkfnGbWti9YPZkZo2iCp7Y8ihALRmxd1X6dgXXA+XUIquK6pLdlQc/94xHhEJXs=
X-Received: by 2002:adf:fbce:: with SMTP id d14mr20755156wrs.236.1627324743540;
 Mon, 26 Jul 2021 11:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
In-Reply-To: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 26 Jul 2021 12:38:47 -0600
Message-ID: <CAJCQCtQ8u6_6FaMwV+fY2rRaSmFxaNwiDk8bgPHYOR-rPhKEXg@mail.gmail.com>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 11:40 AM Dave T <davestechshop@gmail.com> wrote:

> dmesg | grep "checksum error at" | tail -n 20
> (no output)
>
> # dmesg | grep -i checksum
> [  +0.001698] xor: automatically using best checksumming function   avx
> (not related to BTRFS, right?)

Search for "csum" or use -i btrfs instead.



-- 
Chris Murphy
