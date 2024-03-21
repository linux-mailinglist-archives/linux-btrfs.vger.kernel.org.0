Return-Path: <linux-btrfs+bounces-3493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4008858DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 13:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE3CB224A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECE76036;
	Thu, 21 Mar 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGxFWzRp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED52757FB
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023168; cv=none; b=EhDzs35fHklGkEHcNz6PCUvOiTWZ5ZAMIOtxVmCmYv29+B61FLlmSE6vxf9Sb9o3rdr/oa0GOCqog7l4bsIKdCMYL2mgHuzLrnyxeThwgC0kWD8amtNxFOYFEep+J7BeY4hvEmIOkoSVM0tAhvLraMPugvgNylReBlkNDRS18/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023168; c=relaxed/simple;
	bh=346KvDUQEYCqKV8blMEmL3CKIYjqsNWNCzDduIvH/T4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KdbOFD9gf3Jy2RyNpSxV2JNbps8i6Qhk5VJgOe+JjVemEPNAF9Q4KSs8JnKi5LzSfuhsluDQRDeGoGwvVjAyDVpR6FiQNp/nn+a7Sxvc5/jj3KYPq6rHiJzqLHzMXn8tqhKH1VzaTi/XU3OKgYV6i+nPSmbf+B9Hl+1snY4UAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGxFWzRp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a4a102145fso409796eaf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711023165; x=1711627965; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=346KvDUQEYCqKV8blMEmL3CKIYjqsNWNCzDduIvH/T4=;
        b=jGxFWzRpmLmd2X8TjNR890IgWEhWU3r7H+XrZWgZm6qcanNjcnUWo2zlOsxos80uPR
         9A6ixjXYH2BGOXqt/UYMtnc0GPKN1JVICOinhW4pT9f1k1sU8M6VgqF44Vb4FMiU2xhw
         UMq2KuvgZtcLhPmIqyVTvEntRS4c892rSCWbwl6znSY5goQfftt5A0r6lDmpP6PiMTAZ
         d86027gJTbawQ8gx2XUwrjBY+trTaiR/SFGLTJTEK/emlkwcjxaNkNLG+wFP4DmtEYoZ
         yxMLRNUGx4F4WNQkQ3emqo6va2xk3hc+8lIs6KByR6J/EgmdUog3ahryTVGUCEhtJRNz
         purw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023165; x=1711627965;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=346KvDUQEYCqKV8blMEmL3CKIYjqsNWNCzDduIvH/T4=;
        b=PdGy+ZHlIGePwNhcy8d4+h1GPvaWNSB4oz1P3Du3XtqN1AkWv9WG9mVWuiUQu9FosS
         SAXbSgNZ/NyrVaRCvNlnxxncBG6gFbJ3uTXzkk69LwCiqlDxT79UaA75QoDX6cpF2iPm
         J5xtjrF3Vo1eFtmqt9cuNPZHWiAw7d++rbA2w3bd7/zbPVVI4+WpkLNEcRfftEOOEFEb
         3BrRzAYi7Rw6IH3sWalusf47HApUT5lVVNRlgA7HEKW3P2oCI0kbooX2zICcBHFsRKxZ
         R9wXnlMJ40zNLYFXxnp40N0X0G+DamgGikXe0XudImXNLLNM+x/CNiY+BbNry9iQYbMq
         98vg==
X-Gm-Message-State: AOJu0Yyg+6HxDaXWPgTU8THdNkGjiFJ7OXoQzZjyTxpKbycHfdq4lPA6
	+joAhUGTW8vP5+mCt1pyuEAWS5s1LpodZ7ULI6eMvb6JpcalkHpnWMEaQu+l1xX1x1xb+ixEChi
	6uNpIdlD2Fp7NjHok5qsUwnpuFQWljFRSsxU=
X-Google-Smtp-Source: AGHT+IElB0gvIjJb5vD4frKVF9sVXDrAc4e4SiR3r3IzLsEcUzVG65+U9FrEVqUr0aNvMSlAaWtOafqWc5gyED6MHak=
X-Received: by 2002:a05:6820:2d43:b0:5a1:dd31:a38d with SMTP id
 dz3-20020a0568202d4300b005a1dd31a38dmr5619478oob.6.1711023165627; Thu, 21 Mar
 2024 05:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Barry Kauler <bkauler@gmail.com>
Date: Thu, 21 Mar 2024 20:12:10 +0800
Message-ID: <CABWT5yhTcEcdaCGSptF6iWDEAJES-v_Lj_H5ytiU5J3KqXsA8g@mail.gmail.com>
Subject: fscrypt v5 patches cause kernel crash
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I have just joined this mail list.
I'm a newcomer to btrfs.
I am using 6.8.1 kernel in a custom Linux distribution (built with
Void Linux packages) and it works ok booting into a btrfs partition.
However, exactly the same kernel but with fscrypt v5 patches applied,
get to a shell prompt, then about a second later the kernel crashes. I
have take a snapshot. attached.
I am not using fscrypt, have only patched the kernel and booted up the
distro as before.
If it helps, the partition is mounted in the initramfs like this:

mount -o rw,compress-force=zstd:7,noatime,subvol=${SUBVOL} -t btrfs
/dev/${WKG_DEV} /newroot

Does the snapshot help identify the cause of the crash?

Oh, seems cannot attach an image. OK, uploaded here:

https://bkhome.org/news/202403/images/btrfs-fscrypt-crash.jpg

Regards,
Barry

