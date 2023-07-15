Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE2754763
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGOHzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGOHzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 03:55:42 -0400
Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6A3AA9
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 00:55:15 -0700 (PDT)
Received: from [192.168.1.27] ([84.221.16.1])
        by smtp-36.iol.local with ESMTPA
        id Ka7LqDcI63z8yKa7LqXXgs; Sat, 15 Jul 2023 09:55:03 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1689407703; bh=CSNM/vxUtxDmIPu60Clvzuq5SF7M8ZkI7pI7kfDYvAM=;
        h=From;
        b=vY2aOXE8VvBI7Dih2EAtkHzMvXCBlLTyiffX3OsvtmAh3KQRnsqecjf7vLaoxJSiw
         RSSCm8xLTBLvMEIYt+wHaH7y8MYufXzGpFPJkyRqjbKnFdOazUc7K9q8FujTCDRz4I
         c+Et3PxVUbk4r43o97U6NTT0iqRrnX/GTPw6Wco0M7hn6lGjwdKST5tn44QabWCn7Y
         4+cogWd5zUYUU2MCuAC7HlbO79s9bKtRwnMJYtokbSEyq/D+9XF+3mRSSm6DgUeiUz
         2A+eghVujx9DERFC0yFoQtapPhYHPagqQzO706FH5xOZ0E+lReZWIbtSbjeMnEZTim
         T9KY2Mq4FJZmw==
X-CNFS-Analysis: v=2.4 cv=VpPlQc6n c=1 sm=1 tr=0 ts=64b250d7 cx=a_exe
 a=vr8dJlsG5SImbR3TFHgzaw==:117 a=vr8dJlsG5SImbR3TFHgzaw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=D6NJEGuwsEpi-tpYABEA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <f393fcb9-2d8b-e21e-f0fb-d30cbbb1ed3b@libero.it>
Date:   Sat, 15 Jul 2023 09:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: kreijack@inwind.it
Subject: Re: btrfs loses 32-bit application compatibility after a while
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>, linux-btrfs@vger.kernel.org
References: <87cz0w1bd0.fsf@oldenburg.str.redhat.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <87cz0w1bd0.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM6ejnfPtRBkvLznKGIdmJ5rw+we2FBM8lDj1XrSGkFL7qPztKm/MXRQ7CtW+2DMR0J6g6il5LEIcBJOSlC8TxKar1c5rh05sqw3AJqLp+xzgSfCEgFb
 TcNmOTL5qdVcOkO2vRnKr0Mu6mIedjINNWKs+ACD2bEJKQ3nowlJlZ96F21YGXPHNW2z74rChq0vs0UOL/XVd9xfQNjbSCc9SYzl0CyrD47k8lag/438cSZr
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/07/2023 10.09, Florian Weimer wrote:
> As far as I can tell, btrfs assigns inode numbers sequentially using
> this function:
> 
> int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
> {
> 	int ret;
> 	mutex_lock(&root->objectid_mutex);
> 
> 	if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
> 		btrfs_warn(root->fs_info,
> 			   "the objectid of root %llu reaches its highest value",
> 			   root->root_key.objectid);
> 		ret = -ENOSPC;
> 		goto out;
> 	}
> 
> 	*objectid = root->free_objectid++;
> 	ret = 0;
> out:
> 	mutex_unlock(&root->objectid_mutex);
> 	return ret;
> }
> 
> Even after deletion of the object, inode numbers are never reused.
> 
> This is a problem because after creating and deleting two billion files,
> the 31-bit inode number space is exhausted.  (Not sure if negative inode
> numbers are a thing, so there could be one extra bit.)  From that point
> onwards, future files will end up with an inode number that cannot be
> represented with the non-LFS interfaces (stat, getdents, etc.), causing
> system calls to fail with EOVERFLOW.
> 
It is a know btrfs issue. On 32 bit some workloads may cause the
exhaustion of the inode number.

There was the inode_cache feature that it was supposed to permit to
reuse of the inode. It was removed, below some more details

https://patchwork.kernel.org/project/linux-btrfs/patch/20200623185032.14983-1-dsterba@suse.com/

It was deprecated in 5.9 and removed in 5.11 (see commit
f5297199a8bca12b8b96afcbf2341605efb6005de)

Despite the technical details, I am curious about how many 32 bit
systems still uses btrfs.

> For ABI reasons, we can't switch everything to 64-bit ino_t and LFS
> interfaces.  (If we could recompile, we wouldn't still be using 32-bit
> software.)
> 
> So far, we have seen this on our 32-bit Koji builders, which create and
> delete many, many files.  But I suspect end users will encounter it
> eventually, too.
> 
> It seems to me that the on-disk format already allows range searches on
> inode numbers (see btrfs_init_root_free_objectid), so maybe this could
> be used to find a sufficiently large unused range to allocate from.
> 
> Thanks,
> Florian
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

