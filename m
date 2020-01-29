Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42AE14D422
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgA2Xzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:55:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:58939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgA2Xzw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580342141;
        bh=XITtJExlSdMJlvvk3SPPpbztWnmlDrNbkZn5CRoQBMk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZO7aULeul8WVQQRCr/e/jyU/9rHzFbYMMaS5ktSTrJT9BEryz1EVg+TGy4RQkzcNX
         CD7LRuD/gxi+E1w6AQ/kRcjrvBPgoKfXDhsTj5wPxeSyTWfqTWWcADl9AV3UZH8PUG
         kGiL7Ye46BPFdfOb+aCcHiVUmKdIll7Y8ObwN9Hg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU4s-1jXOSe2Nsa-00aTMb; Thu, 30
 Jan 2020 00:55:41 +0100
Subject: Re: [PATCH] btrfs: optimize barrier usage for Rmw atomics
To:     Davidlohr Bueso <dave@stgolabs.net>, dsterba@suse.cz,
        dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20200129180324.24099-1-dave@stgolabs.net>
 <20200129191439.GN3929@twin.jikos.cz>
 <20200129192550.nnfkkgde445nrbko@linux-p48b>
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
Message-ID: <f49aaafa-9144-5644-adae-d5bc13b6ca41@gmx.com>
Date:   Thu, 30 Jan 2020 07:55:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129192550.nnfkkgde445nrbko@linux-p48b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKbIn1BgJMkSZlYsDHNNloPVS6CzOJ6Jbe8+Vbhx6l5avVBfbu6
 djLKitQzzavm8h09+MQdjnCFrSPKUm+4svxVi62aQ9rLGVfUrTTFYIYNlwqKI8Mw+AgLcyb
 1l/8QM8bwXS4KasZwmif45KD2XDVKs3kn1LRAJ4zDSF3l+df/lARUgmS4ofQ2MyeCqkGj9J
 Fb5BF7Wk/QhzBNCMGOIqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rkod/PACeIY=:NafSwqzKI40NSpj7xmTXkY
 AMyUO6OSmE4Ec+YjheoIN9BYc979Gu587jlGdYjUoiNiY0GbHbuLxGqK4yc2/YyL4ovl2U490
 LRQOOaEysPTsaTS1WooOxO7iqrANkK6u9mDW5XTH8aa0/GUSUJTdqN6BlA6nyZVRtdBIg/pPk
 FR8Q5TVHmkJ0vNWm22nIR0g8i80Xv8/6fj/H+Qm4XAxFHgAZJVweEd1Gobv4KhNmBeyghP5GU
 dgZ9en+G4SJJ9Z6BQdiiiy5V7ep7ayH+JHkGS6bnjtPxiaRC0erwf9sEUVKZX85hnmlZ7oElG
 gTKVdTHsZE8nwosDmQxvAvMhDoULzIUThjrnLURKUoSM7iX2UgFS/B6x5411Gil8RfA6u+8dW
 rCLwHDBwioBNwGO7Onw7hqYpikapnCwaqqLsEKntOGwgdZeGm33qoicCZJDDw5HsoMGR6oI9J
 tiRtFswwQw9VCneiyKWjqaCTzxG/2o7Kf0DOdTZSGl6HsvR8gkNlxvUvu4Fr13TAQ2TVlkqhz
 XUkMQAT3zXSG/oeVwj2Afcvmwj9DwRP5CCuOfNexUfzSTN+DguR2QzpLG8LdZ/zdw9e3CABpF
 uGA+U4bMtCj9jgPXwnk6HKVh9LgUahEcxmnHVRhmsS+k+VxTBDUb3pBgL01EdClu5JuObykLn
 8Y3zS6EshOdZKHzI2mOAeGALpHlTP9P9kNVZ+akiBynZxP5GkmOGHBrQ+s+NC07ScGVlwZods
 7WpX/UnpUEE5uc7UNJWXInojLyC0YKIo7Yg6usPLbuUFuj31NxTBtPEgDbhXUoGywQ+DZG2VN
 GZSnYNHXVCaQiqfGoV/DIHeJrnuIZkdg7iMKKqtDF29kTBrpIeZQ64Cc7NYn5CDV5Y4wGmT5N
 mb8aE5Ms1mDMrh544wdPMjZGw5ZBTRnPiQifNmNDZ9z2qogOzwBk42l+adS/+IVRTT7huy72R
 PghUz+P1FvvvqTVUgBCY+P9n2oa/loA/fa+RDGmXZ5Uw6U+jgODfg/J7sfNFSW2RoLClOh8QQ
 cVajxkSe6U5WtzO1smbBLl9fGpwCcMMEjR7/cnk3xf5eUqukOI+/58SyouD+iqeBsjU13S47O
 RgniZ7YKv5gEGZzk1/UtODQYCpF9wuXm0BvIOe6AL2aZu9yAxuCS5/I2NqPpXIJig0Qh6kHpy
 LIekZQEnWZY9ZNuZuC6K6CJOgC8dFGLyyTkVQmVUoc0tkBlBRDp4rO/o6VWXMSCKoqUTiWefR
 N0Ui8xHuX+b46pRUJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/30 =E4=B8=8A=E5=8D=883:25, Davidlohr Bueso wrote:
> On Wed, 29 Jan 2020, David Sterba wrote:
>
>> On Wed, Jan 29, 2020 at 10:03:24AM -0800, Davidlohr Bueso wrote:
>>> Use smp_mb__after_atomic() instead of smp_mb() and avoid the
>>> unnecessary barrier for non LL/SC architectures, such as x86.
>>
>> So that's a conflicting advice from what we got when discussing wich
>> barriers to use in 6282675e6708ec78518cc0e9ad1f1f73d7c5c53d and the
>> memory is still fresh. My first idea was to take the
>> smp_mb__after_atomic and __before_atomic variants and after discussion
>> with various people the plain smp_wmb/smp_rmb were suggested and used i=
n
>> the end.
>
> So the patch you mention deals with test_bit(), which is out of the scop=
e
> of smp_mb__{before,after}_atomic() as it's not a RMW operation.
> atomic_inc()
> and set_bit() are, however, meant to use these barriers.

Exactly!
I'm still not convinced to use full barrier for test_bit() and I see no
reason to use any barrier for test_bit().
All mb should only be needed between two or more memory access, thus mb
should sit between set/clear_bit() and other operations, not around
test_bit().

>
>>
>> I can dig the email threads and excerpts from irc conversations, maybe
>> Nik has them at hand too. We do want to get rid of all unnecessary and
>> uncommented barriers in btrfs code, so I appreciate your patch.
>
> Yeah, I struggled with the amount of undocumented barriers, and decided
> not to go down that rabbit hole. This patch is only an equivalent of
> what is currently there. When possible, getting rid of barriers is of
> course better.

BTW, is there any convincing method to do proper mb examination?

I really found it hard to convince others or even myself when mb is
involved.

Thanks,
Qu

>
> Thanks,
> Davidlohr
