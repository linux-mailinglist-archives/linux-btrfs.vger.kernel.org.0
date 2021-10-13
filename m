Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C542BDC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhJMKvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 06:51:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:35263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhJMKvh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634122159;
        bh=3y1Ax8ewSDNoGoLvir72to9z/znLvie6bI0c75IcE40=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=f6Z26b0GJPuSfXqwsu3+ZE3YwXZI4TWWjZudaAlYH2k/c4WnGIhtysaeWeh3kXn/o
         WafeyWMnstaLvSWr0ZeWn4NkuPVPUN6rnNK6QDUhrESVVWQd8/Yqk1gus1NCMAsLAX
         3iRdB8nAGix1BR2TtJ3FXASKPPuc3Qdmcu4tYVC4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKKh-1mYcg33vA1-00Fmrr; Wed, 13
 Oct 2021 12:49:19 +0200
Message-ID: <39a70849-3550-8757-ea0a-3d641d4137f4@gmx.com>
Date:   Wed, 13 Oct 2021 18:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qing Wang <wangqing@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
 <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
 <20211013103642.GC9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: replace snprintf in show functions with sysfs_emit
In-Reply-To: <20211013103642.GC9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tlyABHuiyXrsoReSwr9sfmb6Pq9RbDFi9hceUdlTr36n5U7Afm3
 8AFgw/UHCmfcaVFUARhhWse/sxxPHhdyo7e8nq+9J+cX5SZ23EWLTBQRcoQwLJlic9eFqQz
 eN/s6Xdd3Po9LUa96amnHd3k6cnPfls+yFWtDtnwbeY1WRzx+a0mpEPwYMlPHH5Rcc1+6hL
 u7gAP08q7O36GmwYL4R2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JpPk9/HRbQg=:tmCyRzEu8J5U5Q4QpdTvqw
 r3IE4fAd+LprxMynNCfvpgi3sNvgsBjjJOQuHF4swmbM2bFWHBpGF9WTlfuOg7wRwFZTmmtMt
 kZSyFhoI4poyrg1Jho9qsHdnoSumzZfBLSAirbiTs38uB60E6fGjq3SphQuS7eQAkaQLDwtVd
 FEZ6zsYLPPK8zONIywZnOl2wmSRSA0o0lDNKb6OJwML1/obZG856p8j1tPM6D2VHR7qCgHo3x
 HXlT5S9H6xyGtfMO/ZgZrZ36pUhaNkyOYh6IVi0qJ0mnGE0sshTLNilQyRG+7FZSYdd2SSWMC
 S26Y+dX4lVUhAZKx3y0LEcdLKrVb759dKz8BwD2cQDJ3jXHqC+7SCbeiciHBVrxipayp/Lllu
 C4/OXgiDNPjQunCtYDjbHXJaSPLaPl35Ds0mpWtiwtbXgTy+NPwvWJdp8iiE/9XGHavwb5Q3v
 S166LA5hc+DwCVin+9z3KnZm0/p3ahDwUeP2uK3qGfRTQuLenw7eT+UVWs4bAGNDs6T/7yzfI
 +EOVrccx4UcHF9xIBcp4+7mCBKDtrzAiEed8QLuejDIE3PbhXNNLgQ1yonMC+hg6W2uRJsJl6
 2V2lTjzkIz2g6/jlHhLU0qOo4Py6DTDbNqgRq3o68JUuRYCVGObDqTrV0WCXN3OF+o0RxJ0rr
 RFMU66pCF0Ajy70wsO4OKa96DRzLEcgFUlVgQzxELkDkGeCkJQ9tXqAfoeBBSDlQqPpZXi7Eo
 bVuWDoir2KMVhFhZfuBzrbpwbPjByjVmxWPGcEBInjB40dj8UylIKfFgSeBdHwOUmGKR3/zB4
 /FCjyNSVeExi9F3DD50uGMC9Gmodn8yMgrcpgGzAS7tn6lz+amL9ljp5prJKwZO2ntfNY5OUj
 IenmJD8jG6kZVI5eWUgJMRqW9psUGZBxBu0x/rmw6hq6k9w1EipliRYsBFb6icraxXDEQrTLK
 tMADt0eGocSG80KHYQvpQS7rAnwq5lMZd/lI5UbnhWwwC9qKB+JN88C1SPNWELuBSqT6iT/bt
 JLCgglNvd0KoZGFkqIBalZBp+F/PFkIMedFWiX0CS658rGsxLuQ6SlonpYIpI8y7nIfIXsuxF
 EfxUmSU6hoyUy0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/13 18:36, David Sterba wrote:
> On Wed, Oct 13, 2021 at 03:51:33PM +0800, Anand Jain wrote:
>> On 13/10/2021 11:28, Qing Wang wrote:
>>> coccicheck complains about the use of snprintf() in sysfs show functio=
ns.
>>
>> It looks like the reason is snprintf() unaware of the PAGE_SIZE
>> max_limit of the buf.
>>
>>> Fix the following coccicheck warning:
>>> fs/btrfs/sysfs.c:335:8-16: WARNING: use scnprintf or sprintf.

IIRC sprintf() is less safe than snprintf().
Is the check really correct to mention sprintf()?

>>
>> Hm. We use snprintf() at quite a lot more places in sysfs.c and, I don'=
t
>> see them getting this fix. Why?
>
> I guess the patch is only addressing the warning for snprintf, reading
> the sources would show how many more conversions could have been done of
> scnprintf calls.
>
>>> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>>
>> Below commit has added it. Nice.
>>
>> commit 2efc459d06f1630001e3984854848a5647086232
>> Date:   Wed Sep 16 13:40:38 2020 -0700
>>
>>       sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs out
>
> The conversion to the standard helper is good, but should be done
> in the entire file.
>

Yeah, the same idea, all sysfs interface should convert to the new
interface, not only the snprintf().

Thanks,
Qu
