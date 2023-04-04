Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C46D5953
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 09:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjDDHTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDHTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 03:19:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C39E5C
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 00:19:35 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1qcwB82ccY-00zGan; Tue, 04
 Apr 2023 09:18:45 +0200
Message-ID: <16c0d29d-c986-0c9a-dd95-10d61eb6f29a@gmx.com>
Date:   Tue, 4 Apr 2023 15:18:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Matthew Jurgens <mjurgens@edcint.co.nz>,
        linux-btrfs@vger.kernel.org
References: <01bc2043-28ea-905e-44f2-de61cd86934e@edcint.co.nz>
 <02f70470-fd22-bfed-7f0b-2c0acf4259e2@gmx.com>
 <7ae06bd0-4165-8e0b-8035-f1e676fac270@edcint.co.nz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Readonly file system: __btrfs_unlink_inode:4325: errno=-2 No such
 entry
In-Reply-To: <7ae06bd0-4165-8e0b-8035-f1e676fac270@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4d93sCkb/JkNBrj98pzFWJugV2NBtXpnmu0VNZMi5mDIlhKD5oa
 EgRy9jfKPUjCLtfW2R4Bcpbjha2eh331JFxwGm19UNo2+WEnIHxtmmL+tInewy9nk4qjZOq
 vflPDCQa2mKKc8zCUODuMIyioAAs93yI91497QmW7XAyU0wue3cATC8TpB0LfY/3bqBPjM2
 jAUBH3UYLMThzc4lmPSRQ==
UI-OutboundReport: notjunk:1;M01:P0:84gFv/AfyjQ=;skNY5ga5nUbwnR4Z8FwZ8PgNtXs
 O4zvFLHZ/0N2UVfVN62jyVHJ7l8Re5+MFtiQncCegidHkJQ7SF4yP7V8oROYdnRE5osUPVxq/
 CMbPidG1AeMI2E/YOcZ6Fb6FkKtH+Zu8APhGBtz2QKjl3Nxf9uZM53fS6zJXyZVwdLTovZSjq
 fxnfiTHbTMTxz2BrV5SHqYSW//qNpH7xsA+6fCVtGZphqIaaFj9qh3+XfuyTON7M3k1+EAqts
 JVIRHjnWlWxSFeZCcddISsBEfbLL9ZbyuVwX5QyfRrJIvLXrqknDoN/aK9rmtRZwV6DLQewtR
 swcxG14lE3IrbqN3ETbwrRuSTHqBrImP8SjBLGa0MWZ3HjHUvk7RN8V/hRijzbtrrXhvv2IeU
 3vUIf6FIJ7Bb8EXAOBnS1ODpBj3eHi/8bo5+in9PWijRmPUBy/S3zHrYq/MBCS3qudZmZcx3Y
 eKDci63y/ZkFmhiIxcUEyNxlzBuLBc/WIkDuYBKygH19dqKw/MxThJFFpmkqwph0EsJsow+tu
 kMLSdPvqnYSrKM+kvZR08DgaAPEJywvmWSUb7ybxbc/CEr8KRaR1ikMui3Kn4NMBL5u+ziSon
 gT7FgBgCEJMNBS3xeIbzf+52fDPBOo1QlKVoq+jnHgsT9Hs09GRx8vkKfsddEK8BlnN/0R3H7
 ZsiAPeSvE5oimeZIwK0/ZVbrf4HOogJsSeLTieubVQDDGrRAwQaJBbr/6Ry7LctxSujlkUgup
 kEb42FSGLyAPDtFQxOVP14VAMHj26YsI7WJFVLHK1jBIpAAkD66l+QRtw2VSNw13srhknHmmf
 BMA0yw5fhN4W5DhwAM2BEhuEjqkpVkx9BLp0nQyM03x1mEIdGhFhwsJpG6W0rVsYU7AC5foa7
 NoBoD7xIuzrMGVmkXqB746HRDKYxBheyJQCB9RJGQW746VrLORX2B/hZogWe+0BVrzmJJi5CI
 GZtY4N16iq6j310r0jJRKGuqts8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/4 10:22, Matthew Jurgens wrote:
> On 3/04/2023 12:39 pm, Qu Wenruo wrote:
>>
>> This looks like an extent tree corruption.
>>
>> Before doing anything, strongly recommend a "btrfs check --readonly" 
>> run on the unmounted fs.
>>
>> Thanks,
>> Qu
>>>
> btrfs check --readonly /dev/sda
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 3adb6756-7cab-4a7a-a7d8-9ff119032ee5
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
>          unresolved ref dir 168755802 index 5462 namelen 49 name 
> dd02f3c3-e4fe--b908-bd11845475af@starship.eml filetype 0 errors 3, no 
> dir item, no dir index
>          unresolved ref dir 168755802 index 5462 namelen 49 name 
> dd02f3c3-e4fe-4f63-b908-bd11845475af@starship.eml filetype 1 errors 4, 
> no inode ref
> ERROR: errors found in fs roots
> found 3501318352896 bytes used, error(s) found
> total csum bytes: 3381392748
> total tree bytes: 37968969728
> total fs tree bytes: 33514553344
> total extent tree bytes: 580124672
> btree space waste bytes: 5546340662
> file data blocks allocated: 3463349383168
> 
>   referenced 3582557282304
> 
> https://btrfs.readthedocs.io/en/latest/btrfs-check.html says "Do not use 
> /--repair/ unless you are advised to do so by a developer or an 
> experienced user" so is it safe to repair or is there something else I 
> should do?

Yes, that particular problem should be able to be fixed by "btrfs check 
--repair".
At least "btrfs check --repair" should not make the case worse.


But "--repair" is only recommended after you have verified your hardware 
memory is fine.

If the memory has bitflip, you always has the chance to screw up the fs, 
no matter if it's "btrfs check --repair" or a, RW mount.

Thanks,
Qu
> 
> In this case, I am happy to lose the file, but this may not always be 
> the case
> 
> Sorry, I forgot to send to the mailing list on my first reply
> 
> Thanks
> 
