Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E446419F8
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Dec 2022 00:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiLCXJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Dec 2022 18:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCXJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Dec 2022 18:09:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B941A3AB
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Dec 2022 15:09:35 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79yG-1ovvFP3VEq-017YsL; Sun, 04
 Dec 2022 00:09:32 +0100
Message-ID: <f908653b-7092-fe64-00ce-12b14e3d8157@gmx.com>
Date:   Sun, 4 Dec 2022 07:09:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH PoC v2 01/10] btrfs: introduce BTRFS_IOC_SCRUB_FS family
 of ioctls
To:     li zhang <zhanglikernel@gmail.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1664353497.git.wqu@suse.com>
 <36c909e90fa85813afa206e7f0e0a10177c841b3.1664353497.git.wqu@suse.com>
 <CAAa-AGnd4qRbQ-MRNsTMNKJLP7j+NZrMOV2KRDaKDhUtrrnowQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAa-AGnd4qRbQ-MRNsTMNKJLP7j+NZrMOV2KRDaKDhUtrrnowQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eK3mYVCRfCt66AL/7BMxSgKCwZDAKkpLgzyNDpl367X1EY4eTdZ
 7/nUmUQ735CN5ILqszuR0Rblxzyn5d+vvTRWHmC/p251maZC4+z2VU3VtqEhsw4fLg2HkCs
 yOoaeG8Wi9h/noO31Wqv9vALAn+RoUZi2q06vBAFiM4RQ7twwJTHZDPtrs7O/pvnmbDwTdL
 ftk1iZMQv6yoMph0lcflA==
UI-OutboundReport: notjunk:1;M01:P0:XpMICbbcMjk=;Nzor3CWV4ex8jD4okN6fCMBDxxY
 K5cGeLm1gKS0XIZzPRcc7uh/w3nzxFdRd+Yc9QXvnTgFYlSBVmDYKoEJ9y7i8LVuuOcBAmxOQ
 5mV4dgI/LklF5OQq+w/VoQv+85Xcmf6SCz7TzO0DDs4UZL3KFP1jSjDbzQEBo6Q/oUlGhwt+m
 4tanMrahEVged1TisyIiJGP2FBIBPxkTktfJyFqTZ8gH0AJj0ooWgBGt0b/uIYcIb73qikZ04
 2WQuYt+LOUN8TY6fsKrOmsCD4oVbEo2pohzNcvoD8TvtBV9uhnhjSpA+hN9iKSDd/JFoybsdi
 TDxGby8YLokgWQVc32cvfn6fHlI2Cpt8S0rKWz5tLGgqE56lqU2dUpSY5/WHpCwr8g90Id/ja
 RugF0n6e4lsNHYtmIye6o0BQNX9MwNAQDKohRk53oEqTJLPGQ5MWM+XrKX5knT/MqWu3Gg13h
 N3yxoOpTXGJGsUOnBbI7RDsyKXyD2ZdoKf/K7mUK2ODdkeIOYho6vNq1L4DA/3DXvWzGhv+ur
 8NQJ7iR6Qt5BDzXPzxBGyQibaWO0DI6FWIZLVLXxKz6iDLVdUEL8Ris1uogiNbHhzn7o+x+Hn
 9plfTlgUlLkRN9TZ3wZ0F1+J00loUzv8+dLDKtWqDucQyqV0mgHfYOscUNgGR03pMMHOb3LqU
 /bLNDxf++hEjSBQ7aHIBOUQlaOt6AtvnZtX3RmYffMjICuQsRLk8ltjlRdTXhKOPhhFrRy5i7
 dr2sicz87KkLe52dCOp1Z+x/hWkhJ/RbQj7OCWUlS1V8IRsIpCHhI+lEFXU4kTl7Q5N8Mw0a+
 zmBa3lWWmF3COEoY9GRIp2mRdiT8Cu/L4zYYE5o+mFvry3VDVUybookm2yt+wcIInyClJBqcC
 OhWgo7LsKi+TWjOYWMRBnQ/pZXBePSZINfMNo344geVx510O8BcnXhh/MwomCbcamRhUGrHjX
 yC1wvM+VOf2bvT3YnkKX5+d/x3A=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/3 23:10, li zhang wrote:
> Qu Wenruo <wqu@suse.com> 于2022年9月28日周三 16:40写道：
[...]
>> +       __u64 parity_io_fail;
>> +       __u64 parity_mismatch;
>> +
>> +       /* Padding to 256 bytes, and for later expansion. */
>> +       __u64 __unused[15];
>> +};
> It looks like this btrfs_scrub_fs_progress is missing
> a member for unverified errors like the old btrfs_scrub_progress used to
> indicate that an error came up but went away during a recheck.

That member is no longer required as we don't do sector by sector read 
at all.

Thus there will be no such case that initial read failed but sector by 
sector read succeeded.

> But
> this is a poc patch,
> just wondering if this recheck feature will be added to the official patch.
> 
> Also, just curious, what kind of situation would cause the first read
> of a block that appears
> to be corrupted, but the second read everything is fine. Could bad
> sectors on the hard drive cause this?

I don't know, it can be hardware dependent.
Some hard disks have internal checksum, thus if one sector is corrupted, 
it may mark the full read which covers that sector error.

Thanks,
Qu

> 
>> +static_assert(sizeof(struct btrfs_scrub_fs_progress) == 256);
>> +
>> +/*
>> + * Readonly scrub fs will not try any repair (thus *_repaired member
>> + * in scrub_fs_progress should always be 0).
>> + */
>> +#define BTRFS_SCRUB_FS_FLAG_READONLY   (1ULL << 0)
>> +
>> +/*
>> + * All supported flags.
>> + *
>> + * From the very beginning, scrub_fs ioctl would reject any unsupported
>> + * flags, making later expansion much simper.
>> + */
>> +#define BTRFS_SCRUB_FS_FLAG_SUPP       (BTRFS_SCRUB_FS_FLAG_READONLY)
>> +
>> +struct btrfs_ioctl_scrub_fs_args {
>> +       /* Input, logical bytenr to start the scrub */
>> +       __u64 start;
>> +
>> +       /* Input, the logical bytenr end (inclusive) */
>> +       __u64 end;
>> +
>> +       __u64 flags;
>> +       __u64 reserved[8];
>> +       struct btrfs_scrub_fs_progress progress; /* out */
>> +
>> +       /* pad to 1K */
>> +       __u8 unused[1024 - 24 - 64 - sizeof(struct btrfs_scrub_fs_progress)];
>> +};
>> +
>>   #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS   0
>>   #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID    1
>>   struct btrfs_ioctl_dev_replace_start_params {
>> @@ -1143,5 +1312,10 @@ enum btrfs_err_code {
>>                                      struct btrfs_ioctl_encoded_io_args)
>>   #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
>>                                       struct btrfs_ioctl_encoded_io_args)
>> +#define BTRFS_IOC_SCRUB_FS     _IOWR(BTRFS_IOCTL_MAGIC, 65, \
>> +                                     struct btrfs_ioctl_scrub_fs_args)
>> +#define BTRFS_IOC_SCRUB_FS_CANCEL _IO(BTRFS_IOCTL_MAGIC, 66)
>> +#define BTRFS_IOC_SCRUB_FS_PROGRESS _IOWR(BTRFS_IOCTL_MAGIC, 67, \
>> +                                      struct btrfs_ioctl_scrub_fs_args)
>>
>>   #endif /* _UAPI_LINUX_BTRFS_H */
>> --
>> 2.37.3
>>
> 
> 
> Best Regards
> Li
