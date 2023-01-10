Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB326640DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 13:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbjAJMtb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 07:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjAJMta (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 07:49:30 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9B4FD54
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 04:49:29 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 339EB320091B
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 07:49:26 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 10 Jan 2023 07:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=terrorise.me.uk;
         h=cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1673354965; x=1673441365; bh=2p8HGTVHwfMKWiXxefXwL/riyp4Xm/flL9+
        E/g3Qgx0=; b=TamSbZ4nJaAEi6T2GJRgDgmKbLgV7HF2s26MmCOInEd5ubvb7Ep
        CtXJbfcTxibuQkDyO1pJ41y6KSORKMRti6QMp2iRMKVFdQtRise+a+HBEIlZONLC
        6QE7p1ft6457gnPvOAFv1GuS+AuHIGqFl6TFmHfAa9YdW+mZneK4RIbaRxmgX1ME
        ruNoJLsuCABRToBUqfptbMi17KbU9iRqJ0cDbp+YbQeWBCIr3Ma+J7c0sdYTzBBG
        aaw+PfdSoCBHyxWOIkzAiW5iqmyYdul4J6VbZtXCgDGtAd0UXD6IPpa1GGmcBsnJ
        caYNOV9Lh3vZpJfbd3/I7Mr1edKfE63jMjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673354965; x=
        1673441365; bh=2p8HGTVHwfMKWiXxefXwL/riyp4Xm/flL9+E/g3Qgx0=; b=p
        BuRGnSLdK0S3WFcarWYzxo9UskgXKySXzj7GBiko+oHgDc/cHwhK3hnxXwxhoZ5s
        NqDgmhK1JrMyVXZ5U4op+2yU1IXj1MGBb7yG+UNHz8Qg0lW7zbHgNllxVs25xpmE
        eIRmG3gF18zjMi+9rb3enPub6y0SgzR1oT6n/E8V9czwLH3ZKtcqsc5P1jJs6Mbp
        Mv+1QLAQ6LTzPdyMdimZlqrXPRLhxNGeUhOmQhfs7B8scAhj88xH1roGYMAB0Oaa
        XvPLLnDsB2ebvNBDay8ob8VwuXWGCT3chNzfrFWSLqNCLjdz8kS4jSMdcs83q+ir
        aLhYo2TLgdLsCB5z3TXFw==
X-ME-Sender: <xms:1V69Yx6DnGWa1olX1NhduYCXxpbnCBGrGLOUxeKfe4s3TAmlCBtSiA>
    <xme:1V69Y-7jDg2l_1RcmTKTn7bx-H_Hf2UEUEG5xnaMSrNCK6NkYfRkcmdKJOynbNQZF
    HCzmuxEvc6EWD53zvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeekgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdfhrhgrnhhkihgvucfhihhshhgvrhdfuceofhhrrghnkhhivges
    thgvrhhrohhrihhsvgdrmhgvrdhukheqnecuggftrfgrthhtvghrnhepfeetudfhjeejhf
    efheeihfeggeejtdefjedugeevieejkeeluddulefggffgudefnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhrrghnkhhivgesthgvrhhroh
    hrihhsvgdrmhgvrdhukh
X-ME-Proxy: <xmx:1V69Y4c452oC2dQw2B8GVIr8ca3-RF7O8pN2Jimu92M_qWo26yBY4w>
    <xmx:1V69Y6LHk7Ryg76y9oXzJiVgfOO0977NU0eBAJEpWPyszbJWga41Ig>
    <xmx:1V69Y1JQ42mM0au6EPczvBnuNA2K4lzrqxazcOFKzuKX-K5-X02eMg>
    <xmx:1V69Y6XzQnDiClbCuQ0FdaTVZMtBPIGDOpCkCk9bEGif0pkWe4jqsQ>
Feedback-ID: i3b4144de:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9814DA6007C; Tue, 10 Jan 2023 07:49:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7c69dd49-c346-4806-86e7-e6f863a66f48@app.fastmail.com>
Date:   Tue, 10 Jan 2023 12:49:06 +0000
From:   "Frankie Fisher" <frankie@terrorise.me.uk>
To:     linux-btrfs@vger.kernel.org
Subject: errors found in extent allocation tree or chunk allocation
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I upgraded a box's kernel from 5.4 to 5.15 then restarted it. The box had been up for 2 months before the restart and after the restart the btrfs filesystem wouldn't mount. I suppose there are two possibilities - the issue occurred during the 2 months of uptime or as a consequence of starting up with the newer kernel.

uname -a:

Linux basie 5.4.0-136-generic #153-Ubuntu SMP Thu Nov 24 15:56:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
Linux basie 5.15.0-57-generic #63~20.04.1-Ubuntu SMP Wed Nov 30 13:40:16 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux 

I first restarted with the older kernel 5.4 and the problem recurred. dmesg output (filtered for btrfs/BTRFS) is similar with both kernels:



[    4.607811] Btrfs loaded, crc32c=crc32c-intel, zoned=yes, fsverity=yes
[   22.257868] BTRFS: device fsid 0f4a1bba-fbd1-4007-88f8-5c288a8eb161 devid 11 transid 4797718 /dev/sdh2 scanned by btrfs (561)
[   22.257977] BTRFS: device fsid 0f4a1bba-fbd1-4007-88f8-5c288a8eb161 devid 8 transid 4797718 /dev/sdg2 scanned by btrfs (561)
[   22.258313] BTRFS: device fsid 0f4a1bba-fbd1-4007-88f8-5c288a8eb161 devid 10 transid 4797718 /dev/sdf2 scanned by btrfs (561)
[   22.258420] BTRFS: device fsid 0f4a1bba-fbd1-4007-88f8-5c288a8eb161 devid 7 transid 4797718 /dev/sde2 scanned by btrfs (561)
[   22.258531] BTRFS: device fsid 0f4a1bba-fbd1-4007-88f8-5c288a8eb161 devid 9 transid 4797718 /dev/sdd2 scanned by btrfs (561)
[   29.581350] BTRFS info (device sde2): disk space caching is enabled
[   31.414167] BTRFS info (device sde2): bdev /dev/sde2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[   33.735212] BTRFS critical (device sde2): corrupt leaf: block=30874802077696 slot=176 extent bytenr=21866556121088 len=4096 previous extent [21866556112896 168 4503599627378688] overlaps current extent [21866556121088 168 4096]
[   33.735234] BTRFS error (device sde2): block=30874802077696 read time tree block corruption detected
[   33.751471] BTRFS critical (device sde2): corrupt leaf: block=30874802077696 slot=176 extent bytenr=21866556121088 len=4096 previous extent [21866556112896 168 4503599627378688] overlaps current extent [21866556121088 168 4096]
[   33.751484] BTRFS error (device sde2): block=30874802077696 read time tree block corruption detected
[   33.751517] BTRFS error (device sde2): failed to read block groups: -5
[   33.757126] BTRFS error (device sde2): open_ctree failed

I ran btrfs check with btrfs-progs v5.4.1

Checking filesystem on /dev/sde2
UUID: 0f4a1bba-fbd1-4007-88f8-5c288a8eb161
[1/7] checking root items

[2/7] checking extents
ref mismatch on [21866556112896 4503599627378688] extent item 0, found 1
backref bytes do not match extent backref, bytenr=21866556112896, ref bytes=4503599627378688, backref bytes=8192
backpointer mismatch on [21866556112896 4503599627378688]
extent item 22704514924544 has multiple extent items
ref mismatch on [28106103517184 8192] extent item 4503599627370497, found 1
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
there is no free space entry for 4525466183491584-21866556121088
cache appears valid but isn't 21865483468800
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 4511516231163904 bytes used, error(s) found
total csum bytes: 7142228136
total tree bytes: 11304239104
total fs tree bytes: 3378511872
total extent tree bytes: 386826240
btree space waste bytes: 930753844
file data blocks allocated: 28547414216704
 referenced 7990763888640


I also installed btrfs-progs v6.1.2 and the outputi was similar, other than section [3/7]:

[3/7] checking free space cache
There are still entries left in the space cache
cache appears valid but isn't 21866557210624
There are still entries left in the space cache
cache appears valid but isn't 21867630952448
.... (similar lines removed)



Any suggestions to recover this filesystem are gratefully received!

Cheers,

Frankie Fisher
