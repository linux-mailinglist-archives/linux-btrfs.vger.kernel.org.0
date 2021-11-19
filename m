Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238CF456D7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhKSKf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 05:35:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:34629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234790AbhKSKfZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637317937;
        bh=C/nH5UkAr0puGQ7VLdwAFD9qC05TCKsrM5mjIL61bAg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fKW63jtFirWXt5kqM1aGvFlj9yX62iXlqZDuFawR2QeKYzct+diLM+ta2uRw4cCb1
         hC82Pw5xJXLabIj7FrDamR7DEfOxXtanB3cnpJzOuPeszf1dPlP5xL0SfagECSMNxr
         TPy/DxOLn7ApFTiBnFDvTSCZZdWS/ulcoI4lk9Yo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mr9Bk-1mHedS396s-00oFpt; Fri, 19
 Nov 2021 11:32:17 +0100
Message-ID: <2c981536-6b48-927d-f66e-4600277947f6@gmx.com>
Date:   Fri, 19 Nov 2021 18:32:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] btrfs: don't bother stripe length if the profile is not
 stripe based
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211119061933.13560-1-wqu@suse.com>
 <4d05cdb0-6d76-f58f-51cb-2b270ccf2df7@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4d05cdb0-6d76-f58f-51cb-2b270ccf2df7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpGhq91blGpWf/W4wNAD0L6JHV6aqX9aamQNp6oFh80o7YXFajd
 ZJR1A6nLDUeSt/9jJPXc/h9T3feJh5gSh1LNhEy8KowY1w0fMG7nu7Sia2Rr+xxsdDcSKp7
 ci3P9iUplXSgwWakmAI8MSnKyJgz7tn/eNbqBUxYML+Lni8+yKkV+leFb1mmsj3zYH7koe8
 msPpAgRfgACEz9vTxf52Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tL9kifUfqqA=:cFvCalQSlloSgPD6CFncWc
 DU3GsOOz6bUJi57bW3a418xtHaK27Kq+/dkZoTpxgR1HPTdm+tQvVXLP2s4dtN1+HZrH7Z/ka
 XLnWLkVfyzfkYOdoniWKAKi7I4jZ00SnC1RFt3Vf97/oHNXG0srbGu1M1mjliSOy80DXzUIW1
 7DhDFbEVspw39Mf8t/bs+9lZIJyn1pXhObXTkr1E+CxFXyIERcnVEvWdbOxCsD5SC+bPIYjqp
 25TE9PbiezYb4nXgM8L40hH4yKzp8fidgNabAykLCvVu7S49TP2vOr7bgN9YeaTM+ULbE/Nid
 kZth2W/uh1Q338Pt7hBUy1FBs0v9XIbPDpnnA2XPNQSKT0xEYuhCYFVh0EU74BGOm0GSJFhuO
 HJnY7ciy9oAwVxW5yOkYGx5zA9M7zKA5sHn6jPeEh5lr6fBtuakWIIq3xwPCUYTB5ePKOpxgj
 ibaJEyCUyUSOIcCvoL5Bod1luIE/pej/UGD6pQbn6crIN0AOglXO93/RaaFnCW4xRXcjzL4Nn
 QCOa4j/5MElYXSJmmozlvKkgbKq2/pYqX2g6gnvFNunEH/kaTxQUF62AwB0iDjg+uzHGfGZPT
 l1d+zmPEOXpurpn8FQ5MJfsySY7Us+0eLlWG7mzc2jWh0or714WRdCzucE3EZmVYe2MP3p2XA
 xCfCiYP7Z/j91BhTWfZcUaKdGk4D/eSvq0EkpU6ApmU/FyGB++lw+gLlQ/6H7yOrXibjiczx2
 clU/iWqSezfeL/3Fiy7XKHZZnR8r+6m3GO3ljWreg69v5gyadixuzPiP7t0r58/t4FGHID6d0
 N01/9Jn0W0iivHjqbCCsgMcwhUp1dyaQJ/qN7dJt0yqxMt+GazWcdi7/7HFaSgWR6VEd8CVu3
 Y8kjGE1JMYsqRxADf8+1XjevA2xg+UCVatwnM1JjT4l0Vn0u1koP/r0+0NMIZO5an8Y3emySt
 id1XafT7bAAB5MnlJu6eC2QDqLhD+XAVctqvKeLP/5mhHSJaPwMkQS8Cexn/tHkmfchFS9MYo
 hCTTS8l6LsiHfPCaRApgvJYRSqybp7CgkbdGHM54aebuWAHNnnBAA67CHqr8wcq8ZXCtWpAlg
 lFn1DVPueZnMNI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/19 18:22, Anand Jain wrote:
> LGTM.
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Nit:
>
>> +#define BTRFS_BLOCK_GROUP_STRIPE_MASK=C2=A0=C2=A0=C2=A0 (BTRFS_BLOCK_G=
ROUP_RAID0 |\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_BLOCK_GROUP_RAID=
10 |\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_BLOCK_GROUP_RAID=
56_MASK)
>
>  =C2=A0How about moving this define to btrfs_tree.h at line number 911?
>  =C2=A0We have other BG MASKs there.

I don't think we need it in the long run.

There is already a plan to remove the stripe_len requirement completely
(all the bio splitting will happen at btrfs_map_bio() time instead).

Even this definition would be gone in the future.

Thanks,
Qu
>
> Thanks, Anand
