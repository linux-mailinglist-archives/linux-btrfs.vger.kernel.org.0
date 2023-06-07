Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23594726A53
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjFGUCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFGUCH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:02:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E21712
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:02:05 -0700 (PDT)
Received: from svh-gw.merlins.org ([76.132.34.178]:57714 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1q6yPb-00015u-VA by authid <merlins.org> with srv_auth_plain; Wed, 07 Jun 2023 13:02:00 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1q6zM0-000DEP-1a; Wed, 07 Jun 2023 13:02:00 -0700
Date:   Wed, 7 Jun 2023 13:02:00 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230607200200.GA43020@merlins.org>
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
 <20230606164139.GK105809@merlins.org>
 <20230606232558.00583826@nvm>
 <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
 <20230607191719.GA12693@merlins.org>
 <a2a492ee-baa5-6881-e9ec-85ca2e611879@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a492ee-baa5-6881-e9ec-85ca2e611879@knorrie.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 07, 2023 at 09:32:13PM +0200, Hans van Kranenburg wrote:
> > On the plus side, this seems to have fixed the issue:
> 
> Just a random hint... One possible situation in which a deleted
> subvolume can't be freed up for real yet, is when there is a process
> that still has an open file in it.

this is a fair guess.
Too late now, but is this something that would show up in 
lsof -n | grep volume ?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
