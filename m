Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300183D5960
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhGZLne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:43:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:37967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhGZLnd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302240;
        bh=30/+yY9iW//5+99YKX5hAYjOryzV1JeFHYOjyDvewb0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZdBmQ4gBo9RKrlCDAhrgJpXhd9G1M8KcbfcU3KDdRjuk5RxQgL8+j4lvjRSnyD25O
         mlrRQuRY29TRPtkxE8ZDYQzP4UBmUT34FHnnEhig1EWSuZ3x8ZBeZGVzdcYhb3Y2OM
         m0UGSZ9XLzP9vdFyBTpspOtTvmLm//dNQxlzW9uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M89Kr-1m3Kwe2zbv-005FYa; Mon, 26
 Jul 2021 14:24:00 +0200
Subject: Re: [PATCH 01/10] btrfs: switch uptodate to bool in
 btrfs_writepage_endio_finish_ordered
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <ea500ab6911d708d8c70fe5f7aa1556b4283b188.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ef329269-0956-4741-e81c-9ace324f12b6@gmx.com>
Date:   Mon, 26 Jul 2021 20:23:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ea500ab6911d708d8c70fe5f7aa1556b4283b188.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ZS1QPVUVXW7Uj1G4svdH3ChiitGfM40HER10A1mZYRCg0zUiuf
 zFdDEnitCQlLa3OP9oePp+vvlqVwiPzupkVirRSr6sj2+F0rs6F2hELJaWjO+3vkqmlxG50
 Cs0CscxAGbbuyAAlu5mLKlx9D3iBM6KwOrV2rY1CiSb4Zjvx4v7ZRc7MRlXJdNUntKLpCvI
 cPf7moMTON5kec62RPmFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZVvN+OafoY=:9IJ3Jk+1+yo5c2emHFw7Dl
 ndcj4yyN2N/gIbOOMGwsznrig54FkveUShP6NrZ9s2woo2oyBtTltxI8i7VyOxbBx4jj56cT2
 FJqMcGqQ+0yaJGuZqZ4qLKqfPDd9eKa2mDlnsxkkCzGU1kSokXGP3EVO6urPC90WHCeVa9hBk
 0oCRLXw8WezNuOBJwOFpz9cA+sXPgvRE7cVBPvUCVeqVJZ5n78xFgtDZsrVLMq8k1CyZcGCAy
 7v9Psq4Jc6UNGFIiCh4jscLrLzQr6ecR5VUoxfJlvztM1Ma9dCFHae4yl1kfD7pQ4/h3V1X1V
 BDD1eAko4lWvY21KpQsIE/AdotV428jc4eSArkVoJx2UOWHRm1EAKCoDfXHyUoLwY23H7wNF4
 rZZg7o5hfT7ILXq7q6SCgnNEvSMLMGG+Sh/MR9JiZMKn62JUTvEsx52F5hP44gVmOKIxaiEP6
 LZ3ZeqEMmrtCmONQDSySOOcr5rgYOY6tXxzcuzp23Zg5Jvzp2QO36Ak0VNX/hfrQnBBpjzVll
 J0WhhBOGRqmCpACscthGy2sfI4ejjWC/JXCo5UnX5MgQOQ71/bLtBOeqiAZqUB9nY9UQ15Q9z
 JFpyhHKBZCmlZ19Ut2v+yd2myXVXfDdD1SYWtm7HLH/37m8tCZlniZzGPmtpxVVITzEr0PSB7
 WTMV3INzfYhOO3NcIgFqfDoCx+39OOw+sH1b+0nHYv92dDKVYoVzPOWbBblZTyojUs/wLbrcV
 PAo4x1jmyzjCrBPGYYBCoexVyBqEfM+8e8JlqPVkKNcn5NmhcqRGu4vz0h2NNXrlGhTEoLB1X
 dQS70BtBKl9BQTjbV2QjjVHP9GVJMlcpfU+lg/UDOo4ZYzNSMOzet1ep+aLHkNCZANzHB6B/3
 yest3Zsi5EnzzaL25i4d63Hsfibu27UNnIUu/OubUN4XaEmXfv6VjFghBYTINK9AY/W2dRNYT
 g+9UMVt0DBbzAzvtetsYWsL64FfO0xDdYY5RPTYsy55hc+knWbCUrIxrAL48YHTs/ORBFF677
 tihnPjwyliT5sgoXOZ8jLBknsORn213G+BXRxHbhNFb1MS/JjDVMogUDZwoOVzXLBNGqzt4Q2
 dN/kK4KNIK/8SjFyXfu571mRF9GYA7B501eymQPMZEN2QRhnLJTWyW06A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> The uptodate parameter should be bool, change the type.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h     | 2 +-
>   fs/btrfs/extent_io.c | 8 ++++----
>   fs/btrfs/inode.c     | 4 ++--
>   3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4a69aa604ac5..a822404eeaee 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3195,7 +3195,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *i=
node, struct page *locked_page
>   int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>   void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>   					  struct page *page, u64 start,
> -					  u64 end, int uptodate);
> +					  u64 end, bool uptodate);
>   extern const struct dentry_operations btrfs_dentry_operations;
>   extern const struct iomap_ops btrfs_dio_iomap_ops;
>   extern const struct iomap_dio_ops btrfs_dio_ops;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1f947e24091a..f7e58c304fc9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2779,7 +2779,7 @@ static blk_status_t submit_read_repair(struct inod=
e *inode,
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 e=
nd)
>   {
>   	struct btrfs_inode *inode;
> -	int uptodate =3D (err =3D=3D 0);
> +	const bool uptodate =3D (err =3D=3D 0);
>   	int ret =3D 0;
>
>   	ASSERT(page && page->mapping);
> @@ -3864,7 +3864,7 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>
>   		if (cur >=3D i_size) {
>   			btrfs_writepage_endio_finish_ordered(inode, page, cur,
> -							     end, 1);
> +							     end, true);
>   			break;
>   		}
>
> @@ -3914,7 +3914,7 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   				nr++;
>   			else
>   				btrfs_writepage_endio_finish_ordered(inode,
> -						page, cur, cur + iosize - 1, 1);
> +						page, cur, cur + iosize - 1, true);
>   			cur +=3D iosize;
>   			continue;
>   		}
> @@ -4983,7 +4983,7 @@ int extent_write_locked_range(struct inode *inode,=
 u64 start, u64 end,
>   			ret =3D __extent_writepage(page, &wbc_writepages, &epd);
>   		else {
>   			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
> -					page, start, start + PAGE_SIZE - 1, 1);
> +					page, start, start + PAGE_SIZE - 1, true);
>   			unlock_page(page);
>   		}
>   		put_page(page);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6089c5e7763c..43b1393eec67 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -972,7 +972,7 @@ static noinline void submit_compressed_extents(struc=
t async_chunk *async_chunk)
>
>   			p->mapping =3D inode->vfs_inode.i_mapping;
>   			btrfs_writepage_endio_finish_ordered(inode, p, start,
> -							     end, 0);
> +							     end, false);
>
>   			p->mapping =3D NULL;
>   			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
> @@ -3170,7 +3170,7 @@ static void finish_ordered_fn(struct btrfs_work *w=
ork)
>
>   void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>   					  struct page *page, u64 start,
> -					  u64 end, int uptodate)
> +					  u64 end, bool uptodate)
>   {
>   	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
>
>
