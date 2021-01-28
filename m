Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49AA30746F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhA1LI2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:08:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:36579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhA1LIZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611832007;
        bh=AmJ8JheKKzRIyc+PE48fpnm0lt/mwRYhZomnFgG4+Rg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=RtdQHDNxQZIGqJTXlM3YKoMA0XbffxoIeTQAH/fNwm+vXNYNNYvMVskSXFsmRLEYT
         X6dnlkktyoM9juSXANo3kyP8XT7s5/G2aAHcTJpDBfw7zJ6BL5nBQGmmYp3LB6u/b2
         yMyaS5KacD5uBnQElcgo3oDmuSkrzHJdANH6rt+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1l6zsb0KmR-0038Oo; Thu, 28
 Jan 2021 12:06:47 +0100
To:     Dan Carpenter <dan.carpenter@oracle.com>, wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <YBKW31GtQ2Rc6EfC@mwanda>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [bug report] btrfs: introduce read_extent_buffer_subpage()
Message-ID: <e19e87e2-17eb-7244-008d-2a0c9cc2dac7@gmx.com>
Date:   Thu, 28 Jan 2021 19:06:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBKW31GtQ2Rc6EfC@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VstJVDczBEsuS4Pc+PbryPIXTWZ9xHtRa03w4+xnELW3JZvHixY
 vqaQo+blwkMc7qqMVjUp9rjScumIOlf8skKszv15k5tpRJvSqWP/fl+lflM9xmxF8Mt41eI
 MZhv9UYNswxwEpvRqtKHJKu9j1E9b8DD05ki4OppvjisNdeYLl5yzB7rT0UejJGitlew+Js
 S+6XCwIXyamkGVpbvqr5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MncrWruw+Ew=:929B9iWJjcD5ZuXDsZidaC
 juIIm6bG7q6y6ngEpiVLUllIbm9+YCz2Hz+3PKXP39hlSEQV/240QUtmOKGXfRjug4KtoBSL9
 LuyEYKNU7icDcdpy2NLd7JZ0L6BVcaWI6MaEK9PnSnYFTzTLnXGug6YbmCfp79WggAJ3ofDku
 S/Pk0nSdZAIJYA0QuKtz2e1EOVAVyBWzWCCzQgNYbDtsDAk9TPOyfOX0cd1Sk2Ysq6B7IW0z0
 ul0adtRbGGUGOKSh0O3lCr7daYyKSCJiO9qcIBFx/cCQ1b5z2AEn10vmpEvv+9fzBVY/czRJo
 Tj5JjmJE083shjbeqsMy6jNo6/pwRowUKulezy3zxFgN4jpyvBK8ocut0kTjE/O8oP9PhpZZr
 V+vWwobgxketio/XuLN/VlKODlBbtjdOS4cQmOuexlgz9/OWDQk047e+V+kpj/F5kKNaaEh0u
 6AHB5kPMSikDJkGHJk2ixj7PJbZZ1jN+IkkTfcQqBM1r0a8ENovCzH9ta2cJq40S4BVirexyX
 MZAUi4TaK1uwsGoIzeqEa2fNApabo7XBjPmmVEtCdIvBElAEGmPjsOkcNB4A3M/O8N6EL3dST
 Qa/lpbO7R+nEOmTa7jizHABNnljibYLT6GFbfLD0cwWcfohihaUifwC0yqyFxMPpvNMkg44q1
 w64IyhS2DE1uRtUFvPYezJjSY7bIN2K+lYerIbiL+nxrlu4SbpTKiaVzNEDQH+IxMWLLUGhjo
 EPVb9RD2LMS1uKaJERAbXzC3Aw6iETWzejfXvgbpDMsqcdTlbLm5hD/tH3mYyrlFJ/SYajIT7
 ASD+3DUGXRTDaero14yTUSCJdtHK7WiiAgEqg/oOWv2cGE2V/klRV4xzeJcfzl+uoUvjO+GWB
 jR9PLaR17xUtWzfZb7Mg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/28 =E4=B8=8B=E5=8D=886:50, Dan Carpenter wrote:
> Hello Qu Wenruo,
>
> The patch 5c60a522f1ea: "btrfs: introduce
> read_extent_buffer_subpage()" from Jan 16, 2021, leads to the
> following static checker warning:
>
> 	fs/btrfs/extent_io.c:5797 read_extent_buffer_subpage()
> 	info: return a literal instead of 'ret'
>
> fs/btrfs/extent_io.c
>    5780  static int read_extent_buffer_subpage(struct extent_buffer *eb,=
 int wait,
>    5781                                        int mirror_num)
>    5782  {
>    5783          struct btrfs_fs_info *fs_info =3D eb->fs_info;
>    5784          struct extent_io_tree *io_tree;
>    5785          struct page *page =3D eb->pages[0];
>    5786          struct bio *bio =3D NULL;
>    5787          int ret =3D 0;
>    5788
>    5789          ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
>    5790          ASSERT(PagePrivate(page));
>    5791          io_tree =3D &BTRFS_I(fs_info->btree_inode)->io_tree;
>    5792
>    5793          if (wait =3D=3D WAIT_NONE) {
>    5794                  ret =3D try_lock_extent(io_tree, eb->start,
>    5795                                        eb->start + eb->len - 1);
>    5796                  if (ret <=3D 0)
>    5797                          return ret;
>
> If try_lock_extent() fails to get the lock and returns 0, then is
> returning zero here really the correct behavior?

This is the same behavior of read_extent_buffer_pages() for regular
sector size:

int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int
mirror_num)
{
	...
         int ret =3D 0;
	...
	        num_pages =3D num_extent_pages(eb);
         for (i =3D 0; i < num_pages; i++) {
                 page =3D eb->pages[i];
                 if (wait =3D=3D WAIT_NONE) {
                         if (!trylock_page(page))
                                 goto unlock_exit; <<<<
	...
unlock_exit:
         while (locked_pages > 0) {
                 locked_pages--;
                 page =3D eb->pages[locked_pages];
                 unlock_page(page);
         }
         return ret;
}

Here when we hit trylock_page() =3D=3D false case, we directly go
unlock_exit, and by that time, @ret is still 0.


I'm not yet confident enough to say why it's OK, but my initial guess
is, we won't have (wait =3D=3D WAIT_NONE) case for metadata read.

Thank you for the hint, I'll take more time to make sure the original
behavior is correct, and if it's really (wait =3D=3D WAIT_NONE) will never
be true for metadata, I'll send out cleanup for this.

Thanks,
Qu

>  It feels like there
> should be some documentation because this behavior is unexpected.
>
>    5798          } else {
>    5799                  ret =3D lock_extent(io_tree, eb->start, eb->sta=
rt + eb->len - 1);
>    5800                  if (ret < 0)
>    5801                          return ret;
>    5802          }
>    5803
>    5804          ret =3D 0;
>    5805          if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
>    5806              PageUptodate(page) ||
>    5807              btrfs_subpage_test_uptodate(fs_info, page, eb->star=
t, eb->len)) {
>    5808                  set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
>    5809                  unlock_extent(io_tree, eb->start, eb->start + e=
b->len - 1);
>    5810                  return ret;
>    5811          }
>
> regards,
> dan carpenter
>
