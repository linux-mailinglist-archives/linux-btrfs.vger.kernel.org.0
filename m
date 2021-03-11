Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC33379E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhCKQsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 11:48:15 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:49734 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKQsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 11:48:01 -0500
Date:   Thu, 11 Mar 2021 16:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fomin.one;
        s=protonmail3; t=1615481277;
        bh=8z4oCF/Cxpc3mG5/bI3kpA/G+lREs3qwLwFBxtl2/kM=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=L+XQq6J4j5K8KbYF99sfbT/1MdN6gWFKlt23kT8yujVvoZw5oUiKxbHNy7LbPE7FD
         kUFOjX4ZA0XhOJO65iIevEd6HEdYEhU2Id9gnATe+BNDcQQc2XlcwxV0MXmEE01TfA
         NoB6P0IoXAXV8jwHYico5KEMMRsyOnmheKzKummCoArp7TSV67ApQYln4BZaU2Sa5b
         yQ9au8zxLwHTD7xUz3rPWcDegTqJXQx6RoguWD/RZQ2XU9aZMcOt19ebWNnWYfSqHT
         gCcjI/Dc5A2AgUGFCoUF9hNfWk3D6ngtvg4QoMvnthc5xODS9f9aJMC88RuUL4fqzk
         FAp5RCoEOyCoA==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Maksim Fomin <maxim@fomin.one>
Reply-To: Maksim Fomin <maxim@fomin.one>
Subject: Multiple files with the same name in one directory
Message-ID: <gpmixArD-r8A5adzNpKZzMuEXbuhabkOg1kZECF3t4fL1PWIXuqKVfHKOEnkng0Geku1USZskpjNvrDdgce0y-96ADaSbTYPdbE-7HSKUX0=@fomin.one>
In-Reply-To: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
References: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 10 March 2021 =D0=B3., 20:15, Martin Raiber <martin@urbackup.=
org> wrote:

> Hi,
>
> I have this in a btrfs directory. Linux kernel 5.10.16, no errors in dmes=
g, no scrub errors:
>
> ls -lh
> total 19G
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 783 Mar 10 14:56 disk_config.dat
> ...
>
> disk_config.dat gets written to using fsync rename ( write new version to=
 disk_config.dat.new, fsync disk_config.dat.new, then rename to disk_config=
.dat -- it is missing the parent directory fsync).
>
> So far no negative consequences... (except that programs might get confus=
ed).
>
> echo 3 > /proc/sys/vm/drop_caches doesn't help.
>
> Regards,
> Martin Raiber

I can say that approx 1 month ago I also was surprised by having several fi=
les with duplicate names (listed by pcmanfm file manager and ls in console)=
. In my case I had duplicates for several different files in one folder, no=
t 10 copies of one file. I resolved the problem by renaming files and delet=
ing duplicates. I decided not to report that issue because I thought I have=
 unintentionally done something crazy. Btw, they likely occured also after =
power loss.

Regards,
Maxim Fomin
