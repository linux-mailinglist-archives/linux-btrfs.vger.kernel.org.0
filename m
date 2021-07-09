Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3813C2794
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGIQdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGIQdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 12:33:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AE1C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:30:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso6686186wmj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0GUrbhdoT09wQMCgusCyfWAUdwpxNN6CNsL8S4k9cD4=;
        b=Qs1LXJp2qwvgXYfJU8iPkI/c59W22sWzUoSyHaklwGlpzv1VEKMxE+9kHRXsypAy+Z
         YGtCKBG+ZyHLpXFMz7q82CISv0JOROP6AerC6fpibXbNuhj/hIPl4d2lFqgHHEe+49fa
         KOwyxuVdpc38GGvGPMnp85ZLgdf2/8FzX99+eLPSPgwfxbTukzE2X/IZfWbBh3+A2v0S
         /s3yJ1zrhu8ujbf+xs8mT8aTcl5+Nwikr5z0sNSFrTqsWwrSJRByPWj0dXVKn2zXrNyr
         wWn67LLWjIGMtDae2kPsh7IT+NjNae0lgEl3SeckIc2vtL2ObjgAdxFV7vmevRvA+l6m
         JFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0GUrbhdoT09wQMCgusCyfWAUdwpxNN6CNsL8S4k9cD4=;
        b=gBhOfLHLCkCxZjXoOIqp09cqz6U95ueOkU5cNmfi2HVFVKD3zu+L0W52DjINnS6obJ
         basVH+kbMAb4gvG9VRRMlPv9Za/h5KfZR1AVA0DxxSjAyZdCzz3ohmQdGd7cntkZVv5/
         dNdC2MqX3g/tk2VG4zkkcLVOjZgf5BIUKyIbI1mYbaPe3bfCEtRtoG8UxeVwyzhh92Kv
         jpGSYT0WUIrgRdwRQIILEfWeztS0kgwuAhLL6tNz9cjr3s07VsSP0Px37hESQpq8lwKT
         teNACw/BjXT+3i+2hImVaLyOppX3flnd3r6oetsEHBX7kANQHO8zxhGb1OifYid9/ayN
         nYeQ==
X-Gm-Message-State: AOAM532/A4AJfJUuI374gBG43fSLmm2cQuydMVOmmaPVUw/stc81eTc1
        /UuuUdXX27+NxeapBG18PBjSnQQkY8GmuOjAtS8wdPpRP+dF4RRA8YQ=
X-Google-Smtp-Source: ABdhPJyOoo1q7EMdFv2m/3xnlaJ4cACBtFi+xPgAFBHBoTzUfP/6fXDEZ5zSyGgt3sWzbrQRyKE6qKDpZr8tniZPBxk=
X-Received: by 2002:a7b:c949:: with SMTP id i9mr23711164wml.168.1625848253008;
 Fri, 09 Jul 2021 09:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de> <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de> <475ccf1.ca37f515.17a8a262a72@tnonline.net>
 <20210709073444.GA582@tik.uni-stuttgart.de>
In-Reply-To: <20210709073444.GA582@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 9 Jul 2021 10:30:36 -0600
Message-ID: <CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
Subject: Re: cannot use btrfs for nfs server
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 9, 2021 at 1:34 AM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> root@tsmsrvj:/# du -s /nfs/localhost/fex
> du: WARNING: Circular directory structure.
> This almost certainly means that you have a corrupted file system.
> NOTIFY YOUR SYSTEM MANAGER.
> The following directory is part of the cycle:
>   /nfs/localhost/fex/spool

What do you get for:

btrfs subvolume list -to /nfs/localhost/fex


-- 
Chris Murphy
