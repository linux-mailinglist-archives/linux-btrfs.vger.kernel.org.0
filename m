Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB04C5DE6
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Feb 2022 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiB0Rwc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 27 Feb 2022 12:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0Rwb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 12:52:31 -0500
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 09:51:54 PST
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087725AEE6
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 09:51:53 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1B33F46163B
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:46:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2890A4615C6
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:46:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1645983962; a=rsa-sha256;
        cv=none;
        b=b9dr5BX8/DxwAwJCtQJJqUrZ7EXwjKSbLt23HzegclX1SrnUh39axaPrbad32iszSaNB5G
        ZGpLcJIROlma/na4a7AyWcCF0FKiv2obK6S5hzdefWMv/tVn3Dt7XhMP/3PfPsiDXhrOKx
        NONQaVQXOapfok+88U4hDVNSyHxFvsxDL4kcA8qDGiExqETVNLcqCL65YcADRy6eD5u3N4
        bn//rbecktbAZ6Dc/ldOrraJFwZ0mtJqO/95NX2/uacHjGe/SKPN3VwtYWnZMRVhiE5Ig0
        UFtlc9ev72/1p7SXWc/rKclDGcLoL65/lkf6kdm+ttfFJILImW0eyb0SHkku8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1645983962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GpL2qxM4ZjmTijQUsWRlgb3IOzrFR6VCyeAml04wTn4=;
        b=f4RGzRuspTtyz/xcLPjpXID3Z0OnSEBOJT7CVcMPOJTXPPXF4rZ5qV7AbVaBll6pQz9+Rf
        uzty7+uKtItUdWuGy6BkIGxFHOuZVb7cxY8JJE5rI+ypJhcFecQSzsYrBOcBRLj9XpIrR8
        Mlcibd9pMWcVA9y/EKj5n7ouMa3n41Z/woKbwc9SZk8Qox18C4WNaDIuLszKX5r2U5zDUx
        EH6EGAoZ6rTWnMt7MYSf3sW9Ll7RZnFxR/DezxlHYuHBRvzUGAij2yTm38XBYM5TC4x46D
        Ovy8F4aVSp50QFLfNo7Ap4pzsA/5wigJyVE04k8hOdV3eih9KQm9C53j4PFPuQ==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-zctxc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.113.39 (trex/6.5.3);
        Sun, 27 Feb 2022 17:46:02 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Occur-Bored: 3b22945b2abff782_1645983962699_1638797658
X-MC-Loop-Signature: 1645983962699:2605404889
X-MC-Ingress-Time: 1645983962699
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:58794 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nONcJ-0007FL-P9
        for linux-btrfs@vger.kernel.org; Sun, 27 Feb 2022 17:46:00 +0000
Message-ID: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
Subject: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Sun, 27 Feb 2022 18:45:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

This is on 5.16.11, Debian sid.

This filesystem has existed since quite long (is the one from my main
working notebook).

Today I was doing a full backup onto another btrfs, with:
  tar --selinux --xattrs "--xattrs-include=*" --acls --numeric-owner -cf backup.tar /mnt/snapshots/2022-02-27
in which /mnt/snapshots/2022-02-27 is a snapshot from the filesystem
with the issues.

While tar was (or actually it still is) running I got these in the
kernel log:
Feb 27 18:35:10 heisenberg kernel: BTRFS info (device dm-1): disk space caching is enabled
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511299584, 64511303680)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511303680, 64511307776)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511307776, 64511311872)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511311872, 64511315968)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511315968, 64511320064)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511320064, 64511324160)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511324160, 64511328256)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511328256, 64511332352)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511332352, 64511336448)
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum hole found for disk bytenr range [64511336448, 64511340544)
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601640960 csum 0x62c2c721 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601645056 csum 0xff51e027 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601649152 csum 0x681a44cd expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601653248 csum 0xbbfad1b7 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601657344 csum 0x09ae86f1 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601661440 csum 0x09ee43ad expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601665536 csum 0xaae8fc18 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601669632 csum 0xe6d04b46 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601673728 csum 0x3e49bf9d expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Feb 27 18:36:52 heisenberg kernel: BTRFS warning (device dm-0): csum failed root 1583 ino 1354893 off 601677824 csum 0x08695db5 expected csum 0x00000000 mirror 1
Feb 27 18:36:52 heisenberg kernel: BTRFS error (device dm-0): bdev /dev/mapper/system errs: wr 0, rd 0, flush 0, corrupt 10, gen 0

And this in tar:
tar: 2022-02-25_1/home/calestyo/cpu-tests/test-vid-high-res.mkv: File shrank by 334726574 bytes; padding with zeros


1) Any ideas what caused this respectively what it means?

2) Can I check whether this is actually the file that caused that
issue?

3) Can I check whether other files are affected?

4) Is it recommended to recreate the filesystem on dm-0?

I would have a number of generations of snaphsots of that filesystem,
also sent/received onto another btrfs, if that would help anything for
debugging.


Thanks,
Chris
