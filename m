Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B26E76BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjDSJu0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjDSJuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 05:50:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608C41387E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 02:50:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so41172816ejz.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681897821; x=1684489821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWNmBbyACuy4bGzJRiIpcZxhN0iokKBRp7Abd5vCMTM=;
        b=UfzNnm3NqnYgQ/EgAbbRMbihofpMXQEKE5aqXxXpHLIiHiGm6eLv7D6tPoWnVe8q++
         ikXa5X71jm8ncSntkePYRBSt2/5b29OOgVb1telRC69x+xpSNsaoWDrdVljJSS0SFTh3
         ZFCK9p6KWdtE2sexC73PIJ/NDz3JQfcHHLhorfBRj34awzSOVbZ/tEasSoPh22qlvSIn
         aBcB/hFSEjCZym4ZqVtUBFbheyau+G6Rr8Ezt4hvQx7Xq4YfEydKQ5hc5NNC/zwjNQLS
         a2XBPn6BmY5YKvXjyN59fqzHS1va03QfkNj4SAuj9aiIacElN0RThfU5LMtGL/ywgw0w
         Sf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897821; x=1684489821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWNmBbyACuy4bGzJRiIpcZxhN0iokKBRp7Abd5vCMTM=;
        b=DCCTizv0ExPMwOstlLZG8wYR5ejSvle5s9Nic7iLC7xnDAACZuWb4EiYMzPAgn2HnK
         prncP4aUuvCNgYBnw+HoT9ujtbu6dxn7j4Ck3yQroSeO+IddYZmjPUw5JUPEtYAozniB
         bTEKD3Ak+7nE26qHseRaizMeoEHTvDUTpp8HLU/OPFDgo0P9yMEUOd9r+EYRzPd0y0oX
         MtXzruDwRWPnPd/TDP6hi8PtqqmwWSM3KyNb7W5K1TBby0OoytqPdt6ERNjgG8BamGdO
         DXbQY/nNqS2eKBN//jRFvUXQzHpUjIXVNS10e5+N+6hsiqjq0VxzGNp2IDhk3qWb8K6V
         Q9ZA==
X-Gm-Message-State: AAQBX9eYm9IYZDf1VvkIJbichbXjgA1aZaI9N7FoIXgUeWWrSAOaZF1W
        MxOVlYwGiceI9wcFoKiEXRLx948PSmoI8uJHQiE=
X-Google-Smtp-Source: AKy350YkKKW+ZVirXEnm1l5OTY0kKqjFqLepynk48OgiZSZvpIvxVTyu5Pfg0hIfkhoByl2QZt29lvqXhcb7aSnWJXI=
X-Received: by 2002:a17:906:c2d1:b0:92f:33ca:c9a3 with SMTP id
 ch17-20020a170906c2d100b0092f33cac9a3mr12760526ejb.71.1681897820558; Wed, 19
 Apr 2023 02:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230417094810.42214-1-wqu@suse.com> <20230418235505.GU19619@twin.jikos.cz>
 <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com>
In-Reply-To: <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Wed, 19 Apr 2023 11:50:08 +0200
Message-ID: <CAL5DHTGxSVhfhB15LMBg-h45UVpCeYY-PPYq0FEDhC_AbZCOXw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path resolution
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
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

As a user i think this result will be good:

(use -q for script use, print lists for 1, 2 ,and 4 )

1.  File is resolved in current mount path:
````
# ./btrfs inspect logical-resolve 13631488 $mnt
Files is accessible:
- /mnt/btrfs/subv1/file
- /mnt/btrfs/subv1/.snapshot/1/file


````

2.  File is not  in current mount path, but part of the volume:
````
# ./btrfs inspect logical-resolve 13631488 $mnt
Files is part subvolumes, but not accessible under current path:
-  subv1/file
-  snapshot1/file
````

3. Hybrid
````
# ./btrfs inspect logical-resolve 13631488 $mnt_snapshot
Files is accessible:
- /mnt/btrfs/subv1/.snapshot/1/file

Files is part subvolumes, but not accessible under current path:
-  subv1/file
````

4. List subvolumes a file is part of:
````
# ./btrfs inspect logical-resolve 13631488 $mnt --list-subvolumes
Filename:

Files is part subvolumes
- subv1  (subvolid 256)
- snapshot1 (subvolid 1025)
````

5.  failed
````
# ./btrfs inspect logical-resolve 1 $mnt --list-subvolumes
Error: logical address not in use.
````

ons. 19. apr. 2023 kl. 10:55 skrev Andrei Borzenkov <arvidjaar@gmail.com>:
>
> On Wed, Apr 19, 2023 at 3:24=E2=80=AFAM David Sterba <dsterba@suse.cz> wr=
ote:
> >
> > On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
> > > [BUG]
> > > There is a bug report that "btrfs inspect logical-resolve" can not ev=
en
> > > handle any file inside non-top-level subvolumes:
> > >
> > >  # mkfs.btrfs $dev
> > >  # mount $dev $mnt
> > >  # btrfs subvol create $mnt/subv1
> > >  # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
> > >  # sync
> > >  # btrfs inspect logical-resolve 13631488 $mnt
> > >  inode 257 subvol subv1 could not be accessed: not mounted
> > >
> > > This means the command "btrfs inspect logical-resolve" is almost usel=
ess
> > > for resolving logical bytenr to files.
> > >
> > > [CAUSE]
> > > "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
> > > root/ino pairs, then call btrfs_subvolid_resolve() to resolve the pat=
h
> > > to the subvolume.
> > >
> > > Then to handle cases where the subvolume is already mounted somewhere
> > > else, we call find_mount_fsroot().
> > >
> > > But if that target subvolume is not yet mounted, we just error out, e=
ven
> > > if the @path is the top-level subvolume, and we have already know the
> > > path to the subvolume.
> > >
> > > [FIX]
> > > Instead of doing unnecessary subvolume mount point check, just requir=
e
> > > the @path to be the mount point of the top-level subvolume.
> >
> > This is a change in the semantics of the command, can't we make it work
> > on non-toplevel subvolumes instead? Access to the mounted toplevel
> > subvolume is not always provided, e.g. on openSUSE the subvolume layout
> > does not mount 5 and there are likely other distros following that
> > scheme.
>
> The BTRFS_IOC_INO_PATHS ioctl used to map inode number to path expects
> opened file on subvolume as argument and it is not possible unless
> subvolume is accessible. So either different ioctl is needed that
> takes subvolume is/name as argument or command has to mount subvolume
> temporarily if it is not available.
