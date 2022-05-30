Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74EA5387AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiE3TSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiE3TSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 15:18:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651A8722C
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 12:18:35 -0700 (PDT)
Received: from [76.132.34.178] (port=59078 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nvkC3-0002lH-4r by authid <merlins.org> with srv_auth_plain; Mon, 30 May 2022 12:18:34 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nvkuQ-006Mqg-5S; Mon, 30 May 2022 12:18:34 -0700
Date:   Mon, 30 May 2022 12:18:34 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220530191834.GK24951@merlins.org>
References: <20220529153312.GF24951@merlins.org>
 <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org>
 <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org>
 <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org>
 <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org>
 <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 29, 2022 at 09:14:23PM -0400, Josef Bacik wrote:
> Ah ok that makes sense, fixed it, sorry about that.  Thanks,

Same?

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
WARNING: cannot read chunk root, continue anyway
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ret is 0 offset 20971520 len 8388608
ret is -2 offset 20971520 len 8388608
checking block 22495232 generation 1572124 fs info generation 0
checking block 22462464 generation 1479229 fs info generation 0
checking block 22528000 generation 1572115 fs info generation 0
checking block 22446080 generation 1571791 fs info generation 0
checking block 22544384 generation 1556078 fs info generation 0
checking block 22511616 generation 1555799 fs info generation 0
checking block 22577152 generation 1586277 fs info generation 0
checking block 22478848 generation 1561557 fs info generation 0
checking block 22593536 generation 1590219 fs info generation 0
checking block 22609920 generation 1551635 fs info generation 0
checking block 22560768 generation 1590217 fs info generation 0
ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
Tree recover failed
gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
Already up-to-date.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
