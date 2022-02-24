Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76A4C2B8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiBXMTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiBXMTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:19:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943D1451E3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645705137;
        bh=6qd1TZbO707GDoJxYAnI795Jw9fXLGYi4Jn6Qbv277M=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VjoOMhbjLgCgdVFgu7e2a0fdCe620FLckYK9Y9xcN9n6x+ejhHRrGCsBmf6vvi9P8
         9ZxKJAU9Fre85/Cx9jDROqzTf0tZtPAbwi9p8RmjIB+8Ad0YzA5/+LYuraPpu4RytU
         eP7wtBrdgOou4+Y4KbItmxYiWOj3tr03ZSC9lvcU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHQh-1o7F4T1PYH-00ki6G; Thu, 24
 Feb 2022 13:18:57 +0100
Message-ID: <00ad978f-195a-9f47-043a-befb0bca0faa@gmx.com>
Date:   Thu, 24 Feb 2022 20:18:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
 <20220223155301.GP12643@twin.jikos.cz>
 <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
 <d760d854-b3d4-6118-9b8d-5b1e775333e7@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d760d854-b3d4-6118-9b8d-5b1e775333e7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W9tqLiROMaSXiQaph8ooF6q27Lli3bg4hGrlYHShFfGiX0Q5l1V
 3UL73zwh/+pLR10DkaNPHiYUS8eczV6xutlBuszm0TBR+OXmmFDpKDsZcr1sWXkEvRFDafd
 JkYFqdQT1z7TLerR/w8C/9RF/CaNOVOgm+nWdEbR9mFyfOAMi9nFNC8s+Vm+GcDTpCMMDk4
 lrp9CNqItNdb9rDwVCzDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4bQqMCkSXik=:AvF00gyC7l4ri9VjODZIik
 1RONY/TYyN5KaXbhC+trZez0dD+e/7jljZrJWUF6L/x7ZeRw5gQpeajjg5qmjbW8HJxDjlg9M
 PB/vEvBarhRz+u4Vt80y/sjhUn2Sp7CZqpSSqxeJh5kX8qz3w3dUGgXt4meXJoVaxCbw9Y9EA
 7nBaGAmtecjZaaT+PGkDHGnoo8776LuQ2IckA3SQU0zoHxKdSGEUt4pu641j5iqon9H1931Ve
 NfKGDw5wYpf10sooQb+q3mz7xpUTFhbD0MuuO4yENkBdwe/WZ3TgYZ7wihh8q+s0X376Ech3i
 I0CcVpLZL5q9zpmjRrtIl7teRZHmM171W0yl/dvz0KC4Ouvjf0HXVZ4RzrggCvgyRzjLeSJNF
 yftBeTsFvf/lvX+8T3E/St6jjTz0yDlH27IDdNU9emYspE7S9kDslh7nmBjPcy/JUuNYwF9PI
 XXO4UV/fTYljZgWGHwepB3cQRFH2hHuJ3hAAY6tPVZ0TzXcCkE2w0lSAnExtvlA+6kDNM7JTj
 MmQ9TaIuEFV3J2Jm3Ywr2XJHTPIRoSB+zEPPCyeS02ZFIN9+3ljnjILn6dzBaBOAKFTwkKT7U
 AJvLXpWviAA4RLlXG6UYUUkC8Vvt0jtxVgdTJD7VOSIHhxr1QqkeVoEtgLEtWJj7wiNMs9zd1
 wPflw49xZujm2zhpoobUMyMFhOdhlvMoa96lHSgnFwe7s1zkIZHJGsaq/OEfCc/353PhJRkMR
 DSkkWkRR0bQOTOVgOEUEYt0MZ4rLe5AdB78FSZi/64ps7qtqD5OpWWxo0/2dYKoGS3yb4UDvU
 ZptuYyvsDJyPZL5VhaaI2PfN4dEDnTUXSle+Wdo2nW7xTWwUzek8cuWzvH7tt7tuOmPpvsJoC
 pQ3jmtwAG7P10XsAoXxKFMZaQyWkvyfoZv1Ued8QFQEs6KCP0iBmdyjgLz8Tq0nsnxT3ix8iQ
 4Arzm2SJ0Cil8vBSgbHPqtMlXHZ11k+b9zz7ceC7Bvp20Jsj2dCnKF54E8DjpN6NT1aAeiDCJ
 UC7bRLKE6cZUH7MHQrHDqqVPOx1RBPug9J/cUhojWIbZYOZBL2I6AH4jOhFzp3ZtpFCHtFez6
 y0fSsy8hz53VXI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/24 17:45, Qu Wenruo wrote:
>
>
> On 2022/2/24 14:59, Qu Wenruo wrote:
>>
>>
>> On 2022/2/23 23:53, David Sterba wrote:
>>> On Wed, Feb 23, 2022 at 07:42:05AM +0800, Qu Wenruo wrote:
>>>> On 2022/2/23 01:32, David Sterba wrote:
>>>>> On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
>>>>> @@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct
>>>>> btrfs_fs_info *fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cl=
eanup;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 if (cur >=3D i_size_read(inode)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(inode);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>
>>>> Would this even compile?
>>>> Break without a while loop?
>>>
>>> That was a typo, s/break/goto cleanup/.
>>>
>>>> To me, the open-coded while loop using goto is even worse.
>>>> I don't think just saving one indent is worthy.
>>>
>>> Well for backport purposes the fix should be minimal and not necessari=
ly
>>> pretty. Indenting code produces a diff that replaces one blob with
>>> another blob, with additional changes and increases line count, which =
is
>>> one of the criteria for stable acceptance.
>>>
>>>> Where can I find the final version to do more testing/review?
>>>
>>> Now pushed to branch fix/autodefrag-io in my git repos, I've only
>>> updated changelogs.
>>
>> Checked the code, it looks fine to me, just one small question related
>> to the ret < 0 case.
>>
>> Unlike the refactored version, which can return < 0 even if we defragge=
d
>> some sectors. (Since we have different members to record those info)
>>
>> If we have defragged any sector in btrfs_defrag_file(), but some other
>> problems happened later, we will get a return value > 0 in this version=
.
>>
>> It's a not a big deal, as we will skip to the last scanned position
>> anyway, and we even have the safenet to increase @cur even if
>> range.start doesn't get increased.
>>
>> For backport it's completely fine.
>>
>> Just want to make sure for the proper version, what's is the expected
>> behavior.
>> Exit as soon as any error hit, or continue defrag as much as possible?
>>
>>
>> And I'll rebase my btrfs_defrag_ctrl patchset upon your fixes.
>
> OK, during my rebasing, I found a bug in the rebased version of "btrfs:
> reduce extent threshold for autodefrag".
>
> It doesn't really pass defrag->extent_thresh into btrfs_defrag_file(),
> thus it's not working at all.

This is the fixed version of that patch, based on your branch:

https://github.com/adam900710/linux/commit/5759b9f0006d205019d2ba9220b52c5=
8054f3758

And my branch autodefrag_fixes has rebased all patches (with a small
reordering) upon your branch.

With trace event and my local test case, it indeeds shows the new defrag
will only defrag uncompressed writes smaller than 64K.

I'll submit a new test case for it.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
