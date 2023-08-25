Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735C788FD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHYU2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHYU1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:27:53 -0400
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDC1BEB
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:27:50 -0700 (PDT)
Received: from c-73-11-250-112.hsd1.wa.comcast.net ([73.11.250.112] helo=[192.168.1.226])
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qZdPJ-0007CJ-6Y; Fri, 25 Aug 2023 20:27:49 +0000
Message-ID: <0f1c3625-8ab8-d455-46ed-04b6a17b5f28@trager.us>
Date:   Fri, 25 Aug 2023 13:27:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, lennart@poettering.net,
        daan.j.demeyer@gmail.com
References: <20230825010542.4158944-1-lee@trager.us>
 <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
 <20230825114718.GN2420@twin.jikos.cz> <20230825115040.GO2420@twin.jikos.cz>
Content-Language: en-US
From:   Lee Trager <lee@trager.us>
In-Reply-To: <20230825115040.GO2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 8/25/23 4:50 AM, David Sterba wrote:
> On Fri, Aug 25, 2023 at 01:47:18PM +0200, David Sterba wrote:
>> On Thu, Aug 24, 2023 at 06:23:50PM -0700, Lee Trager wrote:
>>>> --- a/fs/btrfs/volumes.h
>>>> +++ b/fs/btrfs/volumes.h
>>>> @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>>>>    		      struct btrfs_device *device, u64 new_size);
>>>>    struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
>>>>    				       const struct btrfs_dev_lookup_args *args);
>>>> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>>>> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
>>>>    int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>>>>    int btrfs_balance(struct btrfs_fs_info *fs_info,
>>>>    		  struct btrfs_balance_control *bctl,
>>>> @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
>>>>    int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>>>>    int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
>>>>    int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
>>>> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
>>>>    int btrfs_uuid_scan_kthread(void *data);
>>>>    bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>>>>    void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
>>> I plan on sending a follow up patch to optionally resize block groups to
>>> the amount of space used by data and metadata. This will allow the
>>> creation of small distributed btrfs OS images.
>> Can you create the images in userspace with such properties?
> Also we have that already as "mkfs.btrfs --shrink".

mkfs.btrfs --rootdir foo --shrink doesn't support many btrfs features 
such as subvolumes and compression. To use those features you must mount 
the filesystem and make those modifications. Once those modifications 
are made the filesystem must be shrunk. systemd has its own logic to 
figure out how to shrink the filesystem after these operations are 
complete using a bisect algorithm[1]. This patch allows users such as 
systemd to minimize the filesystem with one command which uses internal 
data to quickly get the right size.

[1] 
https://github.com/systemd/systemd/blob/main/src/home/homework-luks.c#L2957

