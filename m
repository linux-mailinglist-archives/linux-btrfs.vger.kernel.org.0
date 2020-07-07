Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F1217511
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 19:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGRZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 13:25:24 -0400
Received: from magic.merlins.org ([209.81.13.136]:42812 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGRZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 13:25:24 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:60956 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1jsrLP-0007Za-Oz by authid <merlins.org> with srv_auth_plain; Tue, 07 Jul 2020 10:25:23 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1jsrLP-0008Vo-FN; Tue, 07 Jul 2020 10:25:23 -0700
Date:   Tue, 7 Jul 2020 10:25:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption: parent transid
 verify failed + open_ctree failed
Message-ID: <20200707172523.GQ30660@merlins.org>
References: <20200707035530.GP30660@merlins.org>
 <01af6816-b0ee-20fa-5e00-0bfeef60cd88@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01af6816-b0ee-20fa-5e00-0bfeef60cd88@toxicpanda.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 10:31:32AM -0400, Josef Bacik wrote:
> > Soon after, the copy failed:
> > [ 2575.931316] BTRFS info (device dm-0): use zlib compression, level 3
> > [ 2575.931329] BTRFS info (device dm-0): disk space caching is enabled
> > [ 2575.931343] BTRFS info (device dm-0): has skinny extents
> > [ 2577.286749] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> 
> You have a corrupt counter here at mount time, does your logs go back far
> enough to see where those came in?  Thanks,

I copied all the logs in the original Email.

Here it is all in one swoop:
https://pastebin.com/GURufP8w

The devices going down and back up is normal, my backup script saw the
backup was over (although in that case that's because it failed) and
automatically unmounted the filesystem and turned off the drives.

I'm not sure how my FS got so corrupted, it's been a while since I've
seen damage that bad, especially pretty unexplained like this.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
