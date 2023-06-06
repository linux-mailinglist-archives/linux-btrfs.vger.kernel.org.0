Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01111724963
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjFFQlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbjFFQlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 12:41:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991092
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 09:41:43 -0700 (PDT)
Received: from svh-gw.merlins.org ([76.132.34.178]:36790 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1q6YoB-00042Q-Sh by authid <merlins.org> with srv_auth_plain; Tue, 06 Jun 2023 09:41:40 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1q6ZkZ-00DENW-7Q; Tue, 06 Jun 2023 09:41:39 -0700
Date:   Tue, 6 Jun 2023 09:41:39 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        wqu@suse.com
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230606164139.GK105809@merlins.org>
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
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

On Tue, Jun 06, 2023 at 07:47:03AM +0300, Andrei Borzenkov wrote:
> > sauron:/mnt/btrfs_pool2# df -h .
> > Filesystem         Size  Used Avail Use% Mounted on
> > /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
> 
> Well, I have had it once, there were deleted but not freed subvolumes
> 
> https://lore.kernel.org/linux-btrfs/ecd46a18-1655-ec22-957b-de659af01bee@gmx.com/T/

This sounds like it could be the same, thanks.

I started with
sauron:/mnt/btrfs_pool2# btrfs subvolume sync `pwd`

Unfortunately it's been stuck overnight.

Looks like I may have to reboot first (not ideal either)

Qu, any thing I should capture before reboot? Running 6.2.8 rigt now.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
