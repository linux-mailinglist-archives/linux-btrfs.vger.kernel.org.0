Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB263296F98
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464007AbgJWMqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 08:46:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:54025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463977AbgJWMqC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 08:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603457152;
        bh=9rX8rHEYo6ArFl8Lj/eBUMQpX1da3flwIIeW1bR6Wys=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HtSzksGC338zJlTeOf5vZtEVHD5ipwm2arKjUjFT14ZasOeWMgLWshdCjbYjmRl/1
         8ZKBCjjePvTX0dVIN5nPMLEFhClXU6uMciJ6sw66KHm9O4nx6jNo8BELEYgD8l8gUe
         +DsI7GyFwod/jRkwnm+j8fDE+NUm7nxrWrqSylYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1kaMHv1KWe-00DKTK; Fri, 23
 Oct 2020 14:45:51 +0200
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20201023101145.GB19860@angband.pl>
 <d7ee1c25-ceea-0471-9702-0622a5ef4453@gmx.com>
 <20201023203742.B13F.409509F4@e16-tech.com>
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
Message-ID: <acb58507-ca7a-ddbd-88c1-cd35a127bb64@gmx.com>
Date:   Fri, 23 Oct 2020 20:45:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023203742.B13F.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iwiXw7EQoDdwMcpgsD+bHbMJ8SLZ2Jz8PExMYUIETjJq6jr04TW
 VJQFPJSAAqGUu8U2ZIPHSEAbG/tmuqJevnwOX9Rg3KIIk2sSMjh5AbM/dyy/Fib/5/iMmj1
 /bcQdu64vsXUytgqC810EjsliJPg+RUw3HfXd70p4xw0tqfnWOkX8pc3OE9kh332bo7OZn+
 xJSgV4OCTa89p1z9xDluw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JJMx5icy84Q=:bksFCdNhvjF3jiwEUm9BkW
 c0S7oKWgD+sUcm1Zj2SUZ3MekV+IyeadKsoFmlb0/jgwSKN/1KzdMpcgVguTi0YnIMAISAJaZ
 b6Uc7nat926Wt2Hyp5zN3TuzIRWXwkCzIEAjbqtObVWQCvNWltbi24mlikZTkeVyzOJwg8HXe
 zAtkeqatpKNWbDeWp4+EuaT8fFqkjAQoZUZ/zzbZlzL7y6QWawjVkEaVSxjGUZDdm0f522lIt
 1TDJ9khMifjiwwZWVSEixgoIIt9u89mVAcgIpvVqAak/OKr9kQlsMXFEdWOUmHzrUkoxcKlFm
 +FSi/Co7hYPeHJb8NxoHBSMjDUdvfGYH4nWc20+ZK9IjscuCzV157Ryj5tNgrN/HDtuNWKTC+
 kgbr7e/t+OYt2GQoJGEV8lGrg9LGj2g5vVesurKnEbkfSDLNDCnu/yJhRuEg72x48IixN1GzG
 q4EX5PMkijWl89t5zZD5zXYbS+j3ynqzo3CbrpJptyF6YLK8vhcsVk2SXgDY8GeKAfBG44vlI
 PHkOih5S+2hUqkx4bUzf0JAbVDJGq5udvb4lw396vOGGGZx7/pXvOBpRx47eEoVnWOtMnK9MC
 Hljbf0nPQvAzihx94EeBaFGCEE0WSfoDm2HdmptEGq4848uAAbOKESqI2u+FDfIUUr/QJSNMW
 +QUM0wgCQO5BycIK6lS9y3kh/PD5+CVdYIPEcj5+KkeHtCEI4odx8RtiEW2Mh8EskilaBBTI5
 TFFkw2SV8pYZ6bYC8639KoSClWu3/S7kSVy4IjIHRMqgUg5tzbbzURr4J5C/gXtUNtmw0pjQi
 SFEt71hjTlkBosI4eA9uv6m5NUpPKdqeWCmk9cBu7I9GLGyW3t6NMR9znCUvEvDn++B8Bby2e
 XdwEns/PsqpBr2XoTO2Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/23 =E4=B8=8B=E5=8D=888:37, Wang Yugui wrote:
> Hi,
>
> Can we add the feature of 'Storage Tiering' to btrfs for these use cases=
?

Feel free to contribute.

Although it seems pretty hard already, too many factors are involved,
from extent allocator to chunk allocator.

Just consider how complex things are for bcache, it won't be a simple
feature at all.

Thanks,
Qu
>
> 1) use faster tier firstly for metadata
>
> 2) only the subvol with higher tier can save data to
>     the higher tier disk?
>
> 3) use faster tier firstly for mirror selection of RAID1/RAID10
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2020/10/23
>
>
