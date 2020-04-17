Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678FB1ADB3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgDQKhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 06:37:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:60803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgDQKhS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 06:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587119828;
        bh=oDEQvYKxjhKzmg/weJvIkF9pFJJXP/6CzHZckGmAqGI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BDBCMnoqpaoTD4Il1zxt5N5j5xN2J1EZFOhJQP4qbcHrqBUatuUxVNGiyzdGASqQB
         0CDup5xWEvE9iXq/Hln9murnGH4b69xzq2zGh3jP2e91qjSkjP5L/hguamp78HkNio
         fb6vvx83Z0PpucA/aaUz8+Te7zgJehAsoMBvDWT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1jVlEY2KWf-00BH0g; Fri, 17
 Apr 2020 12:37:08 +0200
Subject: Re: [PATCH] btrfs: Remove the duplicated @level parameter for
 btrfs_bin_search()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marek Behun <marek.behun@nic.cz>
References: <20200417070821.65806-1-wqu@suse.com>
 <288c5af4-7d5e-4618-2a29-6a871e667dd3@suse.com>
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
Message-ID: <b577ab05-49e1-b1d9-18ae-578d5ebe3bc9@gmx.com>
Date:   Fri, 17 Apr 2020 18:37:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <288c5af4-7d5e-4618-2a29-6a871e667dd3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M3LqD+rL1cgHPKpaTgpu/uZ235ldCG5qOM0UBivvFOOOyyZ1oZK
 PzyGndBgqlwRdB6vz2epOJIrIenr4E21NrasdeWtyNLa6uyqwuX8oWSCyK1iTHj3TD01d3Y
 mPKbPt3MNJjLADrZ8aNu1w8vwv64WiVQklXWHdRSwxSG6KgQblkbw5cvAWUa1Y7SDgc7Kph
 jolTIUO3ylB6QvPQaAa3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+E/EMbOtNC8=:A54mVSDmtyvOi1B93VPw8n
 kAOHvd4CljxrIFPuiQlzJpNx5fw8BnfQsMm+6F4uBu+4PRh4LOh3C7kZIh/9d3tptIIsbz5uC
 KLl0MGT29w+fM0WTwaprmJMK40EoFSELh4b3eoulf9Fm29sNm0RnUHQqJkb2xUnL39jhloKZg
 heZVLEAGE95WX4wqTzvcpnlwYv9RJDCQlMFM8xdVwYGJPxsm289sLuxPl7vlVtPvd8MP2A9Ct
 uA/1PVlJVJuDlTzN88pUebXrDmfYMXFii85zWlwrFKMqiPTnPR/gyx7ZtCFUUo4sBAqxTwoZB
 OsJ7VNOrSVUbIFL22C+rvvxWX1unUe9B/gQ2mI5NBlpU6gdpTTU9cV0NxAyQYfkF+d5FFV74L
 VB9oADYU+ePrhksVu1UGfktk0+JOQ+qj6YXQ3Zv0R3h7taKKZd5Cc7CmffxcaqTGnBp2OCJoS
 4ifnSnQ2I0RlQGkdJAv9GMPYiGXxQAq9H/25MzXh+F9cA8CfwDXMd7GzGA3bIKbZZ4U3RXezE
 lPzdrqmHmftEz7SX3d5UWYBOQFyzPAxjuG1N+TUEb4cJrpEQGNNMfuywDVcqtFxo/rLvGTgLQ
 BE8VCmczYXI2LQkfWpkDqvmggXCEdqDSMduu4weL8H0AN1W0jSu5tnUd6D8T/GD/fKKJNP0/d
 Ms6EbghhyiAVUYABLbKzD9HHkTlvo1A2XjBnrDz+9effIA5Y03/zgt4MJxeWSx3wD111zNPoC
 FaNOi/S52kLz23EZYj8xsuOUahtuSjc8/7UES0yOvwroXqaQbA22Z0ys7O6e4GuKR11sHrzkz
 Wbts3AwFKwG+s1YhyoB82JnMzXE469n+Z8dE8a2ATNPQuzN+C2GDa1Y3n9hVNMjxDqLANn2Mn
 bRBzkZ9iInHC/8BjsQpUxeYpX4xoehD58FucxPADbDI3VI7uAHCSSFccvG08tEumRP4Jb/GxK
 nlQ4wcutilaiXJGdAAfNNBtTtXMoQBkhqL4XQjtSGzgkViQAjKd7NU+p5qhZFRsIMflnyhxRH
 88RZaBNkoAKP8xr8i9XgUaBOplKeHmJNhzTMHYypFMFLESMgs5rhIJcSSIt1ln+J3ztMw/vG+
 Yvtzo8unC1rusEJWtTaRK3cOS6U8vOa2EOjWNOkUjrpl+EGTNh3gEc0nqhPQoyssczNNVYLVw
 gfMECAvQb8qVNvBPS/l054YY7YGdKH2IifxdGJpsTCBziHbOiCFX9aBWJbl562pdTPWsmHBHT
 0tSdmZVF9lZg0MzzC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/17 =E4=B8=8B=E5=8D=885:03, Nikolay Borisov wrote:
>
>
> On 17.04.20 =D0=B3. 10:08 =D1=87., Qu Wenruo wrote:
>> We can easily get the level from @eb parameter, thus the level is not
>> needed.
>>
>> This is inspired by the work of Marek in U-boot.
>>
>> Cc: Marek Behun <marek.behun@nic.cz>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
> <snip>
>
>> @@ -2953,8 +2952,7 @@ static int do_relocation(struct btrfs_trans_handl=
e *trans,
>>  			slot =3D path->slots[upper->level];
>>  			btrfs_release_path(path);
>>  		} else {
>> -			ret =3D btrfs_bin_search(upper->eb, key, upper->level,
>> -					       &slot);
>> +			ret =3D btrfs_bin_search(upper->eb, key, &slot);
>
> nit: By the same token why does btrfs_backref_node need an explicit
> level member if its level is always equal to that of eb->level ?

I guess because btrfs_backref_node::eb is not always ensured to exist.

Thanks,
Qu
>
> <snip>
>>
