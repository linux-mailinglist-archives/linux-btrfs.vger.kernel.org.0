Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E43E9A99
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHKVym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhHKVyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 17:54:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5622C061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 14:54:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so2995171wmi.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=3TN4XJwbHo+kn+vW9P0En+4Topn4KNtuBDPHwew0i9A=;
        b=I+sFtpmMCDkD8sHtrx18eHOCGOF5ZL4eHSa7d+UqNL3Rzsqb4b3wgIGbs18ICjSMK0
         4aKuFIVNmFRN8akiqlVqmLbEcPUzlPJA1MMiVGPkMYKM/xXGAd9kGycisHVGiEs7lwIC
         qSuXPovLAPE5wg4Kk16PI4oF46sR1GCxh66/KxdUgv99QCM+y1vo7ZHRD6cht/d6ihYc
         CSDJakluCEiCHx09UGo453fusN6Mif7IcL4q8EoO8/kWPdepDjWnA8DA9mWFWaXEOjCF
         g8oI/PEqfZKjMdhRobBKw+LiGvp+tazsVI6+FSWLOkmoQTV7i3q89DVbDlxfBy110bQC
         eLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3TN4XJwbHo+kn+vW9P0En+4Topn4KNtuBDPHwew0i9A=;
        b=l8lcjR3PMKnIYaNyLn8uwt5sQnjbl48tiHnVfqMjYm/IjewzMrV60R8bidR2YNfAqM
         xMAyR6VcnR6hn2g8ud6BH1GJ+Y0zwg6RlaLGeb8epVXszIz4ezEXgLVZntZ7QZpyYxTH
         lJVp39Ucjn9eU0GIve8py4m8kmRdb+0OL1+4TEcdhn9MQiJxml8E1grRIW336oV4Wywb
         tadQpJ8ZNzH4D8AdENDjqEMyPCJa41FaesLxcoO7l/ZMMsG6IWVK//jbtkyOJEIqwllA
         /X0tXJ2S8SN7P8aWUgcuVOnQ1qcWmPFh2kEdJoVQuO4lRNqDl2bxDdHK+cUGdeysQuEg
         qSUQ==
X-Gm-Message-State: AOAM53079kp/ZP57o9WgzPTy9x0IMtBm+hL3c643Z1e+1tYyw9jQWoQh
        IL9ASPapb3h5o+atFTdikt13vnWWDYQDUg==
X-Google-Smtp-Source: ABdhPJylX/AwTOMHztxVg/2tuPYCPakglflAUvHDIEq5rjKMMcvgj0vsY5VH4RWGOg/lP6P8r89fxQ==
X-Received: by 2002:a05:600c:1c09:: with SMTP id j9mr11906248wms.183.1628718855463;
        Wed, 11 Aug 2021 14:54:15 -0700 (PDT)
Received: from [192.168.0.89] ([88.162.188.213])
        by smtp.gmail.com with ESMTPSA id l41sm5841361wms.2.2021.08.11.14.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 14:54:14 -0700 (PDT)
Subject: Re: Files/Folders invisibles with 'ls -a' but can 'cd' to folder
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <94bf3fad-fd41-ecc0-404c-ccd087fca05d@gmail.com>
 <c11aea64-0f94-7cb1-886e-f6bc5050d7f2@gmx.com>
From:   k g <klimaax@gmail.com>
Message-ID: <1bbcdbaf-ecf3-a116-f26e-a2edcc36e536@gmail.com>
Date:   Wed, 11 Aug 2021 23:54:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c11aea64-0f94-7cb1-886e-f6bc5050d7f2@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu ,


Thanks for your valuable answers, 


The synology system I'm using has btrfs tools v4. I compiled a v5
version because "btrfs check" version 4 returns "Couldn't open file system"


a little bit late, (I'm 1000 km away from my crashed server, I'm doing
all of this remotly) ,Here is some output of btrfs check I made today
(output is very long , here is some samples of the messages returned)


Opening filesystem to check...
Checking filesystem on /dev/md2
UUID: 306faa08-9e17-406b-924e-57e06e2c2763
[1/7] checking root items                      (0:03:47 elapsed, 4389038
items checked)
[2/7] checking extents                         (0:06:51 elapsed, 3092
items checked)
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space cache                (0:00:00 elapsed)
[4/7] checking fs roots                        (0:00:00 elapsed, 2 items
checked)
found 196033421312 bytes used, error(s) found
total csum bytes: 15533120
total tree bytes: 50102272
total fs tree bytes: 17711104
total extent tree bytes: 31784960
btree space waste bytes: 10681343
file data blocks allocated: 0
 referenced 0


