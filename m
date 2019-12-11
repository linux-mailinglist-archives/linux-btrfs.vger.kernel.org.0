Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0C11ABBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 14:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfLKNLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 08:11:40 -0500
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:46958 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729225AbfLKNLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 08:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1576069896;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=b4CozWUU+C1n0XeqSnfEqmkIT/29B81YS6NlphsLpgw=;
        b=dmg4t22StrLmYoQk5WICW2Q9fy6wc/RdwedHG842NfoTtCfLM8EjEioGWNsCotos
        Qak65nGg9Xc/HI9s/36gKuUpH3LQPcZvWyZ4U7lBAjR8jtDDe9vcrnwetGBXvo05YZU
        ecMjFYR95aOlK3UVIRpEzd+CvywfQ7XaNN4Vl9X4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1576069896;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=b4CozWUU+C1n0XeqSnfEqmkIT/29B81YS6NlphsLpgw=;
        b=ICnK7vyf6bMFk8UykVbbfcvh8rXFf9Bp/9RLetgNiPC4NH0bsekIDkMc3Y6ljxv4
        VxNtSAFXRbWfSvh1DNGI5i3lcxn9bR2YFVxvm6mj3FZ6ZKf9iNw+oEfdxFikpKV32R2
        GOIousQKBhyhBqkCKBY5mWyzX/X3kw0Oaa780htg=
Subject: Re: df shows no available space in 5.4.1
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
 <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
 <b0501a9b-34da-e69b-a06b-1946f7917269@gmx.com>
 <2ae7f7c6-37a6-9133-6f97-e245812b005e@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016ef51617a2-339bd846-c076-4a86-a263-f1bdb14de622-000000@eu-west-1.amazonses.com>
Date:   Wed, 11 Dec 2019 13:11:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2ae7f7c6-37a6-9133-6f97-e245812b005e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.11-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10.12.2019 02:19 Qu Wenruo wrote:
>
> On 2019/12/10 上午8:52, Qu Wenruo wrote:
>>
>> On 2019/12/10 上午2:56, Martin Raiber wrote:
>>> On 07.12.2019 08:28 Qu Wenruo wrote:
>>>> On 2019/12/7 上午5:26, Martin Raiber wrote:
>>>>> Hi,
>>>>>
>>>>> with kernel 5.4.1 I have the problem that df shows 100% space used. I
>>>>> can still write to the btrfs volume, but my software looks at the
>>>>> available space and starts deleting stuff if statfs() says there is a
>>>>> low amount of available space.
>>>> If the bug still happens, mind to try the snippet to see why this happened?
>>>>
>>>> You will need to:
>>>> - Apply the patch to your kernel code
>>>> - Recompile the kernel or btrfs module
>>>>   So this needs some experience in kernel compile.
>>>> - Reboot to newly compiled kernel or load the debug btrfs module
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>>> index 23aa630f04c9..cf34c05b16d7 100644
>>>> --- a/fs/btrfs/relocation.c
>>>> +++ b/fs/btrfs/relocation.c
>>>> @@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root *root)
>>>>  {
>>>>         struct btrfs_root *reloc_root;
>>>>
>>>> -       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>>> +       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>>>> +           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>>>                 return 0;
>>>>
>>>>         reloc_root = root->reloc_root;
>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>> index f452a94abdc3..c2b70d97a63b 100644
>>>> --- a/fs/btrfs/super.c
>>>> +++ b/fs/btrfs/super.c
>>>> @@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry,
>>>> struct kstatfs *buf)
>>>>                                         found->disk_used;
>>>>                 }
>>>>
>>>> +               pr_info("%s: found type=0x%llx disk_used=%llu factor=%d\n",
>>>> +                       __func__, found->flags, found->disk_used, factor);
>>>>                 total_used += found->disk_used;
>>>>         }
>>>>
>>>> @@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry,
>>>> struct kstatfs *buf)
>>>>
>>>>         buf->f_blocks = div_u64(btrfs_super_total_bytes(disk_super),
>>>> factor);
>>>>         buf->f_blocks >>= bits;
>>>> +       pr_info("%s: super_total_bytes=%llu total_used=%llu
>>>> factor=%d\n", __func__,
>>>> +               btrfs_super_total_bytes(disk_super), total_used, factor);
>>>>         buf->f_bfree = buf->f_blocks - (div_u64(total_used, factor) >>
>>>> bits);
>>>>
>>>>         /* Account global block reserve as used, it's in logical size
>>>> already */
>>>>
>>> Applied. It's currently 100% used directly after reboot, and I am
>>> getting this log output:
>> Thank you a lot for the debug output!
>>
>>> [...]
>>> [  241.245150] btrfs_statfs: super_total_bytes=128835387392
>>> total_used=93778841600 factor=1
>>> [  241.904824] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
>>> [  241.904824] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
>>> [  241.904824] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
>>> [  241.904824] btrfs_statfs: super_total_bytes=128835387392
>>> total_used=93778841600 factor=1
>> This proves the on-disk numbers are all correct, so far so good.
>>
>> The remaining problem is the block_rsv part. Which matches with the new
>> ticket system introduced in v5.4.
>>
>> Mind to test the new debug snippet?
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f452a94abdc3..516969534095 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2076,6 +2076,8 @@ static int btrfs_statfs(struct dentry *dentry,
>> struct kstatfs *buf)
>>         /* Account global block reserve as used, it's in logical size
>> already */
>>         spin_lock(&block_rsv->lock);
>>         /* Mixed block groups accounting is not byte-accurate, avoid
>> overflow */
>> +       pr_info("%s: block_rsv->size=%llu block_rsv->reserved=%llu\n",
>> __func__,
>> +               block_rsv->size, block_rsv->reserved);
>>         if (buf->f_bfree >= block_rsv->size >> bits)
>>                 buf->f_bfree -= block_rsv->size >> bits;
>>         else
>>
> And this extra snippet for available space.
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..f1a3e01a0ef5 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1911,6 +1911,7 @@ static inline int
> btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>          * We aren't under the device list lock, so this is racy-ish,
> but good
>          * enough for our purposes.
>          */
> +       pr_info("%s: original_free_bytes=%llu\n", __func__, *free_bytes);
>         nr_devices = fs_info->fs_devices->open_devices;
>         if (!nr_devices) {
>                 smp_mb();
> @@ -2005,6 +2006,7 @@ static inline int
> btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>
>         kfree(devices_info);
>         *free_bytes = avail_space;
> +       pr_info("%s: calculated_bytes=%llu\n", __func__, avail_space);
>         return 0;
>  }
>
Now logs this at 100% used:

