Return-Path: <linux-btrfs+bounces-12265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B29A5F7DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756C919C3541
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08702267F49;
	Thu, 13 Mar 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="PzHs8stW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01E267B78
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875698; cv=none; b=jv70oVEzsx3GHcDVS34dCIvV+eD+dacgyUs+hW/pTewGIsTD7vbRiRPjfCNKBTcnaFdR+VbJahb0iRnznW+0u4nNfAaBOwodvdI/fD/hCTTmHzKl6EdZk7BAp4RPwDYnb8ngvV1iQS2qf+KiWioRZVUKMvz6Kc448QmjXJwt2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875698; c=relaxed/simple;
	bh=WpvnsUzxl6gpZMtFBMkL0WHekJbk8BwBrLg5RdPfqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVPpTNzXreifhdLcc4TRR6FFVBKSXHO9RKwpMyM9/2KmoYRKA0/kIctt5wN5EfH/FS/QP7EwTk7TFDh5vFT+5n9kMRUvO29sG+YFl39PZqa1jOVAK4zG3ex41uPIEzkEpiQ8MY9RlGz2Wp2MJC3qsgsRbuGAfimfXqcGe+9diUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=PzHs8stW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso18759925ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741875696; x=1742480496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0tetsoKa2ISM18bfiufTSiFquhBJtIAvJUABcLWCV4=;
        b=PzHs8stWv3CkhdJNpveHIyT2gRaaww2ivWO3szaAoNnaXW3VZqM5ipx/kVvRF3dAaH
         /544wV2IdaBd1jtbzHqClaBAuzz0cbTG77luMTeMzuZV8+Pt90x8A1hqlLMWUcHSnhJV
         36gjVMJy9TW2tBrBszvnHx4ax4OiFXTfSjUW3hGsN+Ip6zpgirewI7yen0E6EURXrd1W
         +mUwZwLsI1hL6E0wZNrFRXeUmgVS8zjP4gHJl3kjRftGqVqIgOn0NRabM7ASFDmiakdz
         ZqsAGAZpWubw/WAgMqcTjkpv24CBEX1jI9J6O6w4xhTZUVTfsN1A5uoZ+0JAABaZeGbH
         Godw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875696; x=1742480496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0tetsoKa2ISM18bfiufTSiFquhBJtIAvJUABcLWCV4=;
        b=ZjNWEFnwGCJBAWbYpn0utA1B+t7Ih1KHeKNiTJxvrecGQQ1pF68n2rqxS2bva1B6dZ
         WeHrGYAokxy1j4PJ58P6j5yRjpVZJmWYMKy8wJsTMurTHSQ6T7udP3JG1BglNfJAbDM3
         4JShsTjxb6beJmYSpiGN6CeoNn5cAwEO8kdIaaeSyWBJnGaW6yOZl4ejHJNwOhwMtXnP
         xVfDKVt3nIWdXs7Zu+KsM+fSkSr91A898P05u4PPR99HnFttCFOaUGsXlDi+zYUznMi8
         hTIp06lFIxANoZjv0U9ZF7iun2mPs/DFZ9oEMH4BDw2ABkYBvt9LBBWxid22TojJntaA
         Y6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEIg9+lOIwENqrdBnlPjKoVZfVpKV66hzyNPs/lmHdxbsNdMfiZ7Q+05XRavpSYJtN0f3m6MlKcAk6cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFeIYV5u6y9XQU/bS+in8qG6FZeWU9yN8EQe6QuYuBgV1bHT58
	YjC+WuoIbMRqdvREAKF300PHdZBS7EIPGK+XffMc6VhFDm/s/BvEldKP44HDRpk=
