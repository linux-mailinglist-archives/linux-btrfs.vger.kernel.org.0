Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0A1B5B96
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDWMjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDWMju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 08:39:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8505BC08E934
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 05:39:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z1so1189608pfn.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YWEYk5CIpEC0NGFaZvf5WuiZBOimQdihoVj9pRN+jyU=;
        b=D4mVDZz2CzCfKHZLu0iZw2WcGtDY5IFdcv9dxFdssPj4pVD+0jlNtGi76j+gRjVumZ
         P7UjSVdA01PKohz4fKlmvzD0Qgz/n/kpL99ZpCf92twJXe1GLXCtZfr6HHAKH6B6BoWh
         d+piznN0748Wgi69lGM4dmz3PwAVyxwtjt+pucdza645ovjcu6ZygJULU0Eutdb6pnhs
         RWNXbonZmwHklr4maOKXxOUcYzOHmWVSZ3aVxVbOT7XmzFDS2No6ENIC16gj6Y/5XY1i
         NZSqxA0WwFIJNxrQvvKSHT9UgS6eWlF43H/8IHOadfcbgI3lLyqhhl3IIsE98AsoCoNJ
         BmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YWEYk5CIpEC0NGFaZvf5WuiZBOimQdihoVj9pRN+jyU=;
        b=AMbXM4rnx6dgeGM7raYx4FpmX1Dlu5WD24iBbsX3h+Iw1tj6D+UGBCB6ySD6JdBlIC
         50Km/alC6qw0LIjTrrb7zxjIdml/YMkP9clF9McHFf6Rx+EjTcjTnodjeCS+G7P45rso
         l4n+sU9HQflDelEYXjFRVuLHbCgnZ+gl/vaC/qaav1+9sRxZkJLrbUGLMqZTmmnx5oDl
         bxk9dhDT9hT3zfOTkgLfzkP/MRvvexf28MStCuppme+xH+qvNNNugDCeLz5myThFnT1n
         boSuQEPIvchlb83Eo1B+LjtoBD0JigMWZSga4nBD/GSXOw+8Qq9OSt1qsKk7CKRlD0MK
         j3tA==
X-Gm-Message-State: AGi0PuZJBgbeRRJ3iYJY6AFNx2/FJwwX6xU8xElGFbAmCKRAcIyQifyY
        spHgiYuTAtf6mBGUrk5c79zrXG1y12e/S+xbhEo/Nw==
X-Google-Smtp-Source: APiQypII4j9A2x1uKZUz2BaAS0H/M5yaGDMdx5COatq64somFZH49ONsOQP20eL1+XwQ3ceEBupIwLMTj6A8L6D55jU=
X-Received: by 2002:a05:6102:308b:: with SMTP id l11mr2781099vsb.14.1587645587589;
 Thu, 23 Apr 2020 05:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
 <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
 <20200422225851.3d031d88@nic.cz> <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
 <20200423134248.458cd87c@nic.cz> <CAL3q7H41C6do6SdBCfCmA==TT1nPJQ4dB0vTi_jsm0tYuvvsUA@mail.gmail.com>
 <20200423140559.2762bb0c@nic.cz>
In-Reply-To: <20200423140559.2762bb0c@nic.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Apr 2020 13:39:36 +0100
Message-ID: <CAL3q7H4Vx0-vfxCHpdhwg0rSby6rphxVnDFYX=NnfJ_96gEfdQ@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 23, 2020 at 1:06 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> On Thu, 23 Apr 2020 12:51:32 +0100
> Filipe Manana <fdmanana@gmail.com> wrote:
>
> > There's nothing in btrfs that converts a sequence of zeroes
> > automatically to a hole.
> >
> > It always has to be done by user space, either by writes that leave
> > holes intentionally (e.g. create file, write 64K to offset 0, write 4K
> > to offset 128, leaves a hole from range 64K to 128K) or by hole
> > punching through fallocate().
>
> Thanks for this information. If you ever come to Prague, let me know,
> we can have a beer :D

Noted! (Through it will be a long while until travel is allowed and safe)

Another case I forgot is a hole created by truncation - truncate a
file to a larger size, then you get a hole for the range that goes
from the old file size to the new file size.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
