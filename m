Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C50A1B14
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH2NMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 09:12:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:55455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfH2NMC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 09:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567084318;
        bh=3nmBVGm4s2QI0mjqma6HFnT6N6Aor5vEmNmKAE9OlJI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZF4BEjrpVfaonPW0KNroCZjFMX9wINKhJT6d+NkaTX63CQMdG1C0SoQISCMjWWj+V
         gURH1jHapUNULk55unf6Ng4eYC+ZyItLWlm2VkwX+vvOOYwLWocv7pu500mzpra4hE
         rMp9nmsH/nfQPJp1KrUKxoZ6/0WptIxZ54EyeMnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MIuSH-1i5ExR3SNV-002Urm; Thu, 29
 Aug 2019 15:11:58 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Oliver Freyermuth <o.freyermuth@googlemail.com>,
        Hans van Kranenburg <hans@knorrie.org>,
        =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
 <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
 <317a6f8f-3810-4a6c-ba64-3825317de1e7@petaramesh.org>
 <c116d672-a212-f73f-ffdf-fd97aa958135@knorrie.org>
 <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <d0a7ec7d-42c8-ebc4-7d54-28bda3d50e5f@gmx.com>
Date:   Thu, 29 Aug 2019 21:11:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PfAN9mftHseOEE4XFUEwNHz0wYE+D9YsdstEgRfUHBHe32uCmHA
 glJJ91RrBeD37HYmRFD+IVzjEYhmO7BNEntZSn//88BHKkVyEtvvfKkEbmZCD2x22yt/cle
 ohAzqeflZN15eZc/ty8qUOGkYxH/y9gQJi1rPEYoeibUw47TfLvGuSqRwGZVlbaaXnIBZMG
 Kr2rIr4jyRJ7RM8gn0gBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAKbRHL0KxE=:XsOHFYcIk3Zrl/IRDDfXv3
 E9zwAeo9vwfzC3hPf4h4dXOJyYospg/CIcS+l01L4i3gPYkCD4swbi7Z8AccToM72YJYt2hmw
 WOwXjivCTVkR6cuytmnNt6IDr9a+zOLz7FQCqfSayF9ifkcif0XGRhjqPUlkn5vJCsZOBQgF5
 UIqCUCgbXUVNZV2HKGduju+5sNboV9JutqQunl54swunvCuSAiCGmk9VBGPEyZ81X0zfy30ko
 jCQFuJWwNeaq0ChfaZSaMoRNt48ertWn85JcJTORSocMJfngRV4NeoDydn9H6mx51Vt7EfrHO
 J0NAaftrPkUTrlQncVUgDerv7DJZy0JAynV0wmeFSGQBoWXp3KQE8CeFnwNg0vmhyGadcImxV
 +vjibS7Euln4qvUC8O+OZO7WeyjvMlFwBD6YDqa3yy56VO9v1TAO60Dv7BQDoYzHH8O8uEqm5
 hT2Ub5i0CkRDnbp8/hSyMtsk4ZwwHiG4d22CgiHJPTbFvudnJB6jWat91x4GYxmq6lKq/2akI
 PEDlrFuyu5Eglr2JQaqtS3HnQgb8XRStViBOTa035WYxiVtz1bIL94vA5QPO7Wk3re6SbRMvS
 5u4Jq22opVaaRVGBnHsN9ZePb5xlBLkk+nB+dk9W30FEKO1w5WpGyqYJOY1Gx+x1MmMNY1HAv
 TaQx8dhgLbaEB0V6UUG5ui0mgL9PsnLY0yMn66yXphATbu9pM0Z8fOFLbK0jWGFry4qE8GgCd
 ZBqLSSk1IiuoRPsC3kf8J5ciWeYlKUp9CB1H6OzCU3/8edTK6eRTajFEUd3PcbFCLrFizu36x
 tHAiZNCoE9AaqXr7c5uw+n8WdeWnJybxSYYT7c/3E7i+xV6Xdwqh+zLL6Vt1XbkPHJ4wbEcSH
 shQvSn6oTjGYr3pjCalWTbWTmbGsQtUEkvuafOFTqQxRDT5ZBSuTL1N0BIAOMay/weO9RmlJh
 dMJ4w2BDT80c56wsrxDxY5azXZFWCMfDhtRY6h0n/qYcGK4bU5pipzv8u3+jSj63xD5yWtaFn
 B17FYt/m/UJsMwD2JPuYbZK8BRa9iY18Ff9ens4veijwasKB3QVwjpMzV3tvr20Re9YTMBV1N
 BJVos0mdtObR1oksrdDtXVGNHtRUxABErBXiRPAMdrKxfrbhFKTVGJ52tmWV7e1iJG9kD79PC
 IEJpC3YDX9p8OCnykD6MXrr5Sv0al39aCCaZ8YlluvgBoweg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/29 =E4=B8=8B=E5=8D=888:46, Oliver Freyermuth wrote:
> Am 27.08.19 um 14:40 schrieb Hans van Kranenburg:
>> On 8/27/19 11:14 AM, Sw=C3=A2mi Petaramesh wrote:
>>> On 8/27/19 8:52 AM, Qu Wenruo wrote:
>>>>> or to use the V2 space
>>>>> cache generally speaking, on any machine that I use (I had understoo=
d it
>>>>> was useful only on multi-TB filesystems...)
>>>> 10GiB is enough to create large enough block groups to utilize free
>>>> space cache.
>>>> So you can't really escape from free space cache.
>>>
>>> I meant that I had understood that the V2 space cache was preferable t=
o
>>> V1 only for multi-TB filesystems.
>>>
>>> So would you advise to use V2 space cache also for filesystems < 1 TB =
?
>>
>> Yes.
>>
>
> This makes me wonder if it should be the default?

It will be.

Just a spoiler, I believe features like no-holes and v2 space cache will
be default in not so far future.

>
> This thread made me check on my various BTRFS volumes and for almost all=
 of them (in different machines), I find cases of
>  failed to load free space cache for block group XXXX, rebuilding it now
> at several points during the last months in my syslogs - and that's for =
machines without broken memory, for disks for which FUA should be working =
fine,
> without any unsafe shutdowns over their lifetime, and with histories as =
short as only having seen 5.x kernels.

That's interesting. In theory that shouldn't happen, especially without
unsafe shutdown.

But please also be aware that, there is no concrete proof that corrupted
v1 space cache is causing all the problems.
What I said is just, corrupted v1 space cache may cause problem, I need
to at least craft an image to proof my assumption.

>
> So if this may cause harmful side effects, happens without clear origin,=
 and v2 is safer due to being CoW,
> I guess I should switch all my nodes to v2 (or this should become the de=
fault in a future kernel?).

At least, your experience would definitely help the btrfs community.

Thanks,
Qu

>
> Cheers,
> 	Oliver
>
