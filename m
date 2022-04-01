Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAE4EE64B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiDACz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiDACz1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 22:55:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D84BFEA
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648781614;
        bh=3nmpyRPrPQZS/OP2T06iXlfBdJofV4ZNDtkvUbdckAc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ArrSMbhzIamLfPBX9oxj0jQ6JWtBh0T2D0ocyqPW/7AQ46kbQam6R1oiSLbp93u/+
         SJPX4qIgEuU8QiC5KmcYFdtz8Mzp2/P8ijD2ZDBc+G4kv3/kH7DSKbH7fe2gfs45Mm
         5Do23N83fG2fjcbGkd2hmSkaz3GKPwymKcAT8yeE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mjj8D-1oK8X83r3r-00lCOF; Fri, 01
 Apr 2022 04:53:34 +0200
Message-ID: <d70042e2-1f05-1052-d6a1-2d8b57b0300f@gmx.com>
Date:   Fri, 1 Apr 2022 10:53:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs volume can't see files in folder
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
 <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
 <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com>
 <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HUAoguAg3GS06Dnq/pkWkVhGapwSgFTVp6vxjZLdvDnb8v3z9Vm
 ogZUqzR/AxYyTgha/8qbeohQDiT4Pbr9AkDHWGnr9pX+N74RENL7O9JyN5roTuuOAtgsTVQ
 zs6JVLcFz5oNZ2p4blty480VAm/s2kCdd0yHCICoRIhjVHt087bFgBdEwY/GNKLM+Ehmfe+
 rFTZGB1a/VOufcOJNNWew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8pZFc105xQ=:6bu/p+f4Eom7t1P3t2tdW5
 tweBg7ViJORe3oAHqViyRtxy/w6OoeqVaSf0A38nREnhaIyni9rHx8+fb9Gd6hhSHIeQ2TieV
 +Uz8VE//qWgD80dkMi0d8EusLiAKjMj+jIOyW854+6jdWChSpeTuZkWS+mnlJgQOmL/H24DhL
 Ktpk93ILFdE6rbXW+j5mrptE4B2rgZeYdw0xkS2kipHcwB5RolMPD7rQU++L4MKHC5p6KpnkW
 GBHWj7edAdoUKTalE1hCSM7QID9lXnuYJXnc+JgAYxE53U80SlNccS2N3DxjOE/Hzy7yqY2ak
 KS1btRoe57z7CYB7eFS67uhJy3Py21y/cAUPpXMxC84Jj+aN9WcBXSEBIyOOfEOicQebE7TzG
 wqy6f/rdTvjytcrIyMnyKdkh0LjYnX0bJ2YWWBHvnXJG/1yndi+JA/tdoXTL71F4Lp+TDbKJ2
 mSddMCmaqN96xjgosD9EPh0pea8HSCO87Nsz1coiT0LVgr5jNMPJWf2OXevfzm0usOC/H/Yta
 P1A86xncAMePLpHPPHZli6a+6BqUeS4Im/2o+HaSbGYaMrmxbiSVyNh+6GU+6rzfL1ff9SeEY
 Yu0aIOOrrI42lqCVb3iNyJB1UCuBPWF6VJN8M8zhIaz8eNlrvglR9ciaYlyCoCPRxxjv4bGbh
 c8j/ZtlJxzUkNcEh/YYWg165pZNVP873X7F7dvqJ6tiXXxj2SMx5o4K5FFZNa2PbZQNd2XMEK
 pR1hnclE1ainYWrHMg4vGWWaX5VOGkPexMJJqPrZ9yHozLVwIFbVjZKvtBOZY8xiebCdFs1+V
 68JQSVO92bY2/bSxbpmkHydYbQXDzSJLtn5CvKxsHiMDjRgdnjgiCxHxg5WodTFVtogtuzj5f
 DYe/ke+SgZ+w8cVjKJIOO0qy6p3GoX48CUHtzDkldQls1P4CE4Gtx/pJZ89D92zCIcnFlIBCX
 /AWaNLPdVW9ZnsMdrxlp+xEFFUcpHOQw6hasRboUY5aVzw5+kgxAT54Z90FosaAoHTCF0xLXp
 +kHHaksqjMr7ow4kjmjuzzWPsOcG4wZAObhVplFiyuXMFE1RrQ2UlJMN//JMWLhr6bQnJeRsm
 ZrxV+I3s75Pdzg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/1 10:48, Rosen Penev wrote:
