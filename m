Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926356731FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjASG5t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 01:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASG5q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 01:57:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1326A5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 22:57:41 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1pAK5y2cWR-00RM1f; Thu, 19
 Jan 2023 07:57:38 +0100
Message-ID: <f6235214-5c2f-a53a-5260-fc78e0c8ab90@gmx.com>
Date:   Thu, 19 Jan 2023 14:57:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/11] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1673851704.git.wqu@suse.com>
 <8bae193cad8c35dc1b861af03d66b202c5bf8ead.1673851704.git.wqu@suse.com>
 <CAAa-AGkqVTk7bOGpTmp+yr1S=mZ2Zw5vYQ0kR9sK73JwJx24fg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAa-AGkqVTk7bOGpTmp+yr1S=mZ2Zw5vYQ0kR9sK73JwJx24fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hAfT0JFT1xv0obWKpLB7vIzCuWyHnf3J1o6jf31TxNX5Hss4yRW
 l8YZdSeWJkUlEFg0+aCliKHAOAxX7DxcIO1IOF15IjcDhlFCvPCWHVjCT7ipJJZvoiW2meB
 pQsX+Ut159j8zADF1fia5EPRFE1A3+yWuaNm6ehGDEZbWC4bj9lVpk9StlNekmWZEEMojvb
 +SaSi2QMytQwWifXNt69w==
UI-OutboundReport: notjunk:1;M01:P0:1tIaGyJAYsY=;tBHRYe90+NK+ZSpCK0nzdX8sunV
 fpLOJGR76/Dsi4bP/IQ1nU51Rom2PMaDeyyy4VV5JfYI0YFhfwbfFZzkbdB6IWvlFlLui67I2
 X4jNiM5J8YcnIfZYRRfWeF3Ir1D1GHryZy6Cn2VNONx1PpfwhgcLffb/QM7zPtlZVCZ6JaE2I
 vUpUnZVxKte/t10OQNf1vr2qf4osQzHC+q8VPRwixWm0wzR7zB8LvG1rlseRBMXfcc+G0Vvcw
 mzX4r4p2OEsbq+VZakrNzgVtVtd4Jk4vFYKNvtmEzGw64ezv6bW99+KdQUrnc0xqtnOiqPPE3
 bzXQepJ0z07c5Z1VGLgPyquvm2uedYdvmwICbN9fDgczSMSYg+JzE8S5IdFE0pd/XzUbr1sIW
 wwRk+b2ZIO8UnH6IHryQ/R//nFPb9PixnXJtAr0+xrzhR5FuOlQr5y8vveyt9s3omfC1Ndl75
 k7+kz0uaE4mYa+olSiZErA+shulOr+0WEKog3kH6g1PhT3zsKm+W6JkpcjPoJVGRDODecPKaU
 Uvo9HcnkANK5t017DBTJBioI7mrNSSRLv80yiWZc2uyl9Nu0e5iqLAQCqy83cXXzJ7rv8cHz3
 GiWDcVh45VbbTOeZstC2Ebzs49r16hsqFn8OzNZ2zk9Ai6D6ES2dj1Fr4e7Cp0qVnl2WNDiPJ
 mW43xjRhsNJ+UXWUd8Rsd/NaGlbUWAQik+0zBv2o2KT60U0uJh1ljhMR+AeXW6VpSldiH23Zt
 AHEJ2RfFfOmwop5Mgu0HSqscXeryifsw9n2EUC0LH0pIKNpHQPNqel4+l6uea1UkIuSFwb+Zs
 4GOX1oPFBl8hqFvvL7c6o1zXLjqtubX5+oXS2FImxKSBm5nwC02Z1zqUG0hPqWfkMrThvFKOS
 XpDfzlBXVYW4YF1xiyZ4M9s1R8FyedBjugb0CqC8os1I2xhRVbAuD4xaJrpNfspnQVcpPE4UC
 PmQ/Ef7nkCY7+pJIaCvM6NWUx50=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/19 12:46, li zhang wrote:
> Qu Wenruo <wqu@suse.com> 于2023年1月16日周一 15:06写道：
>>
>> There is really no need to go through the super complex scrub_sectors()
>> to just handle super blocks.
>>
>> This patch will introduce a dedicated function (less than 50 lines) to
>> handle super block scrubing.
>>
>> This new function will introduce a behavior change, instead of using the
>> complex but concurrent scrub_bio system, here we just go
>> submit-and-wait.
>>
>> There is really not much sense to care the performance of super block
>> scrubbing. It only has 3 super blocks at most, and they are all scattered
>> around the devices already.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 45 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 288d7e2a6cdf..e554a9904d2a 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -4143,18 +4143,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>          return ret;
>>   }
>>
>> +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>> +                          struct page *page, u64 physical, u64 generation)
>> +{
>> +       struct btrfs_fs_info *fs_info = sctx->fs_info;
>> +       struct bio_vec bvec;
>> +       struct bio bio;
>> +       struct btrfs_super_block *sb = page_address(page);
>> +       int ret;
>> +
>> +       bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
>> +       bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
>> +       bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
>> +       ret = submit_bio_wait(&bio);
>> +       bio_uninit(&bio);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +       ret = btrfs_check_super_csum(fs_info, sb);
>> +       if (ret != 0) {
>> +               btrfs_err_rl(fs_info,
>> +                       "super block at physical %llu devid %llu has bad csum",
>> +                       physical, dev->devid);
>> +               return -EIO;
>> +       }
>> +       if (btrfs_super_generation(sb) != generation) {
>> +               btrfs_err_rl(fs_info,
>> +"super block at physical %llu devid %llu has bad generation, has %llu expect %llu",
>> +                            physical, dev->devid,
>> +                            btrfs_super_generation(sb), generation);
>> +               return -EUCLEAN;
>> +       }
>> +
>> +       ret = btrfs_validate_super(fs_info, sb, -1);
>> +       return ret;
>> +}
>> +
>>   static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>                                             struct btrfs_device *scrub_dev)
>>   {
>>          int     i;
>>          u64     bytenr;
>>          u64     gen;
>> -       int     ret;
>> +       int     ret = 0;
>> +       struct page *page;
>>          struct btrfs_fs_info *fs_info = sctx->fs_info;
>>
>>          if (BTRFS_FS_ERROR(fs_info))
>>                  return -EROFS;
>>
>> +       page = alloc_page(GFP_KERNEL);
> 
> Does this page need to be freed?

Nice find, you're completely right, I forgot to free the page.

Would update it in my github branch first.

Thanks,
Qu
> 
> 
>> +       if (!page)
>> +               return -ENOMEM;
>> +
>>          /* Seed devices of a new filesystem has their own generation. */
>>          if (scrub_dev->fs_devices != fs_info->fs_devices)
>>                  gen = scrub_dev->generation;
>> @@ -4169,15 +4210,11 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>                  if (!btrfs_check_super_location(scrub_dev, bytenr))
>>                          continue;
>>
>> -               ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>> -                                   scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
>> -                                   NULL, bytenr);
>> +               ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>>                  if (ret)
>> -                       return ret;
>> +                       break;
>>          }
>> -       wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
>> -
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   static void scrub_workers_put(struct btrfs_fs_info *fs_info)
>> --
>> 2.39.0
>>
> 
> thanks
> Li
