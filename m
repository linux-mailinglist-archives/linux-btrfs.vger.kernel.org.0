Return-Path: <linux-btrfs+bounces-18315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D30C07F8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E519A1F46
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30202D3A8A;
	Fri, 24 Oct 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEov/4n+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63962D3212
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335891; cv=none; b=ArhR8aOxfs75smn8Ui/M7w3iRovdpyxzvT3ZSMoDEg6Z8no2DxTHsBRmCM/eI7rDDYHwdRTExkX4PMGHeDFiq7Ipi7PS/z6pKEcJxOztSTVV/xiUSE3by8yW2El8+DhGgpbwkasSSK2nHiUE/bKPWy7UAeThWT4XGmjgFWMuGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335891; c=relaxed/simple;
	bh=TSu4wT7bTPuWdELQRo0A5h89GY2MPcuFRVAlfLpDRmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kEFbvwwCDzUw+NceRFGQ/GPGbIQbAMdBvjIrWEVj+/KWyKuNJ9pUjrgvyvvvPnGbwcmKj3v+YcqLYXqiCG/UyTz/sJ/Ye5Y6RotyIEcUYu98CXQIKS+WKeOSpPaV4bs0XOjUN+KzG0/zwktWaqVymsmC+bMj00moG4BoxjH+PWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEov/4n+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c2917b92bcso2129688a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761335888; x=1761940688; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwo4aSfaBE6Q34kbypKp9KkeHT8QeUVG9DrSMA3rfIM=;
        b=EEov/4n+E1fymJ/gIzGF97HBCbIRCG1FYcfopgS5MD1f37hAmJYQpUTw9VwPZQyTmZ
         rcalDhsA4V73NcVEGo2VsenbI4fAY66eGmrlO8K++Juc1epfJcYOoy1HFbl1pWm83VkL
         gy0tALatTLvtgdghLd0At7le9nhfP8kEOqcNvZxpquqQqN3eUz0yY6N060cNKEaf9WVJ
         oo6qvwfQkEjhpt5J8qdjOPdEk1mV7UBg5fqip74YUVG5sFqSFXhQZ1v0eYetcD0xRbRU
         Njqw3jRmPF6j9zAt+Hpt6PfS+t9zsr0tcSI+hY1La7dVWPhgx1hs6C6TAfkmA01diqJk
         JiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761335888; x=1761940688;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwo4aSfaBE6Q34kbypKp9KkeHT8QeUVG9DrSMA3rfIM=;
        b=aYpPJMwtxZUcql+hONN95439/qhPAuh1rtMWfzRMAzoaGA1VYDXxwl7xf90VbR0unU
         n+n8BwTy3+Umf9OSjTOag8uSg5UxzE1schTVpKH6F6Y0TfiPxbOKYraU0/GnhW212gfc
         pBMrx/VLQiv2FnsI2hcwaM48Fl2kOYm5xEilGJDSn2WMKsEfbQV3g+HoEh5PofMeGI6B
         w0wOLSX0J1hC2hE6yLc+AQnmDXwvgaKX5lrAVgspK/6RoSw1bC+elIcukEPJDntOGMh7
         oJFVAEOtGKTMI3L4/GALbtplvwLIEe54ENsFigBaWcbFi1xxTN/+3/g1SyIe7Fg74yyA
         Xrfw==
X-Gm-Message-State: AOJu0YyAudHDtuFAl3u8fUqsKTJ8heT3Teswvp4bfTTCTdhi3GjZUxP2
	3SWhXNo1sqUAorb9nFo0ZPiaSZHDV2Jp6Vg6v/cmMPahL2WQlgsUMfWerLQOGEV2oiXal6qrJmW
	Pp3K7n+zgoKqy5Kg8CS8zB6GbvDgrEb6BuySbvbX3fxOO
X-Gm-Gg: ASbGncvMkv2H6ujCUl9tGOv/Mng5isP5eQEztbUAXhlwXot1KpEVQLrc9yqZ4CygUnG
	FzkCd/YmbRRWqDC+oXtAqyjCpe0YXAjkPT1cR9fI/QcNiYY7ESMFSWuQh032IpRxpcjmVvabVde
	k+vKwZ7kDl6UFAsDkKVlZAjt25txYPn1QBp/rpIZGQrQZp8OeYpRlUA1x6JqsQVBvwWSCQjutcj
	yDsOen2o8uffBtJAMudiTE++uhstlgXYx2Sbvc+56SUtwadhLgbSOY4woiP
X-Google-Smtp-Source: AGHT+IH0Ux3eSuu7TpNtfLEzURYIhFza1ruR9l65bTOlvhKyUSvbDcDcPhkPB6h1B+iKGudFoMTC/hSrsE+b22lQlGw=
X-Received: by 2002:a05:6830:6f42:b0:741:bf2f:ee87 with SMTP id
 46e09a7af769-7c522ef4b16mr2084185a34.0.1761335888287; Fri, 24 Oct 2025
 12:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 25 Oct 2025 00:57:57 +0500
