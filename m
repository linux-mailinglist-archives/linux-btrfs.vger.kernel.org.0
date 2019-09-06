Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92ABDAC211
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 23:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbfIFVfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 17:35:44 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44386 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfIFVfn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Sep 2019 17:35:43 -0400
Received: by mail-wr1-f49.google.com with SMTP id 30so7935435wrk.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2019 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54Klza3LjXKhzW3sUGC9/V5PJf1/zmXbTf2GpxfPDNs=;
        b=FE340TXuLZLp9fVnIm+mhpWwt4nAU4QR1mw7ga0u/hGsCiM+IZkixSEGugiz/1Yot8
         301cFESz1JiKBrq1XTtWzygtpRwzjuiosW7JWVBPAM6/m0hzWrWgNJYh887SlTRyRpsU
         Z5At+nEC+hYJRt6f10Xlq4QWnRlcTLOie/xHD7TpG+N0d/PV1SKVxJhFGBmiDZcD0wvP
         Hy6xOew/naQ1HEwOz7AsXn2Oeu3ZN0VV6bEkqdHux/ZFSY6QYl/zLj53TB4mkLk0wzqC
         h0Pd/+U5xsG70hlBsjzfS5gKKgBBsilsVHB2q4NIqPQKBHzUeYOiK1YKZz+sZ+ksO7BG
         6dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54Klza3LjXKhzW3sUGC9/V5PJf1/zmXbTf2GpxfPDNs=;
        b=l1QDsawP9H9zgZ94A81k7j6ig8ciuc7rek5LEBem7SvPkZJqPXrOezu89T+jehXhVw
         u2yuIkSXdFL8bTZV5SVX4vWnAknYfsqknlWRSWgNMC64lp+/syjDdK9C73567XCpA3ib
         wq/KWIIEyEwf3im2QZgeVukPEqAq3ZVEMmSH1bDAVY1lHk6XJsc5bPt9T5yCU45aMJ4D
         nIeque1gMIGwRG5QGMrx4FMlWi7X0foJD8VQNJxYTxmKKUImTCqNMbpqzhgd/1adIy++
         0HqQhem/BOenRZQrenzw5pIam6PlW60dfZvrnCnZZhpp5uJp6r5VTVyhG1bC0d/tgSIB
         Wmhw==
X-Gm-Message-State: APjAAAXyPXg+diJ7w/ltSFIE4E7+723QTkT4MeogR4LBgX13repdayij
        sraZooc87RZZYftRH6VoE3LEUtFg1RVeTctgWkOLsQ==
X-Google-Smtp-Source: APXvYqxOFRvn1/q1Kl98oqid6K/JkPramW8rEZd4eSGVqvgOXPNEgFKOb9WmL/v3F2fsAdORf+895c4+olzKsXCJ/xY=
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr8742716wrv.12.1567805741582;
 Fri, 06 Sep 2019 14:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <4d97a9bb-864a-edd1-1aff-bdc9c8204100@redhat.com>
In-Reply-To: <4d97a9bb-864a-edd1-1aff-bdc9c8204100@redhat.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 6 Sep 2019 15:35:30 -0600
Message-ID: <CAJCQCtSm0rv=-zoAReP7+kjdvV1ihgi7tx1sh9YM=on_fZLKNg@mail.gmail.com>
Subject: Re: LTP fs_fill test results in BTRFS warning (device loop0): could
 not allocate space for a delete; will truncate on mount warnings
To:     Rachel Sibley <rasibley@redhat.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 6, 2019 at 1:21 PM Rachel Sibley <rasibley@redhat.com> wrote:
>
> Hello,
>
> While running LTP [1] as part of CKI [2] testing, we noticed the fs_fill
> test fails pretty
> consistently with BTRFS warnings seen below, this is seen with recent
> kernel (5.2.12).
> I have included the logs below for reference.

I'm only 6 for 6, but  so far can't get it to trigger with 5.3.0-rc7


-- 
Chris Murphy
