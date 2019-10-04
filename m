Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8BCBCC3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfJDONR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 10:13:17 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34298 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbfJDONQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 10:13:16 -0400
Received: by mail-vs1-f66.google.com with SMTP id d3so4227514vsr.1
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3K3Mka3BoLBLw5PlY/iyIdKZbNQnw7d04RyzF4xN1U4=;
        b=ZcgoEPzW/+9972yOCdIgs2rWEtlLNYpy0KVXcxaomkhrffUIdAC/NHYdkziSGbzJhF
         9YQkCmsVGl3zx6z5NlxG408OHGv+91lLZhK4dmrZnMJ8StxBaG0ZFg2LfWIrdwItdpC4
         QrpJxI/HB+JBV4+1dTTmKRQTKGmBF+dNa4jesRs2RZWz9/vMftzW4epnlhnFfl5/Duou
         ArsljNXkfzrgekVGtuD9PwKeC2WUBlQbRYO6gLyN2Z/TGBAMYZOtkaCgiNm754A+5+8i
         ouHlk/eTI+ehtZQFOIoVMfThcaWJML3M48RQsr5OFlRsUasl9NWT4vcpUSCBVMFlfJvK
         2dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3K3Mka3BoLBLw5PlY/iyIdKZbNQnw7d04RyzF4xN1U4=;
        b=XTo5Y5Z0N0Pw/aLUjFk8dfWr/TatMZUrblLYVDD4tl3ApmBSiOax9G34jc5J2n7ZrR
         8kqVl56vBUIfAp0PnN0D5Uq9COKJVpujBCMTlvETFQ6HgQ/tYwYzEE82sJWd8f2+khvk
         nhWR+Dt4LKUknMfySaFElyqGRo0x+YxuEXAZ2RqxRa9FK9YlsARrDcbedzcynW2ZsUxa
         aVvEKCCM0BzaFydGV3zktYTtimakIasBD23FjXMOlI2/9zKnOKWmcdmWJmgmwy9hXLVh
         8evIhKU/auyZzpfNH8cbCAY8fvgyNEWDmt7rRxx/bPeOq9wHn1yqvt32Ljg6olwriXA2
         vCGw==
X-Gm-Message-State: APjAAAVe7aaBeQOiIzQ8UyusYjEWZ5cCCcEpsRBBBQivUje7rvD67H0/
        AGGc00KEj2CjX6OYKKZBVTQKftPLUTNVdsNfyen05Dld
X-Google-Smtp-Source: APXvYqxXLQ6ifudkydzEiiFG1XWYmujGbLY8Iuz4N2qVuxHo0Cq+BAEzi3KY4YdmMNARD3WzKqPvmcvYrTivKUrWijA=
X-Received: by 2002:a67:bc15:: with SMTP id t21mr7915261vsn.90.1570198393810;
 Fri, 04 Oct 2019 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191004093133.83582-1-wqu@suse.com> <20191004093133.83582-2-wqu@suse.com>
 <4e1e4ffd-c8c1-0d02-d8a0-ebdb4deabe4c@suse.com>
