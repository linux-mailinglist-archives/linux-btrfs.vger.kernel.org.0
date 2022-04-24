Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2229850D0C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiDXJYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiDXJYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 05:24:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B628B3C
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650792065;
        bh=R3PNDa1jvy5Md+op3J90aP/dxeRGOjDngknXGfKMwIo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RL2c2fqX4/EC/FrhQKxfyiurDUZ0vBLb5xVD0OMxwr+4qqaRKrGF7JeT1otbKSc19
         VkK1659+GXif+jb/kFZoyYY9PRxZ12Otrg/UtAmxFjbbIpDKsS6//0MNDxLjx/kOjJ
         F9cbh2SLTuiash8gP4wXHMk4jijpPfuqE/Ket5Kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1nX3j41S86-00PyX9; Sun, 24
 Apr 2022 11:21:04 +0200
Message-ID: <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
Date:   Sun, 24 Apr 2022 17:21:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
Content-Language: en-US
To:     Johannes Kastl <kastl@b1-systems.de>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VTpyvO62KZltMD4RUL2drK0VdCub9t+GQmzkATrHEXJpcXJmfQy
 RfCZr1ZO/7V77QSbXpGb84+P1DBCe6SCiffDhT6putJ7YAwu7O2lcLNLQ1CLM/bL3LsBfdQ
 VsMMNi+Tt4ij7QUxAIwl7RCNX+1xZBmu/pDHOYEmlYJdkk8nHKWaYQenedRan03UqUEihBC
 1edi5h0RIsutfagBqdADQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jrd8XvnRc6k=:2+cC6UHc5mwPJbZ+6ZPNEI
 fHA+chIefObxI4cWdz9KYBHam6voeWU1cSSQPNKNVPYXi4fMdbgq4zNkjtoExFZzSi+fVk3MB
 cLwOj/lQpqCUOz77LRBk5zcHAJ49Z0yz8auurnKQ2Tn3Z+iLNPpupAV2v4unxPtz7lpa7jKuz
 5agGTP2Ej2gsMs1xO8sqVDVzgFRPfZKncWSdsrTm75B1X8K9gbDsW0V3zpml178kLLmK5UMld
 IyWVybCbn9ZS+bO+ibXagRiN95BrxoR11Cmb7HsOJLIeeMuSWokFSIq1ufb9YTLVjudkH9tmb
 f3ragIy5UYcX7gCUYu2riTRig7AFwo6tqco7quPiKdaDhZ4APx2esmbFGMdnCY5gjvhbi01TG
 taEYAEey4CI8DW5iRFzAKuiGekf1ZXYJfoIJrPceCM0HPYxOt9ckuWJepFb+S3qJtBEoUg0X7
 zcBvXlhTxnFD/kYXiZOmMYYAUGcMY9CP2gfs2BwYKW2+ST2enjPbbU3M/wnSzzm/sqcRGu8ij
 KvZievtSH1Ey+BwY5WP8loPSmt4j22RJNplQEKJGtqcdYaZirnfWu/vywNRt/t7M8XEgLkUd6
 mYcdC79AwcD1qGLJKrDz3el5+N+QGdr4iBCCb3UaCSdrda6ntdgeamJACY2plIm14op8QL+KA
 CUUUWGzP9s8Z6jaJnGaKGdg+ZsZvcXAWc1+WIlTSms13QcXqWhETBqRGsfFgh2CvXIWxxItZ5
 5Owttz+7djl37wd0NhcdgxbW0AtQA9bcS0tQ8kmZ8QoaAQI9GNDAD+HPHa9QH7N5fUTrCpxfN
 7T0Nt9zCoNSI1crN832H8dZD9f66zOvJNFJaCKR7WEQc4Wc54jnoE8KJibfxX3qStU89MwCw1
 QeJMFh7utDjqup5ixvpLsiij2oCFjnfj4j4nDEdk9+slIuS/G8ea+R9MK/AyOzvNlLoYjgrEO
 XgB96pkHd4p45HLTIZK4IaXGE6h82QgRkhgHw+N4g0mZBGqhgcjscRcx/Nds5MDjvIgco/ikt
 8LH1VgUC0M6WIUDPnYofeM5HsnGLM1Lsk2ym1Xpv3p2/4FOMlkyXQZ34vHthba5qeGsM4BUHT
 yoDk9z/AToEqAo=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/24 17:10, Johannes Kastl wrote:
> Hi Qu,
>
> On 24.04.22 at 01:07 Qu Wenruo wrote:
>
>> No need to run btrfs check on each device.
>>
>> Btrfs check will assemble the array automatically (just like kernel),
>> and check the fs on all involved devices.
>> Thus no need to run the same check on all devices.
>
> OK, good to know. That saves half the time :-)
>
>>> The output of the check is below. The TL;DR was that I should run 'btr=
fs
>>> rescue fix-device-size' to fix a "minor" issue.
>>>
>>> Unfortunately, running this command fails:
>>>
>>>> root dumbo:/root # btrfs rescue fix-device-size /dev/sdc1
>>>> Unable to find block group for 0
>>>> Unable to find block group for 0
>>>> Unable to find block group for 0
>>
>> This is an unique error message, which can only be triggered when
>> btrfs-progs failed to find a block group with enough free space.
>
> So would resizing the filesystem (to 8GiB) workaround this "limitation",
> so afterwards it could properly fix the device size?

I'm not yet sure if it's a bug in progs causing false ENOSPC, or really
there isn't many space left.

For the former case, no matter how much free space you have, it won't help=
.

For the latter case, it would definitely help.

Thanks,
Qu

>
>>>> btrfs unable to find ref byte nr 2959295381504 parent 0 root 3=C2=A0 =
owner
>>>> 1 offset 0
>>>> transaction.c:168: btrfs_commit_transaction: BUG_ON `ret` triggered,
>>>> value -5
>>
>> So at least no damage done to the good and innocent (but a little old)
>> fs.
>
> Puuuh, nice to hear that. :-)
>
>>> So, my question is what I should do:
>>>
>>> Do I need to run another command to fix this issue?
>>
>> Not really.
>>
>> But if you want to really remove the warning, please update btrfs-progs
>> first, to the latest stable version (v5.16.2), and try again.
>
> I'll have a look if I can easily install a newer version of btrfsprogs
> on this machine.
>
>> The involved progs, v4.19 is a little old, and IIRC we had some ENOSPC
>> related fixed in progs, thus if above problem a bug caused false ENOSPC=
,
>> it should be fixed now.
>
> If I can install a newer version, I'll let you know if the bug disappear=
s.
>
>> You can ignore it for now.
>> It's not a big deal and kernel can handle it without problem.
>
> That's good.
>
>>> Should I copy all of the data to another disk, and create a new BTRFS
>>> RAID1 from scratch? (Which of course I would like to avoid, if
>>> possible...)
>>
>> Definitely no.
>
> Perfect.
>
> Thanks for your reply! Have a nice day.
>
> Kind Regards,
> Johannes
>
