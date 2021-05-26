Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31015391B19
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhEZPGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 11:06:40 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56401 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233472AbhEZPGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 11:06:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8E0B012AE;
        Wed, 26 May 2021 11:05:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 May 2021 11:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=9
        LMcFrI5BFKBUdunFX8RPkJReq/AnmRMaJRUaseC4g4=; b=F6wGHOVrMTqVSwYnC
        zQFBPxNrVNw4VSKRcuDwmxufR/gGu2Lef3HCYDDXdlm6JXTAr/NtLYEkBi1l723b
        4cFEBERVVfh2CgomHPUg7+QZXVgXEFSCnKmOk2REfjm5PMCZsvx6YWgjterB00EK
        H4cuEE0AO4dzMTQlLYKT7JJZQHekqKKTUT0u4sdaWK18Nitx9mMwTNIFDOrMU+j0
        DiE+noBccT3yM7obtkbQpbgMONnOdKvO9Rx0C8tRwcMr4P0vQG+zkkUxg1ErKSob
        AXn/87stU75DQ1U+G7tLa+h6dWx6XJhZiKAkgVgCnCXUJU69j7niXo0tjjL3xLu9
        9n+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=9LMcFrI5BFKBUdunFX8RPkJReq/AnmRMaJRUaseC4
        g4=; b=RX1FvhRpiiD6P+VxvjyKeMJ61nqBRoZh1SM1gfOh0cJ1MPyKLnGQEAMYC
        K9A2USYFRwAEmY4qwAXOblAMAQJrQCdGxhTQiQo15IZCLvGTkAWJsZwL9EUUzE5z
        68Z11ZlCz2PQRGY2nsXIvjGWJTkjPAhgARtpNbQz/lK6ck+vJrtHaKZqHzV0djsQ
        UUfRWlQJJsHiN5uqufwadt9LtH5L0MgIY4WqgtcKCRoVbRdeG8C31T4lfsVg4eFJ
        wYUqFlXIACBY5p1JuzRXNApaPbbxczAIHKlN4DTjgndy34R1Y+dookHKT/2bRm5v
        cqrbDlQes7KLRSvO5kw9pA46tTfeA==
X-ME-Sender: <xms:o2OuYOnmB5vkCnk1Ccgh7we7SFiUcpaoC0y_ZOyJGCylB8XO_TDRvw>
    <xme:o2OuYF3DlFB9zzORoxU-DRY_8TEYsrLqjbFVp4ZlvgkCv3RoTjJRJaNH-JS7uNjuy
    KuSwq8OxqTwcFwUyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhgfefuedttdduhfdujeekjeduveeltdduueffhffhueekjeekkeeitdff
    hfffieenucfkphepudelvddrtddrvdefledrudeftdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgt
    ohhm
X-ME-Proxy: <xmx:o2OuYMoU-a18lktJ1Kvrrjlhvo2BO1u1iOew6sU-mw8_HGohPhYKaA>
    <xmx:o2OuYCnC1naDoNGqmKYzJUDSkEjd6E_Y3Tri1cCiSMzykNBIcDRV8g>
    <xmx:o2OuYM1F8VNR38LIY6qNlY7lUOo3q0A9WAIe1_LeXcpO0MfAw5Y9cw>
    <xmx:pGOuYNgkuTeVGzfx1lGhpXbKtrzx-dO1KIRZeoF-nyhHtHKv54IgWg>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 11:05:07 -0400 (EDT)
Subject: Re: how to rollback / to a snapshot ?
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
 <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
 <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <ddebf677-3994-75e9-e3e3-3017cc7ac030@georgianit.com>
Date:   Wed, 26 May 2021 11:05:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-26 10:53 a.m., Lentes, Bernd wrote:

>>
>> mv /mnt/sub/root-volume/@bad/var/lib/docker/btrfs
>> /mnt/sub/root-volume/@/var/lib/docker/btrfs
>>
>> You need to repeat this for any other subvolumes found in the first sub
>> list command.
> 
> OK. What is their purpose ?


The snapshot of a subvolume does not contain any other subvolumes.

So if you are replacing root from a snapshot, any of the other
subvolumes that were within root have to be moved from the old to the new.


