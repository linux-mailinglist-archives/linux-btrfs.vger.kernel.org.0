Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C86B7D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfGQIGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 04:06:01 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:50626 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQIGA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 04:06:00 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id D7E8A8F4B
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 10:05:57 +0200 (MEST)
Date:   Wed, 17 Jul 2019 10:05:57 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: how do I know a subvolume is a snapshot?
Message-ID: <20190717080557.GA3462@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2019-07-17 (09:45), Bernhard Kühnel wrote:
> Am 17.07.2019 um 01:24 schrieb Ulli Horlacher:
> 
> > How do I know that /mnt/tmp/ss is a snapshot?
> > I cannot see a snapshot identifier.
> 
> From the btrfs-subvolume man page:
> 
> >       A snapshot is a subvolume like any other, with given initial content. By default, snapshots are created
> >       read-write. File modifications in a snapshot do not affect the files in the original subvolume.

I know this, but my question was not "What is a snapshot".


> I believe the usual practice is to create snapshots with the -r flag and
> follow some naming convention (e.g. place them in a common .snapshots
> folder named by date), but you're free to switch between read-only and
> read-write mode for a snapshot at any time using the btrfs property command.

This is true also for my users and co-admins.
Though, I want to know which subvolume is a snapshot of what subvolume.

Non-toplevel subvolume snapshots have a Parent UUID - why not all?!
Or at least some kind of flag "I am a snapshot".


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
