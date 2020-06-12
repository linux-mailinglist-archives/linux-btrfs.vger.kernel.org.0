Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93F1F7B08
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLPjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 11:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:55954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLPjn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 11:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C3E4AAF1;
        Fri, 12 Jun 2020 15:39:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75E7BDA7C3; Fri, 12 Jun 2020 17:39:35 +0200 (CEST)
Date:   Fri, 12 Jun 2020 17:39:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v3 02/16] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20200612153935.GU27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1574678357-22222-3-git-send-email-anand.jain@oracle.com>
 <20200612105606.18210-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612105606.18210-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 12, 2020 at 06:56:06PM +0800, Anand Jain wrote:
> Add btrfs(8) global --verbose and --quiet command options to show
> verbose or no output from the sub-commands.
> By introducing global a %bconf::verbose memeber to transpire the same
> down to the sub-command.
> Further the added helper function pr_verbose() helps to logs the verbose
> messages, based on the state of the %bconf::verbose. And further HELPINFO_
> defines are provides for the usage.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
>   Add define MUST_LOG
>   Add comment about the argument %level in the function pr_verbose()

Now you've created quite some chaos here, why didn't you just send v3 as
a standalone patchset? Replies to individual patches works for small
fixups but not as a whole new iteration.

The second part now depends on this v3 that has the MUST_LOG define
burried in patch 2/16, while it should have been one extra patch to the
second part and we'd be done with that. I'll sort it out somehow but ...
