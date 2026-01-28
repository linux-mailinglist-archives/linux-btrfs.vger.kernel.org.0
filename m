Return-Path: <linux-btrfs+bounces-21163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JqkAjzVeWntzwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21163-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 10:22:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A59EC00
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FA5E302E7E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093C344DAE;
	Wed, 28 Jan 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="oAn4htXo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE075221DB1
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592103; cv=none; b=pBTvCgWfRXAjrudn/G5rLjjjDY7SU7mneSPrl2JPgqO6r7D9MMC9HfE5EsmG/6Py7+P0jymANH8ezxm2pf7vJ88Qcs+2ezslx8foQZw9hCZ0Wwi5OcMoSB1zMSKSknFA5BApItNQfghme8Wh0nNr7+whml3RuSRgMMLCv06ckSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592103; c=relaxed/simple;
	bh=JzvJmKvT2vsRdJqbbo2pAFNhNRZ/WrJf6NzOUU3Dn/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOJQ0Q+GWsJQbtTilNK6qsaAWIKjU3Ti6A7hgINP0EobPbS5RqmhLQsKIMJs8YRz4pR6OhzIStV9ovQabH04TXpwITeHcQK3F8e+bSmPSMl+H3YADvPBkts3EDuhac+vZIN0NGpv2uujK09RsjeEf5gqx93+KMUCxPJ+mZpGRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=oAn4htXo; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4f1Gx92lWWzGCnWfS;
	Wed, 28 Jan 2026 17:21:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769592093; bh=JzvJmKvT2vsRdJqbbo2pAFNhNRZ/WrJf6NzOUU3Dn/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oAn4htXoTkii/obiVViLJwvyUPVwyxHaE5CbgKffSp83EnmyXeLGfv7QreOuQp1Tl
	 S7LqeIfx8cMb+wnn8/bRpUTDOprttkisiTFb4TWiv6ty3yQyZymEfn3nb6z3i3w99v
	 e1GKNcpFpfcSNDLpcaQw+9cb65NvcqN63ikZWMe4=
From: jinbaohong <jinbaohong@synology.com>
To: wqu@suse.com
Cc: dsterba@suse.com,
	fdmanana@kernel.org,
	jinbaohong@synology.com,
	linux-btrfs@vger.kernel.org,
	robbieko@synology.com
Subject: Re: [PATCH v4 3/4] btrfs: handle user interrupt properly in btrfs_trim_fs
Date: Wed, 28 Jan 2026 09:21:32 +0000
Message-Id: <20260128092132.848164-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eec6b47d-2b0a-4196-807a-b05f4a983e47@suse.com>
References: <eec6b47d-2b0a-4196-807a-b05f4a983e47@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21163-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synology.com:mid,synology.com:dkim]
X-Rspamd-Queue-Id: 8F5A59EC00
X-Rspamd-Action: no action

Hi Qu,

Thanks for the review.

> If your idea is to exit without counting it as an error, it's better to
> put the early return before the error message, or it will still acts
> like an error.

If some block groups or devices failed before the user interrupted, I
think we should still report those failures to the user. The warning
message tells the user what actually went wrong before they interrupted,
which could be useful information.

So the current placement is intentional: report any real errors that
occurred, then return the interrupt code.

What do you think?

Thanks,
Jinbao


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

