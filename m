Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE70FD660F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfJNPYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 11:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733176AbfJNPYq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 11:24:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F0D5BA73;
        Mon, 14 Oct 2019 15:24:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F9B3DA7E3; Mon, 14 Oct 2019 17:24:57 +0200 (CEST)
Date:   Mon, 14 Oct 2019 17:24:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
Message-ID: <20191014152457.GQ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
 <20191007174129.GK2751@twin.jikos.cz>
 <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 08, 2019 at 10:53:37AM +0800, Anand Jain wrote:
> On 10/8/19 1:41 AM, David Sterba wrote:
> > On Wed, Oct 02, 2019 at 12:11:52PM +0800, Anand Jain wrote:
> >> To help debug device scan issues, add verbose option to btrfs device scan.
> > 
> > The common options like --verbose are going to be added into the global
> > command so I'd rather avoid adding them to new subcommands as this would
> > become unnecessary compatibility issue.
> 
> > There's an pattern to follow, the output formats (--format). So add a
> > definition for global verbosity options, add new GETOPT_VAL global enum
> > values that do not clash with existing options, add relevant
> > HELPINFO_INSERT_ text string and use it in commands where needed.
> > 
> 
>   IMO a debug option should rather be at the top level command.
>   If verbose is the top level it would emit a lot of unwanted messages.
>   Here is how a user is using --verbose option in dev scan.
> 
>  
> https://lore.kernel.org/linux-btrfs/2daf15de-d1e7-b56a-be51-a6a3062ad28a@oracle.com/T/#t
> 
> ------------
> useful to get the list of devices it finds.
> ------------
> 
>   OR I didn't get the whole idea here. Looks like you are suggesting
>   something like
> 
>    btrfs --verbose device scan
>    btrfs --verbose subvolume list <mnt>

Yes this is what I mean.

>    ::
> 
>   How does the user will know if a subcommand will have any verbose
>   or not?

The point is that the global option will work for all subcommands, so
the user does not have to know which support that or not. For
compatiblity reasons, what works now will continue to work. This means
that the verbosity option will be duplicated for some commands.

>   How would you not emit unwanted messages and keep the output clutter
>   free.

What unwanted messages? Though the verbosity option will be set as
global option, it will be up to the command itself what to print.

  $ btrfs -v device scan

would be equivalent to

  $ btrfs device scan -v
