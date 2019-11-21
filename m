Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01304105C0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 22:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUVfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 16:35:20 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40108 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 16:35:20 -0500
Received: by mail-ed1-f42.google.com with SMTP id p59so4143703edp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dw0fy99yCuayDeDSjRfWDE9xzdzThNtcRm3L78QqAvo=;
        b=T5P2Xr+VuHqFI2A40FyxSx/te8uIWloRA2L6JvfVwU5Zpi0s+STKzwNi0JH3ufUaaT
         4F2Gd8THNOGQMlNyr4SQg6UHmWBtHwWQcgvd/GjpNJoWyECu3+0m9U5LseOTnZnswuyp
         SNcqEWdaplWQ14vI71DEW3exPg1M2ruSP17Pp9Mpgb6qdKPxqzeXkteyp50SaRUEsXIO
         +pMDBHnDtI1rRT+bREnKIEHOeFMsShq/lFiJWS0dgCUPx/W+rrHcwGqDtv/hxCaG+K3W
         3Rk6vCMMKkV8xr0WlD3opwzbkSZp5qDvN8SGgdYoikrGKDemAjh6tmjSsmSP5tk+l0sO
         jJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dw0fy99yCuayDeDSjRfWDE9xzdzThNtcRm3L78QqAvo=;
        b=m8qet3W8Y0ea2F/YbBVEQLdptVKGbhHUKkxQV/OWT/z68Mzw61aW3xo+N6EkGDLL31
         hJ9B8qK3QpZ19OvBaJWu8bCQvFz8I38vVuy5itx7DtwT27ti65NWvWw7UpPwsgmsVQzs
         Y54XkKyvXiK/DoX1qODbXi6FeHEKKHlFT84H8WCX1cR5RImIWlMJxmHDLbSe2fyozQNT
         QxtpGk1okNVWFLB9K5wTO8azxfuaEyjlWLzor+pg3Sb9eYaaVL8En2H1Dc48WVcDMgBb
         virrST7hOwJEocflGPKhjL7oXDzY5uREE2rshbO6/AnOxzBIehaMZSoscbTEtFU+ivRj
         FdoA==
X-Gm-Message-State: APjAAAXpfuRh4nxGxUY4qvGovLS7zVePud3PDKWcM3OS0OXJD6bCt4y6
        dmmQhb382kaZQxGFtD9aItI7iOTLDADcf9ZZpplzuR8=
X-Google-Smtp-Source: APXvYqwxxIqKaCFA0uGWyxxBA/VgaTZbwFKCc7xYYKg6sKl3Nabc/kzNlePGa2cdyyHlhQvR8A7DBZQ15JVzMQea5us=
X-Received: by 2002:a17:906:b6c3:: with SMTP id ec3mr17062379ejb.27.1574372117234;
 Thu, 21 Nov 2019 13:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com> <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
In-Reply-To: <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Thu, 21 Nov 2019 22:34:41 +0100
Message-ID: <CAKbQEqFX8_oU=+KtDsXz-WeEUytgcXr-J-pw+jEmC3dwDAfJMQ@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Another interesting test could be to adjust btrbk configuration to:
> > btrfs_commit_delete = each
>
> Will do.

Hm. No freeze, this time (with btrbk set to commit after each delete).

In other news,
- I seem to be leaking cgroups. There are currently 191 subvolumes
(most of which are ro snapshots), but 547 "0/*" qgroups. Should
deleting a subvolume take care of removing its (auto-created) cgroup,
or does that always have to be done manually (or by setting the
experimental *_qgroup_destroy options in btrbk.conf)? Any elegant ways
to remove orphaned cqroups?
- Timeshift, at :00, triggers this as well, it's just less severe
(maybe because that's 1 subvolume instead of 3).

Cheers,
C.
