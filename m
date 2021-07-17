Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A693CC06D
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 03:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGQBC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 21:02:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:44797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhGQBC6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 21:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626483600;
        bh=xjCpgmbh06P1JxGIzfNsARINXnpvuWYKA3rBCpamiOI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ibDaskID+9EEuAYcnNl70xwi674vouIK3WKyJl/RbU4l03RcXNoMRVGILKx445rqC
         c13mWZwYFiFOdDJbUcfY//xAkWDqlY2K39AS68DCeGr2ah2AmUMha+wrn9Z8FXsc8k
         e8ML7psEF5ZobaD36lJhXWR94TA4C/VetYaT1ITk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1lUwgP1Ro2-00Zyub; Sat, 17
 Jul 2021 03:00:00 +0200
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Dave T <davestechshop@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
 <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
 <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
 <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
 <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com>
 <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
 <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com>
 <CAGdWbB7XqoJaVsdbG7VkvSj78hVPt-HnZxOw_nvX7GaTziaiwg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <062c20ad-ea9f-f83f-ce49-0a82668c3c6c@gmx.com>
Date:   Sat, 17 Jul 2021 08:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB7XqoJaVsdbG7VkvSj78hVPt-HnZxOw_nvX7GaTziaiwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qjEh26riptHxFDov2NEchBi+YKVhtcswDmkbvE21rQ5rCM3Uxlt
 lljxX1mw82R04/nU9QXWR/czX+rFZUmNapSfW4Ws5dq3IX9nFX6WbfjVy62zDFl2oC/fZKo
 qg/MkOHCQK2DeRtoj5G/3nYINRqv1RNiBiANqiFuza1zFvA6E8HktMtNlotrYzSm7MM7PHc
 YDRuMidAhva2v3eDFldQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yWgkrvVlSCU=:V1AmAdBcLOUyGsoLxvIXj9
 9oiIY8fk00DGFYuoT4gsxNb0ySofZiY4JVQmmbr+IPuxM49iRFDKd64Dko67dWykN4QWH9yZv
 mhYh2mkvUp4quoj14C2bGK6eZEBiqpkVrZ7pvZsXTUFOGrwTHN9s4bKb247LDY0ii1knxrjlA
 3qZfQ8m4AV1dhaxzkOvm+cqe36K8JAAIhyjRdBMrGAjNYwuQpasQPsGXsZ6St+P8wUdmKeyx7
 OOXu0+/he/Bu4S/7NL4rLhpXW+x3iwKCanw9BaW5YyXXPkaGRc1E6pjL4Dyb3VqSnH+O4OkTa
 XeqtrmIMsllS0OYTGS8eLafaBwRf58E6N/o12uAfeDICO0ypU7kidRIpx0KVLn8i1MmN+GRDG
 bCImH9YIJZc+6EZs+KIqH4qfoaU0mZAlxsxBUfy2W27hjAi5PARf04HLzuP98f7T+qWg6idyF
 DRPAMlXcN25AKyw0k4RwnMwPS0JmVwROcf+vs9EhxBGDrwBsI2kjKDmQPV2Le8fAr3csR4mU+
 QLV4l4G6jm0w9sgGsQ+lIiOhCCmfVk4MvQK5kc9eIgd7kx/ZbK6rH6NxCaZ/XAcghMACMre5r
 sZ2QnJ2HKhRJ4csPnNozzDcHFSRch0s6E95x++tcSeLNPMXCFBppKfTmHIBmhJYbswfUDliaP
 aZPMkmOIvcm9ZSy1JtOA3N2Ym3OCyJqQrJktJW9Q+E3hmBRrKxI1NzbVNPNq9mvziR/2IN2Kx
 Hxm6gRmAqYx9zH+S1QwTMzOuaDGqpG/JgBDXnriCfvxpHReCK1I5Voj/pZ6Vw/Wa64e2TZB8r
 j/BkhSgwx5iYtLYqYAyS8dAJo60AAt/OKJLyeAfdNESgcuVZ4iSQ+GRomx8dGcLogwFPCPRjG
 NPA1D/DIgW+CcJJiHBqxVBwtkk8p+IT8cwIgtwU+De7beyo22awPh1w3fx6hi1StyFORiOfV1
 ZWSFH600+F6OvAAP3uy6KUWb1EvkOp5xev6304oxIk98sjTBJBS/KA2FLo/3/lgadB1gRrwfG
 AIhU6Hpb6OSWquBYXGnJOayC2efTO2yLnafN1icLmLoi1PMx3tHhhMvOhRObGaP5E2g58XnIo
 e3tfoUbkWOzk4G9jRP9+HtBB+r98U30Hg3ynGmppD89ZGgNxrQzlw0B5Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8A=E5=8D=888:57, Dave T wrote:
>> But before that, would you mind to run "btrfs check" again on the fs to
>> see if it reports any error?
>
>> I'm interested to see the result though.
>
> First I will send you the full output of the command I ran:
> btrfs check --repair --init-csum-tree /dev/mapper/xyz
> It's a lot of output - around 50MB before I zip it up.
> How about if I send that to you as an attachment and mail it directly
> to you, not the list?

It works for me either way.

>
> Next step: I have remounted the old fs and I'm going to run a scrub on i=
t.

Scrub shouldn't detect much thing else, but it won't hurt anyway.

>
> Then I will unmount it and run btrfs check again and send you the
> output. Again, I'll send it to you privately, OK?
>

That's fine to me.

THanks,
Qu
