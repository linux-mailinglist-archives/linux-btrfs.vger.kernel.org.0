Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE73F5885
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhHXGz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 02:55:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:50673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhHXGzZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629788079;
        bh=LHvaMwSaRP4kHb7szCfSuyUrRn7fojWkkPUckL5yaAk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KhWqsnm0NANSMMJ31SMFsw5ILAkBz+Jb4Y5Jfe9eTibjevglChMII9mg/hkifPwPg
         5N9j1QE5lBlUxnU6odMUjXdkZRLuRNvkzkfKcS97VpasvL2xRRIea6CQrOISuScDkY
         h/2nQd8XyfUM9pTqezDwy20o3dpHMKLuwT87rk5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1mrl0x2329-00Zdbc; Tue, 24
 Aug 2021 08:54:39 +0200
Subject: Re: [PATCH RFC 0/4] btrfs: qgroup: rescan enhancement related to
 INCONSISTENT flag
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210822070200.36953-1-wqu@suse.com>
 <20210823173025.GM5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9d957532-5473-feba-6ad6-695d459a85bb@gmx.com>
Date:   Tue, 24 Aug 2021 14:54:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823173025.GM5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h5jwQ6Wut4QWL1Q3vkIWEZnenNJp6Zj0WoQP6x5Plcalv9ddvCy
 3OnkeTbiWmEGrq/I94AdL7Go7Af6YenpFBHv++zV8NB1c2j/2Sj9tnjPArdFmkdUAU2rjR8
 gNTy4T8FdWrcT3vNWLqeXR/m4Z7XSWTGyHy6MN5rfjvWMlVeQFwlKGL1k1jsuolnNp2fBM4
 b2F2tJZkc6McaS4nmK3NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KRd1RX3lRww=:keyZvawuBRp79rJaY9CVW7
 xoGcGKqysteexQYwiDnKn7pRCllC8HGfRk9+0C4N661nBhtSeJ8xblHGQmSOW0twIJi+vPjGG
 33cuvVgcsYjc805yiohZrmwdsK1XOMOfFwMl0X/17ZzS2sxrV5cboI7RU7hxxw9RjtAkoPnFp
 GnKrS4vtzVNmh7Cs7VyEr3C+ZXPs8gpvdBSslRcIjxedl80s+OuvW7X9fAgecHPYL+dY0Icfu
 gu503eNDUFqsTFr9Kh5pGhlQwvDSnfs8aYzF45MfOvvetJZ8PTDmcCI6twDQ4rd83RBaGuuyE
 gTAiZesrFPH4rR9E30dSac6CjF/dEZAmYihPAp8qHCbhv1C747oawH/KxUjEHwwAfX637Q1UT
 +c7icKn+sQwHBLPLBYM7jiHoeLtar9/eQya91ivwATgfLaq3pC44lwu31xxlxWzNdPzN/LsLq
 F66Pkorh+vh8THOBNndI6IHqPKhnrCapHP/FoaZFV7mIqTeuJNeIfArh3XMi/vqmZwmvhS6lT
 8f2jCaJV+2BQxy2qZ6Hmqk2Dg8Gu4z5OYqnyPlp7qIA0YaJKFcmpSvSXHrXb6D91Zd1GClUEv
 PgHTk5I90ssDcdFniM93iOpi3m32qI42ite5VhhQ/a8dOSNz8q2u5PkoYCaRpATz+kNQYMrdc
 HO2dNLiB3UBiceNDH1mxSn1wyOFkuhd/eODawNKFYTBW97hxv++jwTo4SRYDvgTH72eZwYb63
 /f06LrNBcihHpe+DkMbl+BG8ydZkZMTaT6kLAoyH7y6fBsh3zqK/7COkdsuIDFcr90SOzl2/S
 gNwu3UJqoPwNRXNp3fVMdP0Qfp8X9AKyVKoCVcyClk5J9d487Xqc1ESNN4KyXx/BplHB5+KZl
 Aufp35priwI/XoAAYeAYOp71K4GUgH/ajY8M+gKWoUkaNu2keEbGgDKYia1y/n5KfeVbwME3H
 pBdcS3XmE+FJNBwuk2hbsxQpg0cXXi6o8RMCdKt1J4DR4j5IEl93elMIdpOA6foN0ihM3hGRo
 88TO3e7ossa7wpAar5nUaG1pbtzSIbJcv+cAswTgwRQRcxlypAYh95cmjhwB6kCbTkd0febbf
 TK5VLi2b7EIhLG/xaccPktfRMIlBli0w9FqTmmY1IGIn0DmEue9nVNK6A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=881:30, David Sterba wrote:
> On Sun, Aug 22, 2021 at 03:01:56PM +0800, Qu Wenruo wrote:
>> There is a long existing window that if we did some operations marking
>> qgroup INCONSISTENT during a qgroup rescan, the INCONSISTENT bit will b=
e
>> cleared by rescan, leaving incorrect qgroup numbers unnoticed.
>>
>> Furthermore, when we mark qgroup INCONSISTENT, we can in theory skip al=
l
>> qgroup accountings.
>> Since the numbers are already crazy, we don't really need to waste time
>> updating something that's already wrong.
>>
>> So here we introduce two runtime flags:
>>
>> - BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
>>    To inform any running rescan to exit immediately and don't clear
>>    the INCONSISTENT bit on its exit.
>>
>> - BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING
>>    To inform qgroup code not to do any accounting for dirty extents.
>>
>>    But still allow operations on qgroup relationship to be continued.
>>
>> Both flags will be set when an operation marks the qgroup INCONSISTENT
>> and only get cleared when a new rescan is started.
>>
>>
>> With those flags, we can have the following enhancement:
>>
>> - Prevent qgroup rescan to clear inconsistent flag which should be kept
>>    If an operation marks qgroup inconsistent when a rescan is running,
>>    qgroup rescan will clear the inconsistent flag while the qgroup
>>    numbers are already wrong.
>>
>> - Skip qgroup accountings while qgroup numbers are already inconsistent
>>
>> - Skip huge subtree accounting when dropping subvolumes
>>    With the obvious cost of marking qgroup inconsistent
>>
>>
>> Reason for RFC:
>> - If the runtime qgroup flags are acceptable
>
> As long as it's internal I think it's ok.
>
>> - If the behavior of marking qgroup inconsistent when dropping large
>>    subvolumes
>
> That could be a bit problematic because user never knows if the rescan
> has been started or not.

I guess for the end users, the new behavior means they should know which
operations could cancel rescan and cause qgroup to be inconsistent.

For now, only qgroup inherit (snapshot creation with -i option or qgroup
assign) and large subvolume dropping can cause such situation.

If there is something like snapper running, we can teach snapper to
check the qgroup status with an interval.

But for non-snapper qgroup users, it can indeed be problematic,
especially considering how frequently snapshot dropping can be.

Any better idea on how to balance the performance and qgroup consistency?

Thanks,
Qu

>
>> - If the lifespan of runtime qgroup flags are acceptable
>>    They have longer than needed lifespan (from inconsistent time point =
to
>>    next rescan), not sure if it's OK.
>
> On first read I haven't found anything obviously problematic.
>
