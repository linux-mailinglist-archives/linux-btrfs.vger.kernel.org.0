Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84CD28FF18
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404522AbgJPH3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 03:29:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:53889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394538AbgJPH3b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 03:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602833368;
        bh=Jomdj7VmpN8weC9aGRG6kSFSE3bjLUJU8UGq6oSzF2w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iRideI3RjM3s3HbvZvsBdjuBja8gc+Hw70Sj3r/sp50ECc0doNGvH8VWwkqVCTHI+
         NgCqQMPsdZnXXA4EPjDBf35u2xhQdiRKrMWrB46zR6/drpH8pgchWLleMJclt0xU2u
         IDnYrcDYq7AZbiiSH4KONLTbi1nwpT5W2CFYCJ38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1jtQnQ2L9T-00daxK; Fri, 16
 Oct 2020 09:29:28 +0200
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     Nikolay Borisov <nborisov@suse.com>, louis@waffle.tech,
        linux-btrfs@vger.kernel.org
References: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
 <4226ff1b-e313-2881-0670-965e7e98ce59@suse.com>
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
Message-ID: <b4f37e58-496d-818a-35d9-ab0832a6fe61@gmx.com>
Date:   Fri, 16 Oct 2020 15:29:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4226ff1b-e313-2881-0670-965e7e98ce59@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z++fT3x8Cr1FnA2VUTuYViSMDi3He/mvzrvYceozzl697NEKUt9
 zt9HXiYCMpN+lQ3dp1tsVNeJMUXxrB6Rt9KWinN1vQqFTuHfRUEP7V4DSWqcomUvI8aSAVg
 wZwgvw+ml1Ij3OsnS77s8rMKp3/CdY2VdmW40rmdAWLiu/kWw6jauxUq2KiCgZUBLdKuN9l
 nbI5GHmbdsAjBxCDNqqXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BbNeXeiP9vc=:NNeUCkSGKCzsojMOxmuRtm
 9ze0uE68DFUBYawZseJqHIm2HCDexnjnp2V1PgB110DdWax9hcI9ytPuuAjxsb2iqco93XgY6
 tDcNZaX4O8DZ/CnfEfcGfNHuUJldkD9ys/XoRh/b6Lf3SpDvaqZ15t+YEkRcOv1w+efEru/yl
 ve90JOJgUpjzI3hezX4Dcx4v/XoQoy5r54FvJfysLJE0GP1gsATIJjj27UXf7Mhd2Q80CWRty
 RI39frzuuD4cHdNCu/ICFAh9H05gVDZyWPybWD5uoaRKFhXqHKbb4KvANyTZPz92vFc7dN0p8
 Y1pHXC5agJ+61wWhN2pLyKYyOaVzdJEW68vWLW0mgJ4uXJ4fPi1WaPoJSUqWJSBNIcuEHu0yx
 NwBjn4X5w6lkDQgzpdMwHbVV+JtWuyqfj83Sq8W1YOJP/q2tHQlJh9vF46owVMi7MIQzbg7Qb
 nmx+b6xVKHEdUzZEThhPg9C6k36P7E5SRv8ZrKX4G1mCVixByJhwhjliztywKFJbXZEKMrwJl
 gr/lOOmVYm+LWcK0/lxVAo7HL/jlUeM/3g2l1eynlHgGTrAeR+G2pQ+M3jM/eIz8jWhXeujwI
 CKKNTHf0HBqQRUZYpKctuWCjWvhcPHKe9ul31yuUVSfFdxgrT/1EX2zCHxP+amyQLHz0dPhTN
 md1RhcvVvQbYxMh+ej9Dt0xssjpfCuV4S2O/629+NjCJ9mAlzgeul8sO4PaGF7bLA5tfRk5pU
 F07T70IbmCgLiUmEsWu+lpCvqK0Jnzm3c1VgMGv2khyk+voaG7nKb8eCRbXgw0EyaOhp6yduG
 dfmnnhsz6SokNLR9rW8mTgVo77RqRk8LbYaiDyfZpkowjvCrLhZDv6K2oXf3S6uDy10H3ZmEF
 qkBIDI6BzZpojRGb8mKA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/16 =E4=B8=8B=E5=8D=883:15, Nikolay Borisov wrote:
>
>
> On 16.10.20 =D0=B3. 8:59 =D1=87., louis@waffle.tech wrote:
>> Balance RAID1/RAID10 mirror selection via plain round-robin scheduling.=
 This should roughly double throughput for large reads.
>>
>> Signed-off-by: Louis Jencka <louis@waffle.tech>
>
> Can you show numbers substantiating your claims?
>
And isn't this related to the read policy? IIRC some patches are
floating in the mail list to provide the framework of how the read
policy should work.

Those patches aren't yet merged?

Thanks,
Qu
