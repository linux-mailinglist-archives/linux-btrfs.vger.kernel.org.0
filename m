Return-Path: <linux-btrfs+bounces-403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97A7FB4A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 09:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0801C21092
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2F1A29B;
	Tue, 28 Nov 2023 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793A1739
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 00:45:20 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0E9F1F390;
	Tue, 28 Nov 2023 08:45:18 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C7E2C139FC;
	Tue, 28 Nov 2023 08:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GtiqHJyoZWXSRAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 28 Nov 2023 08:45:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: william.brown@suse.com
Subject: [PATCH 0/3] btrfs-progs: subvolume-list: add qgroup sizes output
Date: Tue, 28 Nov 2023 19:14:50 +1030
Message-ID: <cover.1701160698.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_LONG(-0.93)[-0.933];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: E0E9F1F390
X-Spam: Yes

ZFS' management tool is way better received than btrfs-progs, one of the
user-friendly point is the default `zpool list`, which includes the size
of each subvolume.

I'm not sure how ZFS handles it, but for btrfs we need qgroups (or the
faster but slightly less accurate squota) to get the accurate numbers.

But considering a lot of distro is enabling qgroup by default for
exactly the same reason, and during the years qgroup itself is also
under a lot of optimization, I believe adding sizes output for `btrfs
subvolume list` is an overall benefit for end uesrs.

This patch would do exactly so, the output example is:

 # ./btrfs subv list -t /mnt/btrfs/
 ID	gen	top level	rfer	excl	path
 --	---	---------	----	----	----
 256	11	5		1064960	1064960	subvol1
 257	11	5		4210688	4210688	subvol2

The extra columns are added depending on if qgroup is enabled, and we
allow users to force such output, but if qgroup is not enabled and we're
forced to output such sizes, a warning would be outputted and fill all
the sizes value as 0.

Thanks William Brown for the UI suggestion.

Although there are still some pitfalls, mentioned in the last patch.

Qu Wenruo (3):
  btrfs-progs: separate root attributes into a dedicated structure from
    root_info
  btrfs-progs: use root_attr structure to pass various attributes
  btrfs-progs: subvolume-list: output qgroup sizes for subvolumes

 Documentation/btrfs-subvolume.rst |  12 +-
 cmds/subvolume-list.c             | 572 ++++++++++++++++++------------
 2 files changed, 349 insertions(+), 235 deletions(-)

--
2.42.1


