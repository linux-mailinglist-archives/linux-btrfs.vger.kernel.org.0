Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD851B0EFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgDTO5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 10:57:06 -0400
Received: from magic.merlins.org ([209.81.13.136]:35246 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgDTO5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 10:57:06 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jQXr2-000773-08 by authid <merlin>; Mon, 20 Apr 2020 07:57:00 -0700
Date:   Mon, 20 Apr 2020 07:56:59 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Message-ID: <20200420145659.GA26389@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org>
 <20200414003854.GA6639@merlins.org>
 <07166dd6-4554-a545-9774-a622890095a7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07166dd6-4554-a545-9774-a622890095a7@oracle.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 07:10:24PM +0800, Anand Jain wrote:
> The steps below are they in the chronological order?
 
That is my recollection, yes.

>  Before and after --forget command
>     btrfs fi show -m
>  could have told us what devices are still mounted.
 
Oh, I didn't know about this. If/when it happens next, I'll 
run this to show btrfs' understanding of what's mounted instead of
the kernel's understanding (/proc/self/mounts)

> I will send a boilerplate code to dump device list from the kernel it will
> help to debug. As of now this boilderplate code which I have been using is
> too localized needs a lot of cleanups, will take sometime.

Sounds good.
 
Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
