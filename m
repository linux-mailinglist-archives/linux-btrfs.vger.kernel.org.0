Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ABA9EC53
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfH0PWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 11:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbfH0PWY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:22:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EED77AE65;
        Tue, 27 Aug 2019 15:22:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC33EDA809; Tue, 27 Aug 2019 17:22:45 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:22:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs-progs: resize: more sensible error messages
 for bad sizes
Message-ID: <20190827152245.GK2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-4-jeffm@suse.com>
 <ed2cbb17-8b93-9d29-0405-a485e8d36a7a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2cbb17-8b93-9d29-0405-a485e8d36a7a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 14, 2019 at 09:53:33AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/14 上午9:04, Jeff Mahoney wrote:
> > If a user attempts to resize a file system to a size under 256MiB,
> > it will be rejected with EINVAL and get then unhelpful error message
> > "ERROR: unable to resize '/path': Invalid argument."
> > 
> > This commit performs that check before issuing the ioctl to report
> > a more sensible error message.   We also do overflow/underflow
> > checking when -/+ size is used and report those errors as well.
> > 
> > Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> > ---
> >  cmds/filesystem.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  common/utils.c    |  2 +-
> >  common/utils.h    |  2 +-
> >  3 files changed, 43 insertions(+), 2 deletions(-)
> > 
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index 4f22089a..e3415126 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -34,10 +34,12 @@
> >  #include "kerncompat.h"
> >  #include "ctree.h"
> >  #include "common/utils.h"
> > +#include "common/device-utils.h"
> >  #include "volumes.h"
> >  #include "cmds/commands.h"
> >  #include "cmds/filesystem-usage.h"
> >  #include "kernel-lib/list_sort.h"
> > +#include "kernel-lib/overflow.h"
> >  #include "disk-io.h"
> >  #include "common/help.h"
> >  #include "common/fsfeatures.h"
> > @@ -1062,6 +1064,41 @@ next:
> >  }
> >  static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
> >  
> > +static int check_resize_size(const char *path, const char *amount)
> > +{
> > +	int mod = 0;
> > +	u64 oldsize = 0, size, newsize;
> > +
> > +	if (*amount == '-')
> > +		mod = -1;
> > +	else if (*amount == '+')
> > +		mod = 1;
> > +
> > +	if (mod) {
> > +		amount++;
> > +		oldsize = disk_size(path);
> > +		if (oldsize == 0)
> > +			return -1;
> > +	}
> > +
> > +	size = parse_size(amount);
> > +
> > +	if (mod == -1 && check_sub_overflow(oldsize, size, &newsize)) {
> > +		error("can't resize to negative size");
> > +		return -1;
> > +	} else if (mod == 1 && check_add_overflow(oldsize, size, &newsize)) {
> > +		error("can't resize to larger than 16EiB");
> > +		return -1;
> > +	} else
> > +		newsize = size;
> > +
> > +	if (newsize < SZ_256M) {
> > +		error("can't resize to size smaller than 256MiB");
> > +		return -1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static const char * const cmd_filesystem_resize_usage[] = {
> >  	"btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>",
> >  	"Resize a filesystem",
> > @@ -1110,6 +1147,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> >  	if (fd < 0)
> >  		return 1;
> >  
> > +	res = check_resize_size(path, amount);
> > +	if (res < 0)
> > +		return 1;
> > +
> >  	printf("Resize '%s' of '%s'\n", path, amount);
> >  	memset(&args, 0, sizeof(args));
> >  	strncpy_null(args.name, amount);
> > diff --git a/common/utils.c b/common/utils.c
> > index ad938409..f2a10ccc 100644
> > --- a/common/utils.c
> > +++ b/common/utils.c
> > @@ -638,7 +638,7 @@ static int fls64(u64 x)
> >  	return 64 - i;
> >  }
> >  
> > -u64 parse_size(char *s)
> > +u64 parse_size(const char *s)
> 
> Although a good change, not sure if David will ask for an explict patch
> for that.

I've split that from the patch.

> Despite that, looks good.

Well, no. The resize specifier is more complex and has eg. formats like
1:+1G, max, 2:-2G, 3:max. Moreover the relative change must not be
compared to the 256M limit, 'resize -128M' fails while it should not for
a filesystem that's eg. 2G.
