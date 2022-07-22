Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71D857D9CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 07:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiGVFea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFea (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 01:34:30 -0400
Received: from sender4-pp-o93.zoho.com (sender4-pp-o93.zoho.com [136.143.188.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98B4951EF;
        Thu, 21 Jul 2022 22:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658468062; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=L7viaXs6ZrQyPRmMHAYIAEqffFbsdD1HaFIkjD5qlNpmDg/Rr1EKRakxXmCnsfOOlzCBK7vi1e2g+FKFfTdSkaZPZuicrO1RzAJyN5tm9A2B+T0OKBkAQqt3Usyqm6Lc918syDPa8WjIRTEESaim1mBcyQdgXbpH+cVp1FkFeOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658468062; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3Y135H/p5PIbkFVE4WHHlr16JMNUlFTePqjl6a/bfpY=; 
        b=DYthUuCvHDzYsuwTWCuTOACD53GJSgJHnIY+NhjjbFlWqUUhBi7MiPaaUrKfCVy+TfbBpgwv8OWt/278uvdqmTnv4kC/hneOAFsx06HqFFoRx6HebVDuEggdBrfwwVIvAjjqRHvcTKfNzMV6b+iVeo4mxvxEV9CXhM2aYiuc+Ec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=F5pGxiSE0x1csP3J0cX7cXlYXGs3XcleU4LY2UImdK5f2ASH/wGPkbd3UX5Zaq7JBQR2dgM8QnxP
    6anc1Gzkl6RkmEmH1NNksO+vYoALHYSnZAX9QHW3aX4d9z3QLlng  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658468062;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=3Y135H/p5PIbkFVE4WHHlr16JMNUlFTePqjl6a/bfpY=;
        b=RNWbNGWaZjRBYLtN2oFWrhBnxViMEnujGXndlU5GIKO0wVokku0iAyVnIswbKTJm
        k9nV/WV2J0uljb+wh7PB8LTK4pf60wcFJ0xHl/SBeOOKJ+MtnP+7rTw81F7u3xntBUX
        vOHOlUU9SwVBbc48vsxCJ13rt1PfwLqCnaecK4XY=
Received: from [10.42.0.6] (85.203.23.77 [85.203.23.77]) by mx.zohomail.com
        with SMTPS id 1658468060819939.9691730356952; Thu, 21 Jul 2022 22:34:20 -0700 (PDT)
Message-ID: <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
Date:   Fri, 22 Jul 2022 01:34:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH]btrfs: Fix fstest case btrfs/219
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721083609.5695-1-hmsjwzb@zoho.com>
 <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/21/22 09:37, Nikolay Borisov wrote:
> 
> 
> On 21.07.22 г. 11:36 ч., Flint.Wang wrote:
>> Hi,
>> fstest btrfs/291 failed.
>>
>> [How to reproduce]
>> mkdir -p /mnt/test/219.mnt
>> xfs_io -f -c "truncate 256m" /mnt/test/219.img1
>> mkfs.btrfs /mnt/test/219.img1
>> cp /mnt/test/219.img1 /mnt/test/219.img2
>> mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
>> umount /mnt/test/219.mnt
>> losetup -f --show /mnt/test/219.img1 dev
>> mount /dev/loop0 /mnt/test/219.mnt
>> umount /mnt/test/219.mnt
>> mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt
>>
>> [Root cause]
>> if (fs_devices->opened && found_transid < device->generation) {
>>     /*
>>      * That is if the FS is _not_ mounted and if you
>>      * are here, that means there is more than one
>>      * disk with same uuid and devid.We keep the one
>>      * with larger generation number or the last-in if
>>      * generation are equal.
>>      */
>>     mutex_unlock(&fs_devices->device_list_mutex);
>>     return ERR_PTR(-EEXIST);
>> }
>>
>> [Personal opinion]
>> User might back up a block device to another. I think it is improper
>> to forbid user from mounting it.
>>
>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> 
> 
> This lacks any explanation whatsoever so it's not possible to judge whether the fix is correct or not.
> 
>> ---
>>   fs/btrfs/volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 6aa6bc769569a..76af32032ac85 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>            * tracking a problem where systems fail mount by subvolume id
>>            * when we reject replacement on a mounted FS.
>>            */
>> -        if (!fs_devices->opened && found_transid < device->generation) {
>> +        if (fs_devices->opened && found_transid < device->generation) {
>>               /*
>>                * That is if the FS is _not_ mounted and if you
>>                * are here, that means there is more than one

Hi Nikolay,

It seems the failure of btrfs/219 needs some explanation.

Here is the thing.
        1. A storage device A with btrfs filesystem is running on a host.
        2. For example, we backup the device A to an exactly some device B.
        3. The device A continue to run for a while so the device->generation is getting bigger.
        4. Then you umount the device A and try to mount device B.
        5. Kernel find that device A has the same UUID as device B and has bigger device->generation.
           So the mount request of device B will be rejected.

            if (!fs_devices->opened && found_transid < device->generation) {
                 /*
                  * That is if the FS is _not_ mounted and if you
                  * are here, that means there is more than one
                  * disk with same uuid and devid.We keep the one
                  * with larger generation number or the last-in if
                  * generation are equal.
                  */
                  mutex_unlock(&fs_devices->device_list_mutex);
                  return ERR_PTR(-EEXIST);
            }

I think it is improper to reject that request. Because device A is not in open state.

Thanks
