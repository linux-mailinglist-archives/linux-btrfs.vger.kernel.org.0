Return-Path: <linux-btrfs+bounces-20788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLu9FrEucGkEXAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20788-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 02:41:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2594F3B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 02:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9869B0811C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED830BB97;
	Wed, 21 Jan 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="ko3RO7Re"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715530E853
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959647; cv=none; b=c0GAC5SeL80858hPtNV1BN394sVByajsAuuCvSMCVslEaJOzVERQQdPKlAlpMtyvWFvhlUJ3S+f91jzUV5maiMsv0ho/RUTjG7gd0P9t3+i0aYkutYgHwm8e9nlvRiz16r5BZ6Saf8tr20cLf7yZf0Enncoi0QLDe/4s4bcGpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959647; c=relaxed/simple;
	bh=2+Snkxhi/61wxQcNNhNBW8qTcOFRZD0gesFeC8JvWkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/nZ7nJm8EX8OeyT0wIW+N73z0ou9Q+OFlAL4nemGKiO9+Zm+Y+o2Lr1UUjNU0ctu3GHtccR0BKLN/mEaxVAC/F8zlPzq81cjRbcghOLpr30U0X06LSSe+PG8aWmp/UgeMJFnDYSxDWhqrGunq6CTwy3yx0AlR3rb5imz7JFp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=ko3RO7Re; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4dwn2X38jfzG4VX46;
	Wed, 21 Jan 2026 09:40:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1768959636; bh=2+Snkxhi/61wxQcNNhNBW8qTcOFRZD0gesFeC8JvWkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ko3RO7ReDczmYE6B3c7C2tfnUOua9XyF0MouzqECWwSm/9FoUEPkdDzib3uFVkUCG
	 NhErRZmP9QoHuiR40d2DzmSDYDWA7v+t3GSwQj424QYG/kR8cFqrMrzC4JeMruSuxu
	 4PQYb2JFRDUg8pALHJqu+MVqWpd/HZHmTYgVn4+4=
From: jinbaohong <jinbaohong@synology.com>
To: johannes.thumshirn@wdc.com
Cc: dsterba@suse.com,
	jinbaohong@synology.com,
	linux-btrfs@vger.kernel.org,
	robbieko@synology.com
Subject: Re: [PATCH] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Wed, 21 Jan 2026 01:40:34 +0000
Message-Id: <20260121014034.453704-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cf826f01-b6f5-4b2a-a850-b066f268dff3@wdc.com>
References: <cf826f01-b6f5-4b2a-a850-b066f268dff3@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[synology.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20788-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[synology.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,synology.com:mid,synology.com:dkim]
X-Rspamd-Queue-Id: DD2594F3B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Do we really need to take the device_list_mutex here? Isn't this sufficient:
> rcu_read_lock();
> list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
>      test_bit();
>      ret = btrfs_trim_free_extents(...);
> }
> rcu_read_unlock();

RCU alone won't work here because btrfs_trim_free_extents() can sleep -
it acquires chunk_mutex via mutex_lock_interruptible() and issues discard
I/O. Standard RCU read-side critical sections must not contain sleeping
operations.

The device list is RCU-protected (list_add_rcu/list_del_rcu are used),
so short non-sleeping iterations can use RCU. However, for long-running
operations like trim, we still need the mutex to pin the device.

Thanks,
Jinbao

Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

