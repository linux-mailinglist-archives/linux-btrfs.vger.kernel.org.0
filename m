Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67BA396817
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhEaSt1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 14:49:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhEaSt0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 14:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622486865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONvPFw4CoVDHT9L/CK/qoWZO7jL4R8969vYb1k4udc0=;
        b=uwlfUpT0wmVgVnz+dMEkdFX0kEiPSWDZuTJXS9zd1Z4KAK0qEj+75T9w40a9sU7njjhDfM
        5lpR6fNo1YhiySS/FD/MGSu2iCvYg3xJFhAZENKXR7RD+OwRSyKkztNjAwCSZ/dfUnJilo
        5l/ID00XXVl/yn5ZpEZrKaVueQYGeIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622486865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONvPFw4CoVDHT9L/CK/qoWZO7jL4R8969vYb1k4udc0=;
        b=eIzCb6oHXwB1JirQyfA+yB4Kl/kPL4hEvsFELSzdB7TYspLMQEfxftXJxLx9Sn0VQiaIWf
        Z7mjiIr1l+8IAsDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79D91B4D1;
        Mon, 31 May 2021 18:47:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED9D9DA70B; Mon, 31 May 2021 20:45:05 +0200 (CEST)
Date:   Mon, 31 May 2021 20:45:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use list_last_entry in add_falloc_range
Message-ID: <20210531184505.GD31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531073703.41498-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531073703.41498-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 10:37:03AM +0300, Nikolay Borisov wrote:
> Instead of calling list_entry with head->prev simply call
> list_last_entry which makes it obvious which member of the list is
> being referred. This allows to remove the extra 'prev' pointer.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
> ---
>  fs/btrfs/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e910cc2cd45c..2b28a3daa5a9 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3034,7 +3034,6 @@ struct falloc_range {
>   */
>  static int add_falloc_range(struct list_head *head, u64 start, u64 len)
>  {
> -	struct falloc_range *prev = NULL;
>  	struct falloc_range *range = NULL;
>  
>  	if (list_empty(head))
> @@ -3044,9 +3043,9 @@ static int add_falloc_range(struct list_head *head, u64 start, u64 len)
>  	 * As fallocate iterate by bytenr order, we only need to check
>  	 * the last range.
>  	 */
> -	prev = list_entry(head->prev, struct falloc_range, list);
> -	if (prev->start + prev->len == start) {
> -		prev->len += len;
> +	range = list_last_entry(head, struct falloc_range, list);
> +	if (range->start + range->len == start) {
> +		range->len += len;
>  		return 0;
>  	}
>  insert:

The function could be restructured a bit to get rid of the insert:
label, like:

	if (!list_empty(head)) {
		range = list_last(...)
		if (range->start ...) {
			return;
		}
	}
	range = kmalloc(...)
	<the rest>

