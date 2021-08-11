Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D63E9AF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 00:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhHKWe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHKWe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 18:34:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3FC061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 15:34:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso7497153pjb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=blmY+Dlh1rVKvP9LoUByfTzlspf06JIp06Um7rPstFs=;
        b=E2eXLhdsytp0tmpD+lZnGef/fmO2goKVJnymfLkPh1vE7rmme0ybAxYXOWre3zcyms
         N0XAS5m467+TQ/tSUVmn4UQDPBi6kwjtbU2EAI0vDAH7Pt6pSCHV7p6W4/5Z6oEuA3AO
         /d8AwBqItV4cNRGxVKcyogcF9DiX6wvtiaVHo6bjrCFIdfx+TzuqSbi2dCmnFrI+LhH1
         7KlAJctYCJbS7VJAhV1PpJ8TvL7laugjjQOy8aZqD994AjqRoy3MoAWWav1MC4Yk4OwB
         BzABbz57LEhITJH9oXS8Kctsx+hNjAy2F8R89jNCQjgbok/Fd0pC77IKcjqKf501K1pu
         JDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=blmY+Dlh1rVKvP9LoUByfTzlspf06JIp06Um7rPstFs=;
        b=q/bGeIuN7kQYlMb0CxgtMQKFRokqBc6f3iGow6pLP7vsd+M0wUwyHnWKXJWmvYIbBG
         S0SaEyGfze/Ej904R6KeUw0lSzOaBJmRU6PPVk5mOLEddEazvD+aQfoNEBsbHEGqa/y9
         rP255TvJFzWWnfdcKAtvGd2V+VCIY4uEVDT1z6UqUtw2HuhOnJQRylsPXAtbd05jiirO
         bz+dvR3sg4VG7jeTUHa0uqGNDAXs8FO5a1HxLy9Ls5hhbQOVLg8NWcQ6jsvYEkujnaDm
         UbG98f9QrpsuwLEgXCqphprOux2c/pL3uNP6Ysak0+9Rf41ZZcz0BOvDta/H3Tn0Ltfb
         hooA==
X-Gm-Message-State: AOAM531QZ9rvIZ9igf+TYf4/nIVkCert7ojJrCkVaSyLJmMaK01/a9wL
        7ddLJTW7yfVNptf5wPmZLPo=
X-Google-Smtp-Source: ABdhPJzYKTDu4MzeJ1cc6DLG8Bn0YVyol+jDUmhEp93PeiKnPVaCRbprxEggkow7f6GiD+bX15mOEA==
X-Received: by 2002:a17:902:ea02:b029:12c:916f:ff1f with SMTP id s2-20020a170902ea02b029012c916fff1fmr925213plg.45.1628721272184;
        Wed, 11 Aug 2021 15:34:32 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id n1sm604147pgt.63.2021.08.11.15.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:34:31 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
Date:   Wed, 11 Aug 2021 15:34:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 14:51, Qu Wenruo wrote:
>
>
> On 2021/8/12 上午3:33, Konstantin Svist wrote:
>> On 8/10/21 22:49, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/11 下午1:34, Konstantin Svist wrote:
>>>> On 8/10/21 22:24, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/8/11 下午1:22, Konstantin Svist wrote:
>>>>>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>>>>>
>>>>>>> Oh, that btrfs-map-logical is requiring unnecessary trees to
>>>>>>> continue.
>>>>>>>
>>>>>>> Can you re-compile btrfs-progs with the attached patch?
>>>>>>> Then the re-compiled btrfs-map-logical should work without problem.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Awesome, that worked to map the sector & mount the partition.. but I
>>>>>> still can't access subvol_root, where the recent data is:
>>>>>
>>>>> Is subvol_root a subvolume?
>>>>>
>>>>> If so, you can try to mount the subvolume using subvolume id.
>>>>>
>>>>> But in that case, it would be not much different than using
>>>>> btrfs-restore with "-r" option.
>>>>
>>>>
>>>> Yes it is.
>>>>
>>>> # mount -oro,rescue=all,subvol=subvol_root /dev/sdb3 /mnt/
>>>> mount: /mnt: can't read superblock on /dev/sdb3.
>>>
>>> I mean using subvolid=<number>
>>>
>>> Using subvol= will still trigger the same path lookup code and get
>>> aborted by the IO error.
>>>
>>> To get the number, I guess the regular tools are not helpful.
>>>
>>> You may want to manually exam the root tree:
>>>
>>> # btrfs ins dump-tree -t root <device>
>>>
>>> Then look for the keys like (<number> ROOT_ITEM <0 or number>), and try
>>> passing the first number to "subvolid=" option.
>>
>> This works (and numbers seem to be the same as from dump-tree):
>> # mount -oro,rescue=all /dev/sdb3 /mnt/
>> # btrfs su li /mnt/
>> ID 257 gen 166932 top level 5 path subvol_root
>> ID 258 gen 56693 top level 5 path subvol_snapshots
>> ID 498 gen 56479 top level 258 path subvol_snapshots/29/snapshot
>> ID 499 gen 56642 top level 258 path subvol_snapshots/30/snapshot
>> ID 500 gen 56691 top level 258 path subvol_snapshots/31/snapshot
>>
>> This also works (not what I want):
>> # mount -oro,rescue=all,subvol=subvol_snapshots /dev/sdb3 /mnt/
>>
>>
>> But this doesn't:
>>
>> # mount -oro,rescue=all,subvolid=257 /dev/sdb3 /mnt/
>> mount: /mnt: can't read superblock on /dev/sdb3.
>>
>> dmesg:
>> BTRFS error (device sdb3): bad tree block start, want 920748032 have 0
>>
>>
> Then it means, the tree blocks of that subvolume is corrupted, thus no
> way to read that subvolume, unfortunately.
>
> Thanks,
> Qu


Shouldn't there be an earlier generation of this subvolume's tree block
somewhere on the disk? Would all of them have gotten overwritten already?

Any hope for any individual files, if not for subvolume?




