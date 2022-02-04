Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961B14A9A47
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiBDNrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 08:47:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:51161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358986AbiBDNrt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 08:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643982468;
        bh=VtfR1pkDBxHeksWUjQzXspFb9PSyMzTGbuja/+aoxVY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=dd0YLSlUf6rBSz4xhY8czMV/VFgJUxjfKjH9YCP4Cayt0j0o5ZmBUf/1ExhIFmFYY
         8+jI/3kgaR49/OeS1NBoqnb66vXYsGkJwpLmfBxT1HVWtHdvI+PpDw+p9fW0tBD0pQ
         4jM+9WfmN6Qy+DrnMnBpu+I+vSPk19gXHspeiN3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1mjIkK2rRj-00XvP2; Fri, 04
 Feb 2022 14:47:48 +0100
Message-ID: <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
Date:   Fri, 4 Feb 2022 21:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>,
        linux-btrfs@vger.kernel.org
References: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx
 errors 1, no inode item
In-Reply-To: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mexIL2NDqWIXT+F+9zH7azt3ntKu0QYDFs9sWwLlFa6Me4YeW4w
 EYdSh6DDQM1CGJOUcQFR0ul11LudsFmbH//M/3BysRjgG8bwHCCeJkUujJ5rGrq4/8qSLX8
 roD/YdwSQ/1oh4LcvbjNatuDKmfLXcU8aWbElTzCsdYFz1o0c0EV5Q6MU9djAp5v1Cr5yC8
 htRLJl8RFhLfhrjIH4cBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tvP+6tK+kJk=:7Sjtm5qjHe6aq6/pkLfRdo
 YhjeCfTlfrq0yZUZJUkHG12s8Xsc12eP8TRThpnYCbJZ6D6q1pdHaMgrjavpIU1aaEKz+U187
 62HFMu2+klPzEp/t/rjGR19qOrprhiykh7kZgzctOOEUNdEby+beuJOv9EGEmKaJ1U/bOEd+b
 T6w7wlrbuvwPSi9bX+lKuUUAriUq3GUaadRrsKYo4KgTYWoCOWwfrHKMpGdgLMK1Glr+lAmE3
 OPdScOwIIdLMBr17at3blEnPzcn8NphPS3+man/RIpwTvwDoFeIDp2tw5j/QuUTo+8oFTP7D+
 IJP/xk9L41sWVTk4NuvqQKe4pqmfiUYuhRjImwHeIlPAYE3cGhauy0iBSL9oBzSw4S15UtY6K
 am8lqtqsF2Bi7Aoxn9Dr7T9/R8CAMA5PpMkBBXz62X5AbGryrkNT3QgS75oVUAzBqHRz6h1xO
 udVGISZDquFDnK719esfn0H6vnQcuDmckUa7fKI2jZ8g/bXivyZwZUOHNEobebHM0lXlZQBhP
 PUm6/x+iYSt6ToTjShUI5kXC1ku3vfLM5wk90wdZJ/NwjwhX11Uw9F3NxtFAEZu+OkBbOnU65
 RMUIZvFHgWbRff2zQ60vmQuavh8B3DIWoZzO2Zw4+1im5QAuH6iyy3zUU6tHjzkOOAb7WFRP3
 SGyc60CLgdd8wqR5wV4+ewsCZHV0MuZPOYnQ462k1MhYxf2spDwklZvnbIZlnBjR0h94fEukk
 oNmHA2XIvQNv3iJVjjPu93CMEu5BB2xn/YxFxwKAPq6VWaGDVgHzN7QNJeb3pX5Vxa5BR+CTU
 9V7HPiSHFPXRSunLxzthyuMXtdWoLknMOTqu965Jrynp3LMn8n0Fltm2beJ3mHETeigwsEdIg
 qlGWqtAoDQntGAinPcEcrVXDx7vQR78DDJBAAsrpfcdbO5UYXqD1NsyOxCSrouXkaQ6h0t9J2
 KCP8jdR0KpZTwBqFM1N810/E+dubaahDwQ3dG1xGieKnXinfD/+pvCpv9u78/DYqUdYoAl207
 JxvCvc+2gBXovT3Mh+JfA/nXyeFD84PSDRdpL6NQeuuM350aXTjz7Ih9cW7/yEifmqjvsKGdu
 aOEjo+dIIC61O4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 21:30, Hendrik Friedel wrote:
> Hello,
>
> I found some files for which ls -l gave me odd output (??????) instead
> of mtime etc.

And have you checked your dmesg to see anything wrong?

My guess is, tree-checker reports something wrong.

>
> So I ran btrfs scrub without errors and then btrfs check with these erro=
rs:
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 5 inode 79886 errors 200, dir isize wrong

This is pretty easy to fix, --repair can handle.

But I guess it's mostly due to the offending dir items.

> root 5 inode 59544488 errors 1, no inode item
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 79886 ind=
ex 199 namelen 11 name global.stat

No inode item is a weird one, it means the inode 59544488 doesn't have
its inode item at all.


> filetype 1 errors 5, no dir item, no inode ref
> root 5 inode 59544493 errors 1, no inode item

On the other hand, there are some other dir refs which doesn't have dir
item.

 From the inode numbers, it doesn't look like an obvious bitflip:

59544488 =3D 0x38c93a8
59544493 =3D 0x38c93ad
59544494 =3D 0x38c93ae
59544495 =3D 0x38c93af

And, mind to run "btrfs check --mode=3Dlowmem --readonly" to get a better
user readable output?

Thanks,
Qu

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 79886 ind=
ex 200 namelen 10 name global.tmp
> filetype 1 errors 5, no dir item, no inode ref
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 79886 ind=
ex 203 namelen 11 name global.stat
> filetype 1 errors 5, no dir item, no inode ref
> root 5 inode 59544494 errors 1, no inode item
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 79886 ind=
ex 202 namelen 9 name db_0.stat
> filetype 1 errors 5, no dir item, no inode ref
> root 5 inode 59544495 errors 1, no inode item
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 79886 ind=
ex 204 namelen 10 name global.tmp
> filetype 1 errors 5, no dir item, no inode ref
> ERROR: errors found in fs roots
> found 62813446144 bytes used, error(s) found
> total csum bytes: 43669376
> total tree bytes: 665501696
> total fs tree bytes: 329498624
> total extent tree bytes: 240975872
> btree space waste bytes: 119919077
> file data blocks allocated: 4766364479488
>  =C2=A0referenced 60131446784
>
> How do I fix these?
> I am runing linux 5.13.9 (about to update to 5.16.5).
>
> Best regards,
> Hendrik
>
