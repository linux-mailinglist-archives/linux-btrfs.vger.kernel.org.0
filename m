Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DE6E75BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjDSIzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjDSIzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 04:55:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A364C2C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 01:55:40 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a603577a89so183668a34.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681894539; x=1684486539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqg+Jt0G3uYbcy+yyFmfvd3Ybi3KkDaw1aHHsoBSQbQ=;
        b=bAICi/kGdv3HRVGa6OKvKA5ZshcHfhPY4j0fXK6+/K+3mEwAgxrJmaXRVKPDd8Utf3
         ypNsRzet23jr3AemxWy97u+M0Haejz/Fqx3xJlh0vtlb6DOtW9yki6IR/LEfjKlaoBvE
         Pq6b70dw9sKjWaJKsW50Ngr5SKAdoF/kV9g4VXpHUR+Tm5F2QncYwOCYBrad422JajP/
         uRS8h2WbLYAGlylY7TvlHSuuoyiuZSb41ik5LDT1VgtnwXWdE+Hc5pWkiQDEIIRBRuJC
         ZQRWj4oj3sNU4jY/gL1VgNg0Vz3AhyRY7r3NfetOWTyb8gnCwauxS8v8yQcKVANhR6nO
         Pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894539; x=1684486539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqg+Jt0G3uYbcy+yyFmfvd3Ybi3KkDaw1aHHsoBSQbQ=;
        b=jO7yiIaWRcJGpAkuxLv99jvtWHYdvPnJybhpjroDtRqXMKymDqOjpWMhbFJt+GNz/E
         zCUKbNrml4uijLp+xajfb37jZe2kKpGs4YDKCcE4/I9+pWCz3nPZczkUoIdHdTplfjAj
         HP7CGyEbBRs9WDTXDnUsrD3UNSEv8f9RMH79bWVmQ4d4vpjoXomEIvcx+5ja0uygVB89
         YOrNSxAn9PC2yIo8u0bU2MIxa8VLCnTzU61ebwMSOxyum3TV6v3/QH9hKHYN0/NZGmsP
         E1n9hdC+w1QDjCv+FblSLxq8/gN6YO3RTVJ7iggofizVFXFin+ZLA/Ena19/VGIQMc2D
         zR6g==
X-Gm-Message-State: AAQBX9e/72sskBdYnAY4upgXHJf9CC+P8X+szyMSHezCrk7jI9J5hEd/
        kJxeHBvMPxyZkV2EJnTF2WuAEKFSl5GPGU+WYr0=
X-Google-Smtp-Source: AKy350bzlVLublVincTciaD9U0vPBYcCZwU5qD/vqmrxG8XuzH0hnvQYbFBn6LiT8XpopR5H5x1K60Ur8Og1GRh9REg=
X-Received: by 2002:a05:6871:203:b0:184:1eea:aace with SMTP id
 t3-20020a056871020300b001841eeaaacemr11126854oad.2.1681894539668; Wed, 19 Apr
 2023 01:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230417094810.42214-1-wqu@suse.com> <20230418235505.GU19619@twin.jikos.cz>
In-Reply-To: <20230418235505.GU19619@twin.jikos.cz>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 19 Apr 2023 11:55:28 +0300
Message-ID: <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path resolution
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Torstein Eide <torsteine@gmail.com>
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

On Wed, Apr 19, 2023 at 3:24=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
> > [BUG]
> > There is a bug report that "btrfs inspect logical-resolve" can not even
> > handle any file inside non-top-level subvolumes:
> >
> >  # mkfs.btrfs $dev
> >  # mount $dev $mnt
> >  # btrfs subvol create $mnt/subv1
> >  # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
> >  # sync
> >  # btrfs inspect logical-resolve 13631488 $mnt
> >  inode 257 subvol subv1 could not be accessed: not mounted
> >
> > This means the command "btrfs inspect logical-resolve" is almost useles=
s
> > for resolving logical bytenr to files.
> >
> > [CAUSE]
> > "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
> > root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
> > to the subvolume.
> >
> > Then to handle cases where the subvolume is already mounted somewhere
> > else, we call find_mount_fsroot().
> >
> > But if that target subvolume is not yet mounted, we just error out, eve=
n
> > if the @path is the top-level subvolume, and we have already know the
> > path to the subvolume.
> >
> > [FIX]
> > Instead of doing unnecessary subvolume mount point check, just require
> > the @path to be the mount point of the top-level subvolume.
>
> This is a change in the semantics of the command, can't we make it work
> on non-toplevel subvolumes instead? Access to the mounted toplevel
> subvolume is not always provided, e.g. on openSUSE the subvolume layout
> does not mount 5 and there are likely other distros following that
> scheme.

The BTRFS_IOC_INO_PATHS ioctl used to map inode number to path expects
opened file on subvolume as argument and it is not possible unless
subvolume is accessible. So either different ioctl is needed that
takes subvolume is/name as argument or command has to mount subvolume
temporarily if it is not available.
