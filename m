Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2B2D2F58
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgLHQWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLHQWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:22:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D96C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:21:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 91so12893843wrj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUswIW/XHF11HUoNNSWMLmxFMhh004MVjVa87d4wQKM=;
        b=KfkCl5vc4RPYxMG4GQgaKV1rVGIUH/S4/pmu46/SPhEiRlJsj6Z+eguqzVqZ0YxuxZ
         xa5aVgESfkylxRv4CBgJDxcYA9uW4ObJKUojfWx89IqfQGC7PDX48yFrleFQGwCgNm5r
         w5dPykHct3wacxZnBNMOhWtSpzQFYV19OUNclHJXt0RBjONUHk83bGsVjQSJm6ea9ip6
         spg+/e100CXkX6VAMoFMmTYmCmvLkZpc/b2bVasdgQX4IYx+lr+kbXdbo83oo+Eqs5X7
         Cf2Hr7XIJGmYwsCnrfMScri3Vv4W7CsTZBtIY/ef/zbBtmi0QD9ZGdWGRA+3XYaDRR3q
         4UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUswIW/XHF11HUoNNSWMLmxFMhh004MVjVa87d4wQKM=;
        b=FGe2mxJAxSqg9Gd2R4b+tQbQY+gujcSw/s1kzuNHuxSY+djXN/25zg/UgX/ss5DvlX
         ZUr5r4sA7WpYXGCet/8BCIB8zn3k1p+OQLni9dm4w3fbvpUWmCpgpOg+cr4cxpp60cO3
         iBIg+V5MNn8l3+T15oCeKhfT3hSfxuJixjS7vXPzi4D802xJAIl4v6a4uTmigGi9TDGc
         aRXUyZViCX6rCuSzfKlxqprOOHn+FcWV4rR4HCu1whCI6uzRVgmHLkxfSLs/4wvq7NYs
         A6QvBHmkf6CwWp9bYtdQTyCEajYa124ZFZLJMI5R9eGfhjNqPOKqQCgEdxgpf3wnWy48
         vcIg==
X-Gm-Message-State: AOAM530i23+RV80ei2x7YJg+otLQz/+3s/4xJEbn85hTVirZCaHpIt5t
        jGU2/ByLfiQ7fVl90QkJnpvcGi3scEwoE4bExtj1YPKlNY4WJjow
X-Google-Smtp-Source: ABdhPJw8wFviAvBmp6/XLw08AXhhcH98ziGOtwpk6U2bx/+W4DEjWgogjAq9pyyV1680mKDhf8ioxG9qOubUK9lK8sI=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr2216112wra.252.1607444491585;
 Tue, 08 Dec 2020 08:21:31 -0800 (PST)
MIME-Version: 1.0
References: <7ffdf22e-352c-70e3-eb7c-86c591febe7c@panasas.com>
In-Reply-To: <7ffdf22e-352c-70e3-eb7c-86c591febe7c@panasas.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 8 Dec 2020 09:21:15 -0700
Message-ID: <CAJCQCtTjFwtJassQoN9UY9o=+dz70jJb30uW7JMDKmJpgfgAOg@mail.gmail.com>
Subject: Re: Assertion in tree-log.c
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 10:57 AM Ellis H. Wilson III <ellisw@panasas.com> wrote:
>
> Hi all,
>
> We've hit this assertion a few times, and I wanted to know if it was a
> known issue:
>
> Dec 05 08:53:52 6afa1e4331fa46 kernel: CPU: 2 PID: 6897 Comm: iopathv4
> Tainted: G           O     4.12.14-lp150.11-default #1 openSUSE Leap
> 15.0 (unreleased)

This is quite an old kernel and no longer maintained by the stable
team, so it's entirely up to the distro to maintain it. My guess is
that 15.0 isn't maintained at all, and you should be on 15.1 or 15.2
kernels.
https://en.opensuse.org/Lifetime


-- 
Chris Murphy
