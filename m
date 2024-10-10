Return-Path: <linux-btrfs+bounces-8775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98359997F9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0A2810A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E01F709C;
	Thu, 10 Oct 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b="gYEU9vM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7A1F4FC5
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546000; cv=none; b=W8USPTcW8RgOAXSRFQVaAAf8M+J1lGHmJMNLZlQVSghVocAmaylH408tbjckDZCGoJ7XkZFuweqbwo1NLOLrVlukhHDYWbJGq4wbRgIB/C6rCFtiHhE6CqzokWGigLESRRkv/lBFDSfrd/exHETwi6OZufpQ9N+apCu+5RLiwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546000; c=relaxed/simple;
	bh=0YU3iDJpm34uTKv0lZwpU4lDR12fZ8C/PXKHb0LQ988=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oK5l1jgzzXjbetEZaMtQl3vOHNPqYo59cKK5ubPo6sGL22HYT/yG2TJwomN+jU+RXOvLNWmLi+m+QKRGsFey/gd6KcQz8FtQnPb4Si+i83rjwL/XUlNV1PbyRKtKs+d10spX2cFf8t7wiknNnLZSYmBjycHj55CtUIJUNtJPOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org; spf=none smtp.mailfrom=fandingo.org; dkim=pass (2048-bit key) header.d=fandingo-org.20230601.gappssmtp.com header.i=@fandingo-org.20230601.gappssmtp.com header.b=gYEU9vM+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fandingo.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fandingo.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c91d0eadbfso766615a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20230601.gappssmtp.com; s=20230601; t=1728545996; x=1729150796; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0YU3iDJpm34uTKv0lZwpU4lDR12fZ8C/PXKHb0LQ988=;
        b=gYEU9vM+ae5lAzze1tGQSQRyb31Msrh9X2oSInE0IWvnrrLmU9O91w6L2HONI1uQOE
         2ruH6lrs1y5UckINh85ijYqSg41MaZSvA35nKDqJmfqAS62cEB5gbJMcmrFx+gIIm/uL
         G9Q6uDZ+3FtFtODILeDm49j1XY9K0p7MFVKsIgObeA1O6WmdmeYCAWORx49Ccy8cv5wr
         6mOrWy+xhYrSCSagDro14ue0C6wbbmBNtu+Sb5rpTDVp91u3Qlh7YSPWxPcnqDinPMpL
         O6s2lxc41aGVUQ63LjbEDeSroByCKsf2LbwPavMPlNjjiEBIP7vbdFEpn/ZWH+1tTv2v
         zqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545996; x=1729150796;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YU3iDJpm34uTKv0lZwpU4lDR12fZ8C/PXKHb0LQ988=;
        b=XimbPuI57S722d2WJAXkeByymZmF5Tes3cwyBp9+I/yL8TmX0gn4k7yd4sMvC8S57C
         PL5WhLHYCwPItUe/Txno2bheopmEUTzzg0Pv4xRstxDcK02psptrdnYY/KbMpC/tXdMN
         WdRn9x5S6Pfs2l2RcKssuDwzh45fit+DmFY/OKtRxbbkK5JIuxCpWlcFTvb7zdl8TbY8
         tPeWjkJl4Hwn68MKSpsOUqvzC9ubSCMq762SDMCcMAOC/G1hlgUbRI723d27bx+dKCA4
         bkGCPakjEHT6/zlA3b7mfK5z30yusqZRnBdyRKSrlQfaaNsNiKt6Qq1fH4C1nL29GycO
         IwRA==
X-Gm-Message-State: AOJu0YySmXYHr83tZIc/MlLacdKEcXjPbm/dfVhbtORuDUheUi+rDUD7
	dSXLKlOqC4l1ovZcWeGomQQ8Dl6bDrk5Y5ZsF8ZwkKQrev6I/QIiacmPa5NkaaSSepTHzgnw3fZ
	54SvX5VjmgP72ZZSyU8GQog5ZsdThmiH/kY9xKlY3Zf8WP3VmZtE=
X-Google-Smtp-Source: AGHT+IFXBmh3mFInURxStPNfyfXOKF172NcpSKNlgkyfK4NHBK/+q0G97eS+u/U7DWq3RKzEwXnmF8HAGO6whFK8x9I=
X-Received: by 2002:a17:907:94cd:b0:a99:5b55:1a75 with SMTP id
 a640c23a62f3a-a998d208648mr457826666b.29.1728545996186; Thu, 10 Oct 2024
 00:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Brown <Justin.Brown@fandingo.org>
Date: Thu, 10 Oct 2024 02:39:45 -0500
Message-ID: <CAKZK7uzDzSnKyV56OyBHP0OaB5=gSTjbYPwhQZq6qq-W1uj11g@mail.gmail.com>
Subject: JSON Output
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I was trying to write a script today, and I came across this
documentation page
https://btrfs.readthedocs.io/en/latest/dev/dev-json.html about
btrfs-progs supporting json output. First, that's awesome! Structured
output is fantastic.

However, I came away confused. I'm on Archlinux, so very up-to-date
packages, but it wasn't working:

$ sudo btrfs --format json subvol list /
ERROR: output format json is unsupported for this command

After messing around for quite a while, I finally figured out that I
needed to compile it with ./configure --enable-experimental

I read through all the github issues that referenced json, and I
appreciate that the schema is not formalized. That being said, I have
two suggestions, and I'm willing to write the patches. I want to get
some feedback before submitting PRs.

1. The docs page should have a tooltip/warning that this feature is
experimental and likely not available in a standard distro package.

2. I haven't been able to fully grasp what --enable-experimental fully
entails, but it seems to include quite a bit. I want access to the
json output mode, even if the schema is unstable, not necessarily all
the other stuff. What are your thoughts on a patch to separate out
json format into its own feature flag? Maybe
--enable-experimental-json?

I'll submit patches for both if the community likes the ideas.

Thanks,
fandingo

