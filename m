Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06F154A3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBFRdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 12:33:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37094 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFRdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 12:33:09 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so7241568ioc.4
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=susLVxPwU9t8+5jj2AzDETD+/1CnMrZt9dJFJDdEnBU=;
        b=ALWyqz7NdluhG2Gdhaz4DaivO7P1gQ7ctzV2nySYajdB1DOoVwqt+lLN2QmMYGWxf2
         3kKzwc1RwFEZ9JCgN3ibFNbXMomSLXoKgh1yic3hcL9cS0VtpSy7OKL9WQFFuGa06GXw
         A6Jw7QRkXHrSN4T959n0pPawDTLgFgdpCZ4ihs269Jp94A1SdGgkjgcL+hrJr0cT5a7Y
         Z3wlaQVVttIzTEhQcj/W8+ljRAY0FWTrBV7cCyiDZhsO3QEx3nmgMsDZbXsa5wLGzjrL
         U7fMEDOlMqSDWBSWOL0DftFhP0xIQ2x4nWzehkLxR5diu5dL6mkyP79oC9e2FeoxZFMF
         W4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=susLVxPwU9t8+5jj2AzDETD+/1CnMrZt9dJFJDdEnBU=;
        b=oe/ZI7k1aPIxv99tyIJJCY98xEqvT16ulAoCmG3VzRIiyL5UCq99mVuUCwSswNc+4z
         5yDcRe2il1taIKWaM6RG8h4U26Slyv+anCMsM740DCsBRDP9KZu1Nq2m8xX3Lm/RCJfW
         4+sGVphL5eLe+zQNlYEahzza5fOLPvMJ7YClLWbniwUain0n7l9x+2URaktzbekTioW9
         NWunG9Hvy21VOaO4SpNBhmC0yIxXP+wtCBQHcYxq7cgnxn3A2l0LW4LVPpTuCQOU9hGn
         y34o74vduag2pWclyNO/usSMrktv/EDLs1ZssGTKGs1qHqq2XaESFWFqdAaAjbfo3C+T
         SYtg==
X-Gm-Message-State: APjAAAU6436i0VsjJ33baTbluHuwiXZN/hod9kTqLqgp+RVjnNDGUV1Q
        ujP/njR4IcauZ+t+Y+WmeGP7NCT74C1ezm5TppHbgQpM0xQ=
X-Google-Smtp-Source: APXvYqxo+AAeWYllxo4pOgxEDrfjIfdmRdN9zb3FzkJ29XZba7/lJSXYtl0bomC8aEKIE+XoHmvyGNkBfTY00ZdueCo=
X-Received: by 2002:a5d:9dd9:: with SMTP id 25mr34690493ioo.287.1581010387597;
 Thu, 06 Feb 2020 09:33:07 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Thu, 6 Feb 2020 18:32:54 +0100
Message-ID: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
Subject: btrfs-scrub: slow scrub speed (raid5)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

when I run a scrub on my 5 disk raid5 array (data: raid5, metadata:
raid6) I notice very slow scrubbing speed: max. 5MB/s per device,
about 23-24 MB/s in sum (according to btrfs scrub status).

What's interesting is at the same time the gross read speed across the
involved devices (according to iostat) is about ~71 MB/s in sum (14-15
MB/s per device). Where are the remaining 47 MB/s going? I expect
there would be some overhead because it's a raid5, but it shouldn't be
much more than a factor of (n-1) / n , no? At the moment it appears to
be only scrubbing 1/3 of all data that is being read and the rest is
thrown out (and probably re-read again at a different time).

Surely this can't be right? Are iostat or possibly btrfs scrub status
lying to me? What am I seeing here? I've never seen this problem with
scrubbing a raid1, so maybe there's a bug in how scrub is reading data
from raid5 data profile?

Just to be clear: I can read data from the array in regular file
system usage much faster - it's just the scrub that's very slow for
some reason:

ionice -c idle dd if=3D/mnt/raid5/testfile.mkv bs=3D1M of=3D/dev/null
7876+1 records in
7876+1 records out
8258797247 bytes (8.3 GB, 7.7 GiB) copied, 63.2118 s, 131 MB/s

It seems to me that I could perform a much faster scrub by rsyncing
the whole fs into /dev/null... btrfs is comparing the checksums anyway
when reading data, no?


Best regards,

Sebastian


~ =C2=BB btrfs --version
btrfs-progs v5.4.1

kernel version: 5.5.2
