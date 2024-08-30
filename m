Return-Path: <linux-btrfs+bounces-7701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5C966B01
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75511C22045
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65171BFE0F;
	Fri, 30 Aug 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUqb3Uj9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525F15C153
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051289; cv=none; b=rHS3VYFRj3emVJuty93bXHhhSxN/u8mu+vO1/c8PJbeCghRFmpiNbcXinJdfn5ucJYdt+rh8qtnF1hIA6I9uKFaYvgp3UdcavkFUcEvN9B2rXSX1tcmpGlk//d1/FQy5fLNqrjzs4x+KhOXAkzHOgk6Rra3qZKv3zQjDjM5MVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051289; c=relaxed/simple;
	bh=D+Q9UbPqFgFHNfOGgd40FRevWZ0/DcyJAcOwvpkzUX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AyNq40L7yOueQN/Kn7/CoHpSCbVvkNDYnBZXUdZvryf0B3yO/fTSVwJInij2a5U1zpg89KTHkP/j/TfW+hFHSe5e5sAvZJfKIOGmBnAMDfdsv+lRSihkdtuU0IlxDwIm7stoF3N5BAvOip+Qas9SbGBpBeM9uuVcTXM+8dhHp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUqb3Uj9; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-70df4b5cdd8so1499493a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725051286; x=1725656086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x7J6LebUMTqmDlnvzslmlyBlq4EwezfnlX+bAwIYABU=;
        b=EUqb3Uj9+B3KiweMy8xWrkoT62L8H0k1g/iX62PYLO5sfc0OoXY+q/cVlS7RZTuoa8
         a5wBthRUqXTWZliu31UF623atfl3UmTSHyYkQbfOCdSywocZX/bqv3hmwmPbtJ/DplAh
         XM+tetbo+EgSmQIrsIhuib5UFxd4cy//qoMH8AXO4WsRkANtElx6UJGJXfkCewaMbiBu
         q4wHSFfIBjp5cwy1J1C1ikC0Kf3Sv6cdZ7TWm+sb5qzqboUym2zRnK1mFyL1OTbnS4oJ
         09kGQnb5LptmXg7M76xvcverfTt+6/9Pqt5Va5snz3tZ5+6v+YF4/gWLpskZKzYpMYBg
         Ejnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725051286; x=1725656086;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7J6LebUMTqmDlnvzslmlyBlq4EwezfnlX+bAwIYABU=;
        b=VUZKKLeqUizxPT4rDlkLH9yIU+JAzQ19cQ/vcmyjO52Gq7na4lNynT06BOAkKfCPN8
         0IhWGCoRV+onVn7hSxQadTEebZ7u2mXLZjgqNUJOqKfMZGuuuf5xRyPvsadasPqp37ef
         6RIqn73sTB8sv1mk2D/NaB+gfRGl9eIwSC4WFMHfdPxy+hq28E++fALth0pTLRoyfPGq
         H21SK/xo7GXYUk+5jlVBWOg+9eElPXGoi6oVH7DIIr5mWVVl5PGpQvbfodOxlWRTd63G
         jHBNd/HWPBWywyc3J5OkM8Ar2kNjk+4MLiv2ca01qu34Rdxmuqs6LPf+yv4awEzKFcJr
         uFbA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bAWIVeD8d6BZDnQD0FoEJvr1cowbXc672lFuq/8nZwM+Gjj9NjbzAwXWuOM6ALJ7IwRWZxSu1j5xlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2d4UderY3WgLVGH9cUCG+f3TFepxCj1tlhiMSg2elk5/l3usl
	d+OXtYB50yBz8rcr2ly0mtPBDRG8nQEyTVgYYzaEXtv561ehGPAQ
X-Google-Smtp-Source: AGHT+IEOJyJXpwBZYTJEKfTzqDoMqU4NXOl1SBxC1Jy3xV0vRlK6W366z9PDxYktDXhXcP6wojAtAg==
X-Received: by 2002:a05:6830:2783:b0:703:5fb2:34b7 with SMTP id 46e09a7af769-70f711956damr508364a34.32.1725051286304;
        Fri, 30 Aug 2024 13:54:46 -0700 (PDT)
Received: from localhost (fwdproxy-eag-008.fbsv.net. [2a03:2880:3ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67158f54sm645306a34.29.2024.08.30.13.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:54:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:46:59 -0700
From: Leo Martins <loemra.dev@gmail.com>
To: kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc: 
Subject: Re: [PATCH v3 0/3] btrfs path auto free
User-Agent: meli 0.8.6
References: <cover.1724792563.git.loemra.dev@gmail.com>
In-Reply-To: <cover.1724792563.git.loemra.dev@gmail.com>
Message-ID: <j1u38.er61zc06h8sh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

I think the only feedback I haven't addressed in this patchset was
moving the declaration to be next to the btrfs_path struct.
However, I don't think moving the declaration makes sense because
the DEFINE_FREE references btrfs_free_path which itself is only
declared after the structure. The other examples I've looked at also
have DEFINE_FREE next to the freeing function as opposed to the
structure being freed.

On Tue, 27 Aug 2024 15:41, Leo Martins <loemra.dev@gmail.com> wrote:
>The DEFINE_FREE macro defines a wrapper function for a given memory
>cleanup function which takes a pointer as an argument and calls the
>cleanup function with the value of the pointer. The __free macro adds
>a scoped-based cleanup to a variable, using the __cleanup attribute
>to specify the cleanup function that should be called when the variable
>goes out of scope.
>
>Using this cleanup code pattern ensures that memory is properly freed
>when it's no longer needed, preventing memory leaks and reducing the
>risk of crashes or other issues caused by incorrect memory management.
>Even if the code is already memory safe, using this pattern reduces
>the risk of introducing memory-related bugs in the future
>
>In this series of patches I've added a DEFINE_FREE for btrfs_free_path
>and created a macro BTRFS_PATH_AUTO_FREE to clearly identify path
>declarations that will be automatically freed.
>
>I've included some simple examples of where this pattern can be used.
>The trivial examples are ones where there is one exit path and the only
>cleanup performed is a call to btrfs_free_path.
>
>There appear to be around 130 instances that would be a pretty simple to
>convert to this pattern. Is it worth going back and updating
>all trivial instances or would it be better to leave them and use the pattern
>in new code? Another option is to have all path declarations declared
>with BTRFS_PATH_AUTO_FREE and not remove any btrfs_free_path instances.
>In theory this would not change the functionality as it is fine to call
>btrfs_free_path on an already freed path.
>
>Leo Martins (3):
>  btrfs: DEFINE_FREE for btrfs_free_path
>  btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
>  btrfs: BTRFS_PATH_AUTO_FREE in orphan.c
>
> fs/btrfs/ctree.c  |  2 +-
> fs/btrfs/ctree.h  |  4 ++++
> fs/btrfs/orphan.c | 19 ++++++-------------
> fs/btrfs/zoned.c  | 34 +++++++++++-----------------------
> 4 files changed, 22 insertions(+), 37 deletions(-)
>
>-- 
>2.43.5
>

