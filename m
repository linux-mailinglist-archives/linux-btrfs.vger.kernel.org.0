Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BF718E64
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEaW0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaW0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 18:26:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC19F
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685571963; i=quwenruo.btrfs@gmx.com;
        bh=48hFjeo9PrNXcuESTWVFfS7/mfIej0hn7bO8F26rgbU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Py3q9r74e+kuKd14Sy7t+kva4wkVwkit2OeoFmmYE+glPLcgXLCQkYRZSYRHTeJNZ
         +3IVMGUCF8dG24Y0b/F858Oj5dxKjYv/8FyVmfMUcffj/BLVGt3XiRCRTSM6Il0V/F
         E/nuWIm5W+9XtnJrhd2RAqPsSOv9W/PRVrZqRKcA2BSKt1jK2L88+S+x3NjnjSqQJd
         CggJm3wS6Qny6hqL1xSYt6s3gLVeUoVElI6amgvwPbR2/svOeFVJQsq0yUREb0Lo8C
         RmNto1Sk+x/FeUdtJLyPsCxpMjCLsfWrE+vpukxnJbe4fa6u2d+M6kjYJw0aPSNYD5
         Rrga33HJWgmJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1pdEKm03gh-00REme; Thu, 01
 Jun 2023 00:26:03 +0200
Message-ID: <ea984319-decb-ce86-aed4-d4520bf3ad3d@gmx.com>
Date:   Thu, 1 Jun 2023 06:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: new scrub code vs zoned file systems
In-Reply-To: <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vLFIOxxj9r2y4RXQSgX8U06iMsQCpFhwk7Y3EcTuSJY9Ax1WraW
 yJozeY+4S2DOOIepVxH7VmxYv3cu6J5+4Isk56rZFTJWVUI5yRj0FbgNuGzib89XIJ6vw+D
 3ryZm1NSTPHKJ1Mlk58tYj2IKMajv+/bQFo+EfbKXSuHv+hhOS/GCci4UmoNIyLNTLXl+YY
 Q7kTRSmaFla1fxQ/b711Q==
UI-OutboundReport: notjunk:1;M01:P0:zBtZ5aMzfD0=;p97FOz6dTLqQLSFs/9SlSX3c+qR
 N1zIsR0i7tiKGxN3G8qtMqVMK/4CJwyV7NOreaVP4PwMR5Qw4pFsfiejUYc+sgiz2hrqXg+IV
 XZbIdcRJgez8023afZ8qM4jS8hl8+s0qXYKWTafKsfDbUNZoQ+Kx2ICJccL82+OtI6j51gmxx
 3E2ISTsr5Y56ru9Lz496njwdcMGdpBAL9evjpiyq4COm4F0QN7pzX2fxubIvXnQXOMJ3nP39h
 8IaObbCzatmhJ8g+oFHCMIw2yhHsOmJ+xJuewijc0rV3Aa72NCK1W2vcebbOd2kO44kymToQE
 m4fCj4H7rlpxNMbRYE8zkTfzjXVpUda/5K/i1iC+ZQasfe7+HUjAsyABiDMtNd6ChVuh8H5MX
 8HJvtKJQ8Gu/W1vrB5FPnKJusFXPC/8ngZIGjzmrHHyDSjJc+14ni3uLHNLmkZAZs9/YhyRjL
 ludVKJqfTTj3cMPHUG/cmRyquiBa4p4mVyrdGSdrN3xNc6aV5GYzfI8iQ2kzsrL6PBdw6aaxh
 k70KrB6OReym9v2bXFWxrV9gkzwrUhHQ99S2BiuhjD7/61dNyfS7tMJgh/ikXBzplQYHtPbCu
 kg1ypBtMGG5m5zT4WldV7PT+ZcuAYJtJTnNdmCA/4qfB7TIp7sVKA36RzqNIwTSeYcofMGjs0
 I/GZi81iutrcrZTBdZwo/3PtIs44Q7eLWe27r7V+vwvZtnnrrmo+uFDdkK80RHwJCI3b16OEy
 t7q1K1cGbbBUzgYaZjzYEiG7QjZCyQ/oLshQcZ9uCnrfM0WkgiVQ9Y3DjewcdGl/BrFzKF/9r
 3M0jKk4CaX1AsGKqt94Aos31VPdkpJ6Qh5eA5Fo8BZCrhfYc0eEC0pQStAxiMPggTYL7eJYg2
 hkFwr2TgiTp7AsO2p6HOe0S+E+NW9duVg7sbw/C27TGM8u/98JkddGqyFYxOtmvb1oWaEi+fT
 gHGNA+eaZmQcqHRAuaT+v+o3KAc=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 22:04, Johannes Thumshirn wrote:
