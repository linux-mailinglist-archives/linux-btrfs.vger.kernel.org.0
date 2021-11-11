Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F352844D1E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhKKGXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 01:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKKGXW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 01:23:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3FC061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 22:20:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t21so4957323plr.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 22:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GoCLreCSesknHyZ1wAeKwc2uZ5vxfajw7FuZIundYE=;
        b=gMgpbtB9iFzFT5L4ZBadEj1ZVkUbwz/Ojujtu2aBnFUdbfDw+WfdnBSo+gNpLyToX6
         WX42z2nsCqjMp/r455uggf6KMbVyaFED0QAeYJXZLkod9emTVDtedl4CZkMo1vXtNXI3
         AP81mnLCM9lWiP92ytQuJ3sxJSABLOydPc7K3z8gfQ0CH4ICCrwnGpB/4jFk/+xntUog
         wI1eD40EfFi8x5IU/nLVcwQL5XuVHxUXx4wwQaqS2VMIATRRkOK+oMAUf9HoWNzBvHix
         l913uq/xeBVVG2WrCpQA/0Th65dQaBmkFHViPuX6lR9ZnddG8rvQ781xa9yoJdqBeRqG
         jr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GoCLreCSesknHyZ1wAeKwc2uZ5vxfajw7FuZIundYE=;
        b=1XOLMqY1cBUM6yJ5SpwgEHwmD3amyM/0OwOaFDUQALdeSsfDnwrYaBWHbwsHfMZT9/
         sw9bLCn3OTwwGJfPAWlY1gdzxPqFf+/3KD9cPTQXyWEgwpnrmrPTGHH1E/wgzUWdoL1T
         YpRL1FbQI5WtKque/vXMzGO0Wu47yQX5uRYzqlnulGGnFqvRzrKPb9YlYYrDKz25/c4r
         guK/OOJ/OksCuF2g4vomvvVk5ts5Bv/9q/oF377uIGOzelsAKkATX0X2VpUGpkE2octH
         02uwVhIFTapPaGILMFeEPGB+BARRl2iioR9bBi31GiA+6uRmRQzmPi8SBcSAkEfQnl0q
         g79Q==
X-Gm-Message-State: AOAM530MfA+BTPfQNQlS+M16G8wQeD22YENXsUW7HJK5eQw2+7DWLNPp
        htxeaSduqob8C9vhWuBcHL0mKlH7tgIiYxtTW8Ns/Sx5q3k=
X-Google-Smtp-Source: ABdhPJySmyIeQVzWynUSYHphoWtRc+WMVlpILS2IwTeb4UcO49CZ9GJQU3klgGxZ/f2D2rXsn1BJUq2JIjrpyOtLLxM=
X-Received: by 2002:a17:902:82c9:b0:142:401f:dc9 with SMTP id
 u9-20020a17090282c900b00142401f0dc9mr5192868plz.43.1636611632774; Wed, 10 Nov
 2021 22:20:32 -0800 (PST)
MIME-Version: 1.0
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com> <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com> <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <a5e0ebf7-68d5-9a2b-f053-4392106bb9f9@gmail.com>
In-Reply-To: <a5e0ebf7-68d5-9a2b-f053-4392106bb9f9@gmail.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Wed, 10 Nov 2021 22:20:50 -0800
Message-ID: <CAKxU2N9hC8ha-M1RV27Km3p24t2Dg32t0B9JEbbStr1i+s0BqQ@mail.gmail.com>
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
To:     "S." <sb56637@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 9:25 PM S. <sb56637@gmail.com> wrote:
>
> Oh, and I forgot to report that memtester didn't find any errors. I ran it one more time too, I think I managed to request up to 210M before the OOM-killer intervened:
I bet the actual issue is some 32-bit problem...
>
> ---------------------------------
>
> root@OpenMediaVault:~# memtester 200M 1
> memtester version 4.5.0 (32-bit)
> Copyright (C) 2001-2020 Charles Cazabon.
> Licensed under the GNU General Public License version 2 (only).
>
> pagesize is 4096
> pagesizemask is 0xfffff000
> want 200MB (209715200 bytes)
> got  200MB (209715200 bytes), trying mlock ...locked.
> Loop 1/1:
>    Stuck Address       : ok
>    Random Value        : ok
>    Compare XOR         : ok
>    Compare SUB         : ok
>    Compare MUL         : ok
>    Compare DIV         : ok
>    Compare OR          : ok
>    Compare AND         : ok
>    Sequential Increment: ok
>    Solid Bits          : ok
>    Block Sequential    : ok
>    Checkerboard        : ok
>    Bit Spread          : ok
>    Bit Flip            : ok
>    Walking Ones        : ok
>    Walking Zeroes      : ok
>    8-bit Writes        : ok
>    16-bit Writes       : ok
>
> ---------------------------------
