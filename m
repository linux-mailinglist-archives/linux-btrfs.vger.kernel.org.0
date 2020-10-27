Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27329C4FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824026AbgJ0SBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 14:01:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1824022AbgJ0SBj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 14:01:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF3A9AE3B;
        Tue, 27 Oct 2020 18:01:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 929F8DA6E2; Tue, 27 Oct 2020 19:00:03 +0100 (CET)
Date:   Tue, 27 Oct 2020 19:00:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH v9 1/3] btrfs: add btrfs_strmatch helper
Message-ID: <20201027180001.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
 <20201026175228.GS6756@twin.jikos.cz>
 <d241d508-6c7e-1624-8f04-4c234bcd6c57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d241d508-6c7e-1624-8f04-4c234bcd6c57@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 09:19:33PM +0800, Anand Jain wrote:
> >> +	stripped = skip_spaces(given);
> >> +
> >> +	/* strip trailing whitespace */
> >> +	if ((strncmp(stripped, golden, len) == 0) &&
> >> +	    (strlen(skip_spaces(stripped + len)) == 0))
> >> +		return 0;
> > 
> > This a bit hard to read but ok, essentially we can do the string
> > comparison in a loop or use the library functions.
> >
> 
> >> +
> >> +	return -EINVAL;
> > 
> > This does not make sense as it's an error code while the function is a
> > predicate, without error states.
> > 
> 
>   A non zero value return will be some arbitrary number, is that OK?
>   Or the return arg can be bool instead of int.

Bool is fine in this case.
