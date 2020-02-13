Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3EA15CB66
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgBMTwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 14:52:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45402 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgBMTwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 14:52:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so3533326pgk.12
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlIGL4VBhydy60nyRhAQZ/+XeeQBeDRGjmVGlkgczFY=;
        b=vqV1rSBzMJv8I2CCK77lX565f1nbldEm853SNXFkb02apf2B/wxsIEog92JxlkyHHK
         WK5enjLIwRVenR+GDj5tnLVB/iQcP/GmBbHSkcSzA8SanZPfXVPuxl7/wcb+VKlAIG7w
         qMUY1ySBR8Q2Gb6Yjg+iS6n2DKEC+3A/36c0svCljeiNcMmamHndPdWA3QPxHWIvhptv
         vzN+L9aWmmVa4zfVqqVzC2Li50+BqYuJejbPhG+eoHdcIcrprYls7Y3EzFyBCb5T7qWS
         4bnOXuUbCdnr0xfjQ6i4BXjLuhlxYYxxhKERB0pnwvjJAEtDcSmFaFcsG7BwUhazOGOu
         Eiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlIGL4VBhydy60nyRhAQZ/+XeeQBeDRGjmVGlkgczFY=;
        b=Ss8p0i8+0niVD8HwZtTR+cWWjg90ezevdci4S1bTjqPM+MsPFERE2KCA1hPGtkHTOU
         ytNbnENoRSf7Tscqg6oLhG+FKnrlZCEARfQt62X+yJ+CGEOAeghotjH+tOpx7r30dAov
         HjmXlg5Y4a4R3zMbbpDjMglsDFfx6XfL3oS7P1etC44GRMcXGJwyEiPJNVDSki++y1E+
         4WmfGykyQPwek564qFOSKSvhdoVqM0nd3MVI9Mnf2j2bLkaJSbOApLwPgwYHZiV/nzyR
         kyiQXba81OdGfsyrUhlT4mOBCnUyG70c+DmoYS8RQIqhpL0kJ+giNxvfXYrVMntbzjc+
         1KGQ==
X-Gm-Message-State: APjAAAXsq7pOYUhQ3jew34ii/Zrq8lLpx87iB1wLCU7zdHMiLQdgIRQv
        GhS+9OCSIWVCUR1wlYDq7p1mxw==
X-Google-Smtp-Source: APXvYqzynh2RHHyryFTAEFEzqu74DbSCGKRdhIzvCTidYY4rl2w7swF0DdDrECfl+LqGDW6ihTIOew==
X-Received: by 2002:a62:2b8a:: with SMTP id r132mr14887954pfr.56.1581623533239;
        Thu, 13 Feb 2020 11:52:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id n2sm4071334pgn.71.2020.02.13.11.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:52:12 -0800 (PST)
Subject: Re: [PATCH v2 19/21] btrfs: factor out chunk_allocation_failed()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-20-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b9579637-fb57-6b02-48fa-46878136cf8c@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:52:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-20-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out chunk_allocation_failed() from find_free_extent_update_loop().
> This function is called when it failed to allocate a chunk. The function
> can modify "ffe_ctl->loop" and return 0 to continue with the next stage.
> Or, it can return -ENOSPC to give up here.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent-tree.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index efc653e6be29..8f0d489f76fa 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3748,6 +3748,21 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
>   	}
>   }
>   
> +static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
> +{
> +	switch (ffe_ctl->policy) {
> +	case BTRFS_EXTENT_ALLOC_CLUSTERED:
> +		/*
> +		 * If we can't allocate a new chunk we've already looped through
> +		 * at least once, move on to the NO_EMPTY_SIZE case.
> +		 */
> +		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
> +		return 0;
> +	default:
> +		BUG();
> +	}
> +}
> +
>   /*
>    * Return >0 means caller needs to re-search for free extent
>    * Return 0 means we have the needed free extent.
> @@ -3819,19 +3834,12 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>   			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
>   						CHUNK_ALLOC_FORCE);
>   
> -			/*
> -			 * If we can't allocate a new chunk we've already looped
> -			 * through at least once, move on to the NO_EMPTY_SIZE
> -			 * case.
> -			 */
>   			if (ret == -ENOSPC)
> -				ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
> +				ret = chunk_allocation_failed(ffe_ctl);
>   
>   			/* Do not bail out on ENOSPC since we can do more. */
>   			if (ret < 0 && ret != -ENOSPC)
>   				btrfs_abort_transaction(trans, ret);
> -			else
> -				ret = 0;

You can't delete this, btrfs_chunk_alloc() will return 1 if it succeeded, and 
we'll leak that out somewhere and bad things will happen.  Thanks,

Josef
