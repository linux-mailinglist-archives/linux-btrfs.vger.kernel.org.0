Return-Path: <linux-btrfs+bounces-17841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3502BDE69D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39909504844
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4646326D61;
	Wed, 15 Oct 2025 12:12:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BD324B17
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530341; cv=none; b=rTSkooRP8agPBPzOV8u36LjTHeuivKuPisaZsdJXAuvnovF4UOGBLTfwIjr5u/dDKQiua45fi62LIlKU82JRKVKeU1pWj0k6OE5berq18OeIJv71y78DO800CCzBwONy+9VA6S0Ku2RKozfVb37YNzH4nYiGHZASGQQnQyzWAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530341; c=relaxed/simple;
	bh=TVjk+sN829384qmE1KzGYS3h7+rR3MsH4XWHy+VT1ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcbM/Jwyq6rmzSojVgGYavYV8zhglYVUMoJZBts9c1vdpwhfC7WZcoOS1+letOCHPSRn6H9reglOOzRxR58G4gt21DkA31KIc3w7P1Uoj1LqO8jf0o5JiBxw1Sc77tv493tqd7j8/DO8x3GgIBpIk5FcyC80xQSJRHB64ICWPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38C541FC05;
	Wed, 15 Oct 2025 12:12:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25E3D13A42;
	Wed, 15 Oct 2025 12:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eBDECJOP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:03 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 8/8] btrfs-progs: string-utils: do not escape space while printing
Date: Wed, 15 Oct 2025 14:11:56 +0200
Message-ID: <20251015121157.1348124-9-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
References: <20251015121157.1348124-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 38C541FC05
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Space is a valid printable character in C. On the other hand
string "\ " in fact results in an unknown escape sequence.

Fixes: 637563be ("btrfs-progs: send dump: introduce helper for printing escaped path")
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/string-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/string-utils.c b/common/string-utils.c
index e55c10c5..794639a0 100644
--- a/common/string-utils.c
+++ b/common/string-utils.c
@@ -88,7 +88,6 @@ int string_print_escape_special_len(const char *str, size_t str_len)
 		case '\r': putchar('\\'); putchar('r'); len++; break;
 		case '\t': putchar('\\'); putchar('t'); len++; break;
 		case '\v': putchar('\\'); putchar('v'); len++; break;
-		case ' ':  putchar('\\'); putchar(' '); len++; break;
 		case '\\': putchar('\\'); putchar('\\'); len++; break;
 		default:
 			  if (!isprint(c)) {
-- 
2.51.0


