Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97758E751
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiHJG36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHJG34 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 02:29:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB26D9E4
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660112978;
        bh=AOrNm3rkk4lryCn+zUF2IW+dr9P19XTE6T2ixBVQ7PI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=l79Z1DUufcePalV+dJF42l/DdUCrCS/de3SQxNT9LuYC6E/RB5scoYk120OK2EVw4
         P3okUf8cJc2c85Xf/wRREekMLCpSSkVPm/82k1VKt3FS5raWG2VJb4noyva4/B9HEP
         0kQFk4q+L9X4TzeCEXsBRZkMs3s/E+XFxyowDXZM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRR0-1nyXm92bnA-00Tm3k; Wed, 10
 Aug 2022 08:29:38 +0200
Message-ID: <3c47ebef-a76c-3206-7954-42c6de557efa@gmx.com>
Date:   Wed, 10 Aug 2022 14:29:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
 <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
 <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
 <6ab45148-cf37-43cc-1bd0-809af792e24a@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6ab45148-cf37-43cc-1bd0-809af792e24a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zNb68EqJ1H8+6HZdwwlg3Ug5obVGHwhSI6gP/dAlsq6l5rHtKg4
 jCEfHthg5n8b1nw9H3KHTyMJz8FStGuZT+MPHUpQuHIpilq2+vIooZziH05am3aPaTv1Ona
 RETy3Nofh7qGVnOznTJG4v8HWFiZHf94ar1HzD5EcZu60ekbmJn5C+vSDjQRnQnSpJkgdaT
 dxk8/kOEjkaxtaDtdhwRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRAoL/h6EzE=:JDSTdHAO/KVU/sYTkLVaSo
 9jBWAlCKyzl8+WMUlnsdKwIidrYdzm7kvF7Z8iiIr7aEjzNcF1iAB/hapLzFkma8QZ5v/oSFB
 sLjL5x4mqtginEGNZgfFFCfOQ4CFdtLnwrLf/x6iwD49b9n2/gzbkAee+E04Oy3lCyKwlbXnL
 q1b+xh2JxzheWlxEoNGrde2JQKfMKWmD/ogUjyNP5vyZVDMQD0w3TZB7SV3rHxd9yI0ur8aE4
 TRtClkcS8ruuc7RNCIXu+4F6+Tj/MFvaIzZrKx338VvOzgmXJypLMIeGB6N8PB9ev4Z4agQU8
 ZkRWQ7zQWANbL089OUGODQYchokWXTMz+dNdpMlHphym90ZLC4SpXfCysjR9qdB1hQPNggpOS
 irMD1CnkAzgDjtjPmLi+O8ZL78TuOOoG/+0GEd5pixtL2+WrWvCjAylr8+gBfBd+hnPP594oG
 TAwWS4aTrnGw1A9O0Ke38nLTaHV9XML6Y1DClvaYrASV8QqjzN38Kscw2hAdBoqeCgkWRx+YU
 vPHmtxlcBHWnNsgtYZYJ63EjQL3GDiU3dDrDMznUObIyndQYIuJRJfDQA7POwnVxSQoUaCVxR
 Sl5KNfreIg4qfegSDwaq85nucWJI7pmyLovYJToXBG0oQ4NyneTNiVSKXfXD8k3pyVp2/gMWi
 5wZ4SbMBuERpAuN+581EXNi65PIFCjJJ0Z1ZAZBNtHJiU9+BJk19sFIEhiqICkL9eAokneX2m
 zF02gJggt8x6GNedY0qeyP+diQc7t1db/IejcEEpmMr+/oraXPj2CETfJEo7HpowrfV8irRnO
 qWPj5RTkHolmaIrR9vSRjWBHIriAq5NY5yKR2EG6q4p8bGwuxoRr2EXLs8liZkIowLDxM0YYO
 nWN9ite8Z+wl111XH+R3pxuNtAJ9rCzHesTyxK0Pt7ybxLs4qd4FGyNHeCmzZk+Y44uj8lTJd
 2uz/ThE/7tV8ZCrvwEP0gslJVAyY33WZeKXQI7xvbtEAo2wb7JiMDHpv5XKhzm1vhBMpGjpsN
 w78pZqQ+6Fd5agUIEKI0+rCDsTXFUzGYiESdvYQjV8kNUsIvHqv1OAzjZ33lsdUOZjXkLNBp4
 3vyidrTRimWCK6jHR3snsZarq4a1l4rNYUpNYo7kg8mAl3hV/O2pSSJZQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 14:10, Andrei Borzenkov wrote:
> On 09.08.2022 14:37, Qu Wenruo wrote:
> ...
>>>
>>> I think what happened is having had mounted the FS twice by accident:
>>> The former system (Mint 19.3/ext4) has been cloned to a USB-stick whic=
h
>>> I can boot from.
>>> In one such session I mounted the new btrfs nvme on the old system for
>>> some data exchange.
>>> I put the old system to hibernation but forgot to unmount the nvme pri=
or
>>> to that. :(
>>
>> Hibernation, I'm not sure about the details, but it looks like there
>> were some corruption reports related to that.
>>
>>>
>>> So when booting up the new system from the nvme it was like having had=
 a
>>> hard shutdown.
>>
>> A hard shutdown to btrfs itself should not cause anything wrong, that's
>> ensured by its mandatory metadata COW.
>>
>>> So that in itself wouldn't be the problem, I'd think.
>>> But the other day I again booted from the old system from its
>>> hibernation with the forgotten nvme mounted.
>>
>> Oh I got it now, it's not after the hibernation immediately, but the
>> resume from hibernation, and then some write into the already
>> out-of-sync fs caused the problem.
>>
>>> And that was the killer, I'd say, since a lot of metadata has changed =
on
>>> that btrfs meanwhile.
>>
>> Yes, I believe that's the case.
>>
> ...
>>
>> Personally speaking, I never trust hibernation/suspension, although due
>> to other ACPI related reasons.
>> Now I won't even touch hibernation/suspension at all, just to avoid any
>> removable storage corruption.
>>
>
> I wonder if it is possible to add resume hook to check that on-disk
> state matches in-memory state and go read-only if on-disk state changed.

AFAIK what we should do is, using hooks to unmount all removable disks,
before entering suspension/hibernation.

> Checking current generation should be enough to detect it?

IMHO fs doesn't really have any way to know we're going into
hibernation/suspension.

If we have such mechanism, then yes it's possible.

Thanks,
Qu
