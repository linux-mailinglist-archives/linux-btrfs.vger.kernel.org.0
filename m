Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB34830C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiACL5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:57:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:36541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbiACL5r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jan 2022 06:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641211063;
        bh=sygVF50g4JngWa9+DB9XYy8E6cW0RE+EU8fvCf3C6Ek=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FmIsiG+9Fx3wit9tfdamnsbnTP28sMas0mrIUyaBGJ3bsI889JXfVFqVtLHamd2fF
         mrTA1O/8ECXogYufnuUaA1HKsJiPvMozz3wqHLp+2UDAhcICxjKl7a+OGkkELjvE+d
         3Oi1/QNRotIu4RqNCnay5f2mqVn50SeMYaLXwWP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1mQdQk0iae-00dpTd; Mon, 03
 Jan 2022 12:57:43 +0100
Message-ID: <409d6824-bf81-111e-286d-e004025b25c2@gmx.com>
Date:   Mon, 3 Jan 2022 19:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: "hardware-assisted zeroing"
Content-Language: en-US
To:     David Disseldorp <ddiss@suse.de>, Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <20220103124607.524882f8@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220103124607.524882f8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aqhCww8ejgNf0lpgzWJfU3L9ycnBnEii7sdnYBME5sbDoSatWmt
 vt6L/yvb1dvk2WWyga1LqWV2CHMZ4LZKQfb8HDTWOBt1AhHzjIABCZCAMo2SneLIW2zrZJS
 1/vNv9zIlWfsLqV4+bXvpoHPevhf+L8nVy/XImafdbvCyZGasHaNujx3NhZvNaPVotZ3oqz
 gRQm5uB+k33hV2j5PSbPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L+viYXYRgV0=:QIwvkSHtJVjWyFQdi8rGYH
 EIYYRBeRoZ7rO/8blyIJEsV3n8o+44zDgoPTuFru5lT3GK/wDUt3D1uwu4dpRFvpOfUCzNUR7
 E9AwivOXSBLtc9I7F7wmfI1dFWNrymt6a5MrC55p1zyTHG66zdabIELgZz1SzlPUqhobRotM1
 Zhm6url5Q6mnSK8PVxNUargeP/68jffHeBgwhr385G+pzSqX5oe0R87XhpAwjnx6/+tOItRGo
 9XePALUQEq+FGJ96BSJp/w7M/3d54yY1R0Y5BkNoDzBnibZZ7gwkbXiafqub8WisR6FnQ37x9
 44D1hUkKRKDyHeephX9nbB3aESFJpUotv0/Fp86tpJ1W0OE9LKCUvG+/UxtVLiBDyTQLdks3h
 4NWo8lryaZbUQcmONZE4Wo0mP3WSXvmX4SAdyvueeVA+qTBEiCDOljYHJsAS8TPkjAkIfeTGK
 VieWqglT8pu71l3R0WRsHuF4clYGnMKxMrTY8kdQaYtKPWLhHkyvdF9srwktjfAuDQXZZHQIk
 4cWOAFdWZIx4XrltwUNhpuyw7XcIvVTmmbDRE2/BF4p+C7EF8FJsp/oYTOxYGOUZ5dYNw1qf8
 v5EdYQV7G7f5MXsFRPs0ABjOjUeeyuZb7TOIySbH5+rYaVoLL8pE0jxsjnMJldB5eU2PdCKHk
 pDVKlkmB/+nAQL2YuPJ708r9sPXMCftvQlC/fZTMFg3y8Eqv5tLv+x9nL1mTGMMn2p58gty1o
 Uh+Vqdy/TEWdoly4JpKTcFdp9FIhqyxIqBoCJj4zt7DHL5+WuuFsCFPUiETrB4vrb+fxw0Syv
 9kUuhiaIhy3KsImp/3AYruEdCvecrg3MTuJnYj6AgSi4L2yeYh4ZPEzUL3/HsitDbg2zU3Seh
 xp848qgCQTmLQZ93gPeF9bTzgU2vPhzDrlxhK7keZ4gj4+OHSBOK86blQHKT427RcV5omRqme
 aa7EJpSRmxaqyNL9KpSv1CigGSNGrx70ojuTC+AI9OX2cvLlOl/lLLGBcYQ+EsEBeTh0HgvMb
 Qy/NNb1E3Zwn3BaUN0Kgv4g83cV/93mobwG50G/XqkGjpBfKCvPhr9w7JJeMa1THGS5f8Ra6m
 VPtkjCbq8J/qPc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/3 19:46, David Disseldorp wrote:
> On Mon, 03 Jan 2022 06:08:46 -0500, Eric Levy wrote:
>
>> I am operating a Btrfs file system on logical volumes provided through
>> an iSCSI target. The software managing the volumes shows that they are
>> configured for certain features, which include "hardware-assisted
>> zeroing" and "space reclamation". Presumably the meaning of these
>> features, at least the former, is that a file system, with support of
>> the kernel, may issue a SCSI command indicating that a region of a
>> block device would be cleared. For a file system, such an operation has
>> no direct value, because the contents of de-allocated space is
>> irrelevant, but for a logical volume, it creates an opportunity to free
>> space on the underlying file system on the back end.
>>
>> I have searched the term "hardware-assisted zeroing", without finding
>> any useful resources on the application of the term.
>
> "hardware-assisted zeroing" is often marketing speak for the WRITE SAME
> SCSI command, which is used by VMFS. I'm not aware of any Linux
> filesystems which make use of it.

Thanks for pointing this out, really not familiar with WRITE SAME command.

After some quick search, it looks like it's kinda of hole punching for
SCSI command set.

Then I guess that explains why Linux filesystems don't really make use
of it.

If we want a large zeroed file, both hole punching and fallocate will be
faster, and we don't need to issue any data IO.
All data read will be zeroed at read time. No IO is always faster than
any IO, even if it's "hardware-assisted".

Thanks,
Qu
>
> As Qu mentioned, "space reclamation" would refer to UNMAP / discard.
>
> Cheers, David
