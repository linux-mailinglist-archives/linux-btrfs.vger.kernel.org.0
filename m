Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF646EA66
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 15:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhLIPBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 10:01:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35298 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbhLIPBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 10:01:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9529F1F37E;
        Thu,  9 Dec 2021 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639061857;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzIyK+gI/e6qy64cioNsB/eyWTg6lDPo2zLef13Qb4k=;
        b=Qo5sPc/P1oqZt0kfsY2w9dkF4Jm+6ERRLHS87A719/Ex1Zc61R0GsKZpKg8tnwZQxqPrGI
        ySfuR88cyrVS/cvTgVBBq8Nn7cjippO69D0oKYxMLh5t5mxK2njJvrFojXqc8ao1W27YIx
        BxL26MVDl4raecYeibt+c5L8thHSzik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639061857;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzIyK+gI/e6qy64cioNsB/eyWTg6lDPo2zLef13Qb4k=;
        b=uW0xqn7RdCT45OG86B/Ho7qyuawOQXG4iBlCbJtajyWcYhNzYQMZNE2KZNZ3WcZCyuEaGS
        p8zS/o3rISAOOnBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 80111A3B93;
        Thu,  9 Dec 2021 14:57:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DBA4FDA799; Thu,  9 Dec 2021 15:57:21 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:57:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix memory leak in __add_inode_ref()
Message-ID: <20211209145721.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jianglei Nie <niejianglei2021@163.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209065631.124586-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209065631.124586-1-niejianglei2021@163.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

Added to misc-next, thanks.
