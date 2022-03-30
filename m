Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542544EBA50
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 07:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiC3FrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 01:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiC3FrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 01:47:16 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303425B90A
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 22:45:30 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9099FC01C; Wed, 30 Mar 2022 07:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648619129; bh=xyko/7EqlrULMSNJwnyo9RB5yp9MBOBSMfOTi0ia3Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmYw5fPbSsi4kJ7wprDLCKHz1eot4qgorFrebS0Ut6SdQgUI7yqtO6FDGPoXs9Njd
         pa+21YWRoB5XjpRDfp3yTEleBPyoFALgERNsH+Z6Khga+EMkfpxO39RorXJqLdxWlU
         KSF8B9xftwbywWr4UMZI1o0ilZy/yJOtE9/CCkhAg4o8wz0Cf93pRz1nJokC3VodY+
         EihtnjlydwbwhvSu7bSg5JBnLo3iZqgf4H5iHxlt63suCVeIH/DA00jYJxlNsqGBHT
         rkQnyRkf70CSqw8xlJOCJTS/XZkWwTe9rePKf9MQRPOpeI1VCwaCZ/jrGOsROtJKTY
         u2j4xfOXFUyjg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id DA348C009;
        Wed, 30 Mar 2022 07:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648619127; bh=xyko/7EqlrULMSNJwnyo9RB5yp9MBOBSMfOTi0ia3Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiilbsocXCDrW2pi4DTQlzRdSUchQiPBEhnerrQZiYVw5OnBGJD0TQ68ZAlFwKdaP
         tYvpvzui3drhcRZcexKY6qFC46zFeSzAgIOS9vCJ1UTjonq+15ZQhhAgv/u/KmGpYh
         bhsQ/CMK4dRXVg3YvMpUJezIamdgG/YHl/zQ7bOw9m6b2+OG4FOeqN1z3UwratUNCZ
         FHUMxn37zyROTGF/hnFdvnhspCcrstZ+6NSoVHIvM8MaFfRerzVRKiKlf/iB8nNJBk
         +357aPlbD1fxS5F2rwsVwVKgwpvTEP2rnATxSUAcHWOc7wsmfv4MxmNNGOQZ6GPxe+
         awmdC3fqY26bg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 52d4044d;
        Wed, 30 Mar 2022 05:45:23 +0000 (UTC)
Date:   Wed, 30 Mar 2022 14:45:07 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [RFC PATCH] btrfs-progs: prop: add datacow inode property
Message-ID: <YkPuYyoV6LRWJdbS@codewreck.org>
References: <20220324042235.1483914-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324042235.1483914-1-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Dominique Martinet wrote on Thu, Mar 24, 2022 at 01:22:35PM +0900:
> The btrfs property documentation states that it is an unified and
> user-friendly method to tune btrfs properties instead of chattr,
> so let's add something for datacow as well.


I appreciate it's a trifling feature, but I'd appreciate not having to
teach our users about chattr if they could only have to manipulate btrfs
properties so I'd appreciate some feedback! :)

If you just say 'no' I'll bite the bullet and install e2fsprogs just for
btrfs and document the command, but as things stand my users (embedded
device developpers) have no way of disabling cow for e.g. database
workloads and that's not really good long-term.



> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> - I've sent it on github[1] first as there were other PRs, I'll close it
> there if this gets a reply 
> [1] https://github.com/kdave/btrfs-progs/pull/454 
> 
> - naming: I wasn't sure whether to name it datacow with yes/no, or making it
> "nodatacow" with true/false (readonly uses true/false so it might make more
> sense to use the later), I've picked datacow to avoid double-negation for
> ease of understanding but happy to change it to anything
> 
> - documentation: I got a bit confused with the rst and asciidoc file, as
> things got "converted" to rst recently but the asciidoc file didn't get
> removed. Should I have updated both?
> 
> Documentation/btrfs-man5.asciidoc          |  2 +-
>  Documentation/btrfs-property.rst           |  3 +
>  Documentation/ch-swapfile.rst              |  2 +-
>  cmds/property.c                            | 67 ++++++++++++++++++++++
>  tests/cli-tests/017-btrfs-property/test.sh | 25 ++++++++
>  5 files changed, 97 insertions(+), 2 deletions(-)
>  create mode 100755 tests/cli-tests/017-btrfs-property/test.sh
> 
> diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
> index dd296fac6fec..a2ed7eb582d9 100644
> --- a/Documentation/btrfs-man5.asciidoc
> +++ b/Documentation/btrfs-man5.asciidoc
> @@ -712,7 +712,7 @@ To create and activate a swapfile run the following commands:
>  
>  --------------------
>  # truncate -s 0 swapfile
> -# chattr +C swapfile
> +# btrfs property set swapfile datacow no
>  # fallocate -l 2G swapfile
>  # chmod 0600 swapfile
>  # mkswap swapfile
> diff --git a/Documentation/btrfs-property.rst b/Documentation/btrfs-property.rst
> index 5896faa2b2e2..600f6e60d255 100644
> --- a/Documentation/btrfs-property.rst
> +++ b/Documentation/btrfs-property.rst
> @@ -48,6 +48,9 @@ get [-t <type>] <object> [<name>]
>          compression
>                  compression algorithm set for an inode, possible values: *lzo*, *zlib*, *zstd*.
>                  To disable compression use "" (empty string), *no* or *none*.
> +        datacow
> +                copy on write flag for an inode: *no* or *yes*.
> +                This is the same as ``chattr``/``lsattr`` *+C* flag.
>  
>  list [-t <type>] <object>
>          Lists available properties with their descriptions for the given object.
> diff --git a/Documentation/ch-swapfile.rst b/Documentation/ch-swapfile.rst
> index 9d121bc5c569..f682e868632a 100644
> --- a/Documentation/ch-swapfile.rst
> +++ b/Documentation/ch-swapfile.rst
> @@ -36,7 +36,7 @@ To create and activate a swapfile run the following commands:
>  .. code-block:: bash
>  
>          # truncate -s 0 swapfile
> -        # chattr +C swapfile
> +        # btrfs property set swapfile datacow no
>          # fallocate -l 2G swapfile
>          # chmod 0600 swapfile
>          # mkswap swapfile
> diff --git a/cmds/property.c b/cmds/property.c
> index b3ccc0ff69b0..de9fde9e09e2 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -24,6 +24,7 @@
>  #include <sys/xattr.h>
>  #include <uuid/uuid.h>
>  #include <btrfsutil.h>
> +#include <linux/fs.h>
>  #include "cmds/commands.h"
>  #include "cmds/props.h"
>  #include "kernel-shared/ctree.h"
> @@ -232,6 +233,65 @@ static int prop_compression(enum prop_object_type type,
>  	return ret;
>  }
>  
> +static int prop_datacow(enum prop_object_type type,
> +			const char *object,
> +			const char *name,
> +			const char *value,
> +			bool force)
> +{
> +	int ret;
> +	ssize_t sret;
> +	int fd = -1;
> +	DIR *dirstream = NULL;
> +	//int open_flags = value ? O_RDWR : O_RDONLY;
> +	int open_flags = O_RDONLY;
> +	int attr;
> +
> +	fd = open_file_or_dir3(object, &dirstream, open_flags);
> +	if (fd == -1) {
> +		ret = -errno;
> +		error("failed to open %s: %m", object);
> +		goto out;
> +	}
> +
> +	sret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
> +	if (sret < 0) {
> +		ret = -errno;
> +		error("failed to get attr flags on %s: %m", object);
> +		goto out;
> +	}
> +
> +	if (value) {
> +		if (strcmp(value, "no") == 0) {
> +			attr |= FS_NOCOW_FL;
> +		} else if (strcmp(value, "yes") == 0) {
> +			attr &= ~FS_NOCOW_FL;
> +		} else {
> +			ret = -EINVAL;
> +			error("datacow value must be yes or no");
> +			goto out;
> +		}
> +
> +		sret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
> +		if (sret < 0) {
> +			ret = -errno;
> +			error("failed to set nocow flag on %s: %m",
> +			      object);
> +			goto out;
> +		}
> +	} else {
> +		fprintf(stdout, "datacow=%s\n",
> +			attr & FS_NOCOW_FL ? "no" : "yes");
> +	}
> +
> +	ret = 0;
> +out:
> +	if (fd >= 0)
> +		close_file_or_dir(fd, dirstream);
> +
> +	return ret;
> +}
> +
>  const struct prop_handler prop_handlers[] = {
>  	{
>  		.name ="ro",
> @@ -254,6 +314,13 @@ const struct prop_handler prop_handlers[] = {
>  		.types = prop_object_inode,
>  		.handler = prop_compression
>  	},
> +	{
> +		.name = "datacow",
> +		.desc = "copy on write status of a file",
> +		.read_only = 0,
> +		.types = prop_object_inode,
> +		.handler = prop_datacow
> +	},
>  	{NULL, NULL, 0, 0, NULL}
>  };
>  
> diff --git a/tests/cli-tests/017-btrfs-property/test.sh b/tests/cli-tests/017-btrfs-property/test.sh
> new file mode 100755
> index 000000000000..1da3eda4cd3a
> --- /dev/null
> +++ b/tests/cli-tests/017-btrfs-property/test.sh
> @@ -0,0 +1,25 @@
> +#!/bin/bash
> +# test btrfs property commands
> +
> +source "$TEST_TOP/common"
> +
> +# compare with lsattr to make sure
> +check_global_prereq lsattr
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev
> +
> +run_check $SUDO_HELPER touch "$TEST_MNT/file"
> +run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/file" datacow no
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" property get "$TEST_MNT/file" datacow |
> +	grep -q "datacow=no" || _fail "datacow wasn't no"
> +run_check_stdout $SUDO_HELPER lsattr "$TEST_MNT/file" |
> +	grep -q -- "C.* " || _fail "lsattr didn't agree NOCOW flag is set"
> +run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/file" datacow yes
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" property get "$TEST_MNT/file" datacow |
> +	grep -q "datacow=yes" || _fail "datacow wasn't yes"
> +
> +run_check_umount_test_dev
-- 
Dominique
