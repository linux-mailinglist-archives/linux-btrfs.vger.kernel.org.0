Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6761570F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJIrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 03:47:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:40413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBJIrT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 03:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581324430;
        bh=WcH01ILjvgfjBi8X7iaF+Rcj9InhUXxl1KON/VyJtac=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=dOxScJr//vjiW9zIgDCV9WnCSAoMQ+iot/OSFRj36v1Yn43fTiY4VLSBnU2L2uu+c
         adqtwIHWF4xJoE5eS7HAF1Jf1GWTrfdtjkhrOWZxMWj4Yap7cXrz19Y/5G4rQ0AQwp
         zpC93/T+0TWOfxZVzrNQV94EWzcu5pvJgq2B59Ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1j5BSW1zCz-004hje; Mon, 10
 Feb 2020 09:47:10 +0100
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
 <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
 <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
 <73b9d157-840b-b93f-b86a-5041745f08ce@gmx.com>
 <2937988f-3ebc-8cd8-a6dd-82648faf126e@suse.com>
 <f0d9163c-fd33-907a-b5ae-dd9a5c42507c@gmx.com>
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
Message-ID: <94b304a2-fe1c-2bb5-ad13-d7757432e657@gmx.com>
Date:   Mon, 10 Feb 2020 16:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f0d9163c-fd33-907a-b5ae-dd9a5c42507c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P6/YgJtX6GsDj9LyGi3kqExdtfcMG8MQZCTtoKfuD8pq0uDso6l
 CEtfo8d9xBDkyTRADZ+ccWQgV3h+/ivAXF8iLgjnDfVjqfkEny9Bs/9gaP53t57GOohq3lE
 oPIkdT3zXpNO29NIO0ggAJ4M5bhjzdcC32bicEEtCNiJ63AWuV/rKmU3bbRr/9q6zwVZj8r
 Sz2BLzvw6kpARM3857Wtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SII7Hq3m3OQ=:lSJhW78EV58RjxaqWnmS4g
 ebqRfBzV98FCFDvGv7mlps+h0/AbzoP8A04h/ZUxn6Bw5Ng057JgB6RjgFH3eibbp5BjHGwJ+
 dy5tbj3Jh4fS97/HWDeIxtBGcR+XL8hjcH8XNBJymnsNtFgpS5da6vC37TjdRG9YB+5cX+GmO
 ZIT5TkrusFDx2bLHJpuKd4HcGUXFgUiXHC2JwH6DvmdWzuNR399JBV+yvA9Z3dT08scR/e8kY
 24VaBS4Q72n7LJRuIJoG8Z50bfEwzkNC62h8MFXIkyaxJ1yi+5TznTiqaAiNjjCxBZ+7ab5xa
 BjswnCBTELZjNhN8a/MdaPEKWO3Cb5vGnkqJTYy96LdXJiAAf6SO6OyxfLPN3cOdtGsV7aeai
 9ZdtahY18/z0KA1aFU+4sKEW+lQC0USz8EeUgIc0aeNF+JElj0XdO5lcnakt9gISt0q2pT3gQ
 P5N5KlXz3dVAyTeayHlO7wEbkXJsf0tPSkNco3mfrKJ2VOG63YQPMiBLKoNwF7iala5lbGPRq
 wAXMzoqFqqzJRKcBxIgs4B+fl/sjqyClKhR0qxKQ43NAX9R7/j15D6qHCZZk6qPwsWwtr8e8g
 DCjYquX3YCL1nDRwJb5tP7TY6I4NJMy7//TjsdCDlR2ETIrE482ATAnSOhNM/L1vOKVNCzb5M
 9dPVXCBUNfSc6R6uDU1d6NzoN2rFxQ4pJfX98EgVAHNHbRMbdGKaoG1ndVSLWkO0xkp2RtfNG
 1fENJycHhwWijSZgg6dVEAA3BwmKtDcf3xBuH4CbamF8B4M2ujaD+xXe1nTFdhVLJBtiI8RFc
 jPFlA91WmzJFjEjk5yYav9GoMGIVc6yGzDdMdMrjG9HJUxhDBwadtlXMKTpAVMe1BXTrUh9Y0
 r5ivYBXdEyPGdc9qPH77XnCDUyX/l2iS144xrcF+GiH1+pPUxgl0f+vN6KZvauG5HvW8xczTV
 gKu/c3jv7HVa7JtW0JHxT8nCWjJhFqhvJKHaP64aynklcjRmvDkz0sTye3D1oqQRtHwdZeC/N
 nUnXvB1cI2p7S9WOTfKKFlRBSOw1RjkJ7WKp1nJdU2/xl4bSGoveFF0WVAA416JZXa8XKjBhS
 pMfkBjHga0zZF7IDRP5SCrW72QMjF7qPFylWZAXY6JG4nwjakhCESSEratb3NPB0h8RR4DCrf
 W6httnOUWvf7K6yXqlI9ymgUpoqMcQbjKd6n38zc4k6cTUURf/FmeSvbQRgu2DoJPaLnSDpM0
 SygmRtN4e++2FP5yJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/10 =E4=B8=8B=E5=8D=883:55, Qu Wenruo wrote:

>>>
>>> That looks like a valid workaround.
>>>
>>> Although the immediate number 5 looks no that generic for all test
>>> environments.
>>>
>>> I really hope to find a stable way to wait for all subvolume drops oth=
er
>>> than rely on some hard coded numbers.
>>
>>  what about btrfs filesystem sync?
>
> The only cleaner related work of that ioctl is waking up
> transaction_kthread, which will also wake up cleaner_kthread.
>
> It triggers clean up, but not wait for it.
>
> And my first run of such added fi sync failed too, so not good enough I
> guess.

Although 'fi sync' does nothing better than vanilla sync, Nikolay also
mentioned about 'subv sync', which does the trick!

Nikolay rocks!

That would be the proper way to solve the problem.
And it's time to update the man page of `btrfs-filesystme`.

Thanks,
Qu

>
> Thanks,
> Qu
>
>
>>
>>
>> <snip>
>>
