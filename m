Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502D848B1B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiAKQOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:14:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiAKQOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:14:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 100541F3B8;
        Tue, 11 Jan 2022 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641917648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sAkJhQNIVyQWCSncblfHtjk+woZI4t0Hvpj1Xsych4=;
        b=x6jYTrG9I3dXK9F45bDYLOof25wOCjK7K2iU1MqK2PHBFtrvo7o0e37tu+BDYsbOpMilyV
        y37dwg+q6TVCclYdgj0J43wc6kEzzMX/4VDk7jFP9ECSYanfx7UZyvRVAKLue2qrpN0k2/
        iVOOyKTiYYKhpAjw9kCi9fkFbZKuOM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641917648;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sAkJhQNIVyQWCSncblfHtjk+woZI4t0Hvpj1Xsych4=;
        b=EKa7MFHyMAsvN7AIO1izYSSKWoBu2xY1TefvIr0MtfT563zxYP1we7xPpfXNB53erHiwAO
        IQ3UT7l2Qbj5qGBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E35F9A3B83;
        Tue, 11 Jan 2022 16:14:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2AFCDA7A9; Tue, 11 Jan 2022 17:13:34 +0100 (CET)
Date:   Tue, 11 Jan 2022 17:13:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Juan =?iso-8859-1?Q?Sim=F3n?= <decedion@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: 48 seconds to mount a BTRFS hard disk drive seems too long to me
Message-ID: <20220111161334.GS14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Juan =?iso-8859-1?Q?Sim=F3n?= <decedion@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
 <YdhzOhLar6TqZbbN@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdhzOhLar6TqZbbN@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 12:07:06PM -0500, Zygo Blaxell wrote:
> On Thu, Jan 06, 2022 at 04:48:21PM +0100, Juan Simón wrote:
> > Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
> > Arch Linux
> > Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
> > +0000 x86_64 GNU/Linux
> > btrfs-progs v5.15.1
> > 
> > $ btrfs fi df /multimedia
> > Data, single: total=10.89TiB, used=10.72TiB
> > System, DUP: total=8.00MiB, used=1.58MiB
> > Metadata, DUP: total=15.00GiB, used=13.19GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> > 
> > I have formatted it as BTRFS and the mounting options (fstab) are:
> > 
> > /multimedia     btrfs
> > rw,noatime,autodefrag,compress-force=zstd,nossd,space_cache=v2    0 0
> > 
> > The disk works fine, I have not detected any problems but every time I
> > reboot the system takes a long time due to the mounting of this drive
> > 
> > $ systemd-analyze blame
> > 48.575s multimedia.mount
> > ....
> > 
> > I find it too long to mount a drive, is this normal, is it because of
> > one of the mounting options, or because of the size of the hard drive?
> 
> Worst-case, you'll need about one second of mounting time for every ~180
> block groups on a spinning disk, which works out to about 89 seconds on
> that drive when it's full.
> 
> It's a known issue, but it will require a disk format change to fix, so
> it will likely be rolled into a larger change set like extent tree v2.

Yeah, there was even a suggestion to add yet another tree to store the
block group information with better locality, this will be part of the
extent tree v2 update. Otherwise we can try to do readahead, there is
something already done I can't find right now.
