Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29FCBCCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfJDOQE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 10:16:04 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38561 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbfJDOQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 10:16:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id b123so4213735vsb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HLBvin4gATxgcC6dfsuq2UDU4Da5BCeGtTmG8HYcoOk=;
        b=F0DoLTV0PZyZ0jIjXWVYe8qPviKrulIDxr133EwiukgfAJhFnrKDzCG3ZbTooUj81e
         rr5JzmFSkoRM93A4dwWdSpd5wZ25zq09IyzDdVLYyTgU0cj5bFsP2Yk7lvns3neC0udz
         u/wJuiaAAk/uAGc+dRP10N35QpSrqL98S8Q3u3uZ2rIjH90F68/PX0HE7mYsyWZC4Sd/
         uvjxtkV8Z+iY1eHoHFtiEHYPvumDgzkP0Ry0eGLZa0rSgIGbh027o+sPyo+6mzWLo2ge
         9ml+RrHWfUiELmVT7mkULao56AzODe5F3PiIjjJ88m7Ss9avFBAiGInFYNBZRZHata7W
         K2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HLBvin4gATxgcC6dfsuq2UDU4Da5BCeGtTmG8HYcoOk=;
        b=Q+w9ZtAodz2yPRjBAjE05rL4984BjUELag9G4cqDHgJQMYO51Ar66iXt2UEdqwCYBB
         LIGH7veTFixFgsdemPbYJMGUQ5xSybWxsZ2oluCRU2E4/i79kSpzmKz5Y3spUd2Rnt+l
         cLbmw+X73Z1Fo0YvaJnTVpzS4GyKXhvFN1zF0303X1PnwSoARokPCOREu8SOfDbqOJVN
         IBIXKLfGf09NOPFP8MWVDWY57/u3UCVh0r2EkSe0LcZEsDYZCpckTwZLFKCnV7ojhzF1
         pwU2GKRF6xrAsVjlDpw/2pggG8+oNF/6THHlKL07q8V1uNlymjktQqRDTli9Md8ZDwKm
         NPBg==
X-Gm-Message-State: APjAAAXaMwUTC9qelvM1p1+Y1g0QR9EZjTFmdM1rN4yGHhjmmvyh6iP0
        syMOgEZ9fb/iOkFc+rpnoz2uWU9qLwVU7kCglXg=
X-Google-Smtp-Source: APXvYqz7+a4yAWmgbDPwQQZ8/BEjN4Nzo2HXpkHRmiYmRX7pj1rFnsAFNF93CWgoT3gN2NA8f3oy+OBclFcNe4caXao=
X-Received: by 2002:a67:6810:: with SMTP id d16mr8224363vsc.206.1570198562528;
 Fri, 04 Oct 2019 07:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191004093133.83582-1-wqu@suse.com> <20191004093133.83582-2-wqu@suse.com>
In-Reply-To: <20191004093133.83582-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Oct 2019 15:15:51 +0100
Message-ID: <CAL3q7H5TdwA5tJL-SFKGCozwexmhwWHnCvHgqucdmw=xB+MgCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Fix false alerts on log trees
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 4, 2019 at 11:27 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/063 in a loop, we got the following random write time
> tree checker error:
>
>   BTRFS critical (device dm-4): corrupt leaf: root=3D18446744073709551610=
 block=3D33095680 slot=3D2 ino=3D307 file_offset=3D0, invalid previous key =
objectid, have 305 expect 307
>   BTRFS info (device dm-4): leaf 33095680 gen 7 total ptrs 47 free space =
12146 owner 18446744073709551610
>   BTRFS info (device dm-4): refs 1 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) loc=
k_owner 0 current 26176
>           item 0 key (305 1 0) itemoff 16123 itemsize 160
>                   inode generation 0 size 0 mode 40777
>           item 1 key (305 12 257) itemoff 16111 itemsize 12
>           item 2 key (307 108 0) itemoff 16058 itemsize 53 <<<
>                   extent data disk bytenr 0 nr 0
>                   extent data offset 0 nr 614400 ram 671744
>           item 3 key (307 108 614400) itemoff 16005 itemsize 53
>                   extent data disk bytenr 195342336 nr 57344
>                   extent data offset 0 nr 53248 ram 57344
>           item 4 key (307 108 667648) itemoff 15952 itemsize 53
>                   extent data disk bytenr 194048000 nr 4096
>                   extent data offset 0 nr 4096 ram 4096
>           [...]
>   BTRFS error (device dm-4): block=3D33095680 write time tree block corru=
ption detected
>   BTRFS: error (device dm-4) in btrfs_commit_transaction:2332: errno=3D-5=
 IO failure (Error while writing out transaction)
>   BTRFS info (device dm-4): forced readonly
>   BTRFS warning (device dm-4): Skipping commit of aborted transaction.
>   BTRFS info (device dm-4): use zlib compression, level 3
>   BTRFS: error (device dm-4) in cleanup_transaction:1890: errno=3D-5 IO f=
ailure
>
> [CAUSE]
> Commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_IT=
EM")
> assumes all XATTR_ITEM/DIR_INDEX/DIR_ITEM/INODE_REF/EXTENT_DATA items
> should have previous key with the same objectid as ino.
>
> But it's only true for fs trees. For log-tree, we can get above log tree
> block where an EXTENT_DATA item has no previous key with the same ino.
> As log tree only records modified items, it won't record unmodified
> items like INODE_ITEM.
>
> So this triggers write time tree check warning.
>
> [FIX]
> As a quick fix, check header owner to skip the previous key if it's not
> fs tree (log tree doesn't count as fs tree).
>
> This fix is only to be merged as a quick fix.
> There will be a more comprehensive fix to refactor the common check into
> one function.
>
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_IT=
EM")

So this is bogus, since that commit is not in Linus' tree, and once it
gets there its ID changes.
More likely, this will get squashed into that commit in misc-next
since we are still far from the 5.5 merge window.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Anyway, the change looks fine to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/tree-checker.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index b8f82d9be9f0..5e34cd5e3e2e 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -148,7 +148,8 @@ static int check_extent_data_item(struct extent_buffe=
r *leaf,
>          * But if objectids mismatch, it means we have a missing
>          * INODE_ITEM.
>          */
> -       if (slot > 0 && prev_key->objectid !=3D key->objectid) {
> +       if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> +           prev_key->objectid !=3D key->objectid) {
>                 file_extent_err(leaf, slot,
>                 "invalid previous key objectid, have %llu expect %llu",
>                                 prev_key->objectid, key->objectid);
> @@ -322,7 +323,8 @@ static int check_dir_item(struct extent_buffer *leaf,
>         u32 cur =3D 0;
>
>         /* Same check as in check_extent_data_item() */
> -       if (slot > 0 && prev_key->objectid !=3D key->objectid) {
> +       if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> +           prev_key->objectid !=3D key->objectid) {
>                 dir_item_err(leaf, slot,
>                 "invalid previous key objectid, have %llu expect %llu",
>                              prev_key->objectid, key->objectid);
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
