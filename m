Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5820610B6AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 20:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfK0T0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 14:26:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:36852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbfK0T0O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 14:26:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADA47ABE8;
        Wed, 27 Nov 2019 19:26:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9C1E1DA733; Wed, 27 Nov 2019 20:26:10 +0100 (CET)
Date:   Wed, 27 Nov 2019 20:26:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Alberto Bursi <bobafetthotmail@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
Message-ID: <20191127192610.GB2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Alberto Bursi <bobafetthotmail@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
 <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
 <f8602f1e-7401-dfd7-0274-48609e3804b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8602f1e-7401-dfd7-0274-48609e3804b1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 01:18:21PM +0800, Alberto Bursi wrote:
> >> Thanks. This is going to change the behaviour with a missing device, so
> >> the question is if we should make this configurable first and then
> >> switch the default.
> > Configurable then switch makes sense for most cases, but for this
> > degraded chunk case, IIRC the new behavior is superior in all cases.
> >
> > For 2 devices RAID1 with one missing device (the main concern), old
> > behavior will create SINGLE/DUP chunk, which has no tolerance for extra
> > missing devices.
> >
> > The new behavior will create degraded RAID1, which still lacks tolerance
> > for extra missing devices.
> >
> > The difference is, for degraded chunk, if we have the device back, and
> > do proper scrub, then we're completely back to proper RAID1.
> > No need to do extra balance/convert, only scrub is needed.
> >
> > So the new behavior is kinda of a super set of old behavior, using the
> > new behavior by default should not cause extra concern.
> 
> I think most users will see this as a bug fix, as the current behavior 
> of creating
> 
> SINGLE chunks is very annoying and can cause confusion as it is NOT an
> 
> expected behavior for a classic (mdadm or hardware) degraded RAID array.

Thanks for the feedback, I agree with that. It's good to have a
confirmation from somebody outside of developer group.
