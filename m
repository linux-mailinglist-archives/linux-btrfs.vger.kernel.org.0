Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CFB233DB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 05:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgGaDgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 23:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaDgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 23:36:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131DC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 20:36:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k8so7993313wma.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdQJyJqpFN2fR/l7hckq15lT8jtEq5VWWhRVFYg0P/Q=;
        b=uyKY8BtQdlmEneE0oQsNDF4E/t+y1wSvB2KqCV9g0bDVt+jeoylYPutoHkfJf82ars
         rnXLnVvF9aMqhiOUvJ2N9gvo9f6sFg3rJJ8cIZscdRvt5DhsILRWM1KZJq0Bgvlz2OfF
         s1+a+MgXOF9Qq6an90YhmpxBmVco1z2j4aFYU7bJb966sT1X/pAgI+IiiVBsaLdgn+OB
         kViajbiUci5va/JggfAyBpMMzLEdhQewMi9t4VOIjsXQ9MGR5ogjHON+mG1XulkDpH/c
         sLxlFWfSN/AVgxFmrdQ8PGd1fI2Twr5ZkM2TUGRoOCxPQcco8c0ACRkNrY6QJ3g/PWCL
         7IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdQJyJqpFN2fR/l7hckq15lT8jtEq5VWWhRVFYg0P/Q=;
        b=TJFmmBOOFciJOphfjhXi1En47VOnVYUs7AnAfBBW4Ib7rovlz4NmKPhHTWujs0xQpJ
         Je3ZwmqzAMFV5nZGgk3Y2WuUCEp/uhTG5azBtrWRSO7sY7vzUBKGVQ7s1qrUghNZmRUh
         5h7/4uI7+EA42ED0Oc7fCu0wEtMB4VxT+ntjklQgPonMPyHaXPaFCUa8KOQ1q1iLPAr1
         qGYnoNyGD8BjzhnKdyK29dgbTzyTLxHgkYn0SOwiQFgI/U3SyIRby2ifFW1fU+S5jybJ
         6QzS62DyB8bjqK+jZQbPIlH/ZMfO134Nqq26g4qt0KrBuCJHo3sg3X+auw7Mw21/M3Cg
         /Jng==
X-Gm-Message-State: AOAM531ZDFRN0KqddJNTG932r+Hnma+e16XdL03WaIZnH8yl6lt7/Xwa
        qV5ifu81s6fkM17yHKnfIQHQsXWIu00hWlQboF7XbrDv
X-Google-Smtp-Source: ABdhPJz9Qw7qNFKxCvVtDz2hMO36sMOnbDhn+m+5AzmrLYBLQIQtvvuzuzGeyVtp1DcClegCfqY6cIAzjAiynxbwMws=
X-Received: by 2002:a1c:a756:: with SMTP id q83mr1840353wme.168.1596166575610;
 Thu, 30 Jul 2020 20:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200731001652.GA28434@dcvr> <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
 <20200731032212.GA21797@dcvr>
In-Reply-To: <20200731032212.GA21797@dcvr>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jul 2020 21:35:58 -0600
Message-ID: <CAJCQCtR36ojCgmdUQbyLn_oNQKZn2cnN8FFV7iUWz+pKJaYTfg@mail.gmail.com>
Subject: Re: raid1 with several old drives and a big new one
To:     Eric Wong <e@80x24.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 9:22 PM Eric Wong <e@80x24.org> wrote:
>
> Chris Murphy <lists@colorremedies.com> wrote:

> > When one of the 2TB fails, there's some likelihood that it'll behave
> > like a partially failing device. Some reads and writes will succeed,
> > others won't. So you'll need to be prepared strategy wise what to do.
> > Ideal scenario is a new 4+TB drive, and use 'btrfs replace' to replace
> > the md concat device. Due to the large number of errors possible with
> > the 'btrfs replace' you might want to use -r option.
>
> If I went ahead with btrfs alone and am prepared to lose some
> (not "all") files; could part of the FS remain usable (and the
> rest restorable from slow backups) w/o involving LVM?
>
> I could make metadata (and maybe system chunks?) raid1c3 or even
> raid1c4 since they seem small and important enough with ancient
> HW in play.

Yes. I'm not sure whether it will mount rw,degraded if 2 devices are
missing though, it might insist on read-only.


-- 
Chris Murphy
