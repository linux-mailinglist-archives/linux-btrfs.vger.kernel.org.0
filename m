Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E61320A1F
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhBUL6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 06:58:15 -0500
Received: from ns2.wdyn.eu ([5.252.227.236]:37852 "EHLO ns2.wdyn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBUL6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 06:58:05 -0500
Subject: Re: Unexpected "ERROR: clone: did not find source subvol" on btrfs
 receive
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1613908672;
        bh=Aw+qEFGxiA1qtxrWzAMS9IrbaxbHvO2RHY7TkPLUEgo=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=XhB1yzJ1EpGnIEfPd+bdaPsD4DWBy73zvoQCZXpqjbXluV91HE4d9L8UfHnROo19Q
         nwTK6gTlNQZ7EpG2LCkxzxb71roLBK1h6n8VKkNhP9FKz5849FzkLrPUAwASS4Hjdx
         c6xH7+a+kyJ1/VbXCMnPZtzcmAAmI40l+E8MdfH8=
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
 <0fcbd697-11c5-0b32-7e08-80cf8d355271@gmail.com>
 <0d8ff769-59b3-9bbe-d958-9879e6f34719@wetzel-home.de>
Message-ID: <a2e5da8e-4267-4ef4-b259-18fa98aac263@wetzel-home.de>
Date:   Sun, 21 Feb 2021 12:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0d8ff769-59b3-9bbe-d958-9879e6f34719@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> While compiling I also switched to 
> https://github.com/kdave/btrfs-progs.git. Same problem.
> 
> I then tracked the error down up to btrfs_uuid_tree_lookup_any():
> 
> nr_items is zero after the call
> ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search_arg);
> (ret is also zero)
> 
> So looks like this is a filesystem issue?

I've now "reused" the ret < 0 output in btrfs_uuid_tree_lookup_any() and 
added nt_items to it, too.

Then I get:

# /home/alex/src/b2/btrfs-progs/btrfs  receive -f test2 .
At snapshot 2021-02-20-TEMP
ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key 483c17093f551dd3, UUID_KEY, 
896d0cfd51ec5cb6, nr_items=0) ret=0, error: No such file or directory
ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key 483c17093f551dd3, UUID_KEY, 
896d0cfd51ec5cb6, nr_items=0) ret=0, error: No such file or directory
ERROR: clone: did not find source subvol si=0, 
uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89

Any ideas what I can check with that information? The key looks 
interesting...

Here my debug patch against current git:

diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..29244f88 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -726,6 +726,7 @@ static int process_clone(const char *path, u64 
offset, u64 len,
  	char full_path[PATH_MAX];
  	const char *subvol_path;
  	char full_clone_path[PATH_MAX];
+	char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
  	int clone_fd = -1;

  	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
@@ -750,7 +751,8 @@ static int process_clone(const char *path, u64 
offset, u64 len,
  				ret = -ENOENT;
  			else
  				ret = PTR_ERR(si);
-			error("clone: did not find source subvol");
+			uuid_unparse(clone_uuid, uuid_str);
+			error("clone: did not find source subvol si=%i, uuid=%s", si, uuid_str);
  			goto out;
  		}
  		/* strip the subvolume that we are receiving to from the start of 
subvol_path */
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 21115a4d..82f6d078 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -64,16 +64,17 @@ static int btrfs_uuid_tree_lookup_any(int fd, const 
u8 *uuid, u8 type,
  	search_arg.key.max_transid = (u64)-1;
  	search_arg.key.nr_items = 1;
  	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search_arg);
-	if (ret < 0) {
+	if ((ret < 0) || (search_arg.key.nr_items < 1)) {
  		fprintf(stderr,
-			"ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key %016llx, UUID_KEY, %016llx) 
ret=%d, error: %m\n",
+			"ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key %016llx, UUID_KEY, %016llx, 
nr_items=%d) ret=%d, error: %m\n",
  			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, ret);
+			(unsigned long long)key.offset, search_arg.key.nr_items, ret);
  		ret = -ENOENT;
  		goto out;
  	}

  	if (search_arg.key.nr_items < 1) {
+		fprintf(stderr, "DDD2 ret=%i nr_items=%i\n", ret, 
search_arg.key.nr_items);
  		ret = -ENOENT;
  		goto out;
  	}



