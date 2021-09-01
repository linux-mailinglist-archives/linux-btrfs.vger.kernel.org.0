Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAD3FD0D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 03:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhIABji (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbhIABjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 21:39:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F818C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 18:38:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so3126070pje.0
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 18:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HQmScti7QNBPCK4gDOewjzW4WcJQ2nsBS9jeGZ6Q/10=;
        b=jh4au50XUNZoxBBqH21LtPZcqwVdEkfO0zJ4sx37QVtnJDph4zzOX+NQqsSDC2AXmO
         O7MdPXPSaOujylSjT/QtFqTsLe29o74rbeDgOSv0IYwtpFUGvvRhzgVl/+KoJaWDA+ff
         eKMwKBoEN/KFbtcrhz/b3tics/tVm1mbc4rLTe6Vc4bujG+habgzLWK42fGOjDpa5Sd9
         amV2vVZv6Ij+KaTY0/1R2CA4wX3w7t0SDX28UKFtnUgeMRSgIrzfBV8p+KDDGEn79bBS
         mUyRLRDiRq6UN4C3Nj96mFNr7wfwzWzDNUoYT7Fp1F5ByXqBQ3f//Jt/OLn0Gpv74tfb
         lywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HQmScti7QNBPCK4gDOewjzW4WcJQ2nsBS9jeGZ6Q/10=;
        b=H03HjCTfHBAzF9u4nG0xD8+geSjN6aU+jGLylEaqGig++dD2Kr59wk35AWqVJNxUmd
         kKU6Y6BcTaobF8fuiTYSVt6xR9aYWWg3XJWYY0kKlcJBh2CV2a5Nh0Lrxi5MGDA9Leo0
         KGmBTcFsJ1Mz9DPndigSqSrHxK+4ozXxC3C3K7z4TYXmmXkHE6ZRM29yMz7U/WLsrNFz
         jeB0DzDjQkHIfbi/XadkoQzO/vNDXXK6tmn4szB5tYh7KprGPJTnUK+UbIgGG/QBv1JX
         uFjDX6cKwz1iqJtGfApu0xd8yEbaIwh6V+cgBTRGUJz11yLnyhvTV9E8dKPTCTJYvWlp
         8irA==
X-Gm-Message-State: AOAM532U9uRChxn/Pqu23NDIWmxh7TcyMO+yfhYBmhp394vxEzrjsPt2
        g6blD6R+HDAjMs4OJ42cA0/+XfUM6/q9kA==
X-Google-Smtp-Source: ABdhPJyXOXhG98znuTf+7nGdMjkMXrEj6A9zwFDkqcvArkEn/COjcGE35noRh1S01T+XmAMdKeEXpQ==
X-Received: by 2002:a17:902:cec1:b0:138:e176:9676 with SMTP id d1-20020a170902cec100b00138e1769676mr7304406plg.65.1630460316824;
        Tue, 31 Aug 2021 18:38:36 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id r15sm15548533pfh.45.2021.08.31.18.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 18:38:36 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
 <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
 <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
 <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
 <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
 <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
 <74809aba-047e-ca7a-e5b4-d64287ddd81d@gmail.com>
 <3fbd1db5-97f7-8d8f-e217-3a7086eb74b0@gmx.com>
 <aa33b83f-b822-b1d8-9fe4-5cf4ab45c3e1@gmail.com>
 <64eb1b22-a9c0-e429-4407-cdfd6af4e031@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <dc35d674-1dd8-d67a-0e78-b38bf1a638ca@gmail.com>
Date:   Tue, 31 Aug 2021 18:38:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <64eb1b22-a9c0-e429-4407-cdfd6af4e031@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/31/21 04:05, Qu Wenruo wrote:
>
>
> On 2021/8/31 下午2:25, Konstantin Svist wrote:
>> On 8/30/21 00:20, Qu Wenruo wrote:
>>>
>>> On 2021/8/30 上午11:48, Konstantin Svist wrote:
>>>>
>>>> I'm hoping to find several important files at this point, definitely
>>>> don't need the whole FS..
>>>>
>>>> So when I run this, I get about 190 lines like
>>>>
>>>>       key (256 INODE_ITEM 0) block 920748032 gen 166878
>>>>       key (52607 DIR_ITEM 988524606) block 1078902784 gen 163454
>>>>       key (52607 DIR_INDEX 18179) block 189497344 gen 30
>>>>       key (174523 INODE_REF 52607) block 185942016 gen 30
>>>>       key (361729 EXTENT_DATA 0) block 785907712 gen 166931
>>>>       key (381042 XATTR_ITEM 3817753667) block 1027391488 gen 120910
>>>
>>> Can you provide the full output? (both stdout and stderr)
>>>
>>> If you're concerning about the filenames, "btrfs ins dump-tree" has
>>> --hide-names to mask all the file/dir names.
>>>
>>> 190 lines look too few than expected, thus means some tree blocks are
>>> not read out properly.
>>>
>>> You may want to try other bytenr to see which gives the most amount of
>>> output (thus most possible to restore some data).
>>
>> ## Naming these BTR1..4
>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root | sort -rk 4
>>          backup_tree_root:    787070976    gen: 166932    level: 1  
>> ### BTR1
>>          backup_tree_root:    786399232    gen: 166931    level: 1  
>> ### BTR2
>>          backup_tree_root:    781172736    gen: 166930    level: 1  
>> ### BTR3
>>          backup_tree_root:    778108928    gen: 166929    level: 1  
>> ### BTR4
>>
>> ### BTR1:
>> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
>> ROOT_ITEM" -A 5
>> ...
>>     item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>>          generation 166932 root_dirid 256 bytenr 786726912 level 2 refs
>> 1      ### naming this RI1
>>          lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags
>> 0x0(none)
>> ...
>>
>> BTR1 -> RI1 786726912
>> BTR2 -> RI2 781467648
>> BTR3 -> RI3 780828672
>> BTR4 -> RI3 102760448
>>
>> ### inpsecting RI2
>> # btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3
>>> RI2.inspect.stdout 2>RI2.inspect.stderr
>> <outputs attached>
>>
>> One of the lines of this output is
>>          key (2334458 DIR_ITEM 3564787518) block 196816535552 gen 56498
>>
>>>> I tried to pass these into restore, but it's not liking it:
>>>>
>>>> # btrfs restore -Divf 196816535552 /dev/sdb3 .
>>>
>>> Where the bytenr 196816535552 is from?
>>
>> ^^^ output from inspect RI2 -> DIR_ITEM. Probably wrong usage? :)
>
> OK, that seems to be out of the way btrfs-restore can handle.
>
>>
>>
>>>
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> Csum didn't match
>>>> WARNING: could not setup extent tree, skipping it
>>>
>>> This part is expected, it just tries to read extent tree which is
>>> manually corrupted.
>>>
>>>> This is a dry-run, no files are going to be restored
>>>> Done searching
>>>
>>> While this is not expected, as it doesn't even show any research
>>> attempts, is the bytenr from the subtree of the subvolume 257?
>>
>>
>> Interestingly, I tried --dfs instead of --bfs and there are a lot more
>> entries, including filenames
>>
>
> BTW, thanks to the output and stderr, it shows exactly what's going
> wrong.
>
> The offending tree block, 920748032, is the first one.
>
> If using --dfs, it will go through each child until reaches the leaves,
> before going to next tree block.
>
> And if the first child is corrupted, then it gives up immediately.
>
> That's why I'm explicitly specifying --bfs, which will skip the
> corrupted child (and its children) and go next tree blocks directly,
> thus have the best chance to recovery the contents.
>
> For the worst case, I guess you have to use "btrfs ins dump-tree" to
> recovery your files, and then "btrfs-map-logical" to grab the data from
> disk directly.
>
> Meanwhile I guess I should put some time to enhance btrfs-restore to
> handle the corruption you're hitting, so that we can continue to next
> good tree block, without being bothered by early corrupted tree blocks. 


Thanks again for looking into this!

Should I wait for a patch or is there something else I can do meanwhile?


