Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80FCFCA8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNQIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 11:08:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:45866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfKNQIO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 11:08:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBBDCAD0F;
        Thu, 14 Nov 2019 16:08:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F20C6DA774; Thu, 14 Nov 2019 17:08:13 +0100 (CET)
Date:   Thu, 14 Nov 2019 17:08:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20191114160813.GK3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
>  /*
> + * Global verbose option for the sub-commands
> + */
> +#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
> +	"",									\
> +	"Global options:"
> +#define HELPINFO_INSERT_VERBOSE							\
> +	"-v|--verbose       show verbose output"
> +#define HELPINFO_INSERT_QUIET							\
> +	"-q|--quiet         run the command quietly"
> +
> +/*
>   * Special marker in the help strings that will preemptively insert the global
>   * options and then continue with the following text that possibly follows
>   * after the regular options

I've realized there's more magic around the global options, because
currently the --format option depends on the subcommand definition thus
it can't be a static text like you do with the definition of
HELPINFO_GLOBAL_OPTIONS_HEADER.

There's a special keyword that gets replaced, the verbose/quite options
don't need that so it's just the plain textual definition/description.

As this is a simple fixup
s/HELPINFO_GLOBAL_OPTIONS_HEADER/HELPINFO_INSERT_GLOBALS/, hold on with
resending I might find more things or fix it myself.
