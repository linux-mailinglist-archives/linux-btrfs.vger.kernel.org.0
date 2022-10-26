Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD760E1A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiJZNKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJZNKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 09:10:37 -0400
X-Greylist: delayed 1527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 06:10:35 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CF2FFFF;
        Wed, 26 Oct 2022 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0La9xePEka4s3dK4EFGiM4QoypNG8UN+HmXZKdb7kCA=; b=iD+0Q10MfbKIiKO0rg1t2AynId
        bJM/S+Lmse1dcjOxPPMJHCfeWDgIyqq5todb/szevvYniRfZ9CnrWoBK0MvHV9Vi1cEEuGZqbu/9W
        qEoOpOj1HPlvfFjWifOdf2MnQNw1W2Rg7ilVrDJ56FY80PnM/NjBDvv9kdUZGBac+XZEkZFkvVoJk
        ipaQc0oZC9LZEscYBPMxDoavzT8vd6So7C4AeyAl6qroApzrSiKpt8um1g/mCJt1Hf0PYYaVmKwLM
        agzjQVWVhD83Cpvo7xtNNJvSlKcLxXpEvzyi10T10j2UtF/FKWmq23GOACszkU0KCvO1fkboyqKEp
        aAq2UzNA==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <norbert@preining.info>)
        id 1onfmL-004sbp-LG; Wed, 26 Oct 2022 12:45:05 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 46942DE9448; Wed, 26 Oct 2022 21:45:01 +0900 (JST)
Date:   Wed, 26 Oct 2022 21:45:01 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Lenovo X1 - kernel 6.0.N - complete freeze btrfs or i915 related
Message-ID: <Y1krzbq3zdYOSQYG@bulldog>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

(please Cc)

I got a new laptop Lenovo X1 Gen 10 Alder Lake, and installed Arch on
it. In contrast to my desktop that runs the same kernel and software,

kernel 6.0.N (latest stable), with or without -zen changes
Arch linux uptodate
Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET67W (1.32 ) 09/27/2022

The laptop is freezing like hell. At the moment it hangs reproducible
on every boot after a few seconds (around 20?).

I captured a call trace on photo:

btrfs_release_delayed_item.part
btrfs_delete_delayed_dir_index
...

(more on request, I can type it in)


Intel i915 also has loads of warnings. I tried with 
	i915.enable_psr=0
otherwise screen flickering and tearing is bad, and bad pixels show up.
Adding the enable_psr=0 did fix that.

Other things are that the GUI (Plasma via X11 - not wayland) is often
freezing completely. But I guess that is a consequence of the btrfs
error above, since starting new shell does not work, anything that wants
to read from disk is hanging.

I captured a recent boot log:
	https://www.preining.info/boot.log
which shows in detail hardware etc.

I am more than happy to:
- compile kernel with patches
- provide detailed information as far as I can gather them

Thanks for any comment/help

(Please Cc)

Best regards

Norbert

--
PREINING Norbert                              https://www.preining.info
Mercari Inc.     +     IFMGA Guide     +     TU Wien     +     TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
