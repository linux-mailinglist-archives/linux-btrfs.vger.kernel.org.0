Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5C251E46
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYR2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 13:28:49 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:55407 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbgHYR2s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 13:28:48 -0400
Received: from venice.bhome ([94.37.192.142])
        by smtp-33.iol.local with ESMTPA
        id AckXkiywq8e2WAckXkJRIN; Tue, 25 Aug 2020 19:28:46 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1598376526; bh=z+i+UGiZ4qX8ekQ2ETZIHTPI5dtU5IQJzqRmMEl6yB8=;
        h=From;
        b=p4LftJ8ze8ed04X142JDDZX74q8oM2njzqVuFHgKzmbgd/N5fYtSdUChv/aKK0s3R
         MWlOL/1TRBJWuZmuJcmtvYH7QPyjfvnfs4XC2lYGRiZ2f7c5E/Zw1rULgBE0K12jbI
         4PT/SdD8hLs7Ua9axtZvcYsRT60Y/3Xgbd/5rYFbRADICqY+M41luTV+V94oJpIWx9
         XWgmdqU5OG6wPjW5qdK7OKShUuo8wJoca5lOkzkMMtczZ8XMe2Tr8aCTCDUPBX0Bz/
         skZZ4sgL5tRyv6Feze4sWLEvLcXmbC6G4UT2yFvLzD08MpNPkyzSD3vAxunPAMgODv
         JtT8ksbuw0SbQ==
X-CNFS-Analysis: v=2.4 cv=ZYejiuZA c=1 sm=1 tr=0 ts=5f454a4e
 a=ppQ2YIgYQAGACouVZCsPPQ==:117 a=ppQ2YIgYQAGACouVZCsPPQ==:17
 a=IkcTkHD0fZMA:10 a=maIFttP_AAAA:8 a=eQvp_tLMpgjuMhaeEAgA:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: add a warning and countdown for RAID5/6
 conversion
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <164e102b2a6179f9af35ded962c11d780ccf8400.1598375602.git.josef@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <969bf9a2-6635-d7a4-a4b2-ae1fa28c73ed@libero.it>
Date:   Tue, 25 Aug 2020 19:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <164e102b2a6179f9af35ded962c11d780ccf8400.1598375602.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfER9VsJqF9PURxI02ywJRzoc9Oj+ICk5IhFAJ1Dg4ar7c0cGO8SYm+iJ9Ik/rzdHX0smKKkYuPs8zYpuK47hlgRddY4dDKyRQpIW8erhNf8/hoOPbGA9
 oLp0sOP5ZDoWcU55eniDkYsiVJdgdhiwI1kKK3prCD5v2GHN63AWIa4Fz7yHWbjEzzfwvewga2ZA+vqkNJS5usKKpcMZ0JWpUQtsF0HQ9mkEnfe6gByh1ot8
 eVnRE+yLB+yRUkCT1DrAJQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 7:13 PM, Josef Bacik wrote:
> Similar to the mkfs warning, add a warning to btrfs balance -*convert
> options, with a countdown to allow the user to have time to cancel the
> operation.

It is possible to add a switch to skip the countdown ? Something like "--balance-raid56-i-know-what-i-am-doing". I am thinking to the developers which are doing some tests
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   cmds/balance.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/cmds/balance.c b/cmds/balance.c
> index b0535d40..d7b2b3d6 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -515,6 +515,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
>   	int force = 0;
>   	int background = 0;
>   	unsigned start_flags = 0;
> +	bool warned = false;
>   	int i;
>   
>   	memset(&args, 0, sizeof(args));
> @@ -616,11 +617,36 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
>   
>   	/* soft makes sense only when convert for corresponding type is set */
>   	for (i = 0; ptrs[i]; i++) {
> +		int delay = 10;
> +
>   		if ((ptrs[i]->flags & BTRFS_BALANCE_ARGS_SOFT) &&
>   		    !(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT)) {
>   			error("'soft' option can be used only when converting profiles");
>   			return 1;
>   		}
> +
> +		if (!(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT))
> +			continue;
> +
> +		if (!(ptrs[i]->flags & (BTRFS_BLOCK_GROUP_RAID6 |
> +					BTRFS_BLOCK_GROUP_RAID5)))
> +			continue;
> +
> +		if (warned)
> +			continue;
> +
> +		warned = true;
> +		printf("WARNING:\n\n");
> +		printf("\tRAID5/6 support is still experimental and has known issues.\n");
> +		printf("\tIt is recommended that you use one of the other RAID profiles.\n");
> +		printf("\tThe operation will continue in %d seconds.\n", delay);
> +		printf("\tUse Ctrl-C to stop.\n");
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +		printf("\nStarting conversion to RAID5/6.\n");
>   	}
>   
>   	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
