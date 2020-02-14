Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54115D4CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgBNJet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:34:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:41199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgBNJes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581672881;
        bh=h+Jo1A5Okf9TR4lM23XTj5mIIRZfmoM7d4REjXpn6bg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q3I0k4qXZaaBYzWWjulvIAL+x9sFSHNf6OKwaHwCzkW1iZYsO9ZRx+UyXyrVu1bRT
         ZNG9IGarzFd+Go3r0k3Qx/xBhgaixbAIWdrJTpILCnW1UqWAu26z6AXTO+u8sq+tqX
         yO2yTUEGyMJpQ1HhNKhOVKqM1nphhtMPEYo42FAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1isXUT0ki4-00RXUt; Fri, 14
 Feb 2020 10:34:41 +0100
Subject: Re: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iterator
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-2-wqu@suse.com>
 <e352690f-a368-282a-5328-2bd2237bbecf@suse.com>
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
Message-ID: <c2658498-66a1-d8c9-c3df-76aca01dd0aa@gmx.com>
Date:   Fri, 14 Feb 2020 17:34:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <e352690f-a368-282a-5328-2bd2237bbecf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wa32q4vh44/2WVG98RdeqAJNWRjADacdPgI5pVME1TcLs8NLfIc
 SRJeidqH/94lHC1E5DubH7InDTOCzjCz2bw5xs0EZK5Jc19+PoKZZec2Gxb3nBaBWlXWWjc
 XA03SsCGurkZBgeQzJ9U27N+b0K6tM/W/Kuc6ZEQhQI1dYP8EocUhgmDE/SxD2LhdJZ5qBC
 a3mZoK85gcYngRRDYst4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gZ8AX11ivE=:NMWO5DPdH7H0IveFe/2LcY
 3FO0S4LoP1CcJzivqtOu93/uo1Y5YsQdqHspuUbdgXTV+67KcPLQdIlAB0zFwtCCeEDHef1vm
 4Yapzm8J6/7ezbeerNxp/TTL6LFi5NTTBVOwNenkyOdAWGbM537zcqZrmgSFYDCWw+A9T0zxM
 w7ydLlcMnLOMRy+4kcjqkMACT1qlnw9/y7xjwol9jrL3K5ix1057oJdzByTdMcDGhJHHQYBWi
 gTEnh+unzRZSEeoFJTKeAk8mgBuXd8ot1fGVLUxYiE4yY85N2r3RkKHEwER3eAw7DuCBdj+2m
 pG6ggqC13u772aiSwm/J59qwwIGTICHmBijDCPxq45LkLfrna1zlHXUBljq0GlHO9zd29hne0
 jUUo6r6aQBR5n7ufgJoj8Ro0xgUS0/rgmPvH1qsB+dlUa8g/KK6Yp3IE8Qscl4fsYW9LlJLHS
 NDAoBTGv9G+3G5KFzsp1/JPBB27/Uurs0D57d8tJHKEUuj6YOhxRr3+4rZr+nLSHpxum+pxrv
 xoEkHNvnj4biirX+Z2pKO0BQmDMSdb3dptSyX6Tfqc/XCEum57jggpLjtrj+URzDJ+v9bmF2/
 KURMKZgrvWHS9fP1AS3bnL8WrvzJiEUb3v08b0VLvNSn3mKO6RX95VN9XvzAqVQBi/Kfvh0mO
 68D3Eo71ugy/9CtBf1KtvGoO2xteltzFYO8ktS4IquG9FlvX+10FFSahWwoMfnwXCH4fjKXlX
 AWf+XGE8en5eySIXdcCwFVm+rSQBJ8NdkcYjW/ugrDVRu0VR6EjtxuGzSvn3w6DxlndQc+sfp
 21UlkhBOSXdOVkGMyXieBKoGMOrgxBmBn41CFf2pwXDlcL6KkEfODosoCCNJMbYNhmmwKeJS8
 NJ0DDthPxzGqVtdKpNv41T/j7wkaippki15qTcU2ebtT106vytEE0czxbH4RqT+2xHtfZEhy4
 GbOEZWSaAYuEJ9CplmheXWyjQuSLPo+AcYeyB9FdcEdAt7c2r9j2AX/SDcYlUaCFP4pRQa8Wg
 ytsG+K/GqJk8TACiqZtlqVtLIHQM8A66HZMp02dg9oITSCzvCPhISdeUfW/fc878j4ohlcD+a
 4cH+SpbcBGUVhiy8q5jJC3HuyicixjUP91eWYQwpvkh2hwNVPrit3X5zjBNuZgGL3XrCyHygQ
 ss2+A1wHPlUWp3cyI1Ul6Zf/VKH5vY0l2ruYb9rz2s++SqA0F8cA0TdGvMRVPRhxDMZMp8wo7
 idYgBNX75sI98V/As
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/14 =E4=B8=8B=E5=8D=885:24, Nikolay Borisov wrote:
> <snip>
>
>> + * This helper is here to determine if that's the case.
>> + */
>> +static inline bool btrfs_backref_has_tree_block_info(
>> +		struct btrfs_backref_iterator *iterator)
>> +{
>> +	if (iterator->cur_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY &&
>> +	    iterator->cur_ptr - iterator->item_ptr =3D=3D
>> +	    sizeof(struct btrfs_extent_item))
>> +		return true;
>> +	return false;
>> +}
>> +
>> +int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterat=
or,
>> +				 u64 bytenr);
>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r);
>
> You are exposing a function here which is not implemented. Remove this
> line and add it in the next patch where you actually introduce
> iterator_next.

OK, I'll take this as a generic principle for later patches.

Thanks,
Qu
>
>> +
>>  #endif
>>
