Return-Path: <linux-btrfs+bounces-4669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247028B9A95
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00011F2324B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F677F1B;
	Thu,  2 May 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c4rQfHeS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c4rQfHeS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B7D26A
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652111; cv=none; b=pv4hitdMtlKUFBoeph+cM+/8u/roWqf6zru2ajSA1JOGH3nJOL4J2efpcCUEUi7JTDqUr7pgUwmBp/Ro/otE66IAJW0+c6QOe9V9fGyMXz5yAcrkae3alyunGgp3WAZ9qs4qkyscYyYd9Z2QkixxavJ1MyACZ/pIm9u+k9L07Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652111; c=relaxed/simple;
	bh=6aQt/Th4Em3KqbVL7COhfnb6Hcb0pSZBTQ5ysAAuHk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XcsHs/E2TYEhYyvZD47WxndjFY3i3PqIl7HzpE0LTAQPgxb3W7Q7k6ywF1adhVfR2Xd7kPxLEcUMwuk3NLt3U7Iq0XyoI6SOVWjJY4Xib0snULuKg3HciweQnJ891IOohXSR7nSl6XyjLcGkWwPfKeEWCxI3BMIq/dKZKAL/DNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c4rQfHeS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c4rQfHeS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B1335313
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714652107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gTg7+RFm0U4NqtHuun6xx23jT+7SNQ+tp8ZGwp0ijsM=;
	b=c4rQfHeScgpyiryNWo8G6w+C6GSkVhSsT5rp5kzcNY4gB66j5kn8mtZ2d/bzYty/VnDzk1
	bbPWA2a4IcudAzirVANrTwmDwASWxGPMl2AHm8WYp/+kxH0HyUeo5y65SIKZyMrqW4hQSU
	RUImuQ6R7SiSE8G5FEY9y8P3L/PrKb4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714652107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gTg7+RFm0U4NqtHuun6xx23jT+7SNQ+tp8ZGwp0ijsM=;
	b=c4rQfHeScgpyiryNWo8G6w+C6GSkVhSsT5rp5kzcNY4gB66j5kn8mtZ2d/bzYty/VnDzk1
	bbPWA2a4IcudAzirVANrTwmDwASWxGPMl2AHm8WYp/+kxH0HyUeo5y65SIKZyMrqW4hQSU
	RUImuQ6R7SiSE8G5FEY9y8P3L/PrKb4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCB9B13957
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 12:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4+0OLsuDM2aeNQAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 12:15:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.8.1
Date: Thu,  2 May 2024 14:07:51 +0200
Message-ID: <20240502120753.32434-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.87 / 50.00];
	BAYES_HAM(-1.07)[87.89%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.87
X-Spam-Flag: NO

Hi,

btrfs-progs version 6.8.1 have been released. This is a bugfix release.

Changelog:
   * mkfs: fix writing on zoned device when block-group-tree is selected
   * tune: fix writing on zoned device with option --convert-to-block-group-tree
   * check:
      * more progress and error messages
      * unify handling of unknown command line options with other commands
   * subvolume delete: remove options --delete-qgroup and --no-delete-qgroup
     (added in 6.6.3), qgroup deletion does not always work due to delayed
     background processing of subvolume or set value in
     sysfs:ggroup/drop_subtree_threshold
   * other:
      * misc refactoring
      * error handling fixes reported by gcc -fanalyzer
      * documentation updates
      * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.8.1

