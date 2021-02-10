Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA378315B47
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 01:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhBJAdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 19:33:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:59131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhBJALG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 19:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612915759;
        bh=s+opzyFTcyKb9Np/I+ncpXPKeNNsVH37+uEc2yIG2uw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bSVfggDwtHZXo/JxTFqFGhXmihux9+VO+Hf8N6feIqR/MZaTEsYjs/5WW0zmMWacm
         ga7H34RehlIc+MPWaHOw9TOlYsyDUiq8s+veVnmDQkM2vdiqmHrmB3z/QsL3Jev8D0
         iTpAaYMXUk0iOIfaHYNPIEEccMzg6xt+lef/bvT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mw9Q6-1m1jDv05ye-00s2Iw; Wed, 10
 Feb 2021 01:09:19 +0100
Subject: Re: [PATCH u-boot] fs: btrfs: do not fail when offset of a ROOT_ITEM
 is not -1
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
References: <20210209173337.16621-1-marek.behun@nic.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40e38323-0013-6799-1527-02cbac8dc93e@gmx.com>
Date:   Wed, 10 Feb 2021 08:09:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209173337.16621-1-marek.behun@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aTm3a8X29GZo8Hs7sEE1w+TXseXQ5zvOYYZmIQgYrfEQxWq866/
 54nvkFrkLaXBzMD4cIqA3ZNns+puKOnoRhx81w7WTeZ0g+nCLepVs7MGuaD68V5+cZoihkt
 HpkAlxV/qlV//rNQJU7r4q9n3sEnirA/wz1tgu6OjdS94rsTdkoOsjIIFeVNehbhYu0qtSF
 OKh/dXGUofxSbJAkk+JVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjJMwkEtfEA=:wRhD6HoUPcL+ieAKYC891n
 SqG4AtvkhZlLTRh9k4tfkuRuyWufoaXccSHRCvzRq4xjJe/d7ylaBdSBmNUYq5W3oLbWbw1r3
 S/v0dfisz242lcDIZSsyJlBo63fxfi7+1DX1DRgaAlpO7RuB6WjR8SRlQg9zT9S6qgKHEe/Kc
 cn3con6t/anMLIJEzV2i3U2rgt5VkcnF6qB2+t5NSIXJm9NYCD9JSx0yjso4SStaFj9MzqlEg
 7AXBnqhphPCpxTDyOCFPk0bDXZtWuUc+mmYSrRXXm7Rcvbf8AAY3jfR/vKOLV/F5s2p60VEZg
 ZTWRuzPUQcAzE4EPis8GCuZShoXTI0ASgFf9aB/jFugZ/ib+rZpOQ0hqCUiVYvF+5irjbB8iu
 Gqzj5UEeTjyTcIUmB4fmaItwz0JJ1ng4uIGK30ClEd3X+vQGAONjQG+DMAJ3/T2vh/k5GVeqn
 9LvcZfYJ3GX7nYgb/T/B5eSE2ykgLh9i7bllyZmj7OVLichT3/+DJQeMKIjspx6G3x7ASGW4+
 RIoWvVFIP6jxXoy8ZVv0CSLLNaw2zuNkwSnWg4exnWjgp4Alc/E2jpDxRfV30n834SaNKX5pV
 /ewlFGm14ncOSUPoZ5sK7+9V2wgEIPmXUOKXDxUdh0sp4pYZrP3LXgB6eQuQYtSe6Hcul0xFH
 /lykIpmLIQEzK8WSGun5d3pJDYJan9Oe497Uf0kOj+yD84A2poF00uoNUwZMp5zNUZp03OUEa
 TAIDb+ZmtKnwbxcmNKRUdMPYHNlr+3VUovGreT1mWKDgD7NR4vDQhzx1MKBhVNKE3mQagxJCV
 QajnDGJ1HGF90csCGW8KmxMoOvPP8+TUAzr3S7l2YYtKsyqMyaoVHBlr2tLgdqTNNpuifYPVb
 +3ciFIJhQVCFrS+Pbe7w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/10 =E4=B8=8A=E5=8D=881:33, Marek Beh=C3=BAn wrote:
> When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
> location key offset other than -1, it currently fails via BUG_ON.
>
> The offset can have other value than -1, though. This can happen for
> example if a subvolume is renamed:
>
>    $ btrfs subvolume create X && sync
>    Create subvolume './X'
>    $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
>          location key (270 ROOT_ITEM 18446744073709551615) type DIR
>          transid 283 data_len 0 name_len 1
>          name: X
>    $ mv X Y && sync
>    $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
>          location key (270 ROOT_ITEM 0) type DIR
>          transid 285 data_len 0 name_len 1
>          name: Y
>
> As can be seen the offset changed from -1ULL to 0.


Offset for subvolume ROOT_ITEM can be other values, especially for
snapshot that offset is the transid when it get created.

But the problem is, if we call btrfs_read_fs_root() for subvolume tree,
the offset of the key really doesn't matter, the only important thing is
the objectid.

Thus we use that BUG_ON() to catch careless callers.

Would you please provide a case where we wrongly call
btrfs_read_fs_root() with incorrect offset inside btrfs-progs/uboot?

I believe that would be the proper way to fix.

Thanks,
Qu
>
> Do not fail in this case.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   fs/btrfs/disk-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b332ecb796..c6fdec95c1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -732,8 +732,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_f=
s_info *fs_info,
>   		return fs_info->chunk_root;
>   	if (location->objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID)
>   		return fs_info->csum_root;
> -	BUG_ON(location->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID ||
> -	       location->offset !=3D (u64)-1);
> +	BUG_ON(location->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID);
>
>   	node =3D rb_search(&fs_info->fs_root_tree, (void *)&objectid,
>   			 btrfs_fs_roots_compare_objectids, NULL);
>
