Return-Path: <linux-btrfs+bounces-11315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C3A29FB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 05:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52B8160F0A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 04:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126915B99E;
	Thu,  6 Feb 2025 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8XHxiVm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8XHxiVm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D63B1A4
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816643; cv=none; b=lLWFOb8Gpe5PCxqQdx9J8yTwhq+/cr+L9Mtsw3jgWksDsRaNFOrSTZvjuKOhJESb5LHFYfhekwt8hJL37GRhh8iAitUq8XuAn8sVnZmnFfOFSwSLwCV5UP14gV9Pb6qhKGnKHIcDu9XUWu4Ngxd3QDulQ3xUqnTzVsnx0gjJt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816643; c=relaxed/simple;
	bh=Ks4iDcFCjgzcQdSuMjVFv7x/Sl8+47UWMQ4zCI8DJdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FYH7aqP5cFiu3lQ++lhptog1nQN6Uq/VqF2wP3+JoDqFWUZkgPv0GYtCpBGKHMPD2jhhxQPJ1NiH+V8Pnm4MI6vJLIgKTFxdvRndQuaIwsnjLcShC5Aq6lgC4QDI3AXe1fajEyJ+aHzqVMDCovDeVHUZVEvQfnayBkx9ofooRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8XHxiVm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8XHxiVm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27D251F381
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 04:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738816638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jvdO0UuGpRl31A5AlF67VGBk8mEtvLnOXLfndfpvFnI=;
	b=V8XHxiVm9ru3RPHyMF/7fX27Po+ftirLMBHIFNm9DeinyYRHOn+nratfgegurhDLkdUCit
	fRShxa2HkO0KWYveEdb0GEq3b2B89KakaRGnhmjPI+R3a24KOZqqWXROD+xigRuyBaDpaE
	hLCs8PMxPO9TxhfUmtsGg9QiTq73Gns=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738816638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jvdO0UuGpRl31A5AlF67VGBk8mEtvLnOXLfndfpvFnI=;
	b=V8XHxiVm9ru3RPHyMF/7fX27Po+ftirLMBHIFNm9DeinyYRHOn+nratfgegurhDLkdUCit
	fRShxa2HkO0KWYveEdb0GEq3b2B89KakaRGnhmjPI+R3a24KOZqqWXROD+xigRuyBaDpaE
	hLCs8PMxPO9TxhfUmtsGg9QiTq73Gns=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC2813694
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 04:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 33VHCH08pGfHdQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2025 04:37:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: scrub: add the new --limit option to set the throughput limit at runtime
Date: Thu,  6 Feb 2025 15:06:59 +1030
Message-ID: <5fd8e0787ea103687fe1a04e96ff8f127fb538f4.1738816581.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Add a new option `--limit <throughput_limit>` to `btrfs scrub start`.

This has some extra behavior differences compared to `btrfs scrub limit`:

- Only set the value for the involved scrub device(s)
  If it's a full fs scrub, it will be the same as
  `btrfs scrub limit -a -l <value>`.
  If it's a single device, it will bt the same as
  `btrfs scrub limit -d <devid> -l <value>`.

- Automatically revert to the old limit after scrub is finished

- It only needs one single command line to set the limit

Issue: #943
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
RFC->v1:
- Use longer option '--limit' instead
- Update the docs and helper strings
- Save and revert to the older limit values after scrub is finished
---
 Documentation/btrfs-scrub.rst | 13 ++++++++++++-
 cmds/scrub.c                  | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.rst
index be106a551ade..fe8dd97c5f7a 100644
--- a/Documentation/btrfs-scrub.rst
+++ b/Documentation/btrfs-scrub.rst
@@ -69,7 +69,7 @@ resume [-BdqrR] <path>|<device>

 .. _man-scrub-start:

-start [-BdrRf] <path>|<device>
+start [options] <path>|<device>
         Start a scrub on all devices of the mounted filesystem identified by
         *path* or on a single *device*. If a scrub is already running, the new
         one will not start. A device of an unmounted filesystem cannot be
