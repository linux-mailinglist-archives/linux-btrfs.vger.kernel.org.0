Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFD6F7155
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEDRnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 13:43:22 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7647F133
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1683220861; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=aaQHmiqWWyn3SO7Bqj50mjG1VHVhc5RX594XTPbJcJk=; b=QroaoX+9kEDyv
        EXtOXnyjUkFtcHCjpxElidkm6+1pIcWu7fRB6SYEb+zHT4W7myyXoenRNX83LVlVO3Rgq8O7hNDgZ
        8Znt1sk4ELk3PRtHvSRJwApfwtnVOdyTCiNQ1PD9c7OaMpbMs14zfHUjGPNl1VqOnw3b0Dz+wKCvW
        Ob2qU2YkYrWQVrRsl6Daq/gtqBenDjCF2oUYTimF+4XwhbOslxARzH9JlaQS8nleBrJtl3srYxpeP
        /IafKveFrAt/ROzVE/I6O1HDH9kM7JwKapEhZvEYw64g9VtD6r/J25c6JWm+xrG66aKM0/7HQxaZl
        OOzVJeMo888id6uFk3UJA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1683220863; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=aaQHmiqWWyn3SO7Bqj50mjG1VHVhc5RX594XTPbJcJk=; b=OJ5N++MDPTuwzHBA1TAgz7d72I
        ZjWxeTqm+voJCwdAzhXiACG8YouXF95k20hEWqJJD9rn5bdKdbUs+xddw4t02U9p8X2HI5+DIeBf4
        vdauq52XPJXC369qURMxigJQfqts8wS1SP4b+pB84pHTsWlfwBrUewMaPpbv+XOLoL4wTEzCr+3pU
        VgwOtk0y0ED9/k9RI322NgvD/rpDsK1sxMF6KnCk8pKNwxJFA1T7NcTzkz3HoQEcVlw7WZhyY54je
        Rh+SkjwvaD5HxIucuaaGAZS5xh0xoGiGOL8aBpU+X/IQEKj+qUmVQPjMeGwkRDX3we0COuBn8ic+l
        4sX1SnYw==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1pucz8-00DDZR-2o;
        Thu, 04 May 2023 17:43:19 +0000
Message-ID: <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
Date:   Thu, 4 May 2023 10:43:19 -0700
MIME-Version: 1.0
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/4/23 1:40 AM, Qu Wenruo wrote:
> 
> 
> On 2023/5/4 12:46, Matt Corallo wrote:
>>
>>
>> On 5/1/23 8:41 AM, Matt Corallo wrote:
>>>
>>>
>>> On 4/30/23 9:40 PM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/5/1 10:24, Matt Corallo wrote:
>>>>> Oh, one more replace papercut, its probably worth noting `btrfs
>>>>> scrub status` generally shows gibberish when a replace is running -
>>>>> it appears to show the progress assuming all disks but the one being
>>>>> replaced had already been scrubbed, shows a start date of the last
>>>>> time a scrub was run, etc.
>>>>>
>>>>> On 4/29/23 11:10 PM, Matt Corallo wrote:
>>>>>> Just starting a drive replacement after a disk failure on 6.1.20
>>>>>> (Debian 6.1.20-2~bpo11+1), immediately after an unrelated power
>>>>>> failure, and I got a flood of warnings about free space tree like
>>>>>> the below.
>>>>>>
>>>>>> Presumably unrelatedly, I can't remount the array, I assume because
>>>>>> the device "thats mounted" is the one being replace:
>>>>
>>>> When the mount failed, please provide the dmesg of that failure.
>>>
>>> There's no output in dmesg, only the mount output below. This issue
>>> actually persisted after the replace completed. Scrub seemed fine
>>> (can't offline the array atm), but `mount -o remount,noatime
>>> /a/device/in/the/array /bigraid` worked just fine (after replace
>>> finished, though I assume it would have worked prior as well.
>>>
>>>> And furthermore, btrfs check --readonly output please.
>>
>> A scrub completed successfully, so presumably there's no hidden corruption.
>>
>> Then went to go run a check as requested and on unmount BTRFS complained
>> ten or twenty times about
>>
>> BTRFS warning (device dm-2): folio private not zero on folio .....
>>
>> then btrfs check passed at least through the free space tree:
>>
>> # btrfs check --readonly --progress /dev/mapper/bigraid21_crypt
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/bigraid21_crypt
>> UUID: e2843f83-aadf-418d-b36b-5642f906808f
>> [1/7] checking root items                      (1:27:21 elapsed,
>> 435001145 items checked)
>> [2/7] checking extents                         (9:00:58 elapsed,
>> 45476517 items checked)
>> [3/7] checking free space tree                 (1:32:56 elapsed, 29259
>> items checked)
>> ^C/7] checking fs roots                        (0:01:08 elapsed, 12246
>> items checked)
> 
> So free space tree itself is fine, but the subpage routine is still
> reporting that tree block is not uptodate, thus it must be a runtime error.

Given the check happened after the warnings, is it possible the corruption was trivial and fixed 
itself with a few tree updates?

> There is a bug fix related to subpage tree block writeback code:
> 
> https://lore.kernel.org/linux-btrfs/20230503152441.1141019-3-hch@lst.de/T/#u
> 
> But that problem only happens after some tree block writeback error,
> which is not indicated by the dmesg.
> 
> Any full dmesg output? As only that WARN_ON() is not providing enough
> info unfortunately.

Uhhhh, sure, its 300MB but knock yourself out. This is the full dmesg from the boot after the power 
failure, almost immediately after which the drive replace started, all the way through the unmount 
prior to the check. Generated with the following to remove the piles and piles of errors generated 
by the failing disk. Note that at some points during the replace I swapped the cryptsetup/dm tables 
to an empty one to cause I/Os to the dead disk to fail immediately rather than btrfs hammering it so 
that the replace actually makes progress, swapping it back once it.

You'll see a "BTRFS info: devid 7 device path /dev/dm-8 changed to /dev/mapper/bigraid51_crypt 
scanned by systemd-udevd (341892)" kinda line when that happens.

journalctl -a -b -1 | grep ' kernel: ' | grep -v " Trying to write to read-only block-device" | grep 
-v ' error writing primary super block to device 7' | grep -v 'BTRFS warning.*i/o error at logical' 
| grep -v 'BTRFS error.*dm-2.*fixed up error at logical' | grep -v 'BTRFS warning.*lost page write 
due to IO error' | grep -v 'BTRFS error.*dm-2.*bdev .* errs: wr ' | grep -v 'BTRFS warning.* 
checksum error at logical'

Link coming off-list.

Matt
