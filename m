Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4347AC3F7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJASKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:10:35 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50290 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfJASKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 14:10:35 -0400
Received: by mail-wm1-f48.google.com with SMTP id 5so4439096wmg.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2019 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcQ3axwe9wZupf0LvDLpAhyq/vSSp/VNlnWFHO1kDtE=;
        b=ncDgqfZ4QljpNZ0pGCErpXZuU0dA6lzQP09k53u6Zc2z4CuFr1Wfx1A+t5RYQcGN9R
         Lujw014xU2H3bQJ/QmrXaV5wzAFRmUkVdWi8Kmjf07PeozuNmXFf27sBgGX8lrZFLw7o
         zooXcVS0JP72T4rcs6ZCIQbfuuhB1RnlpFrI/nvrBnot2Ygp2jJ71NSPGEi/ztmjuS82
         V5hD7SE+2RJM+xeFow7+dbO7Dw2zq62PmzNnHj1z60NiEX5coUDRYqXEBlMCFsJFybTL
         HRujNmXPT7MaJo8FVbRoQEJz54GartOzrNzJzOGklacp3iYNXuXsk/Crzi+XjxX4LHg1
         JSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcQ3axwe9wZupf0LvDLpAhyq/vSSp/VNlnWFHO1kDtE=;
        b=hj1u5daewq6MU0PoBaEolbZiqgnxV50ZcLhIRZleuWXlSC//4442j1+2tXRJ02oS5P
         v2oadFYQMjP8Wtvh8t96pBhrSLNDEMKDzX5CkAVLYjcqHBO8cheHpYk5Jbk3O7GmYdCi
         WiKNy5922oqbpYoi2pDG8AiYRcEWn5ARdvkF18BZXcnYJr188jwoztGfOSE3gnmErLJr
         +siMkfi3hzXTVzbnWxOlHo/llK1HvYl8hM4noavU1cJX9EHt3l/lT+oJLTZUEXY70bKM
         2Fu1OI78wK56TtVhx9F6RyFOjgahoIhKEkvN4YOZwElSxTOMsbBMNZj/HXUeY7/nhmn4
         ZLrw==
X-Gm-Message-State: APjAAAVhnhHpW1q178aqhkAU7U9MCMt1eGFGWWihF1xem+Fu5iM5z1No
        itJgdXN7Zivq39/RSrDA+bpynv4XPvTSzJYzD7i2nw==
X-Google-Smtp-Source: APXvYqxsrwJgX1PsNTwIatmRMuF4EZCoey5E/+HzXoVXV9bngwvLHKh4BSLN5u6F2Prbqp9q5OuQAg1k3Qp9vJ2zJvM=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr4711185wma.66.1569953432489;
 Tue, 01 Oct 2019 11:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
 <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com> <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
In-Reply-To: <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 1 Oct 2019 12:10:21 -0600
Message-ID: <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
Subject: Re: BTRFS Raid5 error during Scrub.
To:     Robert Krig <robert.krig@render-wahnsinn.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 3:37 AM Robert Krig
<robert.krig@render-wahnsinn.de> wrote:
>
> I've upgraded to btrfs-progs v5.2.1
> Here is the output from btrfs check -p --readonly /dev/sda
>
>
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: f7573191-664f-4540-a830-71ad654d9301
> [1/7] checking root items                      (0:01:17 elapsed,
> 5138533 items checked)
> parent transid verify failed on 48781340082176 wanted 109181 found
> 109008items checked)
> parent transid verify failed on 48781340082176 wanted 109181 found
> 109008
> parent transid verify failed on 48781340082176 wanted 109181 found
> 109008
> Ignoring transid failure
> leaf parent key incorrect 48781340082176
> bad block 48781340082176
> [2/7] checking extents                         (0:03:22 elapsed,
> 1143429 items checked)
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache                (0:05:10 elapsed, 7236
> items checked)
> parent transid verify failed on 48781340082176 wanted 109181 found
> 109008ems checked)
> Ignoring transid failure
> root 15197 inode 81781 errors 1000, some csum missing48 elapsed, 33952
> items checked)
> [4/7] checking fs roots                        (0:42:53 elapsed, 34145
> items checked)
> ERROR: errors found in fs roots
> found 22975533985792 bytes used, error(s) found
> total csum bytes: 16806711120
> total tree bytes: 18733842432
> total fs tree bytes: 130121728
> total extent tree bytes: 466305024
> btree space waste bytes: 1100711497
> file data blocks allocated: 3891333279744
>  referenced 1669470507008


What do you get for
# btrfs insp dump-t -b 48781340082176 /dev/

It's possible there will be filenames, it's OK to sanitize them by
just deleting the names from the output before posting it.



-- 
Chris Murphy
