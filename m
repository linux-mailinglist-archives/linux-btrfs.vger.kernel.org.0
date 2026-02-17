Return-Path: <linux-btrfs+bounces-21698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN7eLxsqlGlTAQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21698-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 09:43:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8414A138
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 09:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8124630292FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF952EF64F;
	Tue, 17 Feb 2026 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmPrPIef"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3EF1FC7C5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317773; cv=none; b=bBejNFXvnl5ka4j4TxyqbEnUOoSweH+9LB6cjbe2xlOqBuukhs8NIJoeeq140taQKHJWnw3BkPjdbEasTAvjqUdLgEtRtZx2XnUiirX19VstU+u9v1EnWaw5v5onHkxlewf33YrFG5p8RyRALEikU4H8OjpBZQcrbb5sJH2aG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317773; c=relaxed/simple;
	bh=K2FQH7PpMIibguGrGrhzt8FddGrBV6kQkMRnHRoduiQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EVxOVh7z/d3G8D9G0NVLKEuSTjzGqLw66XCZ5cjrM8A2PBKL9E7vcKQlWEe7UxW4D/mgqEfls7e5hp7lFOPbd2vKCgudtvkQnqSyq4n03f/dDsREWXnMdwum+eo+60Br69/oXAtqG+iX7mBRjnK/cIpk3tpfgdGOUADtZeULTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmPrPIef; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e6491f1a2so4152513e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 00:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771317770; x=1771922570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpq2RAxNFCz9UvUxD0Qdy48glGRDkBg6Q4EVfiWiPYg=;
        b=FmPrPIef+xL52xBgswt0GbtOACk39NoDnA2M8XT5aQp+yydacCOUqEeSICQNFU4Has
         96PUUF92GrV2T+OIkAVP0TjVxLLVbfwM9ZBBPT79NRsHe9rVoPYWDVqLJcycRnlfuRuq
         yea3DDvBMuqcZeZuYL9OOWec7nUZxFj+nAiAXQshPkaLgGkGzsRLs4WOLtF90PS5spTf
         aJgcpxBaGrUKfW7nm3pfDOFSHn7kOwlKokqfaVocWn6YGFoxUZ82MCMpruVKbbhNhM3F
         99At2fYOR9OVAP837+YydiSYhT8AtT/W3yCApeuQ5D40EkZFUmlNzxvlAfrKhGq4MbYr
         d5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771317770; x=1771922570;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fpq2RAxNFCz9UvUxD0Qdy48glGRDkBg6Q4EVfiWiPYg=;
        b=ejxvhnoXFmO4I6/67OpnNcQPNoporcG9bsJBT9AWA4nhz4Dkv+/oiIL1lQ0bOiPQAx
         1DwnZox/BAirZmojh36rLbkjrG+OeQW5pYtnSb5yHrgmAlloFUx/nFz6UUzXFT5vKlpb
         yY4NY4tvdt5l8z1T7VcE7SYorqPJTmgtwEj5Sn6BXIpbVDEwyB4b7KsLqQ1MYrdWT5Hk
         jxeha8lCpmVz52kXavuoo+5L0/qF5aBc5Mt4m2qUluqizQnVNOcVT163aev9rd6SNXAe
         RGbr99S5J776uBagPGp3rAUS4/f5mHmLacfRZiAmAcrc4OZhaL3THKibvHFuYvuOcb0I
         P6EQ==
X-Gm-Message-State: AOJu0YwLLFPOouwSuCfMiSHD7PN00+ynM99dLHfjtu6rOKKO04/Isvfv
	M9kKyrOuwXKvHIJWlNCxRoc+0Vf3TAmhWXexFOxoAcJPfrnn4qyN0cwp
X-Gm-Gg: AZuq6aJQkek+eZ92GArxp+2eLumi4th4328w/WMXUQB9p2HnW+5kl/qa94erhP9R8Mm
	JrLpihiTEnE2+H2ZeM/iZaryeGMmJFqk2DgZwqiF1c8IjnIuEusnRN8LeUT9OeKRuQgLHKrXVvM
	Rx+PegLivDn9hhwrxxAMUt3UmFX53jhwq9OPIc1kUXh2EhTc34+/YF4p2IYA+i1BMjgpaeHmSKT
	8XtUBn9A88F/ucS60vl/0szwlWj7KjfYTgbLJby5G2daUJDqXvKATVcSibaxY1g6nt3yS/vQaWR
	jWN84u6ejT/WlYNCD6N8sn310kQCZ0cESLrPf/+wIvoRK+xHMYggZZ2jLLonpIeZqXPbDbsI6lr
	M7HNF+zpBVa7M2MYVpQwc/swVFGO+lrly4FVOJUQfUBv7Ea5M8dkYDv2W2fTsahkUS/Cx+9xGyN
	Vk8tlZLsOYpVFZ8PsSwTvyCipB1qbDJWDNVP/8WNjSo7j9
X-Received: by 2002:a05:6512:239d:b0:59e:4f90:44e1 with SMTP id 2adb3069b0e04-59f6cfcbf5bmr3881569e87.10.1771317770226;
        Tue, 17 Feb 2026 00:42:50 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a5096sm3723433e87.47.2026.02.17.00.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:42:49 -0800 (PST)
Message-ID: <af8c15fa-4e41-4bb2-885c-0bc4e97532a6@gmail.com>
Date: Tue, 17 Feb 2026 11:42:49 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: File size is not persisted after opening the file with O_TRUNC flag
 and creating hard link if system crashes
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21698-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CD8414A138
X-Rspamd-Action: no action

Detailed description
====================

Hello, there seems to be an issue with btrfs crash behavior:

1. Create an empty file in a directory.
2. Fill file with data (e.g. truncate) and sync the file.
3. Open file with O_TRUNC flag (should set size to 0) and sync the file.
4. Create a new hard link to the file in the same directory.
5. Sync the directory.

After system crash the file will have the old size (>0) even though the 
file was synced after truncating (O_TRUNC).


System info
===========

Linux version 6.19.2


How to reproduce
================

```
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
   int status;
   int file_fd;
   int dir_fd;

   status = creat("file1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("CREAT: %d\n", status);

   status = truncate("file1", 1000);
   printf("TRUNCATE: %d\n", status);

   sync();

   status = open("file1", O_RDWR | O_TRUNC);
   printf("OPEN: %d\n", status);
   file_fd = status;

   status = fsync(file_fd);
   printf("FSYNC: %d\n", status);

   status = open(".", O_RDONLY | O_DIRECTORY);
   printf("OPEN: %d\n", status);
   dir_fd = status;

   status = link("file1", "file2");
   printf("LINK: %d\n", status);

   status = fsync(dir_fd);
   printf("FSYNC: %d\n", status);
}
// file size is 1000 instead of 0
```

Steps:

1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that file size is 1000 instead of 0.

