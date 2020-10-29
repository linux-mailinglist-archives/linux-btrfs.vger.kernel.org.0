Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB329F42F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJ2Shb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJ2Shb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04DCBADCC;
        Thu, 29 Oct 2020 18:37:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27E0DDA7CE; Thu, 29 Oct 2020 19:35:53 +0100 (CET)
Date:   Thu, 29 Oct 2020 19:35:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 1/3] btrfs: add btrfs_strmatch helper
Message-ID: <20201029183552.GR6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
 <d3cfa1d20e7e0a86bbef9e078d887e90d1755b29.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cfa1d20e7e0a86bbef9e078d887e90d1755b29.1603884513.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 09:14:45PM +0800, Anand Jain wrote:
> Add a generic helper to match the golden-string in the given-string,
> and ignore the leading and trailing whitespaces if any.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Suggested-by: David Sterba <dsterba@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v10: return bool instead of int.
>      drop unnecessary local variable and ( ) with in if.
> v9: use Josef suggested C coding style, using single if statement.
> v5: born
>  fs/btrfs/sysfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index fcd6c7a9bbd1..5955379d3d9e 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -888,6 +888,24 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(, generation, btrfs_generation_show);
>  
> +/*
> + * Match the %golden in the %given. Ignore the leading and trailing whitespaces
> + * if any.
> + */
> +static bool btrfs_strmatch(const char *given, const char *golden)
> +{
> +	size_t len = strlen(golden);
> +
> +	/* skip leading whitespace */

Comments should start with uppercase unless it's an identifier.

> +	given = skip_spaces(given);
> +
> +	if (strncmp(given, golden, len) == 0 &&
> +	    !strlen(skip_spaces(given + len)))

You had strlen() == 0 instead of !strlen in v9, the == 0 is better here.

I'll fix that locally and push to misc-next so we can proceed with the
actual policies.
