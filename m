Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6AB29EDF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgJ2OLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:11:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:46395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2OLp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603980702;
        bh=NaPOGUl+Bx9sL8dfYOtUu1WswgL6sp7do7P1GY+PsJE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B21xMtqojmewDGlic6s3R8VfIR1ibIZJ9HkPuTkyY/PVAKr8r0Lp6lZLCdvyCm686
         dfLaXBPTcira3/+ajtvOjhiBG/E7JekEp3ok+kMpPmLNij5xuPS0t1oRgV6UyqAwSH
         U9uLiYID8K+iG6Mgm//HD8F+r/ftzSnWorgBjsss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1kFUhc2Ktx-00ua50; Thu, 29
 Oct 2020 15:11:42 +0100
Subject: Re: [PATCH v2 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums()
 to handle out-of-order bvecs
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-4-wqu@suse.com>
 <765375f6-7c4f-e9d9-f0f5-3de9bac74cce@suse.com>
 <55275e3c-1828-7180-e902-8344a571516e@gmx.com>
 <20201029135415.GK6756@twin.jikos.cz>
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
Message-ID: <214e0c82-db77-1b28-eadd-97bca06a5aed@gmx.com>
Date:   Thu, 29 Oct 2020 22:11:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029135415.GK6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y6tSifGfDG9may9s4kit+pK8BaLDozAOUf1mapY05EoILzhDGPQ
 N0ON0EFP+teNYg6USiHNOE+jsXVF/HzyB5wAd7yq0rznQDc0eYwVojnFvsVdUIdNm36iy2W
 2lT7YNBEuPi1c2Lhv9jV9xVTaQtdRAx+g+FZ6GQmPL2Dih3/H4QB/b6xhmNQeQ1LieoiQtd
 gW6hB5S7hjIKprZgolpqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UJEsqEXzWIw=:tPJ08Ue04v+BqVY+icOoOl
 bgI8ek0SzcAa6wGf0vt0J0RtZj9z2uDIRWbK/4WxcNUPQ42Vbc5BBRxkgRLNFivsILLlD8tF9
 I2dhauq/377CZUVaKYCnR9+l1itoaTZD3vbS+9GgJMIXNDuRsc1TG63ZcSsQhXsMHzUdMifNr
 6gRzsqKl8F45QN51HP9aw1vqwmoyPcKvaI0v60TDxzFOraPCj56RjIP1XoHPRo2o6aB2EQopj
 fnfE9W7sKlrfv/nju706KDO4U0d5WPlbWxe8jxaZJgEygowt0LD4MhBnzbXQl0/fd/qAl4FJC
 6Xi8H5CfuViN7zxqwckoVDxLVNSu5pOrnkqUtM6KKqZ2JefWSWCnmIUiSYxE2m65wz00PvEQ5
 vnp8n0vc/oz/wSu15vD82IVpRjaRNMU99ZXL8wl3lb0MN2sUVKWdSaKF1Uc6eoAmxlRASManp
 CVTlc2eb4huc1ic86m0dmd4CfTnbRQazUUgt5sNoSAG/AhGykjKykpt7qCF5sccJFZlWUtJvJ
 pWo3xDQb0B/xvst/SI9uM8jDgz9zjq3oke5oCLMgaYhlntTFHkMIg3tB7eB9Gkty5+sbpdO5o
 rr6fJhGM8iOpLVw+kvDvqrypKhSIoid4E4KvevV3Fr0A0fn//le3LAuOtoGO34YF/5EiFPthq
 v165Nzzqa9AdObRShX+L9ISDm8ty9oM0Yfy1+bPmQxjN9Cq1zaUcCflLTwyaYTIjkAllvyObr
 G0tymS4herFepp0EX0xIvSEAd/D/OOLHYysGSdKyCqBtvichbono9eK+Q7Pvx1jTbhwL6bTUk
 uwm7BuR0TJSZvVfoRmmNMn1mL7RFSy5hXoAuhQkOOAEB3APSTXWiXbPTy84US6320j0EecfCX
 7iZEqhirxIMz0elm2UmA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/29 =E4=B8=8B=E5=8D=889:54, David Sterba wrote:
> On Thu, Oct 29, 2020 at 08:43:12PM +0800, Qu Wenruo wrote:
>> On 2020/10/29 =E4=B8=8B=E5=8D=887:50, Nikolay Borisov wrote:
>>> On 29.10.20 =D0=B3. 9:12 =D1=87., Qu Wenruo wrote:
>>>> +{
>>>> +	struct btrfs_csum_item *item =3D NULL;
>>>> +	struct btrfs_key key;
>>>> +	u32 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>>>
>>> nit: Why u32, btrfs_super_csum_size is defined as returning 'int',
>>> however this function is really returning u16 since "struct btrfs_csum=
s"
>>> is defined as u16.
>>
>> It was misguided by u32 from btrfs super block, where sectorsize,
>> nodesize are all u32.
>>
>> Any recommendation on this? Just u16 for csum_size or follow
>> nodesize/sectorsize to use u32?
>
> u32 is ok, this generates a bit better assembly than u16. I'm about to
> send the patchset lifting it to fs_info and it uses u32.
>
BTW, if you're going to change that, what about adding some thing like
nodesize_bits/sectorsize_bits/csumsize_bits?

There are a lot of locations that u64/u32 leads to 32bit compiling
error, and a bit shifting would be a much better solution than div_u64()
macro.

Thanks,
Qu
