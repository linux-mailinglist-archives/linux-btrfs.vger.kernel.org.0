Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B479B49FD9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiA1QFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 11:05:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38051 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234788AbiA1QFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 11:05:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 645D65C0165;
        Fri, 28 Jan 2022 11:05:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 28 Jan 2022 11:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=yG0OCbe1iNJgSe
        HAfhJsQ9DmGksC0bBYKUxEWfNUFSo=; b=qIpmuOIUiNWuT6zWSUQSBIhGjB00F9
        2jB88+kddpTfqbNSIpF3HSF+Jpj8ls/GA2a0lq4DB/NNGsKu8IuldKTP5l9zqnfJ
        ye/YalsSXDl3/xRX7zPxlfCCWYLDpcJbUDqTEYYnCoF3APZU2V+LsFYPwHc97Wt+
        PnDMs17T86BFR8eQaiVCZ+2AtvtIcumVXZwtv1yprUITlPeskP2Rgbs+xHMwzecV
        4PIALm0lTg0y38eieuYY5gUGSYItdJrhx7UulE0ox80lDxpUxXvuKbsN6FFEk78s
        zILBjQww2t7gEa/I/TPqlL6Mru98HxkMGa1VP6yaX5NRqG665vywMIuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yG0OCbe1iNJgSeHAfhJsQ9DmGksC0bBYKUxEWfNUF
        So=; b=f08UeW/2Afff5wGrFphDoOuORbaYu1yrRxXCcnLmpLMFeeCEhw0ylcukC
        IFz9knzhsDImkR0nrA50z8vgJietsSKnnAsr9nFyzD1KEnulB7KpwA8tdsUqWber
        ll9U2KvoHuHS5VvNdeh/Bz5SgHELaYujmwnJhVGOUh5dsI4Y34y83AN0JrXHj3Cw
        z0Qz3dh/NNDgbNlCe3cAUqPMPLhIpXyg2ra+FSA/WThPDIaKOw3CvXzVBvLfB36K
        W0OX/ayemV8VvmCz2DpgZQ0Jzz+ZtpSpaa+X0rvMNRbWIG7wbiJKcwS0O3fb19+P
        HrDC8QvgSjbyAS9FTZC5BoG2J6mhw==
X-ME-Sender: <xms:YRT0YQ_kgqJOeCc8kV2cV81h7UjbPPIQLO4iuUDazSsyPCIdptTVlQ>
    <xme:YRT0YYuwalKXOxt6kqvajeybu-LNphe4njjxLaU-CVOuM1_Snh-3K-7Inr38sVvrb
    PQ5243suY90SZqdnA>
X-ME-Received: <xmr:YRT0YWBljjPExiC9uD15td1N36wqb6TC-nmJoGsuyrONs6DWiEMBt8nxZQ3d7y0QU80LSQ0mEVx6RYmXt_O-IS4eTK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekjeduve
    eltdduueffhffhueekjeekkeeitdffhfffieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:YRT0YQfWGNzFyAzGJJ9Y1M2pym35zoKZFJDuZ_zIz8TSmr1mwBRzJg>
    <xmx:YRT0YVMvlaPhWjekr8aqRPzvOI_WcyLSV9dJMP69fjmnA3271hPumg>
    <xmx:YRT0YalUdMpG2uL84z68HctpoXUXudztkSWH3FZo7Z2iiJUJ4k2duA>
    <xmx:YRT0YT37ey98GvU3IBuTOaiQw8Z3OvoVBjKgJH4zEtwwkaOs3WlcLg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 11:05:52 -0500 (EST)
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>, piorunz <piorunz@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
Date:   Fri, 28 Jan 2022 11:05:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-28 6:55 a.m., Kai Krakow wrote:

> 
> Database and VM workloads are not well suited for btrfs-cow. I'd
> consider using `chattr +C` on the directories storing such data, then
> backup the contents, purge the directory empty, and restore the
> contents, thus properly recreating the files in nocow mode. This
> allows the databases and VMs to write data in-place. You're losing
> transactional guarantees and checksums but at least for databases,
> this is probably better left to the database itself anyways.

This might be critically bad idea combined with BTRFS RAID,, BTRFS does
not have any means to keeping the Raid mirrors consistent *other* than COW

