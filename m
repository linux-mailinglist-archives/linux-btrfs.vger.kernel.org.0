Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0500B135052
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 01:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAIALh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 19:11:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:43785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAIALh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 19:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578528685;
        bh=DWnO07bFdl6GJfwQMeoQBtvBDgKzns114yACLKYbymw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BrGq955FAokfqhqqHdnSIUu7CnE/CRjZvJXCPa8Z6/sx7p0KNu97SITPOKyKloz6Y
         i2+NJC53OCGQnYAsdUPjKQnjZmVjI0C2rXY+oo+IxtQ+x8gLM0BEeVdNnFy/R7kiNn
         mTGA+ZQgrmCw0THrqnMHXDhm2Nf6DSMr9ikbZ74k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1jk2XO3aUs-014j4W; Thu, 09
 Jan 2020 01:11:25 +0100
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
To:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <3b6e5dc3-c1fc-c619-9939-16ffc0f1eacb@toxicpanda.com>
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
Message-ID: <f5d2693b-9b30-e067-1ed5-a40255e8991b@gmx.com>
Date:   Thu, 9 Jan 2020 08:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3b6e5dc3-c1fc-c619-9939-16ffc0f1eacb@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:toUgyd4P3yxn5VnlcO6wUpMRTOmS6tTy2CXkzXz91XIq0Xgo2r+
 lFQkfzQmn5fX/A1f5HRaHtH5t8Dq2fjAza2EdsHfuZE5xpSajWUAAfNS48SbjK3tQqnpNB4
 5rvk7/Mvy7Ix2MbWZubtVgv8uFHonRmiUZcHekZHiThWMIjVfd6ioQEhpBTb2/d3cDIA+Ai
 2p9PKxm9oJ+XM70EUptCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h1dSLdR6oB4=:9IYZ5U293JS7MtJ/E6ZuMe
 FaA+TkoIHNDALGv8Ov1rp6t492Di6xhj275UTvSG+fZ/fHea0+cT3O4AjRXZG5Jil8q6vUL1X
 Xq9vt7ECxZDA2+4Dzrvgn4YGmymhjgcpYrw78m8aB68u4AMuVLD5O+oP/8HvoX/jaVUxOirYW
 SiTS8msbWZHQd9JMoUGjKA5zIHCdJy+eQWKh1PuA4+lVXAaG0CfFRLkcCP12jdE6jgjxaRCjp
 Ojh5CJ7kp7te7pKljwIdWz6QW7nIWazCc/w1VgDbFKuCDJPupTOBZIoaDCRv8OM53wXiG3OWb
 IGM84/pWe2Hn/Xap2FUb5F25tETR36+mjoZElEzbpi19Xam3c2tRv00AcdOP0KPmx4ESS8Qxr
 FR8bWEKqcYsQTjP05ZVV9lF4/IDv6hLyll8C3DXIjdra0P/HH1X1BkWCPZ0q/efWVKh9vc4Dg
 BNp7foA0CtdifkhXJt9q+NlXzysP2IA0mYgj7TV40wpC8zRwGlYcz7GVNCN5r3SOQ74h/hA3N
 H7QrB1HXhvjd/6hs4IpXyS2lgz7JiS0C8pZa0K48QCdQi1/g01PLSjhrB1EpMl6MW3IpWT+rU
 KD3QeRP6++Mo1rDWwNpqarvbtoMWq2axJBNXOzgqWLfDOe1JYc6tFk7h5igyoPa4F/hzKdqJC
 9w1Xh0FnTteBIgCX39a3pSChWHogUVAA45gvAO52BJHHKkLqKFnnYucUSemViHoVZvU3ezp4B
 R9oakG6s6j1fNZbcLW2ALnMSGGVORh3t7WnUn3GLFsLTxqUSJ7cOb+jX9g5fNkB4Rrmi2O/xT
 JbdJH0MYnskaqafH6SC2QNwZYKQ/ZFvrlGYCxGw8XVVZZ4KF9bWXkkMpBxIBrGyRi1+LrjWdS
 uuyCL6Iz6xghG73z/dTmll+TmsFidDidIGxUr/XvORlRqwVgeluP5xekizs++0xt/QnadgLb5
 SL9P6mE+xtiWhGWFEq2EuyiEa6OFk4Pc0OMkmpT34HODN95Gg1jEd/ROB9wIFI6MRS7OVokIz
 7zn5qFFrKLhz9ob7OTgPFplCByDC/sHo7lLJ9HVHNKvnYJ+Rq6D7QpNomWwD03/pT6cFXBmXO
 prxAQ2YXdKtUGpLp7sN2XPygNlZiKspacsyXWiCfQuK4Zx1pVVF9hnraHrnPdtSV+e45vWTvM
 Ff9Z7NFtlZX6JvoCI2rcs1nL+HVA8M5kpjriO/FgoEcuSiIWLz2xWUq7CGoFvSmfa7C0UEbbh
 xlxTJ2W3FCmkoVxtQrZaPGMLJlppM6uZrWrHJlyUs104P6K8Qp/Vi+ZPcxQw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/8 =E4=B8=8B=E5=8D=8811:19, Josef Bacik wrote:
> On 1/8/20 10:03 AM, Nikolay Borisov wrote:
[...]
>>>> + */
>>>> +static bool have_reloc_root(struct btrfs_root *root)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->s=
tate))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>
>>> You still need a smp_mb__after_atomic() here, test_bit is unordered.
>>
>> Nope, that won't do anything, since smp_mb__(After|before)_atomic only
>> orders RMW operations and test_bit is not an RMW operation. From
>> atomic_bitops.txt:
>>
>>
>> Non-RMW ops:
>>
>>
>>
>> =C2=A0=C2=A0 test_bit()
>>
>> Furthermore from atomic_t.txt:
>>
>> The barriers:
>>
>>
>>
>> =C2=A0=C2=A0 smp_mb__{before,after}_atomic()
>>
>>
>>
>> only apply to the RMW atomic ops and can be used to augment/upgrade the
>>
>> ordering inherent to the op.
>
> Right but the document says it's unordered.=C2=A0 The problem we're tryi=
ng to
> address here is making sure _either_ we see BTRFS_ROOT_DEAD_RELOC_TREE
> or we see !root->reloc_root.=C2=A0 Which means we don't want the test_bi=
t
> being re-ordered WRT the clear_bit on the other side.=C2=A0 So the other=
 side
> does
>
> reloc_root =3D NULL;
> smp_mb__before_atomic();
> clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE);

Yes, that's correct.

>
> now say on the other side we get re-ordered and we see reloc_root !=3D
> NULL and we also see !test_bit(BTRFS_ROOT_DEAD_RELOC_TREE), and now
> we're screwed.

That's not possible. With above mb, there are only several possible
results on the reader side:
A: Reloc_root =3D=3D PTR, and DEAD_RELOC_TREE : Before NULL assignment
B: Reloc_root =3D=3D NULL, and DEAD_RELOC_TREE: after NULL assignment
C: Reloc_root =3D=3D NULL, no DEAD_RELOC_TREE: after clear_bit().

That's what mb() is doing, killing the unwanted case:
D: Reloc_root =3D=3D PTR, no DEAD_RELOC_TREE.

On the reader side, even with the mb, the test_bit() can happen whatever
they want, mb makes no sense for *single* memory access.

>
> The smp_mb__after_atomic() guarantees that the re-ordering doesn't
> happen, correct?

That smp_mb() has no effect, as it's not defining any extra order, since
there is no extra memory access to start with.

And definitely has nothing to do with reader side, as reader can really
happen whenever they like.


=46rom what I learnt recently, mb is only needed between at least *two*
memory access where the order is really important (to say, kill certain
re-order possibility).

If there are no two critical accesses at both side, then a mb makes no
sense.

Hopes this would help.

Thanks,
Qu

>
> I realize that this is mostly a moot point on real architectures, but
> I'm looking at things like ARM where test_bit() uses the generic asm
> helper, which could definitely be re-ordered as it's nothing special.=C2=
=A0
> Thanks,
>
> Josef
>
