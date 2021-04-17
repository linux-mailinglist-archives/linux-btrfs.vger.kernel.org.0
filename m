Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741F8362D31
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 05:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDQDaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 23:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhDQDaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 23:30:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED42C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:29:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g9so12423798wrx.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Vq0gAYO39RRbeS0AUAERD1Vbq9fOunOsQfwqTrTL9M=;
        b=mJiHJcNydCJ+PUWs0mCpU9RGH1jjc7vueGuBIjn6fVE7NtKdbgGa5aPi2q2pF/oz/n
         sak8sR/gPcqPlAyCJtxcFpsEJJwKENb4CI8rcgOdyqZFABfVN6uswNaMNz/jWTVnlMpv
         gWks+i+4EfOZgN+tZPP9ORa6rPotcYXCNhNV1KbhrglD3WBAJ9WBORkVUuDwFekMb6oM
         bOCh3cOJB3j7exEQOt0tKIbytFKa3fvh5iq/0fuJw2vNpX3AEUVqZy/UdCvqjdefaAps
         hVp++7aqFRvjcbKnIUyGxU4f87SDIy2U+V1RtuHXhprwY190tmNDFrmy/sUUP3PjCNOk
         VY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Vq0gAYO39RRbeS0AUAERD1Vbq9fOunOsQfwqTrTL9M=;
        b=XpapVtSQoP9e0m+3peprhB9lsQzfXPRn6kfzriRrGWOQHyfAsalq/7I33Et7laUkeC
         oWr/9M+QDb1mXXLGpri84qQY/v+wn8NuP+xJiZP5HNdi1SGADXOyL3HleaiVNc/UVfSw
         c4wa+umdWoxVrYDUH3iPSKIF3ct2SQTZFjkloE81Jicr84oQNXCoh4TCqhCpZwb+3kQL
         v+zWWpLrXXX8/I0cH8L+2LFvSVJo+/3Oq+dkMqZS/YnFzWMR//eunD7BmA6RTJiWpi9u
         J8PIHp1ArJDqeqk+rK8jE4Yh4G74BlMrmRhf2AUpMiu4Qo5U82pOjRnxdZu6dR1GRRMi
         OkAQ==
X-Gm-Message-State: AOAM533xs61oq4sgLZlEfXMpRe3Rzv6eLuwUimrkB/slr4EFgIN2Z/Rj
        shG0pZ06DL8NxgdY1oy3UBD/UjM79uBZMtyQv/dhVP1kjAcGSg==
X-Google-Smtp-Source: ABdhPJwBDubBPa8GvluLrz1VhukIQfch1enbQ87/mLjk+pR05NcP0StJg06MiI/Gm/Cf+cTq0CX+tF/a0eYBO2S3F5E=
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr2152982wrg.274.1618630174854;
 Fri, 16 Apr 2021 20:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9tQ0dr1+TTrALYUGfgx7tViU1tVU00OyAxkP1qsUUkyVsXPQ@mail.gmail.com>
In-Reply-To: <CAE9tQ0dr1+TTrALYUGfgx7tViU1tVU00OyAxkP1qsUUkyVsXPQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 16 Apr 2021 21:29:18 -0600
Message-ID: <CAJCQCtTD+XKZOfOi8dS13qbp7L_MUsSVt1eF6raFjsTEE3-NBg@mail.gmail.com>
Subject: Re: Design strangeness of incremental btrfs send/recieve
To:     Alexandru Stan <alex@hypertriangle.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 16, 2021 at 9:03 PM Alexandru Stan <alex@hypertriangle.com> wrote:
>
> # sending back incrementally (eg: without sending back file-0) fails
>     alex@alex-desktop:/mnt% sudo btrfs send bigfs/myvolume-1 -p
> bigfs/myvolume-3|sudo btrfs receive ssdfs/
>     At subvol bigfs/myvolume-1
>     At snapshot myvolume-1
>     ERROR: cannot find parent subvolume

What about using -c instead of -p?



-- 
Chris Murphy
