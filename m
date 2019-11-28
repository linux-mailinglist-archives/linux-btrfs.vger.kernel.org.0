Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC75710CF0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 21:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1UFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 15:05:53 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35319 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1UFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 15:05:53 -0500
Received: by mail-wr1-f52.google.com with SMTP id g17so458287wro.2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2019 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQYbYl9Ch8LwRT4ZHSUB2zRaadPt9+9Qlq+hVkpFdDQ=;
        b=WN+RNfsF+XwdZTflsJ+CKDwZkB2T34si6cYAh6ilFViT8RRtwPqsSpuk/jMhzQkViA
         bzfA4z5FSljP/q2E6InQ0v5DhQSy0pjzew7B87k6AdBXXv51cqv5PBqc0KkGQtPKcBAp
         nC6aDj5IB9/Ek99pkrzeesIQbum+0BYqkStvFTww1IkoUwnavD51ZM35NSwfy4wmq7T3
         UInaMoXUHKpHt/Y4iQ/fYkxVYt68Apw9OnImmqQtek6KS818z/hCof9g7SVMviWK05r+
         c3bmn8DDvXvXYlbNrVZxhVbpH45Fq8lWYBC624OLcEndCRqUWOc9x5EjjCNWAjVdFqay
         TFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQYbYl9Ch8LwRT4ZHSUB2zRaadPt9+9Qlq+hVkpFdDQ=;
        b=HFFDrB2jl9Guo+YTFkCe9wFo3608ly89X47mKiscvbyaaAbGaAEDjzRmtSV9q8W7u3
         9BTQQy/kEyE8K333xqhYC4YzSlnyjPmjHe2ePQok1BOLbD1AKIrPFXOFXmmhjRZZkJS/
         KNjiM4oxZ5fEYERrFpPItb7bsMJtwlrGs1VxatLUFuz83KT6INext2EAKPYFEg9iOyO8
         +dS6PaRbA/1NlQ9km302XRLDtH9RjNcWVHP/w2YtntZ7Zg4ziz9+WLXQGyls5TFuNwdX
         C5tBQJSy1cX1r6QYaBPrkHDTmIY3ZDHLmycg9zQH5Vd2kaIWB+dAFY6H/D+6zW6OZCdP
         G9Vw==
X-Gm-Message-State: APjAAAV3GD3CUnGbH7soNPyPs/Y26ThbmlwTF4MTl5PlAk0/JkWtoNim
        3CH4yjuVrvk43Iyg3LKKRyvV3uJXUSP0KAhZKZTeow==
X-Google-Smtp-Source: APXvYqyXbHnm9REwPnlDc70QjCZRyOt0vdsIMII6T5wfW7440hgx+bOPoHlW1pShb46IFGTq4Pd7QCYscsKP1BPg9bg=
X-Received: by 2002:adf:da52:: with SMTP id r18mr50229387wrl.167.1574971551344;
 Thu, 28 Nov 2019 12:05:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it> <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
In-Reply-To: <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 28 Nov 2019 13:05:35 -0700
Message-ID: <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 28, 2019 at 10:58 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 28/11/2019 01.42, Chris Murphy wrote:
> > On Tue, Nov 26, 2019 at 11:07 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >>
> [...]
> >> Could you enable the debug, doing
> >>
> >>          set pager=1
> >>          set debug=all
> >
> > I need to narrow the scope. Adding 'set debug=all', there's just way
> > too much to video, minutes of pages just holding down space bar full
> > time which is even too fast to video. There must be over 1000 pages, a
> > tiny minority contain efidisk.c references, the vast majority are
> > btrfs.c references. As many pages as there are, I was never able to
> > stop right on a boundary between efidisk.c and btrfs.c. So I gave up
> > on that approach.
>
> If I remember correctly, in the previous email you reports that even a simple "ls" at the grub prompt raises an error.
> So you could watch what happens when doing something simpler like "ls" or "ls (hd0)"

Errors with only ls.
https://photos.app.goo.gl/BJpsLvwpL6yf19uj6

Errors with ls per device
https://photos.app.goo.gl/pgxQDdj1JDjq86mZ9

But without rebooting, just repeating the ls for the same devices, I
don't get the error for hd4 again.
https://photos.app.goo.gl/M6yraHfgfAsMigaP8

From the first ls, it shows GPT on hd5, shouldn't 'ls (hd5)' report
GPT rather than no file system? gdisk finds no problem with the GPT on
/dev/sda which is hd5.


-- 
Chris Murphy
