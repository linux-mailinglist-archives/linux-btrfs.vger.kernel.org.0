Return-Path: <linux-btrfs+bounces-21740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNKlEa9slWkKRAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21740-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 08:39:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A14ED153BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BDB3018BF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8C2F6930;
	Wed, 18 Feb 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQm4ltYy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72338D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771400357; cv=none; b=WGrnDpsl1+7sGFTbzWaF8fILemwnssRmDdL6NlYwa+mah6wm3PTrUHWffadZYDhbc5X6SV+HWK6WG+1jn+npKQNt1bY+xcbL1xNlXHFcZxjsD94T7okS9FP2awp0G/E9pnOPY2Kb2WznLyXbWFwb9XELMm3+Cf7NMHh+bjKVLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771400357; c=relaxed/simple;
	bh=MHzMyXHVqbJF9vGiGKG4pQ4ukEwBiCcvL+vIdjTNy0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUG3K36R5Fox/8mxLazJRqN+1ZpKzOLe+WoT2Yuy3SI9lQit5UXWBchhjeIG14Zcm92YcVoV9H10AIlvd6JG4IL8V6aa+CVWg0k0ak+6jrfPPzXmxEB07yMH4WcQow9NdrU+qXzzOdq9PhfEkoF8gcEpgJlhCnOZlbguyhgA70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQm4ltYy; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c383f2fcso3332919a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771400355; x=1772005155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZvYMk6UvWxQGOjP2z212job4z6ccMU4mV8ezITHVZM=;
        b=UQm4ltYy9t3lEOtCzMygmDXqm0aeZT5hUHqbZvopHMxt7xCOABpryfMHvvLArIY3XD
         /luilXHQmp9h3X1N0vD3nPx2Ja/upVwHEl56QHsdh8myjXN7umCLlbEbI/80C7K5f29t
         hflxOzPRCuSgMc59R3NSbxkM/LMzAQcLmHLSHKHRVtvEHxGGc0lzk2pSLcBLvlpUdk8j
         EYVyybMtCepV64WdoZeF7bt0ZwN6i1JAudf7eifHHAcaFA2GmLe6B0TO809ox/b3KGZQ
         y2SvGmc0h5XklZr4fa/mXHwD/h+iSiBZyRro7pypEg/y2FZVr25Cd6yJCeNHVSTm3BWi
         fUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771400355; x=1772005155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZvYMk6UvWxQGOjP2z212job4z6ccMU4mV8ezITHVZM=;
        b=Vj4kN9sv9TYGWaqNs02kPp27Vdw9PnMZSwCsGGlS7gV8R1juppKVM3mVPyZ8PiUsvq
         xaAqbeoz8TQlSV5pa3lSROdIn90v/ug1ZcmHR1bFX5gge1IYgSzo6HUdZ5OAa6dGe8r2
         GdwlPZw2N0dhoNps2n+8J53f23VeRbJyIx/rJMo2l7ZifC896J0m28Otf33l6et3iQ5i
         5eqMwPISmJ0QQ2LcEx2/GRc1JGUvl9c4NTMyHSOqYlzVaCJS0USZHR4j12OlW97Fu6pn
         yzWkDhTIZROfYrLog6jyc9iVl262VIDIcPTLuYODYiIBrX+uijEar5UXG34N3k8Xpk8A
         3rdw==
X-Gm-Message-State: AOJu0YwR1MTgbKapTs5ePsvYCZ/0FrLirg8/Q9KwkY0zZl/LsIQELsan
	MMmVMnsEZ3o14CAtnRk/HUzZwgcl7ckO0IX7J9Kq5b5bBHmACT0M9M+sqEjMVILG
X-Gm-Gg: AZuq6aKaOMoLmB6DfVJyMdPUCIamXW91vcUmEJjFpnuunZN8aurNKN7G3fLTVP+PS/3
	DuPoxszsfSO0KcIQZettFsnxysBwRM5oM4a4oALpTBXi2NqOmT5N1m0dNnxiq8mmrYws77upgXN
	vUqZcBO/RJJ910GZG5OXE4jhicu/KfT+gei4mPPNt0bgnVu9fAgpOP7/7MxDcp81uzRTaoTPvMX
	6fBVgDB24xEv2WYvFgHrf8ASpeFfJHb7dgtWc7NcgMQwzm4OuG8EqCmTK1Mw+RPR1JU3NwgYrnq
	AXY8xhxqk3V6oy7D9/42ClZjT0MvHIY7+AVyr79Lw6Oe8xMpdvAb1QA2UPsgIN7QZBz2aOmPoIv
	JY8apvNSZ6IQaAQVNI1NEnDuKc6BcfZ77qSPDijec36tZxrYqaM2/c2Jj+eSYvDBF+M/8V3ww2H
	L2oZkrSFzGT6wIYaZNzL681YODJLVfm/NavrmA
