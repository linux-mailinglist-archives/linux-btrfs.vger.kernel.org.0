Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA93D57DCF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiGVIxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiGVIwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 04:52:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111CA0BBD;
        Fri, 22 Jul 2022 01:52:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C73A6347DF;
        Fri, 22 Jul 2022 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658479929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9ky5nOTQbieQrKj9AKccRiTwh11U9NC7wDHWspODvo=;
        b=KSm4Uz9vbxB4Bhs1Hg+MN3O6if32HTbXwHNdmg6JdGY05tZzj4j7J+n+WOagS8VuSIUivw
        NvZoaguPVZDbx5tAU9lU+rc4uZRyc4jQccJqKYbBFxpqhDxw/ijBDdLxMRU9vCxzFqCP5C
        3E2BCAZ/9dlIroTh69bB8nl2iRfqLME=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 439CC134A9;
        Fri, 22 Jul 2022 08:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A/awDTll2mIkVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Jul 2022 08:52:09 +0000
Message-ID: <ff0b95bb-96ec-6294-2306-441e93077bd8@suse.com>
Date:   Fri, 22 Jul 2022 11:52:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH]btrfs: Fix fstest case btrfs/219
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>, anand.jain@oracle.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721083609.5695-1-hmsjwzb@zoho.com>
 <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
 <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.07.22 г. 8:34 ч., hmsjwzb wrote:
> 
> 
> On 7/21/22 09:37, Nikolay Borisov wrote:
>>
>>
>> On 21.07.22 г. 11:36 ч., Flint.Wang wrote:
>>> Hi,
>>> fstest btrfs/291 failed.
>>>
>>> [How to reproduce]
>>> mkdir -p /mnt/test/219.mnt
>>> xfs_io -f -c "truncate 256m" /mnt/test/219.img1
>>> mkfs.btrfs /mnt/test/219.img1
>>> cp /mnt/test/219.img1 /mnt/test/219.img2
>>> mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
>>> umount /mnt/test/219.mnt
>>> losetup -f --show /mnt/test/219.img1 dev
>>> mount /dev/loop0 /mnt/test/219.mnt
>>> umount /mnt/test/219.mnt
>>> mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt
>>>
>>> [Root cause]
>>> if (fs_devices->opened && found_transid < device->generation) {
>>>      /*
>>>       * That is if the FS is _not_ mounted and if you
>>>       * are here, that means there is more than one
>>>       * disk with same uuid and devid.We keep the one
>>>       * with larger generation number or the last-in if
>>>       * generation are equal.
>>>       */
>>>      mutex_unlock(&fs_devices->device_list_mutex);
>>>      return ERR_PTR(-EEXIST);
>>> }
>>>
>>> [Personal opinion]
>>> User might back up a block device to another. I think it is improper
>>> to forbid user from mounting it.
>>>
>>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>>
>>
>> This lacks any explanation whatsoever so it's not possible to judge whether the fix is correct or not.
>>
>>> ---
>>>    fs/btrfs/volumes.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 6aa6bc769569a..76af32032ac85 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>>             * tracking a problem where systems fail mount by subvolume id
>>>             * when we reject replacement on a mounted FS.
>>>             */
>>> -        if (!fs_devices->opened && found_transid < device->generation) {
>>> +        if (fs_devices->opened && found_transid < device->generation) {
>>>                /*
>>>                 * That is if the FS is _not_ mounted and if you
>>>                 * are here, that means there is more than one
> 
> Hi Nikolay,
> 
> It seems the failure of btrfs/219 needs some explanation.
> 
> Here is the thing.
>          1. A storage device A with btrfs filesystem is running on a host.
>          2. For example, we backup the device A to an exactly some device B.
>          3. The device A continue to run for a while so the device->generation is getting bigger.
>          4. Then you umount the device A and try to mount device B.
>          5. Kernel find that device A has the same UUID as device B and has bigger device->generation.
>             So the mount request of device B will be rejected.
> 
>              if (!fs_devices->opened && found_transid < device->generation) {
>                   /*
>                    * That is if the FS is _not_ mounted and if you
>                    * are here, that means there is more than one
>                    * disk with same uuid and devid.We keep the one
>                    * with larger generation number or the last-in if
>                    * generation are equal.
>                    */
>                    mutex_unlock(&fs_devices->device_list_mutex);
>                    return ERR_PTR(-EEXIST);
>              }
> 
> I think it is improper to reject that request. Because device A is not in open state.

But then you will gravely confuse the filesystem about which device is 
the latest one, no? This code is rather old and the comments doesn't 
really help. So I'd like Chris (as the original author) to chime in on 
what the expected behavior should be ? IMO we shouldn't be allowing to 
add devices with older generation at all, irrespective of whether the fs 
is mounted or not.


> 
> Thanks
