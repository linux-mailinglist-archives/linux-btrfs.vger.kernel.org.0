Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98867627305
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiKMWhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 17:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMWh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 17:37:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1670C774
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 14:37:26 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Vu-1ogXqX1Veg-00LWiQ; Sun, 13
 Nov 2022 23:37:24 +0100
Message-ID: <01588a81-eb79-36c5-3551-f870437ff84a@gmx.com>
Date:   Mon, 14 Nov 2022 06:37:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range
 scrub
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
 <CAAa-AGnz2QpnpLGurkRB3eKjkasPRgJnQsD1yvSJ0B8qO8caRQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAa-AGnz2QpnpLGurkRB3eKjkasPRgJnQsD1yvSJ0B8qO8caRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dSShbTpl6aTUde9TMOAQFIDlPseZXKexMSKUhm1y4xHGntO60Mq
 OWjLiB6myW5g5Jr7N7KmxGk5/h3VWgTK5sDOgaqRsYLlIbEG3ZPxlOz3/EDshIx4x5jyTGy
 yrgkmaLXYPKpvxNp2RmJ3zSXl9uP+lwEVh+urr6pMdXna0IpP8xLKgHm2FcA36rrmi72XLV
 EzRiSqcMMN5yC1X5EoG3g==
UI-OutboundReport: notjunk:1;M01:P0:BBKDwjI88Zg=;pxVTEm/brrK6Kdjk4jZvyBS2wRf
 hbOgTc94IDSIWIGhGmJq5CybDlhu1V9oKsqAw9GP755tgvcwyuDcwJW2d7CtUhyILudNSTmjY
 BONG7uNpXKZNgc+znXBuQ2LZrzAykehOczMi2NbgH8sR/buzsyTAodXipaFoy99k5ZMybfwQ7
 ihefuUSz7qDe6ln2tr3zpJd1wBc1yPF6mAJzPJnDrOUfwPsSQ/qwr/RMZtALKqZYFBX9h2t6f
 4Cfv4mmUoAbinnb0USBw4KPa/9iFkVG6aV51rhULkJhHngVrWNiRq9rek6i25iq8xm4uHOhoV
 z7VVtgoGo+/Yk4mt2ZtYihCcM8G3xtfUrvtJPtn5qW1oRef4xkENov95TcnHjrIv7AZ6n9ZYU
 XM+baM9RLWKoCjaRYxUnQjjwxBElagYuA8i40V8jFQFG9clhlQmYNRqw/0p6Ak1QiGmO8No9x
 sjrNYhYjLULCl/ydt0KG3U0MKirVDBl8WcQph//dN9TUx6Rxpm0PVZzTEzDUwW8oE7LWCVMj8
 S/Tdc+5mrDLjXRuh+czx94egfKkSu53L3OKxIcZoVoC7EMBmrXtzIqCFfX/Y2+RUJCwLVqCvl
 Bzh2CsbJf0QJUpwhDpz1O+8ZsLtido/m0CXIxCMMZ9eg+R2KAU9/iqp3r8xNtR1EleGpywnw1
 KvIjM1j76Ll8MS41vjMf2lT5C5qv2mpC5N6wMsZbffDEDnTCeuPJfosQw6tMXsmxrf6zS/ZWE
 wRSAJlGORgNBGtP9j7TRu1ET44vNPP3DrMNaIH3SYDXqiD7OE5TU2cO9Vnf8rtbOA8tMXNzWj
 1uvkP92mU0A+iB8t6dqkomhN3jOxluEM3bkkWfVinRQGz5d89uyxQHxolNVcLgwJCZpiIPUvT
 F64WP+UGaRLpgazHWh6+qTthcQ5hNaJkSyT8yUfagLrhX1JNpEORb03M8trRcF+QBoSy2un1O
 mjartioKUsqIQtI6aDL+1802D0U=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/13 23:37, li zhang wrote:
> Here is my test script.

Top posting is not recommended for most Linux community IIRC.

And if you're resuing some fstests, just mention the test case naming.

If you're enhancing the existing test case, please submit a proper patch.

