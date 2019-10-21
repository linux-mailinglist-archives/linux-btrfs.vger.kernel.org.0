Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839E2DF293
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfJUQMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUQMq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEC60B235;
        Mon, 21 Oct 2019 16:12:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4016DA733; Mon, 21 Oct 2019 18:12:56 +0200 (CEST)
Date:   Mon, 21 Oct 2019 18:12:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] btrfs-progs: global-verbose option
Message-ID: <20191021161256.GR3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 06:01:08PM +0800, Anand Jain wrote:
> This patch set brings --verbose option to the top level btrfs command,
> such as 'btrfs --verbose'. With this we don't have to add or remember
> verbose option at the sub-commands level.
> 
> As there are already verbose options to 11 sub-commands as listed
> below [1][2]. So the top level --verbose option here takes care to transpire
> verbose request from the top level to the sub-command level for 9 (not 11)
> sub-commands as in [1] as of now.
> 
> This patch is RFC still for the following two reasons (comments appreciated).
> 
> 1.
> The sub-commands as in [2] uses multi-level compile time verbose option,
> such as %g_verbose = 0 (quite), %g_verbose = 1 (default), %g_verbose > 1
> (real-verbose). And verbose at default is also part the .out files in
> fstests. So it needs further discussions on how to handle the multi-
> level verbose option using the global verbose option, and so sub-
> commands in [2] are untouched.

The idea is to unify all verbosity options. Default is 1, 0 is for quiet
(only errors are printed), the rest is up to the commands what to print
on the higher levels.

> 2.
> These patch has been unit-tested individually.
> These patches does not alter the verbose output.
> But it fixes the indentation in the command's help output, which may be
> used in fstests and btrfs-progs/tests and their verification is pending
> still, which I am planning to do it before v1.

The indentation does not need to be changed if the glboal options are
split from the per-command, like

---
usage: btrfs subvolume delete [options] <subvolume> [<subvolume>...]

    Delete subvolume(s)

    Delete subvolumes from the filesystem. The corresponding directory
    is removed instantly but the data blocks are removed later.
    The deletion does not involve full commit by default due to
    performance reasons (as a consequence, the subvolume may appear again
    after a crash). Use one of the --commit options to wait until the
    operation is safely stored on the media.

    -c|--commit-after  wait for transaction commit at the end of the operation
    -C|--commit-each   wait for transaction commit after deleting each subvolume

    Global options:
    -v|--verbose     show verbose output
---

Some commands can have long option names or the argument names make it
long in some cases, the global options could stay indented. I think
visually it'll be ok. We can introduce some way to automatically format
the options and help texts so we don't have to adjust them manually each
time, but this would be more intrusive and can be done later.

With the global verbose option there shouldbe also -q|--quiet. Both
short and long versions should be available for all commands. So the
help would look like:

---
    Global options:
    -v|--verbose     verbose output, repeat for more verbosity
    -q|--quiet       print only errors
---

In code this looks like:

          "",
          "-c|--commit-after  wait for transaction commit at the end of the operation",
          "-C|--commit-each   wait for transaction commit after deleting each subvolume",
          HELPINFO_GLOBAL_OPTIONS_HEADER,
          HELPINFO_INSERT_VERBOSE,
          NULL

#define HELPINFO_GLOBAL_OPTIONS_HEADER					\
	"",								\
	"Global options:"

and HELPINFO_INSERT_VERBOSE also contains the quiet option.

The global option value is stored in 'btrfs_config_init bconf', so
everything can access it directly.

Thanks for working on this, I'll have more comments on v2 as I probably
forgot a few more things to do, the above is the base for all further
changes.
