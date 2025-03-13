Return-Path: <linux-btrfs+bounces-12263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00403A5F709
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 14:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3E1898A32
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E6267B6A;
	Thu, 13 Mar 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="Qe/3eXMb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB8267AEA
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874172; cv=none; b=cNvByI7gZtLwn2GN4JWsWYT73VkhOzHfikKSw54PGE9yGBujfoK0w0GqHeqm/yNXjHBIleByXzL7UU4WZHrvX8C33tOSSiGq0ZDIjG+9mH1T1WRw9ayRJZSwBLgJNf3yftMwWk7OgSPXeW2LDvft645S1ty+5YaXKf8JdGQD/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874172; c=relaxed/simple;
	bh=OXZwBbGFVEFD60c57eDI5cj9JWNWhkxbptmsSKbkSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA/Y53efoAw52ow3fJaX8yjys1tCts+Pht3SmFSdZ85GhMDeUKlGHQXKyYuYgifu/01bqXc8n/hDI3IRmyB6VGL1rBaz7sqbJDSw/Uys+7TWnp+/oy0Qwc+FKVjZihQZDENhQr9WcBBSX14Gf/kzAAEHEqy42YUBpsYhKJVe6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=Qe/3eXMb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso18417435ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741874170; x=1742478970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJWf+2Kk9KeIZXFG3cJ7oE/X0yoKG+h9t1wBj4fhOuw=;
        b=Qe/3eXMbVcP6ytBYJ76iyF11ZFTjzxBwTRc09YSXvuRg1IYxHKQgV14nktetSYpSH7
         adaS39IwuERhNLr8a3010uqOF/ybTM2gXqB3OPhSOH16cHJ1N4Wak4de26b4imXn8dpF
         T6z7cDBgj4ZWNP2DJzvUoVzYv7KUpukZTewf1HR9j7GW7VgbD7WYqzlzcOXllKG070QI
         r4hVG4okhyBmRCTh4TWudn4gX0zAIjmvDQxG/fSCo3ZSm3tLHGmZSLs6FZMuKcBZznq2
         SxoxHJZBOAwkBtH8O0gsnm4YdLhiimO5OPLztXLM57gvqyNLgFwE+DJ7jjbOl575Np6/
         CCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874170; x=1742478970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJWf+2Kk9KeIZXFG3cJ7oE/X0yoKG+h9t1wBj4fhOuw=;
        b=FMh/C9dZHuaQtXsc47WvSlXkNlNzgs5EfnSa4bUT82Uzce6tNICVXp2g8qzwrcnRBz
         akgzRvygNbb1v1y5r+7+vgq359q3vps7eevkiV8/zFsgO/DekNjJUs1v1s+uOoof3033
         dh9it/RXZCdKAL0Lm97JSISiDYki1op8ZraXc0mPUgbktt88qgcaGH76vglX7eAvWc7y
         DZ/8L3+J7diKd9UaKmbmKrYSRI+5sUQi4OWQ9pmuil6Ofnv/qnYaG0tLE3U14kuK02eg
         HQk80aeLp63fWyIt0CJ7Lv2YEUHuUze5b3JQGijdJEqvrKYu3UjekqM7xmZNtOZbFCf7
         2AWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXRHia3ZSG5ZU9uQZA1cCjio9zvbqpM+TGLgCr4LDXV2VMS2zOqXuspMu2YVeaCdZrIg6oYV8nsiLsPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsq3/i4LGLLSW47hJ8hbuS9FD66PiTcjpBLZeMdseVE3SB9tn
	OGbnedXOfG5Z58Ub8rQuEhWivRhy+j5UZenhvnlTOuCVjqYHzE/IqLfo1jWn06o=
X-Gm-Gg: ASbGnctz3ra3Hf3GOv/ZJpt4M8eOtBFBETU426EMkgm1r4qjzcdcdO2MuXJbmATMKjH
	jIIPVgb/Im/AnmdaL8opWCPWH6oqusoyL6hJrcMqYlAmtQ11rTfiFh1l0ek2rzGHhZ+6sZiEOq6
	jhcEms4bqHqILsv5Y4yXV7+34UtLWRlgkc/UdlrJUyrhjRAv9rg5F5yf0G+b4G0hA5YYXCpFo1X
	TwZU8ZGiDlglt3eTZiX8j0n4sXVKzceBs67xsJQmOd2Xr2JFFOYRzMDJm1JrKRy0GSIq84/m2nx
	I/KbZOd3hbpmyD1UpLYupeZlkIj9/+/0I1issrzH/GY5lRLJ1PSZQETzgK4JGe3PFLuEvfmdY9L
	D
X-Google-Smtp-Source: AGHT+IEaZvgrjYn2hacXxym8AfVHesqurCWdjoDGFqV63N73+ZMsWJUmVSIvP/Ou4EEvrvg7tRtGpQ==
X-Received: by 2002:a05:6a00:6c96:b0:737:9b:582a with SMTP id d2e1a72fcca58-737009b5927mr9817205b3a.24.1741874169929;
        Thu, 13 Mar 2025 06:56:09 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152948fsm1365507b3a.16.2025.03.13.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:56:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:56:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9Lj8s-pTTEJhMOn@sidongui-MacBookPro.local>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
 <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
 <95529e8f-ac4d-4530-94fa-488372489100@gmail.com>
 <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3264c8-02be-4634-bab2-2ad00a40a1b7@gmail.com>

On Thu, Mar 13, 2025 at 01:17:44PM +0000, Pavel Begunkov wrote:
> On 3/13/25 13:15, Pavel Begunkov wrote:
> > On 3/13/25 10:44, Sidong Yang wrote:
> > > On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
> > > > On 3/12/25 14:23, Sidong Yang wrote:
> > > > > This patche series introduce io_uring_cmd_import_vec. With this function,
> > > > > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > > > > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > > > > for new api for encoded read in btrfs by using uring cmd.
> > > > 
> > > > Pretty much same thing, we're still left with 2 allocations in the
> > > > hot path. What I think we can do here is to add caching on the
> > > > io_uring side as we do with rw / net, but that would be invisible
> > > > for cmd drivers. And that cache can be reused for normal iovec imports.
> > > > 
> > > > https://github.com/isilence/linux.git regvec-import-cmd
> > > > (link for convenience)
> > > > https://github.com/isilence/linux/tree/regvec-import-cmd
> > > > 
> > > > Not really target tested, no btrfs, not any other user, just an idea.
> > > > There are 4 patches, but the top 3 are of interest.
> > > 
> > > Thanks, I justed checked the commits now. I think cache is good to resolve
> > > this without allocation if cache hit. Let me reimpl this idea and test it
> > > for btrfs.
> > 
> > Sure, you can just base on top of that branch, hashes might be
> > different but it's identical to the base it should be on. Your
> > v2 didn't have some more recent merged patches.
> 
> Jens' for-6.15/io_uring-reg-vec specifically, but for-next likely
> has it merged.

Yes, there is commits about io_uring-reg-vec in Jens' for-next. I'll make v3 based
on the branch.

> 
> -- 
> Pavel Begunkov
> 

