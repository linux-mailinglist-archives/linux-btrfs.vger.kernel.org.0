Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55161029CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 17:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKSQvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 11:51:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbfKSQvt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 11:51:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38840BDC4;
        Tue, 19 Nov 2019 16:51:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6ABECDA783; Tue, 19 Nov 2019 17:51:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 17:51:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20191119165147.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191114160813.GK3001@twin.jikos.cz>
 <6852d675-0244-388e-899f-008dc53b6ad9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6852d675-0244-388e-899f-008dc53b6ad9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 11:36:59AM +0800, Anand Jain wrote:
> > As this is a simple fixup
> > s/HELPINFO_GLOBAL_OPTIONS_HEADER/HELPINFO_INSERT_GLOBALS/, hold on with
> > resending I might find more things or fix it myself.
> > 
> 
> But there is one problem,  HELPINFO_INSERT_GLOBALS is already defined
> as..
>       Global options:
>      --format TYPE      where TYPE is: text
> 
> (ref: common/help.c   do_usage_one_command())
> 
> Albeit all commands support --format text by default.
> 
> But no sub-command is using the HELPINFO_INSERT_GLOBALS in its usage.
> 
> Looks like its a good idea to separate title and the options, like
> #define HELPINFO_INSERT_GLOBALS		"Global options:"
> #define HELPINGO_INSERT_FORMAT		"--format TYPE"

Yeah, makes sense to split it, right now the format does not bring
anything so that will be better done in a major release some time in the
future when more commands have json output.

> As at the moment I am not sure if its safe to declare that all
> sub-commands will support --format json (whenever we do that).

No, right now json output should not be declared anywhere.

> So with the defines split as above, in each sub-command-usage
> we shall do..
> 
> -----------------------------------------
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089abeaa..f4dba38b4c17 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -631,6 +631,10 @@ static const char * const 
> cmd_filesystem_show_usage[] = {
>          "-m|--mounted       show only mounted btrfs",
>          HELPINFO_UNITS_LONG,
>          "If no argument is given, structure of all present filesystems 
> is shown.",
> +       HELPINFO_INSERT_GLOBALS,
> +       HELPINFO_INSERT_FORMAT,
> +       HELPINFO_INSERT_VERBOSE,
> +       HELPINFO_INSERT_QUIET,

Sounds ok.
