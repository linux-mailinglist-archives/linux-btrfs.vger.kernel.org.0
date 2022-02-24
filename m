Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41844C2444
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiBXHAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 02:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBXHAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 02:00:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F71E3765
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 22:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645685969;
        bh=XAnKpXU/ZBQkaP5mAWBb8HYgUk87DpOWzN9puAXWWb4=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=GRqZBU4TcGw8wz6e80ahCubQkYRokWdKMApfGiBXTwnrKQwN6pbWHQN09podGyDT+
         PWAl0Mo/7kwpaRDwVFOQlWVeNqnvTk9MMKcJJtJPdoWxj3WtQFj+ZForwhKaL2eDCz
         Ky4sMv6xpjrNJD1rhdW32mu49/r4oVQMAXIJiHY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9nxn-1nHMvt0hpF-005qD0; Thu, 24
 Feb 2022 07:59:29 +0100
Message-ID: <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
Date:   Thu, 24 Feb 2022 14:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
 <20220223155301.GP12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
In-Reply-To: <20220223155301.GP12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/lnW57LkJEfvzL8/AHx0fRYFbi7gg0Yx/B4Zcx7v4EK79ZkgwOl
 auxsvXFnIhNlgUMLuR4WnyxAtHJokBewAQKOrcVGEecZfGJBT3hb7SLZR+3O5YuTzP93aZb
 i5sAMJJ94VX8EnUQY4rGSVYmqBocdgNrRQ4dc5d22tbYddQ7ArkrhHFl/QTP9NTVHzJzmmk
 Xecyc9ku4HgtOarVszsfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+xPFJ/L6cAE=:GoOmZElXT84YXliJFzElet
 wsqc3GUnnSnrIGjwOCSwOdSCM0LqDaHFQJgbmEdTCZVh8mpYja5U1hte8uWLVRsjQepCFdQbo
 qAH+wHwg8OxiG76iLQAxYNg3OruM3NbGxyHYNvfmNF90crGd9a4Kzh6NpvA2hA+7oNN9GvwRn
 +Fz8lyG+2r1/KY/YN+z+rMGxKLewb1KAWNEa3o4Drqm69D7PmH86k7onK4CuA+d0klDPhoomq
 xj/DjMzc30zrFtjHlZstAjbWtUvbM8LFnaqBY1hwLBvpR8bRDAPnR0nOWoxpkKIF24i2MjADf
 /eDqVFfrUcvomM1k2fLIPFCygFrPjR7n2Xqo4IWywMD2na/DcivwcnVNiPaFzPZ9497t1uJlk
 kAMTUtourqe5rJ9nHSqYftYBwl9CrmApsQumLdqJxFHOdQOtBRsbg2S/2AB1EZ9gY98Qg9gki
 vfmUDCpSlKfF9s6Tv0RS4J34bmOpAHCWphx5Fbb+OZ/J9z4zrtC3JUEjJmF/SVHE85sNzprgn
 V03kvl3xETNO9tBTnTCXW87EfZReSK10hulcKO0fwQZi8qhax/fe/mO0oMxLlP4a4DvbdSu8N
 QSholOEYMtt4X6nY43iGQ49QLhMv3yndR3/Kdc5rmNeS3V+7k5GvBCjEwSHccNhXW4XIWZwcq
 bdRZiYw76zyfevXvJMXeU5zfEG4chga24GzEVRy03KIA4qY3sk+5ypnFu1Negvt6zmOP5N33k
 rdMKwT8kjEpBiaUlnxpAxWZ3YixF48sf+51wCWd0FZTQ8SbErSVL66QXvLmp/qnfz6URugnNF
 6NLBwGlIJ3o36JPR1FxUWckOa4LOHEL+Wrr6X76H0PPO9X1mgDM7phwkB4Xk/TVpJlrwYLVX4
 lBFD34OhlUSlrFJW1DCd63CEQ4dwTCPMWHXJ6CBaE8xcF+KI0/ab9F2/haj02cc2prDhyD1vY
 0OyMM6hdUQBqaL7ZriIdK8j37rD3FnfAF8FfFezIP+eLaJsda+ECSxzr5mFmkydBnBJrEyQaG
 3MeKJkj2j9Gt0Tn7vi5fEL+bNPb/nwE2bKBHt3B9bs2Ev8gH3o5te21axNO1jQ2pY4bpneIzM
 nd2o0TZQa/6j94=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 23:53, David Sterba wrote:
> On Wed, Feb 23, 2022 at 07:42:05AM +0800, Qu Wenruo wrote:
>> On 2022/2/23 01:32, David Sterba wrote:
>>> On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
>>> @@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct btrfs=
_fs_info *fs_info,
>>>    		goto cleanup;
>>>    	}
>>>
>>> +	if (cur >=3D i_size_read(inode)) {
>>> +		iput(inode);
>>> +		break;
>>
>> Would this even compile?
>> Break without a while loop?
>
> That was a typo, s/break/goto cleanup/.
>
>> To me, the open-coded while loop using goto is even worse.
>> I don't think just saving one indent is worthy.
>
> Well for backport purposes the fix should be minimal and not necessarily
> pretty. Indenting code produces a diff that replaces one blob with
> another blob, with additional changes and increases line count, which is
> one of the criteria for stable acceptance.
>
>> Where can I find the final version to do more testing/review?
>
> Now pushed to branch fix/autodefrag-io in my git repos, I've only
> updated changelogs.

Checked the code, it looks fine to me, just one small question related
to the ret < 0 case.

Unlike the refactored version, which can return < 0 even if we defragged
some sectors. (Since we have different members to record those info)

If we have defragged any sector in btrfs_defrag_file(), but some other
problems happened later, we will get a return value > 0 in this version.

It's a not a big deal, as we will skip to the last scanned position
anyway, and we even have the safenet to increase @cur even if
range.start doesn't get increased.

For backport it's completely fine.

Just want to make sure for the proper version, what's is the expected
behavior.
Exit as soon as any error hit, or continue defrag as much as possible?


And I'll rebase my btrfs_defrag_ctrl patchset upon your fixes.

Thanks,
Qu
