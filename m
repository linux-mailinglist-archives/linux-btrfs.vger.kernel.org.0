Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5B29946C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 18:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781286AbgJZRyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 13:54:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788628AbgJZRyE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 13:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36E46ABCC;
        Mon, 26 Oct 2020 17:54:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B42C6DA6E2; Mon, 26 Oct 2020 18:52:28 +0100 (CET)
Date:   Mon, 26 Oct 2020 18:52:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH v9 1/3] btrfs: add btrfs_strmatch helper
Message-ID: <20201026175228.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 03:43:35PM +0800, Anand Jain wrote:
> Add a generic helper to match the golden-string in the given-string,
> and ignore the leading and trailing whitespaces if any.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Suggested-by: David Sterba <dsterba@suse.com>
> ---
> v9: use Josef suggested C coding style, using single if statement.
> v5: born
> 
>  fs/btrfs/sysfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 8424f5d0e5ed..5ea262d289c6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -863,6 +863,26 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(, generation, btrfs_generation_show);
>  
> +/*
> + * Match the %golden in the %given. Ignore the leading and trailing whitespaces
> + * if any.
> + */
> +static int btrfs_strmatch(const char *given, const char *golden)
> +{
> +	size_t len = strlen(golden);
> +	char *stripped;
> +
> +	/* strip leading whitespace */

This is confusing as it's not stripping the space but merely skipping
it.  The arguments are not changed so you also don't need the separate
variable and just update 'given'.

> +	stripped = skip_spaces(given);
> +
> +	/* strip trailing whitespace */
> +	if ((strncmp(stripped, golden, len) == 0) &&
> +	    (strlen(skip_spaces(stripped + len)) == 0))
> +		return 0;

This a bit hard to read but ok, essentially we can do the string
comparison in a loop or use the library functions.

> +
> +	return -EINVAL;

This does not make sense as it's an error code while the function is a
predicate, without error states.

> +}
> +
>  static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, label),
>  	BTRFS_ATTR_PTR(, nodesize),
> -- 
> 2.25.1
