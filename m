Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607DF1B59A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgDWKt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgDWKt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 06:49:28 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51BC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 03:49:28 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id u12so5175207uau.10
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vkYaS3t/Ly4e74UZaKB3I/HxH7Fhrvio2XXE+JPU/1I=;
        b=vgHVb6xCr9HvD73cu48w2sZ0oJDsUAdb+KhE0hQXcNxO2cyFVezXrXP08Pk9IyR5Tt
         y4stMlUmiRZs3c8zV6twSEJZvVdSKZCs8S3Wi9zd2zj1c0a8BWHLZ2Vcy6sfy8Y+wRqH
         78swKeeAOtAk+fXm7Bnq/akrk+KQzuYAlRlK2coe5bkMd63jUPbmei3DiX6/xHFf+fJ1
         3CTw0/c7FWtQYS/y5MR3495W1HdlsgaQbUhQYGWX3U/6DrrSl0mbHfBrwTikdZgPcMT0
         MoL1KZI9mS4Ypi32aGdX+JZmKlBsF29bRyznFVl0mvQ15hjjQZy7Y5MqbgpLBVI/O78a
         P4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vkYaS3t/Ly4e74UZaKB3I/HxH7Fhrvio2XXE+JPU/1I=;
        b=FtrTkRJrJy0/Te+F7DSkZGdEwnruLYmWuDL25LGBLXs8E3mw6VYJRasSSbpsHczhv0
         /GE/DZESU3qC1LJPwRXDJ9WCKoZG0wjRl9JEEg2C0XYlp2x8NnZ1Nea03moqeOKGeea4
         Dg89qJV54Mw0RbOxqjMNc/Ei14cPA2d4vzxdPtsadK0S2z2yrGYlF/78hMRwLFnK5UBq
         F0bQu0OHfy/RwyIIH/vbOjMM+Yo9mjOJYwNv51i9zQ0Nf+/foV1jxcXiXEjDn226ChEC
         KtSLAosm/mKO+1Fq9wjUYHQu4DzBJyiMlS4Jl4jsdyS8uJJa8+YdclVqOSE3cO31Qpci
         j5Jg==
X-Gm-Message-State: AGi0PuZE+dnA86+/zlf8uZQJlHk5unjYNrCHP1io6d9IuRVEQ7B/Jbz+
        fGE0LXzUykXSX7vxsHP36jvs08IInDAT23udbXvyOA==
X-Google-Smtp-Source: APiQypL6d8R7jhAldjaqJn5hL54uiQXkwkOqaM+MogyvOw53MqCx3lSrsyOD3esszcAeZ2tzJTBsK8A5k8uY4cHO9U0=
X-Received: by 2002:a05:6102:308b:: with SMTP id l11mr2411937vsb.14.1587638967860;
 Thu, 23 Apr 2020 03:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
 <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com> <20200422225851.3d031d88@nic.cz>
In-Reply-To: <20200422225851.3d031d88@nic.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Apr 2020 11:49:16 +0100
Message-ID: <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 10:00 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> On Wed, 22 Apr 2020 14:44:46 -0600
> Chris Murphy <lists@colorremedies.com> wrote:
>
> > e.g. from a 10m file created with truncate on two Btrfs file systems
> >
> > original holes format (default)
> >
> >     item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
> >         generation 7412 type 1 (regular)
> >         extent data disk byte 0 nr 0
> >         extent data offset 0 nr 10485760 ram 10485760
> >         extent compression 0 (none)
> >
> > On a file system with no-holes feature set, this item simply doesn't
> > exist. I think basically it works by inference. Both kinds of files
> > have size in the INODE_ITEM, e.g.
> >
> >     item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
> >         generation 889509 transid 889509 size 10485760 nbytes 0
> >
> > Sparse extents are explicitly stated in the original format with disk
> > byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
> > extents exist whenever EXTENT_DATA items don't completely describe the
> > file's size.
>
> Ok this means that U-Boot currently gained support for the original
> sparse extents.

To clear any confusion, what you mean by sparse extents is actually holes.
The concept of sparse files exists (files with holes, regions of a
file for which there is no allocated extent), but not sparse extents.

>
> I fear that current u-boot does not handle the new no-holes feature.

The no-holes feature has been around since 2013, not exactly new, but
it's not the default yet when creating a new filesystem.

As it has been mentioned earlier by Chris, it just removes the need
for explicitly having metadata representing holes.
When not using the no-holes feature, there is an explicit file extent
item pointing to a disk location of 0 (disk_bytenr field has a value
of 0) for each file hole.
When using no-holes, there's no such file extent item - btrfs knows
about the hole by checking that there is a gap between two consecutive
file extent items (both having a disk_bytenr > 0).



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
