Return-Path: <linux-btrfs+bounces-6045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F066E91C480
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976021F22632
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660281CB327;
	Fri, 28 Jun 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="JF7fsQaR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE551C9EBE
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594530; cv=none; b=JGWAbL8DIEIEzA/APEkiwGC+UDsZsixCUoMVnFEWZCBz37BHun8IESS57PrPdhKtkgVTkNI/58zKoiDnYiARYl5f1OBW0LBZ5/+zH82hH1JYa3o/xQwRbnrlxlyQjy+RXvfKBsefSzTIjTlihq4AnmubKPRxRtNcq+vlFVzZp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594530; c=relaxed/simple;
	bh=2GgiU93DC7BYUxZeNoJSCwEtpwvuxtTmv8gOBon7854=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj5xHNBt0c1mGtHXrp4yGptYtoD5I0RTMhe/w4oZmoiUfUWkSpKafJnWDv5pKngtaN+wbQwdF+CtYd0sQxSmavjcIKasxCv77G5hmD1Nf62YiYKVpqVopRE0F2sPI6K4BWCbtcW3CCFk8dVXcRK01QH/NN4rzu+LNlTeSRscQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=JF7fsQaR; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id NF32scyaXVxa0NF32sbfq2; Fri, 28 Jun 2024 19:06:08 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1719594368; bh=5rJpI4muRnR37cehTaZnWzz8aKuBkVf450uNIu7mzZw=;
	h=From;
	b=JF7fsQaRAg9WfySWJBhBKvzNJCLlInUJCmcJjnvW9IZkGguH4T9L9oUc7NJhADNE4
	 6npfZGHRFy6LrM78M3gB88MJxxtbt6BghUWapM++bjc+TsS43B8RsGWAldBF/X9Ab8
	 psYqavgWZRZcSYrpUXq5NaO5qQ3SSElWG5t6vj7gTbLjxNsPT0cKJNsdMAdMD1a4OS
	 73zct53rMlDISFzdvQS65W6d+6xZsrSROAya34guN9aZQOkxpBim+gq3VqME8VEPk/
	 gGFUFYUZbIiFlR/qESdxGulN3OZcNsGGxA41V7W2gVLkl7yoOAr6hO1wPV9+hsQxrw
	 2y3MuIbmzsnyw==
X-CNFS-Analysis: v=2.4 cv=c89gQg9l c=1 sm=1 tr=0 ts=667eed80 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=VabnemYjAAAA:8 a=kE-lTLQdLfSRi6_233AA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
Message-ID: <eb3642fd-963b-4a14-9cd2-8339adcb58b7@libero.it>
Date: Fri, 28 Jun 2024 19:06:08 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>
References: <20240627095455.315620-1-maharmstone@fb.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20240627095455.315620-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIASC3IC46gPsTYtcPU4hvAPCuUyrxIPyro06sun3UcOPAjrtCyqGMN5mmIL7e3kpCKY/pIo8DV/tk9gsm1fYlxxtGUpMrn9N14hwGHaY/EMmWNr6o+m
 iHjpUu6IApWY6CupVaFXHG7ZrdRtWuApwx/z7txljiGcBU62DQO/u3mSuqkcdyDPYUFt7SnZVMvP4SpDT5SLJEDUHqBGlJAR5i7Jl+i6pz6nzgg05nDxZHs4
 bd/mj/FJzCMnLlRlbzyRhg==

On 27/06/2024 11.54, Mark Harmstone wrote:
> From: Mark Harmstone <maharmstone@meta.com>
> 
> This patch adds a --subvol option, which tells mkfs.btrfs to create the
> specified directories as subvolumes.
> 
> Given a populated directory img, the command
> 
> $ mkfs.btrfs --rootdir img --subvol usr --subvol home --subvol home/username /dev/loop0
> 
> will create subvolumes usr and home within the FS root, and subvolume
> username within the home subvolume. It will fail if any of the
> directories do not yet exist.
> 

Could be possible to decouple the "--rootdir" and the "--subvol" options ?
I.e. doing a first iteration where only the subvolume/subdir are created and a second one where
all the subvolume are populated.

The use case is creating only the subvol without --rootdir. My goal is to pupulate a btrfs
filesystem with a"root" subvol, and make it default. This to simplify the next snapshots.

Until now the subvol=0 is special because it can be snapshotted, but it cannot be deleted.

Having a / in a default subvol, could simplify the filesystem snapshot.

Otherwise, mkfs.btrfs can create a (temporary) root-image with the minimal directories needed...
but it seems a bit overkilling.


> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
> ---
>   convert/main.c                              |   4 +-
>   kernel-shared/ctree.h                       |   3 +-
[...]

>   
>   	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
> @@ -2076,6 +2406,18 @@ out:
>   	free(label);
>   	free(source_dir);
>   
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head = list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->fullpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +

Because it is called more than once, this part can be refactored in a dedicated function:

void free_subvols_list(list_head *subvols) {
	while (!list_empty(subvols)) {
		struct rootdir_subvol *head = list_entry(subvols.next,
					      struct rootdir_subvol,
					      list);

		free(head->dir);
		free(head->fullpath);

		list_del(&head->list);
		free(head);
}

>   	return !!ret;
>   
>   error:
> @@ -2087,6 +2429,19 @@ error:
>   	free(prepare_ctx);
>   	free(label);
>   	free(source_dir);
> +
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head = list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->fullpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +

Same as above

[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


