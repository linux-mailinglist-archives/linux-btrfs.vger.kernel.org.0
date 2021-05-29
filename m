Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42125394E4F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 23:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhE2VoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 17:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE2VoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 17:44:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7EC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 14:42:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m18so6785504wrv.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL7/2IencQ87mb0+CwzF1udAeIDAXaED0/rEGBfZSZY=;
        b=lIxTUKEFP9DGAboNtKTQgnc0GmwFgEXu/yTedrfpn07B81HEi9w5u+AGPfnXZnvBQJ
         L3mFZWbMk+8TSqOodeX/a3epqERyGEH1GA0lSDkN+Q2GaESREiEL95AIeLhU2pE7k2xv
         YU0POI90q+Nvwtm49MmpUbMYObQzKR2M8kKf4AvmO1m2vM/zTrwPDZA5MZRO30IMOM9i
         qGIlvDJYTPGGDGyX753slAElR0lw2E5cA2X1BRe1t8RyaJuQHIVoBOTzAHO2X9lfvZuD
         KUDz2LVWoRY2IUw38CPfYLFYUxC0f8QVTv61GqJoiMcQ9OnoU18Thj12dWSgHmA/dE3R
         GFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL7/2IencQ87mb0+CwzF1udAeIDAXaED0/rEGBfZSZY=;
        b=ISQD2al+fG6/SHa4EtolmzJfhQ/zOmq8ijUYMX1b41YtaKdtspwYojjNQuVW5lDgBF
         nAr78ZcFMhERFckxrFBxjolnQUJ4Md4Jaol4IMtJmYg6mOLERTyioEKkQwk6NRVsHQK1
         VT0JHEu7cf6hd9e7BajgcCFgl0thPIzhJqbkWV7+aHtHvGSN2Pf5OgGQBYBj7dBEl4Ut
         R9lV2CgD0G19ifRJhcPa6NZrTw3XqpfBOE0q++P+BFcSQG/OCTBRQrdfVaT1Ooy5eS/T
         YUJ31/kMugmLKcI2mvgHJOGEckJe0K5vb7hEs0J1fdCoEZmI2Gby8fcj7kLtMWSDTnXJ
         rKUA==
X-Gm-Message-State: AOAM531CBtUIml0fohddrg12IKIkAHrVqC0KSmyiEMgims6FLks+H3zO
        JZ1fD+/ZBHqToHgMpPOvxFHZu6kxdFsabJ1G2vSEaQBeMrJn6Eb3
X-Google-Smtp-Source: ABdhPJzD5IjM1KM2wxaaFJI/FvmvB3/WuNsC9cvvmGuBGbIHtmgQmzVc+XmimUhoElxYXka9fpOgC75VkRybxMm1NoQ=
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr14985813wrq.65.1622324544613;
 Sat, 29 May 2021 14:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRnxq2mKOkjQzOedjnh9oxsNOFKoP92pjxDGwuUw1AOYg@mail.gmail.com>
In-Reply-To: <CAJCQCtRnxq2mKOkjQzOedjnh9oxsNOFKoP92pjxDGwuUw1AOYg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 29 May 2021 15:42:08 -0600
Message-ID: <CAJCQCtTTAJ6dJomJmisVJ8gzTDGbij=SVP=omn4xgVfzQvUyBQ@mail.gmail.com>
Subject: Re: btrfs check, persistent "reset isize for dir" messages
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 27, 2021 at 1:09 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> btrfs-progs 5.11.1
>
> User is reporting many "reset isize for dir" messages with btrfs
> check, even following use of --repair. What does this message mean, is
> the file system OK, why aren't they actually being reset? Would a
> btrfs-image help?
>
> I'll ask them to retest with btrfs-progs 5.12.1 and include lowmem
> output as well as regular mode.

There are numerous other errors still with the file system, following
--repair, using btrfs-progs 5.12.1. But it looks like the "reset size
for dir" messages are gone.

btrfs image
https://cloud.mail.ru/public/Uf3R/paBECvbN2

btrfs check (redirected to file so it only contains the remaining errors)
https://bugzilla.redhat.com/attachment.cgi?id=1787825

btrfs check --mode=lowmem (also redirect to a file)
https://bugzilla.redhat.com/attachment.cgi?id=1787827

Full downstream bug report and all attachments
https://bugzilla.redhat.com/show_bug.cgi?id=1960738


-- 
Chris Murphy
