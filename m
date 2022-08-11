Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A558F770
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiHKGII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiHKGIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 02:08:07 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA27C19C
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660198077; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=j4HN7xuOOZ7DBaw9+3dPoq9jaSor4WBKuoACqmhwQbJVvecIL+JfzW+ZbApcy9/l9qAhmsgz6Iv2Pc3TeJcFJta7L9aiYz6coC2AMeJrixSYTTArBFXdrtMNW3It6G7afRJlk17lx5Np5gjD/Q1SvdfG0KkVzmfIAOnlAjvWXpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660198077; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vVUbtzuyfrkOg59SaLWqGOhWiiJx4UI/Ev8DVR2eA+Q=; 
        b=HEp2CrDHDkn8a+6336L1O47IC8M0EUeAhEOIogjhS7HoHlry1bzL70qZCV+5U5YrQWEBfrRg25QzgaGdDJQGHTBDgr729QH7290fNdlYlFi3HZMtIVISVdA4riNZc3LqR35x0mW19VX3wNtEEmtAuiJtJVH3C+9jqGtqjuK3l5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=Ej6Er/os652hjhYJaJVGlQdetB80E4RkPjCWYdWY8D3Q8TMnhhjUijTJjP/u0iRTVcmJTaVus+xm
    R79FKAXh1fG01j6S2FGCfssT/AKJKoFCgAX4KE1PiL+wWeqxA/Ug  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660198077;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vVUbtzuyfrkOg59SaLWqGOhWiiJx4UI/Ev8DVR2eA+Q=;
        b=QBPpdVrjA1SRC5ST1ZnnpP1Iry28ZBKRLkxEKHwLmODT53C8YwCtIPuMST1YZVBF
        dBECP8VqhE/LW5Ztd/Gv3wiP7HXXKjRyVHzyYnYZFF15JVdbOTVT0Ju/Nw8vQRxsbNM
        MulLm/8j3A2mXDjNVctRbAHPrc8vQQC1T2TqMVms=
Received: from [192.168.0.103] (58.247.201.151 [58.247.201.151]) by mx.zohomail.com
        with SMTPS id 1660198072922168.56023654507771; Wed, 10 Aug 2022 23:07:52 -0700 (PDT)
Message-ID: <548b9707-1fbd-c906-b195-3b8ffe93863e@zoho.com>
Date:   Thu, 11 Aug 2022 02:07:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs-progs: Fix seed device bug for btrfs249
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, anand.jain@oracle.com,
        nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
References: <20220810073347.4998-1-hmsjwzb@zoho.com>
 <d410d2f3-497c-d79b-f413-fbacc9211fac@gmx.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <d410d2f3-497c-d79b-f413-fbacc9211fac@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for you reply. I am working on the tree-search based solution.
I have got the btrfs_dev_item from the chunk tree.
But I don't know how to tell whether it is a seed device.
Do you have some solution to tell whether it is a seed device or not?

Thanks,
Flint

