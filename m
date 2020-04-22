Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1E1B4E52
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVU0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVU0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 16:26:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CFC03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 13:26:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so4052372wmc.5
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSdCKYPVhngCOHBuKy0lP/JtuGIHCEvOeoiLIHG7PnU=;
        b=RtfjmJhYUGEp1iKRXs0FnqkAR97ajkn9ptcWprvSH0NpEgOZ34g3RfCopuUmw0I8ic
         79jKhSDrpzWJNqWOJDmA/MOjJA8hg76cEWz2BOOv4PnlAzzgJZjbPBU4G5g4twzlVpKM
         fBAHcxymhB2MsFV0WKcizytKFr9mchT5ZTX8iC8f3vQ9roOmL5UyVTDiMuTHqfyC31tm
         i8FbKs1jpV9oaW7IxV6JaaSaAat/p497UsEsVTQ2z0+XNu5xNJnIMY+D+a63kXg4mckK
         yA/XeGpbyXLhBkevjCHieIVZGpXOhEk74xNcbZdWlPW52TWmAHf1Hs6uwX6XNhBhErsX
         d9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSdCKYPVhngCOHBuKy0lP/JtuGIHCEvOeoiLIHG7PnU=;
        b=LcOKji3TMltGSBFibBD/PQjV1yJCfMdDpCSofe7wMi0KIIpH3BoKd5BL+7zNXzMZRl
         5PN9Fec3O4HDlqSGskXnxYBESBrwnR9sLTl7n2VD8cCSFgkM8Y7nf+VGTRFUgHh4UF+G
         jEegDbbd1RlLBfBJfVm971ugVExut0daHNbAWcZq8meFqh38laWw+ZRsagISpavyndnL
         MdSJErZR2+AjEMhEDBAu8fWYEv7abW6x5LwYcBRGDNjnghsWREYfqHYUr48YbeLWkeX8
         HXPlr32MSCzI/WC+BCKc/GpI2ggsW53o/ZqTvirFFa78rjDUnF9rA9PdtyCEd7rkrQL1
         mbxw==
X-Gm-Message-State: AGi0PuZb/n3PHUzNYKha+zSqK5ZquhTo6UiqWWbZn75KoRMieM0Yw6gj
        iOGLArwRbUjBS/5EqGx6XVFc5daxAn4PnDXWBwGikHkiJco=
X-Google-Smtp-Source: APiQypLUnXrAR8eBDBjw8XLcfbUvv3RHvpAKURDbULdl79VDVnfXMdAs7JP05iWTc85iS+k12E4X27v82XUnH3UuKwg=
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr264730wmb.182.1587587207463;
 Wed, 22 Apr 2020 13:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz>
In-Reply-To: <20200422205209.0e2efd53@nic.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Apr 2020 14:26:31 -0600
Message-ID: <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 22, 2020 at 12:52 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> Hello,
>
> there was a bug fixed recently in U-Boot's btrfs driver - the driver
> failed to read files with sparse extents. This causes that sometimes
> device failes to boot Linux, since the kernel fails to load from
> storage.
>
> So when does kernel's btrfs driver write sparse extents? Is it always
> when it finds a PAGE_SIZEd and aligned all-zeros block? Or is it more
> complicated?

I'm not a btrfs developer, so with respect to kernel code behavior I
can't answer directly.

But I wonder if other sources of this sparseness has been considered?
Maybe the build system is creating or preserving sparseness? e.g. `tar
--hole-detection` or `--sparse` is used.

Another possibility is Btrfs supports two kinds of holes in the
on-disk format for sparse files. Maybe uboot only supported the
original (current default) type, and the bug really fixed the newer
'no-holes' feature version?


-- 
Chris Murphy
