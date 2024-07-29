Return-Path: <linux-btrfs+bounces-6832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2693F734
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B3EB21E8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9292149C7B;
	Mon, 29 Jul 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8iY2Q0S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E852D05D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261775; cv=none; b=KRdR+a/wBq6gWh2pymC4o3GiQSw/ax/kNdi2gAQXOejqkzke3GU7KQWO3stCug8mpqGC8sp7X0kltuPQNhAWtyB1Pj4bXrbKMoxfSvGZLMOGTMb2ryZvo6wmvmO78dVJwG5Y1eOOpYP/JFSHhsn37mLRac92eVcnxbS7aNE27/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261775; c=relaxed/simple;
	bh=ajufS0BmjOchGaobmqBicgiMnUNRIvg2LMb+v++lq6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jpOWmyXl8xPCK1HLQxJgus3epdeE6jHCQYtHw9oS63c15PNdUVI8dML2wGAyC95ep0IlmWtVxMi/ANxI5eSGXIl+x+dR0mzEMAVHeOSTty/Q/1MeunnhNHd2Q7hhbLKXsV1zEjcir8BuPav4t5faVvqAdcI3UAoxn7Ismfga5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8iY2Q0S; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb682fb0cdso1946619a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722261773; x=1722866573; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w60KFb9+XQcKWCJETTqbfHZUvHLyV11KlEHF+iXyvf8=;
        b=L8iY2Q0SYVR3tT8jTFW6maMoUdO+JkzyuvjS/N7evOZxJAXKbWxUtCLZ/pRh9HZT75
         ai+z7VaVwcBsjxQkAmJjVE5Ne7ozWXnj1BXva+9vnciLMgHXg49PrwY+acf6YgNpJiMM
         L/0mm6s2wIVl1vkNLah6AIPtXDeOkh/rHg8LyKO0789wumK7IjQ10N3wnh1zYMyWdyNz
         65hS4yBDqDazyb4K5WjfcX6/3Z4FPK6w74RdCVWs1CcN7rjiCF0J7a2EpGsyHLnXgmOF
         7Uitb+x0O8dLG7ZATQ3oOk1hzvSGPsgg6hzO2f1h96ar9nPox035Y6U8DarKmUZ2d0Pc
         1/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261773; x=1722866573;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w60KFb9+XQcKWCJETTqbfHZUvHLyV11KlEHF+iXyvf8=;
        b=VxGvipLcI8LvL70s7wTAPMSj1w7UopYdHnmLJ7h/htR6BKtw2cV05NpDHHmbtE+B/K
         iaeSMJKuwsJAWsU2So45QvfFKdsL9+Ebj9DAsF3yb4DKfzIvZmYxWLuqU298zoRK8Hdq
         EIqp/r+LTcVOpOoBGgxVNO70PtzJjsAUL74T+p4BVZ5fG0TRskRji+q+rIvymXCqv8iY
         fqGxGaMhJLHEAN7pgsq/V+JVyLYD16LPhIccrRtqMFVs1fHf2mxUji7GAbkbroRdlNk7
         Il++8Rj3cKLu732ahEqMnQVt4fyMU4A58ACBPA2MXblOzRaDz6yt1bGBi0z5BcVExJqa
         eDvA==
X-Gm-Message-State: AOJu0Ywhr1KdO+dQDWpOTLS0QNOYmsI8jl4w7xFjo6j05nSZ0WbdOr/n
	vEef3nnYelXyYrU8Gdw6ihDe8PBxQrQHtqAeJXjKtX0kcEpEK6SbAUGGkqI7tdkmwXUhdJTVQwg
	JxX9iSWHMBnJNNSeWbDHGb/gBe3Hv
X-Google-Smtp-Source: AGHT+IEl/KHwrSe1cOfT3YHPQATp/jIT5SZjnOrpJt9ggLI9GSz/SAmsALUoUL6FLLbF15MJ7cZAR44EhpuO+6y2kCI=
X-Received: by 2002:a17:90b:e0f:b0:2c9:81a2:e8da with SMTP id
 98e67ed59e1d1-2cf7e61f471mr5567902a91.35.1722261772664; Mon, 29 Jul 2024
 07:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsO0bWUgQmFyZG90?= <bardot.jerome@gmail.com>
Date: Mon, 29 Jul 2024 16:02:27 +0200
Message-ID: <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
Subject: Virtualbox and btrfs superblock issue
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry if I post at the wrong place but  I didn't find an issue manager
(like gitlab).
(I also asking myself if a not already post but maybe before i subscribe)

So my issue :

On a windows host laptop and with a parrot vm with a btrfs and after a
power failure the vm looks broken.
At start the vm drop down to initramfs.
When I try to mount from an iso (of the same os/version) i get following error :

mount -t btrfs /dev/sdc1 /media/user/to-rescue
mount: /media/user/to-rescue: can't read superblock on /dev/sdc1.
       dmesg(1) may have more information after failed mount system call.

and dmesg get following :
[71283.615636] BTRFS: device fsid 70bf0953-3ee3-481f-8a7d-f7327c6fba67
devid 1 transid 182616 /dev/sdc1 (8:33) scanned by mount (24156)
[71283.627681] BTRFS info (device sdc1): first mount of filesystem
70bf0953-3ee3-481f-8a7d-f7327c6fba67
[71283.627711] BTRFS info (device sdc1): using crc32c (crc32c-intel)
checksum algorithm
[71283.627725] BTRFS info (device sdc1): using free-space-tree
[71283.639345] BTRFS error (device sdc1): parent transid verify failed
on logical 26984693760 mirror 1 wanted 182616 found 182618
[71283.642087] BTRFS error (device sdc1): parent transid verify failed
on logical 26984693760 mirror 2 wanted 182616 found 182618
[71283.645163] BTRFS warning (device sdc1): couldn't read tree root
[71283.646224] BTRFS error (device sdc1): open_ctree failed

How can (if I can) I fix that kind of issue.
(i did not create backup/btrfs snapshot)
I get that issue on 2 similar setup / power failure and one with a xfs
system too.

I'm really newbie with btrfs.

thx for your feedback.

