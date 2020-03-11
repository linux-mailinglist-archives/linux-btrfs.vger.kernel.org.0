Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75D1822F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgCKT7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 15:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387433AbgCKT7g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 15:59:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF015AEC5;
        Wed, 11 Mar 2020 19:59:34 +0000 (UTC)
Date:   Wed, 11 Mar 2020 20:59:34 +0100
Message-ID: <s5hzhcm64t5.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     dsterba@suse.cz
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Use scnprintf() for avoiding potential buffer overflow
In-Reply-To: <20200311191023.GH12659@twin.jikos.cz>
References: <20200311093323.24955-1-tiwai@suse.de>
        <20200311191023.GH12659@twin.jikos.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 11 Mar 2020 20:10:23 +0100,
David Sterba wrote:
> 
> On Wed, Mar 11, 2020 at 10:33:23AM +0100, Takashi Iwai wrote:
> > Since snprintf() returns the would-be-output size instead of the
> > actual output size, the succeeding calls may go beyond the given
> > buffer limit.  Fix it by replacing with scnprintf().
> 
> Is this a mechanical conversion or is there actually a potential
> overflow in the code?

It's rather a result of pattern matching.

> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  fs/btrfs/sysfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 93cf76118a04..d3dc069789a5 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -310,12 +310,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
> >  		 * This "trick" only works as long as 'enum btrfs_csum_type' has
> >  		 * no holes in it
> >  		 */
> > -		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> > +		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> >  				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
> 
> Loop count is a constant, each iteration filling with two %s of constant
> length, buffer size is PAGE_SIZE.

Yes, it's likely OK with the current code, but then snprintf() usage
is utterly bogus.

> >  	}
> >  
> > -	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> > +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
> >  	return ret;
> >  }
> >  BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
> > @@ -992,7 +992,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
> >  			continue;
> >  
> >  		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
> > -		len += snprintf(str + len, bufsize - len, "%s%s",
> > +		len += scnprintf(str + len, bufsize - len, "%s%s",
> >  				len ? "," : "", name);
> 
> Similar, compile-time constant for number of loops, filling with strings
> of bounded length.
> 
> If the patch is a precaution, then ok, but I don't see what it's trying
> to fix.

Take it rather a precaution, yes.

The problem is that the usage like

	pos += snprintf(buf + pos, len - pos, ...);

to append strings is already wrong per design unless it has a return
value check right after each call.  It might work if the string really
doesn't go over the limit; but then it makes no sense to use
snprintf(), you can use the plain sprintf().


thanks,

Takashi
