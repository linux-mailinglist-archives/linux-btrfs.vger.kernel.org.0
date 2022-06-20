Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007555522BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiFTR0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiFTR0k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 13:26:40 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE01EC69
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 10:26:39 -0700 (PDT)
Received: from [76.132.34.178] (port=59374 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o3KSD-0007zi-PQ by authid <merlins.org> with srv_auth_plain; Mon, 20 Jun 2022 10:26:37 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o3LAa-0080YP-Ma; Mon, 20 Jun 2022 10:26:36 -0700
Date:   Mon, 20 Jun 2022 10:26:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Ghislain Adnet <gadnet@aqueos.com>, linux-btrfs@vger.kernel.org
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220620172636.GC1878147@merlins.org>
References: <20220611045120.GN22722@merlins.org>
 <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
 <20220620150132.GM1664812@merlins.org>
 <bef3cb0a-6128-8d4e-80e4-dc49770f4bf7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef3cb0a-6128-8d4e-80e4-dc49770f4bf7@gmail.com>
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

On Mon, Jun 20, 2022 at 08:02:59PM +0300, Andrei Borzenkov wrote:
> ZFS on Linux is not owned by Oracle to my best knowledge.
> 
> https://openzfs.github.io/openzfs-docs/License.html
 
Oracle bought Sun and its patent portfolio in the process, including all
claims to any patents in ZFS. I simply will never trust them given what
they've already done.
I did give a full talk about this issue years ago.
https://marc.merlins.org/linux/talks/Btrfs-LC2014-JP/Btrfs.pdf
and go to page #5 and
https://www.theregister.com/2010/09/09/oracle_netapp_zfs_dismiss/
basically there likely are Netapp patents in ZFS too, but I'm less
worried about Netapp suing others for patents, and they did settle 
with Sun back in the days.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
