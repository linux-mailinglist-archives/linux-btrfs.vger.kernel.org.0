Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8C36A388
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhDXW5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 18:57:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:33241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhDXW5G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 18:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619304982;
        bh=9AJMaeHHMwjwSRqsBtGIdLzx1lrBxO44AMn1R8FdMoM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XA/PJB8IosEjIdBL69LooDY69VcgfNELYqj1rmtMd4QdumABX0z1ExMFDC+37a0nl
         wlse2gueY4gu8eP7Nz0iiNi3JKeBglEvJlyBVC+4b+O+obdPeLZRzv/Es5j9hVBNDJ
         KlMMjK2vqW9uEQkreK2ngSHpYxGAAoAvrL9ZrIUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1m03EW2ryP-00Rrtc; Sun, 25
 Apr 2021 00:56:22 +0200
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org,
        Justin.Brown@fandingo.org, Qu Wenruo <wqu@suse.com>
References: <5975832.dRgAyDc8OP@luna>
 <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net>
 <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com> <1706720.PQSuIbNzif@luna>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a954b5b7-1df8-0592-7116-1818b17f03cd@gmx.com>
Date:   Sun, 25 Apr 2021 06:56:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1706720.PQSuIbNzif@luna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TO/kdYgjulr+o36rP4cy8QPkFd7e0h7sKbu0NwgvGOqlRlo2rS9
 g+ffYS1Oam9mwZ7sN9eLYZFJn9MJ7YTaMMw5/Af6sR4p7CWQmiLnNm/Nf72SNzUFQKdW4wW
 iLvRvh3ajvAfPRF1NTbO0Jxp23Ew6WylXcCcH9WzPOsr40SycbIi/nZOlWM8PolekhiOGRJ
 uOkfZhXllK2Fo8HffnW0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7qPw90IfmTc=:mz9czEB5Ww2hosrAbfj+DX
 WG7rSDZTlQKjyLbtfI/VVxxX3cvIuG+zH2ISTyO2doiWbEftWdfhfXNJcZ1uvbYdzrSPc4OAw
 JuEhXajimk5UlZtQvAzlWzj3Fcev0hncXMAiQUcH5uxBfWE+5Btx8MwOofd5kdsGnRbCdPn4+
 JlkFPYv0FG9C+2OmzQe7HetKiFCZXTfi/UYUrA+0R2ny6CWT1AAp+qNU1Kd4iv51w88rx3erw
 CuiLZ+u09tW+EpBsYOxHY/UFh13wLIfW25/MUH4nlEmQ0jXOExJuFhLX0VcnLyTBXEAVd3aDl
 ZY2M+Zbs1WeC/p1XozsvvhH+6WC9Apm1PI3F37eH68/VDoVkdmyjPJH5TjLNgolwjAdbb27lE
 qErDf+CGeX8VBztpnc2KSVintwz3Zz9+RboBnoR0Nc86VQmej3CkmpE/3gUcFEafdhjj6Ypre
 E2fofOgAslxIYefsg6wjisUeMZFg4ZVRtkN25cPEk7jX9Zlk4M7jCsS/kFvowfQStcfX7JPnB
 JEVY3I0LtBM1cucqPwkfyufhamQQwOqZvZCoUG2z0OLutiUhqW4bM+uc/HqRGiZYzODdehxtI
 te81xpV4tVbPyTrfEJzMqdfDIswOs8crK8/wl63kBS/+c2KSe9sKTY30jPvQVL3EV0nqKi8/u
 YinG9/UBs3iOWcINFgeFvNjmSbpUftessXeiCGdzW8LdpgIAUBxpn6kf+eddDxB4aNk1y+RqA
 HD6ERgcNuDCHrQSN/mE0sINGdLX/0WFx0Lo9QEMXoYczls2ykGRdvEIZiMZ0nsfpEeebZpxMT
 iVcUqiYliAXo+akNeHUUctnBACv7jtuatwm8/8ao+j+YylTSb/0ApogStS3PVya+JVfeQPvUk
 m9aQYDWmZKcFXCH2vfSlcj8LO83h/Ei7o+KKGvOPZ1IZJWNxry9Ih1sNxc/k7DdOwLPjF5kBH
 L35Tfw1UGA7n5dgRtagGHrenDIBOm7DPjnR/1Da+jI9T5VdMIQ1Y79l/szOGKNvSKroe/pKbv
 Cyw36p0jhk2c5JRsDYK+YP91MT/lvkt7eywcA9fqSxSUaY3eM2IFvElQHoUbq4bTUVDtAGi0x
 Z8i4ousEyhzsgHTqREMPzEHexLmrBQhp17XqKXCwp5ZDmIr8spYsEIpYxJ6B0r72fUAAUuHgv
 +3zpFrvEzOshiHwJCCtd81YvjMumWwzE5ChRZAHavNSqvP6NHGTa1NmJhH9TMsA4r/YEkuYAA
 x3Z6aKlEvYI8v6xE6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/24 =E4=B8=8B=E5=8D=8810:13, chainofflowers wrote:
> On Samstag, 24. April 2021 02:25 Qu Wenruo wrote:
>> But if that's the case, btrfs-check should be able to report such
>> problem from the very beginning.
>
> btrfs check was only reporting that "the cache would have been invalidat=
ed", I
> don't know if that was enough to suggest that a cache clear was needed.

That means the cache generation is not matching super block generation.
Kernel is good enough to detect such case and ignore the cache.

  I
> assumed it would have done it automatically the next time the volume was
> mounted, that's why I didn't clean it... "pro-actively".
>
> Could "clear-ino-cache" have helped, or not at all?

ino-cache is a feature that is mostly deprecated, and no known
real-world usage.

Thanks,
Qu

>
>
> (c)
>
