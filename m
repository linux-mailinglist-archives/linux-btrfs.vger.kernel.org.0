Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407BE25B2C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBROJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBROI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 13:14:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C040C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 10:14:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o64so354988qkb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6adoTve9zeQPmdqINkyHkMTdb/f7HoBVJLeasaxAAQU=;
        b=dq+3YFhVCrMIkB1NdUvEx+e2NH5BWf0IL/AJTynY5Z4e59EPGvkVb3IPiZuLzMR/k7
         nIrpTVpo4r6HyUCE8pcUn5oxajQPGJxaoqeUFxpSSTNAcFkx0iIccdmw24P4PSz330ER
         nMuNf8y+MXKSDcAWG6xip1vyUssF7K089ZWvf3uKDiQzBaVUSW0+Jjhb6gK7lcShBt/e
         6SA0duNtx2Hs7kzjt+EvdPrFRgo6p6uHYzFswdiRWuf/zUlfj0jgy6OR6CeStrsHuLYu
         noRjXc+LRAywxnPCFw/4j7XYUGc/DsHlPuTDQ3vdm1FsOeeDLNdFEjBqzt4EZSvgVYou
         lmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6adoTve9zeQPmdqINkyHkMTdb/f7HoBVJLeasaxAAQU=;
        b=ZPpod27pzSYe3Z1/xEdh9znBS0uOnG/F3+yKTl3+LziOd/pEYAhqUQkplsNQF24Ayg
         MlsY4GEcT0GD41HSAncb4CTCTMo/rwM4gy3ynBMMh33Gk+r13I3zJqqTqfXy+9TODk9l
         rh/1c2Kjmr1rAq2wvmNdclGweGzIWwCfb+6aPz/qw3jEylvSLfw7Wjg0urR60eBcTzOl
         qZrVo4t07YFO2jBfY5xENaYTw8oXIzaBgkV9nqk0r5ZASsvSfGPrcsxluB0FlSxqxmUH
         LEegy0gFKB49pzMx3cqshARBRkdcFcVjQaRpXWvrsVETsAHJ5V+a82KgVQd6vQ8dmM79
         IKyQ==
X-Gm-Message-State: AOAM531uFIJTxI0mdcaFGfw8vj2uyigqfM30ag4uHwgF2NLqxx4yyNR4
        mL6040xgSy6mYf+YmolWngzIDKuUUxxmLGpf7Go=
X-Google-Smtp-Source: ABdhPJwWMMDrTEyOOpSWTy2X5Fd8pHUVdnU5lpydCR4BMCJvV4T79Ita0w8G70wIaTInny4EIy3j5w==
X-Received: by 2002:a37:7dc4:: with SMTP id y187mr1843993qkc.325.1599066846653;
        Wed, 02 Sep 2020 10:14:06 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm2444qtm.46.2020.09.02.10.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:14:05 -0700 (PDT)
Subject: Re: [PATCH] btrfs: allow single disk devices to mount with older
 generations
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Daan De Meyer <daandemeyer@fb.com>
References: <6b1f037344cd8d24566f3d9873b820a73384242c.1598995167.git.josef@toxicpanda.com>
 <779c5224-6726-9a8d-8eab-ffb610cd5ad1@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5a7f5cf7-c70f-8c6e-d402-381ca0d8a7e9@toxicpanda.com>
Date:   Wed, 2 Sep 2020 13:14:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <779c5224-6726-9a8d-8eab-ffb610cd5ad1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 6:41 AM, Anand Jain wrote:
> On 2/9/20 5:19 am, Josef Bacik wrote:
>> We have this check to make sure we don't accidentally add older devices
>> that may have disappeared and re-appeared with an older generation from
>> being added to an fs_devices.  This makes sense, we don't want stale
>> disks in our file system.  However for single disks this doesn't really
>> make sense.  I've seen this in testing, but I was provided a reproducer
>> from a project that builds btrfs images on loopback devices.  The
>> loopback device gets cached with the new generation, and then if it is
>> re-used to generate a new file system we'll fail to mount it because the
>> new fs is "older" than what we have in cache.
>>
>> Fix this by simply ignoring this check if we're a single disk file
>> system, as we're not going to cause problems for the fs by allowing the
>> disk to be mounted with an older generation than what is in our cache.
>>
>> I've also added a error message for this case, as it was kind of
>> annoying to find originally.
>>
>> Reported-by: Daan De Meyer <daandemeyer@fb.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/volumes.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 77b7da42c651..eb2cc27ef602 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -786,6 +786,7 @@ static noinline struct btrfs_device *device_list_add(const 
>> char *path,
>>       struct rcu_string *name;
>>       u64 found_transid = btrfs_super_generation(disk_super);
>>       u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
>> +    bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
>>       bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>>           BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>>       bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>> @@ -914,7 +915,8 @@ static noinline struct btrfs_device *device_list_add(const 
>> char *path,
>>            * tracking a problem where systems fail mount by subvolume id
>>            * when we reject replacement on a mounted FS.
>>            */
>> -        if (!fs_devices->opened && found_transid < device->generation) {
>> +        if (multi_disk && !fs_devices->opened &&
>> +            found_transid < device->generation) {
>>               /*
>>                * That is if the FS is _not_ mounted and if you
>>                * are here, that means there is more than one
>> @@ -922,6 +924,10 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>                * with larger generation number or the last-in if
>>                * generation are equal.
>>                */
>> +            btrfs_warn_in_rcu(device->fs_info,
>> +          "old device %s not being added for fsid:devid for %pU:%llu",
>> +                      rcu_str_deref(device->name),
>> +                      disk_super->fsid, devid);
>>               mutex_unlock(&fs_devices->device_list_mutex);
>>               return ERR_PTR(-EEXIST);
>>           }
>>
> 
> After the patch - that means if there are two identical but different
> generation images/disks and if the systemd auto-scans both of them,
> the scan will race and the last scanned disk/image will mount
> successfully. Whereas before the patch- the disk/image with the larger
> generation always won (even in single disk FS).
> 
> Are we ok with this? IMO the last scanned gets mounted is also kind of fair.
> 
> Internally I had a similar reported. I just told them to use
>   btrfs device scan --forget
> and try. It worked.
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 

Yeah it's kind of wonky, really I just want to make the "surprise! this doesn't 
work" aspect of this go away.  There's some cases where you really just need to 
do btrfs device scan --forget, and that'll be ok.  But for the basic "I mounted 
this, and then blew everything away, and then tried to mount the old version", I 
want it to work without being weird.  Thanks,

Josef
