Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37153DB4CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhG3H75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhG3H75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 03:59:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B885C0613C1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:59:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p13so4983089vsg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK4U84S6B9L4iN73gKuaKX/AcZOyGaMtF/xYKwHgDIU=;
        b=C/ey1SeItuAZAwl7VAHZWwQkJwbhGY4q37umjmbR+XDSekjz3itQg844Fk2dxrC26j
         aRGtxOHIhfjGtHB3vNzFTNZT0XLiRe1N1lOpoEtbpMqXDnW9FNBS+eEWcONAQJIXgxVG
         NLZZmKR0icajN1l9q+ZbPcQKutA4QaiOiving=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK4U84S6B9L4iN73gKuaKX/AcZOyGaMtF/xYKwHgDIU=;
        b=jyIAJQ9vHID/MxcHTF5rePoA+TGO845WQvGXTg7pd60MTlTVyvVx5Iow+hoEG2t18W
         DdjaMfkCpOhrdqofl/eXM/blAXv9AX3k6lafe805DNBjezI45Nxn+9tC76KzYYYvTx5U
         JVQwUbySgszlUbBXsp02o5AbNrzETfAHmTxgfD1n8TKYN2EmalxgeUIrF6JPfEzL8twY
         bS7yVDi5XgeDS/lW0EPQEob0ydz4B7HKS/b6C1oKg2DG1In6PA23VFIx5K86qW24KHWF
         08yNXsncsJkDHhKpGjLxTTJqInKYb50zcSL/lN3vI1zsJPgmI4zUtQ7zq97O4Z1YDM4N
         VAOA==
X-Gm-Message-State: AOAM532JIcYLNtCPjTzwI9liYt03v+rczVu3cBIRwwbeotqy8gFvofaP
        i2GxlOIOSlTvN72Cn02FIV8cxVRyc57jIQCbiXzI9w==
X-Google-Smtp-Source: ABdhPJzNAQNQqqV/aJfK7JQPWmq2dMTFXC58sCKEj31HVNqDBqtViSN2IlYnT49qjaazqVwklWIuTuBPVPd5xfuBGoU=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr594234vst.0.1627631992199;
 Fri, 30 Jul 2021 00:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com> <162763043341.21659.15645923585962859662@noble.neil.brown.name>
In-Reply-To: <162763043341.21659.15645923585962859662@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Jul 2021 09:59:41 +0200
Message-ID: <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 30 Jul 2021 at 09:34, NeilBrown <neilb@suse.de> wrote:

> But I'm curious about your reference to "some sort of subvolume
> structure that the VFS knows about".  Do you have any references, or can
> you suggest a search term I could try?

Found this:
https://lore.kernel.org/linux-fsdevel/20180508180436.716-1-mfasheh@suse.de/

I also remember discussing it at some LSF/MM with the btrfs devs, but
no specific conclusion.

Thanks,
Miklos
