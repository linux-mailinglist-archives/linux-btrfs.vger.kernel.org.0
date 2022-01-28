Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA249FFF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiA1SJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:09:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52219 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238554AbiA1SJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:09:42 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 68F585C0186;
        Fri, 28 Jan 2022 13:09:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 28 Jan 2022 13:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=qMJJ1x4KAjPtea
        e8Mp7cf1M124bFFlgc3E/oICHwm3Y=; b=noLhdwL1TQ7I6PCMrArZq4jnvFzKVz
        zdhkIPv6y5KT1XCqq6L2AgyhukUmZSFJRF8e8BaZUBenSVnmyacxpGWVZPO8zyDT
        QyWnNTo/8nz/bzEB+TKdbCqLZp0WRcS5Dxpvyt4nSWI62Z0oJFf2joP9cMax9fBm
        nnAk/zutwH/Bc/ryKUG4vPaG2kBAJmsSWLPV6LWhXvmTOgngdkrRElorJfkrhGVo
        wYd5hEOXl5/BL6pP+LVEnpbm7gI20vzEhkQAgdBpD8AUrL/H6/FilYK890QFbruq
        Yvx1PSPqOYhbNYQoo7sPVJOaf7t7SUdoodIiqbfICkqbr4qUElvHoThw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qMJJ1x4KAjPteae8Mp7cf1M124bFFlgc3E/oICHwm
        3Y=; b=hiActtFgAt0Gv+TG4hQd3xbI5tUdn2u3WctV0ibyeaflxk36yJkcBWdtb
        iyMOfrT8CXO6I8FAjLRU63O5towQRRbrPF97ey8QK6FFQyUNtMmDIsQeSJrYjHjE
        +LfQWU8/HxmoXu26Y+AVFsk6wx6wJNa6YJMdf9gzvwqt2uxwECrMPim0u3vkZUH+
        SXn91Dkuv95JjuJiO34AkMkajOo+o14+AKCUupFkmrfAT12JUPAw6zZwbQ6C/wH9
        vC7T4qE/Rz3SoJSaaisLxuWgLQnj1Pzq9SvBtThO+Ur45hdTwkRox9ze0liFOvl5
        XyY0np/S0AJBf/X53uguhtKMOD+4g==
X-ME-Sender: <xms:ZjH0YdgGw6RG9AudbKfpSZW69mmRpavwT5rPt14UNhN_F9ifLM7JOg>
    <xme:ZjH0YSAWRkZIIvqndy6ff2GyiaRUhDyoaSfoGtA5LrQv8m7CPCyNbTb7Z0bGsiO_U
    4KqLBwrHflXsa2Ekw>
X-ME-Received: <xmr:ZjH0YdGDmAA-FMrhEYBN7h_t43LeEjMSa_Tzd2FqktUYPG82OaGq_E8xB4gNsbEoJTo0hUbjqi7saHp7p8mP9eF113Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:ZjH0YSRS7U7USnxYWA3Rui8X9894IMwXoi5908-KPnAzgE9nHSTvIQ>
    <xmx:ZjH0YawVTAA2QmUiN0yAxkouVlhFn5SRGSZQsm-222ToCbPo7VHZww>
    <xmx:ZjH0YY5eVB9Img_z3jeRcKb2fjdg0k9Ux4135o3nh_cYI3iwn-QZxA>
    <xmx:ZjH0YQbqCdJmxEFkTHKRb7CgAh7xdlL-khibbmj0KpOjETdBb5sBKg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 13:09:42 -0500 (EST)
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
 <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <a7e60083-7bbb-bc75-2916-7396e223463b@georgianit.com>
Date:   Fri, 28 Jan 2022 13:09:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-28 1:01 p.m., Kai Krakow wrote:

> 
> Yeah, it's not better than traditional RAID but it's probably also not
> worse. 

Oh, it's worse, it's much much worse.  Any time there is an interruption
(power failure, or system crash) while a nocow file is being written,
the two copies in Raid will be different.... *Which* copy is read at any
given time can be a crap shot....

Imagine if different database processes see a completed and a non
completed transaction at the same time?

And there's no way to fix it other than full balance, (or copy re-write
the file).. Even manaully running a scrub will not synchronize the mirrors.



