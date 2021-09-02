Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370D83FF729
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347637AbhIBW3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 18:29:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:45733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347658AbhIBW3u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 18:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630621728;
        bh=2/bzs/sDv0drcwsgnCUWG0UL2BWbeqo6Cnl4tZhE9BM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IS8arSON88EMOteFnIJS7EhbKeHRLNsS4UmlghC8Isx6OoNLlmRwjiAYSfFhjZziz
         nT8IDUQefyUGs7kgWQkmmuzdRUUu6KRfCE8BpGifP60eKqsyM/alE0YPY2XF/kSxMP
         kkCk12ZmKVS7AljD2/b4bFfL+ZIn4O5isK9TTJfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMobU-1meYXr2Q7w-00IiL3; Fri, 03
 Sep 2021 00:28:48 +0200
Subject: Re: [PATCH 0/5] btrfs: qgroup: address the performance penalty for
 subvolume dropping
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210831094903.111432-1-wqu@suse.com>
 <20210902162502.GZ3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4b802b76-4875-7ed4-8ffd-fee978b5932e@gmx.com>
Date:   Fri, 3 Sep 2021 06:28:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902162502.GZ3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NzmB4qMEspUItedvfnOEZW3ekO1OO/x23LxlCmXZw2eXsWOXYeq
 8f2G5Vo1QwkbLWxZ3acM4SM/tn8ORr5WDQd6ygZNIMbn2svER6UmMIm1cvff4mtWBJm0GBb
 hUqUA+ksdRiwyBnUtIDThHkuvrXZCufSqPUZDLvZIZ31xmilUGUVD9Iea0y5vgN30L7TupM
 wymPv7oegJOsixQwxLh/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Tc57niCuIg=:OBJR/MPGv6TUBtR2qdNAX7
 UuFFMtY0yZZJ/Imj4eIUYaux+UGvxEfYpRJsV6rSQN4Iu1F4RBj8bx0aVw1WvTIDNj3F8xD9t
 qqp9fYG8mEBR9isXY4cr25xlyOZigks06Zzw/CeL7fLj/5XC8xtGIVLasRVGn0U9bKlVtlK5/
 3lOOC129fL1TEv1+dMPEcZWTvQ5ufupZG2aW88sVNFoNvTkUs+xXCrR6eeDOm4jZcSF72ivgx
 BDjLKj/VC0U/lBtBOaWzecaG0Ho5bbM6ojlrLjeWdMuUfDAShfw06SQEzlXaJA1BdWbKtlgXZ
 smSWXUttGXyUQaeFXYf+tjh2j17Iqo2w7RFIDYzjmS77+m4M2Ex3qm8HHwYHBU1r/M7vwwhAS
 o5z0CWo0l/nkDCuI3OHKscB8kk9Y7ul9JTcn11HRGKOR6vt6i8oxaFXLg4lvvgQdR/wofYMcn
 U62V87V3u38hAHinmsKRjEJdd+voNt0MpEicZtnFUw/mTdbCxcGr1KTdyS/lpAlmpzdwXRM4H
 aoVJc6/EMwXOn6HR1JQ/Af/8OUbW8MFT055SJ2UPqwEt0N1lItCCyaIqKcoYrDOFkENP0kKuR
 dwkUV5WNyoA4oSPyivf7C8FAt0yifs1ftiNEuGZrge7b/VVStuYYu+uazIaDJjitaXxdLD6Rt
 VUmRubExnhPb0Lj9ntlAogwHZH2qSqHAleh99Ahc8zkGI+RNK+ThpIEC3K7J8mcJQmnCzqamq
 9lYMjFWWhDMXFfFhpa0Gt64BN1qnZaso4iIuRBkzwgQ7fFDmbjLVKSBhJIUhe0pPbN4dre0ck
 hr7Xh8DKPBK6rEgk6hUtVH3vLmEDCNdY+RJlk/R6Wq731qixyZkO2Gh8gaXZX55jz4AmPQJcn
 n+GDSVMJG5KSTeZ45q52YRZTl5MpwuH0KsS6HHimODSB6hgz/zNZro7sEb8nzsP1hNbHAXjUN
 czKgfwQGz0aYWkR1hRnj7UewJu+rKrRXJ8WffRPsp6MPne1TzdSxUlM3kF4MexITvTjHe01Fg
 zWvQZf0M4dzmtGR4RXODl5QFFtQ8DznSKKibTDzI4KIMin8GoYeCI/LUOEW5v913x7pJ4ZCOF
 ldqPdEG9v5KzMLMP9oba95uFWeJ/rzz2ELwRagWRcxXm+VrZO5rCEBU3w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8A=E5=8D=8812:25, David Sterba wrote:
