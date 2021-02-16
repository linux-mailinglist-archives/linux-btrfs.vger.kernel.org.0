Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668EF31D205
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 22:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBPVZl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 16:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBPVZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 16:25:40 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A0C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 13:25:00 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t62so10874148qke.7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TiKegM4nlemREbwsF18GNQVb2KibxsrrxpW4ZK6JyG4=;
        b=AI6/MDMxbWE18CZqrZaFwn+d/iwsw765vq/SrjztJ/LLqzjKcpLCWBjObV3703kULL
         caqGgs9Ji+uQGsG/ItVWJVPCBXdf1wF2rTqkjC4wr/ycvcnxHdmPhnss3+Dvjr8tXnep
         Lm4ft0ckpV0Ex6iMu9z5d51lpTzAKyhKSG/89rpTsfdruC60HSPL8By4JDOEwrjNe+cu
         8QOpM+biCgbvGUBFcjN/RCwdRe4DR+IZ0FtCP/2hRm0X0FB5OWpMkm/U3eqEsy1rpdGg
         B3tCOXNm/pfuXmQbM/EG2XTE0vT2O5eMz0hwe7PHYn7CIy7MHDG5zz98uqECuP+AtBXu
         oSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TiKegM4nlemREbwsF18GNQVb2KibxsrrxpW4ZK6JyG4=;
        b=uNXJrvNO35RxZTeOsSuNEg2weD3oQhVO0jmZIZ/3EBUdgCwjz+UBDe+TjIK96nUeZA
         IdN+kubH6YhxwsW94er7Ur111hJ6haYs4K+toaxf3Ck66sorXSAyfHnVj9FcxIr/0bQM
         OE2XlTMhU6O75QVWzeJUUPPwAXfP0g43OeMkcD4z5OKkCuN5bS63pxFRVsYvU8Y/oV0b
         ZxpEnVbAMprtLyuSiLfs4zaaZ/Zacf8Y2B9Gw4cifFBoWMeLWUBRuh/zt0RNZtFAkq/A
         lmoQcojfiZU7oRnv1D11YqiPuz0U5iC3WEG5ZUP5tHOvXtjRRhd9r3rC7HSXaEgmgQDl
         AqKA==
X-Gm-Message-State: AOAM531WnOSbxRFghbN5/tyrVJVDyspNBnMSEbBo5p1stDw52/jfvXgl
        NaupjdFq90WON0LRapofVsrWLaLT5mpYwcZW
X-Google-Smtp-Source: ABdhPJy3i3Gl17NhtpCEgt0MKBOh2Sol5ch42P6vMVG69HFf5KtGtfZeVJy9gJQB21McqzykgwlOMg==
X-Received: by 2002:a37:49cd:: with SMTP id w196mr21334780qka.288.1613510698966;
        Tue, 16 Feb 2021 13:24:58 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w14sm10247642qto.46.2021.02.16.13.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 13:24:58 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
 <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
 <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com>
Date:   Tue, 16 Feb 2021 16:24:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/16/21 3:29 PM, Neal Gompa wrote:
> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>> Hey all,
>>>>>
>>>>> So one of my main computers recently had a disk controller failure
>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>> journal:
>>>>>
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>
>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>> seem to find any reasonably good information on how to do recovery in
>>>>> this scenario, even to just recover enough to copy data off.
>>>>>
>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>> using btrfs-progs v5.10.
>>>>>
>>>>> Can anyone help?
>>>>
>>>> Can you try
>>>>
>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>
>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>> other magic.  Thanks,
>>>>
>>>> Josef
>>>
>>> I got the same error as I did with btrfs-check --readonly...
>>>
>>
>> Oh lovely, what does btrfs check --readonly --backup do?
>>
> 
> No dice...
> 
> # btrfs check --readonly --backup /dev/sda3
>> Opening filesystem to check...
>> parent transid verify failed on 791281664 wanted 888893 found 888895
>> parent transid verify failed on 791281664 wanted 888893 found 888895
>> parent transid verify failed on 791281664 wanted 888893 found 888895

Hey look the block we're looking for, I wrote you some magic, just pull

https://github.com/josefbacik/btrfs-progs/tree/for-neal

build, and then run

btrfs-neal-magic /dev/sda3 791281664 888895

This will force us to point at the old root with (hopefully) the right bytenr 
and gen, and then hopefully you'll be able to recover from there.  This is kind 
of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,

Josef
