Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000273F88B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjF0JSB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0JSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 05:18:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F80BF
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687857473; x=1688462273; i=quwenruo.btrfs@gmx.com;
 bh=7ApRoH5VVZPgLsXcNW5Dr/2UgTtlkuXGcQcs/wOYo2s=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=hAhljAu0fyu5VUBRdJxarEWFfE04o3MkQavXdJmQ6yHF1SRoM7C74TrZC6T8WX6Y2O/jIre
 Hhlx4wf+zSBft5tXI3oOwDsc3FcGjiQEchVf/gxPMJXGzPH4zNhzzLnAORMHyDj/d8yR5XAdO
 eKDMDBbF0dtsIf/z30LpSgiUsNc6HeWr5DmfibHs9i5jk4M1czdgNO7HsRK7GO4kacMrUVPl8
 WTE5eqbV2ibHFM4eguagqUOFV4eF0qoRvxBMJW6LomTy+0Zf9M5cWbe7eLZI4dI/q6abOQx3w
 tXsISKlrXpkbxLB0p771VO4x4qraJbblo/jiutsv6eqcjRlZiPZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpNy-1peC7G2Ah0-00ZxD7; Tue, 27
 Jun 2023 11:17:53 +0200
Message-ID: <1e5d822c-3d00-dc61-4bf5-0736b1fce275@gmx.com>
Date:   Tue, 27 Jun 2023 17:17:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] btrfs-progs: dump-super: fix read beyond device size
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1687854248.git.anand.jain@oracle.com>
 <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WCQjus194WDVAbH0rkEGv0nKD4sjHU+mqHnBz0sUgyd9rvUJE/R
 HSblP9Ub8APrqruLlybwypagMq2sbNNZ7twrLaVVU9XR+ICCm9QGAklSHtuyWUBLQ4Opa8n
 2mpHhPRfPCKnvlO8dPFlaN5xckR+Rn1Q1OEjVVfZZRs9ChmFxSRClsgOdLhn0FZMFhqwToO
 93cgpYdAcZ/2OcFcaqRyg==
UI-OutboundReport: notjunk:1;M01:P0:iIr0CCeKF9g=;hhQixhv3wPEyc/p672pNibOm6/L
 VtgWfiydj6jKCHF+eJWGkU7dJoxh5XTi7hwpi8jhXJdWHavsuV08J+SHY86jSqLGGQ+grUsgs
 Ew1qjd+XSN4GHmzvux/Vwph76uWClA9Fhu0LLe/5F6gevPXUBfsDfHRShq4n+I9fvyIDFanB/
 zVzEagPvvqePX2veqsKkiyIIyVuRhOe3kj3SlqBWXSXSuTnN8CRvT3hpUeET41uImmmWFwAah
 5bGvE1drQWLO3g26h7GszjIqNP8H8bXW0LkcmECW8XxpJGmVY4MA63YLDGAN85IBJNkUUT+Ey
 EVx4gRWn+rKkHey9ZeyQVT1MyAbi4DY3V4mwLY62t9m5xvOp0d1KIegp1VbKXk7/rooPhwNF0
 zjic4EMWPD+US7Ff3vZa5Lv4JlguP2kvuJ+pwt8sPJKHdlxoGe0OHLfYfMbEixBhUy94J8ROL
 6ViWzDHHkQkBqM274BSPHNx5TnfbQvFr5B1CWU+gy5V76/jmQhEvYF89veVElIBAoas8fzAvI
 2h1/aPP9viOUUNBXgEUdb5ADAivrzNz0c3nvkcOsgDGLJqn8aNeBHLWP799hSJfQIFGW4wNv8
 SRomiu1grh3IYmvK2uol8V1uRK08eAYqybVK+i2RWBGz2mqYI7JHShhBsRtLdHfpaMO/kLmS7
 SQMDNBTlEBRwUwr7Ks+wKky2sPYTEToSyNeOm61tiT4ZgXuaXTYmjWihDCg1OotldxKeTF8YX
 2oeTQONfmZxIlrmc1wZNQ7DbF2zM3hXpgLXP3F1k/dzBy92yGjnX1GFvv/TzRKOO42f+J5h0Z
 y06koy3fk4/Q4Y/OChdq5LuiAaERigzBDOi2EYzaYqNcrD6SsmUPTf9a5vgZqORT8N+LH0qGX
 9z7JH28G99nqIN50XM2esLWElWOkg2+N/nZRulBDbji9ym9FZ2N2Uz4YNiblNxhHDsHJ91oAt
 t0RNKC9Ckp/6RYl4BYPct98cYjI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 16:53, Anand Jain wrote:
> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
> failing because the command 'btrfs inspect dump-super -a <dev>' reports
> an error when it attempts to read beyond the disk/file-image size.
>
>        $ btrfs inspect dump-super -a /dev/vdb12
>        <snap>
>        ERROR: Failed to read the superblock on /dev/vdb12 at 27487790694=
4
>        ERROR: Error =3D 'No such file or directory', errno =3D 2
>
> And btrfs/184 also fails, as it uses -s 2 option to dump the last super
> block.
>
> 	$ ./check btrfs/184
> 	FSTYP         -- btrfs
> 	PLATFORM      -- Linux/aarch64 a4k 6.4.0-rc7+ #7 SMP PREEMPT Sat Jun 24=
 02:47:24 EDT 2023
> 	MKFS_OPTIONS  -- /dev/vdb2
> 	MOUNT_OPTIONS -- /dev/vdb2 /mnt/scratch
>
> 	btrfs/184 1s ... [failed, exit status 1]- output mismatch (see /Volumes=
/ws/xfstests-dev/results//btrfs/184.out.bad)
> 	    --- tests/btrfs/184.out    2020-03-03 00:26:40.172081468 -0500
> 	    +++ /Volumes/ws/xfstests-dev/results//btrfs/184.out.bad    2023-06-=
24 05:54:40.868210737 -0400
> 	    @@ -1,2 +1,3 @@
> 	     QA output created by 184
> 	    -Silence is golden
> 	    +Deleted dev superblocks not scratched
> 	    +(see /Volumes/ws/xfstests-dev/results//btrfs/184.full for details)
> 	    ...
> 	    (Run 'diff -u /Volumes/ws/xfstests-dev/tests/btrfs/184.out /Volumes=
/ws/xfstests-dev/results//btrfs/184.out.bad'  to see the entire diff)
> 	Ran: btrfs/184
> 	Failures: btrfs/184
> 	Failed 1 of 1 tests
>
> This is because `pread()` behaves differently on aarch64 and sets
> `errno =3D 2` instead of the usual `errno =3D 0`.
>
> To fix check if the sb offset is beyond the device size or regular file
> size and skip the corresponding sbread().
>
> Also, move putchar('\n') after a successful call to load_and_dump_sb() t=
o
> the load_and_dump_sb() itself.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/inspect-dump-super.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index f32c67fd5c4d..a1c3dcd9d90b 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -20,6 +20,7 @@
>   #include <fcntl.h>
>   #include <errno.h>
>   #include <getopt.h>
> +#include <sys/stat.h>
>   #include "kernel-shared/ctree.h"
>   #include "kernel-shared/disk-io.h"
>   #include "kernel-shared/print-tree.h"
> @@ -33,8 +34,27 @@ static int load_and_dump_sb(char *filename, int fd, u=
64 sb_bytenr, int full,
>   		int force)
>   {
>   	struct btrfs_super_block sb;
> +	struct stat st;
>   	u64 ret;
>
> +	if (fstat(fd, &st)) {
> +		error("error =3D '%m', errno =3D %d", errno);
> +		return 1;
> +	}
> +
> +	if (S_ISBLK(st.st_mode) || S_ISREG(st.st_mode)) {
> +		off_t last_byte;
> +
> +		last_byte =3D lseek(fd, 0, SEEK_END);
> +		if (last_byte =3D=3D -1) {
> +			error("error =3D '%m', errno =3D %d", errno);
> +			return 1;
> +		}
> +
> +		if (sb_bytenr > last_byte)
> +			return 0;
> +	}
> +
>   	ret =3D sbread(fd, &sb, sb_bytenr);
>   	if (ret !=3D BTRFS_SUPER_INFO_SIZE) {
>   		/* check if the disk if too short for further superblock */
> @@ -54,6 +74,7 @@ static int load_and_dump_sb(char *filename, int fd, u6=
4 sb_bytenr, int full,
>   		return 1;
>   	}
>   	btrfs_print_superblock(&sb, full);
> +	putchar('\n');
>   	return 0;
>   }
>
> @@ -168,15 +189,12 @@ static int cmd_inspect_dump_super(const struct cmd=
_struct *cmd,
>   					close(fd);
>   					return 1;
>   				}
> -
> -				putchar('\n');
>   			}
>   		} else {
>   			if (load_and_dump_sb(filename, fd, sb_bytenr, full, force)) {
>   				close(fd);
>   				return 1;
>   			}
> -			putchar('\n');
>   		}
>   		close(fd);
>   	}
