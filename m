Return-Path: <linux-btrfs+bounces-3215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B36878DAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95E0B2173E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9A8BA22;
	Tue, 12 Mar 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y1fn47LE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y1fn47LE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED924AD58
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215873; cv=none; b=b3OKFsgStcRuuJgnuN27IcR/yB7EvJUVkN8IeEannMJCyR5e55fr/gFcBia7LTsxX7h88E1wPuEdjqmUtnpFdcvaq6jqCfC51s7QeasiOIX165etj7y0CJEQc5a8a2ECk0eGo7vqSU5+o7TOjBE30Dj5hsP/mWhCmyRF/qKEg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215873; c=relaxed/simple;
	bh=tNiAr9i5t/NK7H5NpaktqohRY1UTyEPQRfPJRyEnv08=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IwU/YPlIWcFegfDiQ1Hh7aVckxm+aP4iLirJz1qJoX1pnUge6PgdZ7BXqdN6vjERZBzM2IQrJil+lpwwQNIcpK5MUUoWhQdky1wNldznpbAdv59eFlLMbqaX7UcoHUsd92NlK+SOJhp4Ti7vU9XzNHXZIBrHJYHfy/1RqXOHkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y1fn47LE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y1fn47LE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BD52371D3
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2xaOXK7kaLYcyqeoEcfKsAvI9gRmkx8Y804MfpCmW+0=;
	b=Y1fn47LEGKsHB4xcQdQ/ohvQI3RcwXyFPrJMfoiOmPwbi8WH3ygAOVJrYM8kerIHa3yzSb
	+Sg1XW/FFiHBaCpjQj3rtsJaLjeLaaU+p2NJXQwn7xtezxmEvRkTt6z0KVQL4GJ+jAbY8A
	pbK/3PElge0RO/b7L4z6qW50PCscWKE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2xaOXK7kaLYcyqeoEcfKsAvI9gRmkx8Y804MfpCmW+0=;
	b=Y1fn47LEGKsHB4xcQdQ/ohvQI3RcwXyFPrJMfoiOmPwbi8WH3ygAOVJrYM8kerIHa3yzSb
	+Sg1XW/FFiHBaCpjQj3rtsJaLjeLaaU+p2NJXQwn7xtezxmEvRkTt6z0KVQL4GJ+jAbY8A
	pbK/3PElge0RO/b7L4z6qW50PCscWKE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EEE313879
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMB4OLzS72VNVgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: cmds/filesystem: add --usage-ratio and --wasted-bytes options
Date: Tue, 12 Mar 2024 14:27:29 +1030
Message-ID: <cover.1710214834.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.87)[85.60%]
X-Spam-Score: 4.03
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Sync the newer kernel uapi
- Remove the "lone" mentions
  Now the new options would be "--usage-ratio" and "--wasted-bytes".

This the progs support for the new kernel defrag parameters.

This adds 2 new fine tunning parameters, --usage-ratio and
--wasted-bytes.

The ratio is between [0, 100] (aka, percentage value), and wasted bytes
is between [0, U32_MAX], but in reality the value only makes sense below
max file extent size (for both compressed and regular extents).
Any value higher than max file extent size would mostly disable the
wasted bytes check (as it would always be false).

The default usage ratio is 5%, and 16MiB wasted bytes.
If the kernel doesn't support the new options, it would fall back to
the old ioctl flags without the 2 new flags.

Qu Wenruo (2):
  btrfs-progs: defrag: sync the usage ratio/wasted bytes fine-tunning
    from kernel
  btrfs-progs: cmds/filesystem: add --usage-ratio and --wasted-bytes for
    defrag

 Documentation/btrfs-filesystem.rst | 21 ++++++++++++
 cmds/filesystem.c                  | 53 ++++++++++++++++++++++++++++--
 kernel-shared/uapi/btrfs.h         | 39 ++++++++++++++++++++--
 3 files changed, 107 insertions(+), 6 deletions(-)

--
2.44.0


