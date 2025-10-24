Return-Path: <linux-btrfs+bounces-18235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84339C043FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 05:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDDE19A3467
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 03:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF92741C0;
	Fri, 24 Oct 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtw+HOp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AB26F2BE
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276474; cv=none; b=LHVFdxWFfx5O5mku2Xb90rJb4CaiVuupCdaH3t79i9PDB22BShNgudmBPqSQtYDyDkFW/bv3t5hWquNQDAOgOV1ssCfWZiLE/0msenLbZpxnW2zSkqB7wY5kn7gQzCs9Y9QSpVNfuDzdqy+uYhnzakSE4UZPpcOSQd6VR6D32LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276474; c=relaxed/simple;
	bh=jYlnoA//N3BMbb6A8YOUE+u4Cg0TGYZ4lEykKO7L+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyIVL0bzKVjd36D5cZK1UbcJwh4N13AVEVcoGa4b2iCJb9DTU32M5TbCOvQRCBOT7jrPtpnrUedNNU5rbM3EjYj9hmBHmU1s0iDcYLAk5n5438EZNP7lZXKFIdVrF2Biu6i5kjLEOxJ52rIrflbyhUfGCWKn9n921+YutkRzi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wtw+HOp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761276471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibXRoeaySX78RFSu+m8DZA78GB7YAHpBsMVeutqEJxM=;
	b=Wtw+HOp6nVXBf5ftrXAmzH+fk7Zh6X2Q++mX7y+APICb5AU7GlFKYByr+048t+WSTwsAT3
	n3zaOZQPtC587dQz4MkeBBu/100/kxP8TTkXKN9BUh5RX+9KiMMfgsELLqwFuarMK0rhQF
	qSGu/DA3NijaeFhMZaHk6qvMnLbGLc0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-8SvPHszkMW-c28UCoYrY1Q-1; Thu,
 23 Oct 2025 23:27:46 -0400
X-MC-Unique: 8SvPHszkMW-c28UCoYrY1Q-1
X-Mimecast-MFC-AGG-ID: 8SvPHszkMW-c28UCoYrY1Q_1761276464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEC721800245;
	Fri, 24 Oct 2025 03:27:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 336F9180044F;
	Fri, 24 Oct 2025 03:27:33 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:27:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] io_uring/uring_cmd: call io_should_terminate_tw()
 when needed
Message-ID: <aPryIDKfN1GB3Ips@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 23, 2025 at 02:18:29PM -0600, Caleb Sander Mateos wrote:
> Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
> it's computed unconditionally in io_uring_cmd_work(). Add a helper
> io_uring_cmd_should_terminate_tw() and call it instead of checking
> IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
> Remove the now unused IO_URING_F_TASK_DEAD.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


