Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7938632FB36
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCFOgd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 6 Mar 2021 09:36:33 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhCFOg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Mar 2021 09:36:28 -0500
Received: from [192.168.177.84] ([91.56.91.134]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6DSi-1lP8gh0PVo-006bT6; Sat, 06 Mar 2021 15:36:23 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Nikolay Borisov" <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re[2]: Code: Bad RIP value.
Date:   Sat, 06 Mar 2021 11:08:13 +0000
Message-Id: <em4b352a73-75c2-4585-b9b3-b01e60818736@desktop-g0r648m>
In-Reply-To: <55d67e6d-c971-b156-ae38-533d03912204@suse.com>
References: <em7cd07db3-30ce-479c-8c6b-063af06a2e69@desktop-g0r648m>
 <55d67e6d-c971-b156-ae38-533d03912204@suse.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1054.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:dnXBjBXe9j/WMMPClynZlwfwRoLO5V5tYlg/3L+AvBZQyCNCZ0y
 UzGqMkMc8W2hRSl5KYLdwbmZuIdBq39p7V7+RM0r9GiNIFxidGgk16onRuyMWp6tL4Fpo8v
 wOtT9wm3A9GXbdZ917uSivJmJUivSdU7B+S19hww9a5PlM8kOvFCjwQ2eO5eFn6C+BYNVCq
 S1EEhgJAOJ2PwIkxnUU3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oi74h1i7RWA=:2RR2cs/0Pvp8+1tdhmMBjq
 My6vhEtLGeoTg6G2rdQa8Q6e4tJRVIprgbmLWQ6rPxVhthK9uvanhnrmecRp7b0bwFcz/T5An
 8+b03wJCOHUUcMOhz8MSUdUm7/uqF6zp7N36jMjtuNQltip/1TYrDxifyjPvKvFJ1p6ggAtn8
 4hpUMuBx1lom0JrNhwXiVq8nI1fBTiyYqd0qSAeHrs+XPOT0HhwIwo8B7eWaA5hcgJquPruDg
 j+gOsdkbmPRgigA1NY3uFFDglUsjbznRNJAf6ok1U1dolfvJPhWesYUhbmxhaybv48cSmHuOG
 QU5ofjbxrnzHZtlTsxR3jpfheY5mvx9m0tHmiq1T4EFc6RccnK0WFeDUYKxwCYto0SydmKqnX
 hjA/JxQoKugYqoQV/cSpo9jNtlIm08wW05RRCAwKnIme7aN1hIOUAfXpcaq/tpd1cs56Mx3qB
 zwy/rB2MXA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Nikolay,

thank you.

echo w > /proc/sysrq-trigger

I assume, I need to do that soon after the problem occured? Is there a 
way to automate it? Otherwise, I will most likely only notice days after 
the occurence.

Regarding the Kernel Version:
I am using Debian, which usually delivers rather old kernels -but of 
course possibly with backports of bug-fixes.
I am not sure, what the better option is:
1) to use the Kernel, Debian delivers
2) to build the latest Kernel every 3-6 months
3) to build the latest stable kernels

any advice welcome!

Regards,
Hendrik

------ Originalnachricht ------
Von: "Nikolay Borisov" <nborisov@suse.com>
An: "Hendrik Friedel" <hendrik@friedels.name>; 
linux-btrfs@vger.kernel.org
Gesendet: 06.03.2021 09:00:30
Betreff: Re: Code: Bad RIP value.

>
>
>On 5.03.21 г. 21:57 ч., Hendrik Friedel wrote:
>>  Hello,
>>
>>  I am using linux 5.9.1 and have experienced tracebacks in conjunction
>>  with btrfs and several filesystems:
>>  btrfs fi show
>>  Label: 'Daten'  uuid: c217331c-cf0c-49ae-86c7-48a67d1c346b
>>          Total devices 1 FS bytes used 54.69GiB
>>          devid    1 size 81.79GiB used 57.02GiB path /dev/sde2
>>
>>  Label: 'DockerImages'  uuid: 9b327a02-606e-4f2d-a137-27f53a5bcb03
>>          Total devices 1 FS bytes used 19.36GiB
>>          devid    1 size 29.62GiB used 19.52GiB path /dev/sdd2
>>
>>  Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>          Total devices 2 FS bytes used 6.87TiB
>>          devid    1 size 7.28TiB used 6.92TiB path /dev/sda1
>>          devid    2 size 7.28TiB used 6.92TiB path /dev/sdi1
>>
>>  I have this bug several times now:
>>
>
>This is not a bug per-se. It tells you that those 2 processes have been
>blocked for more than 2 minutes. Are you using qgroups? 5.9 is not a
>stable kernel so you are not going to receive updates for bugs which
>might be fixed/backported to stable kernels/upstream releases. 5.9.1 is
>not even the latest version for 5.9 branch. Next time this issue appears
>show us the output of :
>
>echo w > /proc/sysrq-trigger

