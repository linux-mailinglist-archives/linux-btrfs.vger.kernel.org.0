Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EF41B4034
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgDVKoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 06:44:18 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:60162 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbgDVKoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 06:44:09 -0400
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jRCrL-0002aS-Ml; Wed, 22 Apr 2020 11:44:03 +0100
Date:   Wed, 22 Apr 2020 11:44:03 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: RAID 1 | Newbie Question
Message-ID: <20200422104403.GE32577@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>,
        linux-btrfs@vger.kernel.org
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 22, 2020 at 11:58:41AM +0200, Stefanie Leisestreichler wrote:
> Hi.
> I might be a first time user with btrfs for a new system I will set up.
> 
> Just want to make sure: As I read the docs, the note about RAID 1 and that
> there will be no redundant data is true only, if the RAID, which is
> possible, is set up to use only 1 physical device, right?

   You can't set up btrfs RAID-1 to use only one device. It's only
possible to end up like that if you set up a 2-device RAID-1 and then
unplug a device and mount it in degraded mode.

> If RAID 1 using btrfs is defined to use two seperate disk, say /dev/sda2 and
> /dev/sdb2, I will have the same redundancy like using md. Is this correct?

   You'll have two copies, so one device redundancy, regardless of the
number of devices. Traditional RAID-1 will use as many copies as
devices; btrfs RAID-1 is two copies. (Although there are 3-copy and
4-copy variations in the latest kernels).

   Hugo.

-- 
Hugo Mills             | You can play with your friends' privates, but you
hugo@... carfax.org.uk | can't play with your friends' childrens' privates.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                       C++ coding rule
