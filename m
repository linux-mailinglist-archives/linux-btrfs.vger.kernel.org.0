Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374414A002D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbiA1SdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:33:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45537 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343687AbiA1SdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:33:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 846565C00A7;
        Fri, 28 Jan 2022 13:33:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 28 Jan 2022 13:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=NeHWejPoyd3rEF
        9jKp6B/PD0CX6HhGBO7gZhXws7NEA=; b=qgofv56ejO6d+jahXZmLMHLehTHhxg
        uUtZrHXIevTcea+saDqciX1u2ki9UTUm5XjIyjt/1r1ur+/RT9XFPM3/FwZgmlA+
        9mypwniEdCpa4uYYES5u37P2FEnK4hk2y0ivC8RYDwom9a0vht8GsxfsTkSCb9Ch
        GAoKonrJGc1aGst1BSqVZflTin+G8XgigPp2wdplsT2U7tF6e5oXJLeMvndPsxEN
        NEM5e7xKGIRhWy/i6PnpDOrs20uZrS7fz2PV+k+CQDcTlWAf7fjLNvnRqV3Oc3jo
        Ce1oqqlu8HCVx2H1dHSyJfQPr7r7Q+comWwOT+BLlQxJy83+ZJklwPyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=NeHWejPoyd3rEF9jKp6B/PD0CX6HhGBO7gZhXws7N
        EA=; b=SZvou8Uywnl+Qo+GPTZMYXhvTO0bcJG8z99d7M1mtSsrmqvtIVikY0f8Y
        +asCabPf8+ISlAodMr7g4H5KuCBxiZK8Rxo4pWIJuffCMIfvWamiJhcP+oFjCOQD
        eMkb6IgEf28e6NT5J3h/egqie53skV3CM7vlaIM3SVOebhi1tjNvAiq/Q2pxu1WZ
        K5NJqZ+IX1S0IJG+sw369Tqcpg6tPtFprvK5qQGZYbJ+gJ1KD7RDFNLga6s5NXxO
        62j8xiQY0QtR42rWFb6HASRb2r6alx7v1EC4DtmlXQ09q2l7Ugz1OdXV2mjQ9pxc
        WKHXRDjpqiOx2Kr7CaHoEok1OXiag==
X-ME-Sender: <xms:4Tb0YSLASI0eN_p3Kqvx0A5eVwqhW6w39u6O-pMb-MHVuqXDvkc5AQ>
    <xme:4Tb0YaJ25mcBVi5gCStnnK3_F5erzIR_VJ8hqo47UYYc7qQxcOyTPMZBWwCMfeZoo
    Z8oeCHb_BUYhV7jPg>
X-ME-Received: <xmr:4Tb0YStnbhztBf0RiFpqUXAmTcgXhdWpMMOqK3IpN5a4WBfmnhovkHAS8t5qyLef8OFdBT0xBuyGphAYY11wqeCEzWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:4Tb0YXb7Ofarb52gdoYQ9M1jEBtYzhxNSdmf44xj7-bjhIXiYYfd6A>
    <xmx:4Tb0YZbZp0-IhS8YskgOir2iVdKnOkuo2g9RppXmu_5FK5IpPVNMIw>
    <xmx:4Tb0YTAFI-N-ysQBsF6Uxj4zOqXGDwfjZIlGqS2dXDSAHHvJzHMxdQ>
    <xmx:4Tb0YaAe0wKCMA5Mwa_s7uxYpvWa10FSlitufFryQiXkilL4MF8R9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 13:33:05 -0500 (EST)
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
 <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
 <a7e60083-7bbb-bc75-2916-7396e223463b@georgianit.com>
 <CAMthOuPa5nmao1cvKf62CXOF5GZvGC84p650S947-YqaRe6i5Q@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <85ffc15d-8000-36b7-d7ad-e5a5a31ccd65@georgianit.com>
Date:   Fri, 28 Jan 2022 13:33:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuPa5nmao1cvKf62CXOF5GZvGC84p650S947-YqaRe6i5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-28 1:23 p.m., Kai Krakow wrote:

> 
> I never assumed something else. But database transactions should still
> protect against this case: Either the transaction checksum matches -
> or it doesn't. And any previous data should have been flushed properly
> and verified already even before that last transaction becomes
> current. A process won't see a completed and non-completed transaction
> at the same time because it reads the data once, it cannot be
> Schroedingers data.

That's exactly my point.. this is what BTRFS does...  2 copies of your
database, but they are different, so transaction can be complete in one,
not complete in the other.  The database program can not detect this
error, because it will only see 1 of the copies,,at that point in time.



