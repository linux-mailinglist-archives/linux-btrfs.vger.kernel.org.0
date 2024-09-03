Return-Path: <linux-btrfs+bounces-7792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53696A351
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C66282BD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D20188929;
	Tue,  3 Sep 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="maVIZxOF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EF18859E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378647; cv=none; b=fgR5IyxN7wCRqtMUFmNs4r5TknyK4FiFFD4yJGx/q24CgupABKNJKJ9VtQzBQTCSGDlTSDMlQ4mTiMUlodNo82lFo2Fbs0uyJjHzwATonTnV2GCe7pz5mthbp1ryUbUpzHf1pOpMsMkY8dpcXDh8Ds4W4mzZnmiZFliTaeKuC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378647; c=relaxed/simple;
	bh=rHCaYRQ3lT3pa8vfNirHSbOjA6zCvS2POPgP29MBz3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQdHu3oDvvNWdpaZxFHFTz7jtxwod6yU5X6CifeWuHYTNY/9DYgDutd9d8JTiGtsrYQcUs59FUHVaCZMf0gFGVfWoyCFPzDlko+XYcWS22GAd+m/s4kMLDXu0eyi8MRr5kyI0CeMP8rnB/lriBmZtSJ7VcMQywgQfkz7nAcqUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=maVIZxOF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso2813571276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725378645; x=1725983445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7qnM8q1c0w9kirjZVQKjB3/n+YUpwmvAEeIVjnk6VQ=;
        b=maVIZxOFHxMbbuL4eU9RfWIJK2m/XflMp/QNnZRZ4ywy/f8BPerCOCHnVE9layrU53
         1h0LKbDlJs6G6j5nLViUrN91CXTyJ4A1Uw84ZERg8yADNXVcKeWlYW/1hO9pmRRDc2c7
         vRxtomHhRD4qPgIDkFJCoyaFAHlqPuBHSrWEye7kcXVsTJQqvB+ehgGP2AF6oda/FBNC
         iyR38uXwsXkrzqkEHQieKEOHco+4aFV8kqqklzYZRRcAnmp3of9u8SUg92w3se/GI+B1
         K3oJ5zX3QK++zDtZy7QDy8cvRlb7maDNgXv7ba0UMWOgz7yUQtoLz5M6UbgH28lN6JQ9
         G52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378645; x=1725983445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7qnM8q1c0w9kirjZVQKjB3/n+YUpwmvAEeIVjnk6VQ=;
        b=Qr26pfPAcsgoWBohHbKZ8Al7po6srAgxfeqytcdhmcNusR8nxd7yK3Ham2sil9wAfN
         ziqBI9luaWbn2wuYADvGyw8j3C2p0p7s/xGch42q6ios9DXFtdYnCtrCDUGFfMiwX8+Q
         OsjzO08fitZGYEg0FJfysFvY+7i4t9JjXzRIU9v+fCp0Vza/J63rC8UAFrvnZpgDXIjp
         31FJcx77zYcw7RwTvHA10LkxGJ5k+w8TI+djqDQqsIdB4YlCMeX9cAYkn+L40oLOirmH
         EaPmE36fGCZTVE9VqjzVvI+3a0l0oCvVxpSGCZwmGDK3E18EoY+G8zIdaMdiTMcXx8Yg
         DJfA==
X-Gm-Message-State: AOJu0YxhbwDl5ZGyyQIbC+4uNLBpN8qdfQv750jtorAeCEp9ReSCvUPk
	wda41g8u8M3yKUknMIu6wcmqzmEoezcr5gA+ssBR/0xFhuubeiOg22UWb6tcpXs=
X-Google-Smtp-Source: AGHT+IF9085Lcd7TFbfrNqRXT+kATcoNDkmyxcMucIMvWB3wFYJEXM7fCuEblaYEyPPzkeHEaJdjkw==
X-Received: by 2002:a05:690c:6703:b0:6ae:528f:be36 with SMTP id 00721157ae682-6d40dc7b873mr181116927b3.12.1725378644805;
        Tue, 03 Sep 2024 08:50:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d5b5fc3e1asm11836737b3.40.2024.09.03.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:50:44 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:50:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix a regression with concurrent DIO writes
 and fsync on the same fd
Message-ID: <20240903155043.GA3354361@perftesting>
References: <cover.1724972506.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724972506.git.fdmanana@suse.com>

On Fri, Aug 30, 2024 at 12:09:35AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a recent regression when doing concurrent direct IO writes and fsync
> using the same fd from multiple threads. This was reported recently by a
> couple users when using QEMU, as well as syzbot. The fix is the first
> patch in the series, the second one is just an improvement for some
> assertions. Details in the change logs of each patch.
> 
> Filipe Manana (2):
>   btrfs: fix race between direct IO write and fsync when using same fd
>   btrfs: add and use helper to verify the calling task has locked the inode
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

