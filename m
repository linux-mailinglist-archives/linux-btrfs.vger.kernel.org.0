Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBC43057E
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Oct 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhJPW5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 18:57:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:35101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236447AbhJPW5g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634424914;
        bh=HnXGAfHCS0MWZ/BykqTwVV+oMydC0CLdpYXPLfKZrlk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DVulnw7nqnJW4MQj/gwBGCNlmuMM9fbg2oMeiDoRa6FuDNEOC+R7KXaD2JryNjlb1
         iDSV/mgMvZ0dtcpupDOevdB0N49tVpF4/IUzQyI839j34fOGb958RgG9Y2guEJvUXQ
         kPliQW8zC4SAzMLeVmyNqHt1jsAvW6kESWJfRr0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1n1d1m2WkF-00j0t6; Sun, 17
 Oct 2021 00:55:14 +0200
Message-ID: <cc66315b-4c14-efb6-083d-cfa73fcc81d0@gmx.com>
Date:   Sun, 17 Oct 2021 06:55:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: need help in a broken 2TB BTRFS partition
Content-Language: en-US
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
 <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
 <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
 <867E9DE5-055F-4385-822F-6EA83A6E8914@icloud.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <867E9DE5-055F-4385-822F-6EA83A6E8914@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wqv0Jz3syia/duvP9Z7+Kq9e33JglR2mri8Mia7xaDJrv6y1TzD
 saJEqTWx6tbA0/bvnZpuForBjB2o15muptUM904YTfIc4TXLStM9gVHoXlaoP0Viu6Er3hQ
 cybNzQkF5sAa/KEK6L8CUyMqvXlqIlf9VCkwCsQ56cNWhgnZi7vhDbo3k45x7nsmMS1uP8A
 GZRmuZHzscr2ljAVzZJgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0b6yZP9+KJI=:0D6PzjDhJbiYPUi9t3hyIt
 tiaKeEJ0pK4UrzZdqi90n8Nlzt04VxwBeu/TvvpFZrhx/fdTiz3ZOpzSbpKSt+gQLSGRR1dML
 7y0iFR2Vdqu+9PSiRjFpR2P0s2nzZp3FSdayFNXUeSCsMgOWIr+6f9uZYRgF/XfqUyrylEidA
 9PxBRyAw2CKH2y2c/muvwnhSJEuvrDXyb4yKV1WDDpqgM6Cg0IyhTgA+cfQhvotJvZ0KjxL0T
 Bk9sIuC8EnRj9AuBvSN9nrZEdPz3U0IRwVWiGfodgIqPMATfkyp9+DhyJYFEqkEjNd0nijcjW
 2BvY+7H55HooyMKU0osFHP6B1jLV7jhb05Ub+sJUNHsdJ1CztUBo3q9J8gA6yjLPgflWRQcY7
 aBjgMjuA6LjWvZ+dTLldPS3Jm+awqwHGJoU96OlNp2lAUrk8FmJl6ti1Ph+KYeJe7Nw155DfP
 ntx0IRMiJQySBSyRhpp+2lz8uPbFbAXzoJN/2i7j8wqaMt4jjJoyCFlnhCc8f87SQPUTh8pSv
 mTIX06PfWd5LGB9w8cL1Dd4Svno3+7Wggsry18kEKQsqKeqxV7Fs7l6TSLRFksDYl+Q+3TxG4
 ebUglteljOSaRWHxD/ulsuJH0WgXKdHSSbgnBSUoLN8vZuDEgU5YkXZP4QrH/yFGTkBE6/BAN
 /zcVVz2G2/Lz9ZundBuRk3sTRHLgpJDoVzRDPg/VVzk2MQyvk9Jz0IeC+PH5lzFQWDJhj+rA2
 KZKpqbeBKw3S5Oi4K9pVygs477m1hLeZ9D4nzbfr+3o8JT1XJVLMYzHYEPMuc4Um2VBhB+DdM
 nBz39hMBf3znZLT2XK9NNvG7wJ6IkMGECEvB03pBU3Dnj/hmvJ/s3UrcCvZ9w+7JTpeuAXl4B
 etff9GhUnOKC/huTazy2Td+u6kE/VZAel8M1qu4jJikReLqtB/g0idBorD0pC0t3cHiGTSbdF
 SCX7XExF+15wbqq3xjkRqs7RAWivsHZYRFIpL3BeZvOqXA/Urdou34wMMcnHwiFewX0l8ANv6
 /z/WSTqxme/WEhaaOfmLtCi7o5CGgg3+X2GArgQuwWHUx+5WyLGtaJ+PkDFzVCkckD1Xx1o79
 Hu/JeC9Le5VTXw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/17 01:29, Christian Wimmer wrote:
>>>
>>> I already run the command btrfs restore /dev/sdd1 . and could restore =
90% of the data but not the important last 10%.
>>
>> Using newer kernel like v5.14, you can using "-o ro,rescue=3Dall" mount
>> option, which would act mostly like btrfs-restore, and you may have a
>> chance to recover the lost 10%.
>
> Very nice! I updated to 5.14 and mounted with "-o ro,rescue=3Dall=E2=80=
=9D and yes, I can see all data now.
> I guess this is just for data recovery, not a permanent mount option, ri=
ght?
> I should rescue the data and format the disc again, right?

Yes, that's just to rescue.

Thanks,
Qu
>
>>
>>>
>>> My system is:
>>>
>>> Suse Tumbleweed inside Parallels Desktop on a Mac Mini
>>>
>>> Mac Min: Big Sur
>>> Parallels Desktop: 17.1.0
>>> Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 03:36:0=
2 UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Suse_Tumbleweed:~ # btrfs --version
>>> btrfs-progs v5.13
>>>
>>> The disk /dev/sdd1 is one of several 2TB partitions that reside on a N=
AS attached to the Mac Mini like
>>
>> /dev/sdd1 is directly mapped into the VM or something else?
>>
>> Or a file in remote filesystem (like NFS) then mapped into the VM?
>
> It is a file on a SAS External Physical Volume that is formatted in Mac =
OS Extended and attached to the Parallels as an additional disc, then form=
atted inside linux with btrfs
>
>
> BTW, I think now I know exactly what I did wrong to get to this stage.
> I suspended my Virtual Machine with all discs still mounted. Then I star=
ted a new Virtual machine with the same discs attached and  this confused =
the discs.
> Should avoid this.
>
