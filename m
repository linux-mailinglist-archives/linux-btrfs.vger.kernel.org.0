Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99EE72D9EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 08:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbjFMG1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 02:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjFMG10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 02:27:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC8183
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686637643; x=1687242443; i=quwenruo.btrfs@gmx.com;
 bh=bYcCxGFk4y1k8EtkFbac1k1tdgR5zVMqjfv51RB4M3U=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=EUc688axiF+9WZyRoKXcI6qUKTpanKQ3VGWQM2+GJmydDLYe3Xt9yeaYVNcC1S0AMXlSy2p
 GfFA2iLH0p6mHgFZxxll8nt8GS4uo+4WSzkWw/hzmDctDppXuRXslY296Hc4mzD2OceyGX/H9
 b6HUQTqZ4U2sx8KkxeuENAnTp/wQi5vjTKsaEDv65rMlx1VmUDpGlVQl+f6QvTO+2yyP7oVhn
 XzUxtfQFuznnjvxV/UmU6uLvHlXFDvPWacLqpRa5jLu/aCxiYbJ04n5xH671aeK/2s2ERNnGU
 fEcOLDuK/W08O6IocK19Amv8x3KaQqgpPUjtydSPpSR6AD6bw6GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1pv98x3IZp-00z2p7 for
 <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 08:27:23 +0200
Message-ID: <43d22a89-4940-ed74-4114-c5f170be3af2@gmx.com>
Date:   Tue, 13 Jun 2023 14:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression that causes data csum mismatch
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
In-Reply-To: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:co75gdYcYZ8gJzCWrwUUjYi0MBWvc2I6sd2UTrtYjNsOZLRXiL5
 ODJCuJ6dXG0cx2YAKPI+lkp7geeQjl+fu+o4J2v67jteEJyzCECEC5cwq2SqQkKgoqo4JaL
 C8N4gWCdBqzVPNz17Mgg6C7XkfdIYcV/9qNMUCCVPtp1P+Xo5yROvjY+GnULU8Bwo6xqODa
 n/t7ivXNRb8SosjDNVlyw==
UI-OutboundReport: notjunk:1;M01:P0:NpyrHIN4zuo=;eXnYOjQw4r1EoOFqd1W2K9dY/nc
 Z7pYsCbRjhebcZETb4dIEgxRDZhNkxQ4RMnCBJPfBVrYwvhxgxuxsQstL1hoOnYgy49FO7FYS
 9GcbEIDKHpGMyQcpdGBZZMJOqINs/Q7xmMAFLMxaFbcANaOcHEJWGb9RHHM330AYhSpBhnt2Z
 fDxSRKl6D6m9f/6Ehqy+U9ZGBJt7jO9XNs1JmFIATBO/mjMn859RpDQJ/NmYnbzdzCsC9iJnK
 Z81LpZXDRn0xlKiM7WOxgIifdK4CU6E1XZbFaZAYGGLaMnl+B3fIpgpaBwgXINO+MIGgcgURc
 znmpmw0aXYayKU1mweoUu1Tp8ZuWJ6D2JP7GAfSaae8EYrojcL6gEudLgUs8kQbf7MAbH5Vys
 fkOk22nqRwfkEch6XRloB4XqQdbKmDCagvoO59TN4iMzUzLry69J+n8NWwv4PB9+HeFfHG3xH
 0b+Ys0Mt4PVKmOEHgfgM3HF3X1xoiG7KuChXfl5IpD8rtUaoVFoBpn/F1Cdf6BQMkPMm7+40d
 mMgUKcc3XBuztGjdOInIr/KxrWSXWFiBkfvH8wi2ybAl0sScF2xMMhJ5Kzr0GcmasiQ8GoE+2
 KMrVbUjAjSz5j+n/0OKGrQKwjdoTUlt2y/Bfz3JmTidj/F6N4K1LeP3bDaNWkHES/3V3QoSCi
 NOKXSC3icK+03XKUDXnIpXSZlQkcRZtznE7sb6+Wi9lhAgCKKd5kMLTfap+lwaUVQsIhHx4t7
 MSzebviT3Of3bSMqEhWZR+H76iPiD41rlA9EA+nVJUPBIZVvezwnpbv9gq4cIzfWpQojpc09F
 DqZ6JqtkkTS+cT2aiN0A0BYg6+2NSmHwIytKJ5pE4QDH4Y0+F1XEI+btEl5ENBqq7vgdaDsis
 YhvfygEwwPyP0GibI/q81mB0gqcMbzfO6Os+ixQZGbyKRw0jdMjObL1JPL53Rzsu5KnDD2Bz0
 xoduNZKpVQlyWb7KCPcbObxmBEw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 14:26, Qu Wenruo wrote:
> Hi,
>
> Recently I am testing scrub preparing for the incoming logical scrub.
>
> But I noticed some rare and random test cases failure from scrub and
> replace groups.
>
> E.g. btrfs/072 has a chance of failure around 1/30.
>
> Initially I thought it's my scrub patches screwing things up, but with
> more digging, it turns out that it's real data corruption.
>
>
> After scrubbing found errors, btrfs check --check-data-csum also reports
> csum mismatch.
>
> Furthermore this is profile independent, I have see all profiles hitting
> such data corruption.
>
> Currently trying to bisect, but 6.4-rc4 already shows the bug.

s/rc4/rc6/

>
> And I can reproduce the problem on both x86_64 and aarch64 (both 4K page
> size)
>
> Thanks,
> Qu
