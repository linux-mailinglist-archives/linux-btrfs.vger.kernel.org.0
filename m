Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319FA2E8F2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 02:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhADBQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhADBQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 20:16:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53251C061574
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jan 2021 17:16:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r7so30551965wrc.5
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Jan 2021 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KCKm2R8095F4LZlCgbhrG4zmOYkZATBAyYXiaVXvSc=;
        b=G0OBdMbsq/T9SjDBsITtgq2f8wZM189L4LamaNU8tm7h0AnSjPA/hbwR1DLdrc3OWa
         UsD15Onnpm1V5hIPMNOpGrl/AOPMM09f4oGjUXcyfBN/fIKXGQB/iYd+PNUrngxkyXui
         ttFo35ynras/Dav5EKKUTOLYnU6RDLD+fgsoX6/HMZMaA92kXkbW6imHXVN++18JXSN3
         dbIdOId8v5G2jzRskeE6gyL+8+YTN6P4GwkIj9YeSIQSY9sDJHPCHuPMr8QD+b+IlLWs
         8rS0FDUBMfPK5jNDgaSvZWDADu2XSvkG6wCgmNhWG/5CpbK8zmfbWBjGt+q4K1u31ikP
         JnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KCKm2R8095F4LZlCgbhrG4zmOYkZATBAyYXiaVXvSc=;
        b=M2ctIimJymm7OISFaR+tTIMbXd55JW7qmHZD1q2/TxZ5eaz1U8VbbkyOOvUXmpyk9K
         4d87n0U/lfyg3+EL08haSSd4NKmC/eMJefhkvPJIU6Vl5bbuJhda4qIttiegI6OgUSLA
         joXyjW3IssUgoVGFqedbnjvvEmWj42RKzMF3ARG4tgzhBL80hM1qD+zLsFAJWUheE+Sk
         jwpBGBNYGxXz6tUGhtg/tMCQG+YOm3vZ1E8nvTDq/j3PT3d4JIRs8WGiCS0tv7eAd5VX
         jID3RHL9PQ4fQcNt7AFxXnvVZAN+DEFMLd/1xTn/10oDceWD2+Odll2hzam9nxWrdS5Z
         /Xqg==
X-Gm-Message-State: AOAM530TifZmCM5hCSoa2gZwoEIG7kvg3e5JiEuT8HtD2Gmk04PzZp53
        7zSSLyGxKdyxfICsixAqZTPhD+jMsSr62U0AzsTrtRt9fT58ASne
X-Google-Smtp-Source: ABdhPJzN8PBL6MUSyduQAD2xqsz2FH3bnCnZhj2MWp6BH1kItBqMWgBZFxfgEuo9Tg1zYj5Spzsozh511OxnJjSiEdY=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr78273192wra.252.1609722965971;
 Sun, 03 Jan 2021 17:16:05 -0800 (PST)
MIME-Version: 1.0
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de> <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
In-Reply-To: <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 3 Jan 2021 18:15:49 -0700
Message-ID: <CAJCQCtSJp56zCdsOrbWd+yi9S8wNMCy5vygbK89KGGt9LZtjcQ@mail.gmail.com>
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The problem is worse on SSD than on HDD. It actually makes the SSD
*slower* than an HDD, on 5.10. For this workload

HDD
5.9.16-200.fc33.x86_64
mq-deadline kyber [bfq] none

$ time tar -xf /tmp/firefox-85.0b4.source.tar.xz && time sync

real    1m27.299s
user    0m27.294s
sys    0m14.134s

real    0m8.890s
user    0m0.001s
sys    0m0.344s

----------------
HDD
5.10.4-200.fc33.x86_64
mq-deadline kyber [bfq] none

$ time tar -xf /tmp/firefox-85.0b4.source.tar.xz && time sync

real    2m14.936s
user    0m54.396s
sys    0m47.082s

real    0m7.726s
user    0m0.001s
sys    0m0.382s

====================

SSD, compress=zstd:1
5.9.16-200.fc33.x86_64
[mq-deadline] kyber bfq none

$ time tar -xf /tmp/firefox-85.0b4.source.tar.xz && time sync

real    0m41.947s
user    0m29.359s
sys    0m18.088s

real    0m2.042s
user    0m0.000s
sys    0m0.065s
----------------
SSD, compress=zstd:1
5.10.4-200.fc33.x86_64
[mq-deadline] kyber bfq none

$ time tar -xf /tmp/firefox-85.0b4.source.tar.xz && time sync

real    2m59.581s
user    1m4.097s
sys    0m56.323s

real    0m1.492s
user    0m0.000s
sys    0m0.077s
