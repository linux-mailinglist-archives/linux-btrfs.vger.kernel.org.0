Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0C3F970D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhH0Jcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 05:32:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:45983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244579AbhH0Jcy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 05:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630056718;
        bh=38dg/dX+rs/7QRWXb+DaCjdsl+m+eS3swmbv3blSdCM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jS/SBadqwerheBtbl/dDrSe99brzqfVlKdt9SWuipzsOeuHc1IY7XqYRzF9AC0Cbh
         YTjLs7MkJfQBUuaO9miAtKnVRyhRW37GXjwcYo3uxOaNFMVm05MuUPvGmL+Pqqff1V
         5NfDRfgMJGrfWFjVhzMNfe0n0/BabK19WQrVqF4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QwW-1n36Oe02SM-011S5d; Fri, 27
 Aug 2021 11:31:58 +0200
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210827114153.19CB.409509F4@e16-tech.com>
 <025d8f85-a86c-63be-14be-a3f1e2170107@gmx.com>
 <20210827083532.GS3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <467cadfd-8b30-5a9e-9b7a-812cb4902185@gmx.com>
Date:   Fri, 27 Aug 2021 17:31:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827083532.GS3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GRVpEB02u7wSE8D9uIXBGg6SlMsnY5UDmqHW531cTKgHH0uHWqN
 K469huIYPIxkFwNFhVMTfJjqvy+OeT7FnXG9EfWlKskTcjX+knywdGmH2Jp8oZV0tOWM01u
 dKAlAz56DUAHFUfkNlU7IeBVGAqd6iDNm0hL75yIYF4goIaaKeFvvbDm4wVkypOeovV6Vzr
 wA/mJBXuB43RM8m6/8YeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:koe4eaNMX7Y=:JAStQt06tjLXvAd8w9L9F1
 /UcpoF9M2fgWiML4E7OofRlPzk7bnbAD28XQ5j+dUOvlOIYcTIPiZZ7tRWC0Et/BpA2TlnayP
 BsqjS0hKfmiozYpovumup4P0ceIeGGg+xs7Dd4Y1/brTurdMZDvXi3OMyUnrASRorA2W8Z8N4
 7yMzim0glIZ102Q6G5j1dlCks4E2IBRQcS3gsfg1+5nP8FLR6F5lJPuoqXXzSV7poShpMQmar
 57GYvgYu1DwwlfLeEu5gsOh8l5eSCEzOCvh2lmpJlfqOqePchPvVZTgl6KkiQ9YdAbLTU5PD8
 jPvsTTwd3gqt7yHSWUp62rREvmDHK5uZdifp1tZtG7JHyoGwCEm9TLPHG/bRd79ODwCJ4xIfK
 W7e3jVXtB+mcpN0L8oE3tRFLfZkop4yW1awBeWVdEVri5ti3ZByrw7FFCNYOP7ncFt337clSL
 5IGZxDAuKPKFd6TIbjOrpt7rc+MTwyrKcKbYtBJxMWabGFStjbyYfGgj74f0vNXnfhQBntkY4
 5e/YLIBz0pU0KDZ3q/1D4wzlyqwGlu0D/iSFK16RmYXVdZoNF45zJ98sYDByXKQr9sc3rckeF
 S1u3njQidc9VFr2J/z09fq1nfaB2LJj4dAP15ZsxBmeHhGZbPBf5+1qX+rlC+y069rHvUnwQU
 FaoMLL2PAZFYvs0dV3g3+bNkWPntFS7K3l7Kr7ngEFZP+lc4FmU+SMW63pCOoxj9CKFey2PJJ
 y+cKJfj0XdMvjSNPbhFPgVennmpCD1ORR0LkOoVp55R9e+Md7gnJwf/KEGcVpEQgVfaPk6EC9
 uHnswGz9bR2gOLEBNaU03LzHe1cvKTDscCEG1aB9u6iMA1uKD6r6Nf7zLwKnimyh8PaeQ2LAh
 GPLmoTGJu2QCAf09SlGtzD/QZfw7pSvDQ+PV/PVlTY7o8yn2Un7EAkv2IAcKmBCXiqegRYGV8
 xir+tgYV1TVS80W8K5F67S/KcrUI8J4frqfSLJUdbaC7aiP1pgy+u4U0W8bJVfhEA9rCGWk7K
 fbbzQwJmAIF+dqsjuDKDhMEYu1djyNjCDcG7VwnV4bgQHXCd5VuOfXSqH6GW/Rr4rqjbYCh+f
 O9wgBIkocOWMvdd0LTAGaRCFduAarHf5Gz6hyEUAQFc7w/mZjGnkfWjWA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/27 =E4=B8=8B=E5=8D=884:35, David Sterba wrote:
> On Fri, Aug 27, 2021 at 01:04:56PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/27 =E4=B8=8A=E5=8D=8811:41, Wang Yugui wrote:
>>> Hi,
>>>
>>> With this patch, kernel panic when xfstest btrfs/244
>>
>> It's completely unrelated.
>>
>> The fix for btrfs/244 is beadb3347de2 ("btrfs: fix NULL pointer
>> dereference when deleting device by invalid id").
>
> The commit has been tagged for 5.4 but I don't see it in the stable
> repo, there are no conflicts when applying. I don't know why,
> nevertheless I can ask for merging it again.
>

I guess it's because the patch is not pushed for mainline yet?

The latest pull only contains my revert for the compressed inline, not
this one...

Thanks,
Qu
