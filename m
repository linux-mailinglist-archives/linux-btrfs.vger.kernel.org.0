Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4E6530C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 13:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLUM0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 07:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLUM0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 07:26:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F8B7D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:26:51 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bjy-1ooSND2qsg-0187I3; Wed, 21
 Dec 2022 13:26:42 +0100
Message-ID: <90a26162-d371-4396-5cb8-6a381fc191f9@gmx.com>
Date:   Wed, 21 Dec 2022 20:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] btrfs: fix compat_ro checks against remount
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Chung-Chiang Cheng <shepjeng@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
References: <82e9c6f8afe4a58e3df60cf601530e14d42264a6.1671613891.git.wqu@suse.com>
 <CAL3q7H6Kg90MA_m1M60kTFd7GUZCx8qfr8kRiPh+66VgQAGuSA@mail.gmail.com>
 <CAL3q7H7GihcV4_Fv-yi2QTLx7MydBVfr8xrxX++wMcseUnVfTQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7GihcV4_Fv-yi2QTLx7MydBVfr8xrxX++wMcseUnVfTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BRNVuPdW6b5Eb7isskl/WHW1Qx2cmEFvll7Ff9XbzIGe7ZG1XSp
 1kKYdW4g8MVmuTifha328rf9JF/bK2bZEhN+UZEoHR/DIlZYV9GNyFa/LN7WYC/+kxrZxln
 SMMeUHR2LUdVwMDllf34dYSGBtPxTePw1S6e0nsGbhbWOVxDSfuWAfQdvk9xFgzJInk8HXS
 VBUeN4ncyXLxZk2H9PCMA==
UI-OutboundReport: notjunk:1;M01:P0:dipRRkQkf8E=;6lD5MX5o7cBvUMvCuMxd20iQqCt
 92Z/kD6Vjjgjts90JCNsCyktygLLzJ9Gz+Yg7R1PdwyDlsBJrRoLXwcuyhH/7ZJ6QanGTmfY0
 69OZ2PuMUvQQz3Fr5/rcoUo9DdKLYepHawGrKOSkJof/PnQ/8w3QH32l8CqV3+RwDPyEOn8Xi
 XKjnZfl/ksJtZ/ycgz2jF/6kfsm7UpTiAdDri8oX3fLL84ixZO6d/meUnOMRDpIFy3g4W2wpV
 g/M7PAOP4epwxqJavHfR/j1628aj1VtwEIjMzu7uE/RxViNphYIKbqBR3pjrCmQVJZfusU7sG
 pbUzDYcAOQv1DtCSlsl6UT3UZrheP+bt9XIqtWruRuOwECsN2ZUc3YJC/J7QPy4a6UkSFKTPq
 Aj3fnx4acPKcNIvvWRIMGlipk9vKhS69DVsSREMiSyoFKaEf3I6p9Pu6w+Z9ieG1FFLZh81M6
 /utFLlxGXdNtDZbGPK8Uh2C0fdukc1aPabe2YEWsUmWeuBtlXJl9f5mpV9xh+liTelesr/2De
 ch7LblaJfKGYYubhQYv7QgVIG/n+cXKbV4AYeVJEgxgwIsrSmwLMs+DkRvvxRYtkeZWmOar9S
 HJ1BvR+a53AtLA653A6UXUHVcJYiEmY13pNBZ85bTk2urYXuD8kSn/gKjIr3niSVhFbPn6rq8
 IOWqcqlbcYjL0wRFN3oDlgTq5H+bzjPXlRTsu+svluS84P3UjOiJIIb58hIdcwoUR5HjmA1Nq
 /qgJ8ZauGIqgmF0cRDiyTTPIHcqSbhssgFfN122NBH+i4u09OD/XE7bgpXDN5i//iwpyTrruv
 MKrVAwBmmr6xYlUeUI3+lyjR+cj0st4s3wwM7pst4BoPFC6UujRhgXlb7x1IYr+X8rQLi2+SJ
 DwuV4S3t1Ilqa+BsXSUDX5gJfoJfCDYLg/U7BJPjcRZzMnySeY7e8n74hL6uUblhPUBhqPEgl
 LVjnPMEYwkUQhG09Gp4VTVDt8+c=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 20:11, Filipe Manana wrote:
[...]
>> Can we please pass new_flags by value instead?
>> It does not make any sense to pass by pointer - we don't want to
>> change its value...
> 
> Or just make it a:   bool rw_switch

OK, this inspired me more.

Just replace the @sb arugument with  bool @rw_mount.

[...]
>>> +       ret = btrfs_check_features(fs_info, sb, NULL);
>>
>> Here just pass 0 for flags.
> 
> Here pass a false value.

And pass !sb_rdonly(sb).

Thanks,
Qu

> 
>>
>>>          if (ret < 0) {
>>>                  err = ret;
>>>                  goto fail_alloc;
>>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>>> index 363935cfc084..e83453c7c429 100644
>>> --- a/fs/btrfs/disk-io.h
>>> +++ b/fs/btrfs/disk-io.h
>>> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>>                           struct btrfs_super_block *sb, int mirror_num);
>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
>>> +                        int *new_flags);
>>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index d5de18d6517e..bc2094aa9a40 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>>>          if (ret)
>>>                  goto restore;
>>>
>>> -       ret = btrfs_check_features(fs_info, sb);
>>> +       ret = btrfs_check_features(fs_info, sb, flags);
>>
>> And here pass *flags.
> 
> And here pass:  !(*flags & SB_RDONLY) >
> Makes the whole thing easier to read and shorter.
> 
> Thanks.
> 
> 
>>
>> Thanks.
>>
>>>          if (ret < 0)
>>>                  goto restore;
>>>
>>> --
>>> 2.39.0
>>>