ERROR: child eb corrupted: parent bytenr=229829935104 item=4 parent
level=2 child bytenr=229931827200 child level=0
ERROR: extent[193738493952, 16384] referencer count mismatch (root: 257,
owner: 226748, offset: 0) wanted: 1, have: 0
parent transid verify failed on 229931827200 wanted 11406678 found 11406670
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=229829935104 item=4 parent
level=2 child bytenr=229931827200 child level=0
ERROR: extent[193738510336, 16384] referencer count mismatch (root: 257,
owner: 226749, offset: 0) wanted: 1, have: 0

ERROR: extent [197244026880 16384] referencer bytenr mismatch, wanted:
197244026880, have: 229859393536
ERROR: extent [197244043264 16384] referencer bytenr mismatch, wanted:
197244043264, have: 229859393536

parent transid verify failed on 229931827200 wanted 11406678 found 11406670
Ignoring transid failure


WARNING: tree block [197151997952, 197152014336) crosses 64K page
boudnary, may cause problem for 64K page system
WARNING: tree block [197152063488, 197152079872) crosses 64K page
boudnary, may cause problem for 64K page system

Wrong key of child node/leaf, wanted: (197244633088, 169, 0), have:
(40699577, 108, 0)
Wrong generation of child node/leaf, wanted: 11406682, have: 11406670
parent transid verify failed on 229934661632 wanted 11406672 found 11406677
Ignoring transid failure

ERROR: block group[9778059280384 10737418240] used 0 but extent items
used 10735706112
ERROR: block group[9788796698624 10737418240] used 0 but extent items
used 10736922624

leaf parent key incorrect 229908168704
parent transid verify failed on 229908168704 wanted 11406668 found 11406678
Ignoring transid failure


ERROR: free space cache inode 41584067 has invalid mode: has 0100644
expect 0100600
parent transid verify failed on 229926993920 wanted 11406669 found 11406676
Ignoring transid failure
parent transid verify failed on 229958598656 wanted 11406672 found 11406678
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=229823332352 item=5 parent
level=1 child bytenr=229958598656 child level=1
ERROR: errors found in fs roots
extent buffer leak: start 229934661632 len 16384
extent buffer leak: start 229823561728 len 16384
extent buffer leak: start 229931532288 len 16384
extent buffer leak: start 229931827200 len 16384

 

By "luck" I have a sql dump that contain 80% of the paths of the lost
files, so I can make a bash or python script to recover them (by doing a
copy elsewhere or mv two times the hidden folders)

unfortunately, these path are samba paths and some of them are mangled
(I did not manage, or had the time to reverse engineer the samba source
code to rebuild linux paths from samba mangled path despite that I asked
some help in stackoverflow...)

But before starting building these scripts , I want to have  your
feedback before launching any maintenance operation, or at best a
procedure to relink these DIR_INDEX


all the best.

.k.



On 05/08/2021 00:55, Qu Wenruo wrote:
>
>
> On 2021/8/4 下午9:19, k g wrote:
>> Hi
>>
>>
>> As I say in my subject, I'm facing a weird problem with my btrfs
>> partition (I already sent this message on reddit /r/btrfs/ )
>
> Sorry, reddit is not really the go-to place for technical discussion nor
> bug report.
>
>>
>> It's in fact a btrfs partition in a raid5 synology system.
>
> We don't know how heavily backported the synology kernel is, thus it's
> normally better to ask for help from synology.
>
>>
>>
>>
>> 3 days ago, the volume 'crashed' (synology terms) ,however SMART data is
>> ok and I don't have sector relcocation errors or CRC.... I rebooted
>> several times , and after dozen of reboots my partition shows up , but 3
>> TB of 10 TB are missing, I made a scrub but it did made my missing files
>> appears.
>>
>>
>>
>> desperately I made a 'cd xyz' in a directory (I remember some of the
>> folder names) and it works ; and inside this folder I can do "ls" and
>> all files and subfolders appears .
>>
>> I made a copy elsewhere of some files and these ones are not corrupted
>> or bit roted.
>>
>>
>>
>> I don't want to make a btrfs check --repair of course.
>
> But "btrfs check" without --repair should be the best tool to show
> what's going wrong.
>
> Alternatively, "btrfs check --mode=lowmem" could provide a better human
> readable output.
>
>>
>>
>>
>> Is there a way to "relink" indexes/root or whatever it is called to
>> bring back these files/folder visible and accessible with a safe
>> command ?
>
> It's not that simple, from your description, it looks like the dir has
> some DIR_ITEM but no DIR_INDEX, thus it doesn't shows up in ls, but cd
> still work.
>
> This normally indicates much bigger problem.
>
> Thanks,
> Qu
>>
>> I'm planning to backup all , is 'btrfs restore' will access to these
>> "non visible" directories ?
>>
>>
>>
>> "I saw similar case here : The Directory Who Wasn't There : btrfs
>> (reddit.com) , but I can't find a reply that solve the problem"
>>
>>
>>
>> cdly
>>
