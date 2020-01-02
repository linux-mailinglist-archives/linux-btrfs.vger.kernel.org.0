Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18F812E8EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgABQuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:50:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33187 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgABQuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:50:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so23951689qkc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAxtVVvm21EywGn8Z3Yh4ucdp0xH/2tCZQVMz1IV/cY=;
        b=eUufuDiHLwJy9MfVSTTNdkE8yl+sdVyq+0Y8C6GBiv+MH2N64gUKWPmzVpPWpIQ5MW
         fNyoCrD/NCrpLicDoEilwzAlekr+Hx/BJkw0bFPNN9WTHnvFUnhIXGhmHxpYSIIxWLFr
         jjy/mVSHEjAWe7KRxC00mBhVCpfEDRGUwoScWAzCZyWBPyGLy/UEKfHa1knJuhjgO8w2
         rNfDczzH3C/9CjiYV3J1XlkRLzODtYx2+nOf35obidiBMlQ5cxsZSA1ranL3bS/3U2Iz
         XWGYVIBonuKBbfbhwOurVdbZJ2Eb05fL31CacN8XXG62flgx74ix4K6bAioa5s0wzxGA
         Sapw==
X-Gm-Message-State: APjAAAV2j0KWRfdbz88cKPAgz6RkFQAz6WNZ6BppkZxP3TfT0+uco1Vs
        TNzGeoI4uxOIpXdCM/D7zJo=
X-Google-Smtp-Source: APXvYqz3dcDj5OPh7rzUPEhkFwc7/JoQJcYOP1Qk/7nZawPDodeMauNPS1qMNFdsdok+oUSnWvE+qA==
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr68949664qkc.2.1577983806754;
        Thu, 02 Jan 2020 08:50:06 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id l19sm16996297qtq.48.2020.01.02.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:50:06 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:50:04 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/22] btrfs: make max async discard size tunable
Message-ID: <20200102165004.GD86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <c3e6fa9d3391104c22c3e474af16a86d439a7af7.1576195673.git.dennis@kernel.org>
 <20191230180503.GA3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230180503.GA3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 07:05:03PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:25PM -0800, Dennis Zhou wrote:
> > Expose max_discard_size as a tunable via sysfs.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h            |  1 +
> >  fs/btrfs/discard.c          |  1 +
> >  fs/btrfs/free-space-cache.c | 19 ++++++++++++-------
> >  fs/btrfs/sysfs.c            | 31 +++++++++++++++++++++++++++++++
> >  4 files changed, 45 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 1b2dae5962de..bf93ddbc773f 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -470,6 +470,7 @@ struct btrfs_discard_ctl {
> >  	u64 prev_discard;
> >  	atomic_t discardable_extents;
> >  	atomic64_t discardable_bytes;
> > +	u64 max_discard_size;
> >  	u32 delay;
> >  	u32 iops_limit;
> >  	u64 bps_limit;
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 085f36808e7f..dd5143f0283f 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -536,6 +536,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
> >  	discard_ctl->prev_discard = 0;
> >  	atomic_set(&discard_ctl->discardable_extents, 0);
> >  	atomic64_set(&discard_ctl->discardable_bytes, 0);
> > +	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_MAX_SIZE;
> 
> BTRFS_ASYNC_DISCARD_MAX_SIZE won't be the upper limit anymore but a
> default so it should be named as such.

Renamed to BTRFS_ASYNC_DISCARD_MAX_SIZE_DFL.
