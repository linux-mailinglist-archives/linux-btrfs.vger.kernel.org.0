Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A763709A7
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEBCJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 22:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBCJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 22:09:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DBC06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 May 2021 19:08:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so3808454pjh.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 May 2021 19:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgDmRUDZrzW94TzulV+h1PS30m4qFNZ9N0OywnH7U8Q=;
        b=f7SyIXN/WuYuu6zFsXho1IBvGclDpFBcciAcz/oaz567ArZSQf0K9x0XlzenGFLf82
         UhmekxQfeLap6ODh2BUhIZeHL3Rv9hkCmKmoZkzmZNHRE9JdaH6Ga9kgzsAlY66a2n8v
         E4Zoa0UkPbHr6gLE/H6YQEX/TtOdl+KY/uVA/21uaJdWAnWFu2a7wlXonR5otrMngdpU
         /3xEOYdROQbXUVjpbccWWEsDs+r0EMuFYFU8qKi2yfXBKAAWWi4DS6fsR692d8W8dOXL
         +/uRtDB/wmKFfDr3KQDvsvXX1uRoI0eciNXlJ2QZftPlqpkq1FhHJvcu9UrMBGf8mSS2
         mjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgDmRUDZrzW94TzulV+h1PS30m4qFNZ9N0OywnH7U8Q=;
        b=ZbHuZeH7f9aAwVZ8HDCPRIPFFQepVYHvVwJYIwx9q8Gp2h6V/ru1ZiuTd4vwyoXM8F
         h/neUiOyXfXTcgb/RNUbsaqt8+7d08yZVhAkmgnkb00m0apzxq3gMRVGl0XrK+Oc6hpw
         2sRa0yJaS5DgOBXm5Oix31idcPLW20ngjpf+5VTT/zdemKbCrDF11tNL/wGDZKreWFzu
         iJIo83CWdoZgbkd81wwi0DYUn7ulsW5PFrHOYGPhPf7WLeqEjkZtMvC0Y8oUivEnSFPB
         /e0b7VjPcww+SlFSYeYLxmZWzBl3sY7xs7MJGNjw8kk6r0U2h/X6uB/KRuSHYNTK8e5Z
         IBfQ==
X-Gm-Message-State: AOAM532Hl4yFEvWpc4L86p1/SE1hZE9u6CrVMyPNUbAUzC503GK5OUFm
        fYZt1vW1GogSi9se59D4pCjLD5RgJZ+FghypoSbSfd+aQ1Y=
X-Google-Smtp-Source: ABdhPJwRmnsBTnBjpVJBHOuf+DhBCmjgyxXsE+77lQECHoISCFsmGfd1+kJRWRdUiNpf/SZ+i+9Qlme/gbkAbDF7zds=
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr13803139pjb.228.1619921324811;
 Sat, 01 May 2021 19:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
 <63953997-7b50-0daa-4a16-d78309136b81@gmx.com>
In-Reply-To: <63953997-7b50-0daa-4a16-d78309136b81@gmx.com>
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Sat, 1 May 2021 19:08:34 -0700
Message-ID: <CALc-jWwuTDO9LdX6Rgu28pkmnVWbgHFuRDZb+16_Ebs--2h=CQ@mail.gmail.com>
Subject: Re: "btrfs replace" ERROR: checking status of targetdev
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 1, 2021 at 5:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> It looks like a bug in btrfs-progs.
>
> Fixed in v5.11 btrfs-progs.
>
> Would you please try to use v5.11 btrfs-progs to see if it solves your
> problem.

Indeed. This is fixed in 5.11. Thanks!

-- 
Yan
