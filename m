Return-Path: <linux-btrfs+bounces-21878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL3nNu+2nWlyRQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21878-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:34:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78C1886D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A653173AA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518C39E6EE;
	Tue, 24 Feb 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXuNoXYY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117F39B48D
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943361; cv=none; b=NbBv6t52+ic0aSOQt+TQNQH8fo2VRM566MaNs5qJh7VRODt/HRxSjvb+gn3sNssAaNp4mP8DGskybVnVZvoHZ/qt5wYdiJ/OCVH+vJQKaszJJl8c64ym4bSpiI3Y5YTl90OksAMf6R2ffnCUxpTD3suSrzjh75egyG9P6AuqKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943361; c=relaxed/simple;
	bh=mP4a+348mrfp4McrAym7M8vsHjahpN7T6dYwYe6vRFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WSqheEIGl7zsej5kwralq/lVa0NQtJBYS9YzHUccr/HD9yV8OggTbEEu58sReb86KtdQkra/qP1J/6FAxzOO74h/fpw8+NTVTC53Svv8ZhhuPKwM8i7oRXY3sVRSCK2hbFrlT6EYUWO8Lc1QVpKcvetpMEZ9KThhRQD9PfQdZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXuNoXYY; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a8720818aeso2979125ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771943360; x=1772548160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uU9cxvk8zjz9pUQPSSd+qPBXFgW+4ls5fQHSszazU48=;
        b=lXuNoXYY2KaVcwY57w84X6sJ1NIUM6DOglu+69dmzLKVjjLXzNF57rSD2+T/Thiy0+
         s98RjTxPIgZ4JK9656qzsGXu4O0uvXgPR1xW6LQ524BN46x/Imnp8lvD2d0LH711O5Td
         nQOVOzi4VPKm5t1m463LkSrBluyiavUWVCpbKlP5EgQkJVZ3DeMmd5AI3M7oX+GBsd4D
         0aoYKvjBh6VZ+xC3qd2m00TgYpuSc4Rm9vWe8s5/ZfAuDBb5VvCaNwoQXBoJirApR29V
         P4m2xZQ5uBB8ssi8QWvj7xCMYb+v1HQFJmFfpsfmWsb9iofmBBIFFzzbBENtYZXAFZKp
         a4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943360; x=1772548160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU9cxvk8zjz9pUQPSSd+qPBXFgW+4ls5fQHSszazU48=;
        b=oZ2iDVX0GI+Gbihg/V8ii3C9/nLDrQbk9AHrPXEQrB0Iyg1cUIwZt+GmWpWuffSCJw
         8FUDjkNKYRPExZZq8MLM7MQqWm9ZBotcXOA55O+r70esZSqts2iHXVsMx2a93qkuJfQB
         xISQHGSlZu7quUSBxgMJJN4V3S+lrBDdVMJVDTQJLuDPli+hrA1M59WZcgSuXPewwA1M
         ROxmjxs78Hhun8tPGDkHWQ2rp+SBqL5olSu6I2g/iDcQJlBmG6wisGB2hgYM2wkfHMdM
         PsLikeIDwtnU5NkA683aUs+eW1hdZS2889Jst6qg2hBZFu0D2AfDS0k9kYsoyuh6p7/A
         QFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0dw6cR+qtYe1koGAdo+4ACqBM9GVZZN3Ks5A3EJ+7EP2HppfMGXTPksR2FvXnurkJBWtp0e9aR8RZgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0u0Zc+xa3hy5UelQzN13if+EyVX7VTZ7zB7O+LngO6bJMVSa
	qRLEbr4GeKS7xG0RmOT7UUBzc425WEWzFOsbxQ2sViyyeMqCrdX41sDC9JQwtdJHR+fgTw==
X-Gm-Gg: ATEYQzwB7gc4/l+GkaTU1iKzlPfSwsFciBfuyOb3SeCrbwPW0wMdP+4D9xv/xKD4h54
	3HtRC+EbsLShyeB6ysf9Pbl/+lYFsBcakQ/m4irq4IbzLicSRcChJnQdxC/HrD0X7rlm+rRCqIs
	LccwVVFrNIKrYnvoDy+9kcI+fe9mmRv/N7nBeaY1IGfB8CcoAv4l2ktsMpCWCvDkD7s5nh/9w3x
	Ml5XIAGKy9FF6SWnZBleSQ3u21L68227gWwtBqnVCZWNWy16HiTQaqwwQSlWx8biyvfT5hLRsHJ
	k9QehPZvW0R0ReMyUzk7+7NSBGocSVPQmF+YREsKzG4mjnfk9nQXzG4lEteaMzCgGpnZtiJn8Kj
	FyDyoOzo2cXO65AW6ec0sG2LGO23bHJNk9ezX562q8gfWn4QTQBqEWGIL5X6B2jfYq/cPC0jNh7
	b53MOM6hhc1CS3Q40pOIPGNzJRrB6r5nzm3pLriQ==
