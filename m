Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072C4174DA5
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCAOZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 09:25:54 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:17653 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgCAOZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 09:25:54 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7FAE8400CB9DF
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2020 08:25:53 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8PXVj7gHXvBMd8PXVj2jy0; Sun, 01 Mar 2020 08:25:53 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AUrtEFgp/70qhN3fiFFPQFB5lflWLoI04+/oOBRU/ck=; b=hYeF+Q1Y2EyBl1Q3ezfSoSv+zK
        k1dSeCNhBI4uUvEPUzOe2bExQQR99dHQbsvvMX7Vy0kRPLb5VTLAvFEuPMvH4YwlTYeTe9/AX79ZS
        6mCH4h5nHFvlzNenrPoBapJMoA0RbhkWYkVWZu60VsGGdct8j4SAAenO51JgJdo10TIB0Wh3tWIDQ
        WHBHI2YFdo0wn3/VUp51EWiXYw6b85/C+z0MbUduNBLtXdMQHeWxRm8wbu2KzsAc1PoeY9/4qYWLT
        Tj8GaAuSw3by1rK0C8+e//tjmeANJLbY72B83WmvELaQ8GYy6/DPYueMr/JJTlJen00svx1ymPhaM
        cHTchyfw==;
Received: from 189.26.179.234.dynamic.adsl.gvt.net.br ([189.26.179.234]:40154 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8PXU-003mPJ-Ss; Sun, 01 Mar 2020 11:25:53 -0300
Message-ID: <7a2549f38537c5a0f9262ae5e7aefd82e8464fb0.camel@mpdesouza.com>
Subject: Re: [PATCH 1/3] progs: Remove manpages of not packaged binaries
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Date:   Sun, 01 Mar 2020 11:28:55 -0300
In-Reply-To: <e8a6bb6a-5c8b-5898-d00a-39a739816664@gmx.com>
References: <20200301033344.808-1-marcos@mpdesouza.com>
         <20200301033344.808-2-marcos@mpdesouza.com>
         <e8a6bb6a-5c8b-5898-d00a-39a739816664@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.179.234
X-Source-L: No
X-Exim-ID: 1j8PXU-003mPJ-Ss
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.179.234.dynamic.adsl.gvt.net.br ([192.168.0.172]) [189.26.179.234]:40154
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 1
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 2020-03-01 at 16:26 +0800, Qu Wenruo wrote:
> 
> On 2020/3/1 上午11:33, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > btrfs-find-root and btrfs-select-super stopped to be shipped in
> 2014, so
> > remove all references to these manpages as well.
> 
> Nope, my distro is still shipping it, and I find it kinda useful for
> certain recovery scenario.
> 
> Thus it's better to keep their documents.

Thanks for checking this Qu. What do you think about the other two
patches?

David, do you think you can only patches 2 and 3? The first patch can
be skipped, since only the later two solve the issue.

Thanks,
  Marcos

> 
> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  .gitignore                                |  2 -
> >  Documentation/Makefile.in                 |  2 -
> >  Documentation/btrfs-find-root.asciidoc    | 35 -----------------
> >  Documentation/btrfs-select-super.asciidoc | 46 -----------------
> ------
> >  Documentation/btrfs.asciidoc              |  2 -
> >  5 files changed, 87 deletions(-)
> >  delete mode 100644 Documentation/btrfs-find-root.asciidoc
> >  delete mode 100644 Documentation/btrfs-select-super.asciidoc
> > 
> > diff --git a/.gitignore b/.gitignore
> > index aadf9ae7..2b1c1aef 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -73,7 +73,6 @@
> >  /Documentation/btrfs-convert.8
> >  /Documentation/btrfs-device.8
> >  /Documentation/btrfs-filesystem.8
> > -/Documentation/btrfs-find-root.8
> >  /Documentation/btrfs-image.8
> >  /Documentation/btrfs-inspect-internal.8
> >  /Documentation/btrfs-ioctl.3
> > @@ -87,7 +86,6 @@
> >  /Documentation/btrfs-rescue.8
> >  /Documentation/btrfs-restore.8
> >  /Documentation/btrfs-scrub.8
> > -/Documentation/btrfs-select-super.8
> >  /Documentation/btrfs-send.8
> >  /Documentation/btrfs-subvolume.8
> >  /Documentation/btrfs.8
> > diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
> > index d35cb858..ff0459c0 100644
> > --- a/Documentation/Makefile.in
> > +++ b/Documentation/Makefile.in
> > @@ -4,10 +4,8 @@ MAN8_TXT =
> >  # Top level commands
> >  MAN8_TXT += btrfs.asciidoc
> >  MAN8_TXT += btrfs-convert.asciidoc
> > -MAN8_TXT += btrfs-find-root.asciidoc
> >  MAN8_TXT += btrfs-image.asciidoc
> >  MAN8_TXT += btrfs-map-logical.asciidoc
> > -MAN8_TXT += btrfs-select-super.asciidoc
> >  MAN8_TXT += btrfstune.asciidoc
> >  MAN8_TXT += fsck.btrfs.asciidoc
> >  MAN8_TXT += mkfs.btrfs.asciidoc
> > diff --git a/Documentation/btrfs-find-root.asciidoc
> b/Documentation/btrfs-find-root.asciidoc
> > deleted file mode 100644
> > index 652796c8..00000000
> > --- a/Documentation/btrfs-find-root.asciidoc
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -btrfs-find-root(8)
> > -==================
> > -
> > -NAME
> > -----
> > -btrfs-find-root - filter to find btrfs root
> > -
> > -SYNOPSIS
> > ---------
> > -*btrfs-find-root* [options] <device>
> > -
> > -DESCRIPTION
> > ------------
> > -*btrfs-find-root* is used to find the satisfied root, you can
> filter by
> > -root tree's objectid, generation, level.
> > -
> > -OPTIONS
> > --------
> > --a::
> > -Search through all metadata extents, even the root has been
> already found.
> > --g <generation>::
> > -Filter root tree by it's original transaction id, tree root's
> generation in default.
> > --o <objectid>::
> > -Filter root tree by it's objectid,tree root's objectid in default.
> > --l <level>::
> > -Filter root tree by B-+ tree's level, level 0 in default.
> > -
> > -EXIT STATUS
> > ------------
> > -*btrfs-find-root* will return 0 if no error happened.
> > -If any problems happened, 1 will be returned.
> > -
> > -SEE ALSO
> > ---------
> > -`mkfs.btrfs`(8)
> > diff --git a/Documentation/btrfs-select-super.asciidoc
> b/Documentation/btrfs-select-super.asciidoc
> > deleted file mode 100644
> > index e3bca98b..00000000
> > --- a/Documentation/btrfs-select-super.asciidoc
> > +++ /dev/null
> > @@ -1,46 +0,0 @@
> > -btrfs-select-super(8)
> > -=====================
> > -
> > -NAME
> > -----
> > -btrfs-select-super - overwrite primary superblock with a backup
> copy
> > -
> > -SYNOPSIS
> > ---------
> > -*btrfs-select-super* -s number <device>
> > -
> > -DESCRIPTION
> > ------------
> > -Destructively overwrite all copies of the superblock
> > -with a specified copy.  This helps in certain cases, for example
> when write
> > -barriers were disabled during a power failure and not all
> superblocks were
> > -written, or if the primary superblock is damaged, eg. accidentally
> overwritten.
> > -
> > -The filesystem specified by 'device' must not be mounted.
> > -
> > -NOTE: *Prior to overwriting the primary superblock, please make
> sure that the backup
> > -copies are valid!*
> > -
> > -To dump a superblock use the *btrfs inspect-internal dump-super*
> command.
> > -
> > -Then run the check (in the non-repair mode) using the command
> *btrfs check -s*
> > -where '-s' specifies the superblock copy to use.
> > -
> > -Superblock copies exist in the following offsets on the device:
> > -
> > -- primary: '64KiB' (65536)
> > -- 1st copy: '64MiB' (67108864)
> > -- 2nd copy: '256GiB' (274877906944)
> > -
> > -A superblock size is '4KiB' (4096).
> > -
> > -OPTIONS
> > --------
> > --s|--super <superblock>::
> > -use 'superblock'th superblock copy, valid values are 0 1 or 2 if
> the
> > -respective superblock offset is within the device size
> > -
> > -SEE ALSO
> > ---------
> > -`btrfs-inspect-internal`(8),
> > -`btrfsck check`(8)
> > diff --git a/Documentation/btrfs.asciidoc
> b/Documentation/btrfs.asciidoc
> > index 1625f6d8..e3328942 100644
> > --- a/Documentation/btrfs.asciidoc
> > +++ b/Documentation/btrfs.asciidoc
> > @@ -115,8 +115,6 @@ Tools that are still in active use without an
> equivalent in *btrfs*:
> >  
> >  *btrfs-convert*:: in-place conversion from ext2/3/4 filesystems to
> btrfs
> >  *btrfstune*:: tweak some filesystem properties on a unmounted
> filesystem
> > -*btrfs-select-super*:: rescue tool to overwrite primary superblock
> from a spare copy
> > -*btrfs-find-root*:: rescue helper to find tree roots in a
> filesystem
> >  
> >  Deprecated and obsolete tools:
> >  
> > 
> 

