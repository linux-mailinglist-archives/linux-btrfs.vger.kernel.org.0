Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F1326AF7
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 02:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhB0BNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 20:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0BNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 20:13:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D7C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 17:13:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so10251755wrh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 17:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2ePmTvVAfm2lPKfuzf7N/fmP7MT/Fk3Lg6t5SNj3lw=;
        b=OV3aaGGgIIyq9M0S2WK5+NkdxNtJu6klJgkQQS4C0D9IXHQdTPg9hHul4MCaJ1RNAe
         zs/dJucUvDzqiSnw0MzCjTZmRR6vHnn7Gu7l6WkkTFhVUwLpOtr4LaPQtCHzwWb+UrjO
         jxisB95/1elP+yjdu6REtN9+O5QSTR1IbzWvdeGFCoxz3rYM8tj1OdGRjBqjcqs0MvAx
         klfBzyUcnuO8kdi+GWKCkLX9O1hZUg0b1+ZvbQAudlpQviu50tzs2vwfTr4npVZ1H04Q
         zipcw7QKnbLcT7fqtthaxrsdZQBN7H4MH/DZ21bOeVxq3J7wcVIoBLylAz/PFqi3pjZH
         87tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2ePmTvVAfm2lPKfuzf7N/fmP7MT/Fk3Lg6t5SNj3lw=;
        b=M6ZBfoudsKFePziNKMfW5T5xNH33KqcuHab/F7HNlRRu5f9/zQPlGKfA/rOsM3iQbp
         /7/Y+vWSdpjLh3jXxwtZ1he/BdjkwbeXT5iX6z04Uak7aOhIX+mk8ohGQ2lIWHwZ6R/W
         r0laWIi5LxjksiKaJ1d5/9jrBNzy5skD5lX7MKu4rk4NFiE2NhT4GCaPtv0XBP1yZohJ
         MP6d+i2Vqwbh/kZiZS4mK+WmJVcEH9zI7C9W5OZ5uMjqLOtBQP/WH4o6Z2Wz2zzyw07X
         yukptMXduZZpcvaNsJ1ScA/Z8fdgLWObHyTUfjDfMkGsmJnGKlBimRT7yu5hW7Nr5jpn
         y7Ug==
X-Gm-Message-State: AOAM531wDABXJHMWOUWSYOWY1UhtJkhSFf4DGq4ovgm29yff8E8r6eeG
        HnzJpzHDiuyNUJize7e2Xao53mMj1ilph4O2MpO8Ng==
X-Google-Smtp-Source: ABdhPJzVYFVblJ+zq5+PLKZn+6cSl///LO6WpNNeE8PU/N9/cNnSCRYfmrbAzgkyyNa4lPoF5aDgfWfcS/Jr46ElU2w=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr2070342wrx.236.1614388390625;
 Fri, 26 Feb 2021 17:13:10 -0800 (PST)
MIME-Version: 1.0
References: <tuq0pxpx.fsf@damenly.su>
In-Reply-To: <tuq0pxpx.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Feb 2021 18:12:54 -0700
Message-ID: <CAJCQCtSRLhOmjbz6nQnwvWruUPdcZXbJzFMXk8yXZ8A5tguxLQ@mail.gmail.com>
Subject: Re: [report] lockdep warning when mounting seed device
To:     Su Yue <l@damenly.su>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 24, 2021 at 9:40 PM Su Yue <l@damenly.su> wrote:
>
>
> While playing with seed device(misc/next and v5.11), lockdep
> complains the following:
>
> To reproduce:
>
> dev1=/dev/sdb1
> dev2=/dev/sdb2
>
> umount /mnt
>
> mkfs.btrfs -f $dev1
>
> btrfstune -S 1 $dev1

No mount or copying data to the file system after mkfs and before
setting the seed flag? I wonder if that's related to the splat, even
though it shouldn't happen.



-- 
Chris Murphy
