Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43618DA18
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTV1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 17:27:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:38830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTV1F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 17:27:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F7F5B196;
        Fri, 20 Mar 2020 21:27:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D974FDA728; Fri, 20 Mar 2020 22:26:33 +0100 (CET)
Date:   Fri, 20 Mar 2020 22:26:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200320212633.GJ12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Takashi Iwai <tiwai@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200311093323.24955-1-tiwai@suse.de>
 <20200311191023.GH12659@twin.jikos.cz>
 <s5hzhcm64t5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhcm64t5.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 08:59:34PM +0100, Takashi Iwai wrote:
> On Wed, 11 Mar 2020 20:10:23 +0100,
> David Sterba wrote:
> > 
> > On Wed, Mar 11, 2020 at 10:33:23AM +0100, Takashi Iwai wrote:
> > > Since snprintf() returns the would-be-output size instead of the
> > > actual output size, the succeeding calls may go beyond the given
> > > buffer limit.  Fix it by replacing with scnprintf().
> > 
> > Is this a mechanical conversion or is there actually a potential
> > overflow in the code?
> 
> It's rather a result of pattern matching.
> 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  fs/btrfs/sysfs.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > > index 93cf76118a04..d3dc069789a5 100644
> > > --- a/fs/btrfs/sysfs.c
> > > +++ b/fs/btrfs/sysfs.c
> > > @@ -310,12 +310,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
> > >  		 * This "trick" only works as long as 'enum btrfs_csum_type' has
> > >  		 * no holes in it
> > >  		 */
> > > -		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> > > +		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> > >  				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
> > 
> > Loop count is a constant, each iteration filling with two %s of constant
> > length, buffer size is PAGE_SIZE.
> 
> Yes, it's likely OK with the current code, but then snprintf() usage
> is utterly bogus.

I'm not sure what exactly are you calling bogus.  We want to keep the
code maintainable, the snprintf could be replaced by

	strcpy(buf, "crc32c xxhash64 sha256 blake2b\n");

yes, but now we have 2 places with hardcoded values. What I consided a
good practice is to have one definition like

	static const struct btrfs_csums {
		u16             size;
		const char      *name;
		const char      *driver;
	} btrfs_csums[] = {
		[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
		[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
		[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
		[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
					     .driver = "blake2b-256" },
	};

and the extract what's needed.

> > > @@ -992,7 +992,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
> > >  			continue;
> > >  
> > >  		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
> > > -		len += snprintf(str + len, bufsize - len, "%s%s",
> > > +		len += scnprintf(str + len, bufsize - len, "%s%s",
> > >  				len ? "," : "", name);
> > 
> > Similar, compile-time constant for number of loops, filling with strings
> > of bounded length.
> > 
> > If the patch is a precaution, then ok, but I don't see what it's trying
> > to fix.
> 
> Take it rather a precaution, yes.
> 
> The problem is that the usage like
> 
> 	pos += snprintf(buf + pos, len - pos, ...);
> 
> to append strings is already wrong per design unless it has a return
> value check right after each call.  It might work if the string really
> doesn't go over the limit; but then it makes no sense to use
> snprintf(), you can use the plain sprintf().

I'm afraid that when we use snprintf, somebody comes that it's unsafe
because that's what some code scanning tool said that, without looking
at the context of use. The code can simply use strcat and be fine, but
that I don't want to encourage to be used, when code is copied to
similar functions.

I'm fine with scnprintf as this should make everybody happy, while
there would be effectively no change, just that the changelog should be
worded accordingly.
