Return-Path: <linux-btrfs+bounces-7595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128D961A2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F1E285044
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2371D416C;
	Tue, 27 Aug 2024 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cou54qAg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB464A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799572; cv=none; b=FmVb/g6A672BrXo3gOEkUkampk88HnYB+3uK6rapl/rIY7+qjcuJJ1n9oeFyEljjGx+BK1S2JB+E0bN0rMLQg97y/anML3UcyIHsolHlXlYYCUglN6xEDSwf/aaYnB8z0xSGA0ejhCDsovga/Ms/638UKzIRJm69Y2ge4AXdpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799572; c=relaxed/simple;
	bh=NdzwYrjoflo4oQWFnaFqYnryZCYdYHYTYHFrkdSSob0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gz9IMMkaRC+/UE9BR1f2oew9FlH4GY0lwefE3x5ivriTSva7mScH7HNS2pvaQi27TAhR9jLJtWbnijQ0fnkbAcDm/Az7p7zWzTZqtLmWO3KifMjb7WfqJoG8bTL4pLs502sOrm8N+xJ7334FmfWq/211r/JzJREgp9EG/MokkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cou54qAg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371aa511609so3014308f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724799568; x=1725404368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FBHD0KQJlBT9EYDf9CyqvuDB7M7twHKAIttGW0Glgzo=;
        b=Cou54qAgz/FIrpuTQsZiSR3+GrjObAWC39HLc9rjqFNy/B6Pv3rc6dHqJUCHQoeskl
         aUyYcueMr/X7Jz3Mu8bWZ8DB2/Br8UIpw0TLxngrDbuSMqEMONcevcSWyXDEqZW6ZMbd
         JgzEGKwWs6qyYnUPRuASmTVcXXmyKOWbHZHoDuGH/RjX1OCFzeW5dacCw+1hYyQSRot2
         8effrPr4CGof5MuxibS/w1BX99R9RgLAvMVLG16atm4XMPpsDLoCYKfuVXL+aUN2ycPQ
         rDY7o3/VrLCaNhAEhK4mJpGUxS7aXirJUv6gidjfndB5PvYYi0ODT5+WSYvmGY4ivMcW
         Nd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799568; x=1725404368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBHD0KQJlBT9EYDf9CyqvuDB7M7twHKAIttGW0Glgzo=;
        b=xS+5yYrXOlvJc4bA/Zuz3zjmw67w4RNLKr6y0G31D58jFdPZOxz+3DHlLELsWcx9ou
         pm3jhjk4Em4OQzIJBtGL5QWiYnNGUfBegBODQvrHEjk8qJltiOAq80+R784/WZCrduxj
         kMcoF55c2yWMzPtaBDJJ4SO5EoUuzgpTfB15OY0wX5f+OVanUMIHOd2mEjq/0HEFuIQK
         KX+3N2eoM1rlSxYUpNRvtRxVjLI+3bfNI3Bj96BZuYVN9U2o1V1yvt7zsJKIzvviEX4j
         Jh2NwSkh6wRjVcG/D0FQ1+Mcc24t4zElekY/yIMJ/xI3FNBLESrREDTSHPbSLuH81Xj5
         Nqew==
X-Forwarded-Encrypted: i=1; AJvYcCUndxGTi0ipVA1RK/HJW1iSO9qiQg4l6hDSN+EhUBXgf1TMpULxojTizFNUm6l0NP86nJsvCaPUpw8W9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSSsggRQqzUyM8XD7XKbmqxeuGO3ympSTqzjCVsTJhHfk+dM+
	zTvt/VHSqr4wsZIErANz05ZhOIofhpHWyBmiQr/WDh6Cf8IViJaUC2bN5USZitw=
X-Google-Smtp-Source: AGHT+IFKwuNGuBuWlM5bkVYQFRefWgHXU63ZryeVdkNlk7bYPZJsOwR1CFlviePY2ptFBIMm0xHViw==
X-Received: by 2002:a05:6000:108d:b0:368:3ee5:e3e1 with SMTP id ffacd0b85a97d-3749680da42mr63025f8f.7.1724799567723;
        Tue, 27 Aug 2024 15:59:27 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557ee79sm88662225ad.82.2024.08.27.15.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 15:59:27 -0700 (PDT)
Message-ID: <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
Date: Wed, 28 Aug 2024 08:29:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] btrfs: clear defragmented inodes using postorder in
 btrfs_cleanup_defrag_inodes()
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1724795623.git.dsterba@suse.com>
 <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/28 07:25, David Sterba 写道:
> btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
> or unmount, but the way it frees the inodes in fs_info->defrag_inodes
> is inefficient. Each time it needs to locate first node, remove it,
> potentially rebalance tree until it's done. This allows to do a
> conditional reschedule.
> 
> For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
> convenient but if the reschedule happens and unlocks fs_info->defrag_inodes_lock
> we can't be sure that the tree is in the same state. If that happens,
> restart the iteration from the beginning.

In that case, isn't the rbtree itself in an inconsistent state, and 
restarting will only cause invalid memory access?

So in this particular case, since we can be interrupted, the full tree 
balance looks like the only safe way we can go?

Thanks,
Qu

> 
> The cleanup operation is kmem_cache_free() which will likely take the
> fast path for most objects.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/defrag.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 41d67065d02b..bd1769dd134c 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -212,19 +212,18 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
>   
>   void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
>   {
> -	struct inode_defrag *defrag;
> -	struct rb_node *node;
> +	struct inode_defrag *defrag, *next;
>   
>   	spin_lock(&fs_info->defrag_inodes_lock);
> -	node = rb_first(&fs_info->defrag_inodes);
> -	while (node) {
> -		rb_erase(node, &fs_info->defrag_inodes);
> -		defrag = rb_entry(node, struct inode_defrag, rb_node);
> +again:
> +	rbtree_postorder_for_each_entry_safe(defrag, next, &fs_info->defrag_inodes,
> +					     rb_node) {
>   		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>   
> -		cond_resched_lock(&fs_info->defrag_inodes_lock);
> -
> -		node = rb_first(&fs_info->defrag_inodes);
> +		if (cond_resched_lock(&fs_info->defrag_inodes_lock)) {
> +			/* Rescheduled and unlocked. */
> +			goto again;
> +		}
>   	}
>   	spin_unlock(&fs_info->defrag_inodes_lock);
>   }

