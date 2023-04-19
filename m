Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF66E7786
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDSKiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjDSKho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 06:37:44 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A06210D
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 03:37:35 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-54709179b2cso57717eaf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681900654; x=1684492654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY1Z3esfT6/vidjCI5aNiq+dmHcORpYNxRMN5sBBW08=;
        b=m0p94UrxlnkZJBXyJn0/p2CHHRmlnhOgMhaxYr1aG/F19PW7ounSG4iCGgUDKkI72g
         eZT34dSpQ01VQzXDYCxPCeiuk6b9MkfNnS4fJSghJ1awLDOcQSUfXN9PiWeX3u1HYq9F
         ZdElrYAbW4du989KSKp7UNaR7cHrlr6LY27e7vbGJ2ufEN2bJ6XzSqJpqFMxobTS4Vmi
         x5HOEQ7Z/4q7BAnzbu8sqRnFZ1UMMgYMSQ9scnNJXvN19fQ77nZYmCxx8eth6v6j7xqa
         3MwiE4Cy5SLjPvHMbGDql+RpwQNDHHe+yYpesRPie5UMGeFbq41H1KdOu8jZddo7T55Y
         0kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900654; x=1684492654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY1Z3esfT6/vidjCI5aNiq+dmHcORpYNxRMN5sBBW08=;
        b=GqnfM10IY2+57Oso6+jrAOPnB6y+xN+D3AoAAAfJIZ3TDt/e73WDn7nOaHkLbF09Cv
         Fth76AauTpagBDo1Ii++DPATK/taE8Fxlv+muKsZ7GJfJzM9MB0BZ40XJ+haFu0m/bGH
         lxOhDf07AeQmU9UVMjhlMDVekpmN8Q81ZSzWZycYIslZMED9yPfTziEMRwr1wX+2ff0C
         PmXeIVFPkQxMVbMSqpyx4hH3GFpuwy5rKK/gcvi3BbQkNwlA8wKqqJX+xRhDW99dVZHr
         Vp5qKrCrcef7G1poFiA/uVPk+JlU3J7jeaI/PpjRKyUQveFIE5Tm6Dflb1q/90/xNAoH
         79QQ==
X-Gm-Message-State: AAQBX9eHpTwjsnbrspQQeYinbzQvA53O+QlT6qinJn6DB4AIvMqcErE+
        uue+MhcT2sFdmrperFrie3NSjyBHs2OHTQX5mMg=
X-Google-Smtp-Source: AKy350aIaB6Cnek23b79HvMYi1F9K+Q6EE2bhdX21DWPxUx5Y9wu+upelUYN45QesqSfZ/KOswzu3pT7d/kz3ZbA/KI=
X-Received: by 2002:a4a:a646:0:b0:546:fa38:9a2 with SMTP id
 j6-20020a4aa646000000b00546fa3809a2mr2409809oom.0.1681900654621; Wed, 19 Apr
 2023 03:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230417094810.42214-1-wqu@suse.com> <20230418235505.GU19619@twin.jikos.cz>
 <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com> <385910f0-abf2-618d-0955-3abee00daa5d@gmx.com>
In-Reply-To: <385910f0-abf2-618d-0955-3abee00daa5d@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 19 Apr 2023 13:37:23 +0300
Message-ID: <CAA91j0XYfgx19On0_NusCxBQUWAQ7b0BdzbBvV2WRj7Cn458XQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path resolution
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Torstein Eide <torsteine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 12:50=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> On 2023/4/19 16:55, Andrei Borzenkov wrote:
> > On Wed, Apr 19, 2023 at 3:24=E2=80=AFAM David Sterba <dsterba@suse.cz> =
wrote:
> >>
> >> On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
> >>> [BUG]
> >>> There is a bug report that "btrfs inspect logical-resolve" can not ev=
en
> >>> handle any file inside non-top-level subvolumes:
> >>>
> >>>   # mkfs.btrfs $dev
> >>>   # mount $dev $mnt
> >>>   # btrfs subvol create $mnt/subv1
> >>>   # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
> >>>   # sync
> >>>   # btrfs inspect logical-resolve 13631488 $mnt
> >>>   inode 257 subvol subv1 could not be accessed: not mounted
> >>>
> >>> This means the command "btrfs inspect logical-resolve" is almost usel=
ess
> >>> for resolving logical bytenr to files.
> >>>
> >>> [CAUSE]
> >>> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
> >>> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the pat=
h
> >>> to the subvolume.
> >>>
> >>> Then to handle cases where the subvolume is already mounted somewhere
> >>> else, we call find_mount_fsroot().
> >>>
> >>> But if that target subvolume is not yet mounted, we just error out, e=
ven
> >>> if the @path is the top-level subvolume, and we have already know the
> >>> path to the subvolume.
> >>>
> >>> [FIX]
> >>> Instead of doing unnecessary subvolume mount point check, just requir=
e
> >>> the @path to be the mount point of the top-level subvolume.
> >>
> >> This is a change in the semantics of the command, can't we make it wor=
k
> >> on non-toplevel subvolumes instead? Access to the mounted toplevel
> >> subvolume is not always provided, e.g. on openSUSE the subvolume layou=
t
> >> does not mount 5 and there are likely other distros following that
> >> scheme.
> >
> > The BTRFS_IOC_INO_PATHS ioctl used to map inode number to path expects
> > opened file on subvolume as argument and it is not possible unless
> > subvolume is accessible. So either different ioctl is needed that
> > takes subvolume is/name as argument or command has to mount subvolume
> > temporarily if it is not available.
>
> Nope, if you're at the toplevel subvolume, all subvolumes can be
> accessed, and btrfs_subvolid_resolve() gives us the path from TOP-LEVEL
> subvolume to the target one.
>
>

Sure. I was replying to "can we make it work on non-toplevel subvolume".
