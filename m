Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D22A8A2C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbgKEWwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 17:52:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:35473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEWwt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 17:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604616766;
        bh=fbWz1FBPylYU4eOMiUbmvphLkuBJ7CUS0IaC+NrI5yc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YCXN/RDpOy1fHDm9id6CPtuxe2uA5b1sS+Y1BFHmstTJEh1Ks0Xr00WKYzt9T14rz
         wRvFmQcCF3WsLt6FeBSnPQOZbDaTnRDM9YUH6pd5TNH02UakKCCWfJPjxvfJ9HY6Fv
         q3qmqZcfeYotzfPwYfXhNHWEbWUhFEPhY5FvvLPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6e4-1k7YAd1FxW-00hfHl; Thu, 05
 Nov 2020 23:52:45 +0100
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
Date:   Fri, 6 Nov 2020 06:52:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:deO3XvqcesdZjYv01fYPaPYSGjIcxMKrq1EOib+H5951RDQKs+m
 89/AjOojdDEWIudO4x5GRwGuLD4VctyTez2TJnPeIEKusexGusFnmrL2BCIB1K9vfThXFIn
 0YuhURtIiZV8gAPfMF6H1jMLdu27snjcRyNb0vTxjh2DlYiWXAH/9o9jNVs24Mkg7XFbWJ1
 Tgx9yZ/aPuY//aBWj+7Lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WII50MiAfhA=:4vfFMaCTZFL2+QPPsOK6rM
 RZvhCesGY+Pc2wueXJAUEo40DEcTekL3m0h8Fv87O6RXQB/xdDaOWt1gI7BXJK+8GLXaVRW6Q
 jVeuCppOtA+yrMkYA7elY3tKJRTDAkrG+IEk2DHQJzDvcRGCwtZ/j4EaWD47t6DQU7pgDEZbi
 21aWx3Do/dwTEeMRpCYznNXwXaeCyoxPuFlaIR1BN3lpUz8Aoheyvph/LycXpOinnKzUYo+et
 aPuc7ZW3VHIi205svCgiJLkVSUpw+khnz6no+OHgzOGXzLLoYC8sI7zEaeb3WY+bJE0gv1W3J
 ghYijy5Sb7s8ZS+cq4GuicXoS/GQRyH6gX/+jd2L84Y+VgywInlhNBSFEX8wL6E7YM0BB5vGF
 5A7jG6u/9lkp8zyEeJjoVdfIf+Ye1Hih2baJnNDY7JDs2uADHvhaYTpxq/hz9YZ10tl2zqu3a
 VHD56tfeFozrvRhLWX8BnXNX7su4KU2fl2wd5MCguTo/Hr29WnESVMsiZaLCVvGiX9dqXTVqe
 DLioF/FDW6PyCRrQ+5QcFGaU2QLsOo6oDsZ0+du+shZwBWMdyQbowz5dOJ7YkPgRnsb2W0OCQ
 8skgIhK7MlMLeUGAHveHS4y0QIwR93QxrM1s+H2ELarVon2rp2k2crk2xL+vbTCHr5aiRTM/z
 AwB4aGu6j1EZGyPCiITFJYz5tpp1cTxj/MIWlWt4x4Hirnvsy8WNL93e3OImywmzfsqkhT7a9
 /wIA3BZUWfmGY4ww9Q94mnB5nl218AeB1NzVPJOIAmNmUYUmdHZE98if60mPQrm7CTP5iuGkh
 HbA7Hef29bPto+fKGvWGyNankdNJXs+83mambasQi9zxRM+hSriUeypDx0VIjlBroDnzDSdVd
 WZzKbWOB3jx3rmrE0D5Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=8811:01, Nikolay Borisov wrote:
>
>
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> Just to save us several letters for the incoming patches.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index b46eecf882a1..a08cf6545a82 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3607,6 +3607,11 @@ static inline int btrfs_defrag_cancelled(struct =
btrfs_fs_info *fs_info)
>>  	return signal_pending(current);
>>  }
>>
>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
>> +{
>> +	return (fs_info->sectorsize < PAGE_SIZE);
>> +}
>
> This is conceptually wrong. The filesystem shouldn't care whether we are
> diong subpage blocksize io or not. I.e it should be implemented in such
> a way so that everything " just works". All calculation should be
> performed based on the fs_info::sectorsize and we shouldn't care what
> the value of PAGE_SIZE is. The central piece becomes sectorsize.

Nope, as long as we're using things like bio, we can't avoid the
restrictions from page.

I can't get your point at all, I see nothing wrong here, especially when
we still need to handle page lock for a lot of things.

Furthermore, this thing is only used inside btrfs, how could this be
*conectpionally* wrong?

>
>> +
>>  #define in_range(b, first, len) ((b) >=3D (first) && (b) < (first) + (=
len))
>>
>>  /* Sanity test specific functions */
>>
