Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A39A5FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 05:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbfHWDTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 23:19:34 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34798 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389784AbfHWDTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 23:19:34 -0400
Received: by mail-wm1-f43.google.com with SMTP id e8so8345904wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D992NZ0tLByY64on1hDKOGZG0W9ccxcJYcMCXGk+Bgg=;
        b=fT99iX3+3sff55Rv1S/VLsZH5HkrTziZAjw4vEyk9F6jdyBnZlvmzQYkY1wxLT3Xbs
         m5TQaBtkHjzk+KN6Ytw6FQPB1aMrDCRfrIH1v4kEbMEZHtKKn1uARxGb+xcrWW2l1+Hl
         Ck4FgQ0CVEHhk0nwXPnwfl80VH2eUf9T7/cXZXfO/wIEXooreBRfgrMBbFLLdwRPNI7W
         s8T+FQ3ut9XxwpVMzZ0c1nDVn2AqWeJE0kcWegVX/47ARuTmRYW4YqXvNzk8K8NMLM28
         WmUJlUs8oq+Z2XndmE6yAJBZOw0TMjQmeU1WI50Yy+cIBf63Uzspe+bi9jcWseJ5t6ad
         +VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D992NZ0tLByY64on1hDKOGZG0W9ccxcJYcMCXGk+Bgg=;
        b=MqBn0u9i+qDXT8PvQI+m608FxS+/IKaFWUo5ruckZIhHW45dGvFSjwUc2gD3XkSFQt
         i4I6uknQ5zCnUU2fW/P32yLAMhZSrU66kW3qpdnLCC4+foZRB/91eRHaUfFUMcwZucxG
         GzrzRz/URy+xHBbsDEiLDzl/eAXZyfm5uJ4F5dm2v0n7QEYx91J8rt92OILUjCAH5WLO
         3ZZLzYrlrMWz9q+wMyZKXdf+xnqefCOKLmRGwN+l6tC6o0kInZ0+iE6xHSMpJtMBybBF
         iMDB5afNGHw5FRRuBBuTS68vc4tNBhfw1O6unarykXHyUvrryQ/N2ptaQHTiPe2krl5Q
         UCig==
X-Gm-Message-State: APjAAAW7gn6aoAXTH+OSsloogSnz7WNWdbfQjCPICSEi9NIxLJcuqJUm
        5ZNCIjMlRWduOby8VNnXbu46ySorvBoz44u9VpA9QaBt220=
X-Google-Smtp-Source: APXvYqwNCfOLyHFXC8x5Z+z2we1ULDrxd/JqjWtlqDfgmNqICBcvVn857Cu8BW+QiZqNRGjTuqF59+nEYGjeVc7+uX0=
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr2261320wmg.8.1566530373144;
 Thu, 22 Aug 2019 20:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
In-Reply-To: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 22 Aug 2019 21:19:22 -0600
Message-ID: <CAJCQCtQZ-BH3vHaV6canyi+HA_Q2Ny_QryKFLtddyR7YME4dzQ@mail.gmail.com>
Subject: Re: shared extents, but no snapshots or reflinks
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 8:38 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> There have previously been snapshots, typically prior to doing system
> updates. Is this an example of extents being pinned due to snapshots,
> and then extents updated and are now "stuck"? I'm kinda surprised, in
> that I'd expect most programs, especially RPM, are writing out new
> files entirely, then deleting obsolete files, then renaming. But...
> this suggests something is doing partial overwrites of file extents
> rather than replacements.

It's databases. Databases are updating their files with block
overwrites, btrfs COWs them. And if there's a snapshot that exists
while COW happens, partial extents get pinned. This affects the
firefox database files, and also RPM's. It's a small effect on my
system, but it's a curious issue in particular if the files were much
larger.


-- 
Chris Murphy
