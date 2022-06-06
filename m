Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB853EC79
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiFFOFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiFFOFH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 10:05:07 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 07:05:05 PDT
Received: from ts201-smtpout71.ddc.teliasonera.net (ts201-smtpout71.ddc.teliasonera.net [81.236.60.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7161731CC88
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 07:05:03 -0700 (PDT)
X-RG-Rigid: 626BF3990169006B
X-Originating-IP: [81.226.241.77]
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffktefuhgdpggftfghnshhusghstghrihgsvgdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvhffutgfgsehtjeertddtfeejnecuhfhrohhmpefvohhrsghjnphrnhgplfgrnhhsshhonhcuoehtohhrsghjohhrnhesjhgrnhhsshhonhdrthgvtghhqeenucggtffrrghtthgvrhhnpedutedvhedvfeejkedvteeugeekgfekudeliefhjefhteekgffftdfgleefffdtleenucfkphepkedurddvvdeirddvgedurdejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehgrghmmhgurghtrghnrdhhohhmvgdrlhgrnhdpihhnvghtpeekuddrvddviedrvdeguddrjeejpdhmrghilhhfrhhomhepthhorhgsjhhorhhnsehjrghnshhsohhnrdhtvggthhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from gammdatan.home.lan (81.226.241.77) by ts201-smtpout71.ddc.teliasonera.net (5.8.716)
        id 626BF3990169006B for linux-btrfs@vger.kernel.org; Mon, 6 Jun 2022 16:03:30 +0200
Received: from [192.168.9.3] (tobbe.home.lan [192.168.9.3])
        by gammdatan.home.lan (8.17.1/8.16.1) with ESMTP id 256E3ULM751480
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Jun 2022 16:03:30 +0200
Message-ID: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
Date:   Mon, 6 Jun 2022 16:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>
Subject: btrfs-convert aborts with an assert
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello

i tried to do a btrfs-convert of a ext4 filesystem and after a short while 
after starting it i was greeted with:

# btrfs-convert /dev/xxxx
btrfs-convert from btrfs-progs v5.16.2

convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
btrfs-convert(+0xffb0)[0x557defdabfb0]
btrfs-convert(main+0x6c5)[0x557defdaa125]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
btrfs-convert(_start+0x2a)[0x557defdab52a]
Aborted

Any idea whats going on?
Is it a known bug?
Is the btrfs-progs that come with my dist too old?
FYI the ext4 filesystem is a bit large ~10tb of used data on it.

I assume the convert didn't even start in this case and nothing was modified on 
the ext4 filesystem, correct? or?
