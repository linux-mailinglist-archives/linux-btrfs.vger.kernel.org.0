Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1EE55899
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfFYURt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 16:17:49 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:40374 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYURs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 16:17:48 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B99C6142BC2; Tue, 25 Jun 2019 21:17:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1561493865;
        bh=jrXPYgWA9AHQVPM7BH3cqMkpfwvBMyhRPr2Qg7rg1Us=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=F7Zlp0sMi65mBQUdS64JaU6YFcN8QIc75k4BQlyyXA4FQSNONAuVNDQtH6RHA9kb9
         604IuGt99Tj7ZlgYIFz72tFUjSlt/UN5d+VVN4f0YXFjnUBvTDbNjuf02STn1jmgno
         NGvOZW3MM7CHBJRccydMBV0rvoGjrlTb+JSIpwFy4tkZRXYeLB2mk9wNOMLv2dOQP7
         L/nEqVax5tl+cfHG/OYWOx0WJaHEh05Jf0rjw3VpCW5Wz4sSvRjHzPMC3hpTNCWhCL
         9PGu3QdKZapKbPOtPrFw3FBhiNfAg+6LdTJ0lNV53xyFbMpmX07Rqnb7dWr3wvqy9+
         Lv7qIH6uARcFg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DFB00142BC1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 21:17:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1561493864;
        bh=jrXPYgWA9AHQVPM7BH3cqMkpfwvBMyhRPr2Qg7rg1Us=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kwfjCOnDpdm5tNn20gDju3kZOy22uDKv6RgFc6Nl0IFumnTlOhEHwB6j5rVfgQLXj
         o8ILTOUq9ynrwtZIq5SiRB6dQwIKRPt9xVFDxfL377rAf+KkDRI7Dnm+q1pFUlH65h
         SWbA2sAq8Zaw5OWzQu92IB4UjMjwbb8pQLwHCoMHrbWn15sgd4ROtjuEkUvshlj3td
         3p9t3Ci1o/UGJ7S2mV4XZlNcdOWI+FSz8QYvZ2dTUueWRyXLYGWAWMphCfIpXA3nI8
         1LK1GeHcphLm/CiVl/WNxmZ1GHS2xR30TyfAN/U0PvmFeCFhgK6AryWHBWOwoHE19r
         8pF43mAt0VW+w==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A44FCCBA3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 21:17:43 +0100 (BST)
Subject: Re: [PATCH] btrfs-progs: scrub: Fix scrub cancel/resume not to skip
 most of the disk
To:     linux-btrfs@vger.kernel.org
References: <2c415510-8d46-065d-6b38-b8514a8ffcc1@cobb.uk.net>
 <20190618080825.15336-1-g.btrfs@cobb.uk.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <9edea292-d787-9911-d067-348c522b8b3b@cobb.uk.net>
Date:   Tue, 25 Jun 2019 21:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618080825.15336-1-g.btrfs@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2019 09:08, Graham R. Cobb wrote:
> When a scrub completes or is cancelled, statistics are updated for reporting
> in a later btrfs scrub status command and for resuming the scrub. Most
> statistics (such as bytes scrubbed) are additive so scrub adds the statistics
> from the current run to the saved statistics.
> 
> However, the last_physical statistic is not additive. The value from the
> current run should replace the saved value. The current code incorrectly
> adds the last_physical from the current run to the previous saved value.
> 
> This bug causes the resume point to be incorrectly recorded, so large areas
> of the disk are skipped when the scrub resumes. As an example, assume a disk
> had 1000000 bytes and scrub was cancelled and resumed each time 10% (100000
> bytes) had been scrubbed.
> 
> Run | Start byte | bytes scrubbed | kernel last_physical | saved last_physical
>   1 |          0 |         100000 |               100000 |              100000
>   2 |     100000 |         100000 |               200000 |              300000
>   3 |     300000 |         100000 |               400000 |              700000
>   4 |     700000 |         100000 |               800000 |             1500000
>   5 |    1500000 |              0 | immediately completes| completed
> 
> In this example, only 40% of the disk is actually scrubbed.
> 
> This patch changes the saved/displayed last_physical to track the last
> reported value from the kernel.
> 
> Signed-off-by: Graham R. Cobb <g.btrfs@cobb.uk.net>

Ping? This fix is important for anyone who interrupts and resumes scrubs
-- which will happen more and more as filesystems get bigger. It is a
small fix and would be good to get out to distros.

Graham

> ---
>  cmds-scrub.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds-scrub.c b/cmds-scrub.c
> index f21d2d89..2800e796 100644
> --- a/cmds-scrub.c
> +++ b/cmds-scrub.c
> @@ -171,6 +171,10 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p)
>  	fs_stat->p.name += p->name;		\
>  } while (0)
>  
> +#define _SCRUB_FS_STAT_COPY(p, name, fs_stat) do {	\
> +	fs_stat->p.name = p->name;		\
> +} while (0)
> +
>  #define _SCRUB_FS_STAT_MIN(ss, name, fs_stat)	\
>  do {						\
>  	if (fs_stat->s.name > ss->name) {	\
> @@ -209,7 +213,7 @@ static void add_to_fs_stat(struct btrfs_scrub_progress *p,
>  	_SCRUB_FS_STAT(p, malloc_errors, fs_stat);
>  	_SCRUB_FS_STAT(p, uncorrectable_errors, fs_stat);
>  	_SCRUB_FS_STAT(p, corrected_errors, fs_stat);
> -	_SCRUB_FS_STAT(p, last_physical, fs_stat);
> +	_SCRUB_FS_STAT_COPY(p, last_physical, fs_stat);
>  	_SCRUB_FS_STAT_ZMIN(ss, t_start, fs_stat);
>  	_SCRUB_FS_STAT_ZMIN(ss, t_resumed, fs_stat);
>  	_SCRUB_FS_STAT_ZMAX(ss, duration, fs_stat);
> @@ -683,6 +687,8 @@ static int scrub_writev(int fd, char *buf, int max, const char *fmt, ...)
>  
>  #define _SCRUB_SUM(dest, data, name) dest->scrub_args.progress.name =	\
>  			data->resumed->p.name + data->scrub_args.progress.name
> +#define _SCRUB_COPY(dest, data, name) dest->scrub_args.progress.name =	\
> +			data->scrub_args.progress.name
>  
>  static struct scrub_progress *scrub_resumed_stats(struct scrub_progress *data,
>  						  struct scrub_progress *dest)
> @@ -703,7 +709,7 @@ static struct scrub_progress *scrub_resumed_stats(struct scrub_progress *data,
>  	_SCRUB_SUM(dest, data, malloc_errors);
>  	_SCRUB_SUM(dest, data, uncorrectable_errors);
>  	_SCRUB_SUM(dest, data, corrected_errors);
> -	_SCRUB_SUM(dest, data, last_physical);
> +	_SCRUB_COPY(dest, data, last_physical);
>  	dest->stats.canceled = data->stats.canceled;
>  	dest->stats.finished = data->stats.finished;
>  	dest->stats.t_resumed = data->stats.t_start;
> 

