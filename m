Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50196BF6BC
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRAAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCRAAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 20:00:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054726F62C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 17:00:26 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1qVY0h2aoo-00umjw; Sat, 18
 Mar 2023 01:00:22 +0100
Message-ID: <ee689112-30de-89b3-51fc-cc6bc33716fb@gmx.com>
Date:   Sat, 18 Mar 2023 08:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] btrfs-progs: filesystem-usage: handle missing seed
 device properly
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1676115988.git.wqu@suse.com>
 <0695352140625cd66a86e8a12365271def5db39b.1676115988.git.wqu@suse.com>
 <20230316152544.GY10580@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230316152544.GY10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vbyo4n0tNOuv5S7oJn6Y6A5VxvElobSaGSQrtI8y29rG47PYaYZ
 Ja9ljQA/ClNlSFgB1eXmPihUYeSShTr3geNvfoRzDE5+ucInQo/HlzltBXvkwV69J48ezcu
 AHRJnbocCj9WYYAFdVv+HzcXWJ1ZfPa7KWFcVpjJlmRDLYAo5sS+Vxgpjyc2QITRLsXUPj+
 gcO2OD8lHp+qgsBs+34ww==
UI-OutboundReport: notjunk:1;M01:P0:KlEHOEb2ZI0=;WIurbgHC8D1WtU9Lp6fyBOj8tbC
 iMS+RgSLUhnv8RnTTxX2PBpogMxvUtndEwypSJKsCzef45gmiUKiJJLlH+XY4KvL9s/wjPhOo
 4DTt5T9/qSVqcZ616v+AuV8a/7lu0oRr9crLTRpieCaMUo5iFiVWYrPpbTYRBu7SsnYfLhjPQ
 db4Js1COyvZIdTCGO+87QhLO0ytpQLF0+cHDV/2Nawa1vcEML/G+5kXL+14J//95QKcwt+tz1
 HexuwyVrTvDcgsd/o2M1Sou59kS+Bs8PETspKkkcvV21d4/UEBthRcMArPsnWusZmLzUJDANu
 e4s4Rn/Suj+sZ5Krq/f3c8lBsVFeM1VkRV2KrQQ5mUSs63UO61MHlm3IclEYdF3YhTodIyIBt
 nPasOzHAkmVmasoFH7YQ5VHKwocLHmuIJuem2+TEf+Bs6lwlbOD4/AvO3fkz2E754cSeWcnTA
 gOvYoi89DTjtzSQbUPFT1Q01YrSsL+AAzqDiz/PaEoGpJsmlgilJAQZgwftNHcLibYWLBK9RU
 RKVgwmWz+Bzw6hT4xdGQ4pqR/l9lYh8HBkFabxvYSe5S0jJAff2ZS3pY3I6T4MH43UomEc773
 P8j9Kk5Rb53bUH3nwBVK5Z8VOvoMKmCEJFDtB+gGN5cfygmZdvdmC3k+WIAwq4b6DDgf6flj9
 hOETJ/UKOGT0jhwhGMHOIVnAwIHQvAftwNg/lrJiJvXB7aBwLvEFFxbwttY0uJIdr/sWBA/pj
 d3XhuGbefhYoAy2swIQTtuaINoZHUr8ghFGY0PY8LIivwxCT6ILC0Sncu9XRZYYCoEFtowxLb
 68wR70U082maSqTo5ErQPEQNb/HIdp/aKDDxS9nQTfw456pv2dwlcj0V18XagUJZ6usSy6v4D
 wDG9dGGFE1pE2OZJ23pIRWmFO5jFCyQjKzFzDtY0mHKa0VKXmsxyOPT+cqKB34LwmPPT2CoR/
 ZKu+pNEFBGFuu6mERggxEJr+Fy8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Mind to drop the series?

Although the series is to solve the btrfs/249 failure, Anand's patch is 
already merged.

Furthermore the situation of btrfs/249 is very niche, it involves RAID1 
as seed, which should be rare or even non-exist in real world.

