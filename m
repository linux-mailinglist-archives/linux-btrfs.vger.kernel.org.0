Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2657115A7C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 02:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLGBFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 20:05:43 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33419 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 20:05:43 -0500
Received: by mail-wr1-f45.google.com with SMTP id b6so9731337wrq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 17:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66Pq6BUiFW5re//Ng/mdlD7vuJGGmbPanQUO0nat8KI=;
        b=yIhNf+cWvJikfTXMtUDvaQE7V0v+B18D/Wkzl58DeRMU2c2ua9kGzlXwW6Zovx1d+m
         3OuOIzlximlakz0VnWBXDXpQx4cJFYzUoskmqodAZTBrqbH5YFjOscPD8s52X+SkWx3r
         g/GJtJQhrhqPgRWGPK8Yk8J4vHsLjR6JtYUCax05hknge8njcybyz79ih6vVMB5WLOj6
         nRlJWO0eiRhLGhvNrbxEo8ws/2rLy+x0st9Ju0miSYszCH6XipMukkZ+5iI/yaG7jU71
         6YzmJOwlbbdXDk97dWNz66o8xwhdvDzVMneJCkV8SyVYq4G4392YAn2od9LHVuPN/nTD
         0RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66Pq6BUiFW5re//Ng/mdlD7vuJGGmbPanQUO0nat8KI=;
        b=BLwIo07b+7z4NQzEatbO7MUsnkmL1QBj4dFum6ghCaI9FBOtibLlv2bXrrmbHcWFmM
         qetNg+8wuPUw0klMdinsEx5Ien+MVkM0lNp4IanSnFbBl1c++cu1OA9QPDTLXwo9N94R
         zRevQggVDgFRasWva1HCuPGuSjF+7QraoD2VEO2u401VDFEFcZ9Cm7PSHjvukZmiDtPO
         7J3UJBwIWv5LHnQVf6whxlg4Yrqko9vSoNVMNlqXpfsh5m7WG2E+rFzidLVrd5Tlvc8J
         EK/dOgPU5q4DSfbfmPHYsgQknLpsRYnZKOrBQME3BzIYR0sKB0OKZN3rLm0ME0A2c0ns
         rwEA==
X-Gm-Message-State: APjAAAVbWkJNfzYrt3PfPW4B34Jy2hACsR3CcucizvuaecXCWMWMlNJ9
        7itRfmMun2HfY8bmqO2BTPjTjyProhqHS+EMxQ1gyY8mdcM=
X-Google-Smtp-Source: APXvYqx8Y4yIubKKEbPCvWVXh4+7w8bMtqBZNQtdhmDdrJTpVHeyGu6kqFdlUFFv0extTYfTfh0MKbbR0Sk0jidxtxE=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr18661954wrn.101.1575680741338;
 Fri, 06 Dec 2019 17:05:41 -0800 (PST)
MIME-Version: 1.0
References: <eb9cfb919176c239d864f78e5756f1db@wpkg.org> <CAJCQCtQ9Vg9VuT66diid6KdRMDqicxj9xLigTBF4sbMgqD=5jQ@mail.gmail.com>
 <c768a339fee28c7b4296d94b02beff12@wpkg.org>
In-Reply-To: <c768a339fee28c7b4296d94b02beff12@wpkg.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 6 Dec 2019 18:05:25 -0700
Message-ID: <CAJCQCtTB8oKnG0kAkYC_wCvVE1WBYHrAYhWoZR5zKsmGgut6AA@mail.gmail.com>
Subject: Re: 100% disk usage reported by "df", 60% disk usage reported by
 "btrfs fi usage" - this breaks userspace behaviour
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 5:47 PM Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>
> On 2019-12-06 12:54, Chris Murphy wrote:
>
> > What version of coreutils?
>
> This is Ubuntu 18.04 LTS, with coreutils 8.28.
>
>
> > Maybe attach a strace of df? (I'm not sure of the list attach size
> > limit but it's preferred, but something like a pastebin is OK also)
>
> "Unfortunately" I did run a balance, which "recovered" the space for df.

Still an interesting data point.

-- 
Chris Murphy
