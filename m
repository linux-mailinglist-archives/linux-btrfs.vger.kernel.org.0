Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205652F746
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 May 2022 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbiEUBKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 21:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiEUBKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 21:10:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D51B12D6
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653095433;
        bh=YMG4a7gjfz2MiZJKgUQkghdNeTeaIwTfALMJJ8WLG08=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GFfy9gUp1tRkmHnB4guK4nBaGL+IwD+yHtbxIw804fA/hF+B3sbyPabqAE12WA7/R
         sZ28cWNL3Ic1YyPxwrrEj6sJUJi2QnTvrOr24ZjPjTCUAHMosQGUq8oDcW8XBr22TJ
         bXbbIi+ewzRP/WQtaygm/jHGCwz3g6tvnmRMzGYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1oLvDI43Aa-00YBHH; Sat, 21
 May 2022 03:10:33 +0200
Message-ID: <9941f4d1-4eb2-4efb-0e24-09b28f2e185d@gmx.com>
Date:   Sat, 21 May 2022 09:10:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
Content-Language: en-US
To:     Johannes Kastl <kastl@b1-systems.de>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
 <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
 <53dabec5-14de-ed6f-1ef9-a300b96333a6@b1-systems.de>
 <00dcf063-aa51-e8f3-9664-d6ca97306711@gmx.com>
 <05775b94-7e69-99ce-f89e-5c7e634f5461@b1-systems.de>
 <e62b429d-358e-ec38-30ca-671d43a5b5be@gmx.com>
 <16c8e141-f3b8-8a6b-1366-23b9dfbae343@b1-systems.de>
 <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ea73d6b6-4e91-438e-6f9a-7377bb461bc3@b1-systems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oIswbReLmdFZJa6Y5kGVZgglhwLzL7vg72KiSAHRl+1zCZfYZ8R
 u/Q4zZVCdsesDIOwzJZdpq/pOGBBV06PRdCRG0CYgHJf9uveMLN0rA+gMiiVpjYLb2FM364
 KXCUJzRzIdA6e5nmjm5tadr+yvDxL7t46i9+6/YekBdw+n2yPtZud1NbF5X3IALlump3M9y
 Vds9N7pLStr+RJEoE0ynA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UeHiq+5VlTs=:T7eXlpXXb4IuzLMeMBAfkc
 sY689R7kRMMZvNd4U4KvtTh5GfvGmZq2Elf6ZzG+e2l8v9FFyC5D+yuTwvxPMlLNLna+GQzEd
 Kgtx1+G5oz5CuQBQGPQO57o8I1+9rtd4AIByWBrhtPbmgwilVFwmZMR8E/Ep2Z+tGs9VFMyFS
 UkWiWLJo06FyJUubW5HLxcjTqdQOAXjouWretf0B560CPO2LLG8LUMhMP6YVEf64dIAcnYbAH
 wEp1359nPbiWSKchMHG+kAp29VeFW5c058JWOR59C/YHmWc6HBdC1JgMgy9rgJUMFnyag0l3h
 QRLNtNzzAb3G22kDT4MsKnEIgv6iL0HRxMTrUpeIN+0NVb+ytrGJkT6dBMTpkG6AvuVzrcPbC
 eoxN8YSOi2i85W5PGRMIRqrXdnyIAUhcPJaLqtv5VdzvLIiZ8LLA1P+wIYCB4oKQlokbC6t4q
 rCRFcWHlrtqG/BSV0x8T22uQ/45il6Zd6RIh39gpkemqVYhUQqK0B/lRP17F4TXgy8GRIwubJ
 1EDyINszy4tL0RsOPoaMAhswOWzXBuSCCJ4s6zcCam7Sa1DtdTt9XbgWOHylbzY2RiGOJn88s
 V1TFyeveMHqsXQKX+33z8hsDrWxGv1XDQaFcG+L30w0FpsF0HUG8coAOxpDnoSJQItsnKulmE
 yrK/P/R1mH/L5XltZwvaAb4FwiqECWZA8A2hFnpWL4FUQOtv6P0wcHyCLJ+MFYE6iXKHJyf9h
 196aoEMuEW/SIRiOmbtVtTE/Y4MdD4AepueHwfUp5I3iVKjFv2VhA/RF7/VnOyokiJ1fdPb58
 dYLlnPkKnR7Kw9rsYnpFY5vYfOmBkFniMjw67fDC8ef8YMxCcXW1sJwJ9/GdP8B7Uh9aTUjTF
 S7620fVmQuya59xQytNt3q+b0l6wk/nExwG51HKgA6rPTD7380qocsHywtHteWjG8qzB5QnHE
 VuK6npetpjwlruWxG5q23lfE/FOfVBXfz/vmW70coY5NNCKahP562Ce5DzbXCcWdxKWrgUeh7
 7qkoi7BcI6Aqjyu6CF/JH20pOqZSZnjRCHzQLQ741EOaa47xsZKVz14nnP75lEJgYFY7HggCO
 BW8lpVXSGn9RklMpG8ulFUqsMvcefUJVTHHSX9fq9PhK9N+dH2awdFXvA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/21 04:21, Johannes Kastl wrote:
> Hello Qu,
>
> On 20.05.22 at 17:14 Johannes Kastl wrote:
>
>> I am trying to build this and will test it, hopefully tomorrow. I'll
>> let you know what happens...
>
> I was able to build an RPM for Leap 15.3, based on your branch.
>
>> https://build.opensuse.org/project/show/home:ojkastl_buildservice:btrfs=
_debugging
>>
>
> I installed it on my Leap 15.3 system, started the fix-device-size
> and... after only a couple of seconds it was done.
>
> No errors, just one line saying that it fixed something.
>
> I could mount the filesystem directly afterwards.

Great to know that.

>
> I unmounted and am currently running a btrfscheck on the filesystem,
> based on the code from your branch. I hope the filesystem is working
> again, and I can start using it again (tomorrow, the check will take ~8
> hours)...

Hope no error from btrfsck.

>
> I doubt that this will give valuable input to fix this error in
> btrfsprogs...

At least we know the new way to fix it is working.

BTW, mind to share things like `btrfs fi usage` and `btrfs fi df` when
you can mount the fs?

Thanks,
Qu
>
> Kind Regards,
> Johannes
>
