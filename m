Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBA38136F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhENV40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 17:56:26 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58961 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhENV40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 17:56:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BAF985C00BE;
        Fri, 14 May 2021 17:55:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 May 2021 17:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=s
        5JIS3o7a7I4RE6zBV9n0XkQDfFOx+KRECtV1Eg9D6Y=; b=NUvgrhu9Zfs0C8G/1
        hvRZS59o8EnlZ11K0tUfBr6AgYnz/yFvEb292fT5qsaogGPAfgY2pBt1NpQ083U5
        1bUxS5Eo5uLUIgCtlua0YZWCWB9kbz65uHJFwu6LTcrEClA4oPZZI54oGlrXKaZh
        VrklQU9wWgLHyHe8q3ZQ1DUnrMR4Qz47EcvHPCaGcQ+cg02BeQk6rw0tL8qxpKtr
        Y4cwPTArKNBV2+wdiKAu/fsudhAVqp3qHM39xrfvpvSGrNORPjMZ7GYB+n/xFwgR
        qci3chl3GOy+cFeM+AGinfxWMLlJ4oYiqRQ6laL847A8ShVGwKNrKn3FqKOHpW5Y
        AygtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=s5JIS3o7a7I4RE6zBV9n0XkQDfFOx+KRECtV1Eg9D
        6Y=; b=dRx63oIQ7bgFz48NnTT2jb4Ap7ABRtDpBQ4XHESbd33xuqL//9JuLyuoz
        wcVPi/jH8lEbUfjmq2eDSz5pwuiVpmQRhN/avH4mYTLhlOy9PeZ9/qFpl6r2a81+
        sG9o39yDzp8wcn902+LREa3KS3YAgEHUOkRZBDyECuPd9t/+8CWr9yGRLKIWG8K3
        yEQRte5/c/A/0GfO/OpW4RpJADG2GRbuUv8Kg4fZzJA66CfWx2xkpzeG0iErU//l
        lYBuq7YZsW8+yPduSShBhKYQPNkekeUVz84rVqnUktfttsx5pIcv9JtzUlW7kpxm
        jNxUwGmftoPCqOromThov+ApftreQ==
X-ME-Sender: <xms:wfGeYI2pD_8EIY0pHubmAeN1vsTB6IAhu76U8lWx4-SmTsKCJJNpmA>
    <xme:wfGeYDH78YdKfCH2SttIC1O3HbOwiw6Dfe-24GSFeWiAV27_uxqx203m3iEurDvDQ
    kR3tWMl3QhSou4c1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephfdtueehgeevheettdehjeffgf
    etffeuudethefhveffteevhfdvffduudduiedvnecukfhppeduledvrddtrddvfeelrddu
    fedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprh
    gvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:wfGeYA5SQlDecLR4OEa67XFxzHwLBah9U4gw_k6wps4N-zC2ixhlKw>
    <xmx:wfGeYB3wwM8BwLCMiaKU1FdAHthHXoB8MmR7lPKZaHnOu0DELJqT2A>
    <xmx:wfGeYLEO4IlgwfsbdeRO5ZZ8teQU9Mcnn356-U-CnvXoW0ZKZuwNlQ>
    <xmx:wfGeYCwDDv7BDuW5IgL7YETYJo3PMrbyLkeK8t0WECKSgLcJ2E_90Q>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 14 May 2021 17:55:12 -0400 (EDT)
Subject: Re: Removal of Device and Free Space
To:     =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
 <20210514220612.6293aa23@natsu>
 <28e272b2-77de-881e-41d2-4357e133ac8e@knebb.de>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <059093e2-44fb-4879-eb61-370701a69e8c@georgianit.com>
Date:   Fri, 14 May 2021 17:55:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <28e272b2-77de-881e-41d2-4357e133ac8e@knebb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-14 3:54 p.m., Christian Völker wrote:

> 
> I do not like the idea of going to full file sync for my rsync backups
> as the bandwidth is my concern here. And it does not help either as I
> have compression enabled, right?
> 
> Any further ideas?
> 

You have compression enabled, but are you using compress-force?  If not,
many files will not be compressed at all, potentionally including those
responsible for your current situation.

You can use btrfs fi defrag -r -t 100M /path/to/subvolume to reclaim
most of the space lost by fragmentation, (assuming there are no
snapshots or reflink copies, otherwise, this will be counter productive.)

Note that defrag does not cross Subvolumes, so you have to run this
command for each affected subvolume.

