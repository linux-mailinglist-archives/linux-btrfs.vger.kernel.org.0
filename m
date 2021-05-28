Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA65D39457A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 17:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhE1P5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 11:57:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35737 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236798AbhE1P5K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 11:57:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CAB6C5C016D;
        Fri, 28 May 2021 11:55:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 28 May 2021 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=G
        kqm3AczTKmGs9+2m7eCnkKolKuomyhDY7L8V4W0FcQ=; b=iBZDceQTVZgbrbahG
        WfhPMTtTPNX0GRfs2+xtIYTRk3RhWYP4LmAp3RiB+L86/fy+zNS2ov7p1OaY7Xno
        omeKq8bUw+Lw81t8QSGtM8n9WTPhbdkYNN4x6n6HQ+vXxFLRdULiLwyRtFgXzdi3
        X2MI4eWN+OHNJUgv79imhrJukT72aKuAahqClIkUjITXqy3aZtr+aQEhD1q5ZkA4
        uVGZynFkxlj93RjqkJDW7UUam9g97u98SWVTNdigmv6muzXhpB2rlMslK80ZbE1y
        jCQNgIPjkye2MgjMRFq+jVCv/a3cLxWz4Cv+YmMxp3TtHL285us0X1l1kyHjSXWH
        MmOAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Gkqm3AczTKmGs9+2m7eCnkKolKuomyhDY7L8V4W0F
        cQ=; b=vU2UuGQGc/aOpOOW725J4XQlGv1Vv2tlB3swhk9ThWxtTuP/kPWO56HF7
        NulJHbEKeOMg6fpElH0Tv7ai8yWoaZjqKnE25cRldxEeDjQkD9I6U4/+DRpTCMTI
        TMT8H7RTPCvqhbtVxMyFtz28oY4z4J9QQlcWyYQWXhcmyaVR/JFI5jDdSayI4d4z
        m6TwBXjr4KLhqROH10MlfYLw0jgQMnRiXIp6jCv93puMbu4RgSMB/fAwgceRmtXV
        0njoP5li3XQaJYnLgQa5jVmuFZ11n49AnnKz/rfosVnZnc7mcLpYGyLA6gZIxk90
        3NAAqav19V88VbX6Rp/lcJJv4D90Q==
X-ME-Sender: <xms:dBKxYPEDvvT6cI9h8m2hyd8CNoQtVpsKgs3Y3gQaQ9FViEM0INvq0g>
    <xme:dBKxYMVPlNSZjJuRZEencS1MG5k44MmkcTSy9IKgr1m4ymOj06PCevv3PL3dqLADw
    ORYKWDHAbQ_hzc7QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhgfefuedttdduhfdujeekjeduveeltdduueffhffhueekjeekkeeitdff
    hfffieenucfkphepudelvddrtddrvdefledrudeftdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgt
    ohhm
X-ME-Proxy: <xmx:dBKxYBJNzRlCj55irum6U4MRqiFLHAlX2d4dzEzApBMbFbIjJB8Irg>
    <xmx:dBKxYNFoI133mnb33aDat7BCiCZzbcWirn1F6iYZ5dfSI3mcnXjLYA>
    <xmx:dBKxYFUrL5MIgTGpzNRBUblmduDE9EIqQTJ7liHxSB-GywyZOAl_gg>
    <xmx:dRKxYEDW5taNYIKReEEIxEC0MB1kl3ZGyKhORK5s7lSadsHN0rjj5Q>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 28 May 2021 11:55:32 -0400 (EDT)
Subject: Re: how to rollback / to a snapshot ?
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
 <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
 <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
 <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
 <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
 <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
 <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de>
 <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
 <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <ec27dd03-6178-c94c-4dd9-dd98be8b4a46@georgianit.com>
Date:   Fri, 28 May 2021 11:55:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-28 11:36 a.m., Lentes, Bernd wrote:
> 

> I try to follow your guide another time, and just before the reboot i will check
> grub-mkrelpath to see if it has changed to @. If yes i will start grub-mkconfig, so that @ is set in the rootflags.
> I will also check /boot/grub/grub.cfg.
> 

The grub-mkrelpath will be @_bad so long as are still booted in that
subvolume,,, but grub.cfg should not change on reboot.. Ie, it it was
subvol=@ when we started, it should still be the same when rebooting.

Something changed it when you rebooted while following the steps I
outlined. (Or there was some kind of kernel related package updates
running at the time you were doing this.)
