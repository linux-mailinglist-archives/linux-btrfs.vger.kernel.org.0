Return-Path: <linux-btrfs+bounces-11266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA35A26D37
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 09:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC81886B24
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0B2066F0;
	Tue,  4 Feb 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bkaa4UP/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bkaa4UP/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81F86358
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657446; cv=none; b=nvBwb+IJqQb1+qYH42b/2RmZtJhwihfaCIl0wiGl1tJNSmq3KXzWRqTg2PNXbfFx/sjs0v8OHlYArqVLeH7Jjbyqu5IlgOrtoIi+hH7utbrA7u5a7dDAEkarinePMQzRxg18E2fIo6GsMX/MXzudkeRhiZRt5WN5H3RtjJSz9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657446; c=relaxed/simple;
	bh=0vL4Ymzg5GwfuC2DDfLn+4m+5cGL5fVFKy/rTt3evqU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Na/EJ0hJEWQMhJN3sx1U9RBAiJzEhWdDr0KqX3eilkquZGr+Sk1zMAreIJ0KhbFU/6X+vSael5+5zHNN8ARhemKBoBJ38pJrcB2F88OR2ya8JvJmLPUcfTfF7U8i2U4FY+p7qzBQ2jmi1fVNraXEcX4cXp1z3hJ2pEw8Tw6VDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bkaa4UP/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bkaa4UP/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890D721109
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738657442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4Cr1/ka8jvOl58sTcHDUifD5MfO/JezbsLHkUVSkLc=;
	b=Bkaa4UP/PZt9n86oStJ/+EVbfa3kpBgaJQY4AWTa/zfeuz4Sw6eo4SG8CuK4xhu/t3Smeu
	2ozg9J/vv+dydZ3m5LfVQP1V5roTmdeGAnvAFyjh2DdaHU0CIgpJwtKMeTnN45f9p0oxWt
	ndTV5MIM5rBNJT4IPd+/A8mQkZaGaYg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Bkaa4UP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738657442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4Cr1/ka8jvOl58sTcHDUifD5MfO/JezbsLHkUVSkLc=;
	b=Bkaa4UP/PZt9n86oStJ/+EVbfa3kpBgaJQY4AWTa/zfeuz4Sw6eo4SG8CuK4xhu/t3Smeu
	2ozg9J/vv+dydZ3m5LfVQP1V5roTmdeGAnvAFyjh2DdaHU0CIgpJwtKMeTnN45f9p0oxWt
	ndTV5MIM5rBNJT4IPd+/A8mQkZaGaYg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4B7113795
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 08:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sO+CIaHOoWdFagAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2025 08:24:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: scrub: add the new -t option to set the limit at runtime
Date: Tue,  4 Feb 2025 18:53:44 +1030
Message-ID: <af7ddf3a70eac6363fa09bd8f26a44afdf34010d.1738657422.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 890D721109
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

I know there is already `btrfs scrub limit` command to set the limit,
but a lot of users are not aware of that command.

Thus adding a new option `-t <throughput_limit>` to `btrfs scrub start`.

This has some extra behavior compared to `btrfs scrub limit`:

- Only set the value for the involved scrub device(s)
  If it's a full fs scrub, it will be the same as
  `btrfs scrub limit -a -l <value>`.
  If it's a single device, it will bt the same as
  `btrfs scrub limit -d <devid> -l <value>`.

- Automatically reset the limit after scrub is finished

- It only needs one single command line to set the limit

Issue: #943
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
RFC:
I'm not sure if this is really needed since we already have `btrfs scrub
limit`.
Involved tools like btrfs-maintenance scripts should have such support,
but to my surprise, David introduced the `btrfs scrub limit` but not
adding any support to btrfs-maintenance.
---
 Documentation/btrfs-scrub.rst |  9 ++++++++-
 cmds/scrub.c                  | 23 ++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.rst
index be106a551ade..de097bf79177 100644
--- a/Documentation/btrfs-scrub.rst
+++ b/Documentation/btrfs-scrub.rst
@@ -69,7 +69,7 @@ resume [-BdqrR] <path>|<device>
 
 .. _man-scrub-start:
 
-start [-BdrRf] <path>|<device>
+start [-BdrRft] <path>|<device>
         Start a scrub on all devices of the mounted filesystem identified by
         *path* or on a single *device*. If a scrub is already running, the new
         one will not start. A device of an unmounted filesystem cannot be
@@ -96,6 +96,13 @@ start [-BdrRf] <path>|<device>
                 can avoid writes from scrub.
         -R
                 raw print mode, print full data instead of summary
+	-t <throughput_limit>
+		set the scrub throughput limit for each device, acts the same as
+		``btrfs scrub limit -a -l <throughput_limit>``.
+
+		The value is bytes per second, and accept the usual KMGT prefixes.
+		After the scrub is finished, the throughput limit will be reset to
+		zero (aka, no limit).
         -f
                 force starting new scrub even if a scrub is already running,
                 this can useful when scrub status file is damaged and reports a
diff --git a/cmds/scrub.c b/cmds/scrub.c
index b2cdc924df97..bcdbac5fa40d 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1265,11 +1265,12 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	struct scrub_progress_cycle spc;
 	pthread_mutex_t spc_write_mutex = PTHREAD_MUTEX_INITIALIZER;
 	void *terr;
+	u64 throughput = 0;
 	u64 devid;
 	bool force = false;
 	bool nothing_to_resume = false;
 
-	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
+	while ((c = getopt(argc, argv, "BdqrRc:n:ft")) != -1) {
 		switch (c) {
 		case 'B':
 			do_background = false;
@@ -1291,6 +1292,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		case 'c':
 			ioprio_class = (int)strtol(optarg, NULL, 10);
 			break;
+		case 't':
+			throughput = arg_strtou64_with_suffix(optarg);
+			break;
 		case 'n':
 			ioprio_classdata = (int)strtol(optarg, NULL, 10);
 			break;
@@ -1389,6 +1393,12 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	for (i = 0; i < fi_args.num_devices; ++i) {
 		devid = di_args[i].devid;
+		ret = write_scrub_device_limit(fdmnt, devid, throughput);
+		if (ret < 0) {
+			errno = -ret;
+			warning("failed to set scrub throughput limit on devid %llu: %m",
+				devid);
+		}
 		ret = pthread_mutex_init(&sp[i].progress_mutex, NULL);
 		if (ret) {
 			errno = ret;
@@ -1568,6 +1578,16 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	err = 0;
 	for (i = 0; i < fi_args.num_devices; ++i) {
+		/* We have set the limit, now reset it to 0. */
+		if (throughput) {
+			ret = write_scrub_device_limit(fdmnt, di_args[i].devid, 0);
+			if (ret < 0) {
+				errno = -ret;
+				warning("failed to reset scrub throughput limit on devid %llu: %m",
+					di_args[i].devid);
+			}
+		}
+
 		if (sp[i].skip)
 			continue;
 		devid = di_args[i].devid;
@@ -1713,6 +1733,7 @@ static const char * const cmd_scrub_start_usage[] = {
 	OPTLINE("-c", "set ioprio class (see ionice(1) manpage)"),
 	OPTLINE("-n", "set ioprio classdata (see ionice(1) manpage)"),
 	OPTLINE("-f", "force starting new scrub even if a scrub is already running this is useful when scrub stats record file is damaged"),
+	OPTLINE("-t", "set the throughput limit for each device"),
 	OPTLINE("-q", "deprecated, alias for global -q option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
-- 
2.48.1


