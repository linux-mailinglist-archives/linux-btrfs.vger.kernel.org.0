Return-Path: <linux-btrfs+bounces-6167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5F9258BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E062F1F2667A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9148171095;
	Wed,  3 Jul 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0gncPBS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E316F8FA
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002769; cv=none; b=HjXkfqqmtEHwpOlzTEOTOZ0i6qn8e1S6s/XqnYh9uMUCEUqVYskDcPUdTszF5NcCg0fExncNna6+q7C3VQSgxevHATnRiZAAinANv2lfPL78Vuy+ctE++6pgvZYQ3LzKRwWB8TlO1G2RE2anD18ikpqsx/HuKyFVh6lLapelzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002769; c=relaxed/simple;
	bh=itwnLsJf+xuF3MHjf84RoacYc2c+aWQ8ZrTjyidGAuU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BtZM3/aP8Zi6934qI0gH/8+yeWyf8Y6ozmPX2RDJ8YUxZbwr1n+SVuk7U9Qi1xJ/jUmr7ZrGiIZt5efq9gifGVMbEtRaNjuDcYJi6hvY76aedtz+mMqgZZpv2PDdqf+BFv4xkfjsLdsR3l1q3mvhpxzmKuVZ1UgYF2p9XHNzjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0gncPBS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c8c6cc53c7so3580532a91.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720002767; x=1720607567; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AVVaSjlx1cUL2RVLoOLQuY0ltO97xSY7WRciFlM+pug=;
        b=C0gncPBSqfOFpez+MkAglWRFb5EOdwuDZWX6pzRVXrNabdhZpPw+72/COsEbT86S2R
         WKpjga48pTpQ8oG/8F/k4vh8+bR/wqhAynVrHxdhloXae0Yvr42P3zLgUnJXxN/+r9y5
         JEXzhKBom2nSpnorHVzShhbyTJC3RB4S/0xva10knKsB5p7M67EnqICDwS498/jscfT/
         25flVcQ2y/MucG48BbOlq4pun+5kTjSiERBU4dddeLDCE9Qkz7b0aFGWEhg2/LJzA4nn
         vEuFX8niTFcpkj0ucoj+3kI3NqIGpdzxzfvLtkwC0DL4TpdPhrsimKKQD2LI7oMDaLrY
         //IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720002767; x=1720607567;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVVaSjlx1cUL2RVLoOLQuY0ltO97xSY7WRciFlM+pug=;
        b=KKdUXJV60oCJmGogGFcEvQu0E0YUFJLY6i/PFDX0UfvVwJH2YPzh6GgG+YFsk7ALR2
         P9c/to+1Q99wIhAZfi2PmIB57T9TuWNDVprnXRst4mD1jL11CiNW8QZD0JkypOl18zX9
         yV1OSwYMDSmxEa7HJyyQRrPVcIqffpJPB54Mwxk+VS0CdHT1vYwygovii1EhakWYS1Fv
         yoVDgeh1I1swux709WL4n77U0outyyeJ472bQEAnfZE6ZJqXBADSQ/HdJm1lHeRDtlMZ
         RZq+4LN8D4FPCL5kqjB1PIW/NDtXZ9S46faIbeyelN/kIDyVrLFrTC89M0S7MWaOxlHC
         h2Mw==
X-Gm-Message-State: AOJu0YyGLjVQftVVY3r9rP+V38qyl2C5skjfJHOdnwk2BSxwaueMLAHG
	fab7/+va5TAsepiPzrpzvtXrC8k6/5lWbidqzS8q+mNWMrmS6/+rVMxdj16JuBGwVK72eAsw4rw
	8kAXyW7CS17pBN5n1GKrS42Z28wSs
X-Google-Smtp-Source: AGHT+IHDYjx5rlXNPQbxe5Lb/F03GSsTL/xyeuEmMSaPqWIIVVGWPuuxM88vhGgZi05vvc6bYDSD+zHQyvGjcGp9fY8=
X-Received: by 2002:a17:90a:f993:b0:2c9:7f3d:6aea with SMTP id
 98e67ed59e1d1-2c97f3d8553mr603644a91.32.1720002766663; Wed, 03 Jul 2024
 03:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsO0bWUgQmFyZG90?= <bardot.jerome@gmail.com>
Date: Wed, 3 Jul 2024 12:32:34 +0200
Message-ID: <CAK6hYTsJV2=TsmWq8mVYO-xDg9cmgMTb9+tk86=i-69+6SZfAg@mail.gmail.com>
Subject: Issue, how to fix ?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

After a battery issue (unexepected shutdown) my linux vm on a windows
host won't boot anymore.
I'm stuck with a grub rescue prompt.
After a boot on a live CD I get the following errors.

Couldnt  setup device tree (check command)
can't read super block on mount command

and with "btrfs restore -vvviD /dev/xyz /restoreHere" (from irc advice) :
https://paste.debian.net/1322170/

Can you help me to fix that issue ?

