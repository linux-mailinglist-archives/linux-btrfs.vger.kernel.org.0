Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD7613C1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiJaR0H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 31 Oct 2022 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJaR0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 13:26:06 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A7613CD4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 10:26:01 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CA0ED201F74
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 17:20:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 01966201EE7
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 17:20:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1667236841; a=rsa-sha256;
        cv=none;
        b=qTQ/7hoqwH+aZ/hlJ3KemhIAuJ5RiS/ljLSfvqCojZRSFhSUt+K6N9j3kq296DVf+/aWto
        LKi7dkEOep2/A7GmDr9IreTCCHjYY4EVlV4TaRxRbSPx5pyvYk8aqIdPgKTcEBeRI6ZCDs
        V1gx3K06uhCA3x7CTCLnJTmLsNGfCNrN/D0JYbYdUTJstS/kfOBdA+vTS9WJ6F2JRWS3D4
        S0jXajYmfusE0k8mku/RKoIGnudW/fg+hN0kg7Bop9aDy7ymWEBBEsnD2g3016NIuRtaWa
        Vl4iXJ0rl7omHgFnEzbdS0G6OlrJvw/jj5eXpOmAIpGNNT4D7H5fKGP0yFpvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1667236841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Gdb63BiNvoQ3DacQusoj71ZVEZDPOBg7bKMAzemYGs=;
        b=35YiHG2AteEDoS4eogZH5HzSl8KtROo44cDSHErW6ncrhC4T1AcOuInQ5XTc1bDqoVWFZj
        kqwvXxalejLS4NcFWSWUFmY4eSIjj6909WbMUxGVP8Wp4w7rsQf1hHa+Jz2eOPu8CW1GqK
        3UsxSpC3sRrYVtZCVD6+69UavJEYRaUIiefV1Rgep4jlqkIobM4toR42i4/KnBIxjD5vKP
        8gfkZEY8F5yZKSmE3ZoNOIeLi2UtEf8baHpHRBtdkDQaAlvaef3Jnw4Yc4VR2ZNOHKVi/K
        MKGgjbDp8WZZP4TQmAxk0dCp4gufLt2q7k0Kogi+e3MvT0s5GgUz3Faqvlh3uw==
ARC-Authentication-Results: i=1;
        rspamd-7b8dfb6d4c-m262b;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chief-Left: 437d1da944ceb213_1667236841493_442022083
X-MC-Loop-Signature: 1667236841493:346416808
X-MC-Ingress-Time: 1667236841493
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.104.101.135 (trex/6.7.1);
        Mon, 31 Oct 2022 17:20:41 +0000
Received: from ppp-46-244-255-15.dynamic.mnet-online.de ([46.244.255.15]:50836 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1opYSh-0004Px-3A
        for linux-btrfs@vger.kernel.org;
        Mon, 31 Oct 2022 17:20:39 +0000
Message-ID: <f3a163c460b436ba4da1991540e49f39036830d5.camel@scientia.org>
Subject: progs: differing "found N bytes used" for original/lowmem mode
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 31 Oct 2022 18:20:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

This is with kernel 6.0.5 and progs 6.0.

When btrfs-checking the same fs (without it being mounted in between)
with --mode=original and lowmem, I get differing values for the "found
N bytes used, no error found" line.

The fs in question was created with the same kernel/progs and filled
with some 600GB.


I vaguely remember that this used to be the case in the past but was
resolved eventually as a bug(?).


# btrfs check --mode lowmem /dev/mapper/newfujitsu ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/newfujitsu
UUID: 3c1b32b6-5940-11ed-b447-53dfc28b8b9e
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 581442859008 bytes used, no error found
total csum bytes: 566096284
total tree bytes: 1760264192
total fs tree bytes: 1012596736
total extent tree bytes: 71417856
btree space waste bytes: 253635124
file data blocks allocated: 629161189376
 referenced 600678027264
0

# btrfs check /dev/mapper/newfujitsu ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/newfujitsu
UUID: 3c1b32b6-5940-11ed-b447-53dfc28b8b9e
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 581442187264 bytes used, no error found
total csum bytes: 566096284
total tree bytes: 1760264192
total fs tree bytes: 1012596736
total extent tree bytes: 71417856
btree space waste bytes: 253635124
file data blocks allocated: 629161189376
 referenced 600678027264
0


Just in case someone is interested in having a look at this.

Thanks,
Chris.
