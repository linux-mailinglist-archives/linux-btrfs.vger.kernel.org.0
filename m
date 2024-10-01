Return-Path: <linux-btrfs+bounces-8362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D298B890
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10273B23D99
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0262BAF1;
	Tue,  1 Oct 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPorFRz5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FD13C682
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775914; cv=none; b=oTmLWHQ6BFIs3u6FFqA0sgoMODXJOl+HMVlIX3UzluT58k4J181dyrIY8WqodRU0ytdFhTrIf1dBLWoG4JfQSaqklQUPh95gvKn5k4OTdPE25XLOLsfw4Ck/VJ1y+8/i5UOe1BUGRo5YQ0joNC5qBNi5fPNaEcv1hDUoL3nvgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775914; c=relaxed/simple;
	bh=DMp5bMGJ98oyyYuyoOiYE4Lcf6ZqAXzpW4R+l3ptjLI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QqiBC4kv5jUZSwkUN4W2uUCr8rzKWO8EniDP1DVcLuy+ivhNrfwrM3EBx8mOsEEWoAdNCzGpPcmTi5qy4e98raD9UaFRD7fddWy4/5PBOWdCN7YemZ/piBrlSiiGo6SOOZdI2Vn5U0bOBkpMzdDegDloantMZ2q6DUTM43Z9cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPorFRz5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so6916871a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727775910; x=1728380710; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2U75/eJQF06ndCVhyC8qZcyj8P1GZFK5FTw04wSEcfQ=;
        b=ZPorFRz51I2PlviMAAVxENcI+mrj8PK6MmAi8lN3hSmbiD38nlcKO6QOEyp01WC0k6
         WAbFLfkv89LMCTQdfL4DQjv5xEsIlD/+RRSkNkKdpbiAhuzWoy2Z/NCGczXRYZZHyoTG
         hB2ZhEHGJIAt+0rEfmyiMms9DHiBm4L0q7Ovc8TPX5PyFUnyGUXoZfF+YFSJ7FzkQPUa
         LWiM8uobiyvIVEcYAet+qWrGvfhXBHjlvil2BhWYi/VUKYJ8/pif19NKdPz2kMcCrfLD
         6B8u65I2qTfGXYKF34ly2GmNjwSqgEkLzTNv5WN09Mw6mxx79FR3BM2AISG0wzRSgR4g
         Znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775910; x=1728380710;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U75/eJQF06ndCVhyC8qZcyj8P1GZFK5FTw04wSEcfQ=;
        b=dNB9PP5Dq57BxeX4pMRkXQY1gH8Xr89fwnfAx2X8Ej1XqXCsmRcGi8bKsfvIDJTB8l
         S8HHQfZCk/qtrI6U9uC5BUYLwTmf0479so3N5cZfAz2FB1bk9CrQdVTqDoe4+8Jnc91f
         dyKO9AWp5G3w5p0L4Tctwn4AsCZMEtbjd91trwXGXNxhqpQOlAFE/Ll6U7iP5symW58D
         MpUOPw5hbhNra8aZrGYPNc25+j9X4DXYz0ipwPXKQeohq/4uuouR/8D8FmD+uz6RCkTl
         J76kJd6EHJWnF23GhVoANYGmS+n7Pok5gCbZ/upsBC1tEkSWJC8ilvl3hVbphI5PcPff
         4RQQ==
X-Gm-Message-State: AOJu0YyGjgqab3rXeoTnL0BYFgxSs9gAhb1swQsqQ6fmbsARsTthKSyo
	bEQxS5cMTfcWntbwSSnhjqlrk0LqJ+H2shNrrLOuAXtKRXD4BB56Pmt4fKJRx6Xbf0wMtbqPsLo
	uFFAjJnpS3+42f/PhwQAdAbRcAkFsKmq6
X-Google-Smtp-Source: AGHT+IHCaqe1f/Feb8LP8cp6RIYfuKHj7TqCIEeY19dfTJPMAaTwpTCErlZKczWIHYKjujQJ4qeCtl8aAo95JNlUOV8=
X-Received: by 2002:a50:858b:0:b0:5c5:c059:63ba with SMTP id
 4fb4d7f45d1cf-5c88261009emr11799223a12.35.1727775910445; Tue, 01 Oct 2024
 02:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michigan Color <rt7946ebay@gmail.com>
Date: Tue, 1 Oct 2024 05:44:59 -0400
Message-ID: <CAP1eV0erLQOGTXDAgm0Y0cVxOL+x0_7ES5nq=_bu3-8kkR52-g@mail.gmail.com>
Subject: check: Almost a day of super bytes used # mismatches actual used #
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is about a 500G BTRFS volume on a 1TB Samsung 980 PRO.  (Nowhere
near enough TBW written to exceed the warranty coverage...)  NVMe
drive is being replaced.

Had a physical write failure on a root partition, and the kernel made
the fs read-only for that boot.  I was able to ddrescue the entire
volume to a file on another drive, except for 16k at sector 423725416.

On a clone of the ddrescue image I made, I'm running btrfs check
--repair.  It's been in the checking extents phase for about 18 hours
now.  About every 12 seconds, it prints:

   super bytes used 456946466816 mismatches actual used 456946434048.
I can press enter to make a blank line, and see it's still printing
that about every 12 seconds.

btrfs inspect-internal dump-tree | grep -c EXTENT_DATA shows about 7 million.

It's not printing one line per extent, is it?  If it's a few days,
that's one thing.  But, if it's going to be 7 million extents as 12
seconds each, well...

I almost wish I had tried filewise copying the volume before running
this, to see how that went.  I could always abort this, re-write from
the image file I made, and try that.  But, if I needed to go through
check again that would of course set me back close to a day.

System is an up to date Arch installation, but the kernel is from a
few months ago since AMD released code that prevented the system from
booting.

