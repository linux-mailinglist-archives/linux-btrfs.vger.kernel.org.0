Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B813C150CE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 17:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgBCQj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 11:39:57 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46854 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbgBCQhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 11:37:01 -0500
Received: by mail-qv1-f68.google.com with SMTP id y2so7053349qvu.13
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 08:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uOlodWylk5iMlbnNfEplli+7W0l0o/w9QfaEuq22YoM=;
        b=G2bbbQ+oL1qkMndpp9XCFqkoe1b3SQE2vMiNTcJYXvccbkxsEa0LFzp/xPGIKzq1od
         W+/hSCSE5PWgqYj28A2U4qJ5mD/CEUO5y3PUPHTJ1fE7wtGf8TW7Fy9W2tCa3V14vknN
         U4EIlNgWq/kO74guhx7JxiLD5YxRWmKeEj4Yis8z7t0ypgVVQXqzA60pm2Iw+W3VwatQ
         aGv0Am0LvhqiQ5WITvENlACHmt3pbj0ZYFtGFtSLLY2Kk+L67bxeHw0ufGWBdqzwJKNn
         /ZUIeD1geuLFTbmASNFsLvEfluDe3LasWTPe21C3DFSIHsshXCyfdSf7UclMJUGwo+sY
         Xdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uOlodWylk5iMlbnNfEplli+7W0l0o/w9QfaEuq22YoM=;
        b=DOl7P35sqwHzGNbq+PyhpcQmozO7UsoiJJKAy2DnztqUtDm62DgoMokKTMNhqIhHeM
         kk0861Mq8oVcPTn3Hu1UzDASl+YxQCnGs/PUYz7UmyWKwHrekhkZuF/js+zXZNi2G31s
         b6rHLAnC+PrjN/rzfB1dkcjv/TYU6iDDndvoSgQLNthKCPfqlusGwRS4ypz+Vh+DSW2W
         YTpPkIPADaZv0G3sIg4TKt/zeQo3U8lBQVv7mKIhQMBJDeGmQCj6q3HiOBj4pHYxkPiU
         Xc/zNpvKyV7cz7KXRyyZodRvlyR0v4G/dk89ucg1jbHsb4GuQxUR0mds4WVmyUd8f3MJ
         Lrfw==
X-Gm-Message-State: APjAAAV7dWhBQtbdOpg6g01DYHmFSP+SvEuHtFXFcCdi3T3vheemFXe5
        3G4T2Zaq9ORo76D2qjLf+fT6LCeWcqVDbQ==
X-Google-Smtp-Source: APXvYqy+qdJvE+5ucpbWxQEefGPpSqqnhOa7VKcvpUIAQIXtf7FCMmKjlM1J5+edef21IyVPM33npQ==
X-Received: by 2002:a0c:f7c3:: with SMTP id f3mr23638784qvo.52.1580747820320;
        Mon, 03 Feb 2020 08:37:00 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o55sm10418447qtf.46.2020.02.03.08.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:36:59 -0800 (PST)
Subject: Re: [PATCH] btrfs: qgroup: Automatically remove qgroup item when
 dropping a subvolume
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191017073659.37687-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7f2baf8b-6826-bad9-1250-377cc8a3ce42@toxicpanda.com>
Date:   Mon, 3 Feb 2020 11:36:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20191017073659.37687-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/17/19 3:36 AM, Qu Wenruo wrote:
> [BUG]
> When a subvolume is created, we automatically create a level 0 qgroup
> for it, but don't remove it when the subvolume is dropped.
> 
> Although it's not a big deal, it can easily pollute the output of
> "btrfs qgroup show" and make it pretty annoying.
> 
> [FIX]
> For btrfs_drop_snapshot(), if it's a valid subvolume (not a reloc tree)
> and qgroup is enabled, we do the following work to remove the qgroup:
> - Commit transaction
>    This is to ensure that the qgroup numbers of that subvolume is updated
>    properly (all number of that subvolume should be 0).
> 
> - Start a new transaction for later operation
> 
> - Call btrfs_remove_qgroup()
> 
> So that qgroup can be automatically removed when the subvolume get fully
> dropped.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..5e8569cad16d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5182,6 +5182,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   	struct btrfs_root_item *root_item = &root->root_item;
>   	struct walk_control *wc;
>   	struct btrfs_key key;
> +	u64 rootid = root->root_key.objectid;
>   	int err = 0;
>   	int ret;
>   	int level;
> @@ -5384,6 +5385,30 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   	}
>   	root_dropped = true;
>   out_end_trans:
> +	/* If qgroup is enabled, also try to remove the qgroup */
> +	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) && root_dropped &&
> +	    is_fstree(rootid) && !for_reloc) {


Is the !for_reloc check superflous here?  is_fstree() should be enough.  Thanks,

Josef
