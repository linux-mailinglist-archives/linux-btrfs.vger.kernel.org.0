Return-Path: <linux-btrfs+bounces-22192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJQtDbYPp2k0cwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22192-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:43:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E91F4014
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDA663035E3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090293264F0;
	Tue,  3 Mar 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luj3ENW3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3102D370D6E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556125; cv=none; b=b2uUYgdV7/9MYIPbR8Grq8eptxiM9b3qM+gFaXmGR76L0IdkixXAkSUIuM3J5KKk6M463f0ux32hnv0UwxWLokLEoVi2Xmc7SHdvN/WSLQdoARPY/YuEaWl+hQCIpYBO2S/bZBjFi7aRD9UBL+MlWtB1R7TOXy2OkO1fwpL55s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556125; c=relaxed/simple;
	bh=rFQaSuWNtH9Qrnd75MRPuGQFSvJF/6cXdLlHAR/5dGc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MyDZxMdNaNoYrQzaqzAHEhISJxDIcHwBGFub+ihrzu7RwJ42sul0GUmmLkzwOHdFdpMlph5Yc2nu9aX7cJ4B4qgxOz1hfauUkOET5mPQHDVGXylhVOr6fbfxwM7Tx+X+vvjzIVXvWBv+bix6nZLfpJE/K3lKldklZwZUOloSsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luj3ENW3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3870df2331aso33225381fa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772556122; x=1773160922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTmOPKz1yOxTxeVLqX9puCNS+ZO1YkE6imS9w0aptKM=;
        b=luj3ENW3bloK/RIpoQzbdMMCEVpGlXGRVWhtdbxYclrvFDot+nz0L/CdevsatYN9dk
         MXR4CEYhKXHkwUzitnL9YL7O7zVbFNaxn+PCVNy+Q9rEGbuZMXCa95khwSdnIOdbs+5v
         0pE4EVecLMfHyl5R7NtLjtdrSOtTBMGVwOPMCX9/KlWZCsa03QCRXy2v7J9vaz98G+6k
         QIgILXFuIxnPVE6GqCGVfEDX3TPLAxOtoPGyxHAukBldM3Lpwuem/vl4dD8lrembTGhm
         cdweMkukX8NbNaiIj8rXYpE2cxSF2ARWsgD32drhOmD2PtE3aFr8BnJAIz35uewJ0y0X
         NKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556122; x=1773160922;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTmOPKz1yOxTxeVLqX9puCNS+ZO1YkE6imS9w0aptKM=;
        b=UJv4yOs9GuWVSU/FwZAzj34Ch55iFSfxzJpVclO1MAGjK+8cJWcqXKKfH4htUa+ieI
         USOcJm9ldIbIvSJpSoYn62QEi4daPya9XBWokqV95f0g+YnRIckcEBoSnwjDwZ4Ikgr+
         BhCWjXrMZOD/uZDiVLWs03RAMyE6gHpeXUjEJGaguagDoKouqd0oFEWYXjo/3UeHSF5d
         fJ4JkzkfyzT5MPzqkBzGwjEkaiD/JngozhhwkCungEFOujc3RaeIQFuyG+2b+XKwPRto
         GEoczhHn+cZ4LJbqhKso/wpBxYW7Eb/5YvwjC38FFsq43js+62J4HTbYFs7Ya+NSQeYa
         XyWw==
X-Gm-Message-State: AOJu0Ywdpag3JoJGzu15jkLCen8KWrDepdLTx01J4ffbw0H+dbNPKFzm
	qh51OnqvjIZi0CR1LBHC/zrj9GhIghuzrM7mQE2kFpU64vhPlxUvR9Mi
X-Gm-Gg: ATEYQzww3eb+CoM0ZS7Oh/AVMQHhSnyGwktEXVxxTSD61rsXOQxSSCp0a+Ycj4PpJs4
	/NBYA2he0dq/9QwsOVL3w5x5vbJgXvczViOmPfQHC8EuT0/TOsYmznRa3j5noUzbg58A8ZjJW0F
	4RlchdUdvlP0lwoSKo6slJyECv2jdQKnaSlYQkrpZPgVC3eF3LUVESUWKw7MA75uwL+eHT2pgIq
	CfHehG0034N/JRqHE1GxpKabD0WR/GBWV8szxlzy6rx98kEMZiLepQRfR4TcIRCjFQ/dsIQu6iV
	bk0GteTARaZ0fBTGM0L3/tY/t0VfjvOwLxOQNJAfzaw+rpyJmzTNrczL2llI8PIW4ebs5BiyuuX
	55xF0pY3pcVIFaCATaYXqMcGwkRZKtR1TyGDeoaGUruYhHI472dGgg2IAKOmfYonQLruY9mJ4lF
	T3Yi2iSZeMvkzMQg93V01FSQp+iaXj8ZunrwysM/1qaA==
X-Received: by 2002:a2e:ae0a:0:10b0:387:a16:ee83 with SMTP id 38308e7fff4ca-38a1c40121emr17269641fa.11.1772556122075;
        Tue, 03 Mar 2026 08:42:02 -0800 (PST)
Received: from [10.74.67.179] ([193.143.64.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1244e0ccesm478286e87.56.2026.03.03.08.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 08:42:01 -0800 (PST)
Message-ID: <2d514275-d2dc-4c0b-a7bd-3adf9415711b@gmail.com>
Date: Tue, 3 Mar 2026 19:41:53 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: File permissions are not persisted after creating hard link if system
 crashes
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D79E91F4014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22192-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Detailed description
====================

Hello, there seems to be an issue with btrfs crash behavior:

1. Create and sync a new file.
2. Open the file and change permissions.
3. Sync the file.
4. Create new hard link to file.
5. Sync the root directory.

After crash the file will have old (original) permissions, though the 
changes were synced.


System info
===========

Linux version 7.0-rc2, also tested on 6.19.2


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
   int file_fd0;
   int file_fd1;
   int root_fd;

   status = creat("file1", S_IRWXU | S_IRGRP | S_IXGRP | S_IXOTH);
   printf("CREAT: %d\n", status);
   file_fd0 = status;

   status = close(file_fd0);
   printf("CLOSE: %d\n", status);

   sync();

   status = open("file1", O_RDONLY);
   printf("OPEN: %d\n", status);
   file_fd1 = status;

   status = fchmod(file_fd1, S_IRWXU | S_IRWXG | S_IRWXO);
   printf("FCHMOD: %d\n", status);

   status = fsync(file_fd1);
   printf("FSYNC: %d\n", status);

   status = link("file1", "file2");
   printf("LINK: %d\n", status);

   status = open(".", O_RDONLY);
   printf("OPEN: %d\n", status);
   root_fd = status;

   status = fsync(root_fd);
   printf("FSYNC: %d\n", status);
}
// after crash file `file1` / `file2` has old permissions (0751 instead 
of 0777)
```

Steps:

1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that file permissions were not persisted.


