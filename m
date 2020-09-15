Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B042126A2AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIOKEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:04:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:59615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgIOKEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600164249;
        bh=6apMcAqVnDHXbV+Glm1RPV/CALLiIuQS7hLDgKhKPIc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=houZWfYWxbNTYN8bGdfO4/dH+32bM1QTyG9fiT71Q3B3T7MHuSdZGrxOgfEFqAPf1
         dPG0TKQepSxVouro7DdKMcovqhz6+tagGu3qZcGkIiDChLZ9K+uIK8Kd1zT7eH3Kee
         KExmcQcNsRsAIom6jjGzqV8L26qMml/OieSB7Hg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1kxUuV0pmh-00fham; Tue, 15
 Sep 2020 12:04:09 +0200
Subject: Re: [PATCH v2 05/19] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-6-wqu@suse.com>
 <SN4PR0401MB35989CC0C4C17E2FA93A2AC09B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <03ad022a-6ad2-5eab-66ea-008a97104189@gmx.com>
Date:   Tue, 15 Sep 2020 18:04:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35989CC0C4C17E2FA93A2AC09B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZx6fwPXgTyJh4eOb2kooyi+ok8QKVmMQnj5ppKdhZrhyVbSHW/
 1S/RGAtORGmKGpJ1beJBaFovcI7J+GqByXk+XVOjcd+2KNrRuU8T21kMgO7lfEAEnRZEfWy
 1mds+8wxxBApSNNawsiVDtRp5ilP0lQvNBKsWLQ7ps8ndFrrvcfj8fD1VLG3Z2iXOU/6OXg
 OKWWNCT6UTYvipV382TGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAfPkXg1F2E=:fTuvzDqel05Av8gOfrDBnd
 1Eq1EFCtSQZ7QG0KOV5yMakWhDti5UkRHtZh3/u4kfUUxv14Q9C4vfCWuIl+SBUCvrlsDCQR7
 kqor5TFWmhNFPDS6kb2bKdnbDe7T4TH8IUu3n3Hk4AGlXJ2zHBdnCgxsXwPvr1TJ8S5PI5xJs
 H0ihDKOWhSItpRAJttMk0kGEvMeGV7i9re0KwcvWoYIJR+8cPlG7cvK5GJ76tmCHSGzW+9gw8
 2mplhuUOx/OT4DDeUzhjAPKtheg7DawpmjXSq4x7gURv+iPpn1wHcpR0BEdYNv983M91h6kC7
 tG8gWRss3Y5rpXQ0vEVslZYKnTf5iPMZN8NJP5OLZyHpS82hxVcbjwTtGMCEfl/Jym7U3n4Vs
 wzFBcw62nOcMYPBUHaX0KNepxn095HMCiOuUyRDTnbSSMgES7LsFxTdJ23uCYx95lFfIa3Lh9
 8I6tV1b8WDwiSUVAbXTV0q0StcQe0V9wUiAvOCVnE5yGGW2l0ODBKeFIEjYWRFcn7dMYPHn8e
 kONpkgJWV/chbELxRE6fhQnxs7KBGOSzE9E+BgxlexWU87MSnyhroGTmhLnzl07AE+oBTfzeZ
 HtEjv8emkkAYepWfJG5ilyGGQt4EV2tk08dLCorAIHPFit1b3PuD65fzLVloudBvb8V+aDIq5
 GHLU6ds9v7m41J5jFPlHVlLmfvjXFar7JK2A994L8rXMMIhdHKgb3MwSS0P7j4Oda5mzSKChB
 WtT7119khbwt3DJ0JNuvE5DrWN9mWcLbJd9NQf9qxWimSoHQMFyy/siS6v840ZRUe2RNMWq5e
 DhSKet7wCSsYV19VFMGfJyRL93JK9CBk/eNXeA5Wc89dT60aHlBSf/M7v76K+oAFsCiQrNGHn
 cNhzmGW6InXHyk61N1bs7if/P2kzv1VaJ7BeD5yARMQiQNWMdMsoT40PfQtLoITdHNevW0vCW
 nqy7NiDiBAuGnfwqLqIXpD/Zyz4juuW7m4Ia+B8b4tEo0MaNTftNlTN/juSmiW2cMHEiHyrZJ
 CDlsIJY3hrMCfe1kH3rP3sVE1DH/4gjyhYyCKkg1XGo5XWgJXEXhXV6nZgtyQzmFNvjCqtvZi
 BbDXZtQ+4VLzTzXnIc+GrWLb35TnvWhCdTuNS4Rkw0rRM3LFK2q0Zgk6wlHR07x0L6YtNaIDy
 qTkhFiGN3E6w229qFi+T67eRN/J7zeSVouibFXdHuxupSpmCrp+D18HhrXP3vtdcPsw3jVQN+
 lvSEhtsuAG0C8zv21GSDe7NS+hD8g53X+X6tThw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/15 =E4=B8=8B=E5=8D=884:27, Johannes Thumshirn wrote:
> On 15/09/2020 07:36, Qu Wenruo wrote:
>>  	eb =3D radix_tree_lookup(&fs_info->buffer_radix,
>> -			       start >> PAGE_SHIFT);
>> +			       start / fs_info->sectorsize);
>
>
> These should be div_u64(start, fs_info->sectorsize) I think.
> At least 'start' is a u64.
>
Do we need to call div_u64() if it's u64/u32?

Anyway, the final version would utilize something like sector_shift.

Thanks,
Qu
