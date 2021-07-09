Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1B3C27A1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhGIQiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhGIQiS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 12:38:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE33C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:35:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso6694032wmj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gmThjR2VrAVEiCyTdHlWDJELIqp4WPuyr2PKYWpEbRs=;
        b=jPu1Sm8r/yT1Eyg14CrEXgBqOOi01zHMSrEFBL7Z3OPyJFU5GJ0yiPKkmrHjjGNpgB
         z3EO4r/S8QKtIZFAISm0Fir3obaUi/MOw5OoUbK7QtJIcnqME2MPN394nAyudWdGOrN+
         L25//YDCKzWn2pl975/Q0fj0T49DP/lc2FJazlznIPns1qU8kFZ+nOEc2L5mpH5qash2
         z1oggO53K5FgUSww9vO0tgN8U+PA0Bv1Y3eDR7ELgyRGhHtLlasnzNziziAtpWwsJFFL
         KaDXIRWPit6MqdWKevMDGPZJ0GkXNQe5sWWoegoQAcORotBzA40ahxCKJlmDnBA7eGc6
         lAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gmThjR2VrAVEiCyTdHlWDJELIqp4WPuyr2PKYWpEbRs=;
        b=JWy0WPjxUlPs7+CBDd+eE5W6zqbcZz4mipGcpmsAJSg6kcziRp1Jk916m1lcwlRFWQ
         E6dHQp1RmCklmEPT5z0JFiKKgTreSebJZyYNC5RRxeJtaPyfpRjVFTB6cGyuZ2/lEXGE
         7dZLTAd8aQA+2OHI4VAum5u9VWOCJZDNBJSGBcbqje+7KU2ecssjvBHikMMBgIYmJK8y
         fnnvi6N59Id+6oqYTlEpt92gLaqsGYqJhakr2VPAElESDDIJgM2B8HVQ+rSaNPgAN7FM
         p0CsSjas07bXHgAXmgmlYS6fSZ0Ty2wXhOZHI2ESf63oVsJvOKWcoYrGq7zsTzhJjToK
         e4mA==
X-Gm-Message-State: AOAM5329vScMDmEtWX6v0qtZlYOmwxIqmlXDkW7SpMAzkcqssonxCxmU
        tVbQsILckWogYXtQ4Y+NDGdC5Mmx7lZ1zOqc5oXFTLG7ub5Sa+l2fmg=
X-Google-Smtp-Source: ABdhPJwjmQyWed3pl6eKHgeBXz5VH0Kd6aLH0k/YGQtpwfMflV4cUwgRStVcX+yb3dk8BEkj6fpg+fQpc5zV87IoVDU=
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr40189338wmp.11.1625848533153;
 Fri, 09 Jul 2021 09:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de> <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
In-Reply-To: <20210709065320.GC8249@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 9 Jul 2021 10:35:17 -0600
Message-ID: <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
Subject: Re: cannot use btrfs for nfs server
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 9, 2021 at 12:53 AM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> On Fri 2021-07-09 (01:05), Graham Cobb wrote:

> > You can eliminate the problems by exporting and mounting single
> > subvolumes only
>
> This is not possible at our site, we use rotating snapshots created by a
> cronjob.

These two things sound orthogonal to me. You can have a:

<FS_TREE>/fex which is mounted via fstab using -o subvol=fex /nfs/localhost/fex

And you can separately snapshot fex from the top-level, mounted
anywhere you want, but I kinda like putting such things in /run/
because then they're not in the way for more routine/interactive
locations like /media or /mnt.

But I don't really understand your workflow, or what the fstab or
subvolume setup looks like. Are you able to share the cron job script,
the fstab, and the full subvolume listing? btrfs subvolume list -ta
/nfs/localhost/fex ?




-- 
Chris Murphy
