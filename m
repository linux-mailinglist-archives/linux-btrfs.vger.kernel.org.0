Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB212FCCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgACTDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 14:03:00 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39483 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACTC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 14:02:59 -0500
Received: by mail-wm1-f49.google.com with SMTP id 20so9446687wmj.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgFJwExE5/xv5t+UUVlVeupX2KsG8st/CX5A7Y/2IVM=;
        b=sgSJFmmgVm6dE7wGPIUSRQ78OjeSu342ZpnutWPjlBONnKKTVXw9SLoUrUHwhw2kqs
         e55utLAuKzkPBPe7zWr93NEilWgfRqTv9dhMFKYUXu8JUIIRcRWssIXGx2+x0Lzy2bRn
         pdAQSH2ATzE0inAKaz9+6pPCud4Nr9uXMNPFgSxNu8kC+cTskBubS/JFDe03tlHVDWsl
         9sXeGDsvz3eeVO1wGky9p0zviIVrEQvCf5Q5p0HCD4fezYh5NLhPt/HI28DtWfyiUJKw
         u8Cmv9gO49dLRqixPHNoImJd7Cq/jWgdjv7n/1k30y/xSiKMxsta2AmS0JiLbWt/np2R
         oMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgFJwExE5/xv5t+UUVlVeupX2KsG8st/CX5A7Y/2IVM=;
        b=Y5+mJFAuE9aF7Tb0TXnAlNxXfT0XMeEkkelL+hJ16GGUhVOEBIgfd0fYhWx38/+KGJ
         ieTrF4iQWXpC80XJF29XKdPARmjbbU+t8Zw1Y5XB5QPRSzBXssUycfFBmUGklax+M2mg
         4KjJ0TnJJjlL/XM3kklacc/XGamizlmIr14ZhEvYVfUofngksUBd0spQ5ScqGsHsShDy
         CaF2O+81io4w5NL4d3LWauVOgIG3ij82SwfKbHT93ManspNDuO/UO9AZNXK10FJhEkjP
         I0afCgxDcDNecM1a19+m9RqLS8/nWUPyZnsvO3fQJfy8rGC0wlZf0M6+VBVFNKcbsi7I
         bD+w==
X-Gm-Message-State: APjAAAXd1dykDq1Hpk4cupLIy1tkLut70qIiUvCZ2aMLou+51L0kA/Mx
        FLHCw1x8XePr0OThhOPYGl6DzeUyRfJ7gRLHH2oH57lfUx8=
X-Google-Smtp-Source: APXvYqz8JbbKukeH/cuaYsqTEe5pSdRTY5hTH+BteGkG79quNS/2JyVJrhoKPCoAYvyBFhx7WVI9rFHiglwWp73giJc=
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr20763819wmk.97.1578078177807;
 Fri, 03 Jan 2020 11:02:57 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl> <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <7c82851a-21cf-2a66-8d1c-42d57ca0538f@dubiel.pl>
In-Reply-To: <7c82851a-21cf-2a66-8d1c-42d57ca0538f@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Jan 2020 12:02:41 -0700
Message-ID: <CAJCQCtSpFyfHAWVth5PuvjJtiHPfN52WzspOdsvLrJxMdbcirw@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 3, 2020 at 7:39 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
> ** number of files by given size
>
> root@wawel:/mnt/root/orion# cat disk_usage | perl -MData::Dumper -e
> '$Data::Dumper::Sortkeys = 1; while (<>) { chomp; my ($byt, $nam) =
> split /\t/, $_, -1; if (index("$las/", $nam) == 0) { $dir++; } else {
> $filtot++; for $p (1 .. 99) { if ($byt < 10 ** $p) { $fil{"num of files
> size <10^$p"}++; last; } } }; $las = $nam; }; print "\ndirectories:
> $dir\ntotal num of files: $filtot\n", "\nnumber of files grouped by
> size: \n", Dumper(\%fil) '
>
> directories: 1314246
> total num of files: 10123960
>
> number of files grouped by size:
> $VAR1 = {
>            'num of files size <10^1' => 3325886,
>            'num of files size <10^2' => 3709276,
>            'num of files size <10^3' => 789852,
>            'num of files size <10^4' => 1085927,
>            'num of files size <10^5' => 650571,
>            'num of files size <10^6' => 438717,
>            'num of files size <10^7' => 116757,
>            'num of files size <10^8' => 6638,
>            'num of files size <10^9' => 323
>            'num of files size <10^10' => 13,

Is that really ~7.8 million files at or less than 1KiB?? (totalling
the first three)

Compression may not do much with such small files, and also I'm not
sure which algorithm would do the best job. They all probably want a
lot more than 1KiB to become efficient.

But nodesize 64KiB might be a big deal...worth testing.




-- 
Chris Murphy
