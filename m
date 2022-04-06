Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68D4F6CE6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiDFVjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiDFVjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:39:04 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A550269
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 14:14:04 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48738 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1ncCyY-00073z-8v by authid <merlins.org> with srv_auth_plain; Wed, 06 Apr 2022 14:14:02 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1ncCyY-00FcgA-2U; Wed, 06 Apr 2022 14:14:02 -0700
Date:   Wed, 6 Apr 2022 14:14:02 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: figuring out why transient double raid failure caused a fair
 amount of btrfs corruption
Message-ID: <20220406211402.GG3307770@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk3t9U/XtQjFAcAE@hungrycats.org>
 <CAEzrpqdLm+Kwp9AWtPvxEBHXXm3wb_NhGLnhxsAsEXhufstPPw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Zygo, answer for you below)

On Wed, Apr 06, 2022 at 04:51:14PM -0400, Josef Bacik wrote:
> We can't do anything about the disks lying to us.  If a disk has a
> wonky FUA/FLUSH implementation then we're just sort of screwed.
> Unfortunately because our metadata moves around a lot we're waaaaay
> more susceptible to this failure case than ext4 or xfs, their metadata
> is relatively static they can put humpty dumpty back together again
> relatively simply.
 
Yeah, that's clearly been my experience. The average end user (which
kind of includes me), totally understands that last data written,
includig potentially directories, will get damaged, potentially beyond
repair, but losing the entire filesystem when 99.99%+ never got touched
by the last operations, is unexpected and undesired.
That said, yes, I understand that btrfs does things that are both cool
and complex, and they are less tolerant of corruption.

> 2. Put a lot more effort into disaster recovery.  What I've written
> for you is an idea I've had in my head for a while.  Some of this

I truly appreciate the time you've been spending with me on this.
In the end, I do have a backup, but I could not have one, or it could
fail when I'm reading back from it, so being able to recover the
filesystem to some workable state, is definitely a big plus.
Honestly I don't even really care if I lose 0.1%, 1%, or 5% of the data
(even if probably only <0.001% of the data got touched in the minute+
that btrfs was still apparently trying to use the filesystem after the
double failure), but a recovery that takes at most hours (for 24TB) and
not days, or never (never is a multiple day restore over the network for
me), will definitely be a great improvement.

> 3. Test these btrfs+dmcrypt+mdraid setups.  Every time I notice one of
> these catastrophic failures it generally involves btrfs+<something
> else>.  This is likely just because it's a timing thing, you put more
> layers you get a wider window in per-io races, you're more likely to
> be sad in the event of a failure.  However it would be good to make
> sure these layers are doing the correct thing themselves.
 
Totally agreed, I'm actually the worst case scenario, I have

disk hw write cache + swraid5 + bcache + dmcrypt + btrfs

that's clearly a lot of layers. This is now my 4 or 5th pretty
catastrophic btrfs failure over 2 arrays with those amount of layers
over the last 8 years, but the last one was 2-3 years ago, so there is
that :)
I think it's pretty clear that having all those layers is significantly
increasing my risk factor.

> We need to be better about this scenario, both in making sure we don't
> have bugs that contribute to the problem, but also that we have the
> tools necessary to recover when things go wrong.  Thanks,

agreed to both, thanks again for your time on this

On Wed, Apr 06, 2022 at 03:45:57PM -0400, Zygo Blaxell wrote:
> > shouldn't it go read only also?
> > I haven't found a setting to tell it to do that if it's not the default.
> 
> bcache in writethrough mode could leave cached blocks dirty as long as
> the SSD completes the write.  It should be reporting the write errors
> back to upper layers.
> Whether it actually does...I don't know, I haven't run that kind of
 
agreed.

> > That's true, but I've seen btfrs remount read only before, and it didn't
> > there. Shouldn't hard IO errors immediately cause btrfs to go read only?
> 
> No, only hard write IO errors on all metadata mirror drives, and cases
> where btrfs needs to CoW a page or read free space tree, and can't find
> an intact mirror.  Anything less is correctable (write failure on some
> mirrors) or can be retried (any read failure) if the raid profile has
> redundancy.

Fair enough. And as you said, my errors were probably already staged in
multiple layers and flushing before I got the first error reported back,
so even by then it mau have been too late to stop it.

> > I haven't heard that these drives have broken caching, but maybe they do?
> > Device Model:     ST6000VN0041-2EL11C
> > Serial Number:    ZA18TVFZ
> > LU WWN Device Id: 5 000c50 0a4d9b49c
> > Firmware Version: SC61
> > User Capacity:    6,001,175,126,016 bytes [6.00 TB]
> 
> I've heard of problems with SC60, but IIRC SC61 was supposed to be the

Well, there you go, just found out that I have a mix of SC60 and SC61.
Ok, I'll just turn off write caching on them all.

> The log excerpt I saw didn't show any write errors from btrfs, only
> from mdadm.  That suggests to me that the failure happened earlier when
> it was already too late to respond.  Also we can't rule out that bcache
> is doing something stupid.
 
Yeah, at this point I think the logs agree with that statement.
Also, I wasn't actually using that array, stuff doesn't really get
written to it unless I manually start copies.

Thanks for looking this over and your opinion/sanity check.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