@@ -96,6 +96,17 @@ start [-BdrRf] <path>|<device>
                 can avoid writes from scrub.
         -R
                 raw print mode, print full data instead of summary
+	--limit <limit>
+		set the scrub throughput limit for each device.
+
+		If the scrub is for the whole fs, it's the same as
+		:command:`btrfs scrub limit -a -l <value>`.
+		If the scrub is for a single device, it's the same as
+		:command:`btrfs scrub limit -d <devid> -l <value>`.
+
+		The value is bytes per second, and accepts the usual KMGT prefixes.
+		After the scrub is finished, the throughput limit will be reset to
+		the old value of each device.
         -f
                 force starting new scrub even if a scrub is already running,
                 this can useful when scrub status file is damaged and reports a
diff --git a/cmds/scrub.c b/cmds/scrub.c
index b2cdc924df97..23af1628099b 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -97,6 +97,7 @@ struct scrub_progress {
 	pthread_mutex_t progress_mutex;
 	int ioprio_class;
 	int ioprio_classdata;
+	u64 old_limit;
 	u64 limit;
 };

@@ -1230,7 +1231,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	int fdres = -1;
 	int ret;
 	pid_t pid;
-	int c;
 	int i;
 	int err = 0;
 	int e_uncorrectable = 0;
@@ -1265,11 +1265,22 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	struct scrub_progress_cycle spc;
 	pthread_mutex_t spc_write_mutex = PTHREAD_MUTEX_INITIALIZER;
 	void *terr;
+	u64 throughput_limit = 0;
 	u64 devid;
 	bool force = false;
 	bool nothing_to_resume = false;

-	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
+	while (1) {
+		int c;
+		enum { GETOPT_VAL_LIMIT = GETOPT_VAL_FIRST };
+		static const struct option long_options[] = {
+			{"limit", required_argument, NULL, GETOPT_VAL_LIMIT},
+			{ NULL, 0, NULL, 0 }
+		};
+
+		c = getopt_long(argc, argv, "BdqrRc:n:f", long_options, NULL);
+		if (c < 0)
+			break;
 		switch (c) {
 		case 'B':
 			do_background = false;
@@ -1297,6 +1308,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		case 'f':
 			force = true;
 			break;
+		case GETOPT_VAL_LIMIT:
+			throughput_limit = arg_strtou64_with_suffix(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -1389,6 +1403,13 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,

 	for (i = 0; i < fi_args.num_devices; ++i) {
 		devid = di_args[i].devid;
+		sp[i].old_limit = read_scrub_device_limit(fdmnt, devid);
+		ret = write_scrub_device_limit(fdmnt, devid, throughput_limit);
+		if (ret < 0) {
+			errno = -ret;
+			warning("failed to set scrub throughput limit on devid %llu: %m",
+				devid);
+		}
 		ret = pthread_mutex_init(&sp[i].progress_mutex, NULL);
 		if (ret) {
 			errno = ret;
@@ -1568,6 +1589,14 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,

 	err = 0;
 	for (i = 0; i < fi_args.num_devices; ++i) {
+		/* Revert to the older scrub limit. */
+		ret = write_scrub_device_limit(fdmnt, di_args[i].devid, sp[i].old_limit);
+		if (ret < 0) {
+			errno = -ret;
+			warning("failed to reset scrub throughput limit on devid %llu: %m",
+				di_args[i].devid);
+		}
+
 		if (sp[i].skip)
 			continue;
 		devid = di_args[i].devid;
@@ -1713,6 +1742,7 @@ static const char * const cmd_scrub_start_usage[] = {
 	OPTLINE("-c", "set ioprio class (see ionice(1) manpage)"),
 	OPTLINE("-n", "set ioprio classdata (see ionice(1) manpage)"),
 	OPTLINE("-f", "force starting new scrub even if a scrub is already running this is useful when scrub stats record file is damaged"),
+	OPTLINE("--limit", "set the throughput limit for each device"),
 	OPTLINE("-q", "deprecated, alias for global -q option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
--
2.48.1


