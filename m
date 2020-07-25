Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71622D5C8
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGYHYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 03:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGYHYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 03:24:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EAC0619D3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:24:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so8511763edb.11
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSRLLjCB8odAzgCBr1FFOX7a+h2pj1WC+cnmib13aRY=;
        b=NOoHWQ55Mouo32yBgoYyn5GDADb1+JTciZycrE2wHxbJlba/t4Cj7Rv76wZKH1EnDE
         JfEqH+BStmWWGurL5YMgYZOiwihTue/0mPb42BFx6RC40nmVD1s3+0MQ4kxQmKbrAa8M
         qP3pfxiCsv1u+KRpiO90M+kWepExCEF1VyVbpCBprBwdfm6JCbAAKSCu/LSArTjwOIEK
         Dlnf0tlXgwrDiWhnmDuLJ0q+qzuIKCBO24KZGpz5MObYpiQx3JUbLoz9DXmi+T6xzIlh
         fdHPH5UthCq8MeP9CUxbzF8vw1DSnYcSdUJZDZLhj76lriq4uMSDUcIc013wMPloqkjI
         nutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSRLLjCB8odAzgCBr1FFOX7a+h2pj1WC+cnmib13aRY=;
        b=WZR60lfB8IzNiLgH08QGTKQ/NkOg+z4sw7t6gBbAeVTE8fPSsIuYleKAONbyiwSDtm
         KPma5xcQlefjExCYsmWPOkodgtbloExnc4k/VDGH9Q8b9J0Phx9kDnTIuz9zNHTyvKGA
         lLVVkn556U39HiWoAzBkFZR+cnsF18gyCr/3jX90lRPOgocuevtKvAFXUx5jdUX0tlvg
         D525n/mZUjVc1tFPFSsCmH1B9TVmYeQUrGB0tXUDVX82gqJ0wRqBXBRiGOWicmdxae1+
         vEw7Hw70XNQivLDjOz1B/TvT8D5yhmHxu9mAA7uAbboTYQ6vJrtFfwUxaoJd/8tI9YgK
         8c1g==
X-Gm-Message-State: AOAM532VrBojzayHLbkhXAYty48OuUgPfaqsVtGfzPv5r7y48KuO7unc
        MIklLh5mCHe0LLnCQoxmR7G52l96L+Ba8lJKGx0=
X-Google-Smtp-Source: ABdhPJw3nAMfi7yjnK0lXXSYHLt9Ai4oHS7ZTcBYZMSQPmWgs0pOIqybtalKE8u9NVXlguyIju9GnmpVgFBQHvh2608=
X-Received: by 2002:a05:6402:30b5:: with SMTP id df21mr4548311edb.73.1595661889575;
 Sat, 25 Jul 2020 00:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org> <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org> <20200619131117.GD27795@twin.jikos.cz>
 <79672577-6189-10fe-b4bc-8cf45547b192@libero.it> <20200622224556.GP10769@hungrycats.org>
 <CAKuJGC_eDi3isqJHxn6XG8GerOthYeVTb1j5cTPYSiuV_oFgaA@mail.gmail.com>
 <20200703031611.GD10769@hungrycats.org> <CAKuJGC8u7h1R2ojyuSjZzbGziQf+phZvMZGg9Vm+ER=RfTJe2A@mail.gmail.com>
In-Reply-To: <CAKuJGC8u7h1R2ojyuSjZzbGziQf+phZvMZGg9Vm+ER=RfTJe2A@mail.gmail.com>
From:   "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Date:   Sat, 25 Jul 2020 12:54:12 +0530
Message-ID: <CAKuJGC8keCieWq-_yOwgyXhwq22S-UQoYk+8xevk_vSo1FXxfg@mail.gmail.com>
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, dsterba <dsterba@suse.cz>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo.

> Let me spend some time investigating these issues, I'm pretty sure dduper
> can be made a little bit more reliable that its current form.

I think I resolved the bug which caused less disk-space saving issue with
this commit [1]. At-least now dduper should provide better disk-saving than
its previous version.

Also added `--analyze` option to display stats with different chunk size[2] and
posted some test run results here [3]. thanks!

[1]: https://github.com/Lakshmipathi/dduper/commit/180f2aedf697b440c53cbe61195dd821c8aae3b4
[2]: https://github.com/lakshmipathi/dduper#analyze-with-different-chunk-size
[3]: https://github.com/Lakshmipathi/dduper/blob/master/tests/TESTS.md

----
Cheers,
Lakshmipathi.G
http://www.giis.co.in https://www.webminal.org
