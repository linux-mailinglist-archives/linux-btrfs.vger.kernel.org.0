Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897333FA3E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Aug 2021 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhH1F6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhH1F6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 01:58:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B538C0613D9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 22:57:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so6532395pjq.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EZwCTN4y/ZRqJGRcM+O5EsefXbgeft4FedkwIbIRb/Y=;
        b=b7Pvt4mZ2TVHlL+x3zeQsZOLe/LZLyz8Mpb4IjnoGriGdWotzqROfts9IBlEfVHwLv
         Um8ZhzelKGJ0HznMNxs6q3Ir2Iq9NsBFwJUI+Vpiku28fpYwvx5jWgKSlJUGd8W0JXwF
         Ri1/hzHdnZ2OrTXHtrgrAHfn6Zk8v7Eb4BoEFJ0OscqodkdZy46u270fHLst6qQ/U34c
         9J9H6dMErKFctbSygCayQS8nPtogVcD9KzXtDEdMXOmjE5WWHgexFfoNbztwpxQRDRYQ
         pkwQwsf0MQNVD4Q2DJhX4Solrt6xoaAURCP1rCViFv/8Wm9k4e2v3PRv77r3//YMHPeH
         bwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EZwCTN4y/ZRqJGRcM+O5EsefXbgeft4FedkwIbIRb/Y=;
        b=FSI1E8XPB7s2Q9THnL7Iv7E1D4j/CCEGZYm8rdq9eyrOpmoNlEf730aRHwjrvQMPd6
         2PgPDskLAE2JoU2xNkpZqUWu0iEOCb1VcpJG6inEcACDOUKzK+6+3VphXr60R4nAWhFt
         dcw/XVR1ZQ5hoEQF7lGEHvjwK2PIs6zwQZKT16UbbgAhMFNH71g9752GQnWEStSyPbLG
         5aNgXkktEIac0fDBq/2nP8A1fGlcVB5iiZS4UTfyVg+tLYIfRbMSLTjEtz3T0Zg/Q0w4
         KhEzGrBhOHsAJiCcA2Uf2xd/Q7nCAycgOQI4D02t8qC4Dcb8SMY29Hqs7sveOtYgGgiE
         kxkg==
X-Gm-Message-State: AOAM531oMrt17dxB1L2QHbOnde4iAcaKZ9IJ9o0FQ2ib5uXi1m17gvAY
        nOeUQWaJ8PWtbyfj0UlcswpfdcEKW+YUxg==
X-Google-Smtp-Source: ABdhPJzPm1+ZND0VopYdPjQesF78+JB+5ExsvooO/kbIqNFTCB+I5w7WU2vG2u+GoaSqcaZ+sI+BPA==
X-Received: by 2002:a17:902:bd98:b029:12c:9106:b54f with SMTP id q24-20020a170902bd98b029012c9106b54fmr12142681pls.40.1630130275249;
        Fri, 27 Aug 2021 22:57:55 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id i11sm8833118pgo.25.2021.08.27.22.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 22:57:53 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
From:   Konstantin Svist <fry.kun@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
Message-ID: <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
Date:   Fri, 27 Aug 2021 22:57:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/20/21 19:56, Konstantin Svist wrote:
> On 8/11/21 18:18, Qu Wenruo wrote:
>>
>> On 2021/8/12 上午6:34, Konstantin Svist wrote:
>>> Shouldn't there be an earlier generation of this subvolume's tree block
>>> somewhere on the disk? Would all of them have gotten overwritten
>>> already?
>> Then it will be more complex and I can't ensure any good result.
>
> It was already pretty complex and results were never guaranteed :)
>
>
>> Firstly you need to find an older root tree:
>>
>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>                 backup_tree_root:       30687232        gen: 2317
>>  level: 0
>>                 backup_tree_root:       30834688        gen: 2318
>>  level: 0
>>                 backup_tree_root:       30408704        gen: 2319
>>  level: 0
>>                 backup_tree_root:       31031296        gen: 2316
>>  level: 0
>>
>> Then try the bytenr in their reverse generation order in btrfs ins
>> dump-tree:
>> (The latest one should be the current root, thus you can skip it)
>>
>> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM" -A 5
>>
>> Then grab the bytenr of the subvolume 257, then pass the bytenr to
>> btrfs-restore:
>>
>> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>>
>> The chance is already pretty low, good luck.
>>
>> Thanks,
>> Qu 
>
>
> When I run dump-tree, I get this:
>
> # btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM" -A 5
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
> Csum didn't match
> WARNING: could not setup extent tree, skipping it
>
> The same exact offset fails checksum for all 4 backup roots, any way
> around this?


*ping*

Any hope left here?

