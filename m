Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247883E98D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhHKTeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHKTeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 15:34:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FBC061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 12:33:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e15so4022524plh.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sPGbDLhnQPtHq95uClk/vh7MWjxsqjWIqRO1dKdc54o=;
        b=FCqLJQVFuOvxa+8NvSR4iwIxFeWueUgBIZsiX79LRdSp9lHuuISIjcm6wtK64io7KQ
         wDSqnGbLK3JK7Od1AXrtgmN9u9jgB2/FhXFe0kenhphD0BLVVo6SmvOxJmwq9ZXEZUq5
         e/GRaNEKu66lfY+93Tg421DExK/nLkFZA+rWvwUu8FkiNBSiF3gt55OWODrcWaFv2Bzw
         zGmDukiy+TowbpQPUPMoNtfWiyd9j5Xk1nihf2EKpq9TyF5qRq5VfF/o32N9xpjyPAga
         shzycvZA3rLsQASyGe8AFwFb6lmHS9gPs+A9KIveWCCALM/mk3K+x9qUfGWUfF7Qwv5n
         j0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sPGbDLhnQPtHq95uClk/vh7MWjxsqjWIqRO1dKdc54o=;
        b=RGJC4xpF3uA3DyYyT+cCJEh44/9UszscqDzQTj3gBnOTua/QuorXIXDQPcgt6LasqG
         cVGZ6Nans3Cn7fyphWHJ2tCXUXV6D+GLXu9GkDEGRWyNf2WWhXsqCpHB2sYOpu9z9vJy
         bng9Orxpw0OYSVn4iCRFWJPwJSD6/6tl+HEz8eV3SdzQshhp3lknIGImdVydrj5Cl5TI
         NAgbqSpBqWaUNRvstSkEyEKie//XrF5JoQDFXQJl/eswIQunC0bc6UdrCndKe4MhWfHQ
         0OOzGQZT3iSNc01S0xuRdLoKCDJx6iy4WExVVvP1isobdAnrW0cZW/hqB42zjG46a6MB
         3fZA==
X-Gm-Message-State: AOAM533WX3fzjHMUM0BtvHsslB7TktBA7lhLxVKRY8a38vmtikh2YEOV
        Y7kCrMhHQE+NRzm/b7612vA=
X-Google-Smtp-Source: ABdhPJytuuGzNkFAGkfNW+NrG0pEKwzUoKzuL0I5v3LxlM/+NHfVgKhBSnFUM/gbnGkVN4wKcQJvqw==
X-Received: by 2002:a63:496:: with SMTP id 144mr272537pge.353.1628710432857;
        Wed, 11 Aug 2021 12:33:52 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id 23sm254477pgk.89.2021.08.11.12.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:33:52 -0700 (PDT)
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
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
Date:   Wed, 11 Aug 2021 12:33:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 22:49, Qu Wenruo wrote:
>
>
> On 2021/8/11 下午1:34, Konstantin Svist wrote:
>> On 8/10/21 22:24, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/11 下午1:22, Konstantin Svist wrote:
>>>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>>>
>>>>> Oh, that btrfs-map-logical is requiring unnecessary trees to
>>>>> continue.
>>>>>
>>>>> Can you re-compile btrfs-progs with the attached patch?
>>>>> Then the re-compiled btrfs-map-logical should work without problem.
>>>>
>>>>
>>>>
>>>> Awesome, that worked to map the sector & mount the partition.. but I
>>>> still can't access subvol_root, where the recent data is:
>>>
>>> Is subvol_root a subvolume?
>>>
>>> If so, you can try to mount the subvolume using subvolume id.
>>>
>>> But in that case, it would be not much different than using
>>> btrfs-restore with "-r" option.
>>
>>
>> Yes it is.
>>
>> # mount -oro,rescue=all,subvol=subvol_root /dev/sdb3 /mnt/
>> mount: /mnt: can't read superblock on /dev/sdb3.
>
> I mean using subvolid=<number>
>
> Using subvol= will still trigger the same path lookup code and get
> aborted by the IO error.
>
> To get the number, I guess the regular tools are not helpful.
>
> You may want to manually exam the root tree:
>
> # btrfs ins dump-tree -t root <device>
>
> Then look for the keys like (<number> ROOT_ITEM <0 or number>), and try
> passing the first number to "subvolid=" option. 

This works (and numbers seem to be the same as from dump-tree):
# mount -oro,rescue=all /dev/sdb3 /mnt/
# btrfs su li /mnt/
ID 257 gen 166932 top level 5 path subvol_root
ID 258 gen 56693 top level 5 path subvol_snapshots
ID 498 gen 56479 top level 258 path subvol_snapshots/29/snapshot
ID 499 gen 56642 top level 258 path subvol_snapshots/30/snapshot
ID 500 gen 56691 top level 258 path subvol_snapshots/31/snapshot

This also works (not what I want):
# mount -oro,rescue=all,subvol=subvol_snapshots /dev/sdb3 /mnt/


But this doesn't:

# mount -oro,rescue=all,subvolid=257 /dev/sdb3 /mnt/
mount: /mnt: can't read superblock on /dev/sdb3.

dmesg:
BTRFS error (device sdb3): bad tree block start, want 920748032 have 0


