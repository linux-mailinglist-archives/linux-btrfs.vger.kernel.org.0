Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4AFACB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKMJOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 04:14:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:35785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfKMJOJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 04:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573636365;
        bh=JXSpYGgWzR9u8vx3xL5cpdzRkH6q+ok7WqkCT/ox1Lo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LVA5KM6ZGOwLJODwHrF2ilOLioCUvKRr6l+HyXhfSgh8wgOpRKe2YbDVUenzBeLGR
         lKuwORIw8U6ZxU6jKqoyLbJ2irZJCIOelO1DwntyFYAiCLxNRwfp4Girl48ZF+XYpS
         78WCAp0tbrrR82W+RDVp1YQ2JqdVMb1MBVuH/iy4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b6l-1iXqyX3Bnh-0083Hr; Wed, 13
 Nov 2019 10:12:45 +0100
Subject: Re: [PATCH] fstests: common: Keep $seqres.dmesg in $RESULT_DIR
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191113065716.33948-1-wqu@suse.com>
 <ed91ef1f-edb4-c5fa-5b0e-7025851e157b@suse.com>
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
Message-ID: <d2aebaaf-8c07-e44c-50d3-6a1bb0ecf7bb@gmx.com>
Date:   Wed, 13 Nov 2019 17:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ed91ef1f-edb4-c5fa-5b0e-7025851e157b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZYrf3QFdZorL09rsiJTWzGYx3Po/OQOm1rXmWZs7aoLEHz0ccFI
 zl7an0n/0hoH2akDwwLCJVotaIB5Stc4kc8Gc9Kv6ba1vbziPPHS0sSo5kZ9ow+UMEifKVu
 FZQjHwJt6sfCz1GUa648hrp2Z6ktGfxMyhBWqYJX1aun2PFa0wltU5UGJBNB+0LM3TmXrCz
 YCmm3mTUdUpewuxo5j6Vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BY5p+xrn6dM=:cvnlwIZaS+oipRiZvCT86V
 HzstR+i9pqS/ccdd13P1b8kWzjM/c3wzAeBTp6QbOH0ykgodPCtWMvoTex5/7rc/YearjGXY8
 8QGPBu+fCD/qE75gKzp/QNttg0yDAg8iTTX28Wt7WZywoGcXgsSx1dGsRmYHfSmQqRG2leKLY
 l/nJnZd2HnldZZYnv2JD07mXlNyJVuxRrHJvPXh05PfwdgQpOPrn8hfX8Rrxva+uiJn02/Y9X
 G5nYC+zhH9E39Hh/kHgZU0g9Bd4DH+SJHG2G4H9FnNljTmOMnanwmKTqX3AwT2Oh9d0I5ZhAT
 GWUsFS6zQp/DilR+Ks/Jz0gOcMCKVjKmTTFVYNwTsg+0QdERGiS0DPb0zjue3HhuIhQNfrCUd
 Mt8cIje6zojK2tH+uwNBLdhEYAUDfN2nM4Am4Er/OYEdEivWAcOPZZhoczvupGVZaWAZAgm7B
 yO4nSdCdfBFfNwRYk0eG3sNPsBILdYbDbjhIMO7fAyvNhz9tEOOWbkaCB6bLZlM9PJK4+NM3i
 3B7WZ0/oHEZcuCQKAMu1n4DDJTQiwE2MhxsfuBovzWLZ0vCA/iz0eynpHObwOGn69CNEVYDRx
 z2dBLUUA2Kh3n3glBl1uU044ac0prEOdGPEU7BwjcIVkyLF3bZBb5dsq3UeKntTyRTyTrh30a
 VO8/j89no+YK6WAOg7vVxverVYZr38QDZSCJtafVjmBWW7p1jQEjd6kiavdI3v0Wy9oaOvF3D
 pmH4u9DJENIFvqsRRfiTf/zDhtQzQKybMgJyKMXoYG8CkEzvw6BRAfQBUczpsinxs0fd0UNyr
 w3vyS2V5IrGJoN0d1IJunMD3OyQpfTY2ma7X7/1jyvTlKDsmq8J1AkreZExb1yMgpI5yS9djQ
 RRB9j6RMCOG89RZVQrM3z+sr8HZvJbzu65Xh2JqFuyFlGSMQjc+zLi370p6gHMU3c+RYGXpSs
 PvdLkwr54HrWNWIhsXjBL/ZgiHPV/1Rq/Aa37hS2eewW/RpIfG53Mc5t/PssYPisb4etn00rs
 qnSPJ9tieYdztKdoMIFM6gowZYHcAfpSkaPhgUCDp7VS1uNhNsImLkY85LoY6Ka7w1Shs42R8
 GfvdcN7UhsS2qTHxD5KF4n8QiQ6p5bCGcQsS5r2X6WQ9lsUdCmyphLrEkEtHLIRABPHxdpNFl
 17hO7KjoAa5SswDqgPt4rrCfBmaDBkewinvsC565SpZrKT2JCfT3JuDXUhki2QRqrK37rrbtF
 B/htWXG9CWl/AkilXLhScArpbVSZ8gJnGp4YI5J63Iw03mSULMA9wyD/UMLc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/13 =E4=B8=8B=E5=8D=885:01, Nikolay Borisov wrote:
>
>
> On 13.11.19 =D0=B3. 8:57 =D1=87., Qu Wenruo wrote:
>> Currently fstests will remove $seqres.dmesg if nothing wrong happened.
>> It saves some space, but sometimes it may not provide good enough
>> history for developers to check.
>> E.g. some unexpected dmesg from fs, but not serious enough to be caught
>> by current filter.
>>
>> So instead of deleting the ordinary $seqres.dmesg, just keep them, so
>> we can archive them for later review.
>
> Rather than keeping the seqres dmesg for all tests why not simply extend
> the filter?

Because you never know when you need to update the filter.

I don't see any reason by not keeping the dmesg other than to save some
disk space.

It would be just too annoying if some report hits you with only
$seqres.out.bad but some clues like btrfs_info() is completely ignored.

Thanks,
Qu
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  common/rc | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index b988e912..59a339a6 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3625,10 +3625,8 @@ _check_dmesg()
>>  	if [ $? -eq 0 ]; then
>>  		_dump_err "_check_dmesg: something found in dmesg (see $seqres.dmesg=
)"
>>  		return 1
>> -	else
>> -		rm -f $seqres.dmesg
>> -		return 0
>>  	fi
>> +	return 0
>>  }
>>
>>  # capture the kmemleak report
>>
