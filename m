Return-Path: <linux-btrfs+bounces-6100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764D91E1E2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4677B2416B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD41607A1;
	Mon,  1 Jul 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TkGOGG4Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158A160780
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842923; cv=none; b=MEra7apb9rEgJE3dyZI01WRZBhF4bQhdFbLvcRUJx4YLDuw9Gz7BgsgDmuqBsjI6kXikPEa1dFXXD4qcbU56TGXzskIuOpFMCMEwANARFLY4gliLW8ZmCNuidQtzlGtM0iyFyAThWrNrfLmlPx5B338GnOiQvyfE5nkb1NMjSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842923; c=relaxed/simple;
	bh=cUGu0W7I/KO8EJpQL3/SOGRCJMKWN69nHxvWVGGD4UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF+FhHffBopRh/Y5/8o6Sf403UPwiiNYl9vN3DUqVJ5XXutbuXqj9T3Cd6Mfuquq5xqZJMnfQfSqK0OXyay1igapQ7uSlzROdKa7665Qr8NVLzuxVgLMVbUB1AOqa/VzwyXEv35VLLyWV6Oydia3NcwjA7UahV1u1lTpauL3zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TkGOGG4Q; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-446689932b8so8136651cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719842921; x=1720447721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3CGRdltZKLEzMTcWHE0HXKapnqnAMbIbhtY4sNi32Y=;
        b=TkGOGG4Q6DRuVTNOk1mXAgJIShN7dGqYVpNWmIdZdsbTeUHwEQHpYf8p1K0hKcvS23
         qvUyHlHYY9pU3FUGBfoZV4BPIh+AGEpgqYIcoZDqhL3+ISt15t+VfZX3jZ3oGcZ7mq/u
         Cxd4be7HeJfu12cr3jXvYAhDtpkiYnZH+yGyjdUIL+c+Nh13mRYbROAVcdys2HSwY76v
         l0LCzod/5X3xkK1PIISuVPGffWH4vfEjiYziDzlm2AYRWZ9Ro3kqb44Pv0R26lEl7qmt
         7/ODVtMQbFVSS1qJlplfpPYzSWw9Ukw2V7ELmLZcP0gYgfFCi7FZzWkC3Gq4lLWrqQDM
         99RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842921; x=1720447721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3CGRdltZKLEzMTcWHE0HXKapnqnAMbIbhtY4sNi32Y=;
        b=sWPtf8UaXljCW0IZABrNw0UqmtrANS3LSrkjHP6RZJ02hj0k0H5Etjrleoo2ApFPiU
         L/ubCt643wadUoZYfeYvXUa4p6yOtE/P/1dhav5I00V82MOPSM9JMVC7OmypU2VlcXZf
         3/IAld2XoYMg8Y1fpvu3wIdZAFR3iXDzhqIyAprD8ZYWzyOUcITlUP7dM9wHExtn4QNB
         S6+g47Cz14eqRQss9uxRlNjsApcI+LxvcRpvmYB40j7DFpzgRr3rcYHfGl+3PUHteUei
         jQdM8zZ2z1Hn1Z3V2ProlUwlPAaOKxirpiyJpXbmBrq+zx0MwCJ+dZRFCb0HvirMxMV2
         wzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVju5wOe/jxslbqknrmlvlOydB7JeHNlr2BUql6Z2o9mkrSJLu8cS5M/CZ0szHXze273m+6K7t+HOd/42yGAPb90xDY+wT5dfCpOXE=
X-Gm-Message-State: AOJu0YzipfntqiyRI9Vrm19fDeZo+w29fas9tV0TNs4AwhoT/ljBBfCj
	XXsbcUUlC8ug3tqbxoua1FEU89277/KTdNwF9wovG4kGoupGyrrFxSZI/yoy8X0=
X-Google-Smtp-Source: AGHT+IHmIxQz7e2tkxFUxh6n9heUT9VPRsYDhw3zonhXK/TfgobKQNp9ohD09a1u8+kPDFPtUpBhwQ==
X-Received: by 2002:ad4:5d68:0:b0:6b4:f6f6:98c with SMTP id 6a1803df08f44-6b5b704f9aamr79758416d6.13.1719842921179;
        Mon, 01 Jul 2024 07:08:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e36849csm33439746d6.4.2024.07.01.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:08:40 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:08:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 3/5] btrfs: stripe-tree: add selftests
Message-ID: <20240701140840.GG504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-3-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-3-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:17PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add self-tests for the RAID stripe tree code.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

These tests run the code, but don't validate that the end result is what we
expect, that should be added.  Thanks,

Josef

