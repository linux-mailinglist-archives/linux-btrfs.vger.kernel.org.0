Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A35E8862
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiIXEoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 00:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIXEoV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 00:44:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC7153A62
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663994653;
        bh=dlG2/SkH3VZf0fK71KLTGWOzMOOCxnwJvcV9IbCKUeM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kABc9H+dL7ZanfRpSet43seH9A96KxIoLqYh4EwSGirRrQujHRHDQaoG+zRXmTFxV
         rWlVOwYBIIPdr27LZaaNS1mpi/W/cg7TBUm2Ynf1Q34fw1zTHAoSZEeoZYM4Yth1mS
         YQTZ5+I9ewYGTHest7KjBsm5xXgX7+qQ1ODb89es=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1p1h8Q2gKo-00ihVz; Sat, 24
 Sep 2022 06:44:13 +0200
Message-ID: <a80263f7-9ff7-4f1b-d863-8d092cbb9a7a@gmx.com>
Date:   Sat, 24 Sep 2022 12:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: fstests btrfs/042 triggle 'qgroup reserved space leaked'
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220924101103.5AEA.409509F4@e16-tech.com>
 <a29f7dbe-1b48-d826-2867-d2da66b55986@suse.com>
 <20220924120727.C245.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220924120727.C245.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MtMK/CLnvlcAHPvEBq53jX3urvfchIPqxTOaYiapIt0QTdFevOb
 Zok+z0CQtXH0jIikR8vXAQZ1f5FBsv3ia+u9gE3+ohMXCLrvutSZcT/BQE/h/YbrnPw5upe
 rHXb1kQBh2Ju7ZooWLoPIQmiGKP3huMvUTh1X6dTaL6tC8aWlRHtGfjbZElpHqYTgbs9iBh
 y6Z/oJALStmi/YBJ/BBGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXZQRQT5sds=:IwWxE+TjIiQgRB5QxG6A66
 tYnIh1uRMrFLZDsdK0LHSpYP+Nn6UIRgRvzbvVsOAJuporQroywb4s9HC5tG1UyDzaYV8KCfw
 hFBmew8rhXZFowrVbyls2oEzXFx0GeT6Lyl1fPuv5+KyOV4nrz60RiWgdPqyr1pYm/h0jUAi5
 /8WAu6/6sz4Sn7g3MLRMOtNqwch4bYiRqqgXHIuJax3KpTY/0bhbE8eQO/PeLwLV81SJhQLh/
 lpYzg1+f0NWW3Lhf84u1nlzkUOiBmdf8U/GV5A7mDk5iEHEGbp0tIeJyeXhRozDFp6LUyiS1C
 YKRC7nIljHzXpbDlXjbz2oyaQxN8IKxOIn6oRjqAVKziNW027GuBJdOKUcwpc6lqGFLAnX+Qu
 6kyXBFAcHwqqjSsGgWxNfGBflLkKlEnbFjFjQTVRW2Y3CFa6MdzsnaXMloZ5wCZqJ9l/LvvnI
 mQuobGnqbDGFr5K2B5tflEMOw3fuJ2YwEz1PBL7qoZ5ZwK2VlD3oBlazchPEhllLLWL3rNI+v
 ZWMM+I6jbA3nseBMTSkurWEigXEZRJkfN4OAhsmZrXawmXxC+ObMY6eP8AOalw3KX9465XJPv
 Fc9uUMcwmYvXo4ecXF205+M085DawuzkgZeHk+WN5y4G4+NSO//QRnrIlJ7FsS37bNuzVNFrr
 rMpB7hSDHNMB1DbRK/F8oJnaBLbUnYS+G0ZzOG2kKfh6aT9ha0RBoAA+d840V8ISwY3MX7mdE
 IV2RcSKaqltDq81QdjiJhS8bERq3bkmX2fwLuZ23g8GHwd8L8W0ExMAU+qcb5OlFANAHotEmH
 9dVXhoGalpB4s4CWNkWouUdIU+KO7efnhyxhYVyKcqqjZUmjyPlMoXQ7EnKMlxxJEFdVWHoT2
 GS+CbOprIvlsGIFKnownbI+qNHZKnky/0B4E2m41N8ArH66Gf4curFNSE7bJhBqYp37nqC01v
 oaW33oQytBOHR/mkEsd6Ig3P/db6g/IRZo4hPx4/P9Z9CWRPBcW/mOTZRVSs9pFzqAsLyR8tr
 vRoI6BNIBu+VMjwoLJ7x8DRgxu3bWHb++wVPxgHgz8ME1BhiZx9/a0rPiOOnjJkL6H/mINbJ6
 727Cvg0tYO9g1ra3FPbuErFuTEQaUdRP7CfV3wpHU1/FProMLLtInnr/k+mnFOtB83eDf+HVL
 Jt6l1cE2i/zMRlanpQADJIoC4M
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/24 12:07, Wang Yugui wrote:
> Hi,
>
>> On 2022/9/24 10:11, Wang Yugui wrote:
>>> Hi,
>>>
>>>>
>>>> On 2022/9/24 07:43, Wang Yugui wrote:
>>>>> Hi,
>>>>>
>>>>> fstests btrfs/042 triggle 'qgroup reserved space leaked'
>>>>>
>>>>> kernel source: btrfs misc-next
>>>>
>>>> Which commit HEAD?
>>>>
>>>> As I can not reproduce using a somewhat older misc-next.
>>>>
>>>> The HEAD I'm on is 2d1aef6504bf8bdd7b6ca9fa4c0c5ab32f4da2a8 ("btrfs: =
stop tracking failed reads in the I/O tree").
>>>>
>>>> If it's a regression it can be much easier to pin down.
>>>>
>>>>> kernel config:
>>>>> 	memory debug: CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
>>>>> 	lock debug: CONFIG_PROVE_LOCKING/...
>>>>
>>>> And any reproducibility? 16 runs no reproduce.
>>>
>>> btrfs source version: misc-next: bf940dd88f48,
>>> 	plus some minor local patch(no qgroup related)
>>> kernel: 6.0-rc6
>>>
>>> reproduce rate:
>>> 1) 100%(3/3) when local debug config **1
>>> 2)  0% (0/3) when local release config
>>>
>>> **1:local debug config, about 100x slow than release config
>>> a) memory debug
>>> 	CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
>>> b) lockdep debug
>>> 	CONFIG_PROVE_LOCKING/...
>>> c) btrfs debug
>>> CONFIG_BTRFS_FS_CHECK_INTEGRITY=3Dy
>>> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy
>>> CONFIG_BTRFS_DEBUG=3Dy
>>> CONFIG_BTRFS_ASSERT=3Dy
>>> CONFIG_BTRFS_FS_REF_VERIFY=3Dy
>>
>> I always run with all btrfs features enabled.
>>
>> So is the lockdep.
>>
>> KASAN is known to be slow, thus that is only enabled when there is susp=
ision on memory corruption caused by some wild pointer.
>>
>>>
>>>
>>>   From source:
>>> fs/btrfs/disk-io.c:4668
>>>       if (btrfs_check_quota_leak(fs_info)) {
>>> L4668        WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>>           btrfs_err(fs_info, "qgroup reserved space leaked");
>>>       }
>>>
>>> This problem will triggle fstests btrfs/042 to failure only when
>>> CONFIG_BTRFS_DEBUG=3Dy ?
>>>
>>>
>>> maybe related issue:
>>> when lockdep debug is enabled, the following issue become very easy to
>>> reproduce too.
>>> https://lore.kernel.org/linux-nfs/3E21DFEA-8DF7-484B-8122-D578BFF7F9E0=
@oracle.com/
>>> so there maybe some lockdep debug related , but not btrfs related
>>> problem in kernel 6.0.
>>>
>>>
>>> more test(remove some minor local patch(no qgroup related)) will be do=
ne,
>>> and then I will report the result.
>>
>> Better to provide the patches, as I just finished a 16 runs of btrfs/04=
2, no reproduce.
>>
>> Thus I'm starting to suspect the off-tree patches.
>
> This problem happen on linux 6.0-rc6+ (master a63f2e7cb110, without
> btrfs misc-next patch, without local off-tree patch)

Same base, still nope.

> so this problem is not related to the patches still in btrfs misc-next.
>
> reproduce rate:
> 100%(3/3) when local debug config
> and the whole config file is attached.
>

I don't think the config makes much difference, as the main difference
is in KASAN and KMEMLEAK, which should not impact the test result.

And are you running just that test, or with the full auto group?
>
> this problem does not happen for 5.15.y.
> but yet no test result of 5.16.x/5.17.x/5.18.x/5.19.x
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/24
>
