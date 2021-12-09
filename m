Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53C46E677
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhLIKVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLIKVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 05:21:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A5C061746;
        Thu,  9 Dec 2021 02:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C23FCE252A;
        Thu,  9 Dec 2021 10:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB0FC004DD;
        Thu,  9 Dec 2021 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639045053;
        bh=iiFK0xmih2wWtgCAO4h7MEOiE9UREM+HuXkiPB8K6rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqLQ1O6kWYVbmlRVdUsCF8LKLZ+uF/BZ3ILFpDnQB+hn3dIdCvm7gdG8FPwSsEydJ
         F6Sd3BYewbH2i3SaFEVB1UOUtvcL9x83vnU5v1sDo15tFjoR4l2j2M+B0EiocOGj2j
         5m5KFMNkat5PcANvZRGOj0+RGf7PcItTDqvZbqhXtdUsW+B6KsRufgNxfgfFxS6QPZ
         smw//lUCceRwYKdl6tBpAZ0id0EYphAXTHdljqzTBSpE+kxaclTcOYWqOITFBNeaE3
         eRrEU2eof3Hs9InHyp+xsiPaqgA4FQQd7aQhatp7DjQw/yrYqq9dnxVGQ6yhgvAxOc
         X+hCRKRUJaciw==
Date:   Thu, 9 Dec 2021 10:17:30 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix memory leak in __add_inode_ref()
Message-ID: <YbHXupg/zk8BLWFZ@debian9.Home>
References: <20211209065631.124586-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209065631.124586-1-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 02:56:31PM +0800, Jianglei Nie wrote:
> Line 1169 (#3) allocates a memory chunk for victim_name by kmalloc(),
> but  when the function returns in line 1184 (#4) victim_name allcoated
> by line 1169 (#3) is not freed, which will lead to a memory leak.
> There is a similar snippet of code in this function as allocating a memory
> chunk for victim_name in line 1104 (#1) as well as releasing the memory
> in line 1116 (#2).
> 
> We should kfree() victim_name when the return value of backref_in_log()
> is less than zero and before the function returns in line 1184 (#4).
> 
> 1057 static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
> 1058 				  struct btrfs_root *root,
> 1059 				  struct btrfs_path *path,
> 1060 				  struct btrfs_root *log_root,
> 1061 				  struct btrfs_inode *dir,
> 1062 				  struct btrfs_inode *inode,
> 1063 				  u64 inode_objectid, u64 parent_objectid,
> 1064 				  u64 ref_index, char *name, int namelen,
> 1065 				  int *search_done)
> 1066 {
> 
> 1104 	victim_name = kmalloc(victim_name_len, GFP_NOFS);
> 	// #1: kmalloc (victim_name-1)
> 1105 	if (!victim_name)
> 1106 		return -ENOMEM;
> 
> 1112	ret = backref_in_log(log_root, &search_key,
> 1113			parent_objectid, victim_name,
> 1114			victim_name_len);
> 1115	if (ret < 0) {
> 1116		kfree(victim_name); // #2: kfree (victim_name-1)
> 1117		return ret;
> 1118	} else if (!ret) {
> 
> 1169 	victim_name = kmalloc(victim_name_len, GFP_NOFS);
> 	// #3: kmalloc (victim_name-2)
> 1170 	if (!victim_name)
> 1171 		return -ENOMEM;
> 
> 1180 	ret = backref_in_log(log_root, &search_key,
> 1181 			parent_objectid, victim_name,
> 1182 			victim_name_len);
> 1183 	if (ret < 0) {
> 1184 		return ret; // #4: missing kfree (victim_name-2)
> 1185 	} else if (!ret) {
> 
> 1241 	return 0;
> 1242 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Fixes: d3316c8233bb05 ("btrfs: Properly handle backref_in_log retval")
Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-log.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8ab33caf016f..d373fec55521 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1181,6 +1181,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
>  					     parent_objectid, victim_name,
>  					     victim_name_len);
>  			if (ret < 0) {
> +				kfree(victim_name);
>  				return ret;
>  			} else if (!ret) {
>  				ret = -ENOENT;
> -- 
> 2.25.1
> 
