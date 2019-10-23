Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40992E1915
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 13:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404693AbfJWLbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 07:31:24 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:44817 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404669AbfJWLbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 07:31:24 -0400
Received: by mail-io1-f41.google.com with SMTP id w12so24442981iol.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HIoNtk/Bq/4bhV8hhYt0o149RJW/w10qAN6MutipuU8=;
        b=ETmY5BDb+24qyozum1hOwfaeP9ABNZ2UErY6Dh5D9rln1qk44KbjNI31iJ3P+DHPZs
         930Z9kStoaikv1+eB0l6vvc9AIRsbjkSlo872PuTVyrOOrDQnyBIBCcNQY3K/r69fH40
         a5dA3CGBZXqGa8ab9X3sXwUQw06Yr4SnScdP7Lx8sTMcg+dGmQNz+aeHTPvpG7+Wf76C
         2kkIrZC5TeVDZpvJT6YJemtPwQVzTv9coxztk0cez79cazS0Nb86yy6F/JbDSpBMPq+S
         JdtCgHOzQm9ngFMz1kYwAqw1PHfccHGTfOwsoSMDClBo9xhI5nWpUGDmmVzox/eLTflN
         2fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HIoNtk/Bq/4bhV8hhYt0o149RJW/w10qAN6MutipuU8=;
        b=HbBYtYKbR8g3a1O3L9Md0eNkVSm7KonbjxSDaSm4C4fdrsV/k9xqyVlxEmORX9BfM7
         97yK0Hr9INeYIsfSqBYZgTHHXcloo2OUj5ky0o/EGf2IAFEBIb959mXq8ZPesAuuuWU0
         vUaavs0aqySbNFIctMvV/qAlTr6gYBxumNq5wrN3p2yBiT8dGjPM7aknKGl0ckI7awXJ
         C/dy02VHQJHtXkmSon33TM5CAoK9ObJIqe6LiHZtiFgizaOtBBDq20Li9iEmFhoLi24Z
         bFVYKHbr3uyQPLYZ06dVKtpg6YHnPCa3ZEJgOoD4BVc97ATe/Sdd1s7iBAAqieTmuDn7
         2syA==
X-Gm-Message-State: APjAAAXnYt3u9Y6cUfjUlSWtMPEQVE87Io3ANVTFm6cJgBFZj3lfYVuJ
        pJq5V2MXtL4y81HcevjOg2VVpLyOHhg=
X-Google-Smtp-Source: APXvYqxofuhg5Wz0dxoXWFBZZF/ko+fERgDkTss2mPP6UY38xNWmSwpPKb4xYNreJEp7ZQ7uKAYPMg==
X-Received: by 2002:a5d:8948:: with SMTP id b8mr2713190iot.200.1571830283136;
        Wed, 23 Oct 2019 04:31:23 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id w75sm4442188ill.78.2019.10.23.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 04:31:22 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
Date:   Wed, 23 Oct 2019 07:31:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-22 18:56, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
> 
> Am Mo., 21. Okt. 2019 um 15:34 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>> [...] just fstrim wiped some old tree blocks. But maybe it's some unfortunate race, that fstrim trimmed some tree blocks still in use.
> 
> Forgive me for asking, but assuming that's what happened, why are the
> backup blocks "not in use" from fstrim's perspective in the first
> place? I'd consider backup (meta)data to be valuable payload data,
> something to be stored extra carefully. No use making them if they're
> no goo when you need them, after all. In other words, does fstrim by
> default trim btrfs metadata (in which case fstrim's broken) or does
> btrfs in effect store backup data in "unused" space (in which case
> btrfs is broken)?
Because they aren't in use unless you've mounted the volume using them. 
BTRFS doesn't go out of it's way to get rid of them, but it really isn't 
using them either once the active tree is fully committed.

Note, however, that you're not guaranteed to have working backup 
metadata trees even if you aren't using TRIM, because BTRFS _will_ 
overwrite them eventually, and that might happen as soon as BTRFS starts 
preparing the next commit.

There has been some discussion about how to deal with this sanely, but 
AFAIK, it hasn't produced any patches yet.
> 
>> [...] One good compromise is, only trim unallocated space.
> 
> It had never occurred to me that anything would purposely try to trim
> allocated space ...
I believe Qu is referring specifically to space not allocated at the 
chunk level, not at the block level.  Nothing should be discarding space 
that's allocated at the block level right now, but the current 
implementation will discard space within chunks that is not allocated at 
the block level, which may include old metadata trees.
> 
>> As your corruption is only in extent tree. With my patchset, you should be able to mount it, so it's not that screwed up.
> 
> To be clear, we're talking data recovery, not (progress towards) fs
> repair, even if I manage to boot your rescue patchset?
> 
> A few more random observations from playing with the drive image:
> $ btrfs check --init-extent-tree patient
> Opening filesystem to check...
> Checking filesystem on patient
> UUID: c2bd83d6-2261-47bb-8d18-5aba949651d7
> repair mode will force to clear out log tree, are you sure? [y/N]: y
> ERROR: Corrupted fs, no valid METADATA block group found
> ERROR: failed to zero log tree: -117
> ERROR: attempt to start transaction over already running one
> # rollback
> 
> $ btrfs rescue zero-log patient
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> bad tree block 284041084928, bytenr mismatch, want=284041084928, have=0
> ERROR: could not open ctree
> # rollback
> 
> # hm, super 0 has log_root 284056535040, super 1 and 2 have log_root 0 ...
> $ btrfs check -s1 --init-extent-tree patient
> [...]
> ERROR: errors found in fs roots
> No device size related problem found
> cache and super generation don't match, space cache will be invalidated
> found 431478808576 bytes used, error(s) found
> total csum bytes: 417926772
> total tree bytes: 2203549696
> total fs tree bytes: 1754415104
> total extent tree bytes: 49152
> btree space waste bytes: 382829965
> file data blocks allocated: 1591388033024
>   referenced 539237134336
> 
> That ran a good while, generating a couple of hundred MB of output
> (available on request, of course). In any case, it didn't help.
> 
> $ ~/local/bin/btrfs check -s1 --repair patient
> using SB copy 1, bytenr 67108864
> enabling repair mode
> Opening filesystem to check...
> checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
> checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
> Csum didn't match
> ERROR: cannot open file system
> 
> I don't suppose the roots found by btrfs-find-root and/or subvolumes
> identified by btrfs restore -l would be any help? It's not like the
> real fs root contained anything, just @ [/], @home [/home], and the
> Timeshift subvolumes. If btrfs restore -D is to be believed, the
> casualties under @home, for example, are inconsequential, caches and
> the like, stuff that was likely open for writing at the time.
> 
> I don't know, it just seems strange that with all the (meta)data
> that's obviously still there, it shouldn't be possible to restore the
> fs to some sort of consistent state.
Not all metadata is created equally...

Losing the extent tree shouldn't break things this bad in most cases, 
but there are certain parts of the metadata that if lost mean you've got 
a dead FS with no way to rebuild (the chunk tree for example).