> On 31.05.23 15:31, Christoph Hellwig wrote:
>> On Wed, May 31, 2023 at 01:25:14PM +0000, Johannes Thumshirn wrote:
>>> Hmm at least flush_scrub_stripes() should not go into the simple write
>>> path at all:
>>
>> Except for the dev-replace case, which seems to trigger this
>> write.
>>
>
> Heh and this has never actually worked IMHO.
>
> I did a crude hack to bandaid scrub:
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index d7d8faf1978a..b20115bd0675 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1709,9 +1709,20 @@ static int flush_scrub_stripes(struct scrub_ctx *=
sctx)
>
>                          ASSERT(stripe->dev =3D=3D fs_info->dev_replace.=
srcdev);
>
> -                       bitmap_andnot(&good, &stripe->extent_sector_bitm=
ap,
> -                                     &stripe->error_bitmap, stripe->nr_=
sectors);
> -                       scrub_write_sectors(sctx, stripe, good, true);
> +                       if (btrfs_is_zoned(fs_info)) {
> +                               if (!bitmap_empty(&stripe->extent_sector=
_bitmap,
> +                                                 stripe->nr_sectors)) {
> +                                       btrfs_repair_one_zone(fs_info,
> +                                                             sctx->stri=
pes[0].bg->start);
> +                                       break;

This doesn't look good, is this a hack to use repair to do the dev-replace=
?

> +                               }
> +                       } else {
> +                               bitmap_andnot(&good,
> +                                             &stripe->extent_sector_bit=
map,
> +                                             &stripe->error_bitmap,
> +                                             stripe->nr_sectors);
> +                               scrub_write_sectors(sctx, stripe, good, =
true);
> +                       }
>                  }
>          }
>
>
>
> But then it doesn't work as well because:
>
> static int relocating_repair_kthread(void *data)
> {
> 	[...]
>          sb_start_write(fs_info->sb);
>          if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
>                  btrfs_info(fs_info,
>                             "zoned: skip relocating block group %llu to =
repair: EBUSY",
>                             target);
>                  sb_end_write(fs_info->sb);
>                  return -EBUSY;
>
> That will always fail, because in the case of dev-replace we already hav=
e
> BTRFS_EXCLOP_DEV_REPLACE set.
>
> I've just spotted btrfs_exclop_start_try_lock(), that could solve our pr=
oblem
> here.

To me, the problem can be solved in a much simpler way, if it's
dev-replace for zoned device, let's write the whole stripe to the target
device, and wait for it.

For the btrfs_record_physical_zoned(), we can skip the OE things if
bbio::inode is NULL.

Would the following change solves the problem?

Thanks,
Qu

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d7d8faf1978a..3fa480cd905e 100644
=2D-- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1709,8 +1709,15 @@ static int flush_scrub_stripes(struct scrub_ctx
*sctx)

                         ASSERT(stripe->dev =3D=3D fs_info->dev_replace.sr=
cdev);

-                       bitmap_andnot(&good, &stripe->extent_sector_bitmap=
,
-                                     &stripe->error_bitmap,
stripe->nr_sectors);
+                       if (btrfs_is_zoned(fs_info))
+                               /*
+                                * For zoned case, we need to write the
whole
+                                * stripe back, no gaps allowed.
+                                */
+                               bitmap_set(&good, 0, stripe->nr_sectors);
+                       else
+                               bitmap_andnot(&good,
&stripe->extent_sector_bitmap,
+                                             &stripe->error_bitmap,
stripe->nr_sectors);
                         scrub_write_sectors(sctx, stripe, good, true);
                 }
         }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 98d6b8cc3874..cced6aeff8d7 100644
=2D-- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1659,6 +1659,13 @@ void btrfs_record_physical_zoned(struct btrfs_bio
*bbio)
         const u64 physical =3D bbio->bio.bi_iter.bi_sector << SECTOR_SHIF=
T;
         struct btrfs_ordered_extent *ordered;

+       /*
+        * For scrub case we have no inode, and doesn't need to bother
ordered
+        * extents.
+        */
+       if (!bbio->inode)
+               return;
+
         ordered =3D btrfs_lookup_ordered_extent(bbio->inode,
bbio->file_offset);
         if (WARN_ON(!ordered))
                 return;
