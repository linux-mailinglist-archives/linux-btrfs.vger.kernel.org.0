Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF39205764
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgFWQkW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 12:40:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbgFWQkV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 12:40:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCC81AEC1;
        Tue, 23 Jun 2020 16:40:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 438E1DA79B; Tue, 23 Jun 2020 18:40:08 +0200 (CEST)
Date:   Tue, 23 Jun 2020 18:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8 v2 PART2] btrfs-progs: add quiet option
Message-ID: <20200623164008.GM27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 12, 2020 at 01:41:15AM +0800, Anand Jain wrote:
> v2: pr_verbose()'s first argument %level can accept -1, and if the
>     quiet option is not set, pr_verbose() shall print the message
>     overriding the verbose level set during the command option.
>     We need this -1 level to make sure we continue to print the
>     messages which have been printed with the default log level,
>     so that backward compatibility is maintained.
> 
>     Now in v2 value: -1 is defined as MUST_LOG. The relevant patch
>     is sent as a reroll patch v3 
> [PATCH v3 02/16] btrfs-progs: add global verbose and quiet options and helper functions
>     in the part-1 set. So replace -1 with the new define wherever
>     necessary.
> 
>     The whole series (both part-1 and part-2) has been pushed to
>     the git repo branch as below [2].
> 
> ----- main cover-letter -------
> The part-1 patchset [1] 'btrfs-progs: global verbose and quiet option'
> [1]
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=207709
> 
> provided a global structure to communicate the verbose and quiet options
> down to the individual sub-commands where the actual printf happens.
> So each of the sub-command could enable the verbose or quiet option as
> needed.
> But some of the sub-commands already had the verbose and quiet options
> locally at the sub-command level. So the aim of part-1 of this series
> was to merge the local verbose and quiet option with the global verbose
> and quiet, which it did successfully.
> 
> In this series, part-2, adds the global quiet option to the found
> chatty sub-commands. So each of the sub-commands outputs were 
> individually checked and brought those logs under the global quiet
> option. As this process is nondeterministic (unless like in part-1 where
> sub-commands with -v or -q were checked) so there might have few logs
> left behind and those can be fixed as moved along.
> 
> The whole series can be fetched from [2], which is based on latest devel
> branch, last commit: c1d6d654a3f9 (btrfs-progs: docs: update balance).
> 
> [2]
> https://github.com/asj/btrfs-progs.git verbose
> 
> Anand Jain (8):
>   btrfs-progs: quota rescan: add quiet option
>   btrfs-progs: subvolume create: add quiet option
>   btrfs-progs: subvolume delete: add quiet option
>   btrfs-progs: balance start: add quiet option
>   btrfs-progs: balance resume: add quiet option
>   btrfs-progs: subvolume snapshot: add quiet option
>   btrfs-progs: scrub start|resume: use global quiet option
>   btrfs-progs: scrub cancel: add quiet option

Merged to devel, some time ago, with some fixups. Thanks.
