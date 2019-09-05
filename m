Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064EAA9887
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 04:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfIECrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 22:47:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIECrk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 22:47:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so840591wrd.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FTeSVW0iifcqiACGODvasQU8ER7yLB2qGEZPTGBQZQ=;
        b=kkKbCgli4WZBwWxXK17HGB9S6YwpFdyL8cT7g858nFs6FAIP6yoEDgj9FTfOIrD6aw
         +cJrwEYliEYYeWjWmCAPGilBVoRWHykhliYGYIJeFCM7vG45ZB5Zof0PvXcqW9sjgq03
         jqEahEkHXFHc38E0zNf7AGQKW5hM4K4tbKJTL/PFSnL/g61AcFHT1flvms9XtyL+y6SB
         jFM/qzfi6GshP8l/WD5kZNWrHl/g+9uxhmR3QtPkUvM4h0PRgksnPznggWCqEsPZaZ04
         8IiyOXnwatXrMWMIIQs5MsZalxOmr9pvwuV/W7nCusPzgFQ2bSbqwWirIWgXoaYbyPC7
         rHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FTeSVW0iifcqiACGODvasQU8ER7yLB2qGEZPTGBQZQ=;
        b=hPQGxww8IfSc+6WgXwbTrYr+F1HtDxSDD7v62aIC968JiXAMLFbX1pBm5b4AT5n0zK
         1l+IxsPfPg/VUtjMi9E1uCouUP+ZrqXZPV90Euh1iZSGn3sW7NpN3PDfULvUQKQTV6XI
         BMlFBDd86s14uzo0gXN5fj+FN8yOKejzuLgiThFTQBfYI50kZ5fl+x9ePHaesNZoJKx0
         eO9Iev5SFbhdVqFSieRRR6c43jObraluekyKgPPtV4b62yjmsb3zrvKqNVYorf3zVMsw
         lHrMBJxuZtKb3dd+RxRMrs249e0ckGMXgsBrEoizPmW7LjzHkysTQqAaFsf2w2T4m3ir
         Sqyw==
X-Gm-Message-State: APjAAAUbFaUbSaaqbxie7/CMpkSY1LtvJXP9LTpjh3/Gd0aPu68ysuaZ
        HWAx1jpDJ6xSo//j/2UdghNsLYF9bq8x3/Xj8hifPA==
X-Google-Smtp-Source: APXvYqwS8MEkPYp5f1jYUobtb+iQRWPrJL3UR6wwOv24NxTqhU4lj0dGdxalHePHRTbyjzzDvW38+8rxaPPEXWV1Z8E=
X-Received: by 2002:adf:e390:: with SMTP id e16mr542006wrm.29.1567651658684;
 Wed, 04 Sep 2019 19:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
 <20190904140444.GH31890@pontus.sran> <20190904202012.GF2488@savella.carfax.org.uk>
 <CAJCQCtQoKOL68yMWSBfeDKsp4qCci1WQiv4YwCpf15JWF++upg@mail.gmail.com>
 <5b5cc1fd-1e68-53c5-97bd-876c5cf08683@petaramesh.org> <DB7P191MB0377435B086CBC80B5713B1192B80@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <DB7P191MB0377435B086CBC80B5713B1192B80@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 20:47:27 -0600
Message-ID: <CAJCQCtTJ36JR7xbr1kO5hARn3Tsm3Far8JWzLo+xMUNXhptswQ@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     Alberto Bursi <alberto.bursi@outlook.it>
Cc:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Chris Murphy <lists@colorremedies.com>,
        Piotr Szymaniak <szarpaj@grubelek.pl>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 4:14 PM Alberto Bursi <alberto.bursi@outlook.it> wrote:
>
> There is a python-based tool that can clone a btrfs volume by sending
> subvolumes to the new filesystem,
> one at a time. I never tried it, but it has a bunch of options, a decent
> readme and it's still maintained so
> you may ask its developer too about your case.
>
> https://github.com/mwilck/btrfs-clone

Wow this is really cool! Just reading the readme is enlightening.


-- 
Chris Murphy
