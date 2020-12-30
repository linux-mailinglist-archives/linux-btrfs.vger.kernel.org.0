Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6D2E76E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL3H6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 02:58:30 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:55140 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL3H6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 02:58:30 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id BFE3B450AC2;
        Wed, 30 Dec 2020 09:57:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609315057; bh=1nUJUOY+e+yzh/hlkOef64rJlWOx7f1bK2r5wXothsI=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=njqcP8mhzVAOmsXofzP81HFPx6EKYG6Stqk1REDbkrDiwwLv/RmgvqSXrMrEPeDch
         ApKO6vHDc4PNJOyRFj5pgVrUuZ24wND0JuC6E7Yrwh9xD6QG9tdEd2aY6iP2OcDVbd
         ywHp7M9bXIOU6wCO0x1OqIlKRMR7Z8Uvtn3M/rAM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id B12A6450AAA;
        Wed, 30 Dec 2020 09:57:37 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id skIWZ0vPEXYp; Wed, 30 Dec 2020 09:57:37 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3EC3D450AA9;
        Wed, 30 Dec 2020 09:57:37 +0200 (EET)
Received: from nas (unknown [59.149.253.145])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 121BA1BE04B3;
        Wed, 30 Dec 2020 09:57:34 +0200 (EET)
References: <20201229132934.117325-1-wqu@suse.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        =?utf-8?Q?St=C3=A9phane?= Lesimple <stephane_btrfs2@lesimple.fr>
Subject: Re: [PATCH] btrfs: relocation: fix wrong file extent type check to
 avoid false -ENOENT error
In-reply-to: <20201229132934.117325-1-wqu@suse.com>
Message-ID: <a6tvsp3w.fsf@damenly.su>
Date:   Wed, 30 Dec 2020 15:57:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1uoXXraDBg1qilXXeng55TJ3WUigBmOPC+CfkkPWBO2mWpqLw+1vSM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 29 Dec 2020 at 21:29, Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> There are several bug reports about recent kernel unable to=20
> relocate
> certain data block groups.
>
> Sometimes the error just go away, but there is one reporter who=20
> can
> reproduce it reliably.
>
> The dmesg would look like:
> [  438.260483] BTRFS info (device dm-10): balance: start=20
> -dvrange=3D34625344765952..34625344765953
> [  438.269018] BTRFS info (device dm-10): relocating block group=20
> 34625344765952 flags data|raid1
> [  450.439609] BTRFS info (device dm-10): found 167 extents,=20
> stage: move data extents
> [  463.501781] BTRFS info (device dm-10): balance: ended with=20
> status: -2
>
> [CAUSE]
> The -ENOENT error is returned from the following chall chain:
>
> add_data_references()
> |- delete_v1_space_cache();
>    |- if (!found)
>          return -ENOENT;
>
> The variable @found is set to true if we find a data extent=20
> whose
> disk bytenr matches parameter @data_bytes.
>
> With extra debug, the offending tree block looks like this:
>   leaf bytenr =3D 42676709441536, data_bytenr =3D 34626327621632
>
>                 ctime 1567904822.739884119 (2019-09-08 03:07:02)
>                 mtime 0.0 (1970-01-01 01:00:00)
>                 otime 0.0 (1970-01-01 01:00:00)
>         item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize=20
>         53
>                 generation 1517381 type 2 (prealloc)
>                 prealloc data disk byte 34626327621632 nr 262144=20
>                 <<<
>                 prealloc data offset 0 nr 262144
>         item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize=20
>         439
>                 generation 2618893 root_dirid 256 bytenr=20
>                 42677048360960 level 3 refs 1
>                 lastsnap 2618893 byte_limit 0 bytes_used=20
>                 5557338112 flags 0x0(none)
>                 uuid d0d4361f-d231-6d40-8901-fe506e4b2b53
>
> Although item 27 has disk bytenr 34626327621632, which matches=20
> the
> data_bytenr, its type is prealloc, not reg.
> This makes the existing code skip that item, and return -ENOENT.
>
> [FIX]
> The code is modified in commit  19b546d7a1b2 ("btrfs:=20
> relocation: Use
> btrfs_find_all_leafs to locate data extent parent tree leaves"),=20
> before
> that commit, we use something like
> "if (type =3D=3D BTRFS_FILE_EXTENT_INLINE) continue;".
>
> But in that offending commit, we use (type =3D=3D=20
> BTRFS_FILE_EXTENT_REG),
> ignoring BTRFS_FILE_EXTENT_PREALLOC.
>
> Fix it by also checking BTRFS_FILE_EXTENT_PREALLOC.
>
> Reported-by: St=C3=A9phane Lesimple <stephane_btrfs2@lesimple.fr>
> Fixes: 19b546d7a1b2 ("btrfs: relocation: Use=20
> btrfs_find_all_leafs to locate data extent parent tree leaves")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
>

Reviewed-by: Su Yue <l@damenly.su>

> ---
>  fs/btrfs/relocation.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 19b7db8b2117..df63ef64c5c0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2975,11 +2975,16 @@ static int delete_v1_space_cache(struct=20
> extent_buffer *leaf,
>  		return 0;
>
>  	for (i =3D 0; i < btrfs_header_nritems(leaf); i++) {
> +		u8 type;
> +
>  		btrfs_item_key_to_cpu(leaf, &key, i);
>  		if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
>  			continue;
>  		ei =3D btrfs_item_ptr(leaf, i, struct=20
>  btrfs_file_extent_item);
> -		if (btrfs_file_extent_type(leaf, ei) =3D=3D=20
> BTRFS_FILE_EXTENT_REG &&
> +		type =3D btrfs_file_extent_type(leaf, ei);
> +
> +		if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||
> +		     type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&
>  		    btrfs_file_extent_disk_bytenr(leaf, ei) =3D=3D=20
>  data_bytenr) {
>  			found =3D true;
>  			space_cache_ino =3D key.objectid;

