Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBB1F5050
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFJIaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 04:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJIav (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 04:30:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62173AD5E;
        Wed, 10 Jun 2020 08:30:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0D49DA872; Wed, 10 Jun 2020 10:30:44 +0200 (CEST)
Date:   Wed, 10 Jun 2020 10:30:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH 1/8] btrfs-progs: quota rescan: add quiet option
Message-ID: <20200610083044.GF27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200608063851.8874-1-anand.jain@oracle.com>
 <20200608063851.8874-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608063851.8874-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 08, 2020 at 02:38:44PM +0800, Anand Jain wrote:
> Enable the quiet option to the btrfs(8) quota rescan command.
> Does the job quietly. For example:
>   btrfs --quiet quota rescan
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  cmds/quota.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/quota.c b/cmds/quota.c
> index 075fc79816ad..4a68f9db081b 100644
> --- a/cmds/quota.c
> +++ b/cmds/quota.c
> @@ -108,6 +108,8 @@ static const char * const cmd_quota_rescan_usage[] = {
>  	"",
>  	"-s   show status of a running rescan operation",
>  	"-w   wait for rescan operation to finish (can be already in progress)",
> +	HELPINFO_INSERT_GLOBALS,
> +	HELPINFO_INSERT_QUIET,
>  	NULL
>  };
>  
> @@ -172,7 +174,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
>  	}
>  
>  	if (ret == 0) {
> -		printf("quota rescan started\n");
> +		pr_verbose(-1, "quota rescan started\n");

That the raw value -1 is used here is not nice, I assume it means print
unless there was another setting of the verbosity (nothing if -q,
otherwise yes).

>  		fflush(stdout);
>  	} else if (ret < 0 && (!wait_for_completion || e != EINPROGRESS)) {
>  		error("quota rescan failed: %m");
> -- 
> 2.25.1
