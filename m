Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB73ABD7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhFQUeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 16:34:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52390 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFQUem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 16:34:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F06FC21B1C;
        Thu, 17 Jun 2021 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623961953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkPNYLwUzSM0a+9JgQ1JGv+cNpOOeC+2+7RXeAFXQds=;
        b=nTHTGKlOxRSB4jxquA/MHwGRKrgPFEZVdME+AFTswOE+hcVAmCZP3fa0RaNfMhO6ma95Sc
        UnyT2ccx5nWb8fwfAQIZ+csjVWNo5OKgTwfGJ3lYpefxwtLp7hilqJHgdc+dNN6UDLx1Y7
        y6bt02BUucQtTqCYsgjrfQz3/8FmurA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623961953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PkPNYLwUzSM0a+9JgQ1JGv+cNpOOeC+2+7RXeAFXQds=;
        b=DT/gUVRUFSzY6WWNrnHHbrprn1q5dFghYt57WKjDPM+4AZsl5ZKkmXmHOdpLl2/pDdbx2o
        LE4V4JvUqlI454Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E9C0BA3B85;
        Thu, 17 Jun 2021 20:32:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8183DB225; Thu, 17 Jun 2021 22:29:45 +0200 (CEST)
Date:   Thu, 17 Jun 2021 22:29:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
Subject: Re: [PATCH] btrfs-progs: quota: Check for args.progress in
 cmd_quota_rescan
Message-ID: <20210617202945.GY28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
References: <20210611144301.10054-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611144301.10054-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 11:43:01AM -0300, Marcos Paulo de Souza wrote:
> The progress struct member is only set when there is a rescan being
> executed, so it's more readable read it directly.

I'm not sure this is right, kernel sets the flags and progress together,
ie. the progress value depends on the flags being set, so reading just
the progress does not follow the "ioctl protocol".

If the reason is to make the code readable I'd say it's obscuring the
fact that there's some semantics behind the ioctl so it should not be
obscured for readability reasons.

> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  cmds/quota.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cmds/quota.c b/cmds/quota.c
> index 246dd277..2038707e 100644
> --- a/cmds/quota.c
> +++ b/cmds/quota.c
> @@ -166,11 +166,11 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
>  			error("could not obtain quota rescan status: %m");
>  			return 1;
>  		}
> -		if (!args.flags)
> -			printf("no rescan operation in progress\n");
> -		else
> +		if (args.progress)
>  			printf("rescan operation running (current key %lld)\n",
>  				args.progress);
> +		else
> +			printf("no rescan operation in progress\n");

This could be improved that it checks for bit 0 set, and so should do
the kernel. Right now we haven't had anything else than the progress so
switching qsa->flags = 1 to |= 1 in btrfs_ioctl_quota_rescan_status
should be doing the same thing.

>  		return 0;
>  	}
>  
> -- 
> 2.26.2