Thus I don't think the fallback for such a niche usage is really worthy 
anymore.

Thanks,
Qu

On 2023/3/16 23:25, David Sterba wrote:
> On Sat, Feb 11, 2023 at 07:50:30PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Test case btrfs/249 always fails since its introduction, the failure
>> comes from "btrfs filesystem usage" subcommand, and the error output
>> looks like this:
>>
>>    QA output created by 249
>>    ERROR: unexpected number of devices: 1 >= 1
>>    ERROR: if seed device is used, try running this command as root
>>    FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and btrfs-progs version.
>>    (see /home/adam/xfstests/results//btrfs/249.full for details)
>>
>> [CAUSE]
>> In function load_device_info(), we only allocate enough space for all
>> *RW* devices, expecting we can rule out all seed devices.
>>
>> And in that function, we check if a device is a seed by checking its
>> super block fsid.
>>
>> So if a seed device is missing (it can be an seed device without any
>> chunks on it, or a degraded RAID1 as seed), then we can not read the
>> super block.
>>
>> In that case, we just assume it's not a seed device, and causing too
>> many devices than our expectation and cause the above failure.
>>
>> [FIX]
>> Instead of unconditionally assume a missing device is not a seed, we add
>> a new safe net, is_seed_device_tree_search(), to search chunk tree and
>> determine if that device is a seed or not.
>>
>> And if we found the device is still a seed, then just skip it as usual.
>>
>> And since we're here, extract the seed device checking into a dedicated
>> helper, is_seed_device() for later expansion.
>>
>> Now the test case btrfs/249 passes as expected:
>>
>>    btrfs/249        2s
>>    Ran: btrfs/249
>>    Passed all 1 tests
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> The patch now conflicts with 32c2e57c65b997 ("btrfs-progs: read fsid
> from the sysfs in device_is_seed"). I tried to resolve it but it seems
> that there's some overlap. Can you please refresh and resend? Also there
> are some coding style issues.
> 
>> ---
>>   cmds/filesystem-usage.c | 119 ++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 107 insertions(+), 12 deletions(-)
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index 5810324f245e..abde04d715a7 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -700,6 +700,102 @@ out:
>>   	return ret;
>>   }
>>   
>> +/*
>> + * Return 0 if this devid is not a seed device.
>> + * Return 1 if this devid is a seed device.
>> + * Return <0 if error (IO error or EPERM).
>> + *
>> + * Since this is done by tree search, it needs root privilege, and
>> + * should not be triggered unless we hit a missing device and can not
>> + * determine if it's a seed one.
>> + */
>> +static int is_seed_device_tree_search(int fd, u64 devid, const u8 *fsid)
>> +{
>> +	struct btrfs_ioctl_search_args args = {0};
> 
> 	{ 0 }
> 
>> +	struct btrfs_ioctl_search_key *sk = &args.key;
>> +	struct btrfs_ioctl_search_header *sh;
>> +	struct btrfs_dev_item *dev;
>> +	unsigned long off = 0;
>> +	int ret;
>> +	int err;
> 
> 	err not needed
>> +
>> +	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
>> +	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +	sk->min_type = BTRFS_DEV_ITEM_KEY;
>> +	sk->max_type = BTRFS_DEV_ITEM_KEY;
>> +	sk->min_offset = devid;
>> +	sk->max_offset = devid;
>> +	sk->max_transid = (u64)-1;
>> +	sk->nr_items = 1;
>> +
>> +	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
>> +	err = errno;
> 
> You need to check ret < 0 first then the errno is valid and you can use
> it directly without the temporary variable.
> 
>> +	if (err == EPERM)
>> +		return -err;
>> +	if (ret < 0) {
>> +		error("cannot lookup chunk tree info: %m");
>> +		return ret;
>> +	}
>> +	/* No dev item found. */
>> +	if (sk->nr_items == 0)
>> +		return -ENOENT;
>> +
>> +	sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
>> +	off += sizeof(*sh);
>> +
>> +	dev = (struct btrfs_dev_item *)(args.buf + off);
>> +	if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
>> +		return 0;
>> +	return 1;
>> +}
>> +
>> +/*
>> + * Return 0 if this devid is not a seed device.
>> + * Return 1 if this devid is a seed device.
>> + * Return <0 if error (IO error or EPERM).
>> + */
>> +static int is_seed_device(int fd, u64 devid, const u8 *fsid,
>> +			  const struct btrfs_ioctl_dev_info_args *dev_arg)
>> +{
>> +	int ret;
>> +	u8 found_fsid[BTRFS_UUID_SIZE];
>> +
>> +	/*
>> +	 * A missing device, we can not determing if it's a seed
>> +	 * device by reading its super block.
>> +	 * Thus we have to go tree-search to make sure if it's a seed
>> +	 * device.
>> +	 */
>> +	if (!dev_arg->path[0]) {
>> +		ret = is_seed_device_tree_search(fd, devid, fsid);
>> +		if (ret < 0) {
>> +			errno = -ret;
>> +			warning(
>> +	"unable to determine if devid %llu is seed using tree search: %m",
>> +				devid);
>> +			return ret;
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * This device is not missing, try read its super block to determine its
>> +	 * fsid.
>> +	 */
>> +	ret = dev_to_fsid((const char *)dev_arg->path, found_fsid);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		warning(
>> +	"unable to determine if devid %llu is seed using its super block: %m",
>> +			devid);
>> +		return ret;
>> +	}
>> +	if (!memcmp(found_fsid, fsid, BTRFS_UUID_SIZE))
> 
> Please use explicit == 0 or != 0
> 
>> +		return 0;
>> +	return 1;
>> +}
>> +
>>   /*
>>    *  This function loads the device_info structure and put them in an array
>>    */
>> @@ -708,9 +804,7 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>>   {
>>   	int ret, i, ndevs;
>>   	struct btrfs_ioctl_fs_info_args fi_args;
>> -	struct btrfs_ioctl_dev_info_args dev_info;
>>   	struct device_info *info;
>> -	u8 fsid[BTRFS_UUID_SIZE];
>>   
>>   	*devcount_ret = 0;
>>   	*devinfo_ret = NULL;
>> @@ -730,6 +824,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>>   	}
>>   
>>   	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
>> +		struct btrfs_ioctl_dev_info_args dev_info = {0};
> 
> 		{ 0 }
>> +
>>   		if (ndevs >= fi_args.num_devices) {
>>   			error("unexpected number of devices: %d >= %llu", ndevs,
>>   				fi_args.num_devices);
>> @@ -737,7 +833,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>>   		"if seed device is used, try running this command as root");
>>   			goto out;
>>   		}
>> -		memset(&dev_info, 0, sizeof(dev_info));
>>   		ret = get_device_info(fd, i, &dev_info);
>>   
>>   		if (ret == -ENODEV)
>> @@ -747,16 +842,16 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>>   			goto out;
>>   		}
>>   
>> -		/*
>> -		 * Skip seed device by checking device's fsid (requires root).
>> -		 * And we will skip only if dev_to_fsid is successful and dev
>> -		 * is a seed device.
>> -		 * Ignore any other error including -EACCES, which is seen when
>> -		 * a non-root process calls dev_to_fsid(path)->open(path).
>> -		 */
>> -		ret = dev_to_fsid((const char *)dev_info.path, fsid);
>> -		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
>> +		ret = is_seed_device(fd, i, fi_args.fsid, &dev_info);
>> +		/* Skip seed device. */
>> +		if (ret > 0)
>>   			continue;
>> +		if (ret < 0){
>> +			errno = -ret;
>> +			warning(
>> +		"unable to determine if devid %u is seed: %m, assuming not", i);
> 
> Strange that 'i' is printed here as it's int but devids are u64, so the
> types don't match.
> 
>> +			ret = 0;
>> +		}
>>   
>>   		info[ndevs].devid = dev_info.devid;
>>   		if (!dev_info.path[0]) {
>> -- 
>> 2.39.1
