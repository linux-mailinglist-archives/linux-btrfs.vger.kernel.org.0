Return-Path: <linux-btrfs+bounces-18476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1EC26C3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38DF3B6048
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3A2F1FF1;
	Fri, 31 Oct 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP/LAixj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB642EFDA4
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939023; cv=none; b=sexiq0EgXjvvZLfAgxw7PJA4nwsc9QyTaRksNQrbxyVfCNXD3/XNbLzaYXYKbwqnFpAdoe1x6Xtn3LiyT0E3txz4b8xsh4dubKWtI0e0XwN3Gb1kQExsiNnv7LYgem5p+9n0k/yxM9T0WtiDdMNUnOHRR3U3fa6pdl+9QKzps+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939023; c=relaxed/simple;
	bh=HRT1zrlw67YT/v0zGnHpiKEt+Ry9RY8D6BYLFaVppGs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o4mHtYwAVr+xg0HBOP0/AT8C/hN4jM6NyG7qSlXPcownKe+Pr/qKinUDn8nkThqExZhfqv5aWsjefYHOc26VYhmkUtPoacCaOL46PHNwzHQaG1bwhB2PY9TDKL3ea9sXmBjjJDLhUaB56iJcllWjIqSiZqlvxxTqrTBM1ufiG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP/LAixj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761939021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWgRT7WaYDoMlN1l4H+rmuJdT1C5jyRgb7Xd7l2YF2w=;
	b=CP/LAixjEt6j/naYZsY0fJ6qiWxzic/Q7udHaUA103+KpAMEFE+1oBE95awFfSPfqY7SAd
	PiKXLQ2d6E9zI8raISItvtpYMD0LujRPZH0DzxMWJvixRarrPeEMEmTi7ZkSYhM+BcSj2J
	tvpwXp1Ru6w5QderVR/VQsBLjXqjsaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-lZ1S-KggMVeFoVz9gzeAxQ-1; Fri,
 31 Oct 2025 15:30:15 -0400
X-MC-Unique: lZ1S-KggMVeFoVz9gzeAxQ-1
X-Mimecast-MFC-AGG-ID: lZ1S-KggMVeFoVz9gzeAxQ_1761939012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 747B21954B00;
	Fri, 31 Oct 2025 19:30:11 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B2C118004D4;
	Fri, 31 Oct 2025 19:30:03 +0000 (UTC)
Date: Fri, 31 Oct 2025 20:29:58 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Askar Safin <safinaskar@gmail.com>
cc: Dell.Client.Kernel@dell.com, brauner@kernel.org, dm-devel@lists.linux.dev, 
    ebiggers@kernel.org, kix@kix.es, linux-block@vger.kernel.org, 
    linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org, 
    linux-lvm@lists.linux.dev, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
    linux-raid@vger.kernel.org, lvm-devel@lists.linux.dev, agk@redhat.com, 
    msnitzer@redhat.com, milan@mazyland.cz, mzxreary@0pointer.de, 
    nphamcs@gmail.com, pavel@ucw.cz, rafael@kernel.org, ryncsn@gmail.com, 
    torvalds@linux-foundation.org
Subject: Re: [PATCH] pm-hibernate: flush block device cache when
 hibernating
In-Reply-To: <20251027084220.2064289-1-safinaskar@gmail.com>
Message-ID: <de1f0036-84f9-2923-2c0a-620e702d850b@redhat.com>
References: <03e58462-5045-e12f-9af6-be2aaf19f32c@redhat.com> <20251027084220.2064289-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Mon, 27 Oct 2025, Askar Safin wrote:

> Mikulas Patocka <mpatocka@redhat.com>:
> > Hi
> > 
> > Does this patch fix it?
> > 
> > Mikulas
> > 
> > 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > There was reported failure that hibernation doesn't work with 
> > dm-integrity. The reason for the failure is that the hibernation code 
> > doesn't issue the FLUSH bio - the data still sits in the dm-integrity 
> > cache and they are lost when poweroff happens.
> 
> I tested this patch in Qemu on current master (43e9ad0c55a3). Also I
> applied Mario's patch
> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/ .
> It is needed, otherwise you get WARNING when you try to hibernate.
> 
> The patch doesn't work.

Yes, I see - the problem is harder than I thought.

I've created two patches and I tested them that they work. So, you can try 
them.

Mikulas


