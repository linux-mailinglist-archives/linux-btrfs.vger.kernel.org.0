Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70CA55223E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiFTQ1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiFTQ1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 12:27:40 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C720BDE
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 09:27:38 -0700 (PDT)
Received: from [76.132.34.178] (port=59372 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o3JX7-000451-A9 by authid <merlins.org> with srv_auth_plain; Mon, 20 Jun 2022 09:27:36 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o3KFU-007uzY-B3; Mon, 20 Jun 2022 09:27:36 -0700
Date:   Mon, 20 Jun 2022 09:27:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Ghislain Adnet <gadnet@aqueos.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220620162736.GB1878147@merlins.org>
References: <20220611045120.GN22722@merlins.org>
 <5e1733e6-471e-e7cb-9588-3280e659bfc2@aqueos.com>
 <20220620150132.GM1664812@merlins.org>
 <8d54c3c5-a0b5-fdca-f31d-f9b5c3eea655@aqueos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d54c3c5-a0b5-fdca-f31d-f9b5c3eea655@aqueos.com>
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

On Mon, Jun 20, 2022 at 05:52:14PM +0200, Ghislain Adnet wrote:
> well i completly understand i use btrfs for the same reason but
> it seems on your side that this use case is a little far from the
> features provided.
> The more layer i use the more i fear a Pise tower syndrome :)

I share that worry, but using ZFS simply isn't an option to me for the
reasons explained.
But indeed, I removed bcache as a layer.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
