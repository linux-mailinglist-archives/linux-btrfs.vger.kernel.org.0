Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E117442D9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfFLRhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 13:37:02 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33527 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbfFLRhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 13:37:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so10789488vsj.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EpU142YjVvjLqoID0092Rl9CHqfEjMX725fOf/hWruA=;
        b=PdokhQ+d7iqjjYqc3g5xclPyQFyrpo+2Gqak4e6jP3TXDNbCf+gwZrA8XnOVR9+DnU
         Jm6fDUWgg4jXjecN0jOk83Za3IO3mpNDyhxiiKgffDD7RHXU9JxJunK9QWpfT8Wmf5EY
         ZY5jsu9fx9IgKjc2QQFJcIZbgyMazummFxtp2QmPzBSagPy2/eAQkuJDsa1pFhgw+28P
         HmQZYj0hWdO4bAwafvlJK4MHfYZveHGrri4bBVbnt17VlW6RyTDm4f1eAzoe+MXH9ysE
         8H2hnHz2WDMbaDZdi4rkawhxXiENXqRdvtNfF4ByfZcDcS2KiL2C8eS7Sbv9DTfBkhYn
         1a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EpU142YjVvjLqoID0092Rl9CHqfEjMX725fOf/hWruA=;
        b=ctVItNzbqEFmLoU5YhG6IlY3CamVTgIyjGwijYLbP6ukSbn0BxHUIXCPgGBoFgGFP8
         2y9d+aZUSNopGV7TkRWJUCip1hLzWJnahwQ8em/5MfkMcky2NH5dz7DoXpCvw1z6D8wj
         YUK80G1NYIERRiwiVnnNShiPTEc5zkd+BySDtjidzjFLrvr9gAcjP5niWz3T7ZGYS7TM
         8OzxhTbX0i0ecEkKxvFIRewY01leNvPlFSp/mtreTOvLHCLap9KRjyDD/fg22cj1jwpY
         EwE9p9w5iAIScFMdqNhol1ihOxOkucZSEiqHNv9/JRk/3HBp08F7234Rzy0vxsVgY3u+
         5LzQ==
X-Gm-Message-State: APjAAAWW18GmURTBjwGRQrdU9UyALWSjxVOJFmz07/kVimFIfgXSgOIF
        mMzy6kjxZ8cP5OJpSqBQXc0A8j2dVOSbi4rfXx06tCcEid4=
X-Google-Smtp-Source: APXvYqxpW6bB08RG9+ATSgMHzX8pDTUVPSNqZrKD7ErQW/ZzehdCourKl6QSI5saGkb7+kLh0qduKDbnqLQWsGweAow=
X-Received: by 2002:a67:fb8d:: with SMTP id n13mr29440047vsr.46.1560361020942;
 Wed, 12 Jun 2019 10:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190611164740.14472-1-dsterba@suse.com> <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
 <66406cde-c497-763a-68d6-9c21673108ac@gmx.com> <20190612144533.GN3563@twin.jikos.cz>
In-Reply-To: <20190612144533.GN3563@twin.jikos.cz>
From:   =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Date:   Wed, 12 Jun 2019 18:36:34 +0100
Message-ID: <CABB28CwrH4k2MP9tR7B2mVXjQuemYUFo-y36WfRDmKW44p_skQ@mail.gmail.com>
Subject: Re: Btrfs progs release 5.1.1
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Linux fs Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 12 Jun 2019 at 15:44, David Sterba <dsterba@suse.cz> wrote:
[..]
> Tomas, can you please run the tests with the following diff:
[..]
> This should dump all potential holders of the mount path when the umount
> fails. I've tested here by cd'ing into the mount directory right after
> the test starts and get something like this in the results:
>
>   =3D=3D=3D=3D=3D=3D RUN CHECK root_helper fallocate -l 4k .../btrfs-prog=
s/tests//mnt/file.2779
>   =3D=3D=3D=3D=3D=3D RUN CHECK root_helper fallocate -l 4k .../btrfs-prog=
s/tests//mnt/file.2319
>   =3D=3D=3D=3D=3D=3D RUN MAYFAIL root_helper umount .../btrfs-progs/tests=
//test.img
>   umount: .../btrfs-progs/tests/mnt: target is busy.
>   failed (ignored, ret=3D32): root_helper umount .../btrfs-progs/tests//t=
est.img
>   =3D=3D=3D=3D=3D=3D RUN CHECK root_helper lsof .../btrfs-progs/tests//mn=
t
>   bash    7777 dsterba  cwd    DIR   0,68    51840  256 .../btrfs-progs/t=
ests//mnt
>   umount on .../btrfs-progs/tests//mnt failed
>   test failed for case 037-freespacetree-repair

    [TEST/fsck]   037-freespacetree-repair
failed: root_helper lsof
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
test failed for case 037-freespacetree-repair
make: *** [Makefile:352: test-fsck] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.gAtTfC (%check)

in test suite log I found only:

=3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount -t btrfs -o loop
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
=3D=3D=3D=3D=3D=3D RUN CHECK root_helper fallocate -l 50m
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt/file
=3D=3D=3D=3D=3D=3D RUN MAYFAIL root_helper umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
umount: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests/mnt:
target is busy.
failed (ignored, ret=3D32): root_helper umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
=3D=3D=3D=3D=3D=3D RUN CHECK root_helper lsof
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/1000/gvfs
      Output information may be incomplete.
failed: root_helper lsof
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
test failed for case 037-freespacetree-repair

kloczek
--=20
Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH
