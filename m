Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1F3D5964
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhGZLoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:44:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:44573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhGZLoO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302281;
        bh=nBA9MZPtlqVyFVIjCG3a5LVyvb9WzlgIWX5DivBaqd0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lO4yN6jCUaQ9Wq3Q7RXSxscNA4R8LMZssQKY2jiYUeNTGqZzgqOmZlljTNaBTuH0Y
         FGe90a1FjMI5Ce4qEC0Rs+rNKllTTBHWeIxq01czvRB1qJ3w3x6Kq7jUH5LMKQ16X+
         3CjCDH2j7p7OYBVj6j8NnVT209a8OjpNhVrDDeNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYqv-1lEe5D1srb-00u405; Mon, 26
 Jul 2021 14:24:41 +0200
Subject: Re: [PATCH 02/10] btrfs: remove uptodate parameter from
 btrfs_dec_test_first_ordered_pending
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <2b01784d09b77a3209dda4284887271e1f8d434b.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <18e1ac39-480e-7d2c-0dbd-dd35dd55baf8@gmx.com>
Date:   Mon, 26 Jul 2021 20:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2b01784d09b77a3209dda4284887271e1f8d434b.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTwb/OvtqTu2JF6WHzPu5q3ArPBEBzjywpBEeX1b2pyCLQpAKJ+
 MEA+SQAQw6hMslkL8FzULZOIgFyiA6KH7D86GnBs0TGND0kMEOgBHxR2ykynezN3rERfZcR
 EnGwK1s7py3VsY7mUfWzrlfsaNiclIe5p43jaBc30V065yHVOXBvwe00wbfNrovDNK05pyN
 qMucOMe+lQ/NwMXhtSgCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bcMyh4DS0bQ=:Ba1wbdzHJWo4J/XsVbXNTs
 zEjTAt9Pn4+H99TbLfl+3qoX19RjpaEUuCAZYQ28s66C17Somqw24Z1AzropKUzvGXutbyrCH
 ldk1kruGqg2gKI/gVg2yeJlNcJD0o05ivOelKXFrUxNf9p5xgHxRyAQCg2T1qaA4G0HbIdKUp
 QFkLwnJDgTJD/x6Ztqqfo70HeudclhVae8qIXqCaC31VMxLAWf4NuebQdtaVuVO2u/pWr0q9J
 N2qVOz8fUSvvAqoYahR5B0ke5CfVuY+HO15qc5YN+LTGdvUm5fepLJ8Frq+vsTHI43cPgyLPb
 kACJryXvIhfS6NOF62Qc9fAr4/YDauMGE+eg8bVuFrSOXbrfNbzNYHf1B7fbnLxQrOFYxY08t
 cM26k3SWhnAcLRnhAAFuJgifQEUSRDz+yBomSbySp+z21Brs8IU83ATPJNBalkpj/IyQX6vub
 gYm8JtWp/S4Uf55cZmSbJ0EImvad+rW67H6qqA579LL1abxBTEgP9ALmRJ/HviX4dVDxUAP6Q
 reoG2SosjsvlHzCxruuJ0Z3zPv2/UbCvCpUxEVNi3DgXDDhwhtUFxTdupkbmh4Xcn3DBQUcrR
 ijMDTQ48P20HXDQO6AcpJWxwGlLZZx8q5Lu8yrLgji+Y7O7PhdQTntEUAuh42VvNdYaET+7C/
 pQkkv0hql5fmdgTbtPegb8pvMjfgu6zoLvMldxlRIk6IT249LzNmCKqJzfdfIXBoj/rQKtl6H
 dHgD5uYHCm2exPpaPs+FpxSHXo2QIvNOIBMGhIQh8513TSzEaH0YWyXC4tOTdVzGegWQbR3kf
 pXfQULR8k+gZNO37p7gD8joRpBzEBE3nVx05fAOVA5YWHO+6ADhxVrZ0iyqAWn508bCHmymD3
 Swn1NSu2y6tefDESxpd9jfBgFWDIFj23aU8vTswqRrJHDSLGHUm8Z6Ubex2aYVEKLO7XiN18E
 dJpnG58rQ0zBkgUrSWsMPgY4d5lwn103vDlJNRgE+wE5ePXKqdyF4J4AwXUIJuCdc8hbIRvwz
 3jlJj/lcibLjcJvYhGWALXL3IzHPOqJhkcBz80JmTsXS43feTX72Zgv7OZrWtGbQk1arV6ear
 6VPMMEhnyIFWMUBouURD83poCSKGWUGe2gPSd9HiAo2+7CkvgnbnDdw7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> In commit e65f152e4348 ("btrfs: refactor how we finish ordered extent io
> for endio functions") there was last caller not using 1 for the uptodate
> parameter. Now there's only one, passing 1, so we can remove it and
> simplify the code.

I should have noticed that...

>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c        | 2 +-
>   fs/btrfs/ordered-data.c | 5 +----
>   fs/btrfs/ordered-data.h | 2 +-
>   3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 43b1393eec67..ba0bba9f5505 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8554,7 +8554,7 @@ static void btrfs_invalidatepage(struct page *page=
, unsigned int offset,
>   		spin_unlock_irq(&inode->ordered_tree.lock);
>
>   		if (btrfs_dec_test_ordered_pending(inode, &ordered,
> -					cur, range_end + 1 - cur, 1)) {
> +						   cur, range_end + 1 - cur)) {
>   			btrfs_finish_ordered_io(ordered);
>   			/*
>   			 * The ordered extent has finished, now we're again
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 5c0f8481e25e..edb65abf0393 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -446,7 +446,6 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>    * 		 Will be also used to store the finished ordered extent.
>    * @file_offset: File offset for the finished IO
>    * @io_size:	 Length of the finish IO range
> - * @uptodate:	 If the IO finishes without problem
>    *
>    * Return true if the ordered extent is finished in the range, and upd=
ate
>    * @cached.
> @@ -457,7 +456,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>    */
>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>   				    struct btrfs_ordered_extent **cached,
> -				    u64 file_offset, u64 io_size, int uptodate)
> +				    u64 file_offset, u64 io_size)
>   {
>   	struct btrfs_ordered_inode_tree *tree =3D &inode->ordered_tree;
>   	struct rb_node *node;
> @@ -486,8 +485,6 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_ino=
de *inode,
>   		       entry->bytes_left, io_size);
>
>   	entry->bytes_left -=3D io_size;
> -	if (!uptodate)
> -		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
>
>   	if (entry->bytes_left =3D=3D 0) {
>   		/*
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index b2d88aba8420..4194e960ff61 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -177,7 +177,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>   				bool uptodate);
>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>   				    struct btrfs_ordered_extent **cached,
> -				    u64 file_offset, u64 io_size, int uptodate);
> +				    u64 file_offset, u64 io_size);
>   int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offse=
t,
>   			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
>   			     int type);
>