> On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2022/4/1 08:24, Rosen Penev wrote:
>>> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2022/4/1 03:29, Rosen Penev wrote:
>>>>> A specific folder has files in it. Directly accessing the path works
>>>>> but ls in the directory returns empty.
>>>>>
>>>>> Any way to fix this issue? I believe it happened after a btrfs
>>>>> replace(failed drive in RAID5) + btrfs balance.
>>>>
>>>> Btrfs check please.
>>> btrfs check --force /dev/sda
>>
>> Force is not recommended unless it's your root fs and you don't really
>> want to run btrfs check on an liveCD.
> Same result without force and unmounted:
>
> btrfs check /dev/sda
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> block group 4885757034496 has wrong amount of free space, free space
> cache has 286720 block group has 290816
> failed to load free space cache for block group 4885757034496
> block group 4898641936384 has wrong amount of free space, free space
> cache has 36864 block group has 53248
> failed to load free space cache for block group 4898641936384
> block group 4953402769408 has wrong amount of free space, free space
> cache has 262144 block group has 274432
> failed to load free space cache for block group 4953402769408
> block group 5478462521344 has wrong amount of free space, free space
> cache has 716800 block group has 729088
> failed to load free space cache for block group 5478462521344
> block group 5484904972288 has wrong amount of free space, free space
> cache has 811008 block group has 819200
> failed to load free space cache for block group 5484904972288

Only non-critical free space cache problem, and kernel can detect and
rebuild them without problem.

> [4/7] checking fs roots

This is the most important part, and it turns no problem at all.

So at least your fs is completely fine.


It must be something else causing the problem.

Mind to provide the subvolume id and the inode number (`stat` command
can return the inode number) of the offending directory?

And some example command output when you can access the files inside the
directory but `ls -alh` shows nothing?

Thanks,
Qu

> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 2689565679616 bytes used, no error found
> total csum bytes: 2620609300
> total tree bytes: 5374935040
> total fs tree bytes: 1737539584
> total extent tree bytes: 511115264
> btree space waste bytes: 889131100
> file data blocks allocated: 41913072627712
>   referenced 2675025698816
>
>>
>> As sometimes it can report false positive if the fs is not mounted
>> read-only.
>>
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sda
>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 139616845824
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 146059296768
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 3183842689024
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 3184916430848
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 3185990172672
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 3187063914496
>>> btrfs: space cache generation (1084391) does not match inode (1084389)
>>> failed to load free space cache for block group 3190318694400
>>> block group 4885757034496 has wrong amount of free space, free space
>>> cache has 286720 block group has 290816
>>> failed to load free space cache for block group 4885757034496
>>> block group 4898641936384 has wrong amount of free space, free space
>>> cache has 36864 block group has 53248
>>> failed to load free space cache for block group 4898641936384
>>> block group 4953402769408 has wrong amount of free space, free space
>>> cache has 262144 block group has 274432
>>> failed to load free space cache for block group 4953402769408
>>> block group 5478462521344 has wrong amount of free space, free space
>>> cache has 716800 block group has 729088
>>> failed to load free space cache for block group 5478462521344
>>> block group 5484904972288 has wrong amount of free space, free space
>>> cache has 811008 block group has 819200
>>> failed to load free space cache for block group 5484904972288
>>> [4/7] checking fs roots
>>>
>>> It's currently stuck on that last one.
>>
>> If the fs is pretty large, it can take quite some time.
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> It looks like an DIR_ITEM/DIR_INDEX corruption.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>
