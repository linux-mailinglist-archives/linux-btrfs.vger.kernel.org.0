Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B547451D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhLNOcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhLNOb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:31:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F1CC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:31:57 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m25so18436294qtq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bloqDIurAzwWlCDQrCfYHO1hcSlaFEjNEVUo5WA7Qtg=;
        b=QvfbRGQGbmnYF8/a5MzvFUoTTyMvIr6B0WIMstOXKwBWDrcI/hw06LM1Cg9uAvuzNK
         bw/LFhmG9eq/nkDOmUp2iahk3X0y+wJbKKG50GQElju6oLOWu36CSS03ZCSSI1qNyt/6
         rjZTdH5ffsdsGpgP/SwtmUC64zu8P8ppLcZg6qcPiLi7C56hkycjiCIbvFhwmKRFeGsH
         +NyeK6PpR7L0yWenF6R//0EBFWNWJWU1E8YlWIQ3ibGsWwhNbnYbsRtVwyW+CwFyxtRk
         kJZZbcw+s27w8u6+bywfpOgqplFiRBnexnGZNpVVnRuJeufxJ/E6qecSUx7T7m4Yd0Gm
         wQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bloqDIurAzwWlCDQrCfYHO1hcSlaFEjNEVUo5WA7Qtg=;
        b=JPdtlujpApIjNRV3A+RPL6EaByUnaKEcKbJLUf03pJwx18AhFn9rvrZu97wz7vcutE
         Fk+wGNjsao2nA87bzzBMvUtNGmrpHfffaD6K5tIPBseOX7QYX4fZBwp4JOR2rwAQHrFD
         a9xgeX3sqtoVcgIemS1COANh80yK5yi7X5MQaGGsUJ6Vgl99BquP/ji6a4YcSzOctSAW
         VRO4KqS12ft4UQKoSQS4Lxm4scfJ+4sLrCw5sO43MjY8dpDb3jnDs89Mg7mpzxlxkyDQ
         CQyZ/fWobma0xWSglkItPuNS/ZkESAc6Kv+aub0fTuEweN5FOPRfdvHRW6nsq3rp5lmC
         2Kzg==
X-Gm-Message-State: AOAM532lOYAuzy87MXUD5j0LYyDl/GqUgy+SvRCgXYZyQZJ39Dr7v465
        QpR9DisAdaxKVmruEUBFUzh5qg==
X-Google-Smtp-Source: ABdhPJyR+JiNQYwJWDUCxussHwrsayrPpTIy4Q8rIRPkB/xSrMSoHnkuuW1adgVWCWs8cbL+6WXDQA==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr6136576qtq.664.1639492316676;
        Tue, 14 Dec 2021 06:31:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u11sm42918qtw.29.2021.12.14.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:31:54 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:31:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <Ybiq2YeAjjGNnd3g@localhost.localdomain>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbfN8gXHsZ6KZuil@hungrycats.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 05:49:22PM -0500, Zygo Blaxell wrote:
> On Mon, Dec 13, 2021 at 04:15:14PM -0500, Josef Bacik wrote:
> > On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> > > Gentle ping :-)
> > > 
> > > Are there anyone of the mains developer interested in supporting this patch ?
> > > 
> > > I am open to improve it if required.
> > > 
> > 
> > Sorry I missed this go by.  I like the interface, we don't have a use for
> > device->type yet, so this fits nicely.
> > 
> > I don't see the btrfs-progs patches in my inbox, and these don't apply, so
> > you'll definitely need to refresh for a proper review, but looking at these
> > patches they seem sane enough, and I like the interface.  I'd like to hear
> > Zygo's opinion as well.
> 
> I've been running earlier versions with modifications since summer 2020,
> and this version mostly unmodified (rebase changes only) since it was
> posted.  It seems to work, even in corner cases like converting balances,
> replacing drives, and running out of space.  The "running out of space"
> experience is on btrfs is weird at the best of times, and these patches
> add some more new special cases, but it doesn't behave in ways that
> would surprise a sysadmin familiar with how btrfs chunk allocation works.
> 
> One major piece that's missing is adjusting the statvfs (aka df)
> available blocks field so that it doesn't include unallocated space on
> any metadata-only devices.  Right now all the unallocated space on
> metadata-only devices is counted as free even though it's impossible to
> put a data block there, so anything that is triggered automatically
> on "f_bavail < some_threshold" will be confused.
> 
> I don't think that piece has to block the rest of the patch series--if
> you're not using the feature, df gives the right number (or at least the
> same number it gave before), and if you are using the feature, you can
> subtract the unavailable data space until a later patch comes along to
> fix it.
> 
> I like
> 
> 	echo data_only > /sys/fs/btrfs/$uuid/devinfo/3/type
> 
> more than patching btrfs-progs so I can use
> 
> 	btrfs prop set /dev/... allocation_hint data_only
> 
> but I admit that might be because I'm weird.
> 

Ok this is good enough for me.  Refresh the series Goffredo and I'll review it,
get some xfstests as I described, and fix up btrfs-progs to show the preferences
via either btrfs filesystem show or some other mechanism since the df thing will
be confusing.  We'll assume if you're using this feature you are aware of the
space gotchas and then fix up bugs as they show up.  With the testing and user
feedback tho this looks good enough for me, I just want to make sure we have
tests and such in place before merging.  Thanks,

Josef
