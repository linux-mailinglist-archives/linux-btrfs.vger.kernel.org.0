Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F92AA661
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 16:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKGPoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 10:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKGPoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Nov 2020 10:44:05 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97AC0613CF
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Nov 2020 07:44:05 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kbQO1-0007eY-Kl; Sat, 07 Nov 2020 15:44:17 +0000
Date:   Sat, 7 Nov 2020 15:44:17 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Pete <pete@petezilla.co.uk>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Move from 5.9.3 kernel to 5.4.75?
Message-ID: <20201107154417.GP30996@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Pete <pete@petezilla.co.uk>, linux-btrfs@vger.kernel.org
References: <7d436bf1-80d2-a298-d124-e9385fb6ef42@petezilla.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d436bf1-80d2-a298-d124-e9385fb6ef42@petezilla.co.uk>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 07, 2020 at 03:12:59PM +0000, Pete wrote:
> Is there an impact for btrfs for moving from a 5.9.3 kernel to 5.4.75
> kernel?  I'm using raid1 or single (more than one file system), no 1c2
> or 1c3 etc, space_cache_v2 and zstd compression.  The reason is that I'm
> trying to see if this fixes another problem - but breaking my file
> system is a major concern.

   If it's going to fail, it'll fail safely. If there are features
used on the FS that the earlier kernel can't deal with, it'll spot
that there's incompat bits set and refuse to mount.

   You'll get back all the kernel bugs that didn't have fixes
backported, but that's all.

   Hugo.

-- 
Hugo Mills             | "There's a Martian war machine outside -- they want
hugo@... carfax.org.uk | to talk to you about a cure for the common cold."
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                           Stephen Franklin, Babylon 5
