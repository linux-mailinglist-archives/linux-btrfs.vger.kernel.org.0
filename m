Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A641DDB48
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 01:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgEUXsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 May 2020 19:48:41 -0400
Received: from bezitopo.org ([45.55.162.231]:57384 "EHLO marozi.bezitopo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgEUXsk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 19:48:40 -0400
Received: from bezitopo.org (unknown [IPv6:2001:5b0:211f:ee48:4e72:b9ff:fe7b:8dbf])
        by marozi.bezitopo.org (Postfix) with ESMTPSA id C95325FB5F
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 19:48:38 -0400 (EDT)
Received: from puma.localnet (localhost [127.0.0.1])
        by bezitopo.org (Postfix) with ESMTP id BBC69117F7
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 19:48:26 -0400 (EDT)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Trying to mount hangs
Date:   Thu, 21 May 2020 19:48:26 -0400
Message-ID: <7541432.rVhWMRgfCE@puma>
In-Reply-To: <87436f2d-40d2-5fa1-cdee-4cc4f63e68c9@gmx.com>
References: <2549429.Qys7a5ZjRC@puma> <87436f2d-40d2-5fa1-cdee-4cc4f63e68c9@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thursday, May 21, 2020 3:56:01 AM EDT Qu Wenruo wrote:
> That doesn't sound good. But according to your btrfs check result, your
> memory doesn't look good.
> There seems to be a memory bit flip.
> 
> A full memtest is highly recommended.
> 
> And since your hardware is not functioning reliable, everything can go
> wrong.

There was a thunderstorm. The power blinked twice within a few minutes. That 
could have easily caused the bit flip.

> > UUID: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
> > [1/7] checking root items
> > [2/7] checking extents
> > incorrect local backref count on 4186230784 root 257 owner 99013 offset
> > 5033684992 found 1 wanted 2097153 back 0x5589817e5ef0
> 
> Here, the 2097153 is 0x200001, it's an obvious bitflip.
> 
> And since it's in extent tree, even write time tree checker can't detect it.
> 
> But that problem is not a big thing, btrfs check --repair can fix it.
> 
> Still, memtest first, only process to try repair after your memory is fixed.

"btrfs check" gave me a "device busy" error. (When I booted the M.2, this was 
caused by the hung mount process, but it happened even when I booted the flash 
drive. I don't know why.) I couldn't repair it. I had to get a new drive and 
recover the files to the new drive.

Trying to mount the corrupt filesystem consistently hangs. That indicates a bug 
in mount. How can I send you the corrupt filesystem so that you can debug 
mount?

Pierre
-- 
The Black Garden on the Mountain is not on the Black Mountain.



