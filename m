Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199F33C2123
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGIJFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 05:05:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41815 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhGIJFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 05:05:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CB455C0131
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 05:02:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Jul 2021 05:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=o
        yBNhUWjPtvINUBtmUt/C7SvT2lClaZFUF/JabPmYw4=; b=KUDQSYphMGHYhLmRz
        Ad7Nft4PNomkxe5+IxbGWhMfOPjQPct8GVNUCyRGKZi80QVHEyfuFdDRv58WLkd+
        IXHFpbd0/GKfRhtnJ42S02KsEe6wJl4tbe6oR3b12qDAR8lcOlqjMyWLO2nz60X5
        K+olnHmj1Ph8M4hV9PItqHx2tBpugZqik0TX8FCWOWocj/8bsRrTcxBKOCBuLRs/
        1Elo2/GaXkul6du2vkPOoHGBZgjuhz2hcyZlJrg2/a8Xf65iqDWKvEhoyrEDehJ/
        WaJzEnEModDGKgmIv8KBFHnThS66N0vGfpeDypv6EcT+tXCbdsoOCEZudKsuNAaf
        ym0Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=oyBNhUWjPtvINUBtmUt/C7SvT2lClaZFUF/JabPmY
        w4=; b=BaXLREL20wshdJnzV2PtXS1aG8jueCYFH8hygM3V/axKkCMyhmsb6a7Ze
        7J2KCwosHuMrgzkn/W+++XEXmeIyeh1+wlExywrh7WX9uftrK/EIB33bo9mdP6vy
        g4D1Gm3bN0tgPD2ZeinomOdLlqztdS74tQ6TTD/iRbu3JyE1eMZMt5IxKNtE9mYu
        E1GjpGCKMGR7t9i6eFQOw7Dh3pXwi3d0E9Y3GFsvhZHzgpNtwA2k/XMzUMpTPfL3
        KecihkPnhVF40Y2/Eulw7Uv0EsFtuEOg8vGltrLTyII+csYT6ASPYleBWpeCF71+
        UeYen/WrUvcGHGNmaV/j45tTm8BEQ==
X-ME-Sender: <xms:nBDoYOjj_mvu0xCZrS__jVdM-oPV2N2IxZPRZdOCOqZrGhIHCmR_jA>
    <xme:nBDoYPCVH479Rw4d-3Ytud_vxandYIqtlITbgwzUbrdESnO3E0uQmIyjHqCDJ_ely
    CzvuuGmVpOydbfiug>
X-ME-Received: <xmr:nBDoYGHPyDQ7W4Bq1NNvKjPdjEL5zZANUI4Kh_t73QQdCLAKgj-jKsCINkUlHPsvks5EEO5TQeC409fS2I45bmdqid0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekjeduve
    eltdduueffhffhueekjeekkeeitdffhfffieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:nBDoYHTeIHSfASwWFK7sX0KOt-x5Wtc4Rp1VvJX5B1APzlvFO4QcpA>
    <xmx:nBDoYLyzDuGtqCM_kyyIMpRsyNHJVSpbjgBDLU8u1lBpSrtgrLQkJA>
    <xmx:nBDoYF4L9ELWdDUhTKgzHua1lL09xbXC02Ro3UYdgSeyFa1gdXJEWQ>
    <xmx:nBDoYMuWphvuFqXGfVBUCtBrQiV0VYpYVRzbTB2kRAUf-n2uZh5IjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Fri, 9 Jul 2021 05:02:20 -0400 (EDT)
Subject: Re: where is the parent of a snapshot?
To:     linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
 <20210709084523.GB1548@tik.uni-stuttgart.de>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <71c3a5d7-f917-e53b-d1c4-cefafcf2298b@georgianit.com>
Date:   Fri, 9 Jul 2021 05:02:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709084523.GB1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-07-09 4:45 a.m., Ulli Horlacher wrote:

> On Ubuntu 18.04 with btrfs 4.15.1 it looks different:
> 
> root@fex:~# btrfs filesystem show /mnt/spool
> Label: none  uuid: dfece157-dd48-4868-b4a3-51e539325aaa
>         Total devices 1 FS bytes used 1.85TiB
>         devid    1 size 14.55TiB used 1.90TiB path /dev/loop0
> 
> root@fex:~# btrfs subvolume show /mnt/spool
> /
>         Name:                   <FS_TREE>
>         UUID:                   -



Interesting.. but regardless, what you probably want to do is create a
new top level subvolume, (for example, @spool), and mount *that* (with
the subvol=@spool option.)

If for no other reasons, it will make actually rolling back those
snapshots much easier and cleaner, should the need arise.



