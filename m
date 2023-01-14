Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E966AC1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jan 2023 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjANPcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Jan 2023 10:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjANPcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Jan 2023 10:32:09 -0500
X-Greylist: delayed 935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 07:32:05 PST
Received: from mail.nethype.de (mail.nethype.de [5.9.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DA65A1
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Jan 2023 07:32:04 -0800 (PST)
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.94.2)
        (envelope-from <schmorp@schmorp.de>)
        id 1pGiGg-000IDh-H3
        for linux-btrfs@vger.kernel.org; Sat, 14 Jan 2023 15:16:26 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.94.2)
        (envelope-from <schmorp@schmorp.de>)
        id 1pGiGh-00CLDT-0Z
        for linux-btrfs@vger.kernel.org; Sat, 14 Jan 2023 15:16:26 +0000
Received: from root by cerebro.laendle with local (Exim 4.94.2)
        (envelope-from <root@schmorp.de>)
        id 1pGiGf-0000Cq-UV
        for linux-btrfs@vger.kernel.org; Sat, 14 Jan 2023 16:16:25 +0100
Date:   Sat, 14 Jan 2023 16:16:25 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: please reconsider silently suppressing error messages
Message-ID: <Y8LHSZHq9EKhTRTw@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I am not subscribed to the list.

I recently started a btrfs scrub on a filesystem where I suspected some
data had been overwritten (externally to the filesystem, due to a faulty
raid configuration).

Indeed, a single corrupted file was found and logged to the kernel log, which
was easily deleted and restored from backup.

Unfortunately, the corruption stat count showed >200000 uncorrectable
errors, a discrepancy that caused me to investigate.

To my surprise, it turned out that:

a) btrfs scrub _completely silently_ rate-limits error messages
b) the rate limit is hardcoded and, unlike the normal kernel rate limit
   mechanism, is not configurable in any way (so cannot be disabled).

So the only way to find out about scrub errors was to patch the kernel.

I think this is a higly suboptimal state of affairs - I can understand
warnings being suppressed to some extent, but not file corruption errors,
especially as there is no other way to get a list of errors. Even if, for
some reason, corruption error messages should be rate limited, there at
least should be a mechanism to configuire/disable this rate limit.

So please, reconsider rate-limit errors, especially those messages that
pinpoint which blocks and files are affected. If btrfs scrub silently ignores
errors (other than increasing a counter), its usefulness is greatly
diminished. At the very leats, provide a way to disable this hardcoded limit
other than by patching the kernel.

Thanks for considering this.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
