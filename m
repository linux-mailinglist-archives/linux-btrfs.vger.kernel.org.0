Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167C2A8C63
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 03:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgKFCBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 21:01:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:35397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbgKFCBf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 21:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604628092;
        bh=/XjwszurCOIOrJRqwWZBCsq8qZpmYYN9EA1ZzEoEpxk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JwcMJlFo3AqavNIbFouavWji0uRzT/iAZpWpzBZ2x2wLmUcI78GXYDW2rujx/OZOw
         g5U4TwdZoX0l33e+BTiHVpTaLp+TpsfGTqHh5LElYjK56j/iilrdXxGHsZMSu0X3/S
         yWzkSpEjp0TTqtY6nTsNkvBrTFLTpJ9RP0zVSRrg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1kfGuZ2bIm-004TBr; Fri, 06
 Nov 2020 03:01:32 +0100
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
Message-ID: <4a4a20ed-93de-65c4-feab-0a4f5a8680ef@gmx.com>
Date:   Fri, 6 Nov 2020 10:01:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <07ee7ff2-e2b1-5318-b72e-8bff87231036@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBjvcbTkHtKGZ+L8BQxEpSUXm1H857LyPxx9i/6D4LVFyYsi15X
 eEgejMWJzLK91tgj8foGzKnld8YDSBONkC+o8xkGLTaNksNbVA73zMzG9aT25PCJYOAj2A3
 cpHnHuY+H4g9LoqXpZu3DqXR3dmZBY1nvlnAYyARV9yOXv8Qs2RTYbYC5kBXi1QazMp5MPw
 AI5in+6J7dvALwUP3LdHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHxrzlpKEec=:OqIcvVLu/8MmTt+pmg4ydr
 ERwRzv5lZUWZ+xu8Gf5P5slmtOtVavygIMz0dEsbpC79zVqxG1tE6dYFbZvrN0Mb1mASVWvWN
 xULngyZ4opNWc342MIa4iS+qT+xyk+B5JwOolM5C6pV0cZNmQqJwtyjzvfyPQNw6JtwfbVuDQ
 4kl7XTkUXLRaCk8zPO9w40CYYSsSSr2dlFrvMV6ao0NdedEggmtI1n8kW/7VzEv4QUdpbJG/6
 EU8B/2gxKw669sIorz7qztt0zg6GEOOKpk5JMCeq0v5uzfz+KTX+f0Bwcmkz8y9M3gSCpJv8v
 DNEIVwLNGsXhUEW6BdZiXC0a//E5kr6u4R+nQyHBEf/xjoF0IZKfgYEt3isI5aj1kRYZs9Vgr
 HgPjBFVrBNfplMbwW9Z+aR3m63cqvmxy1JBOZrhYyVi9NMSJYIwps//RB9NIqYq/xiL5JYBWy
 O46bCO7mw+ZDQLyMZzros71f9QdKODgdyZUcOo/P5bYn64H2wg+3+4pkei3kxaijTiik+as9+
 Y95ohalTI8AhLZZix+8JAQxKanB/4RdfQ0p9EzBpF+nmuolVpT6Kbz5UOTIStxiFBnL/q+XB/
 oWlzjepKlcLbH61fH2UM+ATESYw1tQ9zPe9Kx8i0a9UxyvJ7iHLfUgIc91eNDOsDqznHFRAQ8
 7F9koyJfLsCWxQEsGDK+3zQc03suzN8OccdUfg1X9vrxkfDjAiphvsng7+FWRWe/aosEwHol3
 NGecmCjWWLPtkq7NmuKhpf7IeU0e7cEd7QSu9ugAmbXfWZ8QHRS6HjdVzO/6Mh94O/4RU/rKV
 ndjuDb84SkMJt/djTdq0rYmqkEoPSctAthhVap+f1lpukToXGX6FgkBhbqxm/guNLk9CjLcj8
 502A5zsJlsq7h9yCZrtQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

...
>
> Can't answer that without quantifying what the performance impact is so
> we can properly judge complexity/performance trade-off!
> First I'd like to have numbers showing what the overhead otherwise it
> will be impossible to tell if whatever approach you choose brings any
> improvements.

You and Josef are right. The too many extra extent io tree call is
greatly hammering the performance of endio function.

Just a very basic average execution time around that part shows obvious
performance drop (read 1GiB file):

BEFORE: (Execution time between the page_unlock() and the end of the loop)
total_time=3D117795112ns nr_events=3D262144
avg=3D449.35ns

AFTER: (execution time for the two functions at the end of the loop)
total_time=3D3058216317ns nr_events=3D262144
avg=3D11666.17ns

So, definitely NACK.

I'll switch back to the old behavior, but still try to enhance its
readability.

Thanks,
Qu

>
> <snip>
>
>>> Also bear in mind that this happens in a critical endio context, which
>>> uses GFP_ATOMIC allocations so if we get ENOSPC it would be rather bad=
.
>>
>> I know you mean -ENOMEM.
>
> Yep, my bad.
>
>>
>> But the true is, except the leading/tailing sector of the extent, we
>> shouldn't really cause extra split/allocation.
>
> That's something you assume so the real behavior might be different,
> again I think we need to experiment to better understand the behavior.
>
> <snip>
>
>>> I definitely like the new code however without quantifying what's the
>>> increase of number of calls of endio_readpage_release_extent I'd rathe=
r
>>> not merge it.
>>
>> Your point stands.
>>
>> I could add a new wrapper to do the same thing, but with a small help
>> from some new structure to really record the
>> inode/extent_start/extent_len internally.
>>
>> The end result should be the same in the endio function, but much easie=
r
>> to read. (The complex part would definite have more comment)
>>
>> What about this solution?
>
> IMO the best course of action is to measure the length of extents being
> unlocked in the old version of the code and the number of bvecs in a
> bio. That way you would be able to extrapolate with the new version of
> the code how many more calls to extent unlock would have been made. This
> will tell you how effective this optimisation really is and if it's
> worth keeping around.
>
> <snip>
>
