Return-Path: <linux-btrfs+bounces-6616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCA937D42
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121BB1C214BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E851487DF;
	Fri, 19 Jul 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LHYZadR7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933C4696
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420468; cv=none; b=qSYzgEajx1cIzPZLG+fCOFG+vc0ZCerjrkVUnTmES9lL4wz0IxWyqiLalNmDIDi7RXY/wr9gTREsdkW5gd+vy7qjJoHs1LsdHVYh6yGAKzKlV5I7HxHveFwqoQWFv4AX3UaKObtrWMxiONt7HpJn8I0VwjDlo0vsabcjen6/Plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420468; c=relaxed/simple;
	bh=J60SiPo6FxnJMasbNTCGiUhuPrKXA0+DtPA9llUFT80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIGmf/grpUkXdfumpwNndpH0AnTUN3+xpuNqKx94QujXIcqSH/rte3KhxGonu5GF0W+iL2X+xSNZpg45TXOtTitnYJlwKw6GpLfKux2kQIN8pm/kzjjlUw+gSap7PlAuowR2ywcq1IqopOUlQ+8GKTVnCDEIAybqymC6sbVmMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LHYZadR7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f16cad2a7so117648285a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721420465; x=1722025265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rVVat1BndkSb8XxrDYRRXiVdqBo1fd5raHLjIG8Fi0=;
        b=LHYZadR7U0MDXKyXn5dhrwR5YdUmJ5rqQgmnWBt89FxB4VvSp3xVIk9Su7THba6w83
         raKH40JQXqRtoMzZdwVVeVComWm88LSLYaQmoTMuVp5GD4a5yDNnUIjHIaA+JtnnYLUx
         v2z6GbsZGcG8cEhEalxbK4v9An3gd6sFvrxr7TW4cpPhlwSpVbYk8K7+pPy2eC1aiMyB
         jusbjxMHjoirb6HX91laT11eWFArUYaiD6tLMxHDg3zZ7MnrnJfP9i4mv6VKlwD6ZMH+
         Qd5j9aVgQXZHXjJSzAMLxbp1Xtb651rdYDMheH37kwNRT9ZvxpkHqq4y+84eLjZxpIMW
         2WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721420465; x=1722025265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rVVat1BndkSb8XxrDYRRXiVdqBo1fd5raHLjIG8Fi0=;
        b=B/4gHGrynHtYHtVBJtAJ+S0anSpBxkZ70HPa7TBzi9/dkiHB22FMiPEXBP9V7lu8Gk
         axh/A2V/o3apS2d8SW3OEXp+G9CSPlz5VlnyxkgHwfJPV2/baWea3bLbT89+BfGcbLkB
         beqZlKauWqtLPUXdPQ0545q4Xh3KmvX1+f2DbxMZ5aHT2d7C52l5jJWKSD0JaeNsqcZ2
         EDJMuQdza5oids/HvlQmcTQQi+65S+MB8KIBkhXC8XtwQ3GsDpKyQ3JZ2tOhn78EeDs9
         wodb+bzd7pK68KWoUwuLv0Vz+g6HlQJl2PvYCNk4blaVy/qm9FPLL0cDMBXYe3aD59c4
         2X/Q==
X-Gm-Message-State: AOJu0YxWpMmB9/3PonXTRtM8C2re7CAPiiZBvDK42qr6oXBRaxZ5E6YD
	AHFK/hbZGFg/Obe2ND3sbdqcjob1E3YBMUP33vIG58Sb6pB7iQLIvyMHPWFjGcI=
X-Google-Smtp-Source: AGHT+IGGrtUsCn8t4cKbLybu+7IAo1fWgNsdKkZ3/eAxPzKqf9xcXlhsxlDrNybWpU69JiLwXWIc2w==
X-Received: by 2002:a05:620a:4109:b0:79f:aa9:bf17 with SMTP id af79cd13be357-7a1a13a7615mr100038985a.54.1721420465599;
        Fri, 19 Jul 2024 13:21:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda7d12sm11185321cf.68.2024.07.19.13.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:21:04 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:21:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: add set_uuid param to
 btrfs_make_subvolume
Message-ID: <20240719202104.GB2312632@perftesting>
References: <20240719150343.3992904-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719150343.3992904-1-maharmstone@fb.com>

On Fri, Jul 19, 2024 at 04:03:23PM +0100, Mark Harmstone wrote:
> Adds a set_uuid parameter to btrfs_make_subvolume, which generates a
> uuid for the new root and adds it to the uuid tree.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

