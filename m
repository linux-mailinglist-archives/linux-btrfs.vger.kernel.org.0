Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A612A9026
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 08:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgKFHTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 02:19:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:57097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgKFHTO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 02:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604647152;
        bh=kfXyJuYNQyhqNCOJ2gnrAgIcoIKXwv/5RbnK+owpJDE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c1TTouno2Pjxbi3PCw7dMMgV3dDPbDua1iTAy4/BUIjmJH+l/Tok3q8/4TScwxITc
         AXeX6KEhkDcZH9mehrxcFHAfKTKHSNGwBZYMuERXYViBv0u8Ng+Z4/JhfPgJ4TdBsh
         jv3QaKm3zDLw46jV+RiPh6q9PW8u9irB9veQt1sM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1k5A7942JJ-00fBOG; Fri, 06
 Nov 2020 08:19:12 +0100
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
 <831ff919-f4f4-7f1b-1e60-ce8df4697651@suse.com>
 <1e7bf8d5-30d0-a944-c400-b5fe870f1cb5@suse.com>
 <07ee7ff2-e2b1-5318-b72e-8bff87231036@suse.com>
 <4a4a20ed-93de-65c4-feab-0a4f5a8680ef@gmx.com>
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
Message-ID: <ba70fe5b-1c6f-f0cc-d11e-fded6afa9fa4@gmx.com>
Date:   Fri, 6 Nov 2020 15:19:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4a4a20ed-93de-65c4-feab-0a4f5a8680ef@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LTAcYxqUKY7hiB7X1dFPD4PD58FrAvjvhgRdo8t0roh4kKiz9pZ
 e/khbjFH4f3fxJ00TNynC2prtoUg16fQ7at2cfJRphdJ9Ev9nNhziTbKLhBfHBhCPIVjrJ3
 LwnVipSG2nGeprSIR1onY1cVQtQ6z49RVax1I2YI4w4S1vJ1eQgORoTfWK4Qo43PajUmnvU
 Oc7uoTMOPWRakjmeEzJ+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I2m2/ZnJJeY=:N2ndyI/bhADYy48zD2tP41
 uO0krJL9yxeR2Ugy3wRVIGi3bHZsj8upIfNFKNnxvNpj9kN+jQvN+vf9q/lZ3AV9zQ/s4eUNX
 fBo4vMsuRLfdiWK2bpnRN0dCCmja1W6creVXXamvC8CBBE0x30eFsy1cKrQuB7+yJJ4LVuyON
 Y6bpjqqcdDHfwgZd08KLCIE+g6ghrwjiEg0NYo5UGlWlaFSRhkcfPPhiYx0oamPApadygzjnY
 BRaC5Zc5ITweOE0xA90y8vw1/RdLgTpdfdLHzSONN8joKPDJOYxs73Nm24JcoaIJtPsJ1WKS6
 GpwP2QU7buRqOJKeYXY8940TXoSo86ke3GSPiP19avnCVp1nL6JJdeaHwCVejehW8aaz+dRYg
 vSZI6KR11cy0rQvOfBnpYgLceV2NO7g8emuTHGZVzwo8IfmxaNbCc00IZSL04eeNy7UZESzBe
 oJoOGz+mfuPPtuFM5F1B0drUG+EQnCsIS3gL2j4gq2spV/AeP1cFDXrFJ4deei/wviFo6/G0b
 0tGhXUmNPSdD+fq9u1921Ct+mb/wPpbTmDRMldRIcrgfWKMXVoqbA5BYkL7p74KXCFx+YjNI5
 uOnbZYL8W56CTjsyhU7aXuw/rm1gSkwBz373kEhmqHuQQyJhEHODHOG/XBTwa0l1xQ96HLpBH
 JUSSvvlxp1SxREnNf63UnBQknyJjxBKi4VuO0Qoe5PluPgdeI284jmqsMwqV33rSuq6PP4HPu
 fNf7l0/FqAmli/KQeYHZ//aUjFKp1m/bHcL630EVfY8PwBIYijitfUYsIp4baK8hZB68TgKAG
 x/ZZH6wTwvfGR8j/ycRkxmE2WnB4TskLXrApj28dxuS08kaPlyX3ClOx30vpOGv+ZW7xmTEPM
 6Ig3lSz5QJpSew75yVfw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8A=E5=8D=8810:01, Qu Wenruo wrote:
> ...
>>
>> Can't answer that without quantifying what the performance impact is so
>> we can properly judge complexity/performance trade-off!
>> First I'd like to have numbers showing what the overhead otherwise it
>> will be impossible to tell if whatever approach you choose brings any
>> improvements.
>
> You and Josef are right. The too many extra extent io tree call is
> greatly hammering the performance of endio function.
>
> Just a very basic average execution time around that part shows obvious
> performance drop (read 1GiB file):
>
> BEFORE: (Execution time between the page_unlock() and the end of the loo=
p)
> total_time=3D117795112ns nr_events=3D262144
> avg=3D449.35ns
>
> AFTER: (execution time for the two functions at the end of the loop)
> total_time=3D3058216317ns nr_events=3D262144
> avg=3D11666.17ns
>
> So, definitely NACK.
>
> I'll switch back to the old behavior, but still try to enhance its
> readability.
>

Base on this result, a lot of subpage work needs to be re-done.

This shows that, although extent io tree operation can replace some page
status in functionality, the performance is still way worse than page bits=
.

I guess that's also why iomap uses bitmap for each subpage, not some
btree based global status tracking.
Meaning later new EXTENT_* bits for data is going to cause the same
performance impact.

Now I have to change the policy to how to attack the data read write
path. Since bit map is unavoidable, then it looks like waiting for iomap
integration is no longer a feasible solution for subpage support.

A similar bitmap needs to be implemented inside btrfs first, allowing
full subpage read/write ability, then switch to iomap afterwards.

The next update may be completely different then.

Thanks,
Qu
