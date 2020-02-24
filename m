Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34916A82B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 15:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXOTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 09:19:17 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37345 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbgBXOTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 09:19:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CB0BA4B9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 09:19:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Feb 2020 09:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cJ/CDD
        k+5zM8aw5YRizRLQ4Qc97GznDcRdsd4XGdUW8=; b=1LnuLJmez2qjIzv2rRpprS
        h4gw2DkgIeIAW11MCf1dAw985k5z8VIyCNUnyn47rPJmualP0hyO4q3VQyMFYdNi
        oIvX1DRNdS5S6jRSOI8Eniq+tiL7jq/OB/kCLDKAzt+biXpM6Ocq8EmVZOv2z+PX
        q1uCacOVAO6S6AWDg4wvCQreCTx9ETNn9kwj33Lx4qvkZrilfHluUihvh8dr26x9
        v1UwSXLB8fqWq8ZVtEopLFCRtPSyRz8R/COGXOPMTxnmM2oyG+884eIpcSzJ41s4
        0t6Tbgwbr1x21BLAKXiLd3fmNSJwpNwoBUARoFTrdH7xW+CS0aD5Z+xHjddByZ+Q
        ==
X-ME-Sender: <xms:Y9tTXn7CciFDSx1vDwO02bypeQKnG5-LZ6gTMUR12ipkcANNJNNdhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthejredttd
    efjeenucfhrhhomhepvfhomhcujfgrlhgvuceothhomheshhgrlhgvrdgvvgeqnecukfhp
    pedukeefrdekledrfeehrdejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehtohhmsehhrghlvgdrvggv
X-ME-Proxy: <xmx:Y9tTXmMeTBMW9VL3B3_aTK7u6ca8qPVW5j2yJ2uuiA-fha-Zpg5OGw>
    <xmx:Y9tTXq2hP3iUak_4zOpPx51z14OMvwLEAq2tcOJVowZzGcO3YldHpg>
    <xmx:Y9tTXvtknQsHMVnHXdEKLrrri17J18IcI63d7YMrnNNCrWldHozxzQ>
    <xmx:Y9tTXn1H4IYXR2yLEnGL49NF895o9Dipe9SL5g7lCVPcihTqq7W35Q>
Received: from [192.168.0.107] (mx-ll-183.89.35-70.dynamic.3bb.co.th [183.89.35.70])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC34F3280069
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 09:19:14 -0500 (EST)
To:     linux-btrfs@vger.kernel.org
From:   Tom Hale <tom@hale.ee>
Subject: Reproducable un-receive-able snapshot send
Message-ID: <e52e68aa-1ad5-b186-395a-6559e3212fd3@hale.ee>
Date:   Mon, 24 Feb 2020 21:19:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Would anyone be interested in helping me debug:

* btrfs-progs v5.4

* A FS which is reported as OK by 'scrub'

* A parent and child snapshot combination which cannot be received - 
even on the same FS it was sent from. (In fact, many children cannot be 
received based on the one parent)

* Send aborts with this message:
ERROR: cannot open 
/media/ssd/btrbk/rootfs/TEST/rootfs.20200126T0000/o3658332-53841-0: No 
such file or directory

* Lots of directories (not created by me) in the "root" of the partially 
received subvolume named such as:
o1101063-3046-0
o1194908-3075-0
o127448-2877-0
o127454-2877-0
o127714-2877-0
o128369-2877-0
o1305760-3109-0

If so, please give me directions / point me at resources to gather 
information for you :)

[Please reply-all - I'm  not on-list]

-- 
Tom Hale
