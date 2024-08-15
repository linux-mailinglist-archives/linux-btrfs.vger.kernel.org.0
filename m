Return-Path: <linux-btrfs+bounces-7214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88E953968
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3093B22BC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF10C54656;
	Thu, 15 Aug 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmP5mn5J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D23EA76
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743940; cv=none; b=sLOV+TGAcKq9S/YNlnrACeJ9qHmMZQ0Zuen5SF8Pn9NbOr4hWUZiy6dI6mRrhmKKKygY1bO1XgDFRbuS2otfZSLf0bL1BMhNhG9E7U8GC9TvCwJUwshtJg30YjE/qbQxFrDAUu4Rs29VqmV8LXM+oBuZ/ZfY6f7bMVkxAkT1txM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743940; c=relaxed/simple;
	bh=dh0sdv0xgHcDD/3YvVi7uvPo86Cfz6IKMIGx76Fl5G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FRLbCZFyajeuc3u6yU4ZyjKhKQYJnBDr/KI4sS4fTsKcYR2gwBTDuCiGk7IquW7lU3+5hfEU73PDQBJoaesHuz9AkXiUNHd0H22yqJIT0+dffqz/EgeX09/T8eTyc/62/DUchT1LkMX92fkG8LfAGRSsu35jbJ7iOzwVT0nYRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmP5mn5J; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5d5d077c60aso659914eaf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723743938; x=1724348738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EK8GeEJOAuTu7HqhYyR+w6PoZO92G6Wh26vpRlq9ifQ=;
        b=PmP5mn5JulMqO4t5E3MXlfG5M6I/SfJzxH/sEuqevQgHuNEaOQb6y8ojvnIcjyRZZi
         rAw5RRsihMknDoTTeLvwVuZXJrrCqTI8r0axQN80Q8ia2Z9cn9wOOXHUZAG4Anr31f8e
         GOf133D3C0gCYyM/shfseCALPRU9vV1ncanzIcGM9ezf2Pm58QQJu6Zx87S2uGvw+R8E
         4FI4S4w4l3PUDEmxsBp67zJJA/d8Vratman/oB24PAV0LbJUNJHI833NZDsKI8uZ6GbX
         t8jpaHrDzjZgrxzLOIxtbhq290cPFcRxmb7dbl0FdSSYBJC0n93aXIypp3vvGz1ZdRE8
         o7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743938; x=1724348738;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK8GeEJOAuTu7HqhYyR+w6PoZO92G6Wh26vpRlq9ifQ=;
        b=jF7lsE2i7Hu7tOsd6TVUwoiuvWBzzGrp+A5dliDpcmFLZetLHlO31doUJdfCDDm1MF
         UzOzUpzs7febyU4nfvdX3cAFKWvqUAy5TLXKO0alZ2s22mbQJ3LeC2R16WGZVjfYxYrc
         2nnvzWCoZPgbctyyvghIT8MzQfkSYB8/hfB1/77tH7Zh2B9L+g2+vSKIiQ3/JTeA64W/
         WvlpGTe4+LMIdINKoxmq0V+lp86nOOJvP9NvL/kl4BjPJqyOWyNIjXOw33qmOWpB5Gw2
         9pX8qZlmHdBy2JQWWX5BlndYWBadJcGUJjYWgauxriDatxEj38iUb/F7ZcEIVKufmazT
         fMcQ==
X-Gm-Message-State: AOJu0Yx3ird0CL1NrQpkDzQxqVKlWvqQoACJfqZ0F5EkBvW9wyrzgAXi
	4Ea8zNyofVIR367OF71NpLr+SNw6P9u5J8sqS01OgDz6A+cCcIKHQ/XrYetN
X-Google-Smtp-Source: AGHT+IENVL++8o/jz93WtZ3AFZvCh9VIZM4ji4sprKIL/JmlxgCQn2epU/aMYu0u5ORm1hM3KiaaAQ==
X-Received: by 2002:a05:6820:2212:b0:5d8:750:21b with SMTP id 006d021491bc7-5da97f54c7dmr775531eaf.1.1723743937605;
        Thu, 15 Aug 2024 10:45:37 -0700 (PDT)
