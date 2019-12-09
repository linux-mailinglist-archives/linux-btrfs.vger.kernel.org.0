Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B501174F7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIS4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 13:56:50 -0500
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:58906
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfLIS4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 13:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1575917807;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=uaAhqwaSl/41NQnZYibH6boNMWb7s+WVYftapTA3ANU=;
        b=SCJCkBv3PuOIru82aZPDANtCB6/o+46FgyVlJsLWSeoQLEfbe/amL1tj/O3JoZ9d
        mzQzfR+brD7O9yOmAAMmP0OhSH06XKe2WE0r+sX1gmh67G9pGs8V8loDRd7nNPO30m0
        ACrma8vHVDKK8WrA7yRgTxNzrAeFBUDUWTxUrUWQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1575917807;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=uaAhqwaSl/41NQnZYibH6boNMWb7s+WVYftapTA3ANU=;
        b=MJZ0HwedcM/u6tGvou2BaJ308QW8j7TiKpe0Nz1dZtL6SuT58beLW01B2Bygne2K
        fq3+YMiHJucr0lNpy89KofhU866ieTGmaUltPCjvqlKXl6Fslx6v+uwRQVak8Air3Ny
        xxAgAe+9VKD/4qhqxeJ+Cpt8ilS+J+d/nPnNgPwA=
Subject: Re: df shows no available space in 5.4.1
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
Date:   Mon, 9 Dec 2019 18:56:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.09-54.240.4.15
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.12.2019 08:28 Qu Wenruo wrote:
>
> On 2019/12/7 上午5:26, Martin Raiber wrote:
>> Hi,
>>
>> with kernel 5.4.1 I have the problem that df shows 100% space used. I
>> can still write to the btrfs volume, but my software looks at the
>> available space and starts deleting stuff if statfs() says there is a
>> low amount of available space.
> If the bug still happens, mind to try the snippet to see why this happened?
>
> You will need to:
> - Apply the patch to your kernel code
> - Recompile the kernel or btrfs module
>   So this needs some experience in kernel compile.
> - Reboot to newly compiled kernel or load the debug btrfs module
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 23aa630f04c9..cf34c05b16d7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root *root)
>  {
>         struct btrfs_root *reloc_root;
>
> -       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
> +       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
> +           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>                 return 0;
>
>         reloc_root = root->reloc_root;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..c2b70d97a63b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>                                         found->disk_used;
>                 }
>
> +               pr_info("%s: found type=0x%llx disk_used=%llu factor=%d\n",
> +                       __func__, found->flags, found->disk_used, factor);
>                 total_used += found->disk_used;
>         }
>
> @@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>
>         buf->f_blocks = div_u64(btrfs_super_total_bytes(disk_super),
> factor);
>         buf->f_blocks >>= bits;
> +       pr_info("%s: super_total_bytes=%llu total_used=%llu
> factor=%d\n", __func__,
> +               btrfs_super_total_bytes(disk_super), total_used, factor);
>         buf->f_bfree = buf->f_blocks - (div_u64(total_used, factor) >>
> bits);
>
>         /* Account global block reserve as used, it's in logical size
> already */
>
Applied. It's currently 100% used directly after reboot, and I am
getting this log output:

