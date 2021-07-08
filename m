Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB613C1C1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 01:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGHXfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 19:35:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:58113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGHXfM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 19:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625787148;
        bh=eqWdfaLZqKT+tArpohk1VImInfiE8ypdu/gCJK8qpWs=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Pvl5sEm+qGkEEqPW1A0FuTi4NGUhUHgozp9nOlbJSK/ql5yTK4pwfCLHBfC5JqJ6d
         Zet2wzpAscRHDJNgSdFpRcTDjq/V1spXP28B6PN4W6KbhPDPRnrQ8YB45AWQPcJXmD
         azpLTgeuzQgyF+iqfH7ca6bQOWcBFbWu+MtsKs9o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1lDoi10HZN-00wmrW; Fri, 09
 Jul 2021 01:32:28 +0200
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
 <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
 <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
 <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
 <0102017a680d637c-4a958f96-dd8b-433d-84a6-8fc6a84abf47-000000@eu-west-1.amazonses.com>
 <a5357b44-6c1c-3174-a76c-09f01802386a@gmx.com>
 <0102017a86e63e18-a5023d15-0b20-43e8-b71c-6dd241451179-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: IO failure without other (device) error
Message-ID: <75a45aff-a75f-a6ec-1a7b-6ea4d89071bb@gmx.com>
Date:   Fri, 9 Jul 2021 07:32:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0102017a86e63e18-a5023d15-0b20-43e8-b71c-6dd241451179-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFtfou8R6GyDD/h1IzSbAG8M1UZnXC3nOWu0yX3kVu502xGzhih
 w3rI5Iy0KwjmHaktCIm+/nBwWCEyTNNmDOEVcvDb77FG5J1Yy+tjL1TceJI10V2Q2H7X6z+
 NcXZOqfCJ1Pjhk6L16ZC1CDmIBS5fRWA+acPyK6RZle1mtbgEcBteY82dWq7teTjzVjl+tJ
 48pTwC7UKWz7Q2QaMmAXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnXxf54jXWM=:3KS681lKatO0zNByypnxBT
 VynGn8hByth5YwHr7N29JUM7RY5VhAdzuTPPza/uOSjg8thx69BNHstzq/0Z3/q4LW04fvqQu
 bNugkMPXb7Pz76SXnffbTPu0YvhYRF47A2J+Dx510GwKR9+amx15x1NIgFNFhivht4gXvV5z7
 GxCGq2d3eqbxvm6l/pFKOtTw5ECb3HXYHy1jxg+tNBZUwpfgMFRNrPjmWQntajbEWwfHxvfBv
 o68sb0Eh+GR9SD1zLLXI4hqXB170X3Bln3/CAc3nc828LW9Sh35cdY4NUzi9MCGDz7sToqweX
 4t0yypj01GdPziU9ck4kpx//ha5v1C1L22P7X1Vd24ChMz+kRBhHJyxWZNHOUqlFDT8QI/vQy
 0x8xTf+UyzybaL2+H5837VcbxFG/pfVLxMshm0+9rJnPIGkGwb2sp2m3oXpFoHFP5ZMhLdPlz
 Uc5lGDWiaPg7a019eheRvVMYtFA5UR1SDcv+94TJ2u5Vu2ufQEFQg98IPLTJlMDv+XBF79XQH
 Evhe8Vjr64KGDD0BkwW2Xn31fVNFdG8LtXZvnCKmG0ZvGIfJVP8sXlNkTzM8rPGluF7eprOhW
 cZu6l7lOVN0DHUpZB9PPmxJEptOpcOYmFrDSoLDepE21/NJbGe0I7v+ADXPbhRTnftfxqrEOO
 L3ns9o1XMP99Li8YCDjbKNDVnZRUGDXvkjlR0ohRIsfva7dN3oqqFXOtaxe1303rdbuyNlE00
 gDl3eCtzxBPZXP0rrsfcPt5r/bhP3ViDmey7gAzNHYr1E2VCoMJbvxJ4Nb/gfyuOYjyc94alO
 Rm9t81JrsDJQhJPC3MBBAt5sRaa19Zgn5DhXkF939qSaykCH6QYlU/sYqCjiAF1WbG5RVvhm9
 OFObkn6Qof7NZIyS5iKI2dcguzlOquuUzXMcBnhcREMDiT5rc6L2Eldfh4eyEeI0soWm+r2sk
 /iqAelbwYIltUqjfDY1kGOc1UhTzRyJDQPfFNh6wWHtNq5NbaO6P6F5/xiQQrH9ZPbNdVJz1C
 lBdupoPpWkU0NPsX1QUP6sxG53MJ+kGhWYSDTxMKJ9JlsVe7M4cGv7gWGyFgM/QxPissOwTOm
 tQN6ZTnM3Pw500UoskLmFJyvfInqEMdX0kZC6zmKrHDm3/AkGzup3WZiw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