X-Gm-Features: AS18NWA6YaaLjSg_ElREN7I4mFWnrqu2HrU4lhMAqGD-lTwsQ2FmhhD8HvLNkKA
Message-ID: <CABXGCsOksDzUDn=rEpz1PLRZpxQeytWPP6QVbo50RU-KxP=-eQ@mail.gmail.com>
Subject: [btrfs-progs 6.17] btrfs check --repair aborts in delete_duplicate_records
 (SIGABRT) on single-device FS
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f3bcdc0641ecf72e"

--000000000000f3bcdc0641ecf72e
Content-Type: text/plain; charset="UTF-8"

Hello btrfs folks,

btrfs check --repair aborts (SIGABRT) on a single-device filesystem.
I understand --repair is risky and not recommended unless asked, but
user space should not crash. I can reproduce reliably, and I provide a
btrfs-image below.

Distro: Fedora 44
btrfs-progs: 6.17-1.fc44.x86_64
glibc: 2.42.9000-7.fc44.x86_64

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (...) at pthread_kill.c:44
#1 __pthread_kill_internal
#2 __GI_raise
#3 __GI_abort
#4 delete_duplicate_records (check/main.c:7583)
#5 check_extent_refs (check/main.c:8254)
#6 check_chunks_and_extents (check/main.c:9216)
#7 do_check_chunks_and_extents (check/main.c:9279)
#8 cmd_check (check/main.c:10902)
#9 cmd_execute (cmds/commands.h:126)
#10 main (/usr/src/debug/btrfs-progs-6.17-1.fc44.x86_64/btrfs.c:469)

Key at crash:
  key = {objectid = 17101544210432, type = 168, offset = 16384}

I captured an image with:
# btrfs-image -c9 /dev/sda /home/mikhail/sda.btrfs-image
It did print:
parent transid verify failed on 4843613831168 wanted 213059 found 213019
Ignoring transid failure

Image is available here (HTTP download):
http://213.136.82.171/dumps/sda.btrfs-image (5.4 GB)

If you prefer, I can re-host or provide via a different channel.

I can run additional diagnostics, instrument a debug build, try
patches, run under valgrind, provide btrfs inspect-internal dump-super
outputs, etc.

Thanks!

-- 
Best Regards,
Mike Gavrilov.

--000000000000f3bcdc0641ecf72e
Content-Type: application/zip; name="btrfs-progs-backtrace.zip"
Content-Disposition: attachment; filename="btrfs-progs-backtrace.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_mh59sfbh0>
X-Attachment-Id: f_mh59sfbh0

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
1A9aWe6wMbAwbGW5QxQooph3yg8UMe618sNBY8AYhZ2im2KP+Z2e3Cm2lZhOnsQU4U7P/hSHHm/l
h4MUPEa61QapXdSdzg/U9/xulT3qE9Stskd9exjschKjPg+7VfZofZLqtCYJZ91qYjRABHfaeWng
oXZV7SAFykm7mnSQAsOsXQs6aDYZCduVnIOim/u4XUU5yApOuNc6DR40hhD7rDWbB/kh9FG7BnKQ
FSH12jWQwxRY6Lfy5GFWhAHrdBJjCHvtOsxhCh5v12EOU6C4XYc5xA/MVgY7naMY9ijrlO0ZDsJu
dRiGWdCuwxymEHp+p6dF5jHSrmAcEpvMD+wBoMsYfOZ1q4Ewn/Ow0zMOIyjoVkVhxMPtKsphCgzx
Tu8vGOHM6/SMY8sX3aooLAi8dhXlMAUa4m6RRRHuVkVhFPNuVRRGfUI7VTgZDXC3OgyjlHWrwzBG
wnb94aDIYjRg3fID4x7ulh84Je3qwSFWcOSxbs+bHFFEO72N4ogx1OkcxbFH20+sh3iSY/sXEJ2s
wLaG0c2KEHd7YrWP7e0n1sMUPPsepYsnPYLaz7yHjSFgXqeqO/dChDq9EeM+ot3+qof7QbDrL2pW
3/+Ff7vkCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7g
CI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7g
CI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7g
CI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7g
CI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCI7gCL8vgdAQM8p97zHC
v59QJ5sDRkPuB0HnoQaM+YQghH4LIYp8Tn4DIeIFodd9RBwj6j+68vi/oVC3dcExYuGj6+L7h/r7
CXW1GTPGA/obLJjfUaizzSHxyG8RJL+jUFebfS/wcfec97sK7bX5RmYZlPPUgJmrKovzH0qYi6KQ
+QDkbWnpWkZKx6Cupc5EYWBalZAaWMhSxKIUP8EXzDDCASEeRsT3BoCpz8nPvd5HrWZaLKyCTK9l
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
--000000000000f3bcdc0641ecf72e--

