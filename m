Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8E2C6922
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 17:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgK0QJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0QJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 11:09:21 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC753C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 08:09:21 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kigJV-00051B-Er; Fri, 27 Nov 2020 16:09:37 +0000
Date:   Fri, 27 Nov 2020 16:09:37 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Zener <zener78@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs metadata mirroring
Message-ID: <20201127160937.GF1908@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Zener <zener78@gmail.com>, linux-btrfs@vger.kernel.org
References: <96b1b2e0-40d6-dfa4-25bf-dda02732f30a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b1b2e0-40d6-dfa4-25bf-dda02732f30a@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 27, 2020 at 04:11:19PM +0100, Zener wrote:
> Hi, I have a disk with btrfs but now I'd like enable just metadata mirroring
> to understand if some error occurs.
> Do I need another disk / partition / volume dedicated?
> How to do?
> Is it safe now or do I risk to loss my formely data?

   It's quite possible that you already have it.

   If you look at the output of "btrfs fi usage -T /mountpoint",
you'll see the RAID level for your metadata listed. If it's "DUP",
then you have two copies of each metadata block duplicated --
effectively running "RAID-1" for your metadata, but on a single
device.

   If it says "single", then you've only got one copy of your
metadata. You can convert it to DUP with a balance conversion:

# btrfs balance start -mconvert=dup,soft /mountpoint

   You may need to run this more than once. Sometimes the conversion
process manages to allocate (and then skip over) a new metadata chunk
as single. Check with "btrfs fi usage -T /mountpoint" after running
the first time, and see if there's any single metadata allocation
left. If there is, run the command again.

   Hugo.

-- 
Hugo Mills             | Anyone who says their system is completely secure
hugo@... carfax.org.uk | understands neither systems nor security.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Bruce Schneier
