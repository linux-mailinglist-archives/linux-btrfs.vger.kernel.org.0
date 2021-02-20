Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE432051C
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhBTLoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 06:44:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:44001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhBTLoJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 06:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613821357;
        bh=f0liWpmP3t/kNpHguHl/82BRvaJRBzIen5cjJj1b2CA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EcSwJZPZLCfnHciFuy+/9bWMN52ayeczxx+nGW87n0FAjWVWqKFm8kp9Vh2uclN1g
         kiniDgGLLfiv5PXhrHBWTiWJbNExJzjRtd/xH6pIv3u0NbrGVMo1LLA3W8H+Cl+7Vq
         y9HoWH8F7N97gso0izr/EUWRlCkdpS2g3R3sBUxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1lIGDu1zpi-00VQ4F; Sat, 20
 Feb 2021 12:42:37 +0100
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        linux-btrfs@vger.kernel.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
 <36f43213-14de-4dc0-074a-fa19babfed30@neuromante.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <33cd1bdb-814f-e0c3-e9e1-c876528f6a15@gmx.com>
Date:   Sat, 20 Feb 2021 19:42:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <36f43213-14de-4dc0-074a-fa19babfed30@neuromante.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COWQkX7aNymA6SvadRPU+jCRKP1FdBRL2GUR5xQRUrKQ42od9HE
 FBe7qOrNsLJTZ+9arWBOUzD2TlG63XmHaKVLvYVm/shnJwbjlTnLgCSEb3ZwvDdItq1zthP
 KjxTRtdz+xZYuo3ZeyeR2oJvLL4WdMcKgtSMCflYQPPd/B0Qx/vlsH7ARHXXKRt7i+CTMP8
 soYm6UMmuIBJCFjdBrMAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7LPTZm8/53k=:emko8Ne4NzbwWYetRu2ICK
 6IunkKVzrQQBU0ex1A/owLErtMstkAJuZV2viRf2ThCR4xmPGe/rPPT/WHFgFOB6qVxf7Tw+U
 maVXGClcVi98onxHs2z9C9T/Wyw5ue/GcAcA8xi3j8GBkkEmuoivyNmVKy4nkYwI4eDo0nm4p
 op9LcqrI/eyk/rjbswX2BaWUSoP25bC0l24rLhK4JOL7YNVYWnlfbtyo5ntVjAS5euFzOn6L7
 dndvdVdBgbiWC5Nn8KCnyMbe4NCv7JWemvIt2VYZXJPzdGBxhSKv12JixYxdgwiS+ynxqRZaj
 IFEpmCOuqUud8zalFWTyO7wnJBfkoKd1Wk+uryh7uX7JzY3UJU33PjzuKeOP2Feioezfmivpu
 ySiLHAi9Gtn9TvcOnuXhIXiUdIuhJWEsquBkZMXpgCj//UFtImnwUcoFGFQwnDbe5WyHKq4GC
 pxaH44l60LqfRjC0pFbRVTRr4OYvaFz4GQduLs3Z9jS5SQRo8rzAwx2N6NWJ2t3uBGk17vmQf
 rIRuTcG3vn/XQpchFdIh5qIscShyAiBCb1iYxmwmuVaBdSucPmSguNQzF/RPQjlhwN3sJ/MJL
 km9B+xG13mSNrrddgWmVXmm5VO7Wt7+UbHd42BSnFCbt3wY/AKC1yB0BC9KJS6Ua7LLHYUJOj
 fWXQ7qUGiH6n9llux6FDyUUSvUZRrqiIbVxo+mnKRufLH+ccF1dy6bA4Mt6UYdgq0DhPhiYPj
 ApXjO19aG/ZnIAMoPmqwEJF092G/QQgZ9cOn3wk6kh9KItshSc2easfQyvjOGmXD3AIdC8ZCc
 NIgeNamljxw7Q5ahewRmhqss14+5I/4dUYYlL3sXQOxMCCVWNrFVNrzOYFL8BpmiZrSdBllk/
 3db9CrLqjK5DVgSkjq7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/20 =E4=B8=8B=E5=8D=887:26, chainofflowers wrote:
> Hi Qu!
>
> Is there any chance to find some hints of the issue in the log I attache=
d?

Sorry for the late reply.

The weird part is, the access beyond boundary happens for read, no
wonder why previously added debug for discard doesn't work.

Currently I have no idea at all.

BTW, have you tried "btrfs check --check-data-csum"?
Regular btrfs check only check metadata but not data.

Considering how many the beyond boundary read there are, it looks like
some thing wrong related to data, thus "btrfs check --check-data-csum"
may help.

Another idea is to rule out memory corruption by running memtest, but I
doubt if it's the case.

Thanks,
Qu
>
> On 08.02.21 22:05, chainofflowers wrote:
>> Hi Qu!
>>
>> It happened again, and this time I've been able to dump the dmesg.
>> Also this time it happened on my home drive, please see the attached du=
mp.
>>
>> What can I do to fix it?
>> btrfs scrub reports no error, neither does brfs check.
>> I have also remounted the partition with -oclear_cache,space_cache, I
>> hoped that could fix it...
>>
>> Thanks...
>>
>> (c)
>>
