Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB713FA0F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhH0VGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 17:06:00 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40958 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhH0VGA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 17:06:00 -0400
Received: by mail-lf1-f41.google.com with SMTP id bq28so16978002lfb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 14:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgD4fqAdnshcxaC9mn1KETaCwPWEtTOkFnSbrJYFHqA=;
        b=DaBgNpgpO7PTPVPHyloLGc/JBuszC3890mkaaTI+TwqzRRATd1W974/LXmCp0OvPB2
         MZHDFripToqigkAtEDVxDgQcEfKrB/6KK0WZ5LVOq1BlhouDoEHZ8BSqlvqmjQTiL13C
         EDBzc4HuMj2EJn5dVFZnW3tnuV1UL8ncmRYkpSHTUlioontSqffV+OGQkXa+YHBw53Og
         eYn+jPnl5tg6yKlFLNX98j2jJijJCwvSFaz9O8bxZNbPeBzwbqEwUNSgdGiICpdeQPHS
         Bn0s/NULz7Wjg5OAxv/QwMuNJGv+EpwbpJb3taSGRRlkgEMLeV/GXCOTjNKDAK2Ic1ZT
         56VA==
X-Gm-Message-State: AOAM531rDOfigt/WZbNTdkXwHH9SERVUzwXdJ59wX+dYTuam2UKt2qdf
        OFTij0qPlt2gcC9p0h0IBYBmfxVAJsBEzZmQiRUmlHSTeRk=
X-Google-Smtp-Source: ABdhPJz9dISoWX3yaELlSCI31VssZI3jGiQXLntgrqe/xVt9zY9HR6kuizDliFIbrG6nMve+Bp1ivsPMlnQgVELlGXs=
X-Received: by 2002:a05:6512:3f90:: with SMTP id x16mr8136191lfa.518.1630098310068;
 Fri, 27 Aug 2021 14:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com> <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
In-Reply-To: <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Fri, 27 Aug 2021 14:04:59 -0700
Message-ID: <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inode number of places.sqlite is 400698. It's the same in both
snapshots, as well as the current active subvolume.

From 2nd snapshot (id 977):
  Size: 83886080      Blocks: 163840     IO Block: 4096   regular file
Device: 5fh/95d    Inode: 400698      Links: 1
Access: (0640/-rw-r-----)  Uid: ( 1000/   denns)   Gid: ( 1000/   denns)
Access: 2021-08-27 09:59:01.619570401 -0700
Modify: 2021-08-27 10:06:43.952629419 -0700
Change: 2021-08-27 10:06:43.952629419 -0700
 Birth: 2021-08-07 20:16:37.080012116 -0700
