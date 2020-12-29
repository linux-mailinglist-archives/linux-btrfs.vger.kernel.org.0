Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36292E6F54
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 10:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgL2J1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 04:27:49 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:56068 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725964AbgL2J1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 04:27:48 -0500
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id 7E8401C8;
        Tue, 29 Dec 2020 10:27:05 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1609234025;
        bh=pTPzY50K3PgtBunsM8BahtFsD0Ja2Yy83ct4Pfsc3zQ=;
        h=Date:From:Subject:To:In-Reply-To:References;
        b=UG4raLSuH0HQt5FZam3CpXO/8y9qYO7jHxjaJe8YdM3OSj75JWaQCos7zKIc0GE7V
         Mqgb12fUjefp6QodtttaTiZi6zWXzTW+fGBJXKr416OzaH283rtE7WRvulaJ+oZm8I
         LmJYP3oFS3NlL2YCj7FfRKjcNtCKaDsguE6Wxy0Y=
MIME-Version: 1.0
Date:   Tue, 29 Dec 2020 09:27:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs2@lesimple.fr>
Message-ID: <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: output warning message for
 leftover v1 space cache before aborting current data balance
To:     "Qu Wenruo" <wqu@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20201229003837.16074-1-wqu@suse.com>
References: <20201229003837.16074-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

December 29, 2020 1:38 AM, "Qu Wenruo" <wqu@suse.com> wrote:=0A=0A> In de=
lete_v1_space_cache(), if we find a leaf whose owner is tree root,=0A> an=
d we can't grab the free space cache inode, then we return -ENOENT.=0A> =
=0A> However this would make the caller, add_data_references(), to consid=
er=0A> this as a critical error, and abort current data balance.=0A> =0A>=
 This happens for fs using free space cache v2, while still has v1 data=
=0A> left.=0A> =0A> For v2 free space cache, we no longer load v1 data, m=
aking btrfs_igrab()=0A> no longer work for root tree to grab v1 free spac=
e cache inodes.=0A> =0A> The proper fix for the problem is to delete v1 s=
pace cache completely=0A> during v2 convert.=0A> =0A> We can't just ignor=
e the -ENOENT error, as for root tree we don't use=0A> reloc tree to repl=
ace its data references, but rely on COW.=0A> This means, we have no way =
to relocate the leftover v1 data, and block=0A> the relocation.=0A> =0A> =
This patch will just workaround it by outputting a warning message,=0A> s=
howing the user how to manually solve it.=0A> =0A> Reported-by: St=C3=A9p=
hane Lesimple <stephane_btrfs2@lesimple.fr>=0A> Signed-off-by: Qu Wenruo =
<wqu@suse.com>=0A=0AYour analysis seems correct, as this FS is quite old =
(several years),=0Aand has seen quite a number of kernel versions! I conv=
erted it to=0Aspace_cache v2 ~6-12 months ago I think. It does has v1 lef=
tovers:=0A=0A# btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | =
grep EXTENT_DA=0Aitem 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize =
53=0Aitem 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53=0Aitem 2=
5 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53=0A=0AWhat's interes=
ting also is that a FS I created only a few weeks ago,=0Aunder kernel 5.6=
.17, also has v1 leftovers, as per the above command.=0ASo the issue migh=
t be more common than we think (not just years-old FS).=0A=0ABefore fixin=
g the FS I can't balance, I wanted to test your patch,=0Aeven if it's pre=
tty straightforward, just to be sure:=0A=0A# btrfs bal start -dvrange=3D3=
4625344765952..34625344765953 /tank=0AERROR: error during balancing '/tan=
k': No such file or directory=0AThere may be more info in syslog - try dm=
esg | tail=0A=0A[   76.114187] BTRFS info (device dm-10): balance: start =
-dvrange=3D34625344765952..34625344765953=0A[   76.122792] BTRFS info (de=
vice dm-10): relocating block group 34625344765952 flags data|raid1=0A[  =
 87.065468] BTRFS info (device dm-10): found 167 extents, stage: move dat=
a extents=0A[   87.685571] BTRFS warning (device dm-10): leftover v1 spac=
e cache found, please use btrfs-check --clear-space-cache v1 to clean it =
up=0A[  100.018692] BTRFS info (device dm-10): balance: ended with status=
: -2=0A=0ASo, it works. You can add my Tested-By.=0A=0ARegards,=0A=0ASt=
=C3=A9phane.
