Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D850E0347
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbfJVLo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 07:44:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388689AbfJVLo5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 07:44:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9A13ABD6;
        Tue, 22 Oct 2019 11:44:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91D69DA733; Tue, 22 Oct 2019 13:45:07 +0200 (CEST)
Date:   Tue, 22 Oct 2019 13:45:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] btrfs-progs: global-verbose option
Message-ID: <20191022114507.GT3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
 <20191021161256.GR3001@twin.jikos.cz>
 <daf2cb74-64bb-66bf-9b08-9f07076eacc8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf2cb74-64bb-66bf-9b08-9f07076eacc8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 09:54:41AM +0800, Anand Jain wrote:
> >> 1.
> >> The sub-commands as in [2] uses multi-level compile time verbose option,
> >> such as %g_verbose = 0 (quite), %g_verbose = 1 (default), %g_verbose > 1
> >> (real-verbose). And verbose at default is also part the .out files in
> >> fstests. So it needs further discussions on how to handle the multi-
> >> level verbose option using the global verbose option, and so sub-
> >> commands in [2] are untouched.
> > 
> > The idea is to unify all verbosity options. Default is 1, 0 is for quiet
> > (only errors are printed), the rest is up to the commands what to print
> > on the higher levels.
> 
> As of now verbosity level is a compile time option. [3]
> 
> [3]
> -------
> cmds/send.c
> 
>   51 /*
>   52  * Default is 1 for historical reasons, changing may break scripts 
> that expect
>   53  * the 'At subvol' message.
>   54  */
>   55 static int g_verbose = 1;
> --------

All the specific options would need to be unified while also maintaining
backward compatibility, like the above comment. Fortunatelly, if we set
default verbosity to 1, the only thing to do here will be to convert it
to the global config.

> > Some commands can have long option names or the argument names make it
> > long in some cases, the global options could stay indented. I think
> > visually it'll be ok. We can introduce some way to automatically format
> > the options and help texts so we don't have to adjust them manually each
> > time, but this would be more intrusive and can be done later.
> 
>   ok. But my pertaining question is if the sub-command verbose option
>   should still remain? if no I will be happy to take it out as the same
>   verbose will anyway be activated using the global verbose option.

For backward compatibility, where the per-command verbosity option
exists, it must continue, but will be an alias to the global option.
This is the awkward part but that' the cost of compatibility.

> > With the global verbose option there shouldbe also -q|--quiet. Both
> > short and long versions should be available for all commands. So the
> > help would look like:
> > 
> > ---
> >      Global options:
> >      -v|--verbose     verbose output, repeat for more verbosity
> >      -q|--quiet       print only errors
> > ---
> > 
> > In code this looks like:
> > 
> >            "",
> >            "-c|--commit-after  wait for transaction commit at the end of the operation",
> >            "-C|--commit-each   wait for transaction commit after deleting each subvolume",
> >            HELPINFO_GLOBAL_OPTIONS_HEADER,
> >            HELPINFO_INSERT_VERBOSE,
> >            NULL
> > 
> > #define HELPINFO_GLOBAL_OPTIONS_HEADER					\
> > 	"",								\
> > 	"Global options:"
> > 
> > and HELPINFO_INSERT_VERBOSE also contains the quiet option.
> > 
> > The global option value is stored in 'btrfs_config_init bconf', so
> > everything can access it directly.
> 
>   Oh ok.
> 
>   In the above code-snap [3].
> 
>   g_verbose = 0 and g_verbose = 1 can be mapped to the global
>   -q|--quite and --verbose respectively.

Yes, that's right

>   But any idea what to do with g_verbose > 1? which we support
>   in send.c and receive.c. And in defrag which the patch [4] removed it.

The verbosity option can be usually repeated and increasing the level,
so 

 $ btrfs -vvv send subvol

would be the same as

 $ btrfs send -vvv subvol

>    [4]
>    [RFC PATCH 09/14] btrfs-progs: restore: delete unreachable code
> 
>   Another way is
> 
>    btrfs [--quite] [--verbose[=n]]
> 
> n=1 default
> n=2 verbose

I'm not sure I've seen the '-v=n' way of specifying verbosity and would
rather avoid optional arugment.

The code hadling -v would do

	case OPT_VERBOSE:
		bconf.verbose++;
		break;
	case OPT_QUIET:
		bconf.verbose = 0;
		break;
