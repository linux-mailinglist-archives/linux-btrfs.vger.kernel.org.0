Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D633391B7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhEZPSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 11:18:52 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54961 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235128AbhEZPSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 11:18:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8434B12B3;
        Wed, 26 May 2021 11:17:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 May 2021 11:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=c
        Wquwy8DCxLqZYJ9QaoeEjThKBbQRRtSsyWNYC/ED0M=; b=Gk521uRWahcGQ4cQ8
        pXQMAx/u/WcKFX0rPI4rkWhW+hZ99Fil4Zaiso5f2nfgFLz+bQj7T4ObR/uvRrVg
        Cr5cUBkPLxBS27ddzku2SyLsnCnBxWMNGQcm6aXiSJOtYGutFtOexmndMtXvICkM
        0WsSM2FTNA3t0TRadWm27HAbLpSyPXV18zb600zoh7G7R1q3JCZ/q6EmnBeJIOhe
        G1bLu6DEo/aQufx0cNJY4NyGhR5KJ87s9Vlv8uH+OKnjnG1e9LbtfIrl+0fHwJHv
        PQahVsN0RuYC7clM+6T8voBKW5P/pEhs0gPGKPGr5tPGZiLzcvw5IwcPb/G3NELb
        GBpZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=cWquwy8DCxLqZYJ9QaoeEjThKBbQRRtSsyWNYC/ED
        0M=; b=ABI4IOsSsV830vrIFa7NiGpylLWqJ+JuREivA/NSXi09d5lYw3T/Fu0Cn
        ccXahSWndjGq3bVGM/PS0a4uZ60OdH7iarV1H4wpayP1shVR0g192kWV9+1TkVQd
        f4E70NuemHeYiCQQNUvt+aPGrgsezcrlWNSx8brawK3LDRD+Hubanm7tR9Kz0EgG
        QOwDPdVv+oXhgZ9byWr4HXxt6TPgbwRRRFqNNhoY59lDd75uk3sGTqb37x77Lsbi
        mwu/Xd90rR+yhAoUJQop0mSG7kg0qTQNIdGZng6KaBJTwRZFFolUWu/dG85ihL8g
        qfhZSpunRH2mZEWLC/QU6rZ1I9B4Q==
X-ME-Sender: <xms:fmauYFf7RpNR2tp6biqSnKS7jPn9aACYN416a7MaclNfaErwPIYmwA>
    <xme:fmauYDNKM-km2a5qNvcGqh61wE3qoDpIxKQQS5ExjX7489Bw1658tVw0ASR7aCvbj
    Fmm6U4yJMsbgOxTvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehjefhteduudfffffgudehieevtdelkeffledukefhheehffeugfeggeek
    jeeiudenucfkphepudelvddrtddrvdefledrudeftdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgt
    ohhm
X-ME-Proxy: <xmx:fmauYOjB5PdKbrne0SI_a10FQHFYTcWEtqULIWHyJwYMDO28whoJRQ>
    <xmx:fmauYO9rYEkkWRryy-u9HGSEoH14cJo06pdpivB5U2p3OgUXKQ_MRQ>
    <xmx:fmauYBtznt2TS0S00ALX474E1uz_AU7_py3y_Awc5B0yvvAsD6mdSA>
    <xmx:f2auYG5w1cDit1uJVvtXG_beGW4wcBPMJKI47ULQqpnU2-tV94p3Zg>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 11:17:18 -0400 (EDT)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
 <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
 <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
Message-ID: <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
Date:   Wed, 26 May 2021 11:17:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-26 10:53 a.m., Lentes, Bernd wrote:

> 
> OK. Thanks, i will try that and keep you informed.
> 
> Bernd
> 

Please note that I made a mistake.


When you snapshot into a new @, it will already have an empty (not
subvolume) @/var/lib/docker/btrfs directory.

You have to get that directory out of the way before you move the
subvolume, otherwise, you'll end up with a  @/var/lib/docker/btrfs/btrfs
and mount will fail.

rmdir /mnt/sub/root-volume/@/var/lib/docker/btrfs

*before* you do:

mv /mnt/sub/root-volume/@bad/var/lib/docker/btrfs
/mnt/sub/root-volume/@/var/lib/docker/btrfs