On 8/10/22 03:56, Qu Wenruo wrote:
> Commit message please.
> 
> On 2022/8/10 15:33, Flint.Wang wrote:
>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>> ---
>>   cmds/device.c           |  2 +-
>>   cmds/filesystem-usage.c | 10 +++++-----
>>   cmds/filesystem-usage.h |  2 +-
>>   common/utils.c          |  9 +++++----
>>   common/utils.h          |  2 +-
>>   ioctl.h                 |  2 ++
>>   6 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/cmds/device.c b/cmds/device.c
>> index 7d3febff..81559110 100644
>> --- a/cmds/device.c
>> +++ b/cmds/device.c
>> @@ -752,7 +752,7 @@ static int _cmd_device_usage(int fd, const char *path, unsigned unit_mode)
>>       int devcount = 0;
>>
>>       ret = load_chunk_and_device_info(fd, &chunkinfo, &chunkcount, &devinfo,
>> -            &devcount);
>> +            &devcount, false);
>>       if (ret)
>>           goto out;
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index 01729e18..b2ed3212 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -693,7 +693,7 @@ out:
>>    *  This function loads the device_info structure and put them in an array
>>    */
>>   static int load_device_info(int fd, struct device_info **device_info_ptr,
>> -               int *device_info_count)
>> +               int *device_info_count, bool noseed)
>>   {
>>       int ret, i, ndevs;
>>       struct btrfs_ioctl_fs_info_args fi_args;
>> @@ -727,7 +727,7 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
>>               goto out;
>>           }
>>           memset(&dev_info, 0, sizeof(dev_info));
>> -        ret = get_device_info(fd, i, &dev_info);
>> +        ret = get_device_info(fd, i, &dev_info, noseed);
>>
>>           if (ret == -ENODEV)
>>               continue;
>> @@ -779,7 +779,7 @@ out:
>>   }
>>
>>   int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
>> -        int *chunkcount, struct device_info **devinfo, int *devcount)
>> +        int *chunkcount, struct device_info **devinfo, int *devcount, bool noseed)
>>   {
>>       int ret;
>>
>> @@ -791,7 +791,7 @@ int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
>>           return ret;
>>       }
>>
>> -    ret = load_device_info(fd, devinfo, devcount);
>> +    ret = load_device_info(fd, devinfo, devcount, noseed);
>>       if (ret == -EPERM) {
>>           warning(
>>           "cannot get filesystem info from ioctl(FS_INFO), run as root");
>> @@ -1172,7 +1172,7 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
>>               printf("\n");
>>
>>           ret = load_chunk_and_device_info(fd, &chunkinfo, &chunkcount,
>> -                &devinfo, &devcount);
>> +                &devinfo, &devcount, true);
>>           if (ret)
>>               goto cleanup;
>>
>> diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
>> index cab38462..6fd04172 100644
>> --- a/cmds/filesystem-usage.h
>> +++ b/cmds/filesystem-usage.h
>> @@ -45,7 +45,7 @@ struct chunk_info {
>>   };
>>
>>   int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
>> -        int *chunkcount, struct device_info **devinfo, int *devcount);
>> +        int *chunkcount, struct device_info **devinfo, int *devcount, bool noseed);
>>   void print_device_chunks(struct device_info *devinfo,
>>           struct chunk_info *chunks_info_ptr,
>>           int chunks_info_count, unsigned unit_mode);
>> diff --git a/common/utils.c b/common/utils.c
>> index 1ed5571f..72d50885 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -285,14 +285,15 @@ void btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
>>   }
>>
>>   int get_device_info(int fd, u64 devid,
>> -        struct btrfs_ioctl_dev_info_args *di_args)
>> +        struct btrfs_ioctl_dev_info_args *di_args, bool noseed)
>>   {
>>       int ret;
>> +    unsigned long req = noseed ? BTRFS_IOC_DEV_INFO_NOSEED : BTRFS_IOC_DEV_INFO;
>>
>>       di_args->devid = devid;
>>       memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
>>
>> -    ret = ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
>> +    ret = ioctl(fd, req, di_args);
>>       return ret < 0 ? -errno : 0;
>>   }
>>
>> @@ -498,7 +499,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
>>            * search_chunk_tree_for_fs_info() will lacks the devid 0
>>            * so manual probe for it here.
>>            */
>> -        ret = get_device_info(fd, 0, &tmp);
>> +        ret = get_device_info(fd, 0, &tmp, false);
> 
> No, I don't think we should go that complex.
> 
> The root cause is pretty simple, btrfs_ioctl_fs_info() just return RW
> devices for its fi_args->num_devices.
> 
> This is fine for most cases, but for seed devices cases, we can not rely
> on that.
> 
> 
> Knowing that, it's much easier to fix in user space, do a tree-search
> ioctl to grab the device items from chunk tree, then we can easily check
> the total number of devices (including RW and seed devices).
> 
> With that info, we even have the FSID of each devices, then we can call
> btrfs_ioctl_dev_info() to get each device.
> 
> 
> I'd like to have a better optimization, to skip above chunk tree search,
> but I don't have a quick idea on how to determine if a fs has seed devices.
> 
> 
> Another more elegant solution is to make btrfs_ioctl_fs_info_args to
> include one new member, total_devs, so that we can get rid of all the
> problems.
> 
> But for compatibility reasons, above tree-search based solution is still
> needed as a fallback.
> 
> Thanks,
> Qu
> 
>>           if (!ret) {
>>               fi_args->num_devices++;
>>               ndevs++;
>> @@ -521,7 +522,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
>>           memcpy(di_args, &tmp, sizeof(tmp));
>>       for (; last_devid <= fi_args->max_id && ndevs < fi_args->num_devices;
>>            last_devid++) {
>> -        ret = get_device_info(fd, last_devid, &di_args[ndevs]);
>> +        ret = get_device_info(fd, last_devid, &di_args[ndevs], false);
>>           if (ret == -ENODEV)
>>               continue;
>>           if (ret)
>> diff --git a/common/utils.h b/common/utils.h
>> index ea05fe5b..de4f93ca 100644
>> --- a/common/utils.h
>> +++ b/common/utils.h
>> @@ -68,7 +68,7 @@ int lookup_path_rootid(int fd, u64 *rootid);
>>   int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount);
>>   int find_mount_root(const char *path, char **mount_root);
>>   int get_device_info(int fd, u64 devid,
>> -        struct btrfs_ioctl_dev_info_args *di_args);
>> +        struct btrfs_ioctl_dev_info_args *di_args, bool noseed);
>>   int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
>>
>>   const char *subvol_strip_mountpoint(const char *mnt, const char *full_path);
>> diff --git a/ioctl.h b/ioctl.h
>> index 368a87b2..e68fe58d 100644
>> --- a/ioctl.h
>> +++ b/ioctl.h
>> @@ -883,6 +883,8 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
>>                       struct btrfs_ioctl_scrub_args)
>>   #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
>>                       struct btrfs_ioctl_dev_info_args)
>> +#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
>> +                       struct btrfs_ioctl_dev_info_args)
>>   #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
>>                                    struct btrfs_ioctl_fs_info_args)
>>   #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
