Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874606BA27
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGQK3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 06:29:14 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33159 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfGQK3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 06:29:14 -0400
Received: by mail-ot1-f46.google.com with SMTP id q20so24433114otl.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UeYfPuaTaNC0W6UJOJBqQZj52QqkaP6KqHo2qumQOr4=;
        b=cEs7pOuw6P3ZVgqdN6LWrwm9k+3fxFggQJYMya3Bj2QWxwYcsZ/kt/xCZ2RUKb8NnI
         nIRGK9GcngT3JszfexgbUpZYrNUhh6pX9u7/Pc5lp2oZZx0Wyh0q1y2AfA5fNJcPPjVO
         /ObmskTbK5Ls9KoGtDdGN/0k277on4IiiqxzoGtm66akcd/45HG+lGGT+A6dD/4NZDqO
         zQGJu3qhxHvlEN1pFLLXjhI6vfTnOCL0PRHS5hMwqZdOlDX/cKAjOdAnagm1TkBu0r12
         EFoxjuqThx2BD8GxbDtaSKAs3HVx/aGOuuTaLERBWiVN/+HGNNSkrgEv7b/AokQTMn+J
         UU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UeYfPuaTaNC0W6UJOJBqQZj52QqkaP6KqHo2qumQOr4=;
        b=gX3oDKwpdIOIWmmtlO/6PFaeFgSwzi+r6QdEZnDUJKyM/4u2GxKdkd0qOFBMt/MLqO
         rhhFUZd5yqsEV+haPuOQBt0jSxtey8nx1mwu8VcxGiyrXKKjByCKMo87qnGXjAf9fJs3
         Ep7UlXz7Eez8nweoMcLCdTqQCjmETl1m7EDNpiZdexpwSoj70H46BuLNR9DjFFeU7nPC
         PKBK4+ihf7iwWvSD7jLmuoU441U2br+lcEELNlDVBNGC7XJEV/jVoksMZoBBk1sNM4Gf
         jkLnK31m+GRo4XH7nTRHLOczmTmiYr5Spn8jSYxDE4uREo3h8JedcEy85OAweob5xJSg
         qOLw==
X-Gm-Message-State: APjAAAXWJt+znXwWWtWdkcKsqV+nul9X5UFsPJfLCqVBhWt4IPYtKOTC
        2+U527TMP/CLQ9C6wXh0lmEskuIWO9iQ4cYb/Vk=
X-Google-Smtp-Source: APXvYqxwtRD404ZgFb6q56LTjMHxmgK8JRx5uM9veZACKUb0iy5MWK7KQjpxujoAEB7JIHbuMO3RjNCAuzloI9mqjfA=
X-Received: by 2002:a9d:4b88:: with SMTP id k8mr8840685otf.285.1563359353698;
 Wed, 17 Jul 2019 03:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190716232456.GA26411@tik.uni-stuttgart.de> <eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
 <20190717091100.GC3462@tik.uni-stuttgart.de> <b2410ac6-34f9-f459-8301-c70fcbe6159e@suse.com>
In-Reply-To: <b2410ac6-34f9-f459-8301-c70fcbe6159e@suse.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 17 Jul 2019 13:29:00 +0300
Message-ID: <CAA91j0U1QBruk+JPE4+FZwuKNOz+YeiQOaeM58Viu6iSCYc99g@mail.gmail.com>
Subject: Re: how do I know a subvolume is a snapshot?
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 1:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 17.07.19 =D0=B3. 12:11 =D1=87., Ulli Horlacher wrote:
> > On Wed 2019-07-17 (11:24), Nikolay Borisov wrote:
> >>
> >>
> >> On 17.07.19 3. 2:24 G., Ulli Horlacher wrote:
> >>
> >>> I thought, I can recognize a snapshot when it has a Parent UUID, but =
this
> >>> is not true for snapshots of toplevel subvolumes:
> >>
> >> As you have asked this before - in my testing this is not true.
> >
> > It is true on all my SUSE and Ubuntu systems, for all versions.
>
> That's strange, as I've shown in the previous thread, using the latest
> master doesn't exhibit this behavior.

I doubt you are not aware that distributions rarely use latest master.

Actually I have here openSUSE Tumbleweed; root top level subvolume
does not have UUID but if I create new filesystem *now* it does. btrfs
tools have been updated since initial installation.

Better question would be - is it possible to fix it for existing
filesystems that had been created using old tools?
