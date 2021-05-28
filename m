Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778293944AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhE1O6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 10:58:50 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42573 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236822AbhE1O60 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 10:58:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3357D1CA1;
        Fri, 28 May 2021 10:56:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 May 2021 10:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:references:from:cc:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=y
        LnXymbM2d1D9XJjpfLV/7k9vJ0t3zWawzDgMlsudIU=; b=hijL6PhCsJRf395h2
        4MfgU8clmftyaUf/OPGk/allDKrMdnFCrtsvoRpXoOQcrtRbDBSMzvV6XFrxIqxG
        27gd/zHT4Jl5/o3M9KmFMxiFh0qSv14HSz7VELqcRSiSChubTlhHXL94KARC9HMJ
        920OSIfvV0Cr67sVBw8C8EFw5zL54/1rD77U+WFpK+tG3j1xviO44jgUbcMtrBlU
        +jl71dOGAnPNOICq1x+GQ8JsQ08nUq1/FVUs+rAv9/p5W4BD92rdckgdalbmTN4r
        Db0ZIaQjq7UgWeOh7mtBsLng5xsGDEFTGDq+zq35xB6NQmF77eJuuscxJ+STzupx
        Y434A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yLnXymbM2d1D9XJjpfLV/7k9vJ0t3zWawzDgMlsud
        IU=; b=agqxgI5Oj+liZ8Etr2yU4i9L9ckvtV+pT7R6q5TLVkDDt6QZnDk3RTMZ8
        j9X+Fz+2LYDxPaA/HfL4X94kwPsz2PcSBE/gQQUyeR9q9ZtEy1wWY1OBktTZeJyy
        EfIVB2Rj1KzocM2b4J5y1kjqLupRXRYbfNLKl6bDczK1CMv/51ft8HtdV4K7Sw4L
        gcwMaLHBRCL+fg5oOC/stx0QSKcpJl+/8EY1Cd4VWYi7ykWP3/yTt4/cNrG3Lr0e
        7bqJjFPuUx9Yl5rskzJUlU7YQ/WJC459qe9YsJqsRlgxokaveNtlJk6E6AYvVi8c
        JyF1PSGo1AzuFQkd2ZUs+3r2TE71w==
X-ME-Sender: <xms:sgSxYEdBSvlZmb-GUj9jyjLuc1i6_rmK-twflcGWAHx6wjudjzo2Pw>
    <xme:sgSxYGOxreI5YKFWPEMPXTZMHznlQCvVG5xxrzTk3DsUl-6Vbm0ipKwCHAzQNG53Y
    6ecgxfoVlmj6zIOcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekjedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehjefhteduudfffffgudehieevtdelkeffledukefhheehffeugfeggeek
    jeeiudenucfkphepudelvddrtddrvdefledrudeftdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgt
    ohhm
X-ME-Proxy: <xmx:sgSxYFjR9-nu5jzU7qGjrHbN6VnmPTitfSnsDulE5wrO8MnhYUyE8A>
    <xmx:sgSxYJ-enNbiDqBBZ-lvviyPxof9MhSDC9WzGT6EJxZn6dzdK9hs1w>
    <xmx:sgSxYAsoCnDiXEp_0QlwBx0mmoSCEBoS9AXObTxOlzmpkqraDno1HQ>
    <xmx:sgSxYJ6No6mB4ldrYfy91adAovVjMwKwgPzxKVhvCZASz9VqorgGwg>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 28 May 2021 10:56:50 -0400 (EDT)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
 <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
 <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
 <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
 <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
 <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
 <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: how to rollback / to a snapshot ?
Message-ID: <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
Date:   Fri, 28 May 2021 10:56:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-28 10:33 a.m., Lentes, Bernd wrote:

>>
>> If that's the case, you should also check the /boot/grub/grub.cfg and
>> verify that the kernel boot options specify: rootflags=subvol=@
> 
> root@pc65472:~# grep -i '@_bad' /boot/grub/grub.cfg
>     font="/@_bad/usr/share/grub/unicode.pf2"
>         linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro rootflags=subvol=@_bad  splash=verbose   <=== !!!!
>                 linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro rootflags=subvol=@_bad  splash=verbose   <=== !!!
>                 linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro recovery nomodeset dis_ucode_ldr rootflags=subvol=@_bad
> 
> I'm hesitating to manipulate grub.cfg directly, because of:
> 
> #
> # DO NOT EDIT THIS FILE
> #
> # It is automatically generated by grub-mkconfig using templates
> # from /etc/grub.d and settings from /etc/default/grub
> #

It's relatively safe to edit the grub.cfg directly... Just be aware that
next time something runs update-grub, your changes will not persist.

But here, the question I'm left with, is why your grub.cfg changed
between the time you renamed the subvolumes and rebooted... You might
have something that does, in fact, execute an update-grub on shutdown?

You can try editing the grub.cfg and reboot and see if that fixes the
problem... but if it reverts to @_bad, you'll either have to
find/disable the script that is updating grub, or change it at boot time
interactively, (which means, needs boots on the floor)


