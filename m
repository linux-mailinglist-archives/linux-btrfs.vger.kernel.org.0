Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744ECC3EB5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfJARgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:36:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfJARgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:36:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2CAEAFE1;
        Tue,  1 Oct 2019 17:36:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A460DA88C; Tue,  1 Oct 2019 19:36:52 +0200 (CEST)
Date:   Tue, 1 Oct 2019 19:36:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix balance convert to single on 32-bit host CPUs
Message-ID: <20191001173651.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190912235507.3DE794232AF@james.kirk.hungrycats.org>
 <20190923151403.GD2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923151403.GD2751@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 05:14:04PM +0200, David Sterba wrote:
> On Thu, Sep 12, 2019 at 07:55:01PM -0400, Zygo Blaxell wrote:
> > Currently, the command:
> > 
> > 	btrfs balance start -dconvert=single,soft .
> > 
> > on a Raspberry Pi produces the following kernel message:
> > 
> > 	BTRFS error (device mmcblk0p2): balance: invalid convert data profile single
> > 
> > This fails because we use is_power_of_2(unsigned long) to validate
> > the new data profile, the constant for 'single' profile uses bit 48,
> > and there are only 32 bits in a long on ARM.
> > 
> > Fix by open-coding the check using u64 variables.
> > 
> > Tested by completing the original balance command on several Raspberry
> > Pis.
> > 
> > Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> > ---
> >  fs/btrfs/volumes.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 88a323a453d8..252c6049c6b7 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3906,7 +3906,11 @@ static int alloc_profile_is_valid(u64 flags, int extended)
> >  		return !extended; /* "0" is valid for usual profiles */
> >  
> >  	/* true if exactly one bit set */
> > -	return is_power_of_2(flags);
> > +	/*
> > +	 * Don't use is_power_of_2(unsigned long) because it won't work
> > +	 * for the single profile (1ULL << 48) on 32-bit CPUs.
> > +	 */
> > +	return flags != 0 && (flags & (flags - 1)) == 0;
> 
> I'd rather not open code it again. Based on the discussion, we need a
> separate helper that takes u64 and possibly has the "value has exactly
> one bit set" semantics from the beginnin. We now have a file for such
> helpers (fs/btrfs/misc.h).
> 
> There would a few more users of the new helper (now done using the
> is_power_of_2 helper), that would improve readability.

I'll apply the patch as-is so it can go to stable and do the helper and
other cleanups myself.
