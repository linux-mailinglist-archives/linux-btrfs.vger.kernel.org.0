Return-Path: <linux-btrfs+bounces-19366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA33C8CDDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 06:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 463F74E2F62
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 05:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055030F80C;
	Thu, 27 Nov 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tBd69czR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MRzhn4cL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C958F4A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221128; cv=none; b=YQBhOn/duKRXvGZCzcJlBQWRqtWrHAWWNKf3xUmQuCQWRojzhGECX4KrX5HjuC/JjBlBuLVfea/es2Hubgp0+cOjLtLfMLdUKdbooomOZVU5wLio+c5SGY0TEGyMWPp5GQh5gTIbgEFHVdXqpo2Vx4x7V5+RxCYJU4r/feX7R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221128; c=relaxed/simple;
	bh=ST7qmd37iMEbWdhL/BeqI+7XO4pd567PMMMgM1xAi2o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JD6LL7lvlME10qUK85Eo3nhbnrs4tFPNb5afNg+ob3kWgjakvNDdH6Ye6xwWteXg3WfVO83WGEuYvH9JCYhw3OdyOuDavOsA54Q8aoSoFmBzM3m0bqn6QqtwIgcMYJ8AtgSaYR1VpEUaP0I5GMTA/WLYCt4DBk7/Ah0wtxuP/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tBd69czR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MRzhn4cL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 516565BCC4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x1BuXa9OitdwsAzYW671gevxsyxliG/zayvdUHF4g1c=;
	b=tBd69czRHQVuKhJVEqXUX+mtykSOiIHdBGe1Q5sIFtjBdtrotB8mbJNZN/qMlKMie3SA2m
	xfQTSNHaG9szvyi5+APooFlVsuUgbYg1rcz8foaFg2a+bqhA4TI2XeVmZ6nAdyuwP8H9TX
	Nj9BqMTrnidziKG/8JI+kt9b+RQz3Es=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x1BuXa9OitdwsAzYW671gevxsyxliG/zayvdUHF4g1c=;
	b=MRzhn4cLy+OZo4OiJgEgsSxAeThyiDub+DFq7hNyPHFZ/h0R9KlFoDBahwQ5uCVEv+hjRY
	/wtNKXn3xjjK/A0VyPTfQ8WiXMA4mfUURe0RsdXM0hCx7wfKjRU8kzHeqsL6iDZIKI5W/3
	bPjckoSDROnAdKsCg+QtQf1RKTx+x4A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 900D13EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3xWKFMLgJ2l3fgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: add block-group-tree to the default mkfs/convert features
Date: Thu, 27 Nov 2025 15:55:01 +1030
Message-ID: <cover.1764220734.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

I was planning to do this during v6.12 but forgot it and now the next
LTS kernel release is not that far away, it's finally time to make the
switch.

The first patch is to update the existing test cases related to
disabling no-holes/free-space-tree, which will lead to mkfs/convert
failure as block-group-tree requires those two features.

The second patch is a large page-size specific fix, where on 64K page
size systems misc/057 will fail due to subpage mount always enables v2
free space cache, resulting later conversion failure to fst.

The final patch is the one enabling new default block-group-tree feature
for mkfs and convert.

Qu Wenruo (3):
  btrfs-progs: tests: disable bgt feature for ^no-holes and ^fst runs
  btrfs-progs: misc-tests: check if free space tree is enabled after
    mount
  btrfs-progs: add block-group-tree to the default mkfs features

 Documentation/mkfs.btrfs.rst                           |  2 +-
 common/fsfeatures.c                                    |  2 +-
 common/fsfeatures.h                                    |  3 ++-
 tests/cli-tests/009-btrfstune/test.sh                  |  2 +-
 tests/misc-tests/001-btrfstune-features/test.sh        |  9 +++++----
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 10 +++++++++-
 6 files changed, 19 insertions(+), 9 deletions(-)

--
2.52.0