[...]
>> My recommendation for debugging is to add extra trace_printk() on
>> btree_releasepage() to see when a metadata page really get freed, and
>> read_extent_buffer_pages() to see what's the possible race.
>>
>> Another idea is to add extra debug output in end_bio_extent_readpage()
>> for metadata pages.
>>
>> As I'm still wondering if there is something wrong detected by btrfs
>> module but without any error message.
>>
>> In that case, we definitely want to add a proper error message.
>
> I guess this would be a proper error message:
>
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6505,8 +6505,14 @@ int read_extent_buffer_pages(struct extent_buffer=
 *eb, int wait, int mirror_num)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages;=
 i++) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 page =3D eb->pages[i];
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 wait_on_page_locked(page);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!PageUptodate(page))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!PageUptodate(page)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err_=
rl(eb->fs_info,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "error reading extent buffer "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "start %llu len %lu PageError %d",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start, eb->len,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PageError(page) ? 1 : 0);

What I originally mean is, in end_bio_extent_readpage() we may hit a
case where @uptodate is 0, but we don't have any error message for it.

Your error message is fine, it has PageError() to indicate whether we're
really hitting a case like above, or someone is releasing the metadata
page improperly.

If combined with the following diff, it can rule out or catch the error
in metadata read path directly, as I'm still wondering if it's error
from the bio, or the error from improperly released metadata pages.

Thanks,
Qu

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b5f5de7e4a29..b1f8862ba539 100644
=2D-- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3047,6 +3047,16 @@ static void end_bio_extent_readpage(struct bio *bio=
)
                 if (likely(uptodate))
                         goto readpage_ok;

