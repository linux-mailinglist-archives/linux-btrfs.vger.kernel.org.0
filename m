Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F393C42C057
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhJMMpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhJMMpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:45:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5FC061762
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:43:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s4so6040913ybs.8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hhs5ROdwr7TJtzPiPpJ/F2xDn96AxvEB0q2koLYjXks=;
        b=3WQD/w8qHgw0kcuwQIGHe0nyA+xfjlZoyp0r9PWSFgD4tWxRaeB7gTGypgEaO2uwrI
         2v5tfGqo+3Tgw4VQxeb8axuYEAg+vgmE9q6ymd8dL+u17varwWErZx1FjFmoyeRPw2BY
         rL6faf2LqewujRtdaf2OVCfjveqbWqwBsDLlkMLo9RuihiNILHTOoTOwW0UHbmv8m8Yw
         T0ayd0T90whJPbeHXzcHV/a5Mt9jDmsUM3pTYlTluoVbK2gcuvapuwX09im71tLwR8RP
         ttuXH1bETrBFo1GLCI4XsElh1J8sCpnVZI4fr1rQ44ecbmJVyQawX5GUJfLdCeU4fyG9
         OdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hhs5ROdwr7TJtzPiPpJ/F2xDn96AxvEB0q2koLYjXks=;
        b=FQ4GkpjLJjgclUdUjq03MgHLEg3/1vvQk4MTHL/gEOhXvia5CH50f8CE222cQoTrwA
         AWzu4feivPib6inGFCvAWt4VR3JNTdIelKMvL0tW6a6Ht7PF1mjxOOZdMYcsx6aIpS9y
         s2/f83urEuNYpkQMPB7FGi0lFJPbj9boRUTUJlSkLGBcpi+9IVcFrL0XcyYi7LdaXj1g
         cnxwAZO3o8yjAZLetOmwbOGEC3rEUqD5ZgnyrbJuZHkaly9itZpqgWVx28adNsEMosRm
         Rnfwj53cX5RGG2jFAvRWFwAp8MzNOTzPHLX1qYgjadJJ9B0vp5jwSJHkBL22cBg9zc6d
         qaXw==
X-Gm-Message-State: AOAM5335cmqfCTh7GKh72E2ho1Z7GDIX5i5+wIvEX5bmVGugu/YT/M2I
        u7L7fqdNtUqALjaAjCDcXew1yhy2oZLF8lhAha+K9g==
X-Google-Smtp-Source: ABdhPJxbsWydzIL6ASA3ih9mo053tyUbQSGBvE8nq9/mrwiuIvIHt2dl4d9uhFm8G7YtdFPJkh71uTCSPUs5DQEijFA=
X-Received: by 2002:a25:db91:: with SMTP id g139mr32899960ybf.391.1634129011784;
 Wed, 13 Oct 2021 05:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
In-Reply-To: <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Oct 2021 08:43:16 -0400
Message-ID: <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 8:29 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 13.10.21 =D0=B3. 15:27, Chris Murphy wrote:
> > On Wed, Oct 13, 2021 at 8:18 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> >> Sorry, it only needs the last the stack (submit_compressed_extents+0x3=
8)
> >>
> >> The full command would looks like this:
> >>
> >> $ ./scripts/faddr2line fs/btrfs/btrfs.ko submit_compressed_extents+0x3=
8
> >
> > btrfs is built-in on Fedora kernels, so there's no btrfs.ko, when I do:
> >
> > $ /usr/src/kernels/5.14.9-300.fc35.x86_64/scripts/faddr2line
> > /boot/vmlinuz-5.14.9-300.fc35.x86_64 submit_compressed_extents+0x38
> > readelf: /boot/vmlinuz-5.14.9-300.fc35.x86_64: Error: Not an ELF file
> > - it has the wrong magic bytes at the start
> > nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
> > nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
> > no match for submit_compressed_extents+0x38
> >
> >
> >> The modules needs to have debug info though.
> >
> > CONFIG_BTRFS_DEBUG ?
> >
> > Neither regular nor debug kernels have this set, we're only setting
> > CONFIG_BTRFS_ASSERT on debug kernels.
> >
>
> No, debug info is intorduced by CONFIG_DEBUG_INFO

CONFIG_DEBUG_INFO=3Dy in even regular kernels.

> so you need the kernel debug package for fedora i.e vmlinuz.debug or
> some such?

Each kernel has kernel-debuginfo and kernel-debuginfo-common, ~735M.
Installed that and yet I get the same error, so I'm not sure I'm
pointing to the correct object.

--=20
Chris Murphy
