Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCDF5E8906
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiIXHWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiIXHWO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 03:22:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1316FD4303
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664004127;
        bh=L98H3d5kW0lrE0o2r32UHNjeeqE8jmgSZ7AZL/UV7Qk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=IRxxlY+SaCRi4UUk9xuKX02U9RIDSKweRFDc1eJ2W93hqSksPSfIYGXtcgcwzoTer
         K59Gbp+p1Yd4Dk5I3xfXG41acdPL4adWZ1HMkS62+4pp+Z93Sq/GkQQc18kYBBepoR
         98Gux7X8Yqi9KWoAYOMBEwOnoD1GE32cfeRy6V40=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1pOXnz0m4v-014T8r; Sat, 24
 Sep 2022 09:22:06 +0200
Message-ID: <7a51b28e-d8b9-443b-74ea-457bbfaf1f8f@gmx.com>
Date:   Sat, 24 Sep 2022 15:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220924120727.C245.409509F4@e16-tech.com>
 <a80263f7-9ff7-4f1b-d863-8d092cbb9a7a@gmx.com>
 <20220924144106.E3BE.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: fstests btrfs/042 triggle 'qgroup reserved space leaked'
In-Reply-To: <20220924144106.E3BE.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BpH5RbemyYBn7prZzMb/aE6KXFqq6dKzQmpe0SGUYXK+5vq4U79
 Mbu1jusRpxci6rbKbhKMVYUuT8BBJpeUXh3eFsxt4hqUJhCDq4nglukIVcYjf3JmSjdczB4
 fWtdV+hBVBcnAOkGBCJQ/iGU6eML8oBabbGPmek5wAyur1+GPmW+gQ5IrObX+HFneYci+5p
 8ZgLn/yCApfPfKPv6KHEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+i1UrYgIKws=:ptkqWnbhn5aTAoC2VzdmnM
 m6vcC+ORjroOoQKoqb1Fjdj5CtKNtOgLdQMWKrfFHrY+R91ncREpB3L1kjWnvnC1PBUue2pqJ
 Qtp6uw/fffIBs89K4LYlCeXF4ivF+5o4DXuFUWYICb7su2YOQV9ng43TFELVJjUeZtgEMYJcF
 CRyYd4MaOGdADnhT6A8ic60G1bQFWyuQ5Thber2QNChg4ZAKTRJslLpeWtimc50Ly/h3CKbFp
 lib5RDqY92Iqmi6W7dfzk/GKAhhcKJE429K5BRjX6vQsleR45UPUu4o7LDoHychrQITf9tpqD
 EXGBl+fsYxCu6dkrzS/oSU/70cUAsWTtuOKWuGqmwe2pcZ/vKA8PffN+REelZMmL6WTu/BDvb
 HJKvH2I7P1sS5ClG5DuEkxHU9AOLzn9rM6Hg/xGLCh5BrY2JWBdV0MxNPBUc8qOFAKfuk28t4
 itjnIl+NO7UwVD/HsNMyC+YVjcVx9Slm4ArtT2sr4ky9XHmFvdQzaQWdT+TTGfdxwXZmQSjeE
 HGN1E9vvrJAPkDIwsk9YkdICo3g+7JQ1QiDsRfrRYmeJ14PezW6T8jML/cNfNBzJSok9kTlr4
 WhLh+tkDn6Gna7GgoDqOpLIk86AmRX7N3o2r+SLDRFE0AtxCNLZAF85u9HXlNt9O1F2zgP2b4
 Xi3CCQS6pHbsTZKhwTNwh1qPP0ZY8MSaltSH6Elas5l8ayxI2BIW91BQtvx5LM8qKi8Mpvvku
 D4PMmr+XtRG2WuEC7I3i3QNG4uJcWCtIvkA/6ZdAilAOaszDWWtI/6Wr9huBKyQTL2l/wuTLa
 I/YkQD4u/dGM6NxRTr3BzMh/aNaJMOPo9kiYAEAdEZVgeNsAAd3a8tvqaJcASF2if5mViro06
 mEKAao8nAXRTKdzWOOaa5HO/q3EIPnW3UuV25ifesxaP43jV6b40pvD8k6dyTw6cGO+LYH61D
 cyvBNWgRVZA5VloCTNUKDO/vqUbOZM9iKmQsGyHp0Ix837XoSaSP2tUM4I5u+OirWgqHa1vBH
 aRMa3K9QCpHoczCeRXk/XA9fZrq6mJZJHyYR6vnKYj3fi7sZTZFkLSCKbiTRsHXNm0xOX9Yyb
 SD65CLH2JGQUJwM0ngPuO9yV4AYcleGKZ4iMVFvFbD9Qevu3Ahd53+bgzxXtO1SqFPVqyUovX
 MVX3DCI7m2w8gzDg78cuJ2j8vx
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/24 14:41, Wang Yugui wrote:
[...]
>>
>> I don't think the config makes much difference, as the main difference
>> is in KASAN and KMEMLEAK, which should not impact the test result.
>>
>> And are you running just that test, or with the full auto group?
>
> For 6.0-rc6 with btrfs misc-next, I tried to run  full auto group.
> btrfs/042 failed, others(btrfs/001 ~ btrfs/157) are OK, and then I
> rebooted the test machine.
>
> for 6.0-rc6 without btrfs misc-next, I tested btrfs/042 and btrfs/001 on
> the same machine.
> then I tested 6.0-rc6 without btrfs misc-next on another 2 servers.
>
> reproduce rate:
> server1	3/3
> server2	2/3
> server3	3/3
> total rate: 8/9
>
> all 3 servers are in good status(ECC memory status and SSD status).

Considering no one can reproduce your failure so far, I strongly doubt
if it's something else.

Please provide the following info:

- Full dmesg since bootup.
   Better to reboot, then run btrfs/042, and take the dmesg.

- local.config file of xfstests

- result/btrfs/042* files of xfstests
   Only need to run that exact test case, since you have a very high
   chance to reproduce.

- the full output of "./check btrfs/042"


>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/24
>
>
