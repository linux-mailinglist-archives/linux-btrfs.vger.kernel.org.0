Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235B1ECDCC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCKta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFCKta (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:49:30 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074EC08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 03:49:30 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c15so680357uar.9
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zRqcoUaJIVxX48NY5Ih8mbWgq4YsTj/Nx4LtWG1ZPAw=;
        b=hkr+qsCU90qE0k/xKZAPYq73m2iprpbX5yV65UyUUt/nxPPtvQgIb2AA2uHWQjq5Xj
         KnaPK5YrqG7j2VhgpjM2E1DICMzmq2WM9F4TELX3BFH/bHcgFlybd1xlWCPFtL7mtN3T
         g5BlcGX/3FYH3A5Xx4L0pl6TIj1hApLTdNAnpC+PeQ1AGnT7vxkTn9wvMJcYfV9h+d2t
         YIdjld/bbExTqWrFQkP3eW+Hmsr148/ve6BFzXYpHlZ81YkGx9ptYUdE5OLHQK2niF61
         1ODbJ4yDICjAcAe+/1/kF3qWdg2+p6UcsiQVgRaVnqfcgxe/CFzMH9+/F8u0gPgm3fMn
         +WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zRqcoUaJIVxX48NY5Ih8mbWgq4YsTj/Nx4LtWG1ZPAw=;
        b=UogEIyzcD+okCgXVymuBP2thyVlLNtbuaO2HNOZ5UoTVVYNzWJJCgvoU5NA6NmJbKM
         uszKbuCIxqObbUFEbmaEW8eYlJy0cIuGryZhdbdVIVxPxKMNcixH16bdpBvc5gwkzH9v
         z5vZJmnjXrj9KcW6Cbj6s0MsgsEMtwMf68a0sXb4jZ6fjYvP0RBDRx5jFHFGdPjjefSZ
         aL0CsKhLziVaWO5RHOUjiQU+yJoudEv9mLdRFWs3rc9EEwYNNJMs/VLePBEfuSOml8Dq
         bV62DhIoWQZkvuwfKeTJusuMSIYPA7FAZF75a7JQRPBaIfd2iSg0svFwTa2mubZmdYJi
         uTFw==
X-Gm-Message-State: AOAM532NZ7CAMDk+5/nVlz9LIvFK2Vxu/B+4+D9IpKucKvPO9RtpT3/5
        uDGCmbiHTkLfFoWCF+MTUO/KM0hTjcXpdo6zTzNTdQ==
X-Google-Smtp-Source: ABdhPJx/TuDXapkxMpc0y0pWoF6jFT0G34yCz8AUZ/AJcuwB/IduiOTRCdPQlsiL0/8Hj6XEUa1Guc25iqTPeZ224k0=
X-Received: by 2002:ab0:152f:: with SMTP id o44mr17343517uae.27.1591181369350;
 Wed, 03 Jun 2020 03:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-3-anand.jain@oracle.com> <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
 <f01398d6-2a0a-95e3-9372-2029626a3447@oracle.com>
In-Reply-To: <f01398d6-2a0a-95e3-9372-2029626a3447@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 11:49:18 +0100
Message-ID: <CAL3q7H50fugFVM5Hq7fEg29SjmUi+jfetMBS5LCph9LRP525ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: rename btrfs_block_group::count
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 3, 2020 at 11:43 AM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>
> On 3/6/20 6:19 pm, Filipe Manana wrote:
> > On Wed, Jun 3, 2020 at 11:13 AM Anand Jain <anand.jain@oracle.com> wrot=
e:
> >>
> >> The name 'count' is a very commonly used name. It is often difficult t=
o
> >> review the code to check if there is any leak. So rename it to
> >> 'bg_count', which is unique enough.
> >
> > Hum? Seriously?
> >
> > count to bg_count?
> > It's a member of the block group structure, adding a bg_ prefix adds
> > no value at all, we know the count is related to the block group.
> > I could somewhat understand if you named it 'refcount' instead.
>
>
> Oh right. Now, bg_count does not make sense to me as well.
>
> Something like bg_refcount is better so that it is easy to search
> where all its been used. IMO.
>
> Are we ok with btrfs_block_group::bg_refcount instead ?

Why rename at all?
It's pretty obvious it's a reference count. Count/counter is not an
unusual name to use for a reference count, it even has get and put
helpers...

>
> Thanks,
> Anand
>
>
> > Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
