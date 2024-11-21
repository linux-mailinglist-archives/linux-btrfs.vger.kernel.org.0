Return-Path: <linux-btrfs+bounces-9801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF49D45BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FC1F220EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 02:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4855C29;
	Thu, 21 Nov 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbqc6Dx0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59723099A
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156387; cv=none; b=U9X5/EcXuO7rHEHxkHo27LmwlmzaizG7eas7Z0d93e1TldgxdMZgRsfn4MPIadhaABmhy3iCVCQGBSd5lwmuIJcbuulvpITQc4JCzLHVEPT38ZPUIEVJqERyBrywck7HHUAqA2zb2gPo2KKuzBlWydSb5OfYjZIXow6KeYoTtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156387; c=relaxed/simple;
	bh=5YHYo9qnO3pkwTL55Af2VeJlxa/Z/ORrpN2+txQtLck=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SIOr2u5x++HueMotKGda/nnHvAoDPYsXa6DlEic/63dPAcruIKFYQYj2okK6JmOfa0ufdkwcpTPHC4mYHG77hu+yVvUccICOK1TCfZQ0qPFQkh3ntcJiBn76ajMNPHH/C9FJBUGxTCGBVkMP38BPpTUSrxwppHqRmC/oSAySS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbqc6Dx0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so4247521fa.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 18:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732156383; x=1732761183; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YHYo9qnO3pkwTL55Af2VeJlxa/Z/ORrpN2+txQtLck=;
        b=Nbqc6Dx098zDhYH/qtdTBcS1HvjcDr8PGxYDmvkXOMLdDz+Ujqu2NPE7ospIRb9BHn
         Z4WKm4IVljpv0CPY0qJXN3o1TSQenDehnLk6outf78GffAiWNIzBjl6vXCGjl7NI4b+S
         SjSMRJdrFdpa0tyk3MszXfYft/pYlt7SfV+V9uI4juw2VjhVrZ1k0DDC3w3/XHVKCd7q
         kJYiQXu2Re4HdjVXsA+SAJUM8Fa+25jkDHrso4pL81wuxyVoCUtk7k3p2hs/B7tM14tt
         4X36qUVNPMZoj4ZzMUTTl9y7s2fttSe4eglqnwVH5wzICjjFpp/UxibW41VLxHDygkf2
         d+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732156383; x=1732761183;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YHYo9qnO3pkwTL55Af2VeJlxa/Z/ORrpN2+txQtLck=;
        b=hKE60Ysyqhun+gMvDOF1GUeJW7mQjDLzsw0WkLUYfWe/MQgrWgrMBzMMlpqM0Hsdys
         eWhA79fzq7FiOMZ+B7RkfQTXz4lAlgYdej8Xg3NEF5Zujn3kBG+r1mGu7glREcE8/izH
         8oje0mOFOpsfKwZq+j3G1aY8IJFn1eWFyQWUnXZV8p3rC6sgTaR+2xfM+/QsoorxcxJX
         6H3m5oiuzQitXipk3Q9k0B4xhpldC9l0jy0ncsXyei68bf/MbTiGWFRhCQHzIsnOhshU
         zWTsDp56/Xag2y8AdyFSUiXunw6jfQOJcUkY04LPLH3sG4eax+Uk+8+cKL2myNEwZxy3
         VbHA==
X-Gm-Message-State: AOJu0YyKjpgJ6SrFaQ8ekqApAECXKxRBQ06BxQi4kFNcSIMm1PLtNmJS
	vYFzbeaVi5KkwRSEnrTXOVYuljNSPexqRPmOC0n5JLCklLKlTJdOrHY9dnfTVZFeVUuUaIwRwJX
	9x7T3os05kKQ2f1BBdpmN6+soAeRQ0cbgBrA=
X-Google-Smtp-Source: AGHT+IH6SRViy3RtX/6LMKqmc+Vs8ZyFy8v0b88vqueYmm8wSvc8JBzzwO++8501fkwOUCuZdu50S0FJ/mBmN87+fxE=
X-Received: by 2002:a2e:bc22:0:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2ff8dcdbf37mr34692851fa.28.1732156382752; Wed, 20 Nov 2024
 18:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: solomoncyj <solomoncyj@gmail.com>
Date: Thu, 21 Nov 2024 10:32:51 +0800
Message-ID: <CA+CWo3fFir7Wo7YxW_aF4rr-eveLbbtKD2QJoGDyRBqeq7+gSA@mail.gmail.com>
Subject: RFE: have a metadata-rebuild command for BTRFS
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

