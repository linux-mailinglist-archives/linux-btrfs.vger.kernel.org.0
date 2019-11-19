Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39301026F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKSOi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 09:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfKSOi5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 09:38:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 471E4B240;
        Tue, 19 Nov 2019 14:38:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89D1FDA783; Tue, 19 Nov 2019 15:38:57 +0100 (CET)
Date:   Tue, 19 Nov 2019 15:38:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: How to replace a missing device with a smaller one
Message-ID: <20191119143857.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
 <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 03:08:00PM +0800, Qu Wenruo wrote:
> On 2019/11/18 下午1:32, Qu Wenruo wrote:
> > On 2019/11/18 上午10:09, Nathan Dehnel wrote:
> >> I have a 10-disk raid10 with a missing device I'm trying to replace. I
> >> get this error when doing it though:
> >>
> >> btrfs replace start 1 /dev/bcache0 /mnt
> >> ERROR: target device smaller than source device (required 1000203091968 bytes)
> >>
> >> I see that people recommend resizing a disk before replacing it, which
> >> isn't an option for me because it's gone.
> > 
> > Oh, that's indeed a problem.
> > 
> > We should allow to change missing device's size.
> 
> I have CCed you with a patch to allow user to *shrink* the missing device.
> 
> You can also get the patch from patchwork:
> https://patchwork.kernel.org/patch/11249009/
> 
> Please give a try, since the device size is pretty small, I believe with
> that patch, we can go quick shrink, that means "btrfs fi resize" command
> should return immediately.

So it can be recteated eg. on loop devices, where some of them are
slightly smaller, then go missing and replace is started, right?
