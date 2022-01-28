Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC04A0017
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbiA1S3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:29:23 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41039 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbiA1S3X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:29:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 970D95C0186;
        Fri, 28 Jan 2022 13:29:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 28 Jan 2022 13:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=NoqpwEw41wyDyh
        T2cDHnRnxJRFbyK9DqyqKAm7UWC8I=; b=NtVql8LpuRkrmiyku77u2kytHP3Gc6
        03cZzWmbt1MjnpNBAGQHS0rb4w1YeV3B1SeQVsMeSD1XothbWjLOoMdJC8OK2pIS
        GJw+ftJHrZPnxY9yLg/7O23J4XQmVG3Xn6wo97P58wMtgWY4h25+r51SqKQSV5Ls
        x9KC5oHF5WN/61t9uhwq54g6qHJwbfB3hqN7qtn8466mZ+f4pYaoQXLEENHDiqEp
        ySZc+87JhDnfhutav54bUWyGFiIC9GZzz7RRyXyZTdz/sDe1dkWR3/LmRuR/GomF
        bR5awmFxhQ547OWkmbWricTN9xFITDvoeqLYKb9NQtefG5V17WFPEAZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=NoqpwEw41wyDyhT2cDHnRnxJRFbyK9DqyqKAm7UWC
        8I=; b=XtAnA8Nvti2+xArleUMvbphVdR7R3Hpk4t2r5mMURMV19RpknQM8KMKQt
        RerC1FawIgFprZL+lV3c9olxTSOrAjsw86Sb66ig2SF39n7Mp2HBwgTlYk9ZSgsW
        jXULlchOvtfaJhLe7iw6UxYLwN3U1I7w7K3aBNhwt/FYoIpe6dCkvRE3J0QHyef0
        vqKp/OL84olwZcFfSVUtrO27oRRl2Prffkc4woIz+w9Cyk54BPWj1G0gsovvRHuB
        cpLqWykOawCCGZOjHLei5DCwRlWg+2uP73Q6tEkhuHHXduta4DxeAM7vW83ARgf4
        05HphwU/2sXudNay2hUVFqGyVPvJQ==
X-ME-Sender: <xms:Ajb0YbxMEVJYoW8YK2bvoGBMem0Iw405henp_qT1bU_fomEbA_dHhw>
    <xme:Ajb0YTSwlIkx1Jj0ldROwdmW_13QCDzSyzwtVOVpGi8Tu5OvZhIa1fMqqps0uKnNr
    TQe-TF3-gn5amEJ5Q>
X-ME-Received: <xmr:Ajb0YVUW7qnzVvr-FmneD4UVpGvEwW6VS54iRPO05ZvsoHJBe2qXyuUDjRYNxT3vHTyDJZ_9zaU-9BbKZJd4a6_PKV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:Ajb0YVhMr9MdbZzjoS1owjF6pZWLU47oliCyKKwxoz90gRl_cmZ2SQ>
    <xmx:Ajb0YdBVno3x4_qOpiTh4eCNGre0yn2-IMIEHtgazrNnWgnKs9xQsw>
    <xmx:Ajb0YeIFKopqkGmW2YCtOAKmNRmGP0I-xiY3tc6lWe0MrBtVVkVssA>
    <xmx:Ajb0YQrJJfUuTTjfGn5M-en9dPXk_nqNpRj9Eybd68Q41IG9kNKVRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 13:29:22 -0500 (EST)
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
Message-ID: <19bf3e06-3156-99b4-4656-6ac794ad1ca8@georgianit.com>
Date:   Fri, 28 Jan 2022 13:29:22 -0500
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
> How is this different from mdraid or hardware raid then? These also
> don't know the correct copy after partial or incomplete writes - and
> return arbitrary data based on which mirror is chosen.
> 


MDraid, and any hardware raid I'm aware of, will resynchronize the 2
copies whenever there is an unclean shutdown.  which copy becomes the
new master is arbitrary, but both will be the same.

BTRFS raid with nocow will intsead have what I call quantum bits.  They
can be 0 and 1 at the same time.