X-Received: by 2002:a05:6830:6601:b0:7d4:96c3:3f97 with SMTP id 46e09a7af769-7d505dad2b2mr731411a34.2.1771400354931;
        Tue, 17 Feb 2026 23:39:14 -0800 (PST)
Received: from gamma.attlocal.net ([2600:1700:5ae0:ae0:7bc1:6088:681:9c27])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4cfecfd7dsm10785821a34.8.2026.02.17.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 23:39:14 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Illia Bobyr <illia.bobyr@gmail.com>
Subject: [PATCH] btrfs-progs: balance: refactor parse_filters()
Date: Tue, 17 Feb 2026 23:39:07 -0800
Message-ID: <20260218073908.3927870-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21740-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illiabobyr@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A14ED153BB9
X-Rspamd-Action: no action

Almost all of the parse_filters() function body is wrapped in a loop. By
moving parsing of a single filter into a separate function we reduce
indentation, and makes it a bit easier to follow the top level parsing
logic.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 cmds/balance.c | 230 +++++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 111 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index d6296..31aa6 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -90,6 +90,123 @@ static void print_range_u32(u32 start, u32 end)
 		printf("%u", end);
 }
 
+static int parse_one_filter(char *name, char *value,
+			    struct btrfs_balance_args *args)
+{
+	if (strcmp(name, "profiles") == 0) {
+		if (!value || !*value) {
+			error("the profiles filter requires an argument");
+			return 1;
+		}
+		if (parse_profiles(value, &args->profiles)) {
+			error("invalid profiles argument");
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_PROFILES;
+	} else if (strcmp(name, "usage") == 0) {
+		if (!value || !*value) {
+			error("the usage filter requires an argument");
+			return 1;
+		}
+		if (parse_u64(value, &args->usage)) {
+			if (parse_range_u32(value, &args->usage_min,
+					    &args->usage_max)) {
+				error("invalid usage argument: %s", value);
+				return 1;
+			}
+			if (args->usage_max > 100) {
+				error("invalid usage argument: %s", value);
+				return 1;
+			}
+			args->flags &= ~BTRFS_BALANCE_ARGS_USAGE;
+			args->flags |= BTRFS_BALANCE_ARGS_USAGE_RANGE;
+		} else {
+			if (args->usage > 100) {
+				error("invalid usage argument: %s", value);
+				return 1;
+			}
+			args->flags &= ~BTRFS_BALANCE_ARGS_USAGE_RANGE;
+			args->flags |= BTRFS_BALANCE_ARGS_USAGE;
+		}
+	} else if (strcmp(name, "devid") == 0) {
+		if (!value || !*value) {
+			error("the devid filter requires an argument");
+			return 1;
+		}
+		if (parse_u64(value, &args->devid) || args->devid == 0) {
+			error("invalid devid argument: %s", value);
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_DEVID;
+	} else if (strcmp(name, "drange") == 0) {
+		if (!value || !*value) {
+			error("the drange filter requires an argument");
+			return 1;
+		}
+		if (parse_range_strict(value, &args->pstart, &args->pend)) {
+			error("invalid drange argument");
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_DRANGE;
+	} else if (strcmp(name, "vrange") == 0) {
+		if (!value || !*value) {
+			error("the vrange filter requires an argument");
+			return 1;
+		}
+		if (parse_range_strict(value, &args->vstart, &args->vend)) {
+			error("invalid vrange argument");
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_VRANGE;
+	} else if (strcmp(name, "convert") == 0) {
+		if (!value || !*value) {
+			error("the convert option requires an argument");
+			return 1;
+		}
+		if (parse_one_profile(value, &args->target)) {
+			error("invalid convert argument");
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_CONVERT;
+	} else if (strcmp(name, "soft") == 0) {
+		args->flags |= BTRFS_BALANCE_ARGS_SOFT;
+	} else if (strcmp(name, "limit") == 0) {
+		if (!value || !*value) {
+			error("the limit filter requires an argument");
+			return 1;
+		}
+		if (parse_u64(value, &args->limit)) {
+			if (parse_range_u32(value, &args->limit_min,
+					    &args->limit_max)) {
+				error("Invalid limit argument: %s",
+				       value);
+				return 1;
+			}
+			args->flags &= ~BTRFS_BALANCE_ARGS_LIMIT;
+			args->flags |= BTRFS_BALANCE_ARGS_LIMIT_RANGE;
+		} else {
+			args->flags &= ~BTRFS_BALANCE_ARGS_LIMIT_RANGE;
+			args->flags |= BTRFS_BALANCE_ARGS_LIMIT;
+		}
+	} else if (strcmp(name, "stripes") == 0) {
+		if (!value || !*value) {
+			error("the stripes filter requires an argument");
+			return 1;
+		}
+		if (parse_range_u32(value, &args->stripes_min,
+				    &args->stripes_max)) {
+			error("invalid stripes argument");
+			return 1;
+		}
+		args->flags |= BTRFS_BALANCE_ARGS_STRIPES_RANGE;
+	} else {
+		error("unrecognized balance filter: %s", name);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int parse_filters(char *filters, struct btrfs_balance_args *args)
 {
 	char *this_char;
@@ -104,118 +221,9 @@ static int parse_filters(char *filters, struct btrfs_balance_args *args)
 	     this_char = strtok_r(NULL, ",", &save_ptr)) {
 		if ((value = strchr(this_char, '=')) != NULL)
 			*value++ = 0;
-		if (strcmp(this_char, "profiles") == 0) {
-			if (!value || !*value) {
-				error("the profiles filter requires an argument");
-				return 1;
-			}
-			if (parse_profiles(value, &args->profiles)) {
-				error("invalid profiles argument");
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_PROFILES;
-		} else if (strcmp(this_char, "usage") == 0) {
-			if (!value || !*value) {
-				error("the usage filter requires an argument");
-				return 1;
-			}
-			if (parse_u64(value, &args->usage)) {
-				if (parse_range_u32(value, &args->usage_min,
-							&args->usage_max)) {
-					error("invalid usage argument: %s",
-						value);
-					return 1;
-				}
-				if (args->usage_max > 100) {
-					error("invalid usage argument: %s",
-						value);
-				}
-				args->flags &= ~BTRFS_BALANCE_ARGS_USAGE;
-				args->flags |= BTRFS_BALANCE_ARGS_USAGE_RANGE;
-			} else {
-				if (args->usage > 100) {
-					error("invalid usage argument: %s",
-						value);
-					return 1;
-				}
-				args->flags &= ~BTRFS_BALANCE_ARGS_USAGE_RANGE;
-				args->flags |= BTRFS_BALANCE_ARGS_USAGE;
-			}
-		} else if (strcmp(this_char, "devid") == 0) {
-			if (!value || !*value) {
-				error("the devid filter requires an argument");
-				return 1;
-			}
-			if (parse_u64(value, &args->devid) || args->devid == 0) {
-				error("invalid devid argument: %s", value);
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_DEVID;
-		} else if (strcmp(this_char, "drange") == 0) {
-			if (!value || !*value) {
-				error("the drange filter requires an argument");
-				return 1;
-			}
-			if (parse_range_strict(value, &args->pstart, &args->pend)) {
-				error("invalid drange argument");
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_DRANGE;
-		} else if (strcmp(this_char, "vrange") == 0) {
-			if (!value || !*value) {
-				error("the vrange filter requires an argument");
-				return 1;
-			}
-			if (parse_range_strict(value, &args->vstart, &args->vend)) {
-				error("invalid vrange argument");
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_VRANGE;
-		} else if (strcmp(this_char, "convert") == 0) {
-			if (!value || !*value) {
-				error("the convert option requires an argument");
-				return 1;
-			}
-			if (parse_one_profile(value, &args->target)) {
-				error("invalid convert argument");
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_CONVERT;
-		} else if (strcmp(this_char, "soft") == 0) {
-			args->flags |= BTRFS_BALANCE_ARGS_SOFT;
-		} else if (strcmp(this_char, "limit") == 0) {
-			if (!value || !*value) {
-				error("the limit filter requires an argument");
-				return 1;
-			}
-			if (parse_u64(value, &args->limit)) {
-				if (parse_range_u32(value, &args->limit_min,
-							&args->limit_max)) {
-					error("Invalid limit argument: %s",
-					       value);
-					return 1;
-				}
-				args->flags &= ~BTRFS_BALANCE_ARGS_LIMIT;
-				args->flags |= BTRFS_BALANCE_ARGS_LIMIT_RANGE;
-			} else {
-				args->flags &= ~BTRFS_BALANCE_ARGS_LIMIT_RANGE;
-				args->flags |= BTRFS_BALANCE_ARGS_LIMIT;
-			}
-		} else if (strcmp(this_char, "stripes") == 0) {
-			if (!value || !*value) {
-				error("the stripes filter requires an argument");
-				return 1;
-			}
-			if (parse_range_u32(value, &args->stripes_min,
-					    &args->stripes_max)) {
-				error("invalid stripes argument");
-				return 1;
-			}
-			args->flags |= BTRFS_BALANCE_ARGS_STRIPES_RANGE;
-		} else {
-			error("unrecognized balance option: %s", this_char);
+
+		if (parse_one_filter(this_char, value, args))
 			return 1;
-		}
 	}
 
 	return 0;
-- 
2.51.0