Received: from localhost (fwdproxy-eag-003.fbsv.net. [2a03:2880:3ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cda16b6sm342753eaf.15.2024.08.15.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:45:37 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:38:24 -0700
From: Leo Martins <loemra.dev@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: add __free attribute and improve xattr cleanup
User-Agent: meli 0.8.6
References: <cover.1723245033.git.loemra.dev@gmail.com> <20240813212903.GS25962@twin.jikos.cz>
In-Reply-To: <20240813212903.GS25962@twin.jikos.cz>
Message-ID: <i9tc0.0f867os9viy6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Tue, 13 Aug 2024 14:29, David Sterba <dsterba@suse.cz> wrote:
>On Fri, Aug 09, 2024 at 04:11:47PM -0700, Leo Martins wrote:
>> The first patch introduces the __free attribute to the btrfs code, allowing
>> for automatic memory management of certain variables. This attribute enables
>> the kernel to automatically call a specified function (in this case,
>> btrfs_free_path()) on a variable when it goes out of scope, ensuring proper
>> memory release and preventing potential memory leaks.
>> 
>> The second patch applies the __free attribute to the path variable in the
>> btrfs_getxattr(), btrfs_setxattr(), and btrfs_listxattr() functions, ensuring
>> that the memory allocated for this variable is properly released when it goes
>> out of scope. This improves the memory management of xattr operations in
>> btrfs, reducing the risk of memory-related bugs and improving overall system
>> stability.
>> 
>> As a next step, I want to extend the use of the __free attribute to other
>> instances where btrfs_free_path is being manually called.
>
>Hold on. Adding the automatic memory management can be done but in the
>example patches you sent it's IMHO making things worse on the code
>level.
>
>The btrfs_free_path (or btrfs_release_path for that matter) are not
>simple free helpers but also part of the b-tree locking primitives,
>pairing with btrfs_search_slot and nontrivial semantics depending on the
>various setting flags.
>
>Dropping the explicit marker from the code is obscuring where the
>locked section is.
>
>Another problem is that this will make any backports less obviously
>correct from releases that use the __free attribue to older kernels.
>
>In the second patch in btrfs_setxattr() you removed btrfs_free_path()
>but there's still some code after that. In this case it's harmless and
>only slightly extending the section covered by path, ie. just by a few
>instructions, but this won't be always possible.
>
>In some cases the placement of freeing the path unlocks the tree so it
>has a strong reason to be there.
>
>Overall, we could the automatic memory management, although for kernel,
>for me, it's on the same level as trying to use other fancy C++
>features. We could start using __free in new structures so it's used
>consistently from the beginning and not mixing two styles namely when
>not all instances of btrfs_path can use it.
>
>In justified cases the auto freeing may make sense but not at the cost
>of making the code confusing about the pairing free or extending the
>locked section unnecessarily. The btrfs_path is not a good example where
>to start with that.

This makes sense, I will drop the xattr patch. Do you think there would
be any benefit in using the __free pattern in situations where it
is clear that btrfs_free_path is the last thing called before returning?
For example:


int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
			  struct btrfs_root *root, u64 offset)
{
	struct btrfs_path *path;
	struct btrfs_key key;
	int ret = 0;

	key.objectid = BTRFS_ORPHAN_OBJECTID;
	key.type = BTRFS_ORPHAN_ITEM_KEY;
	key.offset = offset;

	path = btrfs_alloc_path();
	if (!path)
		return -ENOMEM;

	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
	if (ret < 0)
		goto out;
	if (ret) { /* JDM: Really? */
		ret = -ENOENT;
		goto out;
	}

	ret = btrfs_del_item(trans, root, path);

out:
	btrfs_free_path(path);
	return ret;
}


In this code the behavior would be the same except it would eliminate
the need for goto out as the path is freed automatically on exit.

