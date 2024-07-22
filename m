Return-Path: <linux-btrfs+bounces-6643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE393906A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A20FB21A2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9FD2F5;
	Mon, 22 Jul 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jR1MoLQ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07C2CA9
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657745; cv=none; b=RuNzC2QJRdALkht4xGQG6hVatcy3cGpkVo5q6Dzrcm3awbvh98O/GzA61RAgrX3E7MgtdEzoLPWSgkwc3nMVzmgX3u+tiWqNNzqqcWwqwtFOlcIDGoeu1LJmPDxhZF+K5nBoBzOFRjEeiqJoO026YAX/ZJXAFcLuzxktH05K3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657745; c=relaxed/simple;
	bh=MgoTEUlUq0EArcc+W4qaRN3DskX36xYXUNIMou/MVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUd0QZXTl5QaHq94UDH+BtwWaAu099wLgVoq0Xd6Kz6LakqvI5SsZzXAZ0x/wqtoRlZZy9j6CXjmNyE4Wmrecw4BtPN6+frmw9CAt91KEui2IBahvoOCkBU1Va875kSR95X8SRUN/4FpOs5n2DzSHN4+n+0cy0WwweuXiKV1/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jR1MoLQ6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-643f3130ed1so43082017b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721657742; x=1722262542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7UVgzffFXpiNSeYIl+LqwzKMotm47bkXr2Nz7Ljwjg=;
        b=jR1MoLQ6X2aw+ZxiUHLj8+sXvfZi+FhdZsB5LBYjZO2twANY9fIqGwGvlIbTFAf23a
         p2odRP7fzQ+pVGcpm5SIq+0DbQG9sbmtGGcK5MxbwBOtmlSrevax3Clq4QzJBWXHY6w7
         PXHNyIdHwngSoVFwqsX09g8C0oAXjlQMnKLJxmIENgNI5H72nRN+2eE1qqFXUzFxKMu4
         08lr8D5t/7hy0BUrA1oH98OO+N0h8Ea2u0s/o0P6q/5mlrOqK2lA2sSFPjgMn9/oAJ3j
         5F2ytBJmEt8kal3riztzbY+dt8b9OWswbu0Y71TFfk/jkGhi6qmZLS3o7kJrjJ2ykKyl
         Fb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657742; x=1722262542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7UVgzffFXpiNSeYIl+LqwzKMotm47bkXr2Nz7Ljwjg=;
        b=IKfzd7vdP0Sh9LsBWMtPVDqFrQKSNVEGo+JQNY2kW0Kf9jhrS22tzTt1TQQFpZoKMi
         GNvKgYFwU+JMPXC3TirDrwMBgwQDyu1xN+9RXmK6jyhkfi/jWaG/4U6vlYi+6TERdgJT
         Ql3CzuZfaoQirhW/+bnM/oxUKZM9FvaIYM5FIucRJ7g/NQ2WnKvywJfMIm2PwNqVFaaX
         r2eqV8jR08zZw6b76UuQKX5tcUeCLi8UhwPPzc53q3bjYSOIkh/U2Y18YNXH+FWFsQp9
         TjH1cylF159D6byhmmzx655rmCtUDs1CV5iYog+CbUVJT7JKX68x3/wlE0AcNA+hgMUX
         Hx3A==
X-Gm-Message-State: AOJu0Yz2N7QkyAguBHkRPQFejLeqas4bGVU5MaaxB4rOv1Uzsl+i+uyx
	IFQBGJm6pv0xjwdj4n8CcHpLGBQZlWYbenIf0tF1WVVtEdydoNviW9KIUMA8ato=
X-Google-Smtp-Source: AGHT+IHtuCrCsTy88goYF79fwbHIAx70sEuH1aPI9Q6ExdyJWWFlMSuCNWmfFaMx5ItU9hnKzz/ksA==
X-Received: by 2002:a81:c941:0:b0:650:a1cb:b122 with SMTP id 00721157ae682-66ad94ba0d2mr68055307b3.27.1721657742111;
        Mon, 22 Jul 2024 07:15:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66951f7265csm16644137b3.11.2024.07.22.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:15:41 -0700 (PDT)
Date: Mon, 22 Jul 2024 10:15:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: set transid in btrfs_insert_dir_item
Message-ID: <20240722141540.GA2384989@perftesting>
References: <20240722133320.835470-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722133320.835470-1-maharmstone@fb.com>

On Mon, Jul 22, 2024 at 02:33:02PM +0100, Mark Harmstone wrote:
> btrfs_insert_dir_item wasn't setting the transid field in
> btrfs_dir_item. Set it to the current transaction ID rather than writing
> uninitialized memory to disk.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

