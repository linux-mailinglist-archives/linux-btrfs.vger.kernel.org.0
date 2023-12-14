Return-Path: <linux-btrfs+bounces-952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D85813356
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2685B1C21B0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BBF5ABAD;
	Thu, 14 Dec 2023 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z7UgHxmn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z7UgHxmn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86596131
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 06:38:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3ED761FDB3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702564697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=beXn1NNlSJTKzn6qMpffuG/k9s0Om3jiYbdJ1X0qcAk=;
	b=Z7UgHxmnRCylKAmE4B8RrQkfKxnAy2/mgfjyiEPPKcDV72rYqT1ig9IgpdPOs13EW/0yek
	woc1kZSG8t3xF3VLRRN2kxt3jmQVU+AHXxYhDyB7upKNZIl5kJ0aRJwiobibLvl4cCAluz
	uLLSyJJWccJG9IzNtjQyCt4/DKw4Sx0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702564697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=beXn1NNlSJTKzn6qMpffuG/k9s0Om3jiYbdJ1X0qcAk=;
	b=Z7UgHxmnRCylKAmE4B8RrQkfKxnAy2/mgfjyiEPPKcDV72rYqT1ig9IgpdPOs13EW/0yek
	woc1kZSG8t3xF3VLRRN2kxt3jmQVU+AHXxYhDyB7upKNZIl5kJ0aRJwiobibLvl4cCAluz
	uLLSyJJWccJG9IzNtjQyCt4/DKw4Sx0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E6C134B0
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 14:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JnXgDVkTe2VmGwAAn2gu4w
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 14:38:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.6.3
Date: Thu, 14 Dec 2023 15:38:07 +0100
Message-ID: <20231214143808.23656-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z7UgHxmn;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=fail (smtp-out2.suse.de: domain of dsterba@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=dsterba@suse.com
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	 NEURAL_HAM_SHORT(-0.18)[-0.903];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[40.47%];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(0.00)[-all];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAM_FLAG(5.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 WHITELIST_DMARC(-7.00)[suse.com:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.01
X-Rspamd-Queue-Id: 3ED761FDB3

Hi,

btrfs-progs version 6.6.3 have been released. This is a bugfix and minor
feature release.

Changelog:
  * subvol create: accept multiple arguments
  * subvol delete: print the subvolume id in the output
  * subvol sync: check if the filesystems is still writeable so it does not
    wait indefinitely
  * device delete: add a timeout and warning when deleting multiple devices
  * scrub status: report limit if set in sysfs/../scrub_speed_max
  * scrub limit: new command to show or set the per-device scrub limits
  * scrub start: report the limit if set
  * build:
    * fix CPU feature detection on aarch64
    * support Botan and OpenSSL (3.2+) as crypto backends
  * other:
    * documentation updates, RTD config update
    * new and updated tests
    * CI updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.6.2

