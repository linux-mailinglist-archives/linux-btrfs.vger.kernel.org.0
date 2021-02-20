Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF79320535
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBTMPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 07:15:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:45843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBTMPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 07:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613823232;
        bh=IkHXKaOstntNw8r1anp3jeS/rbBvo99acBzxk+dVrgA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RbvotwQvVsOVd4KJu4fG250aLHFgfdW/tHjU9ufs3XmWhpST+BEc0rbI9BAEIhRLs
         IF0RLRmAnB6iJ4D/3yRh8y3bvt8zUT5PSfFEf8BIX/BQph7P9kw81MoIWxGWW53EIo
         11+r1RT4N002PqDYbkJz3umIzo/idEIU0uux3OLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1m1G0H1h94-00x05Y; Sat, 20
 Feb 2021 13:13:52 +0100
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
 <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
 <76971f62-d050-fac2-1694-71d3115e1bf7@neuromante.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <704ad3ea-f795-93c1-3487-c644ea5456d9@gmx.com>
Date:   Sat, 20 Feb 2021 20:13:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <76971f62-d050-fac2-1694-71d3115e1bf7@neuromante.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5fv+2q9fan9zrgzQxxxFf7RkXs6hneQlZZ3T4LAX5PInmN5HZeJ
 csohfR04QmCyYFI385ndV3xZah2gDKXnX2Fq4bndoXfoCfNaJz6eQANOsXzcCSZI+RdSPJS
 MYbdD9zylV4gK4EkXM2xQjzavrric5PP9Cen2T5qW1bKqsD0nChDipocOKJMR6sW4zif+tf
 9qOOan3pvRS3M0fT78dYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZMASHUFv50=:RFu295XFvXurw6NlQIJSe/
 mMhJmi3QTAKeoomEacpXbYjbHsapHa3Ac7yoFZecHgI8XySz9WkIb2CetsDXSZSNNdzTmqMEp
 wfHHQi6ePNbRHlsHhQcpkb5mFblweLJsRUXvbiscyq8J30+jaujvC7J1lYdxctNd370mjzcnu
 YzMWID7CMHwFyRrquGmtZGPmaJsFxoiGGFN5YprrIElzU9yR9IA3h9ooc0T4ztn5cARnzoNUj
 y/6XuBWIoSS08BQO1LVheSIUfb2Olh7YhJ7VUnIkYOTO8dj+mf7Kg5oknOMD/HaZCU8bYt7YO
 xdI40mSmdI0klnAmh9iDrLnyXKHDyvGN+dwOjs9DR86j+RUDcBta2rXx09ia3yr6aSzEpoeTW
 ahOLMAL7A22+svPMYXd/JLRw3BL4+s0Bcomr2G9jjOS4tz/hx0r+0eL2UonOqczeHaztrmNAg
 6V1A4WDjT5xUqFSzyLfTjjLafUbamF2GGwA6H84pMDa1FNn6J1GW0WwXEv8qD3iqvtlodGdrA
 ybSqNehFk61SYG46CSjx64ExZ27I7LTlUcQfclETHiDr3jf7sFMzPlv+ptmeJe+3Ir/5rIU4f
 zv1DSavPX6sjsHOoJAf8pxw+WMg7aFiZM5ErpyVED4njjlJg1MHqteVfIbUyC0yp0d3y5MhnM
 zwrvn2aU+CsET5YR4XFPxJOvEIpO7BaNEC6KxO7XvYkWnCTAytVcyAZSmJ+oLbFow2RUz9Z9U
 ICD/kMqMFr3nbbTDie8ib8kNE6x3AjhjsLDhEkz9lMyhm8KXjP6A2no+/kxE5bfp01V4VH0Vp
 qDB/rS+Qx0Leg1EXz6DHgtn00ShTrYZn0kER/EwJ2ziwyvJ73+xjec3uaNvnGxxqqVhLhHUF0
 xurWJdZKO8xzlWhjeH5Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/20 =E4=B8=8B=E5=8D=888:07, chainofflowers wrote:
> On 20.02.21 12:46, Forza wrote:
>
>> Are you using fstrim by any chance? Could the problem be related to
>> https://patchwork.kernel.org/project/fstests/patch/20200730121735.55389=
-1-wqu@suse.com/
>
> Yes, that's what I mentioned in my first post.
> Actually, it all started with the bug with dm, but some similar
> behaviour persists even after that bug was fixed:
> https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/
>
> The only "maybe unusual" thing in my setup is that I use btrfs on the
> top of dmcrypt directly, without lvm in-between, but I am not the only
> one...
>
> @Qu:
> My RAM looks OK so far, I also thought of that, and I actually ran
> memtest for 12+ hours and more than once. I would exclude that case.
>
> I will do a "btrfs check --check-data-csum" and let you know.
>
> In the meantime, I thought of a related question:
> -> When a data-csum is corrupted (for whatever reason), is there a
> chance that the corruption persists when I copy the whole file system
> over to a new one?

You can rule out the possibility that some data checksum itself is
corrupted.
Data checksum is stored in btrfs trees, and all tree blocks have their
own checksum.

>
> As I said previously, I copied the whole fs to new, virgin SSDs more
> than once with "rsync -avAHX", and I couldn't spot any issue related to
> the copy itself...

Then you can rule out the checksum problem.

Thanks,
Qu
>
> (please help! ;-))
>
> (c)
>
