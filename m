Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E631BE64B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgD2Sdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Sdr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 14:33:47 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CEFC03C1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 11:33:47 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1jTrWi-0004Bn-I5; Wed, 29 Apr 2020 19:33:44 +0100
Date:   Wed, 29 Apr 2020 19:33:44 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: nodatacow questions
Message-ID: <20200429183344.GD30508@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>,
        linux-btrfs@vger.kernel.org
References: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 08:30:33PM +0200, Stefanie Leisestreichler wrote:
> Hi.
> From the chattr man page:
> A file with the 'C' attribute set will not be subject to copy-on-write
> updates. This flag is only supported on file systems which perform
> copy-on-write. (Note: For btrfs, the 'C' flag should be set on new or empty
> files. If it is set on a file which already has data blocks, it is undefined
> when the blocks assigned to the file will be fully stable. If the 'C' flag
> is set on a directory, it will have no effect on the directory, but new
> files created in that directory will have the No_COW attribute set.)
> 
> Question 1)
> If /var/lib/mysql is a own subvolume and chattr +C /var/lib/mysql is set and
> mysql is configured to use one directory for every database, will nodatacow
> apply for a new dir which is created when a new db is created? Just asking,
> because the last sentence of the man above which states "...new files
> created in that directory...". Is a dir a file in the context of chattr?

   Yes.

> Question 2)
> I guess CoW will still happen, if I hold a snapshot of the subvolume which
> will be mounted to /var/lib/mysql. Is this correct?

   Correct, but only once. Subsequent writes to the same region will
revert to nodatacow.

> Question 3)
> How to solve this and avoid defragmentation if my assumption in 2) is
> correct?

   Don't use snapshots, or don't use nodatacow.

   Set autodefrag and don't use nodatacow would be my recommendation.

   Hugo.

-- 
Hugo Mills             | 2 + 2 = 5, for sufficiently large values of 2.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
