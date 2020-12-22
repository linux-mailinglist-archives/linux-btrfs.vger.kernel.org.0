Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3982E05CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 06:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVFjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 00:39:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:57441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLVFjP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 00:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608615460;
        bh=bdBzD63U/+T2y+Vwh0HVTlZlVnaJhhYCBSOLzp98VWI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PYavKOM5YApPxun69p0K3h4eTYG7dND0xXDUZjRBhLSwzoho7N+xbNobz4qX0+xzj
         SdydFtdZrlvQScIrCueddeh3YaxEJDvTIBU0k/I9JDijCK7LXVv+PoZgh0HjWlpiIK
         bRwFeqOup6G02fwxjD6UvCZ3/RjZPziVzSBKIimw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1kNUPf3wur-00f9um; Tue, 22
 Dec 2020 06:37:40 +0100
Subject: Re: [PATCH 0/2] btrfs: btrfs_dec_test_*_ordered_extent() refactor
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201218051701.62262-1-wqu@suse.com>
 <20201218155755.GB6430@twin.jikos.cz>
 <a612e52b-9c1d-880d-0056-762bbdac60ce@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <adc81f87-58e2-7a63-d697-a789708a26ad@gmx.com>
Date:   Tue, 22 Dec 2020 13:37:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <a612e52b-9c1d-880d-0056-762bbdac60ce@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CYbMbezensHQAvCQEOQ5elSHZC7s7keZxUYJYcEIhQOm9Clc6fK
 PcF3Q1w+N8AWW6JmxLmD9poctV3r0J2ffRWRwAzj+froxUTyUUqMDeC8vkIGBTEie6Sy/dY
 GH4WhZBLFlWd672OtFuvMASHHG+G/lhqXig+xY/o6oZKtLVsk+WeQC5AjhITYrFS8j6rWkZ
 i5J1Cl9jRObTs19PQcu/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Xx5FYeXw4w=:t38pcmDDaoASYpXiQ0Z2tN
 CvA8sj2/BqemFDqhf6bCZarKUQyQhEOTOG/LdEeAbj3ZSJ2J1ohQnP6rsoias6OqDyVpfFZlt
 TrKivZJz7bZBIBDSz1scKbZx5kcykapOy5BrSE16HILAZG+NrysA0B2Nn4B4YF6dFOKSXFJ/w
 OQu0WHM2zVMNPAP+JoLLTzLMD+CRpYpCeQ8+XehTVEFiU8WaEdamdTzoWd4dTJ2KWTW7cHzQg
 zsUgx92hcGadt7o60ak4QkAit4O2ZZpTN7/YGreGWTTJ4084yA4oiKJzhr/h6cFrNScjqDu/d
 FYRpAovgRTrqRi7erCt09DD0n/3bZ9PBXFbe4HVY+aoHBS1izzbre8Yc/oXbcoaqYiyW8z3ZJ
 7eGMtrlyCXmyV1RIEPy9apUWKuL0GPf9FroZkQBXggGBS0fa2+nEhi6dM4rgi720x2sCOnnV0
 oLsEhBghOK9ttktXmwPIYPo00Fw+vk/NbWWQ98Hisc9bt95y7As+TIkJ+4PdvHLLkdT6xgDtS
 CDuW0Nnt01F6/r/AFIaIGbbmYk//bav/a4WxhvAiVpnM49QW4AW01hT3WeMge5OZJDQag8bAw
 xj+0LnBeUc63B10hnBLtxJC7T2EmqesHMpjEFvmO42Gwmc95YGCEBsRGeVu7Xwy8/4PohKcfW
 MZwtrtT78GHMmlec2ywev1+6fhBPZbnTdjkmfOpnET5ARHA7qvXr8DFuUrrfsjIy6ieVA3pUY
 Un79fWoVZTSj0D0u1wUx5TozIHeLHvucrs/X2rzg9BnR+NedtZHv/D3MeV77Nxp9iqfUm1vtB
 TIbafGxovl9KnKV6Ns2/sgEMxEZxxNWkgEHIagh1NfeaXfKy1gs+WeQReiL3JjUbbOTWaC+z2
 Uy+Wc+cOZim8bDi2wQMQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/19 =E4=B8=8A=E5=8D=888:26, Qu Wenruo wrote:
>
>
> On 2020/12/18 =E4=B8=8B=E5=8D=8811:57, David Sterba wrote:
>> On Fri, Dec 18, 2020 at 01:16:59PM +0800, Qu Wenruo wrote:
>>> This small patchset is btrfs_dec_test_*_ordered_extent() refactor duri=
ng
>>> subpage RW support development.
>>>
>>> This is mostly to make btrfs_dev_test_* functions more human readable
>>> and prepare it for calling btrfs_dec_test_first_ordered_extent() in
>>> btrfs_writepage_endio_finish_ordered() where we can have one or more
>>> ordered extents for one bvec.
>>>
>>> Qu Wenruo (2):
>>> =C2=A0=C2=A0 btrfs: make btrfs_dio_private::bytes to be u32
>>> =C2=A0=C2=A0 btrfs: refactor btrfs_dec_test_* functions for ordered ex=
tents
>>
>> The idea makes sense but the patches are IMO in wrong order and still
>> leave some u64/u32, eg. in btrfs_dec_test_first_ordered_pending the
>> io_size is still u64 while for btrfs_dec_test_ordered_pending it
>> switches type to u32 (as expected).
>
> That u64 is left there and the reason is explained in the 2nd patch.
>
> Mostly due to iomap requirement.
>
> But I totally get your point.

After digging more, I prefer to give up the width reduction, but just
focus on the other cleanups in the patch.

The width reduction really needs more concern, especially when iomap is
involved.

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> The type cleanup should be done bottom-up, from the leaf functions
>> upwards. After that, the structure type can be safely switched.
>>
>> I'm not sure what to do with __endio_write_update_ordered, it can take
>> u32 for bytes but internally uses u64 for ordered_bytes, that should be
>> u32 as well. But
>>
>> =C2=A0 7711=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ordered_offset < offset + bytes) =
{
>> =C2=A0 7712=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ordered_bytes =3D offset + bytes -
>> ordered_offset;
>> =C2=A0 7713=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ordered =3D NULL;
>> =C2=A0 7714=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> expression on line 7712 would need a temporary variable for the u64
>> calculation and then reassign. Maybe such conversions are inevitable so
>> we have clean function API and not pass u64 just because.
>>
>> I like that the hole btrfs_dio_private gets removed so the cleanups are
>> worthwhile, but maybe not trivial.
>>
