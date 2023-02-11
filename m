Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB78692C68
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 02:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBKBFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 20:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBKBFV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 20:05:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF59C75F52
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 17:05:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1ok7iE47yc-00kxWo; Sat, 11
 Feb 2023 02:05:13 +0100
Message-ID: <be2ba57f-500c-ec77-b845-7b14311ca242@gmx.com>
Date:   Sat, 11 Feb 2023 09:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <29a0e54c8461e3c25e63d5b7b3e48fa6f4254d3f.1676007519.git.wqu@suse.com>
 <770d3b15-d521-794e-b78d-ba8ad67b4e0c@oracle.com>
 <9cb47d00-b17f-bd3b-be60-29f3f95b3065@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: filesystem-usage: handle missing seed device
 properly
In-Reply-To: <9cb47d00-b17f-bd3b-be60-29f3f95b3065@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZzBHFhVG+/ZVqin1xJbvfypV3gd+2nW/w79yiO3CUuyhO1dpwxN
 YM+w3Z35q2k6qWbb3zGQhe4d3sKZeVocHShTbd78LU5Oo0KUiF03Au0G8Ge4aMVNVur5Q62
 BBEA4rX1eb/ZKDU7N14WODQcrP8rPuI7jmgyUy5pzHH14m03pUDxoK88zNKaqLXdkGyuT4m
 wJhHhuF+wKJY16XCmEJeg==
UI-OutboundReport: notjunk:1;M01:P0:whTQ5lrH1cw=;hzOoUPfzBymVJGkQcX+nyJRCkrN
 8+9OiDQBXLraoHS4889/DxN+B3eFPu9Ryf887ZM70lTHtwC7B/hz7uRqO5fNzXB9FffFFYjGS
 WeehE/zB8GslIzvEqR/3cIVWbGBCjGHQxIPhq1S4GEvz0XjInJYvezmRvDAfZn4Hs32truf5F
 qVtT4b7QfyF1oEN8cqBELJnYGEx0NdYBk5eyJsAw/3n3HmH1Fy8RJjnuzb2YgwzvTbLql1tj0
 SQhUN2MRGVTAl6sHa6jH1T/xXBL4x1rg8/Jcs3RqvP43hTQ3R4cBtyN4T8Zgg1ufLfH/NBTYv
 t26OimEVQhvW2Y3/a2Rn5pmZYmJ4/wXQ5kQOYtecgC/EmC9QVQFse2y6c8t62BDFliTDRhT7F
 HvRppqbmJgErKoxqE20hXPSv+wbG3uoK04kX8lvLFBhWHGFrqXuONbsLgpytHPD7Ey/og2aD7
 lnzLKW/B6MnwYgSdtDfaLpeZYC4rJL3goSXNWVt2NjiEDSVU98Bd+COR1TGdBQ8R3/NIXXM6N
 DAiyE19sLpB8L16nSCOoBDEpIMI0XLhKSMHqsxAejUEEIsfwESm8RkO54UpXnNqoV43nqdFyI
 eQ/y99rHkLEa4bmMBApBXdyFe+fhxqvFxIdVZAbrTx/2H1qbPypwuZS1ekyXb8K15WOxhtZbq
 E2gbpRrqE+3pUUhNXpUYxqXbq1RNaIklzUga8rb+qWghvwi4Si/Ahy7O0Ga7aBTrA4O/L1pfL
 rh1Tx3gLK7H6yT9G045bI/SdkxTBRStjQc2J35hrAQQCD3lfHoZxW7FntwmTn0A8tdxCp8A3b
 xiK+5788vKHO9hZpPno5WL5trIHvyAPA9KtQSe+6Mw0vaZQtAOmKPqXEQpivR0AkpdoOc55m3
 eXeiV1u9APRdvWWu5h5AddyANNRxrABsamwnyjwHEpl1W41viCww1agCOeSjEhG+YrP614F0y
 BCi/IgBKxSFaTUiyYl+OyqU1aqo=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/11 00:07, Anand Jain wrote:
> 
> OR
> 
> We could use both methods to accommodate older kernels; switch to disk 
> reading if newer sysfs interface is unavailable.

I believe the tree-search is always needed as a fallback.

Thus the patch itself should always be needed.

For the sysfs part, the commit message has explained it in details, we 
need a proper way to get if a device is seed, from the IOC_DEV_INFO ioctl.

Thus indeed as you commented, if we can add an fsid field to 
btrfs_ioctl_dev_info_args, it can indeed solve the problem.

Thanks,
Qu
> 
> Thanks, Anand
> 
> On 11/02/2023 00:01, Anand Jain wrote:
>>
>>
>>
>>
>> An alternative solution is to utilize a kernel interface to obtain the 
>> fsid [1]. Previous experiences have shown that attempting to directly 
>> read a mounted device's disk is not a reliable method and can result 
>> in various problems. As a result, it is advisable to use a kernel 
>> interface to read the fsid.
>>
>> [PATCH 2/2] btrfs-progs: read fsid from the sysfs in device_is_seed
>> On 10/02/2023 13:39, Qu Wenruo wrote:
>>> [BUG]
>>> Test case btrfs/249 always fails since its introduction, the failure
>>> comes from "btrfs filesystem usage" subcommand, and the error output
>>> looks like this:
>>>
>>>    QA output created by 249
>>>    ERROR: unexpected number of devices: 1 >= 1
>>>    ERROR: if seed device is used, try running this command as root
>>>    FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and 
>>> btrfs-progs version.
>>>    (see /home/adam/xfstests/results//btrfs/249.full for details)
>>>
>>> [CAUSE]
>>> In function load_device_info(), we only allocate enough space for all
>>> *RW* devices, expecting we can rule out all seed devices.
>>>
>>> And in that function, we check if a device is a seed by checking its
>>> super block fsid.
>>>
>>> So if a seed device is missing (it can be an seed device without any
>>> chunks on it, or a degraded RAID1 as seed), then we can not read the
>>> super block.
>>>
>>> In that case, we just assume it's not a seed device, and causing too
>>> many devices than our expectation and cause the above failure.
>>>
>>> [FIX]
>>> Instead of unconditionally assume a missing device is not a seed, we add
>>> a new safe net, is_seed_device_tree_search(), to search chunk tree and
>>> determine if that device is a seed or not.
>>>
>>> And if we found the device is still a seed, then just skip it as usual.
>>>
>>> Now the test case btrfs/249 passes as expected:
>>>
>>>    btrfs/249        2s
>>>    Ran: btrfs/249
>>>    Passed all 1 tests
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> This version is different from the original fix from Anand by:
>>>
>>> - No need for kernel patching
>>>    Thus no compatible problems
>>>
>>> And also different from the fix from Flint:
>>>
>>> - No need to search chunk tree unconditionally
>>>    Tree search itself is a privileged operation while "filesystem usage"
>>>    subcommand is not.
>>>
>>>    Now we only needs root privilege if we hit a missing seed device,
>>>    which is super rare.
>>>
>>>    And we can still fallback to assume the device is not seed.
>>>
>>> - Better commit message
>>> ---
>>>   cmds/filesystem-usage.c | 72 +++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 70 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>>> index 5810324f245e..214cad2fa75b 100644
>>> --- a/cmds/filesystem-usage.c
>>> +++ b/cmds/filesystem-usage.c
>>> @@ -700,6 +700,56 @@ out:
>>>       return ret;
>>>   }
>>> +/*
>>> + * Return 0 if this devid is not a seed device.
>>> + * Return 1 if this devid is a seed device.
>>> + * Return <0 if error (IO error or EPERM).
>>> + *
>>> + * Since this is done by tree search, it needs root privilege, and
>>> + * should not be triggered unless we hit a missing device and can not
>>> + * determine if it's a seed one.
>>> + */
>>> +static int is_seed_device_tree_search(int fd, u64 devid, u8 *fsid)
>>> +{
>>> +    struct btrfs_ioctl_search_args args = {0};
>>> +    struct btrfs_ioctl_search_key *sk = &args.key;
>>> +    struct btrfs_ioctl_search_header *sh;
>>> +    struct btrfs_dev_item *dev;
>>> +    unsigned long off = 0;
>>> +    int ret;
>>> +    int err;
>>> +
>>> +    sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
>>> +    sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>>> +    sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>>> +    sk->min_type = BTRFS_DEV_ITEM_KEY;
>>> +    sk->max_type = BTRFS_DEV_ITEM_KEY;
>>> +    sk->min_offset = devid;
>>> +    sk->max_offset = devid;
>>> +    sk->max_transid = (u64)-1;
>>> +    sk->nr_items = 1;
>>> +
>>> +    ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
>>> +    err = errno;
>>> +    if (err == EPERM)
>>> +        return -err;
>>> +    if (ret < 0) {
>>> +        error("cannot lookup chunk tree info: %m");
>>> +        return ret;
>>> +    }
>>> +    /* No dev item found. */
>>> +    if (sk->nr_items == 0)
>>> +        return -ENOENT;
>>> +
>>> +    sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
>>> +    off += sizeof(*sh);
>>> +
>>> +    dev = (struct btrfs_dev_item *)(args.buf + off);
>>> +    if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
>>> +        return 0;
>>> +    return 1;
>>> +}
>>> +
>>>   /*
>>>    *  This function loads the device_info structure and put them in 
>>> an array
>>>    */
>>> @@ -708,7 +758,6 @@ static int load_device_info(int fd, struct 
>>> device_info **devinfo_ret,
>>>   {
>>>       int ret, i, ndevs;
>>>       struct btrfs_ioctl_fs_info_args fi_args;
>>> -    struct btrfs_ioctl_dev_info_args dev_info;
>>>       struct device_info *info;
>>>       u8 fsid[BTRFS_UUID_SIZE];
>>> @@ -730,6 +779,8 @@ static int load_device_info(int fd, struct 
>>> device_info **devinfo_ret,
>>>       }
>>>       for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
>>> +        struct btrfs_ioctl_dev_info_args dev_info = {0};
>>> +
>>>           if (ndevs >= fi_args.num_devices) {
>>>               error("unexpected number of devices: %d >= %llu", ndevs,
>>>                   fi_args.num_devices);
>>> @@ -737,7 +788,6 @@ static int load_device_info(int fd, struct 
>>> device_info **devinfo_ret,
>>>           "if seed device is used, try running this command as root");
>>>               goto out;
>>>           }
>>> -        memset(&dev_info, 0, sizeof(dev_info));
>>>           ret = get_device_info(fd, i, &dev_info);
>>>           if (ret == -ENODEV)
>>> @@ -747,6 +797,24 @@ static int load_device_info(int fd, struct 
>>> device_info **devinfo_ret,
>>>               goto out;
>>>           }
>>> +        /*
>>> +         * A missing device, we can not determing if it's a seed
>>> +         * device by reading its super block.
>>> +         * Thus we have to go tree-search to make sure if it's a seed
>>> +         * device.
>>> +         */
>>> +        if (!dev_info.path[0]) {
>>> +            ret = is_seed_device_tree_search(fd, i, fi_args.fsid);
>>> +            if (ret < 0) {
>>> +                errno = -ret;
>>> +                warning(
>>> +        "unable to determine if devid %u is seed: %m, assuming not", 
>>> i);
>>> +            }
>>> +            /* Skip the missing seed device. */
>>> +            if (ret > 0)
>>> +                continue;
>>> +        }
>>> +
>>>           /*
>>>            * Skip seed device by checking device's fsid (requires root).
>>>            * And we will skip only if dev_to_fsid is successful and dev
>>
