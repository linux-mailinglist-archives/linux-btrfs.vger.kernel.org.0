Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5197FE260
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKOQLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 11:11:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:58246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfKOQLq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 11:11:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CD2EC03D;
        Fri, 15 Nov 2019 16:11:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 635BCDA7D3; Fri, 15 Nov 2019 17:11:47 +0100 (CET)
Date:   Fri, 15 Nov 2019 17:11:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 00/18] btrfs-progs: global verbose and quiet option
Message-ID: <20191115161147.GY3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 04, 2019 at 02:32:58PM +0800, Anand Jain wrote:
> v1->v1.1:
>  . Fix typo in HELPINFO_INSERT_QUIET.
>  . Remove #include <stdbool.h> where its no more required.
>    (was needed when %bconf.verbose was declared as bool).
>  . Use pr_verbose(-1,..) instead of all conditions printf()
>  . Use pr_verbose(1,..) instead of pr_verbose(true,..)
> 
> verbosity sample code as in v1.1

Please user integer numbers for patch revisions, no need to mark patches
that haven't changed, the overall summary of changes can mention what
changed where if needed.

> pr_verbose()
> ------------
> /*
>  * level -1: prints message unless bconf.verbose == 0;
>  * level  0: quiet

Are we ever going to call the function with level == 0?

>  * level >0: prints message only if <= bconf.verbose
>  */
> void pr_verbose(int level, const char *fmt, ...)
> {
>         va_list args;
> 
>         if (level == 0 || bconf.verbose == 0)
>                 return;
> 
>         if (level > bconf.verbose)
>                 return;
> 
>         va_start(args, fmt);
>         vfprintf(stdout, fmt, args);
>         va_end(args);
> }
> 
> 1.
>  There are certain sub-commands which does not have any verbose output
>  or quiet output. However if the global options were used with those
>  sub-commands then the command shall not report any usage error. Or
>  my question is should it error out.? For example:
>   (with the patch) btrfs --verbose device ready /dev/sdb
>  actually there isn't any verbose output but we won't error out.
>  Similarly,
>   (without the patch) btrfs send -vvvvv will not show usage error
>   as well.
>   So I believe this is fine. IMO.

Yes this is fine.

> 2.
>   There is slight difference in output when global options are used
>   as compared to the output using the same sequence of options at the
>   sub-command level. For example:
> 
>    btrfs send -v -q -v  is-equal-to  btrfs send
>    But same sequence in the global option
>    btrfs -v -q -v send is-not-equal-to btrfs send
>    but is-equal-to btrfs -v send or btrfs send -v.
>    (similarly applies to receive as well).
> 
>   which IMO is fair expectation as -v is ending last.

Agreed, hopefully the wild combinations of -v and -q are not too common.

The patchset looks good, though it needs the small fixups like the
global header or the helper macros, the core of the changes is there.
That should be good for 5.4.

The first version merged should bring the support for global verbosity
options, then we can gradually convert all fprintf/printf to the helpers
and add new printfs with higher verbosity levels.
