Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5432A8A31
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKEWzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 17:55:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:43277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbgKEWzG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 17:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604616904;
        bh=itZYgA1hXu3LsikLerPDae+aebc/6lTt5TKUJlK3opQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QXGqfUnhoIU5qi11+l1rvzHDqRvzRxidgJdGX74Hw0XtRXaM5ZIUoEI9aJnd/6uW5
         rvn0KwhSbPi4xQMuD46IPjV6zOetmYXCOAi68R0lL59HvEyNOjrgBXEOrmsxA79MgI
         5lboj0WWc9/fXj9Pz3ErkP8bdvcm5tsOr1C0F2FY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCpR-1k1CUK2XKx-00bLup; Thu, 05
 Nov 2020 23:55:04 +0100
Subject: Re: [PATCH 16/32] btrfs: extent_io: allow find_first_extent_bit() to
 find a range with exact bits match
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-17-wqu@suse.com>
 <7ea00bd2-73c2-130d-3e8a-f721a0a7af2b@suse.com>
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
Message-ID: <157e5125-7279-50eb-40ce-87d0ae11e7ef@gmx.com>
Date:   Fri, 6 Nov 2020 06:55:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7ea00bd2-73c2-130d-3e8a-f721a0a7af2b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7mb9wxXva/DJM8coaNsO6keDZFIAFEIrZFltpxsZYT/qf3UuLSJ
 uc5Wd80EaSThqn7wHKXnqZ2L3cpFsXD9gpYMq6yl7xKNlqVsHycCasOGJgtPfOzquhzeiXX
 wPhBJCLg0EsrUR/BFxkmSy1YeblmhOyEgnoxK0HXECxX91k+u8q9PbyNdwv7Ywg1ueOLxvZ
 DTjS87qlW4f2pZd/lRl8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F3GEOratu9Q=:pNFHz5W3SO7PV7Eq0FeVIo
 LFvAxCzcE+AEFYv56PkJWp+i/5ns25acOGmRfoC794fge0aRM53QY6DsLFa9WaGPrYa1LIreP
 7OekNo7XE8uo6rifBH9hDDAqsxvrYtqIVu+REQIl4GqIt6GRkP5C1AclJH46xx0xxp13XP4n3
 s/HD2OsDmufeuICT0ujJoDQuFubDUVh/xPFMu/m6obTRrMknNaYCQkScoFQlfqGyyhjPuF2mm
 rNp9qgMwt+vFvL9DEdZin9OXeFVpWXCU2cREAJp9i6Zlhm2CU7yQoViFHJvxrJMQmGo86iEOP
 GtZKDNRxIqAf3Kg2h4ay4Y8IywMZ8Ksrn805LyXhrDTCjkEzJKUEjGyl2GK9rFoZ9b7JOOA6b
 AwJvAtMP1BJc4Pj5MHeVUbcn7UNejQl8p2Bf9GqW51ZopN6AohpdZwm0sDCL5877xj9HqIDmC
 KZslGTLo0Z3IUonpKVbhMwMHtfMzf/jwdd7dbkHNGD7b0rwwC5wxmGulG81KL5zXhzlG7+daw
 sorN/SwWuJq/+K+3ZOvuV6fN21AL9SjUSOk71+AtWuRq+0BeqrBwIFxgvJQ42VuJLRQ9jaqXW
 HljefQRBxpQTbzdDqwLe0ALD1Et76CqxE/s8S1ODR3cauLDH6jU5vy/CX7NRaOI6yTWWEHkkx
 o3v2yWT30rSDjVLEApXx/9XEHTYLg6Wm0v1ovJvkJEKlA890j71FfV2iUv29mpTj5EB/O9e8w
 XM8OTwXD29vYQEMFRmPnR01sh8bY8NcsauOiImLakSUpufEQnF/IkuaRkDYFRHZmB1TXsWDyO
 uJrSf2TKvu0DziRboj2iT7kPGi31mG7a1xj3w+859PepuAiiyU/nKpugbPqce3YgYqCTsCJMM
 UQj8dG6TpYKTylN1yuWQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=8811:03, Nikolay Borisov wrote:
>
>
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> Currently if we pass mutliple @bits to find_first_extent_bit(), it will
>> return the first range with one or more bits matching @bits.
>>
>> This is fine for current code, since most of them are just doing their
>> own extra checks, and all existing callers only call it with 1 or 2
>> bits.
>>
>> But for the incoming subpage support, we want the ability to return ran=
ge
>> with exact match, so that caller can skip some extra checks.
>>
>> So this patch will add a new bool parameter, @exact_match, to
>> find_first_extent_bit() and its callees.
>> Currently all callers just pass 'false' to the new parameter, thus no
>> functional change is introduced.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> What's the problem of callers doing their own checks, given every one
> will have different requirements? The interface should be generic enough
> to satisfy every user and then any specific processing should be
> performed by the respective user.
>
Definitely no.

When the function returned, the spin lock is dropped, thus any caller
checking the bits can no longer be reliable at all.

The interface itself is not *generic* at all.

That's why we have tons of extra interfaces and even don't have a no
spin lock version (and that's also why I'm trying to add one).

Thanks,
Qu