[...]
[  241.245150] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  241.904824] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  241.904824] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  241.904824] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  241.904824] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  241.976082] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  241.976082] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  241.976082] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  241.976082] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  241.976083] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  241.976083] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  241.976083] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  241.976083] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  242.245301] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  242.245301] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  242.245301] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  242.245301] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  242.904977] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  242.904977] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  242.904977] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  242.904977] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  242.976105] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  242.976105] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  242.976105] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  242.976105] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  242.977777] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  242.977777] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  242.977777] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  242.977777] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  243.245041] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  243.245041] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  243.245041] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.245041] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  243.252079] btrfs_statfs: found type=0x1 disk_used=30026579968 factor=1
[  243.252079] btrfs_statfs: found type=0x4 disk_used=957202432 factor=1
[  243.252079] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.252079] btrfs_statfs: super_total_bytes=49999998976
total_used=30983798784 factor=1
[  243.252080] btrfs_statfs: found type=0x1 disk_used=30026579968 factor=1
[  243.252080] btrfs_statfs: found type=0x4 disk_used=957202432 factor=1
[  243.252080] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.252080] btrfs_statfs: super_total_bytes=49999998976
total_used=30983798784 factor=1
[  243.904085] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  243.904086] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  243.904086] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.904086] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  243.976096] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  243.976096] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  243.976096] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.976096] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  243.976257] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  243.976257] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  243.976257] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  243.976258] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  244.081959] btrfs_statfs: found type=0x1 disk_used=665652932608 factor=1
[  244.081959] btrfs_statfs: found type=0x4 disk_used=4902944768 factor=1
[  244.081959] btrfs_statfs: found type=0x2 disk_used=98304 factor=1
[  244.081959] btrfs_statfs: super_total_bytes=8133881348096
total_used=670555975680 factor=1
[  244.084110] btrfs_statfs: found type=0x1 disk_used=665652932608 factor=1
[  244.084110] btrfs_statfs: found type=0x4 disk_used=4902944768 factor=1
[  244.084110] btrfs_statfs: found type=0x2 disk_used=98304 factor=1
[  244.084110] btrfs_statfs: super_total_bytes=8133881348096
total_used=670555975680 factor=1
[  244.245470] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  244.245470] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  244.245470] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  244.245470] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  244.904170] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  244.904170] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  244.904170] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  244.904170] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  244.977624] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  244.977624] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  244.977624] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  244.977624] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  244.977387] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  244.977387] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  244.977387] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  244.977387] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1
[  245.244089] btrfs_statfs: found type=0x1 disk_used=93464006656 factor=1
[  245.244089] btrfs_statfs: found type=0x4 disk_used=314818560 factor=1
[  245.244089] btrfs_statfs: found type=0x2 disk_used=16384 factor=1
[  245.244089] btrfs_statfs: super_total_bytes=128835387392
total_used=93778841600 factor=1

>
>> # df -h
>> Filesystem                                            Size  Used Avail
>> Use% Mounted on
>> ...
>> /dev/loop0                                            7.4T  623G     0
>> 100% /media/backup
>> ...
>>
>> statfs("/media/backup", {f_type=BTRFS_SUPER_MAGIC, f_bsize=4096,
>> f_blocks=1985810876, f_bfree=1822074245, f_bavail=0, f_files=0,
>> f_ffree=0, f_fsid={val=[3667078581, 2813298474]}, f_namelen=255,
>> f_frsize=4096, f_flags=ST_VALID|ST_NOATIME}) = 0
>>
>> # btrfs fi usage /media/backup
>> Overall:
>>     Device size:                   7.40TiB
>>     Device allocated:            671.02GiB
>>     Device unallocated:            6.74TiB
>>     Device missing:                  0.00B
>>     Used:                        622.49GiB
>>     Free (estimated):              6.79TiB      (min: 6.79TiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   1.00
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>
>> Data,single: Size:666.01GiB, Used:617.95GiB
>>    /dev/loop0    666.01GiB
>>
>> Metadata,single: Size:5.01GiB, Used:4.54GiB
>>    /dev/loop0      5.01GiB
>>
>> System,single: Size:4.00MiB, Used:96.00KiB
>>    /dev/loop0      4.00MiB
>>
>> Unallocated:
>>    /dev/loop0      6.74TiB
>>
>> # btrfs fi df /media/backup
>> Data, single: total=666.01GiB, used=617.95GiB
>> System, single: total=4.00MiB, used=96.00KiB
>> Metadata, single: total=5.01GiB, used=4.54GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>> # mount
>>
>> ...
>> /dev/loop0 on /media/backup type btrfs
>> (rw,noatime,nossd,discard,space_cache=v2,enospc_debug,skip_balance,commit=86400,subvolid=5,subvol=/)
>> ...
>>
>> (I remounted with enospc_debug and the available space did not change...)
>>
>> Regards,
>> Martin Raiber
>>

