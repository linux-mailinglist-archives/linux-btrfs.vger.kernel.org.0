Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73D2B88AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgKRXsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:48:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:35579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgKRXse (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605743311;
        bh=L35EQExmcgLV9q29Acutr4AiHGncTDzF72roUXLch7k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ButN28MnKo9fxlMCD8o2oOLlg2+jVxnfoKS5wm47e2yZQYgFu4R0u3POHtF3ra1sz
         xCeohCCzeVJqBsy+iZk2zfpEeKZXGIiRYkSJVHu//sdYzTHwLhRulMO2IQ2zPj0w+g
         yX9P3jhKxW1MVRU8hH3IaDyPryzboIFSigXGs/sM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wq3-1kGxzr2igT-012IoM; Thu, 19
 Nov 2020 00:48:31 +0100
Subject: Re: [PATCH v2 15/24] btrfs: extent-io: make type of
 extent_state::state to be at least 32 bits
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-16-wqu@suse.com>
 <20201118161157.bazycid5hnz4iapf@twin.jikos.cz>
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
Message-ID: <a2ac82fa-bcf8-a54c-181b-9492893aa6a3@gmx.com>
Date:   Thu, 19 Nov 2020 07:48:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118161157.bazycid5hnz4iapf@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxGocrZrdjYeL32mAS27Uv0R3qSDuYAeuN+7AA5aOWrqbBm5IbM
 aSJeA0IFsUB7X4Zk5OvwFsxBgrzIAY5Z8jkKp1ByjMZIzSCB/yvC64HMA3amX4rolpK9a/2
 LuyNrEDAfvmW81mU6cvxef6GOcphTtjfW9ZFepvQIriWTAGZ1JFoZhaeZWAmnpEVB//W8/8
 JEFvm9lM/iIoiwa1vs4kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5rLHEzapfvs=:Zbx6vuBw7LznuH6EDofZSf
 AtpcewXWkQC0l+baVw3di49CyQzZL6QJz5YthFODvwHP2Cg6Y8kl4hxwrABTfm94DD5OSUL0+
 OjSh25kO+MIdXSMtpa0wGtlPhvtgjRDYPQb9C+0D0pipICCbT9sRhOAr3F6eMJc/4ThsqtBZZ
 +ZHaiRaL6S2ZXxYeaHZq6Eg8IaGDauI6rTghrv62wKE++Of9u9V9tyO7XHe5q5BqY3p9OBuZw
 wrCc9fqSr+qMDjdtBeVk8zIGvrVdzBcEd4jlJZaquXGNd7G0zX2rA8pCdDLLD6fSkMbJYfsLU
 iqzC+IOu1pvY6fsh4TpgS26FqYg6wI5AyaBrrXaoo4bL0yFtVEABY8aFif6i+SnbxuVsgQ2qI
 MwYnnrinw7pPG915HHAU4j6CAJBmTX5UcFbucWcbZKJrZ4kRfanR+G3/WeFoCEGi4ta5ia0sO
 NCXgzvOvIEnLzETIt4taKOdgm8sI0hG1NSUmgShWOqiGeRwQMh8bNBEPa+Wk0sUEIMsrbNc6l
 Wri6HihPltQVYi6P0iW1mAYcp1lHyr8sN3IX8s5+TnT9hT86XGVCjB9NwWRBMeNZticsDubsp
 XO5wq2DBpaBkq13CqmmLpkh0qLQjlgrlDLoF9w3nq6QKMSLs4P/OpOCo+3PTj8bPZOAdj02zg
 53JHln6AAJx6lvN6N1RuTxtiGIcUERIzr9vft7C3G9ARLs9XFET09S/jAP002yg3+TkoOqrdb
 u+1pVgEBSP4N+ZzalEfIWDHBj73p8H7V9Zx14CHqyyeJOA8xSwnfjsQCxvdEwil1m86IOja/v
 hl8gcPpxzJVEvn/1CftxrksIIYXINJhOeAOlTospxnXGbsHgFfVuoGCGPrOEEQOQBFJ+4U21S
 JmKIo/MI15KutNKqfOtw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/19 =E4=B8=8A=E5=8D=8812:11, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:40PM +0800, Qu Wenruo wrote:
>> Currently we use 'unsigned' for extent_state::state, which is only ensu=
red
>> to be at least 16 bits.
>
> Ensured maybe by the C standard but we use u32 and 'unsigned int'
> interchangably everywhere. There are some inferior architectures that
> use different type witdths, but all we care is 32bit and 64bit.

Personally speaking, that's not a good practice at all.

You'll never know when you'll hit a new arch.

One best example here is subpage testing. I believe you're also
utilizing arch64 to do the test, and thankfully it has all the same
widths here, but you can never be that sure.

>
>> But for incoming subpage support, we are going to introduce more bits,
>> thus we will go beyond 16 bits.
>>
>> To support this, make extent_state::state at least 32bit and to be more
>> explicit, we use "u32" to be clear about the max supported bits.
>
> Yeah that's fine to make the expected width requirement explicit.
>

As long as this can be merged, I'm completely fine though.

Thanks,
Qu
