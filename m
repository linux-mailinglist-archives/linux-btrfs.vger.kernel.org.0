Return-Path: <linux-btrfs+bounces-5997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CF919BBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 02:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5301283032
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A1211C;
	Thu, 27 Jun 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KjNAoRP0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eTQGL48y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BF4689
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447889; cv=none; b=YELObMIdL3CDXl3bnfJ8OSH3kSAITzSoRY90cffRy/sWAnl82UQhjFeENwU3wT+4LHn3wsZwmvMNU8tOOqPjScu4ts8Do+hMM6wD4Itxqn0U8ep9XxsUTk03Rb7Nc/X0ZwAJrSAM14+XuGOnuwTUOm9rX+fYtKdRyPtmFjdm+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447889; c=relaxed/simple;
	bh=i8/3wmhKnwjykAWM0jozLyIwkv+PGX4DXjXKhq9xkPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RlRSQE1PFE8xLlqAIpgIiUIZAs6wWyx8o417NXbUPnnbJ9YsQ+1nv9vSqzdxZ/vX5nCnp+y9I3DiVtyplOokqEqIUdYc+fwzsiGdONnsBOwdDAY42GJvH/RmpMCGyM+Oyx8XJY+iRgGi+MqZ4sV7WW5Vqs9aSZYIk5aznQYAdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KjNAoRP0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eTQGL48y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F85821AA7
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 00:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719447884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cKFmh1FOIS+sfqNsk6MmtjyLjqySJ47f6iJka4OX6jQ=;
	b=KjNAoRP0FBmpuEh+zD2eEFgbkjECGwmaj6mMDZYZ6/9ZLKCJSC2m/Db/sx06QOV1G1Z4jq
	QUJyaP3Gt0CpTGWqNjir9f0turse+ZHMcKpHvyRq80FEpMBTvjlXKGw8K0N7Aah2bMo9a+
	lcCoERHiWxPQfYxQkghzPaCpsbPWctc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eTQGL48y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719447883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cKFmh1FOIS+sfqNsk6MmtjyLjqySJ47f6iJka4OX6jQ=;
	b=eTQGL48yyHD/yvGPcaNn94svRE/zOfgbiPk/gN/Sxjbj/8GmOJVf4wlZDRZLS5qdS9KS3D
	kCSaX5t7Y6cSYXf66qxbjwiBuaxKzJtFQp8hDflvxXfwi46olYL44m9wwxXETtgrFwqv65
	rdknfuexixPZslhTEk51zhJKUJDMi6k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08670139C2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 00:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFsJAkuxfGbbBwAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 00:24:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.9.2
Date: Thu, 27 Jun 2024 02:24:37 +0200
Message-ID: <20240627002438.11201-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F85821AA7
X-Spam-Score: -2.84
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.84 / 50.00];
	BAYES_HAM(-2.83)[99.27%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

btrfs-progs version 6.9.2 have been released. This is a bugfix release.

This namely fixes problem with trimmed subvolume names introduced in 6.9.1.

Changelog:

   * subvol list: fix accidental trimming of subvolume name
   * check: revert checking file extent item 'ram_bytes'
   * libbtrfsutil:
      * patchlevel version update 1.3.2
      * fix accidentally closing fd passed to subvolume iterator

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.9.2

