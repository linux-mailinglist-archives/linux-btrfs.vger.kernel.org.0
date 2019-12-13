Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB67B11EB78
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 21:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfLMUEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 15:04:07 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52155 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfLMUEH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 15:04:07 -0500
Received: by mail-wm1-f45.google.com with SMTP id d73so53392wmd.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nucXZ9wtUoQSpv2vTysAgY4Szpt3AifXWuNpk7rcmj0=;
        b=rlEsuiGHjMNeX/IyGf8lIZAMq1/pAM3/lub3gb25jWpgP//TM15MuS1m90qd6Q3Oxn
         Bwn5Jo9wL49i+GLnEcN+txkCN3Rik8bAbdnXTDpN7STyK+jHKJ0HJwulqysNcXt2VKXD
         62J7BX+9M88znIHRK+QpauaMOHEjX7oF+IMVGMJiPZZAWH51XKIub3GR57bS0eV14N/U
         0WdkwptjNsltTvHylWN4OW78tYjO5VTWIxHYTBmhKBP7QL9dtrBcrZNRC6Gn33/gOpam
         TwFyTQ+vE4oxCa8Us60olpDGHm6MCfS5Pwel8dTcNxsk1xtiyJT7vfAFdx560XCFzjLF
         hGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nucXZ9wtUoQSpv2vTysAgY4Szpt3AifXWuNpk7rcmj0=;
        b=UteDn3cdJ76oh8aUEqd1fHG6vWdqhP3ld0PGuFge80MHnVlerqGrzWvknJEy2T3Sdq
         8WA6IDRELJdwOjNYBQnfirJ1EGLgF9yN0H2zTth6h/J4zEbjqrlVoWZqtfwq2YEaU9VL
         fixhZbyXCLJOGQTjN63BwChZgcAxZR+GIfsp+WMqdx348UzZhauRwtaY80zZJbWXVD7T
         s2vTXbaXeaOt5maJCGV+eXOL1jkSiNO6tn8QviQbvB8L1mZqXa0lleCgZCgMJ0eJje8m
         mmI9MQD0ouDVPMuxqk6nM60wJzJ9/JKcUARTcBJ68fSQMZAK6BVUiGLI767IxI2qkf/a
         n6Fw==
X-Gm-Message-State: APjAAAVodi0LqbGpnIQkFE8Q5UNDTJ7/tDRV5pAaeTVtx4OrJu8SCvGR
        uyUoLrJXyeh9Pc9tew86a7hCmFY901uFpTg1d9CEjmoOQb0=
X-Google-Smtp-Source: APXvYqxLel0P1fxVNqIUPFjBV+YQE5Lpzz3y/LD9VrGqf1ycJdaSqYB21C9p7HUnuxIhOyxVvQ1Lxz9yfpQ8+LwoGWU=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr15596834wmh.164.1576267445111;
 Fri, 13 Dec 2019 12:04:05 -0800 (PST)
MIME-Version: 1.0
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 13 Dec 2019 13:03:49 -0700
Message-ID: <CAJCQCtQEu_+nL_HByAWK2zKfg2Zhpm3Ezto+sA12wwV0iq8Ghg@mail.gmail.com>
Subject: Re: df shows no available space in 5.4.1
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:26 PM Martin Raiber <martin@urbackup.org> wrote:
>
> /dev/loop0 on /media/backup type btrfs
> (rw,noatime,nossd,discard,space_cache=v2,enospc_debug,skip_balance,commit=86400,subvolid=5,subvol=/)

I missed the 24 hour commit time. I don't know that it's at all
related to the problem, but I don't think you're gaining anything that
can't be achieved with a 1 minute or even 5 minute interval. Has
testing demonstrated the 30 second default is causing some kind of
problem with this workload?


-- 
Chris Murphy
