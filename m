Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66349276607
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 03:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIXBtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXBtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 21:49:07 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078FC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 18:49:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d190so1658066iof.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GvECk7TaisQLKdqe1qN0JEJv2/7U9jHLpKXW6GkcunA=;
        b=oMyPjy3tswQHzW/fH4p+T3TLaprZGfke9bF/v6GYzWMmNAlXgw4m/JHYVQRW4F0n7V
         +bW32Fo9GrCzTAoIdGoDA64TDY4rR6NOQC85j9N8jhSiNuijiLWBarFvELGc/J8OrbAn
         su3FnfQPMEmzhiuEbpcD6YY8B1P8h01ycv1LgY+Ya8IiXlxfJ8DjKebYmjRxsWWN13s4
         VWryR0hqtVAvnMC6u/lY4yqd5oR3bPZCtmAHWy0zmMMvXgG1A5jfz0CVsjX8e03kcSdW
         Q42AO6szILD3gjovM9RLh+38F+P/OuD6vhoj4SPu8WDuVV+gd+xClMyYxeOCAJfljB2u
         Hxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GvECk7TaisQLKdqe1qN0JEJv2/7U9jHLpKXW6GkcunA=;
        b=MSpaAXuzqj5ux4f7Qc4+fstSVi3L5HD0duqOemzt/j1OxeLI3fdhFzP1/FDNNt5/Og
         RtG7EuYjFLzYOdDkWGwTJOVSMwv4QYppxVYLr+cG5IiJMf6ILdGx+LrlJ0Uc2az/S12t
         oAclcShDlohZZUckd/Fhrn979R/arTtTOKfQbgFjfa91AGG0KxxGYwd/FVyB6+jhriTB
         dSpbtpIdrSY45Z/A64LZESIRoB2sCWMy/cQScYtWLiJ95YjU8H34aHYhXug3kkmf30sI
         yCKUQKkccMN0vyq8ivYCShgwhdV4Ncuh1dR1qMJzB96FVgzXSDEeXvxphqHpdb3yP6Mg
         inHA==
X-Gm-Message-State: AOAM533lxJk8PNLvsIt3eU732F3RcdQga+m6C1NYysg4gB5pQI15JZYp
        GI4U8nprG2l2ZEqziizVa2ZlQAwq8zQjVCW7BuQKCnCX3dI=
X-Google-Smtp-Source: ABdhPJwzlf11qWfwp8vXrlv1tSpiTioc+CJKVtP3P/RhfSCWb+qwEeYV+a3wRK9/qPk1Fquqy/Bu0geqhxUcad5g+QM=
X-Received: by 2002:a05:6602:18a:: with SMTP id m10mr1682654ioo.174.1600912160660;
 Wed, 23 Sep 2020 18:49:20 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 23 Sep 2020 21:48:44 -0400
Message-ID: <CAEg-Je-VLz9zZOKEVa+x0V+dpyojtRcjBw7maO73zpmowdOyTQ@mail.gmail.com>
Subject: btrfs-progs and libbtrfsutil versioning
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

I've been working on a set of patches to synchronize the version
numbers across everything produced by btrfs-progs and add pkgconfig
files to make it easier for software to consume the libraries, but as
I worked through it, I started realizing that btrfs-progs actually has
*two* distinctly separate projects in one package.

This is somewhat problematic since it makes properly representing that
versioning in the packages I ship in Fedora rather difficult.

Would it be possible to consider splitting libbtrfsutil into its own
project with its own releases? If not, is there a reason that we
*can't* synchronize the versions across btrfs-progs, libbtrfs, and
libbtrfsutil? We could still make sure that the library sonames are
versioned properly, but having the user-facing versions actually sync
up makes life a lot easier...

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