Thanks,
Qu
> 
> Li Zhang <zhanglikernel@gmail.com> 于2022年11月13日周日 23:36写道：
>>
>> [implement]
>> 1. Add the member checksum_error to the scrub_sector,
>> which indicates the checksum error of the sector
>>
>> 2. Use scrub_find_btrfs_ordered_sum to find the desired
>> btrfs_ordered_sum containing address logic, in
>> scrub_sectors_for_parity and scrub_sectors, call
>> Scrub_find_btrfs_ordered_sum finds the
>> btrfs_ordered_sum containing the current logical address, and
>> Calculate the exact checksum later.
>>
>> 3. In the scrub_checksum_data function,
>> we should check all sectors in the scrub_block.
>>
>> 4. The job of the scrub_handle_errored_block
>> function is to count the number of error and
>> repair sectors if they can be repaired.
>>
>> The function enters the wrong scrub_block, and
>> the overall process is as follows
>>
>> 1) Check the scrub_block again, check again if the error is gone.
>>
>> 2) Check the corresponding mirror scrub_block, if there is no error,
>> Fix bad sblocks with mirror scrub_block.
>>
>> 3) If no error-free scrub_block is found, repair it sector by sector.
>>
>> One difficulty with this function is rechecking the scrub_block.
>>
>> Imagine this situation, if a sector is checked the first time
>> without errors, butthe recheck returns an error. What should
>> we do, this patch only fixes the bug that the sector first
>> appeared (As in the case where the scrub_block
>> contains only one scrub_sector).
>>
>> Another reason to only handle the first error is,
>> If the device goes bad, the recheck function will report more and
>> more errors,if we want to deal with the errors in the recheck,
>> you need to recheck again and again, which may lead to
>> Stuck in scrub_handle_errored_block for a long time.
>>
>> So rechecked bug reports will only be corrected in the
>> next scrub.
>>
>> [test]
>> I designed two test scripts based on the fstest project,
>> the output is the same as the case where the scrub_block
>> contains only one scrub sector,
>>
>> 1. There are two situations in raid1,
>> raid1c3 and raid1c4. If an error occurs in
>> different sectors of the sblock, the error can be corrected.
>>
>> An error is uncorrectable if all errors occur in the same
>> scrub_sector in the scrub_block.
>>
>> 2. For raid6, if more than 2 stripts are damaged and the error
>> cannot be repaired, a batch read error will also be reported.
>>
>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>> ---
>>   fs/btrfs/scrub.c | 385 ++++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 210 insertions(+), 175 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 196c4c6..5ca9f43 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -72,6 +72,7 @@ struct scrub_sector {
>>          atomic_t                refs;
>>          unsigned int            have_csum:1;
>>          unsigned int            io_error:1;
>> +       unsigned int            checksum_error:1;
>>          u8                      csum[BTRFS_CSUM_SIZE];
>>
>>          struct scrub_recover    *recover;
>> @@ -252,6 +253,7 @@ static void detach_scrub_page_private(struct page *page)
>>   #endif
>>   }
>>
>> +
>>   static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
>>                                               struct btrfs_device *dev,
>>                                               u64 logical, u64 physical,
>> @@ -404,7 +406,7 @@ static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
>>   static void scrub_parity_put(struct scrub_parity *sparity);
>>   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>>                           u64 physical, struct btrfs_device *dev, u64 flags,
>> -                        u64 gen, int mirror_num, u8 *csum,
>> +                        u64 gen, int mirror_num,
>>                           u64 physical_for_dev_replace);
>>   static void scrub_bio_end_io(struct bio *bio);
>>   static void scrub_bio_end_io_worker(struct work_struct *work);
>> @@ -420,6 +422,10 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>>   static void scrub_wr_bio_end_io(struct bio *bio);
>>   static void scrub_wr_bio_end_io_worker(struct work_struct *work);
>>   static void scrub_put_ctx(struct scrub_ctx *sctx);
>> +static int scrub_find_btrfs_ordered_sum(struct scrub_ctx *sctx, u64 logical,
>> +                                       struct btrfs_ordered_sum **order_sum);
>> +static int scrub_get_sblock_checksum_error(struct scrub_block *sblock);
>> +
>>
>>   static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
>>   {
>> @@ -991,19 +997,18 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>          struct btrfs_fs_info *fs_info;
>>          u64 logical;
>>          unsigned int failed_mirror_index;
>> -       unsigned int is_metadata;
>> -       unsigned int have_csum;
>>          /* One scrub_block for each mirror */
>>          struct scrub_block *sblocks_for_recheck[BTRFS_MAX_MIRRORS] = { 0 };
>>          struct scrub_block *sblock_bad;
>>          int ret;
>>          int mirror_index;
>>          int sector_num;
>> -       int success;
>>          bool full_stripe_locked;
>>          unsigned int nofs_flag;
>>          static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>>                                        DEFAULT_RATELIMIT_BURST);
>> +       int correct_error = 0;
>> +       int uncorrect_error = 0;
>>
>>          BUG_ON(sblock_to_check->sector_count < 1);
>>          fs_info = sctx->fs_info;
>> @@ -1023,9 +1028,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>          logical = sblock_to_check->logical;
>>          ASSERT(sblock_to_check->mirror_num);
>>          failed_mirror_index = sblock_to_check->mirror_num - 1;
>> -       is_metadata = !(sblock_to_check->sectors[0]->flags &
>> -                       BTRFS_EXTENT_FLAG_DATA);
>> -       have_csum = sblock_to_check->sectors[0]->have_csum;
>>
>>          if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logical))
>>                  return 0;
>> @@ -1054,7 +1056,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                  if (ret == -ENOMEM)
>>                          sctx->stat.malloc_errors++;
>>                  sctx->stat.read_errors++;
>> -               sctx->stat.uncorrectable_errors++;
>> +               sctx->stat.uncorrectable_errors += scrub_get_sblock_checksum_error(sblock_to_check);
>> +               sctx->stat.uncorrectable_errors += sblock_to_check->header_error;
>>                  spin_unlock(&sctx->stat_lock);
>>                  return ret;
>>          }
>> @@ -1104,7 +1107,10 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                          spin_lock(&sctx->stat_lock);
>>                          sctx->stat.malloc_errors++;
>>                          sctx->stat.read_errors++;
>> -                       sctx->stat.uncorrectable_errors++;
>> +                       sctx->stat.uncorrectable_errors +=
>> +                               scrub_get_sblock_checksum_error(sblock_to_check);
>> +                       sctx->stat.uncorrectable_errors +=
>> +                               sblock_to_check->header_error;
>>                          spin_unlock(&sctx->stat_lock);
>>                          btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
>>                          goto out;
>> @@ -1116,7 +1122,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>          if (ret) {
>>                  spin_lock(&sctx->stat_lock);
>>                  sctx->stat.read_errors++;
>> -               sctx->stat.uncorrectable_errors++;
>> +               sctx->stat.uncorrectable_errors += scrub_get_sblock_checksum_error(sblock_to_check);
>> +               sctx->stat.uncorrectable_errors += sblock_to_check->header_error;
>>                  spin_unlock(&sctx->stat_lock);
>>                  btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
>>                  goto out;
>> @@ -1138,7 +1145,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                   * the cause)
>>                   */
>>                  spin_lock(&sctx->stat_lock);
>> -               sctx->stat.unverified_errors++;
>> +               sctx->stat.unverified_errors += scrub_get_sblock_checksum_error(sblock_to_check);
>> +               sctx->stat.unverified_errors += sblock_to_check->header_error;
>>                  sblock_to_check->data_corrected = 1;
>>                  spin_unlock(&sctx->stat_lock);
>>
>> @@ -1147,22 +1155,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                  goto out;
>>          }
>>
>> -       if (!sblock_bad->no_io_error_seen) {
>> -               spin_lock(&sctx->stat_lock);
>> -               sctx->stat.read_errors++;
>> -               spin_unlock(&sctx->stat_lock);
>> -               if (__ratelimit(&rs))
>> -                       scrub_print_warning("i/o error", sblock_to_check);
>> -               btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
>> -       } else if (sblock_bad->checksum_error) {
>> -               spin_lock(&sctx->stat_lock);
>> -               sctx->stat.csum_errors++;
>> -               spin_unlock(&sctx->stat_lock);
>> -               if (__ratelimit(&rs))
>> -                       scrub_print_warning("checksum error", sblock_to_check);
>> -               btrfs_dev_stat_inc_and_print(dev,
>> -                                            BTRFS_DEV_STAT_CORRUPTION_ERRS);
>> -       } else if (sblock_bad->header_error) {
>> +       if (sblock_to_check->header_error && sblock_bad->header_error) {
>>                  spin_lock(&sctx->stat_lock);
>>                  sctx->stat.verify_errors++;
>>                  spin_unlock(&sctx->stat_lock);
>> @@ -1175,8 +1168,48 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                  else
>>                          btrfs_dev_stat_inc_and_print(dev,
>>                                  BTRFS_DEV_STAT_CORRUPTION_ERRS);
>> +       } else if (sblock_to_check->header_error && !sblock_bad->header_error) {
>> +               spin_lock(&sctx->stat_lock);
>> +               sctx->stat.unverified_errors++;
>> +               spin_unlock(&sctx->stat_lock);
>> +       } else if (!sblock_to_check->header_error && sblock_bad->header_error) {
>> +               sblock_bad->header_error = 0;
>> +       } else {
>> +               for (sector_num = 0; sector_num < sblock_bad->sector_count; sector_num++) {
>> +                       struct scrub_sector *bad_sector = sblock_bad->sectors[sector_num];
>> +                       struct scrub_sector *check_sector = sblock_to_check->sectors[sector_num];
>> +
>> +                       if (bad_sector->io_error || check_sector->io_error) {
>> +                               spin_lock(&sctx->stat_lock);
>> +                               sctx->stat.read_errors++;
>> +                               spin_unlock(&sctx->stat_lock);
>> +                               if (__ratelimit(&rs))
>> +                                       scrub_print_warning("i/o error", sblock_to_check);
>> +                               btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
>> +                       } else if (check_sector->checksum_error && bad_sector->checksum_error) {
>> +                               spin_lock(&sctx->stat_lock);
>> +                               sctx->stat.csum_errors++;
>> +                               spin_unlock(&sctx->stat_lock);
>> +                               if (__ratelimit(&rs))
>> +                                       scrub_print_warning("checksum error", sblock_to_check);
>> +                               btrfs_dev_stat_inc_and_print(dev,
>> +                                                       BTRFS_DEV_STAT_CORRUPTION_ERRS);
>> +
>> +                       } else if (check_sector->checksum_error && !bad_sector->checksum_error) {
>> +                               spin_lock(&sctx->stat_lock);
>> +                               sctx->stat.unverified_errors++;
>> +                               spin_unlock(&sctx->stat_lock);
>> +                       } else if (!check_sector->checksum_error && bad_sector->checksum_error) {
>> +                               struct scrub_sector *temp_sector = sblock_bad->sectors[sector_num];
>> +
>> +                               sblock_bad->sectors[sector_num]
>> +                                       = sblock_to_check->sectors[sector_num];
>> +                               sblock_to_check->sectors[sector_num] = temp_sector;
>> +                       }
>> +               }
>>          }
>>
>> +
>>          if (sctx->readonly) {
>>                  ASSERT(!sctx->is_dev_replace);
>>                  goto out;
>> @@ -1233,18 +1266,23 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                      sblock_other->no_io_error_seen) {
>>                          if (sctx->is_dev_replace) {
>>                                  scrub_write_block_to_dev_replace(sblock_other);
>> -                               goto corrected_error;
>> +                               correct_error += scrub_get_sblock_checksum_error(sblock_bad);
>> +                               correct_error += sblock_bad->header_error;
>> +                               goto error_summary;
>>                          } else {
>>                                  ret = scrub_repair_block_from_good_copy(
>>                                                  sblock_bad, sblock_other);
>> -                               if (!ret)
>> -                                       goto corrected_error;
>> +                               if (!ret) {
>> +                                       correct_error +=
>> +                                               scrub_get_sblock_checksum_error(sblock_bad);
>> +                                       correct_error += sblock_bad->header_error;
>> +                                       goto error_summary;
>> +                               }
>>                          }
>>                  }
>>          }
>>
>> -       if (sblock_bad->no_io_error_seen && !sctx->is_dev_replace)
>> -               goto did_not_correct_error;
>> +
>>
>>          /*
>>           * In case of I/O errors in the area that is supposed to be
>> @@ -1270,17 +1308,16 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>           * mirror, even if other 512 byte sectors in the same sectorsize
>>           * area are unreadable.
>>           */
>> -       success = 1;
>>          for (sector_num = 0; sector_num < sblock_bad->sector_count;
>>               sector_num++) {
>>                  struct scrub_sector *sector_bad = sblock_bad->sectors[sector_num];
>>                  struct scrub_block *sblock_other = NULL;
>>
>>                  /* Skip no-io-error sectors in scrub */
>> -               if (!sector_bad->io_error && !sctx->is_dev_replace)
>> +               if (!(sector_bad->io_error || sector_bad->checksum_error) && !sctx->is_dev_replace)
>>                          continue;
>>
>> -               if (scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
>> +               if (scrub_is_page_on_raid56(sector_bad)) {
>>                          /*
>>                           * In case of dev replace, if raid56 rebuild process
>>                           * didn't work out correct data, then copy the content
>> @@ -1289,6 +1326,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                           * sblock_for_recheck array to target device.
>>                           */
>>                          sblock_other = NULL;
>> +                       uncorrect_error++;
>>                  } else if (sector_bad->io_error) {
>>                          /* Try to find no-io-error sector in mirrors */
>>                          for (mirror_index = 0;
>> @@ -1302,7 +1340,21 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                                  }
>>                          }
>>                          if (!sblock_other)
>> -                               success = 0;
>> +                               uncorrect_error++;
>> +               } else if (sector_bad->checksum_error) {
>> +                       for (mirror_index = 0;
>> +                            mirror_index < BTRFS_MAX_MIRRORS &&
>> +                            sblocks_for_recheck[mirror_index]->sector_count > 0;
>> +                            mirror_index++) {
>> +                               if (!sblocks_for_recheck[mirror_index]->sectors[sector_num]->io_error &&
>> +                                       !sblocks_for_recheck[mirror_index]->sectors[sector_num]->checksum_error) {
>> +                                       sblock_other = sblocks_for_recheck[mirror_index];
>> +                                       break;
>> +                               }
>> +                       }
>> +                       if (!sblock_other) {
>> +                               uncorrect_error++;
>> +                       }
>>                  }
>>
>>                  if (sctx->is_dev_replace) {
>> @@ -1319,56 +1371,28 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>>                                                                sector_num) != 0) {
>>                                  atomic64_inc(
>>                                          &fs_info->dev_replace.num_write_errors);
>> -                               success = 0;
>>                          }
>>                  } else if (sblock_other) {
>>                          ret = scrub_repair_sector_from_good_copy(sblock_bad,
>>                                                                   sblock_other,
>>                                                                   sector_num, 0);
>> -                       if (0 == ret)
>> +                       if (0 == ret && sector_bad->io_error) {
>> +                               correct_error++;
>>                                  sector_bad->io_error = 0;
>> -                       else
>> -                               success = 0;
>> +                       } else if (0 == ret && sector_bad->checksum_error) {
>> +                               correct_error++;
>> +                               sector_bad->checksum_error = 0;
>> +                       } else {
>> +                               uncorrect_error++;
>> +                       }
>>                  }
>>          }
>>
>> -       if (success && !sctx->is_dev_replace) {
>> -               if (is_metadata || have_csum) {
>> -                       /*
>> -                        * need to verify the checksum now that all
>> -                        * sectors on disk are repaired (the write
>> -                        * request for data to be repaired is on its way).
>> -                        * Just be lazy and use scrub_recheck_block()
>> -                        * which re-reads the data before the checksum
>> -                        * is verified, but most likely the data comes out
>> -                        * of the page cache.
>> -                        */
>> -                       scrub_recheck_block(fs_info, sblock_bad, 1);
>> -                       if (!sblock_bad->header_error &&
>> -                           !sblock_bad->checksum_error &&
>> -                           sblock_bad->no_io_error_seen)
>> -                               goto corrected_error;
>> -                       else
>> -                               goto did_not_correct_error;
>> -               } else {
>> -corrected_error:
>> -                       spin_lock(&sctx->stat_lock);
>> -                       sctx->stat.corrected_errors++;
>> -                       sblock_to_check->data_corrected = 1;
>> -                       spin_unlock(&sctx->stat_lock);
>> -                       btrfs_err_rl_in_rcu(fs_info,
>> -                               "fixed up error at logical %llu on dev %s",
>> -                               logical, rcu_str_deref(dev->name));
>> -               }
>> -       } else {
>> -did_not_correct_error:
>> -               spin_lock(&sctx->stat_lock);
>> -               sctx->stat.uncorrectable_errors++;
>> -               spin_unlock(&sctx->stat_lock);
>> -               btrfs_err_rl_in_rcu(fs_info,
>> -                       "unable to fixup (regular) error at logical %llu on dev %s",
>> -                       logical, rcu_str_deref(dev->name));
>> -       }
>> +error_summary:
>> +       spin_lock(&sctx->stat_lock);
>> +       sctx->stat.uncorrectable_errors += uncorrect_error;
>> +       sctx->stat.corrected_errors += correct_error;
>> +       spin_unlock(&sctx->stat_lock);
>>
>>   out:
>>          for (mirror_index = 0; mirror_index < BTRFS_MAX_MIRRORS; mirror_index++) {
>> @@ -1513,10 +1537,10 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
>>                          }
>>                          sector->flags = flags;
>>                          sector->generation = generation;
>> -                       sector->have_csum = have_csum;
>> +                       sector->have_csum = original_sblock->sectors[sector_index]->have_csum;
>>                          if (have_csum)
>>                                  memcpy(sector->csum,
>> -                                      original_sblock->sectors[0]->csum,
>> +                                      original_sblock->sectors[sector_index]->csum,
>>                                         sctx->fs_info->csum_size);
>>
>>                          scrub_stripe_index_and_offset(logical,
>> @@ -1688,11 +1712,15 @@ static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
>>
>>          for (i = 0; i < sblock_bad->sector_count; i++) {
>>                  int ret_sub;
>> -
>> -               ret_sub = scrub_repair_sector_from_good_copy(sblock_bad,
>> +               if (sblock_bad->sectors[i]->checksum_error == 1
>> +                       && sblock_good->sectors[i]->checksum_error == 0){
>> +                       ret_sub = scrub_repair_sector_from_good_copy(sblock_bad,
>>                                                               sblock_good, i, 1);
>> -               if (ret_sub)
>> -                       ret = ret_sub;
>> +                       if (ret_sub)
>> +                               ret = ret_sub;
>> +               } else if (sblock_bad->sectors[i]->checksum_error == 1) {
>> +                       ret = 1;
>> +               }
>>          }
>>
>>          return ret;
>> @@ -1984,22 +2012,46 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>>          u8 csum[BTRFS_CSUM_SIZE];
>>          struct scrub_sector *sector;
>>          char *kaddr;
>> +       int i;
>> +       int io_error = 0;
>>
>>          BUG_ON(sblock->sector_count < 1);
>> -       sector = sblock->sectors[0];
>> -       if (!sector->have_csum)
>> -               return 0;
>> -
>> -       kaddr = scrub_sector_get_kaddr(sector);
>>
>>          shash->tfm = fs_info->csum_shash;
>>          crypto_shash_init(shash);
>> +       for (i = 0; i < sblock->sector_count; i++) {
>> +               sector = sblock->sectors[i];
>> +               if (sector->io_error == 1) {
>> +                       io_error = 1;
>> +                       continue;
>> +               }
>> +               if (!sector->have_csum)
>> +                       continue;
>>
>> -       crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>> +               kaddr = scrub_sector_get_kaddr(sector);
>> +               crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>> +               if (memcmp(csum, sector->csum, fs_info->csum_size)) {
>> +                       sector->checksum_error = 1;
>> +                       sblock->checksum_error = 1;
>> +               } else {
>> +                       sector->checksum_error = 0;
>> +               }
>> +       }
>> +       return sblock->checksum_error | io_error;
>> +}
>>
>> -       if (memcmp(csum, sector->csum, fs_info->csum_size))
>> -               sblock->checksum_error = 1;
>> -       return sblock->checksum_error;
>> +static int scrub_get_sblock_checksum_error(struct scrub_block *sblock)
>> +{
>> +       int count = 0;
>> +       int i;
>> +
>> +       if (sblock == NULL)
>> +               return count;
>> +       for (i = 0; i < sblock->sector_count; i++) {
>> +               if (sblock->sectors[i]->checksum_error == 1)
>> +                       count++;
>> +       }
>> +       return count;
>>   }
>>
>>   static int scrub_checksum_tree_block(struct scrub_block *sblock)
>> @@ -2062,8 +2114,12 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>>          }
>>
>>          crypto_shash_final(shash, calculated_csum);
>> -       if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
>> +       if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size)) {
>> +               sblock->sectors[0]->checksum_error = 1;
>>                  sblock->checksum_error = 1;
>> +       } else {
>> +               sblock->sectors[0]->checksum_error = 0;
>> +       }
>>
>>          return sblock->header_error || sblock->checksum_error;
>>   }
>> @@ -2400,12 +2456,14 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
>>
>>   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>>                         u64 physical, struct btrfs_device *dev, u64 flags,
>> -                      u64 gen, int mirror_num, u8 *csum,
>> +                      u64 gen, int mirror_num,
>>                         u64 physical_for_dev_replace)
>>   {
>>          struct scrub_block *sblock;
>>          const u32 sectorsize = sctx->fs_info->sectorsize;
>>          int index;
>> +       int have_csum;
>> +       struct btrfs_ordered_sum *order_sum = NULL;
>>
>>          sblock = alloc_scrub_block(sctx, dev, logical, physical,
>>                                     physical_for_dev_replace, mirror_num);
>> @@ -2415,7 +2473,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>>                  spin_unlock(&sctx->stat_lock);
>>                  return -ENOMEM;
>>          }
>> -
>>          for (index = 0; len > 0; index++) {
>>                  struct scrub_sector *sector;
>>                  /*
>> @@ -2424,7 +2481,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>>                   * more memory for PAGE_SIZE > sectorsize case.
>>                   */
>>                  u32 l = min(sectorsize, len);
>> -
>>                  sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
>>                  if (!sector) {
>>                          spin_lock(&sctx->stat_lock);
>> @@ -2435,11 +2491,25 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>>                  }
>>                  sector->flags = flags;
>>                  sector->generation = gen;
>> -               if (csum) {
>> -                       sector->have_csum = 1;
>> -                       memcpy(sector->csum, csum, sctx->fs_info->csum_size);
>> -               } else {
>> -                       sector->have_csum = 0;
>> +               if (flags & BTRFS_EXTENT_FLAG_DATA) {
>> +                       if (order_sum == NULL ||
>> +                               (order_sum->bytenr + order_sum->len <= logical)) {
>> +                               order_sum = NULL;
>> +                               have_csum = scrub_find_btrfs_ordered_sum(sctx, logical, &order_sum);
>> +                       }
>> +                       if (have_csum == 0) {
>> +                               ++sctx->stat.no_csum;
>> +                               sector->have_csum = 0;
>> +                       } else {
>> +                               int order_csum_index;
>> +
>> +                               sector->have_csum = 1;
>> +                               order_csum_index = (logical-order_sum->bytenr)
>> +                                       >> sctx->fs_info->sectorsize_bits;
>> +                               memcpy(sector->csum,
>> +                                       order_sum->sums + order_csum_index * sctx->fs_info->csum_size,
>> +                                       sctx->fs_info->csum_size);
>> +                       }
>>                  }
>>                  len -= l;
>>                  logical += l;
>> @@ -2571,7 +2641,8 @@ static void scrub_block_complete(struct scrub_block *sblock)
>>   {
>>          int corrupted = 0;
>>
>> -       if (!sblock->no_io_error_seen) {
>> +       if (!sblock->no_io_error_seen && !(sblock->sector_count > 0
>> +               && (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_DATA))) {
>>                  corrupted = 1;
>>                  scrub_handle_errored_block(sblock);
>>          } else {
>> @@ -2597,61 +2668,30 @@ static void scrub_block_complete(struct scrub_block *sblock)
>>          }
>>   }
>>
>> -static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
>> -{
>> -       sctx->stat.csum_discards += sum->len >> sctx->fs_info->sectorsize_bits;
>> -       list_del(&sum->list);
>> -       kfree(sum);
>> -}
>> -
>>   /*
>> - * Find the desired csum for range [logical, logical + sectorsize), and store
>> - * the csum into @csum.
>> + * Find the desired btrfs_ordered_sum contain address logical, and store
>> + * the result into @order_sum.
>>    *
>>    * The search source is sctx->csum_list, which is a pre-populated list
>> - * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
>> - * that is before @logical.
>> + * storing bytenr ordered csum ranges.
>>    *
>> - * Return 0 if there is no csum for the range.
>> - * Return 1 if there is csum for the range and copied to @csum.
>> + * Return 0 if there is no btrfs_ordered_sum contain the address logical.
>> + * Return 1 if there is btrfs_order_sum contain the address logincal and copied to @order_sum.
>>    */
>> -static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>> +static int scrub_find_btrfs_ordered_sum(struct scrub_ctx *sctx, u64 logical,
>> +                                       struct btrfs_ordered_sum **order_sum)
>>   {
>>          bool found = false;
>> +       struct btrfs_ordered_sum *sum;
>>
>> -       while (!list_empty(&sctx->csum_list)) {
>> -               struct btrfs_ordered_sum *sum = NULL;
>> -               unsigned long index;
>> -               unsigned long num_sectors;
>> -
>> -               sum = list_first_entry(&sctx->csum_list,
>> -                                      struct btrfs_ordered_sum, list);
>> -               /* The current csum range is beyond our range, no csum found */
>> +       list_for_each_entry(sum, &sctx->csum_list, list) {
>> +               /* no btrfs_ordered_sum found */
>>                  if (sum->bytenr > logical)
>>                          break;
>> -
>> -               /*
>> -                * The current sum is before our bytenr, since scrub is always
>> -                * done in bytenr order, the csum will never be used anymore,
>> -                * clean it up so that later calls won't bother with the range,
>> -                * and continue search the next range.
>> -                */
>> -               if (sum->bytenr + sum->len <= logical) {
>> -                       drop_csum_range(sctx, sum);
>> +               if (sum->bytenr + sum->len <= logical)
>>                          continue;
>> -               }
>> -
>> -               /* Now the csum range covers our bytenr, copy the csum */
>>                  found = true;
>> -               index = (logical - sum->bytenr) >> sctx->fs_info->sectorsize_bits;
>> -               num_sectors = sum->len >> sctx->fs_info->sectorsize_bits;
>> -
>> -               memcpy(csum, sum->sums + index * sctx->fs_info->csum_size,
>> -                      sctx->fs_info->csum_size);
>> -
>> -               /* Cleanup the range if we're at the end of the csum range */
>> -               if (index == num_sectors - 1)
>> -                       drop_csum_range(sctx, sum);
>> +               *order_sum = sum;
>>                  break;
>>          }
>>          if (!found)
>> @@ -2669,7 +2709,6 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>>          u64 src_physical = physical;
>>          int src_mirror = mirror_num;
>>          int ret;
>> -       u8 csum[BTRFS_CSUM_SIZE];
>>          u32 blocksize;
>>
>>          if (flags & BTRFS_EXTENT_FLAG_DATA) {
>> @@ -2685,7 +2724,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>>                  if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>>                          blocksize = map->stripe_len;
>>                  else
>> -                       blocksize = sctx->fs_info->nodesize;
>> +                       blocksize = BTRFS_STRIPE_LEN;
>>                  spin_lock(&sctx->stat_lock);
>>                  sctx->stat.tree_extents_scrubbed++;
>>                  sctx->stat.tree_bytes_scrubbed += len;
>> @@ -2709,17 +2748,9 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>>                                       &src_dev, &src_mirror);
>>          while (len) {
>>                  u32 l = min(len, blocksize);
>> -               int have_csum = 0;
>> -
>> -               if (flags & BTRFS_EXTENT_FLAG_DATA) {
>> -                       /* push csums to sbio */
>> -                       have_csum = scrub_find_csum(sctx, logical, csum);
>> -                       if (have_csum == 0)
>> -                               ++sctx->stat.no_csum;
>> -               }
>>                  ret = scrub_sectors(sctx, logical, l, src_physical, src_dev,
>>                                      flags, gen, src_mirror,
>> -                                   have_csum ? csum : NULL, physical);
>> +                                   physical);
>>                  if (ret)
>>                          return ret;
>>                  len -= l;
>> @@ -2733,12 +2764,14 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>>   static int scrub_sectors_for_parity(struct scrub_parity *sparity,
>>                                    u64 logical, u32 len,
>>                                    u64 physical, struct btrfs_device *dev,
>> -                                 u64 flags, u64 gen, int mirror_num, u8 *csum)
>> +                                 u64 flags, u64 gen, int mirror_num)
>>   {
>>          struct scrub_ctx *sctx = sparity->sctx;
>>          struct scrub_block *sblock;
>>          const u32 sectorsize = sctx->fs_info->sectorsize;
>>          int index;
>> +       struct btrfs_ordered_sum *order_sum = NULL;
>> +       int have_csum;
>>
>>          ASSERT(IS_ALIGNED(len, sectorsize));
>>
>> @@ -2770,11 +2803,24 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
>>                  list_add_tail(&sector->list, &sparity->sectors_list);
>>                  sector->flags = flags;
>>                  sector->generation = gen;
>> -               if (csum) {
>> -                       sector->have_csum = 1;
>> -                       memcpy(sector->csum, csum, sctx->fs_info->csum_size);
>> -               } else {
>> -                       sector->have_csum = 0;
>> +               if (flags & BTRFS_EXTENT_FLAG_DATA) {
>> +                       if (order_sum == NULL
>> +                               || (order_sum->bytenr + order_sum->len <= logical)) {
>> +                               order_sum = NULL;
>> +                               have_csum = scrub_find_btrfs_ordered_sum(sctx, logical, &order_sum);
>> +                       }
>> +                       if (have_csum == 0) {
>> +                               sector->have_csum = 0;
>> +                       } else {
>> +                               int order_csum_index;
>> +
>> +                               sector->have_csum = 1;
>> +                               order_csum_index = (logical-order_sum->bytenr)
>> +                                       >> sctx->fs_info->sectorsize_bits;
>> +                               memcpy(sector->csum,
>> +                                       order_sum->sums + order_csum_index * sctx->fs_info->csum_size,
>> +                                       sctx->fs_info->csum_size);
>> +                       }
>>                  }
>>
>>                  /* Iterate over the stripe range in sectorsize steps */
>> @@ -2807,7 +2853,6 @@ static int scrub_extent_for_parity(struct scrub_parity *sparity,
>>   {
>>          struct scrub_ctx *sctx = sparity->sctx;
>>          int ret;
>> -       u8 csum[BTRFS_CSUM_SIZE];
>>          u32 blocksize;
>>
>>          if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
>> @@ -2826,20 +2871,10 @@ static int scrub_extent_for_parity(struct scrub_parity *sparity,
>>
>>          while (len) {
>>                  u32 l = min(len, blocksize);
>> -               int have_csum = 0;
>> -
>> -               if (flags & BTRFS_EXTENT_FLAG_DATA) {
>> -                       /* push csums to sbio */
>> -                       have_csum = scrub_find_csum(sctx, logical, csum);
>> -                       if (have_csum == 0)
>> -                               goto skip;
>> -               }
>>                  ret = scrub_sectors_for_parity(sparity, logical, l, physical, dev,
>> -                                            flags, gen, mirror_num,
>> -                                            have_csum ? csum : NULL);
>> +                                            flags, gen, mirror_num);
>>                  if (ret)
>>                          return ret;
>> -skip:
>>                  len -= l;
>>                  logical += l;
>>                  physical += l;
>> @@ -4148,7 +4183,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>
>>                  ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>>                                      scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
>> -                                   NULL, bytenr);
>> +                                   bytenr);
>>                  if (ret)
>>                          return ret;
>>          }
>> --
>> 1.8.3.1
>>
