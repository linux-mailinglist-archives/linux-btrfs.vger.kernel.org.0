Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B637C552001
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiFTPMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiFTPLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 11:11:41 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577A1F2E3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 08:01:33 -0700 (PDT)
Received: from [76.132.34.178] (port=59366 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o3IBp-0006tC-0l by authid <merlins.org> with srv_auth_plain; Mon, 20 Jun 2022 08:01:32 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o3IuC-007oB8-1V; Mon, 20 Jun 2022 08:01:32 -0700
Date:   Mon, 20 Jun 2022 08:01:32 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Ghislain Adnet <gadnet@aqueos.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220620150132.GM1664812@merlins.org>
References: <20220611045120.GN22722@merlins.org>
 <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
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

>  I have a stupid question to ask : Why use btrfs here ? Is not mdamd+xfs good enough ?
 
I use btrfs for historical snapshots and btrfs send/receive remote
backups.

>  If you want snapshot why not use ZFS then ? i try to use btrfs myself and meet a lot of issues with it that i did not had with mdadm+ext4. Perhaps btrfs is not suited to that use (here raid5) ?

ZFS is not GPL compatible and out of tree.

>  ZFS has crypt, raid5 like array and snapshot and LARC cache allready so no need to add 4 layer on it. It seems a solution for you.

It has a few of its own issues, but yes, if it were actually GPL
compatible and in the linux kernel source tree, I'd consider it.

It's also owned by a company (Oracle) that has tried to sue others for
billions of dollars over software patents, or even an algorithm, i.e.
not a company I'm willing to trust by any means.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