In-Reply-To: <4e1e4ffd-c8c1-0d02-d8a0-ebdb4deabe4c@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Oct 2019 15:13:02 +0100
Message-ID: <CAL3q7H43Qsz9cy_EULphP=L=FjpPpiY2KwScHYCSbncJogujjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Fix false alerts on log trees
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 4, 2019 at 2:54 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 4.10.19 =D0=B3. 12:31 =D1=87., Qu Wenruo wrote:
> > [BUG]
> > When running btrfs/063 in a loop, we got the following random write tim=
e
> > tree checker error:
> >
> >   BTRFS critical (device dm-4): corrupt leaf: root=3D184467440737095516=
10 block=3D33095680 slot=3D2 ino=3D307 file_offset=3D0, invalid previous ke=
y objectid, have 305 expect 307
> >   BTRFS info (device dm-4): leaf 33095680 gen 7 total ptrs 47 free spac=
e 12146 owner 18446744073709551610
> >   BTRFS info (device dm-4): refs 1 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) l=
ock_owner 0 current 26176
> >           item 0 key (305 1 0) itemoff 16123 itemsize 160
> >                   inode generation 0 size 0 mode 40777
> >           item 1 key (305 12 257) itemoff 16111 itemsize 12
> >           item 2 key (307 108 0) itemoff 16058 itemsize 53 <<<
> >                   extent data disk bytenr 0 nr 0
> >                   extent data offset 0 nr 614400 ram 671744
> >           item 3 key (307 108 614400) itemoff 16005 itemsize 53
> >                   extent data disk bytenr 195342336 nr 57344
> >                   extent data offset 0 nr 53248 ram 57344
> >           item 4 key (307 108 667648) itemoff 15952 itemsize 53
> >                   extent data disk bytenr 194048000 nr 4096
> >                   extent data offset 0 nr 4096 ram 4096
> >         [...]
> >   BTRFS error (device dm-4): block=3D33095680 write time tree block cor=
ruption detected
> >   BTRFS: error (device dm-4) in btrfs_commit_transaction:2332: errno=3D=
-5 IO failure (Error while writing out transaction)
> >   BTRFS info (device dm-4): forced readonly
> >   BTRFS warning (device dm-4): Skipping commit of aborted transaction.
> >   BTRFS info (device dm-4): use zlib compression, level 3
> >   BTRFS: error (device dm-4) in cleanup_transaction:1890: errno=3D-5 IO=
 failure
> >
> > [CAUSE]
> > Commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_=
ITEM")
> > assumes all XATTR_ITEM/DIR_INDEX/DIR_ITEM/INODE_REF/EXTENT_DATA items
> > should have previous key with the same objectid as ino.
> >
> > But it's only true for fs trees. For log-tree, we can get above log tre=
e
> > block where an EXTENT_DATA item has no previous key with the same ino.
> > As log tree only records modified items, it won't record unmodified
> > items like INODE_ITEM.
> >
> > So this triggers write time tree check warning.
> >
> > [FIX]
> > As a quick fix, check header owner to skip the previous key if it's not
> > fs tree (log tree doesn't count as fs tree).
> >
> > This fix is only to be merged as a quick fix.
> > There will be a more comprehensive fix to refactor the common check int=
o
> > one function.
> >
> > Reported-by: David Sterba <dsterba@suse.com>
> > Fixes: 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_=
ITEM")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
> It's not entirely clear why this bug manifests. My tests show that when
> we write extents we always update the inode's c/m time so it's always
> dirtied hence it's logged. OTOH when punching a hole the same thing is
> valid.
>
> Filipe, under what conditions should it be possible to log an
> EXTENT_DATA item without first logging the inode it belongs to? It seems
> using the usual write paths (e.g. buffered write and punchole) that's
> impossible?

The tests you did are pointless, none of those operations write to a
log tree, only fsync does that.

This change is perfectly fine. Logging (fsync) always logs the inode
item since commit [1] (2015),
however it might do so after logging extents and other items, and in
between that, if writeback for
the log tree leaf happens we get that error from the tree-checker.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De4545de5b035c7debb73d260c78377dbb69cbfb5

>
> > ---
> >  fs/btrfs/tree-checker.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index b8f82d9be9f0..5e34cd5e3e2e 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -148,7 +148,8 @@ static int check_extent_data_item(struct extent_buf=
fer *leaf,
> >        * But if objectids mismatch, it means we have a missing
> >        * INODE_ITEM.
> >        */
> > -     if (slot > 0 && prev_key->objectid !=3D key->objectid) {
> > +     if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> > +         prev_key->objectid !=3D key->objectid) {
> >               file_extent_err(leaf, slot,
> >               "invalid previous key objectid, have %llu expect %llu",
> >                               prev_key->objectid, key->objectid);
> > @@ -322,7 +323,8 @@ static int check_dir_item(struct extent_buffer *lea=
f,
> >       u32 cur =3D 0;
> >
> >       /* Same check as in check_extent_data_item() */
> > -     if (slot > 0 && prev_key->objectid !=3D key->objectid) {
> > +     if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> > +         prev_key->objectid !=3D key->objectid) {
> >               dir_item_err(leaf, slot,
> >               "invalid previous key objectid, have %llu expect %llu",
> >                            prev_key->objectid, key->objectid);
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
