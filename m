Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7CD2A4E41
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKCSTg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 3 Nov 2020 13:19:36 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgKCSTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 13:19:36 -0500
Received: from [192.168.177.174] ([91.63.191.240]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N7AAk-1kHFcc1iou-017Sve; Tue, 03 Nov 2020 19:19:30 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[3]: parent transid verify failed: Fixed but re-appearing
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Tue, 03 Nov 2020 18:19:41 +0000
Message-Id: <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
In-Reply-To: <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
 <20201021213854.GG21815@hungrycats.org>
 <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.0.3385.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:PURi95mYqRqJGs4/qj0KVaF5QIwVJ1FJcaCmtnElQ05OLC6hnvw
 qeav8L/H2pSRMjorF4hXjNE8PkStsTc1FA6Mwvst2Lu9r/WwQIjTD8EajGj8oa9BmyqOPMr
 97QprZnSO3+FkRkEJhCUVB/OQIM435nFoRS4BI0BjGSSBWzZXDgbozYktavR8h0cjGr/HXp
 L4mtM+rhpmBctQOOlOckw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EsqsLODb+Xo=:HBVZj2iCSX85Lj1eZtIuNc
 dQZeUdAASb3Wt7Wrx+ed6WuX7cK1dDRGdUHWuhOdWswgLotdT5yTcRc8OP9LR8x9OYR3jV3/z
 vQo2Z9LYovrAj/68h06Mc78zYAZ6pILblDxoPk5qY32v72Rrgf/K6yQBZ/xh7ok8FhuQGGhuS
 fZEEJhQNbby689R+J4iIn++KuzCf2F1kXErN5D2KLVWRXnKORWovcmThCASVulkZj2mmnnpf9
 WQ75+dp505I9BkhNT3L6M3BmQKz61Ud9bcDQwyXVfFPgtdRnm1sv9qOEbMu5yyHV/AtnR8k7L
 JCQXU80Z2K1zGAiU1oDIQ7aQsFI+OT/VnrUfL1abvqOsVh0VffSricHJYtbI/lyqSBmFp12GK
 tjJ0U/UJqgVYHgoT6Gj7VmRpWEmLxD/jhib0scOCs8UiXyj9829LyNK2+EX80vpr0gtYzZqZK
 LiV4BTVNUQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Zygo,

can you further me help on this?

Regards,
Hendrik

------ Originalnachricht ------
Von: "Hendrik Friedel" <hendrik@friedels.name>
An: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Gesendet: 22.10.2020 21:30:14
Betreff: Re[2]: parent transid verify failed: Fixed but re-appearing

>Hello Zygo,
>
>thanks for your reply.
>
>>>  [/dev/sda1].generation_errs  1
>>>  [/dev/sdj1].generation_errs  0
>>>  >
>>>  So, on one of the drives only.
>>
>>If one drive is silently dropping writes then it would explain the
>>behavior so far; however, it's relatively rare to have a drive fail
>>that specifically and quietly (and only when you use one particular
>>application).
>Well, we do not know that it occurs when I use one particular application. It could also occur a before and just become visible when using dduper.
>
>>>  > scrub already reports pretty much everything it finds.  'btrfs scrub
>>>  > start -Bd' will present a per-disk error count at the end.
>>>  >
>>>
>>>  So, should I do that now/next?
>>
>>Sure, more scrubs are better.  They are supposed to be run regularly
>>to detect drives going bad.
>btrfs scrub start -Bd /dev/sda1
>
>
>scrub device /dev/sda1 (id 1) done
>         scrub started at Wed Oct 21 23:38:36 2020 and finished after 13:45:29
>         total bytes scrubbed: 6.56TiB with 0 errors
>
>But then again:
>dduper --device /dev/sda1 --dir /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
>parent transid verify failed on 16500741947392 wanted 358407 found 358409
>Ignoring transid failure
>
>
>>>  Anything else, I can do?
>>
>>It looks like sda1 might be bad and it is working by replacing lost
>>data from the mirror on sdj.  But this replacement should be happening
>>automatically on read (and definitely on scrub), so you shouldn't ever
>>see the same error twice, but it seems that you do.
>
>Well, it is not the same error twice.
>Both the first ("on") value as well as the following two values change each time.
>What's consistent is, that the wanted vs found always differ by two.
>Here some samples:
>parent transid verify failed on 9332119748608 wanted 204976 found 204978
>parent transid verify failed on 9332147879936 wanted 204979 found 204981
>parent transid verify failed on 16465691033600 wanted 352083 found 352085
>parent transid verify failed on 16500741947392 wanted 358407 found 358409
>
>>That makes it sound more like you've found a kernel bug.
>
>And what do we do in order to narrow it down?
>
>Regards,
>Hendrik
>
>>

