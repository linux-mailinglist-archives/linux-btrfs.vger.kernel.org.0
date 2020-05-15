Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C71D4969
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEOJYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727825AbgEOJYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 05:24:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05EC061A0C;
        Fri, 15 May 2020 02:24:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so1454979lje.10;
        Fri, 15 May 2020 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4HN69hvAxNrKtFX3cEwdX4CzgjCipjYhqqjmfpMvn4=;
        b=hIriAWOy1p+4acNH2XQv3Jh4M5FeOOMDWHmGL+S0YJbxS7YXk+DdQwX19nvR5qM30+
         s4W/K7FdDJ26TyBi4Bv7/pGymP8dnU/zG482HsOSaUK56eqT1unCNMC6KvnczGOjy1cR
         LWDqKZyqUrT1do0HYwd89K9n4yJ5OAYGX3ar8gvnVky2qFXwtmhdJSx41VQv/vLSyfPZ
         /0KPRofovYl3n/onlgTU+ikybQb3is85/Dv1VPbtL3+mfW8b2WE4eJtvRS0xIn3MKkqR
         2e1FUfDgv8isaMmI+OqwZ1y2qyPy5Jpg13iolFJ+gPHTX+qy4QBtGe1yenG7gX8DXFrE
         tpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4HN69hvAxNrKtFX3cEwdX4CzgjCipjYhqqjmfpMvn4=;
        b=gIgsNI6mYtQWzdh1p3XemSbZv6CnRiMZEzrLm8qq63c4QqP1OzKYhDXG7H/s/Vw8l7
         +cclwg9gf1TZ2MJMKc+6/TlC6CExUrXEbLrnriV1Iw0VKvgFjiEqxSKSOvUcCaU1Ol19
         0cuJTcmK4Ju0bGLHDvTTssxkxFTCNrsa6yq/6a56PP9ay/B7lx1B81FVgQ3GbImBWqCh
         eQBeCviWEZW/yjOqj8bi2hbb2VV0g3pj840Z7kK/M2Bb7WWkm4tc8PW6+w8rN9p03aud
         WHBd1IMxJ/cJjkASzFXWgHDBh9b1DmeF4/h6BWhiZLqtNsKl/F8inIHt9/dgKAJz+GEA
         zCjw==
X-Gm-Message-State: AOAM533T4ogwx3qzj3gOqtDTjHtgwO+TFlOLy64UmB3VcJ9YsTM9+8zq
        hSbs3nH6vRsIfXeOOnQPsYJNzGouGyJ46OB9gII=
X-Google-Smtp-Source: ABdhPJxqhBbSrg8tCxhJyS+sWLLZoa8qH+jxXWgEv6AhM+XGSKLzKOru+Paq7nMeAOnXyRyIVIudd62cmmzQTAW5g6Y=
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr1791449ljp.100.1589534648591;
 Fri, 15 May 2020 02:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515021731.cb5y557wsxf66fo3@debian.debian-2> <SN4PR0401MB35985CFC199D20362EBFD8E09BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB35985CFC199D20362EBFD8E09BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Fri, 15 May 2020 17:23:56 +0800
Message-ID: <CAKq8=3KyewqQLdo-GjERuOfKe5ZrmQ+bRPfFRWiyZkjdEVvSeA@mail.gmail.com>
Subject: Re: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "sterba@suse.com" <sterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
On Fri, May 15, 2020 at 5:03 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 15/05/2020 04:17, Bo YU wrote:
> > It adds spin_lock() in add_block_entry() but out path does not unlock
> > it.
>
> Which call path doesn't unlock it? There is an out_unlock label with a
> spin_unlock() right above your insert. So either coverity messed something
> up or the call path that needs the unlock has to jump to out_unlock instead
> of out.
This is out label without unlocking it. It will be offered spin_lock
in add_block_entry()
for be. But here I was worried about that unlock it in if() whether it
is right or not.