X-Received: by 2002:a17:903:1105:b0:2aa:d320:e962 with SMTP id d9443c01a7336-2ad744510c1mr81490665ad.2.1771943359922;
        Tue, 24 Feb 2026 06:29:19 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7180613sm10452132a12.3.2026.02.24.06.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 06:29:19 -0800 (PST)
Message-ID: <f2cb1d65-efe2-48e8-9af7-87f65c8192ad@gmail.com>
Date: Tue, 24 Feb 2026 22:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: dump-tree: add extra chunk type checks
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <56d383400ae8a0ff20b5141baa1ab4068c5603ef.1771798449.git.wqu@suse.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <56d383400ae8a0ff20b5141baa1ab4068c5603ef.1771798449.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21878-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 6F78C1886D1
X-Rspamd-Action: no action


On 2026/2/23 06:14, Qu Wenruo wrote:
> There is a report in the mailing list where a seemingly confused end
> user is passing a physical bytenr into "btrfs inspect dump-tree".
> 
> The best case is that bytenr has no corresponding chunk and will be
> rejected early.
> 
> But if there is a chunk cover that bytenr, and that chunk is a data
> chunk, "btrfs ins dump-tree" will mostly result a checksum mismatch,
> e.g.:
> 
>   $ btrfs ins dump-tree -b 13631488 ~/test.img
>   btrfs-progs v6.19
>   checksum verify failed on 13631488 wanted 0xcdcdcdcd found 0xf9d338a0
>   ERROR: failed to read tree block 13631488
> 
> Note that 13631488 is the logical bytenr of the first data chunk.
> 
> This can be confusing for end users, as they won't know if it's really
> some corrupted tree blocks, or they are just passing wrong numbers.
> 
> Enhance this by introducing a new check_metadata_logical() helper, to
> make sure a chunk exists and the type is also correct.
> 
> Now the error would be more obvious to end users:
> 
>   $ ./btrfs ins dump-tree -b 13631488 ~/test.img
>   btrfs-progs v6.19
>   ERROR: logical 13631488 is not in a metadata chunk, found chunk 13631488 len 8388608 flags 0x1

Would it make sense to use something like `type DATA` instead of
`flags 0x1` in the error message? I believe this would be more helpful 
for users.

Thanks,
Sun Yangkai

> 
> Link: https://lore.kernel.org/linux-btrfs/77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   cmds/inspect-dump-tree.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index 2bc3f68179a5..11eb950dbdcb 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -33,6 +33,7 @@
>   #include "kernel-shared/print-tree.h"
>   #include "kernel-shared/extent_io.h"
>   #include "kernel-shared/tree-checker.h"
> +#include "kernel-shared/volumes.h"
>   #include "common/defs.h"
>   #include "common/extent-cache.h"
>   #include "common/messages.h"
> @@ -194,6 +195,26 @@ static int dump_add_tree_block(struct cache_tree *tree, u64 bytenr)
>   	return ret;
>   }
>   
> +static int check_metadata_logical(struct btrfs_fs_info *fs_info, u64 logical)
> +{
> +	struct cache_extent *ce;
> +	struct map_lookup *map;
> +
> +	ce = search_cache_extent(&fs_info->mapping_tree.cache_tree, logical);
> +	if (!ce || ce->start > logical) {
> +		error("no chunk map found for logical %llu", logical);
> +		return -ENOENT;
> +	}
> +	map = container_of(ce, struct map_lookup, ce);
> +	if (!(map->type & BTRFS_BLOCK_GROUP_METADATA)) {
> +		error(
> +"logical %llu is not in a metadata chunk, found chunk %llu len %llu flags 0x%llx",
> +		      logical, ce->start, ce->size, map->type);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   /*
>    * Print all tree blocks recorded.
>    * All tree block bytenr record will also be freed in this function.
> @@ -228,6 +249,9 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
>   			goto next;
>   		}
>   
> +		ret = check_metadata_logical(fs_info, bytenr);
> +		if (ret < 0)
> +			goto next;
>   		eb = read_tree_block(fs_info, bytenr, &check);
>   		if (!extent_buffer_uptodate(eb)) {
>   			error("failed to read tree block %llu", bytenr);


