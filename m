Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B143A1625CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgBRLy3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 06:54:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35887 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgBRLy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 06:54:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so19829166oic.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH6i0VMMheF0qTLf2UbxFkPW7zIVaMSW5bNGZM+IBTw=;
        b=EZ3pPFuZm32rxNeZ9nt7P++J+xMCt8VDG/X46/ayhZfoKyUqC8m0t4caY+gr4uRYbp
         G71Ts7SlVzMXoBJdv0En+Bz31XeZsIywXVDyf+YI2TbkohK9GauFzpjyvszxty405axD
         bkV8ApoRHXzdJ5XoXwIyrcEz5Mau8xL/1JRwdo6OdkcBT8aKP+YNgRNKkuIYDN+wxUnh
         lPfUzuWL8Nlu9Jo8l201/fds7h6Fv1WSQIhtZGcGSyJDVFuMU9G2Tl0g1xpWYYszX8s8
         aubGc6BahDCAEnV79VMOeJnY3ObxsUtGgSFKEA/9lqwCmQKumZOppIcIgXpBTzahpWrc
         BJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH6i0VMMheF0qTLf2UbxFkPW7zIVaMSW5bNGZM+IBTw=;
        b=POAbGelIo1sjsspE0NtYU8lKs2Uizq5ZfuIv9kyJwHZFC1Bu7Q+JHOR2VB2AoCM8eR
         ghzDhm2ZjaHTFacWt6tSlt3EjGxYmY19Wd/VaT+WgvlbjOPKfUxZRKIY+OvYyynyn3nt
         OVu6wvKKZkdtmNpMJNURmomz0+4WWTt5fQ3qgt14kMhX/iy7l3luP4WBU22twQ8jvpan
         Oyg6nmZP8njpa3sbdD9qI55GpOJ3RBBXzHTGI3ZJoyPCTyKqKKirdCBvSuZoCeoHPDTD
         a8IT0R8Hk2j8OHJLE/HVEzzVhR11d4r7Ud+oMP5/ZxhKfFinFxXDwOxc0lk+xhb4HOk3
         r3Hw==
X-Gm-Message-State: APjAAAWuvkBTThcl9uNa5Wwg8ayfOJ/96U4eOqshGEItqbN8ZXiHmRmN
        C6bQ40qSyFtk4D1jU/QHI6aSFnT3iBh5y/hvcCJWhB7t
X-Google-Smtp-Source: APXvYqygyU6MIzI2NqAsQJ1ZUREdOB/dAkzbvR9SRD/jQ6CM3i+LVLOySq1rTOF6U4Po5HAoqlZ46NtkWhLVfV8BId4=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr1006305oih.30.1582026868854;
 Tue, 18 Feb 2020 03:54:28 -0800 (PST)
MIME-Version: 1.0
References: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
In-Reply-To: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
From:   Henk Slager <eye1tm@gmail.com>
Date:   Tue, 18 Feb 2020 12:54:17 +0100
Message-ID: <CAPmG0ja40xPPcXxM+uv_v339v+8Jc5TLP_kONbkw1vWHFUer-Q@mail.gmail.com>
Subject: Re: kernel incompatibility?
To:     Simeon Felis <simeon_btrfs@sfelis.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 16, 2020 at 10:29 AM Simeon Felis <simeon_btrfs@sfelis.de> wrote:
> [1] https://lists.archlinux.org/pipermail/arch-general/2020-February/047463.html
The partition size calculations done in the reference are not correct,
they are 1 512-byte-sized sector too smal (compare: if start_sector=0,
end_sector=9, size is 10).

Then still, there are some other errors somewhere, that might be
triggered by having unequeal sized partitions sdb1 and sdc1
You could look at backports w.r.t. 32-bit vs. 64-bit, maybe related to
changes 512 sector sizes and 4k page sizes. And better use gdisk
instead of fdisk I think. And maybe check first 1MiB and last 2MiB of
both disks.
There are also Ubuntu 32-bit and 64-bit images available for
RaspberryPi's with kernel 5.3.x, maybe that gives hints where the
root-cause is.
