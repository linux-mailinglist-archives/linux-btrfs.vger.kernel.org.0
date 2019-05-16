Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34121020
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 23:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfEPVjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 17:39:21 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40994 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEPVjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 17:39:21 -0400
Received: by mail-lf1-f46.google.com with SMTP id d8so3770639lfb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9vrZnSp0S/TSaXi62se9wEjsKFSJekv14/1CaCcnBI=;
        b=tf5hLVSS3M86YeRb6lcfwTbY34iJw9Br8pcO8Nl053NB2qRRNHA9Z4Lt6XKJjZSxJG
         SJdTa5fwFzE5lKK3KFR4sXm0yjQz9ey6MJsk88rmGFcAXbcZL2HkrpqhiNb5JZhwwED9
         8byxVhDDobrkJKIsJIsPRJnUwu6lIrJnEDhZ9iQq8Gtlf07kaONRZz05cCy5uMmrs9vm
         oRAsbHvk9xaeBS7HoEJ2a2UlLcLRFIuvmBJByaKupnBbomk/RLu+H3ZjJZI0Ye3h/ILq
         wNbdwSIgEoLX9nia/5ElMqNn+2yFwRzVadDpgdd1x6/DA6DGSCK71AUiVGlgud2D1VJD
         lvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9vrZnSp0S/TSaXi62se9wEjsKFSJekv14/1CaCcnBI=;
        b=rurcVpUgoNCgYT6TyAN47JSC1nfkbT0xyLL20ZpsAcDukrnv51lLq5Ef+sMJWcB1lS
         T/XqcF4w7XS+3JyieEjqhdgF6QBT2H8s+qk5SAD7yTTP6OLIoasWVfMYgDF7/NKloIKI
         goQeg8wDcdRgqq2MJZyH83YEhNDk2oo7EpBQ86CEBJjRgi68Used+x4/vd+9NGxmdwl+
         SqzJ3lDVPqOYbuylF0wpDgoV+xI1NLBbuE+XCv2iMXHQP1y+wJGzKnRQZFUWxDB7ohyD
         rqCpL20UB1i/rnWlWlIlYE5JQBpgRzCSjZR41tN47TB+1ujI2GTP0MRs5qWVVfvz8b6i
         UUog==
X-Gm-Message-State: APjAAAW5I9llErfVafqddeegHupXFrRKoalivMZgF0blNtRoSlCozjHo
        bc22XCD5yyJqj2nmbKP0hBXJ/9a80D2c/1WI1czuRI9cEHk=
X-Google-Smtp-Source: APXvYqySqkK+ZbX3SpQLV+8RlWZCP1jIw125HVrSRXHkaVrO+Vf/0D0AZAqDW5IOmsKW4s2CGTMBuEK7Aod2qfIcdwk=
X-Received: by 2002:ac2:4571:: with SMTP id k17mr26416755lfm.133.1558042759886;
 Thu, 16 May 2019 14:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
In-Reply-To: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 16 May 2019 15:39:08 -0600
Message-ID: <CAJCQCtTmZY-UHeNYp=waTV8TWiAKXr8bJq13DQ7KQg=syvQ=tg@mail.gmail.com>
Subject: Re: Unbootable root btrfs
To:     Lee Fleming <leeflemingster@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 4:37 AM Lee Fleming <leeflemingster@gmail.com> wrote:

> And a btrfs check gives the following:
>
>     % btrfs check --repair /dev/mapper/vg-root

Why use repair? From the man page

Warning
           Do not use --repair unless you are advised to do so by a developer
           or an experienced user


>     [ 17.429845] BTRFS error (device dm-1): failed to read block groups: -5
>     [ 17.450035] BTRFS error (device dm-1): open_ctree failed

Was there a crash or powerfailure during write before the problem
started? What precipitated the problem?

It might be possible to successfully mount with '-o ro,nologreplay,degraded'

If that works, I'd take the opportunity to refresh backups. I'm not
sure if this can be repaired but also not sure what the problem is.

If it doesn't work, then the next step until a developer has an
opinion on it, is 'btrfs restore' which is a way to scrape data out of
an unmountable file system. It's better than nothing if the data is
important, but ideal if at least ro mount can work.

-- 
Chris Murphy