say for example you you have a failing drives with a few bad sectors
which happen to be right smack in the the metadata space. after
running ddrescue, the new drive will not mount r/w and is forced itno
read only,eg
```
[91900.917469] sd 5:0:0:0: [sdc] Attached SCSI disk
[91971.985916] BTRFS: device /dev/sdc1 (8:33) using temp-fsid
2335e6ec-0a8d-4b3f-a310-babdd50215d7
[91971.985925] BTRFS: device label solomoncyj devid 1 transid 15573
/dev/sdc1 (8:33) scanned by pool-udisksd (719894)
[91971.989591] BTRFS info (device sdc1): first mount of filesystem
7a3d0285-b340-465b-a672-be5d61cbaa15
[91971.989611] BTRFS info (device sdc1): using crc32c (crc32c-intel)
checksum algorithm
[91971.989620] BTRFS info (device sdc1): using free-space-tree
[91972.404063] BTRFS info (device sdc1): bdev /dev/sdc1 errs: wr 0, rd
0, flush 0, corrupt 70, gen 0
[91973.800256] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[91973.800648] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[91973.978600] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[91973.995008] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[91974.066421] btrfs_print_data_csum_error: 10 callbacks suppressed
[91974.066426] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[91974.066433] btrfs_dev_stat_inc_and_print: 10 callbacks suppressed
[91974.066435] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 71, gen 0
[91974.066441] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 4096 csum 0x8941f998 expected csum 0xb186836d mirror 1
[91974.066445] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 72, gen 0
[91974.066450] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 8192 csum 0x8941f998 expected csum 0xb14a1ed0 mirror 1
[91974.066453] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 73, gen 0
[91974.066457] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 12288 csum 0x8941f998 expected csum 0x6cecdf8e mirror 1
[91974.066460] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 74, gen 0
[91974.066463] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 16384 csum 0x8941f998 expected csum 0xa8bc0b46 mirror 1
[91974.066465] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 75, gen 0
[91974.066467] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 20480 csum 0x8941f998 expected csum 0x13793374 mirror 1
[91974.066470] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 76, gen 0
[91974.066472] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 24576 csum 0x8941f998 expected csum 0xe34cfc85 mirror 1
[91974.066474] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 77, gen 0
[91974.066476] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 28672 csum 0x8941f998 expected csum 0x53f43d27 mirror 1
[91974.066478] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 78, gen 0
[91974.066482] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 45056 csum 0x8941f998 expected csum 0x7bdb98e5 mirror 1
[91974.066484] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 79, gen 0
[91974.066486] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 49152 csum 0x8941f998 expected csum 0x04b9b8c9 mirror 1
[91974.066488] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 80, gen 0
[91979.939610] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[91979.978368] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[91979.988449] btrfs_print_data_csum_error: 4 callbacks suppressed
[91979.988453] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[91979.988458] btrfs_dev_stat_inc_and_print: 4 callbacks suppressed
[91979.988460] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 85, gen 0
[91980.083522] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[91980.127767] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[91980.142725] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[91980.142734] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 86, gen 0
[91985.671562] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245944934400 have 0
[91985.672022] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245944934400 have 0
[91985.672358] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245944934400 have 0
[91985.766258] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245944934400 have 0
[91985.766486] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245944934400 have 0
[91991.124282] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[91991.161834] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[91991.173439] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[91991.173451] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 87, gen 0
[91999.415747] BTRFS info (device sdc1): scrub: started on devid 1
[92011.582751] BTRFS warning (device sdc1): checksum verify failed on
logical 2245944475648 mirror 1 wanted 0x238c97cb found 0x245f7bdb
level 0
[92011.582801] BTRFS info (device sdc1): scrub: not finished on devid
1 with status: -5
[92338.172371] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[92338.294485] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[92338.325441] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[92338.325452] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 88, gen 0
[92338.438293] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[92338.475829] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[92338.489049] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[92338.489063] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 89, gen 0
[92338.626296] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[92338.671801] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[92338.682746] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[92338.682755] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 90, gen 0
[92338.789870] BTRFS warning (device sdc1): checksum verify failed on
logical 2245942673408 mirror 1 wanted 0x252063d7 found 0x8bdd9fdb
level 0
[92338.829450] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2246237732864 have 0
[92338.840069] BTRFS warning (device sdc1): csum failed root 5 ino
40341801 off 0 csum 0x8941f998 expected csum 0xf1bf235d mirror 1
[92338.840078] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 0,
rd 0, flush 0, corrupt 91, gen 0
[92355.026507] BTRFS info (device sdc1): balance: start -mconvert=dup
-sconvert=dup
[92355.070849] BTRFS info (device sdc1): relocating block group
2491861172224 flags metadata
[92356.498242] BTRFS error (device sdc1): bad tree block start, mirror
1 want 2245942738944 have 0
[92356.498281] BTRFS error (device sdc1): failed to run delayed ref
for logical 2246250135552 num_bytes 16384 type 182 action 1 ref_mod 1:
-5
[92356.498288] BTRFS error (device sdc1 state A): Transaction aborted (error -5)
[92356.498291] BTRFS: error (device sdc1 state A) in
btrfs_run_delayed_refs:2215: errno=-5 IO failure
[92356.498296] BTRFS info (device sdc1 state EA): forced readonly
[92356.498330] BTRFS info (device sdc1 state EA): balance: ended with
status: -30
```
btrfs check https://paste.centos.org/view/b47862cd
The proposed change is for a metadata command that checks and verifies
csums for non-parity disk. if it is ok, the record is retained, if
not, try scrubbing or ask for permission to discard the data or have a
-y to auto delete.

