Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC01ECF18
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 13:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFCLyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCLyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 07:54:25 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC7C08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 04:54:25 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id w188so403639vkf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qFxdAefoC3rXLlFySXI9XXIHkUyodskMUHpgZx8e2pE=;
        b=gR2oZdg49eIHAIucbB4TaaYycQpbH8wAnanHzMzTy/gF0EiYawPVDdo5/y8iSchFzM
         oVPmDWPsoPvDkgE8CnPU04dUXc2zlSR4Usj+lQ55k//sjNfGHCyG+EmwOXYhNS8G+axP
         cd9NJs54TXMf0pLoNqUdFuKUTPtfCq8PwRGn+hKrZH1L3GRobzPXRGba3Ij18smGLCoV
         HZUYZ7k+jagadwvAhIjRdyvNhsGCoQO/rGqXMMOpkqCTBg0Ff40NsFsUvYBsv6SBH9ZY
         SghX+0r/o34rHdZrf11lxEP/2co4TY51QMPUX2N1X9qka55yoUmc6bhRxleqyDjxkZOZ
         SzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qFxdAefoC3rXLlFySXI9XXIHkUyodskMUHpgZx8e2pE=;
        b=qkHwvszDhEqR0TeokvwHlPmetlBEAVJWLYYG0tFTKNeegm2crD6zxevpbM6wwS7skc
         /i21umb+rKqONoCqP3W6WvH2DLwQQ/5SzoR/uWNDijC2on3TUDUxd9sqT3raVzs/5K2E
         UbkQ9oo4WGX69tBZtc1kdlCU5C7Y3h07UUPN2lE7gyrQ6iRrReQFW4mk5aF+feoeJqs5
         mb1xmiHNmlo1Ycw1T8j8JQhQt49a2M0lb0jxq/Em+dkNR6ThamfDAp1rHyo1UmSjGotK
         FkBMRxYgUtdRgpn4sempFn9Prt54Pxl+KeSN5NeIPC4UpjZFNfNvX9LgSdWHm5KUm2tm
         l4EA==
X-Gm-Message-State: AOAM532ofRIjIzegG5YIwUxSFP2wI2mhoL3tjaMivGiAwNw2ERy3Z9ca
        0XnFpe7f53s6f3V434kJKMyjVv2cwJIN3RbWqpQwxQ==
X-Google-Smtp-Source: ABdhPJxTSpvCrkcsjDAp3cxtoNht2J5LGOumnq3RUR+wEEinkgfUqufQSjRnJNfp/BSilUfJyc5xpiqotj738xyKiHo=
X-Received: by 2002:a1f:ae51:: with SMTP id x78mr21022380vke.24.1591185264737;
 Wed, 03 Jun 2020 04:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-3-anand.jain@oracle.com> <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
 <f01398d6-2a0a-95e3-9372-2029626a3447@oracle.com> <CAL3q7H50fugFVM5Hq7fEg29SjmUi+jfetMBS5LCph9LRP525ZQ@mail.gmail.com>
 <bed5d4b9-928d-6f7a-87f5-34bbeff08f2a@oracle.com>
In-Reply-To: <bed5d4b9-928d-6f7a-87f5-34bbeff08f2a@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 3 Jun 2020 12:54:13 +0100
Message-ID: <CAL3q7H5Ysm+jwFzKU89F8rZy0FrhkS6qAatekVUBJ6uZnSvnhw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: rename btrfs_block_group::count
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 3, 2020 at 12:38 PM Anand Jain <anandsuveer@gmail.com> wrote:
>
>
> >
> > Why rename at all?
> > It's pretty obvious it's a reference count. Count/counter is not an
> > unusual name to use for a reference count, it even has get and put
> > helpers...
>
> I understand as the member count is in btrfs_block_group so prefix bg_
> looks redundant, but prefix bg_ is still useful. With out the prefix,
> the grep ">count" *.c didn't help straight away to verify where is

Following that logic, we would add the bg_ prefix to most members of
block_group...
It has members named 'start', 'length', 'flags', etc. Those are
generic too, many other structures have members with exactly those
names...

Don't take it wrong, but I don't find it useful at all.

Thanks.

> block_group count used. At two places we missed using the get helper
> which the patch 3/3 fixed.
>
> It's ok to drop this rename patch if you find it's not inline with the
> rest of the codes.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
