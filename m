Return-Path: <linux-btrfs+bounces-2820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C55867F13
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0262029AD1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613612FF9A;
	Mon, 26 Feb 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="tM+AfqX4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14912DDBB
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969184; cv=none; b=uDzwPqWwqn0spxcfXWEvvKvWDFW4lcyHRfLYGCoihmpEU/zHy3YbECFP1LJzSzftyaYCbEH33qO3D2ju2CKXcsoMHqLreQrIRDLKm6dori3R+G/CLWvN9y/SQj9Y0rc7uyU1hr2ouV5lPowAtbmOPSToPTF3367yAhR1TobJm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969184; c=relaxed/simple;
	bh=PdLZpWCHT5Wa9+bn7VB9GDzTAItIhY0uFZJd7CmsHMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=jRKg35t9OVJ1CatiL4IuwzhcEKRnv3g4WoWRBWvcpNqcwv+GsdK2j9OqugETnjrkYe3pwxZP7MjUT3VMGDzv7O9ZAX7chqnmRuAsXSsaynSEMetq1oUoUfIn6YilfuGTzhO13wcjF0ydJgVgD2fJLH2tvVs6vA/sSG09lI/gW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=tM+AfqX4; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 26D0A803DE;
	Mon, 26 Feb 2024 12:39:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1708969176; bh=PdLZpWCHT5Wa9+bn7VB9GDzTAItIhY0uFZJd7CmsHMg=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=tM+AfqX4MICMTSJ42RslHQ6zbhOaFHqrEteQu91lprf/lcQgA68w00nUFWPe9FDyS
	 WDxcdi6N7T8CoqbyKuG1XpzbZ3qeEKgInW8F9v1ZHSC5hbwRqiaVnzUAnJz18SkF6L
	 VtgAWzoWqoTht1641pdJ0ysxoML225HIvxdUjocfhgU1bK6qXLSFJ8UbgOp0epVWKe
	 40uJr/cg4Dbo0YIaRH62j6z4xlf7GO1ahYuego0OzISFA6nPM3Wb5GJWxokb3WA668
	 yakFLHY7K+2JlNRzLEF7Tqj+qQ2Gq5C+5smpoZglr2rD2KezNuNjYLSRJxc7dVChpw
	 cCRBgK6oD6lBA==
Message-ID: <cf24775e-a9da-498e-93c6-8a2c8009f53a@dorminy.me>
Date: Mon, 26 Feb 2024 12:39:35 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 1/2] btrfs: fix data races when accessing the reserved
 amount of block reserves
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708429856.git.fdmanana@suse.com>
 <5ff1a68f4289d5bb870a499b248d329893d417ae.1708429856.git.fdmanana@suse.com>
Content-Language: en-US
In-Reply-To: <5ff1a68f4289d5bb870a499b248d329893d417ae.1708429856.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> So add a helper to get the reserved amount of a block reserve while
> holding the lock. The value may be not be up to date anymore when used by
> need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), but
> that's ok since the worst it can do is cause more reclaim work do be done
> sooner rather than later. Reading the field while holding the lock instead
> of using the data_race() annotation is used in order to prevent load
> tearing.

Would READ_ONCE() be enough? My understanding is that it should be 
enough against load tearing if it's aligned, and I think both size and 
reserved are aligned? But I'm always learning more about how to do 
things right.

