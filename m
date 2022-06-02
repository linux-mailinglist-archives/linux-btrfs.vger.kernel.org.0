Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8997253BAD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiFBOdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiFBOdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 10:33:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F705281850
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654180394;
        bh=VwVaQ3cgDqpn4C9+XjzTqtjFwEuwWxlDed4sj3bEohQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=a8Y++EaSHGonBiMvOCsrlTc2DD9qVQsyx9rU3cVcwzHCqXDk4DM0m52DnPQl35Tbs
         twTp7L7SfzQUEXp+3Mme3VQlpDn+cyIkTaf/KjxR4jlKfagmw5hRWozK/zMX+Kea4R
         ZrxvUbdQAHeYIZF5zjVnMAuUr8WtBJJ922ui7/zM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.0.100] ([217.227.44.38]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1nsw8W1fAA-004z1U; Thu, 02
 Jun 2022 16:33:14 +0200
Message-ID: <0b5e9439-68c1-0f4b-8e82-2f566b61fdda@gmx.de>
Date:   Thu, 2 Jun 2022 16:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [HELP] open_ctree failed when mounting RAID1
Content-Language: en-US
To:     Jussi Kansanen <jussi.kansanen@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
 <d26ecc30-409a-ad22-74cb-39da3d83b6f9@gmail.com>
From:   =?UTF-8?Q?Lucas_R=c3=bcckert?= <lucas.rueckert@gmx.de>
In-Reply-To: <d26ecc30-409a-ad22-74cb-39da3d83b6f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B7m62WNhQ2GqksCJfUezfXb6Yn8ougo13Oxjz8cFZva2QydxNbB
 Vz11MfpZS9yzwKJDgWj4BRcMRZltcgeF5quJoP1eTDLy3bGOJ479ADrUBvFyvmYcOG/klxq
 Se/7yqD5EBjs55KHzJpIAmj3V7Ga7omiShCCkO2SNX/fTi/h6RTJ6wgfGU2NEvMQINDMCwE
 6U9NHRsbhMtk47IDzuhOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ov0k6YmYK7M=:Mjdg+1VkYtRFGiYUsBjz+h
 tAvbaHx72EE9jypSCC5FiWqu8Ea0vHGFz4hAUYANf8Zvzr7I6bg/Htao8zuTXgHhtqxjXJLmu
 g/D4eONYDaegxq0ZS5XXO4XTE8driKOhIyuq82YNlKsWpLbzXI36QQ5bJjh1CH4CUtMZvg1Ya
 Oz8BnKXaW1SINEea503bKN0KSRz/VYg5k7YOCV+pF1ozdCzQUd8NT8zYc/yaipM3Fcu+dh49d
 MxUZq0OfvdcpZfkNPphPbga2et9kz9VtSPk7LueS9MfxYwf57tcB5kmO7gz9VtjHXvSVVrlPQ
 umJ4GIzpiPW/b1BaL08esRc87BcjqP05usgQqmEiZxk4ZTNHesJ6M/priLcrw9GozWtuNU3Sk
 gI4PlMdG9oCsoLDgRVXpn/G17OFqzXJQbxb969Ao1qCt1OD+tnsRm5cEfnv47h23Am5C/K7xG
 vgO+yi2zerqqrtGGcQ1NvmoTJWLy7hHn+ljT0e5QJr44li+haW7Q3PhLZTCDAww7kFGKnNSDf
 4j3bdYs6qF2Fz/GFVb4khRvgzac4chbLn3BjrbkOpauFQniHGmoo2Km6OQhB4RaKl64Q2vbev
 N9pGTQ6mCMzOPBTYVyxbTpbSthhc05nggDL5bLYDvFP3pxrzUTLWGLT4EoaMxbNq/Kk1GByg4
 1MdYRu7dd4j8C0YULqDnS41zU69DNtF2Ep2Gtxo9ETJ1dEvpbkcgtYU7NY0IIQBnFklGYp3Ay
 eunSb3MG4m0GvSl/vlTrmKgw19/x7ZCuhXvN9U5eXvmOl/v/fD4G+N32qiDztO+szbXkuv1UH
 AEhNMZGSzZ9QZ+pNH4/bP65dB3I/Gdox0+IcL+W0XeEDelKRsKoilo6YIiipn1oV94VlQpNuz
 ENw7cxIHdjFAtZvA1oOqajAsfbbAzgmX7wQ3sxrUPFvn37MnI+c/U/fM7g1OR5768hx9DRChQ
 JTLr1yIk1UdQy6uArqy0ISbqIvxHxgEppDMNnWNXHsMGb8gtIpBNqmU+V6rBq8YuXjfaJLlH5
 fi2hXUnpHrYoXQ6DKs6WZXhI2p+0E5j8cS0LYQ3S0SScrRLTxBMaLIHar18ElZG0D2rOMyKS7
 Vb+7p5vhKwJ/VUrDB8rPEE5CUncNFtTdiRukSQV37+FjOUx7r/0Je/3Sg==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02.06.22 2:49 PM, Jussi Kansanen wrote:
> On 5/31/22 22:50, Lucas R=C3=BCckert wrote:
>> Hi,
>>
>> i run two HHD's(sda;sdb) in RAID1.
>>
>> Kernel: 4.9
>>
>> Distro: Linux odroid 4.9.277-83 #1 SMP PREEMPT Mon Feb 28 15:16:26 UTC
>> 2022 aarch64 aarch64 aarch64 GNU/Linux
>>
>> btrfs-progs: 5.4.1
>>
>> I created the filesystem with:
>>
>> mkfs.btrfs -d raid1 -m raid1 -L somelable -f /dev/sda /dev/sdb
>>
>>
>> And added it to my fstab:
>>
>> UUID=3D<uuid> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /mnt/somefolder =C2=
=A0=C2=A0=C2=A0 btrfs compress=3Dzstd=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2
>>
>>
>> When running:
>>
>> mount -a
>>
>> i get an error:
>>
>> mount: /mnt/backup: wrong fs type, bad option, bad superblock on
>> /dev/sda, missing codepage or helper program, or other error.
>>
>>
>> and dmesg reports:
>>
>> BTRFS error (device sdb): open_ctree failed
>>
>>
>>
>> Yours sincerely
>>
>> Lucas
>>
>
> Hi Lucas,
>
> Invalid mount options can be reported as "BTRFS error (device sdb):
> open_ctree failed". The reason for the error is that your kernel version
> doesn't support zstd. 4.14 kernel added support for zstd or 5.1 if you
> want to set zstd compression levels by mount option.
>
> -Jussi Kansanen

Thanks Jussi this fixed it.

Lucas
