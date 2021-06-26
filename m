Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEF3B4D0F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 08:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFZG1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 02:27:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:47045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFZG1S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 02:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624688690;
        bh=WpUaE1K9ieT2+Ir50pGqVc/ZzWuD6oiwWxsdt695fyE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UWizgihgyPvxrdXgFUXBa/gPBSvz9ArX2oiyjbF7/3PXRxk4h1UcWv0RXacUHN4fL
         3JPkzvi2i0n//sTyEHjJgp3MqDhqTuMFG9mYHuhqktxtaDRFGTJR644HCszWd+cQqp
         t0RpmBv2LgtnCYqipHeuTZp6GscW1bzmjuhJn3kA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9gE-1m2Ze10wxA-00Gbd9; Sat, 26
 Jun 2021 08:24:49 +0200
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search
 Baloo
To:     Andrei Borzenkov <arvidjaar@gmail.com>, NeilBrown <neilb@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <41661070.mPYKQbcTYQ@ananda>
 <162466884942.28671.6997551060359774034@noble.neil.brown.name>
 <ec60fd7f-7020-5168-81f1-809da73763f3@acm.org>
 <162468466604.26869.10474422208964999454@noble.neil.brown.name>
 <7d12d49d-1dbf-566e-cb92-84e68ab67e23@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f71ea06f-0282-dd5d-21f2-f5cf3c46d6ad@gmx.com>
Date:   Sat, 26 Jun 2021 14:24:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7d12d49d-1dbf-566e-cb92-84e68ab67e23@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QK0jJrrTr7DhzrTvp5CNNBCNhsn1WIZieTiCiIcMslC2B71tKUq
 D/c1QeamRhMsaZN3LprD1cnZ2Omlc4D6iHtSOuk9hNeH1GIOZ0T0LqG4+FkFBS6Fnv4KCNj
 CmdnPPCtCrId0Ot4ed8NQCzq4T93bEfEascJ0pmSebMP2h6uSONXUCkoUamkGWXTcRamF3P
 RHvHHSxPIGpbXodLKs1OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lUU+aP0aCOE=:W5YkZSMVUOhV32Fxh/JOHJ
 tDLWRwPcbQOhXARJxEEeSH+N5Yv47IJd279Q5rqtAWppq4N5lj5mYra7CGAFglBqBeJ+/EqXn
 xfVtjgWjOGpxT0KE6O15+qUqvTb+qFnlHnLofDT33/THJi1tcNfXbpK2NJBEQDBJOrLcemNbf
 OH1v1jbZip7ZR/exF6suWuPeQsb7PQ/Y9HNwpChXqkc2Cr/j4ha2ddsutYCuVIIvjMEVfCWaS
 OHSp3VNXimiijYCvE+MLdlV/ac294SRKVfcFPD+ny7f7U3c8BUeN+kXuLFvvsKkdDQXrfw3t3
 6pC4h5pJAuyVFINBUGgv1fB3tsgvKsuj+vCYnNbrng1t5if+jV2efN94OElpQcA5+ynD56ezY
 F6uif3GsL1XID/Sn6yj7SCBVxUNoWbW8p/oiX8HgLjE6xxscTbWdOXcUlfLpnhM7eHkdCvGxQ
 yY8ZgwdV1yikL9zSVu9sEU9CANhWVJu9zFegQlD4PtNMjlV2x9/LjS7nwRH4u3DYcTJ0weqFJ
 vBSAETyALSn1zZPHhAeSdEHX0qNjHgvttJUe8YTpXXmwMoG1Y9IQbGPCp7RM22tNuFGCq0yrq
 xlnNcWa81UJgfKKXsM56FvVl5HmfIigTzPZOKOIzdiv2oXnW7moH4AlULUijPIfUO7H/dMa6j
 qi+7Taq7kaA6gPLokG3kv+9iMe1KVqKQkkCli4q77R/1OUhDSc3fsrq92UsxmVHe+FaJlv86Q
 XQMoHRs09+F7mLeZzFYZVCmVYZDiPV8vE7BnV9Wi3iNj2+M7Qg5L+ObD23GaBR/unN0iiCn7J
 LEX2gmhA6JgB33+mj0E5T1EQVtR/rHeyyDNdOXLX2rkzGVLzkgMA8AxSD74iRFn2Cvuq1RXHz
 W7JOIPI0s2Uif7AAT6WkjQEJaYGhkZkptmhEWKTurL8waowvCjbHDWSHDYDmRkBnE9i0Ii1XL
 T8tgImmsLPptO+5Wmb0tBiAOM2fatOmUZDyUvbnfhou4DyicmjW33m0C7UXpzdanTeFGSmPbq
 NqFnZP6Jh7s7ER5nHfyZAYZL/pgTWXDaAV4E2d3t1V3VTU82BopM51AyyPEZN+MltQ8+DG1Lk
 LkG6FuhH1u4f+1y/nwRPvTmBu4CQymFHZq4ZhfxoXzMWSuLpHwSnhKRcA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/26 =E4=B8=8B=E5=8D=882:14, Andrei Borzenkov wrote:
> On 26.06.2021 08:17, NeilBrown wrote:
>> On Sat, 26 Jun 2021, Bart Van Assche wrote:
>>> On 6/25/21 5:54 PM, NeilBrown wrote:
>>>> On Sat, 26 Jun 2021, Martin Steigerwald wrote:
>>>>>                                   And that Baloo needs an "invariant=
" for
>>>>> a file. See comment #11 of that bug report:
>>>>
>>>> That is really hard to provide in general.  Possibly the best approac=
h
>>>> is to use the statfs() systemcall to get the "f_fsid" field.  This is
>>>> 64bits.  It is not supported uniformly well by all filesystems, but I
>>>> think it is at least not worse than using the device number.  For a l=
ot
>>>> of older filesystems it is just an encoding of the device number.
>>>>
>>>> For btrfs, xfs, ext4 it is much much better.
>>>
>>> How about combining the UUID of the partition with the file path? An
>>> example from one of the VMs on my workstation:
>>
>> A btrfs filesystem can span multiple partitions, and those partitions
>> can be added and removed dynamically.  So you could migrated from one t=
o
>> another.
>>
>
> I suspect it was intended to be "filesytemm UUID". At least that is the
> field in lsblk output that was referenced.

Filesystem UUID is not enough.

In btrfs, all subvolumes share the same fsid.

While for statfs() call, we do extra XOR with subvolume id to generate
unique f_fsid for each subvolume.

Thanks,
Qu
>
>> f_fsid really is best for any modern filesystem.
>>
>> NeilBrown
>>
>
