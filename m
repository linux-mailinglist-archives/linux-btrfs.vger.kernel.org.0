Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2450C717
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 06:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiDWD73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 23:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiDWD71 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 23:59:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01F767D
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 20:56:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ECDF85C021D
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 23:56:21 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Fri, 22 Apr 2022 23:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1650686181; x=1650772581; bh=oE9XyPXhzMfnKgB+1vAJuR5AGmL5MuI+SKu
        Y7vWu6fU=; b=qrio4WWm25csoG9H9oYUBD/0C3MugANoPKpaNG7u96ZFrvLcUXo
        rYHzHmp3Mw5H6WzkXtOPMurUEe+kshKmAOdPZaubwMd6DgPGYT3AUFRQvbPXIRsI
        /l2fWl0dCz+1fFXgWV7TERVetzgHnjq56deZ5T+jxHxpk/4F7zr7nVV65tCUGpTJ
        kEnf43wfyhnxSYiaSye/rZhCaJDBw/9ERk41LpjSpGcgEJ64hb44ZItLbibES/J2
        JltduwGHQ9QGFJtdvto8Wgger92xh5BwE9NnkM56eph/8JRMT1lbwxvG3opeWwDF
        vSMllEM4JOKCKDmfSpL8JvdOgWAkTpUSlXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650686181; x=1650772581; bh=oE9XyPXhzMfnK
        gB+1vAJuR5AGmL5MuI+SKuY7vWu6fU=; b=CAxn5cKCQhalJsEHXyavAW0LA0fl2
        xhKJIdVB2Hhg9sDHrhtYUh1kcZ+UABIDoN91d5ZmF5Na038oYKOwH7pxdAoRetgl
        0CM3CFkid0nQQfMTW5cfirkHjNXf96uPFKJMB6pF2mTuDF8pgdLmFUdTzsZ8gbu9
        ns9iwZj8b9Pt8y1tndZK0L5S6lYu+uK+j8XzCxI6KZGmogSeGKS6Z6UZ+51Yao+Y
        ybxBHWDZ6zoC1GyODBnIlQ5BNmmLagWEmJxczt0yd1wVFdajxeHPg+Ppc2lGANxn
        AzdDeLjZnQh7gFAkcHvBASlREYoKDGRU9E0dKvQSVe5v72rHY1S+SSv4w==
X-ME-Sender: <xms:5XhjYjMDi2l1fDBc5Dm210rr7c2LFe1im--McINTk6Lbiy03YWr2Xw>
    <xme:5XhjYt9KCkouxLE-iDSf8kq60nvVSY_cYW7pOyD4XjmInANdvyHYXLUlzbv0aOZFt
    xPZIPG6vOOGIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomheplfgrthcuoegsthhrfhhssehjrghtrdhfrghsthhmrghilhdrtgho
    mheqnecuggftrfgrthhtvghrnhepheeludejleegfefhtdffgfeuvdfgfedttefhudegle
    effeekheevkeehudejtdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghtrhhfshesjhgrthdrfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5XhjYiSTmiQNF6gZnje5a_gRNwbTZQxEpU0cPBvhiJIpdCoUMC2WGA>
    <xmx:5XhjYntqFpgY3G0MSF481Hj22UzoV9y6ri2g-2Qu8yBVEZZAmLaVhw>
    <xmx:5XhjYrec3fRy_B6tLlx_0BFUS3gwFpmH1LFAPL6rsfcA1EKh2BJX7A>
    <xmx:5XhjYlqBl6Hndd2le-HYXrpaSdFfrv60jUaNZzXWwWPrta_tec-lbw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B14DAAC0E98; Fri, 22 Apr 2022 23:56:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
Date:   Fri, 22 Apr 2022 20:56:01 -0700
From:   Jat <btrfs@jat.fastmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs check fail
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I am trying to resize a partition offline, but it fails the check.
The output of running btrfs check manually is below, can you please advise me how to resolve the issues?

Here is the output from btrfs check:
sudo btrfs check /dev/sda7
Opening filesystem to check...
Checking filesystem on /dev/sda7
UUID: 4599055f-785a-4843-9f59-5b04e84fea1a
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
root 267 inode 249749 errors 1040, bad file extent, some csum missing
root 268 inode 466 errors 1040, bad file extent, some csum missing
root 308 inode 249749 errors 1040, bad file extent, some csum missing
root 313 inode 466 errors 1040, bad file extent, some csum missing
ERROR: errors found in fs roots
found 103264391173 bytes used, error(s) found
total csum bytes: 93365076
total tree bytes: 2113994752
total fs tree bytes: 1825112064
total extent tree bytes: 144097280
btree space waste bytes: 432782214
file data blocks allocated: 352758886400
 referenced 178094907392


Here is the requested info from Live boot environment for offline partition sizing & btrfs check...
uname -a
Linux manjaro 5.15.32-1-MANJARO #1 SMP PREEMPT Mon Mar 28 09:16:36 UTC 2022 x86_64 GNU/Linux

dmesg > dmesg.log
[Sorry, didn't capture this after running the check in live boot environment. Will capture as needed next time along with recommendation]


Here is the requested info from within mounted environment...
uname -a
Linux manjaro-desktop 5.17.1-3-MANJARO #1 SMP PREEMPT Thu Mar 31 12:27:24 UTC 2022 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.16.2

sudo btrfs fi show
Label: 'manjaro-kde'  uuid: 4599055f-785a-4843-9f59-5b04e84fea1a
        Total devices 1 FS bytes used 96.19GiB
        devid    1 size 226.34GiB used 226.34GiB path /dev/sda7

btrfs fi df /
Data, single: total=220.33GiB, used=94.92GiB
System, single: total=4.00MiB, used=48.00KiB
Metadata, single: total=6.01GiB, used=1.97GiB
GlobalReserve, single: total=275.20MiB, used=0.00B


Thank you,
Jat