[90273.353449] btrfs_calc_avail_data_space: original_free_bytes=23583420416
[90273.353449] btrfs_calc_avail_data_space: calculated_bytes=13662945280
[90273.369508] btrfs_statfs: found type=0x1 disk_used=90233212928 factor=1
[90273.369536] btrfs_statfs: found type=0x1 disk_used=90233212928 factor=1
[90273.369536] btrfs_statfs: found type=0x4 disk_used=339361792 factor=1
[90273.369508] btrfs_statfs: found type=0x4 disk_used=339361792 factor=1
[90273.369508] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[90273.369536] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[90273.369508] btrfs_statfs: super_total_bytes=128835387392
total_used=90572591104 factor=1
[90273.369508] btrfs_statfs: block_rsv->size=147554304
block_rsv->reserved=147554304
[90273.369537] btrfs_statfs: super_total_bytes=128835387392
total_used=90572591104 factor=1
[90273.369509] btrfs_calc_avail_data_space: original_free_bytes=23583420416
[90273.369537] btrfs_statfs: block_rsv->size=147554304
block_rsv->reserved=147554304
[90273.369537] btrfs_calc_avail_data_space: original_free_bytes=23583420416
[90273.369509] btrfs_calc_avail_data_space: calculated_bytes=13662945280
[90273.369537] btrfs_calc_avail_data_space: calculated_bytes=13662945280
[90273.400227] btrfs_statfs: found type=0x1 disk_used=726834307072 factor=1
[90273.400227] btrfs_statfs: found type=0x4 disk_used=4908548096 factor=1
[90273.400227] btrfs_statfs: found type=0x2 disk_used=98304 factor=1
[90273.400227] btrfs_statfs: super_total_bytes=8133881348096
total_used=731742953472 factor=1
[90273.400227] btrfs_statfs: block_rsv->size=536870912
block_rsv->reserved=536821760
[90273.400227] btrfs_calc_avail_data_space: original_free_bytes=1171038208
[90273.400227] btrfs_calc_avail_data_space: calculated_bytes=7400493613056