X-Gm-Gg: ASbGncsCIfdhYMJLqtOtX7Euh+gvCX8J/5VCR/tG2O5JHdmSVI/Fm2WD9jnYINhdS+I
	QleB8G9o7KD6IJYnlMtozy2jMpwLKVWU+7+LEdkRkKvk1h3YXxw4QC9GH7bnbmxSO5JTgSkB+Ap
	agYTgs0HzIhhA1f+p5EdBxVeiO/GXv5vixadxSblht7V3WSnMwOx735xHzrlz5BtnblPhYlyXbh
	nlrpwzyyKcKrp/leZ96L0fM9K91kXrfmo+CZoBjCfHlgB7QWKoGaEUsO6hSx1awCkUsocrQdVWO
	V4b/kh1zqLqG3Wl4xnuBBpZia/6ez5N6O2tIQDr5jN2GulDtGXwC99mMvkRkmXYXWm8tNMzvFWW
	rIQIh5A==
X-Google-Smtp-Source: AGHT+IFrm0PyIULGxF7uMa1YAcLldt1ymHl/9crA3Otf7vM1iRhdF/1Q7ffqxaW5uccJLGntcMfu/A==
X-Received: by 2002:a17:903:283:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-2242888bfe4mr406203255ad.14.1741875696042;
        Thu, 13 Mar 2025 07:21:36 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe77csm13577465ad.194.2025.03.13.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:21:35 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:21:31 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9Lp60B4o2Y3AzhD@sidongui-MacBookPro.local>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
 <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
 <95529e8f-ac4d-4530-94fa-488372489100@gmail.com>
 <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>
 <Z9Lj8s-pTTEJhMOn@sidongui-MacBookPro.local>
 <ab277f0b-fdf6-4f20-9fe0-0e0a1ebcc906@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab277f0b-fdf6-4f20-9fe0-0e0a1ebcc906@kernel.dk>

On Thu, Mar 13, 2025 at 08:01:15AM -0600, Jens Axboe wrote:
> On 3/13/25 7:56 AM, Sidong Yang wrote:
> > On Thu, Mar 13, 2025 at 01:17:44PM +0000, Pavel Begunkov wrote:
> >> On 3/13/25 13:15, Pavel Begunkov wrote:
> >>> On 3/13/25 10:44, Sidong Yang wrote:
> >>>> On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
> >>>>> On 3/12/25 14:23, Sidong Yang wrote:
> >>>>>> This patche series introduce io_uring_cmd_import_vec. With this function,
> >>>>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
> >>>>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> >>>>>> for new api for encoded read in btrfs by using uring cmd.
> >>>>>
> >>>>> Pretty much same thing, we're still left with 2 allocations in the
> >>>>> hot path. What I think we can do here is to add caching on the
> >>>>> io_uring side as we do with rw / net, but that would be invisible
> >>>>> for cmd drivers. And that cache can be reused for normal iovec imports.
> >>>>>
> >>>>> https://github.com/isilence/linux.git regvec-import-cmd
> >>>>> (link for convenience)
> >>>>> https://github.com/isilence/linux/tree/regvec-import-cmd
> >>>>>
> >>>>> Not really target tested, no btrfs, not any other user, just an idea.
> >>>>> There are 4 patches, but the top 3 are of interest.
> >>>>
> >>>> Thanks, I justed checked the commits now. I think cache is good to resolve
> >>>> this without allocation if cache hit. Let me reimpl this idea and test it
> >>>> for btrfs.
> >>>
> >>> Sure, you can just base on top of that branch, hashes might be
> >>> different but it's identical to the base it should be on. Your
> >>> v2 didn't have some more recent merged patches.
> >>
> >> Jens' for-6.15/io_uring-reg-vec specifically, but for-next likely
> >> has it merged.
> > 
> > Yes, there is commits about io_uring-reg-vec in Jens' for-next. I'll
> > make v3 based on the branch.
> 
> Basing patches on that is fine, just never base branches on it. My
> for-next branch is just a merge point for _everything_ that's queued for
> the next release, io_uring and block related. The right branch to base
> on for this case would be for-6.15/io_uring-reg-vec, which is also in my
> for-next branch.

Agreed, for-6.15/io_uring-reg-vec is the right base branch for this. 

Thanks,
Sidong
> 
> This is more of a FYI than anything, as you're not doing a pull request.
> Using for-next for patches is fine.
> 
> -- 
> Jens Axboe