+               if (!is_data_inode(inode)) {
+                       struct extent_buffer *eb;
+
+                       eb =3D (struct extent_buffer *)page->private;
+                       btrfs_err_rl(fs_info,
+               "metadata read error, page=3D%llu eb=3D%llu bio_status=3D%=
d
ret=3D%d",
+                                    page_offset(page), eb->start,
+                                    bio->bi_status, ret);
+               }
+
                 if (is_data_inode(inode)) {
                         /*
                          * btrfs_submit_read_repair() will handle all
the good


>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>
> I haven't added this to the kernel I'm running yet. It currently still h=
as a WARN_ON instead of the error message.
>
> I also added the retry like this:
>
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -385,6 +385,7 @@ static int btree_read_extent_buffer_pages(struct ext=
ent_buffer *eb,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_copies =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int mirror_num =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int failed_mirror =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tries =3D 2;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_tree =3D &BTRFS_I(fs_info=
->btree_inode)->io_tree;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
> @@ -403,6 +404,10 @@ static int btree_read_extent_buffer_pages(struct ex=
tent_buffer *eb,
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 num_copies =3D btrfs_num_copies(fs_info,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start, eb->l=
en);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (num_copies =3D=3D 1 && tries-- > 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (num_copies =3D=3D 1)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>
> On Tuesday I got this:
>
> [Tue Jul=C2=A0 6 14:49:17 2021] ------------[ cut here ]------------
> [Tue Jul=C2=A0 6 14:49:17 2021] WARNING: CPU: 13 PID: 2265463 at fs/btrf=
s/extent_io.c:5597 read_extent_buffer_pages+0x346/0x360
> [Tue Jul=C2=A0 6 14:49:17 2021] Modules linked in: zram bcache crc64 loo=
p dm_crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp =
coretemp snd_pcm kvm_intel snd_timer snd mgag200 kvm soundcore drm_kms_hel=
per iTCO_wdt dcdbas irqbypass pcspkr serio_raw iTCO_vendor_support i2c_alg=
o_bit evdev joydev i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi=
 acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp lib=
iscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables au=
tofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor asy=
nc_tx raid0 multipath linear raid1 md_mod ses enclosure sd_mod hid_generic=
 usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel=
 aesni_intel crypto_simd cryptd glue_helper ahci libahci uhci_hcd ehci_pci=
 psmouse mpt3sas ehci_hcd lpc_ich raid_class libata nvme scsi_transport_sa=
s mfd_core nvme_core usbcore t10_pi scsi_mod bnx2
> [Tue Jul=C2=A0 6 14:49:17 2021] CPU: 13 PID: 2265463 Comm: btrfs Tainted=
: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 5.10.47 #1
> [Tue Jul=C2=A0 6 14:49:17 2021] Hardware name: Dell Inc. PowerEdge R510/=
0DPRKF, BIOS 1.13.0 03/02/2018
> [Tue Jul=C2=A0 6 14:49:17 2021] RIP: 0010:read_extent_buffer_pages+0x346=
/0x360
> [Tue Jul=C2=A0 6 14:49:17 2021] Code: 48 8b 43 08 a8 01 48 8d 78 ff 48 0=
f 44 fb 31 f6 e8 cf d0 db ff 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da 48 =
8b 03 a8 04 75 ab <0f> 0b 41 be fb ff ff ff eb a1 e8 4b af 56 00 66 66 2e =
0f 1f 84 00
> [Tue Jul=C2=A0 6 14:49:17 2021] RSP: 0018:ffffc9007562bb40 EFLAGS: 00010=
246
> [Tue Jul=C2=A0 6 14:49:17 2021] RAX: 06ffff80000020e3 RBX: ffffea00095a5=
fc0 RCX: 0000000000000000
> [Tue Jul=C2=A0 6 14:49:17 2021] RDX: dead0000000000ff RSI: 0000000000000=
020 RDI: ffff888713babd40
> [Tue Jul=C2=A0 6 14:49:17 2021] RBP: ffff88869a7d6f78 R08: 0000f5a746752=
ed4 R09: 0000000000000483
> [Tue Jul=C2=A0 6 14:49:17 2021] R10: 0000000000000001 R11: 0000000000000=
000 R12: ffff88869a7d7020
> [Tue Jul=C2=A0 6 14:49:17 2021] R13: ffffea0005f51f80 R14: 0000000000000=
000 R15: ffff88869a7d7020
> [Tue Jul=C2=A0 6 14:49:17 2021] FS:=C2=A0 00007f748ddc18c0(0000) GS:ffff=
888713b80000(0000) knlGS:0000000000000000
> [Tue Jul=C2=A0 6 14:49:17 2021] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
> [Tue Jul=C2=A0 6 14:49:17 2021] CR2: 00005618b6037058 CR3: 000000011feca=
004 CR4: 00000000000206e0
> [Tue Jul=C2=A0 6 14:49:17 2021] Call Trace:
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 btree_read_extent_buffer_pages+0x6=
6/0x130
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 read_tree_block+0x36/0x60
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 btrfs_read_node_slot+0xc0/0x110
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 btrfs_search_forward+0x1db/0x350
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 search_ioctl+0x19e/0x250
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 btrfs_ioctl_tree_search+0x63/0xc0
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 btrfs_ioctl+0x1874/0x3060
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 ? page_add_new_anon_rmap+0xa3/0x1f=
0
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 ? handle_mm_fault+0xf6c/0x1950
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 ? __x64_sys_ioctl+0x83/0xb0
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 __x64_sys_ioctl+0x83/0xb0
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 do_syscall_64+0x33/0x80
> [Tue Jul=C2=A0 6 14:49:17 2021]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4=
4/0xa9
> [Tue Jul=C2=A0 6 14:49:17 2021] RIP: 0033:0x7f748deb8cc7
> [Tue Jul=C2=A0 6 14:49:17 2021] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c=
7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 =
10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 =
64 89 01 48
> [Tue Jul=C2=A0 6 14:49:17 2021] RSP: 002b:00007ffc7e07f098 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000010
> [Tue Jul=C2=A0 6 14:49:17 2021] RAX: ffffffffffffffda RBX: 00007ffc7e080=
1d8 RCX: 00007f748deb8cc7
> [Tue Jul=C2=A0 6 14:49:17 2021] RDX: 00007ffc7e07f0f8 RSI: 00000000d0009=
411 RDI: 0000000000000005
> [Tue Jul=C2=A0 6 14:49:17 2021] RBP: 0000000000bafaad R08: 0000000000000=
00b R09: 00007f748df82be0
> [Tue Jul=C2=A0 6 14:49:17 2021] R10: 0000000000000010 R11: 0000000000000=
246 R12: 0000000000000005
> [Tue Jul=C2=A0 6 14:49:17 2021] R13: 00007ffc7e07ffe1 R14: 0000000000000=
00b R15: 00007ffc7e07f160
> [Tue Jul=C2=A0 6 14:49:17 2021] ---[ end trace 81f64eb2e9ceb4de ]---
>
> with no other message afterwards. This means the retry is working and "f=
ixed" the problem for me. I'll keep monitoring this and will try to catch =
the -EIO from other areas, like the original btrfs_finish_ordered_io.
>