> On Tue, Aug 31, 2021 at 05:48:58PM +0800, Qu Wenruo wrote:
>> Btrfs qgroup has a long history of bringing huge performance penalty,
>> from subvolume dropping to balance.
>>
>> Although we solved the problem for balance, but the subvolume dropping
>> problem is still unresolved, as we really need to do all the costly
>> backref for all the involved subtrees, or qgroup numbers will be
>> inconsistent.
>>
>> But the performance penalty is sometimes too big, so big that it's
>> better just to disable qgroup, do the drop, then do the rescan.
>>
>> This patchset will address the problem by introducing a user
>> configurable sysfs interface, to allow certain high subtree dropping to
>> mark qgroup inconsistent, and skip the whole accounting.
>>
>> The following things are needed for this objective:
>>
>> - New qgroups attributes
>>
>>    Instead of plain qgroup kobjects, we need extra attributes like
>>    drop_subtree_threshold.
>>
>>    This patchset will introduce two new attributes to the existing
>>    qgroups kobject:
>>    * qgroups_flags
>>      To indicate the qgroup status flags like ON, RESCAN, INCONSISTENT.
>>
>>    * drop_subtree_threshold
>>      To show the subtree dropping level threshold.
>>      The default value is BTRFS_MAX_LEVEL (8), which means all subtree
>>      dropping will go through the qgroup accounting, while costly it wi=
ll
>>      try to keep qgroup numbers as consistent as possible.
>>
>>      Users can specify values like 3, meaning any subtree which is at
>>      level 3 or higher will mark qgroup inconsistent and skip all the
>>      costly accounting.
>>
>>      This only affects subvolume dropping.
>>
>> - Skip qgroup accounting when the numbers are already inconsistent
>>
>>    But still keeps the qgroup relationship correct, thus users can keep
>>    its qgroup organization while do the rescan later.
>>
>>
>> This sysfs interface needs user space tools to monitor and set the
>> values for each btrfs.
>>
>> Currently the target user space tool is snapper, which by default
>> utilizes qgroups for its space-aware snapshots reclaim mechanism.
>
> This is an interesting approach, though I'm there are some usability
> questions. First as a user, how do I know I need to use it?  The height
> of the subvolume fs tree is not easily accessible.

The generic idea is, if you're using qgroup and find btrfs-cleaner
taking all CPU for a while, then it's the case.

>
> The sysfs file is not protected in any way so multiple tools can decide
> to set it to different values. And whether rescan is required or not
> depends on the value so setting it.

That's true, but shouldn't that be the problem of the users?

>
> It might be better to set the level (or a bit) to the subvol deletion
> request, eg. a "fast" mode that would internally use maximum height 3 to
> do slow deletion and anything else for fast leaving qgroup numbers
> inconsistent.
>
The problem is, the qgroup part is completely optional, thus I'm not
sure if it's a good idea to add new interface just for an optional feature=
.

Furthermore, when deleting a subvolume, it's only unlinked, the real
deletion can happen after a mount cycle, in that case, runtime values
will be lost.

If we really want consistent behavior, then we need new on-disk format,
which looks overkilled to me.

Thanks,
Qu
