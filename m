Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5E10742D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVOoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 09:44:00 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40915 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVOoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 09:44:00 -0500
Received: by mail-ed1-f41.google.com with SMTP id p59so6238891edp.7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Nov 2019 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MFUry/79CLSxAwaJHLtMD8jgUHc2YMLyPX+cvpRGafs=;
        b=ggNBy5o0pXJ5VHlxNUakZOJxKNiqvmM7rWZGE+2SuIkg1G+OIwsrDT/2nMlgO/hjZm
         Ro507GYtt0Z8ORrQbTvBxkfZSvTsK3g9pqRNdsVJqazTJJdOAsLAyzoFuqbD+teubzlZ
         k9yHRjMnDf8i9e2PENlRc8/07XBHZnQA1cC/0zMJPLEqZkeYTj6kgZYwxJQw5B8/xJy4
         qUEY+JMsvzJkjK43MshOSJK3Dl/FyO9NPKk2SONQkjuqHb17ZfKTGQ+r1iDRE/tgi16v
         1I/XFFfiuXtvig/i4PPMgE9dwFkTaqsoIfvXq72yMn8weXw6CgoW/3aNN5cn4ZKmRJXX
         2Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MFUry/79CLSxAwaJHLtMD8jgUHc2YMLyPX+cvpRGafs=;
        b=sK4RYFFRH/gE2EssTkoMZEbE3GbedhG+8af7RClGgQXxktOh2PROVW9UDQmwd+qLlf
         H3Az1k6iIEtTHvcP38z1imtUTKdavDrZhLJetZaju9BiQb4FKFVnJ7o8CIgfJYCt5rEx
         upGu2VOaYCtqjZd+j/0AaeYxe7ljXh3AYkNVqOHSenj6m7rWNVEZf4BqrS2M4w33oaXo
         WMf/9Zugzg4qMW2IphUH3SH4UuTjbLNDVAMcBzL4nLI298Vxd54xTB9sebRjPCUmucO+
         RcYLhdtBAwtkGDn2AItQ849O9wgXsxb3xQZ+rurvwq2/NBTZoJUzr8+FyNwHkxsM4gId
         O4rg==
X-Gm-Message-State: APjAAAW/Iq+LN/cOZoYd+k7smeBo5yFncEOajBCQozUU4UyR6pRV9S/L
        bLgloc8wx/bfBr4dX1mTQ6laWE7kj1Ne99LNlOUn
X-Google-Smtp-Source: APXvYqyg33Un0xyPms9Ox+jYJ8DOov00gvWH9S/ZVNZ75BAaAz8eK1j/3B7ADg+QNGM7bwT/7npRQT/TrJ/juOoLktU=
X-Received: by 2002:a05:6402:547:: with SMTP id i7mr1558585edx.55.1574433837812;
 Fri, 22 Nov 2019 06:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com> <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com> <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
 <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com>
In-Reply-To: <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Fri, 22 Nov 2019 15:43:21 +0100
Message-ID: <CAKbQEqG362x12PyDUjiz96kGn15xZY_PRdAknS60kKvDDkKktw@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 22. Nov. 2019 um 13:34 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> But still, for snapshot deletion part, there is still a performance impact.

Ok. It's just that I'd have expected *slower* write and read
performance until everything's settled, maybe sync writes taking
noticeably longer than usual, not that all user input blocks across
the whole system regardless of fs activity.

Cheers,
C.
