Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5231B266
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Feb 2021 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBNUZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 15:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBNUZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 15:25:38 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40DC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 12:25:40 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id l8so5165320ybe.12
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PUhHSzImQTW37yT+un+Q6WkgSZIZiToO9snRXp1DdyM=;
        b=aynibPBmbTvCcurB/tJytA+bncbjJGrn/FrS237Tjm9knhOOhAf0YSPZfPOiQp5jRS
         7yN6mHguK3lNwEZTAqbCIVyHmVTh/1mzddW8xaETGoV91rGs1wgplgKue0fqtKpXT29l
         7L1uelLzkzqS9c5B4adVC61Dmzow4A4jGX6MlUDmqFWTEUPatZUSwW/FPN54juPpztmO
         NT4W7VtP+cqv9naUNstOBTkrl5p1SODBecJwPKjhdDxTk+hneUU4dv89NjAXGEYlY8Me
         qhAFg+R8VOekQHHE9S8KhEq/dvRLoZNyAvYSjH7GQEnVifOo4o49i/LkX8kyAx/d2m0H
         1kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PUhHSzImQTW37yT+un+Q6WkgSZIZiToO9snRXp1DdyM=;
        b=h5YlFNMDaegKoJR2GOezevhWow3P+5uk6Dofko8otVgZZkhZqgI/rXNd0hm9RUijvd
         YpKV/B62cYJihdAM2QJ4lqQBMrME8nVvQdL5oOBJMItdCV6Ws+ph93MstoKbDnRGA7gr
         iPi+IMWTjnJ4uN+TlebqMfFLkasKK+cAgl88QBiv8sZu8WuHo0hwdD7kbnYufkGHbBnm
         6uIZOID2y7p6Ds+nlOEyRZ+T3LG9+PUoAl4Ai5JmIGuzCNu8w+J9UDnEXWMOU1azry4o
         VRtexAl/TpMNL4DcUJio0KTDBpL0FXhsB3yRMUO26t5VjhkgpWSonNSIXlre6820jVE5
         PeLw==
X-Gm-Message-State: AOAM533ylsAID4uGuTB+Ai1gn/yuKqNP27C70VuYrwEi4AWjRlMC/ITd
        d79JTP/oimnDl6+NiKRThkam/ZDrBbgAXZwRtyrb40Nh75Y=
X-Google-Smtp-Source: ABdhPJz12gFFfE3UMTn9sdS/b/mVb0pXOGAImUEPoItsY0e9tUsOL2NGIaWsSukfU0tHEbZ345un9rKY6BqE4LHghkw=
X-Received: by 2002:a25:4f41:: with SMTP id d62mr18382449ybb.354.1613334339923;
 Sun, 14 Feb 2021 12:25:39 -0800 (PST)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 14 Feb 2021 15:25:04 -0500
Message-ID: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
Subject: Recovering Btrfs from a freak failure of the disk controller
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

So one of my main computers recently had a disk controller failure
that caused my machine to freeze. After rebooting, Btrfs refuses to
mount. I tried to do a mount and the following errors show up in the
journal:

> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk spa=
ce caching is enabled
> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skin=
ny extents
> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corr=
upt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid inod=
e transid: has 888896 expect [0, 888895]
> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=
=3D796082176 read time tree block corruption detected
> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corr=
upt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid inod=
e transid: has 888896 expect [0, 888895]
> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=
=3D796082176 read time tree block corruption detected
> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): could=
n't read tree root
> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ct=
ree failed

I've tried to do -o recovery,ro mount and get the same issue. I can't
seem to find any reasonably good information on how to do recovery in
this scenario, even to just recover enough to copy data off.

I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
using btrfs-progs v5.10.

Can anyone help?

--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
