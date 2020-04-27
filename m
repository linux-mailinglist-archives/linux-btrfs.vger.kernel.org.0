Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919291BA749
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgD0PGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727834AbgD0PGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 11:06:55 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56110C0610D5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 08:06:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e8so16960806ilm.7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Apr 2020 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ULHHxyGDbcrKGouptCp0kKvfN/ZG9f90+hyrmktyfWE=;
        b=IGnt1RYDvvg4UUOLJO7lLf4iBHvivrIibg2EoIv9SUYMf5blEVrr9OI2zGsj77sGWp
         Vcl1s4uD3QdffHvnGblSoJx2bgw++5rR/neK784/5/+qAEjvD4Qcc7kuJWu9Zg5E2Vlr
         gD/rSnitzIHbmlMLzWS6oNJAiCHHSDo3XvXWhF97xv6HfiVz4PYuQwVGyI0uZq0zr8sz
         T2c7gRJeUPTkU0SitUfkzNN/wGfqeQGfLyTyyuZeE2be7pXGQHLwCnZVlSRZTrqBehkP
         LFMhgceQArwoZUBNHT9jiClUZYXIy8blDkWLGUcb8t0fKs4nnUG9Ywb443oNleHvCirT
         xbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ULHHxyGDbcrKGouptCp0kKvfN/ZG9f90+hyrmktyfWE=;
        b=RiT1clghrt5LZ7PC6AQeCmKqK9HAwYxwpSOsW6le6G/tjg6k7qzIxAnCKOg70/S4cZ
         dbUZQla8oZVdB3CR6RUSWdCC1Exa7ZBPzGEslWK6qXyObs7iLFvbl0TmhtvqtYKIyqPa
         lJsWe+l1p/GbrxOH0bSKerCplBXosNao6kklmw4XuQ2GUAu6gILpT8GxEaCzbDsn0GuX
         7C3DnyeVeU2UIwVmw+yqNjq1nKR4uvgSZ7eXSc3bWUsLXSo/J6ox/Vo8Dj9wqBiAmn05
         UvslGE83n9mA7tqmH/tvoX4yfZhxnLQn3yB00xOWunSRmPlmT2GSBDWKX48fGlXy+XjX
         Yjyg==
X-Gm-Message-State: AGi0PuZmIJSQbwiXTofjbdIUc5vMZaFO855bHNZjV0sWNTwXOS2F4s3j
        VW1b0VqFHNdAzt92e4HjmEo4YrDM/tNxSt1b1NM=
X-Google-Smtp-Source: APiQypKsTzbldEJ1z+yurKtFaq+6Wwuxw9Z3ckc+lFSFVyDTojpyGbVMf9e8McPjyXzSWa5isnWTPxkMEv5vyoSK12Q=
X-Received: by 2002:a92:7f06:: with SMTP id a6mr19745226ild.14.1588000012990;
 Mon, 27 Apr 2020 08:06:52 -0700 (PDT)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Mon, 27 Apr 2020 17:06:42 +0200
Message-ID: <CAL5DHTHbdXz03XUu2EjadStDWTMBsyawTnkbnXhgN=hAXMFN2w@mail.gmail.com>
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     kreijack@libero.it
Cc:     hugo@carfax.org.uk, linux-btrfs@vger.kernel.org,
        martin.svec@zoner.cz, mclaud@roznica.com.ua, wangyugui@e16-tech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

How will affect sleep of disk? will it reduce the number of wake up
call, to the HDD?

-- 
Torstein Eide
Torsteine@gmail.com
