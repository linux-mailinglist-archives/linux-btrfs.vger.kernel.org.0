Return-Path: <linux-btrfs+bounces-21090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W6v4FD4BeGn/nAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21090-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 01:05:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DE8E622
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 01:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7E723006930
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E11EAC7;
	Tue, 27 Jan 2026 00:05:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B64414
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472312; cv=none; b=omZ0uB6TthGWG6C33EPDM9++NIXNJBhBkW1A4LlxRu4fQ4O/sCZzeCi5w2P6ZwtEEZE+TDxk+OA4A3j1g3tUe8bbXZzFmL8bfcytPjzE4xLoGhnE5Qa9zvvnkpSgsXhOG14pITgE25McEkLyk9q9QPvkwt3BGDwLOsTVYLW5NXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472312; c=relaxed/simple;
	bh=Yz7Mh4mYsX1FcU37gND/UpgfuOne//gJBXLrSzLANE4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fCIeebnGfHrYUlJQUelwew3XjO7eXooA16wCgPUKpkJn7VlqbRITZj81RlIPIJyK9tSavlN3ycGKfIajJH2TMEvzGb//+OVvrbiXvWsPUD2SQJtV+UUUEdirN+3mbFWoUo2wZDw59FlAlD74KFEzT0vosOdS4Mq0JKVCzwu1zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.gGjKBoL_1769468639 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 07:04:00 +0800
Date: Tue, 27 Jan 2026 07:04:01 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v3 3/3] btrfs: forward declare btrfs_fs_info in volumes.h
Cc: linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
In-Reply-To: <4c839922e88a33145eca264394ff8aab08c0a871.1769447820.git.boris@bur.io>
References: <cover.1769447820.git.boris@bur.io> <4c839922e88a33145eca264394ff8aab08c0a871.1769447820.git.boris@bur.io>
Message-Id: <20260127070401.327D.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.83.01 [en]
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,e16-tech.com:mid,e16-tech.com:email,bur.io:email];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[e16-tech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21090-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 611DE8E622
X-Rspamd-Action: no action

Hi,

> Fix the build warning:
> In file included from fs/btrfs/tests/chunk-allocation-tests.c:8:
> fs/btrfs/tests/../volumes.h:721:53: warning: ¡®struct btrfs_space_info¡¯ declared inside parameter list will not be visible outside of this definition or declaration
>   721 |                                              struct btrfs_space_info *space_info,
> 

Could we fold this patch into the patch 2/3 which introduce the file of 
chunk-allocation-tests.c?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/01/27



> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/volumes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 8cb72e84dc84..ebc85bf53ee7 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -30,6 +30,7 @@ struct btrfs_block_group;
>  struct btrfs_trans_handle;
>  struct btrfs_transaction;
>  struct btrfs_zoned_device_info;
> +struct btrfs_space_info;
>  
>  #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
>  
> -- 
> 2.52.0
> 



