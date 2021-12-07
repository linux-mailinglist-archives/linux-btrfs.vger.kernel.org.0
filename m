Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4A46BD08
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 14:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhLGN74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 08:59:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39453 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237400AbhLGN7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 08:59:51 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 64C123201C28
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 08:56:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 07 Dec 2021 08:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=7LAUGen6rTvzqGsXtCwVY9vXbK
        9TtyFaqCoggw05caY=; b=EA8gyENtnfdrQH1DEZPnTNIfp7CxhKwTaxKVQMTTD6
        gHhO5DMO4gQpjRWLbgMnpCt+31nujXO4OxNGkQk59trc7XQd0f2PrafYc7q+31pT
        SGq3l9uvWced6qTNlW9ff6xj40dePq5Ur0b2Rx0C6xPVIXRIlf8cfXJikFvvmGxN
        qGRWJhPF5mFbeSQkxRmyZ07bJ3fgL3WYb8d6TQDAcmqf0aGAPBRW7k7+x7MRMjma
        NsPIA5oYL52KG8tmJFin5cnmbNRS3nNvx3ttrezLk7Z4S85VtiRiw+aPzxzx4u8O
        lxkCDXDJ5i+h5UvP9pcEQ5d9aoByLHPNkbU33ygd51SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7LAUGe
        n6rTvzqGsXtCwVY9vXbK9TtyFaqCoggw05caY=; b=Hh5XeWaOD/nX+3yUyeM5Wb
        hy9y7x+ecwVgjAhzPALCJE8Pwu0ipXkGC+BtPn0Vd+/jMQLqVyW05No9iDJrRKzt
        3ichsTounN9w5d6cvz+OX+lPV2B3TwkpPEEfPwg0CSdq4aQNKKBXRc9Kygw4qpcr
        +5Y8FjZRVMKBSSdnjAk9jrJ8/yDAMH3vCQbnuyQ+8+7jAC4T1PTe7whEO71ZkblC
        HgWBkyUn/wjn2Ae9sTXb8uhcqoW9s8ZIArllpgZjcWsgWk9Fv3fLBZDOPBTX/Tlv
        rKdcy1NWtgVnHSof3aSim80hItgAe1SVnjXY+Pv3hkBtDz77QvYYm1zYCbOxmNrw
        ==
X-ME-Sender: <xms:A2ivYbqktEo1h7R-V7h4NFPt0cQ-GMDC1nuCkfk5cR0ep4H_SUpk2w>
    <xme:A2ivYVpbV4psBLxPGGIflvvmRNGKPqKPH5dXuqel72E1tCYhOR18J_STG-iVOilGj
    gXT5J0VOr82PLyhDw>
X-ME-Received: <xmr:A2ivYYMZnZ2-JFiztaNAlLKEm0xcBgeRKmZoxD7dLqJFaN_U04eCQNzrCh8RZQdrI1Br1pUfEzc79SJDaJjbjmfUVOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthekredttd
    efjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghn
    ihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeguefhtefggfefteejteegteelueevje
    evhfeutddvkeejgeehveelkeejtefhudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:A2ivYe76dqTNTLwQXWe2Yjb8HXo-9Sd_8XvrIE5_SimXwLWqyrTOyg>
    <xmx:A2ivYa5vxt85R62aR_B9VLIyBn5NEmwxmXmwrDpjyLV11AmACsDNeA>
    <xmx:A2ivYWh9Iukg10YnHCau8wKW2FXBtynRIyEOL_TPYHBj68XaJj948g>
    <xmx:A2ivYXXfxaCGBKOT0eM3-JRX-YXN8X9qhFczY5QDoYFhkB2W8ohTsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Tue, 7 Dec 2021 08:56:19 -0500 (EST)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Simple test of compress-force=lzo pathological on HDD
Message-ID: <7d69e8a0-cabf-93fb-3db8-de155636154f@georgianit.com>
Date:   Tue, 7 Dec 2021 08:56:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was trying to test performance of compress-force a few months ago and
observed very strange difference between SSD and HDD.

I apologize if this is a long fixed kernel bug, and probably something
well known to BTRFS Devs, but I don't think is well explained to users.

My test was very simple, sequential write and read of a large file with
a mix of compressible and uncompressible data. (ie, VM disk images.)

On Sata SSD, this was almost a pure win.  The read/write speed was
greater than the approx 500MB/S limit from the interface, and the disk
space no longer grows to almost 2X the file size with fragmentation.  I
understand that are probably negative consequences to random reads, but
nothing that is immediately noticeable to me without benchmarking.

On HDD however, there was a very unexpected consequence.  Even though
the file could be written at the full speed of the HDD, trying to read
the file sequentially the read speed was less than 10% of the speed the
drive would write the file in the first place. (simply dumping to
/dev/null with ddrescue.)  The only reason I can think of for this to be
the case is because the small extent size is forcing lots of seeking
through the metadata. (Either that or the small extents are being
written to disk out of order.  Even though the writes are effectively
grouped together, reading back the data requires lots of seeking.)



