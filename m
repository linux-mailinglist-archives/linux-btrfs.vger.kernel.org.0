Return-Path: <linux-btrfs+bounces-18234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B331C043E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 05:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7718C83C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35B272E41;
	Fri, 24 Oct 2025 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hINDlJfX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075026E6F2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276400; cv=none; b=dV+vUIDaDIK8xv2pT70pgupdXAUjHcu459478O+L0iVVYxOiv31oVnlNFrqn26DStKH2uYTWy3InA2bBYPZ9boF6xnzHrBJV/l2IO7YsYMrIVms+4J9yw8GzX9mRxgPMrCa2yLrarcgTRVG5P9sBK06SQxOr+CBELoVs8SW8Iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276400; c=relaxed/simple;
	bh=wOVQLucTqTR+3WTAqlI3dBKz9v+oStyfQUJR6YOtBWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9UWtpqk9g7kON/xC3k/ot0Eq26UR/KxcYeg8Qud07VpwMISrg4rAhxdmCijyb3VOu6ZfbCSudLalGY/6MpbpY1xZvhc9KbJDLukVviMFlZscBU/J5EwHWRcWp0Z8lAAeDSRFoGdjm8yfGDSN7/Pb4I/AUaWdBKeT7tZ/6vQ1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hINDlJfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761276397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBGpZ+b69w7Vm+EhedHcipsUWTvIk6iy1D0IPGn2dk8=;
	b=hINDlJfXIAwObUFhvW4WbWrA4csXFlyVvEw6AThbIHP+A6ske5wU4l9JkNDHS6nX23hgB/
	kdn5OM082r95d3AcYtzqeFPybNv45mSsAohcr8+PFvh6mh7G7tQszwg2bT7gXbzQrxuDku
	lzYJqkqY1zrIs0LbC3DlhW+dQuu/LmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-3XNFOwubM4iZvHWkmhe5wQ-1; Thu,
 23 Oct 2025 23:26:31 -0400
X-MC-Unique: 3XNFOwubM4iZvHWkmhe5wQ-1
X-Mimecast-MFC-AGG-ID: 3XNFOwubM4iZvHWkmhe5wQ_1761276388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0420B1800378;
	Fri, 24 Oct 2025 03:26:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5367F19540EB;
	Fri, 24 Oct 2025 03:26:16 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:26:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] io_uring: expose io_should_terminate_tw()
Message-ID: <aPrx05jWsnraLetW@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 23, 2025 at 02:18:28PM -0600, Caleb Sander Mateos wrote:
> A subsequent commit will call io_should_terminate_tw() from an inline
> function in include/linux/io_uring/cmd.h, so move it from an io_uring
> internal header to include/linux/io_uring.h. Callers outside io_uring
> should not call it directly.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


