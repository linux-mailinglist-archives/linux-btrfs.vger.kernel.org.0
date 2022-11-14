Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62687627BD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiKNLOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 06:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiKNLOK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 06:14:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD227B36;
        Mon, 14 Nov 2022 03:09:47 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1oflso0AoA-00LYnB; Mon, 14
 Nov 2022 12:09:40 +0100
Message-ID: <8df079ab-d0a6-abf8-4c87-c820c148d134@gmx.com>
Date:   Mon, 14 Nov 2022 19:09:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] btrfs: fix failure of tests that use defrag on
 btrfs-progs v6.0+
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1668011769.git.fdmanana@suse.com>
 <e393451cb53b6b81804eaa41c6461b07a910eb62.1668011769.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e393451cb53b6b81804eaa41c6461b07a910eb62.1668011769.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:udFBzhd/liTTnkfRqQAKRctjk0xXxOqTuUU/TQtJ8wGQnn1BHJ+
 htWQFQViXleupU77Ar0D9esOlhyZgR33soy6v56uUGu5Y5Fqjzl8dYBDjBwHJzZmW4OUe16
 BXXck9InJ4oj8pvLvprLWZPYzz37N1tvlciF22LZ/rRFGeJpGFFqUYmVZbtL+EGSJ6o6H9M
 GxlrzYG6gq7u5cRiXstxg==
UI-OutboundReport: notjunk:1;M01:P0:LS8KAlstc3o=;TQAwZ/HWhJNL7FBmWptKwW0bML7
 kQcqN9t7Lg5GfNhSfx4PiGY9olO47OMtab01ejgMx2hZw0mjb0/yo+59uktDLjfnLFCkX+eOZ
 y5VjqHLXg2n6dHSG8qqXG6y2vZNmZvx2PZKFoef/TqBTCbXUX4Sj4suox4FhK9YhZ7TdF3rZs
 rqaLvdjyLbRs6rLN8AQm8gbEMmNd5kMLsQbx35KAtVT8FRWWtbV5i9P7C4k5RiR/w04MybrwL
 MP4q5h/qlRj5tBewUl2q+U+ltSkZAHugQhXX3kIVAOw4SlDMWp8dsQTWEu3auo3AVPCVq20iI
 xVfcghgg512uCScEpZFiirJGFPX4g3yvOfWs4z3KMcD8LJJS8ZeMWB4kXkJU2FWyfJ3lGKa1I
 Ji2AcFTtunQ3p3+U+VXG+O9CAbTRoP3LWkiK3/V8g9Fnw7AsK0woXeRgkEvw3X5GZbIMyqbPC
 fkG3iXYjfWN7QcbN5rkoXW2Oij0gweVLM+sTAfJG4vth0AIvVKs26aUXA+4w/a1TUNKVRQ43W
 AVgo1jnhTnCG0+6gpFQqG8BDiS3DNj10AcF16B5zOT/XxWDZDHritcu49alqksnVP9XUJvB1R
 gcPthd+7Z1ucXUbO+syxMY/A9jTGT+nSAyJ5scfY+6Y8HYXwlRgyJpFVqorKwkTVa1Z7+kpAo
 mf/C4Q/8Baw/D9G7EJGJeTZjo+3Lker8B9Dv/Q0p9KfMlTIdufZYqR9EbcQxeBJhn1op56Oqd
 gS1ww0zLeuyl5F0AkKtAeZ+nmnS/Z4tRvT1WpJooBxHeqUOHzK+0sgeNt42bd43nz1Sc6iILq
 DmYIyZLajfaTEq3m/hr2RBv09hc3w2upTAAc4j3ObNtYq/75F1ln1TggloSzfvvD5Epr7SMIY
 IcwTyH33428Vq2zex7KUhXR/cJP9wchhSYxCMmVUMn1xLNrVLS3xa3evDG6uzoCyunRQ5YiNw
 d2ImkF/DqifnLe8MYD/qq990gII=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/10 00:44, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs v6.0, the defrag command now prints to stdout
> the full path of the files it processes. This makes test cases btrfs/021
> and btrfs/256 fail because they don't expect any output from the defrag
> command.
> 
> The change happened with the following commit in btrfs-progs:
> 
>    dd724f21803d ("btrfs-progs: add logic to handle LOG_DEFAULT messages")
> 
> So update the tests to ignore the stdout of the defrag command.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/021 | 4 +++-
>   tests/btrfs/256 | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/021 b/tests/btrfs/021
> index 5943da2f..1b55834a 100755
> --- a/tests/btrfs/021
> +++ b/tests/btrfs/021
> @@ -22,8 +22,10 @@ run_test()
>   
>   	sleep 0.5
>   
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
>   	find $SCRATCH_MNT -type f -print0 | xargs -0 \
> -	$BTRFS_UTIL_PROG filesystem defrag -f
> +		$BTRFS_UTIL_PROG filesystem defrag -f > /dev/null
>   
>   	sync
>   	wait
> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> index 1360c2c2..acbbc6fa 100755
> --- a/tests/btrfs/256
> +++ b/tests/btrfs/256
> @@ -50,7 +50,9 @@ $FSSUM_PROG -A -f -w "$checksums_file" "$SCRATCH_MNT"
>   # Now defrag each file.
>   for sz in ${file_sizes[@]}; do
>   	echo "Defragging file with $sz bytes..." >> $seqres.full
> -	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz"
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
> +	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz" > /dev/null
>   done
>   
>   # Verify the checksums after the defrag operations.
