Return-Path: <linux-btrfs+bounces-8188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74431983C62
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 07:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97E71C223F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B056433D8;
	Tue, 24 Sep 2024 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmViHd+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFA2E859
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156176; cv=none; b=FJZNNtfb9nWSs1hUGiyqgmdK9d1e5cfEP8OSYhCH30T6t9Mg/4hG8DyIyEHzhzwiKEWZYSxXaCeCnRNtErIDgVu5AfbZChuiWZokjUPOfRTZjpvwf+jakOhsnY/SGo8D+3xqVdMbDtSIEm7DBC6z0HW5YFMei4rGdt3ZhpKEDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156176; c=relaxed/simple;
	bh=Hvr4AMKSMz9jxw31vMpq4KtJPqhRP35fsSccfSGs/dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6su8y84R3FLC5avx4E5GCjnAmX2S2i2KbMRrhSn9hZrLZRlD6x/PcI1vPyQDv/1dZHhzvUBaauto7PvqqvjkpFqqznmrZxOkGNqGbt86/C8QTYBiGi/ROOPdK9Czf6CrPsYVVAsSWhgFdUM/WrcARNaofYkXZQL5y4wPZ8zcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWmViHd+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbc75acbfaso44286637b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727156174; x=1727760974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvr4AMKSMz9jxw31vMpq4KtJPqhRP35fsSccfSGs/dQ=;
        b=XWmViHd+yWc9NjHcpnS9Ce6qdm7fX1Nzl/edf4CRMZmaEKRzZjnfaF275OhEtblPKC
         hnAzwQQT37H3DJFO3IYr/Unr7i/OHPpc7pTWvYb/wlc8ytGH0xd+QO4zenkZFS0Dj66i
         JcmwvMorv47+caVTPqjiggI4Xsj4fp44HFoyobCZVP/DxAotVK+tRySeJHpxilDtVgmp
         wS/Tw8/eLbYRC6HlXjBCBJapKdBH55BrWJ1ffaw8yeTFM9ZD4IE0NK65eOZ8ARJT2KTK
         q8/QGBrZ3RqdgWiZPTJhooyn52nLwaMA4DitiNe0oquLb6BpVVlKiVxYQqT923+Hjb2U
         uhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156174; x=1727760974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hvr4AMKSMz9jxw31vMpq4KtJPqhRP35fsSccfSGs/dQ=;
        b=VPGJxfv7ERqAdk/5CJZ1rFBgaQIqJ0eLWC6+BRcQENvf7LkPOHtY+AW2Jf/3AxXh57
         8OvQOKIiDppeX4s0GMTil7eQusSn7Ziskbvo2xmWTKn7DyMwgIYu2QavtGyLohz74pvs
         UMC/vkUheOrqI97L3/GSYcbcvgJQYYz+J5qv5rpUEliGwVF+UYqQ/I4Nc+0pvnKHIgil
         OC5urW1OyMMtOAs6N8d+bdtAs1oVOf88/bvPAw2oTRTyKxUQGakaBHl34zThqYBU2AVV
         E9xOhLpTrkI09TynJ2te6sOydY8+B3PiceSiHf9zM7p4ieo0vFRcGPvlZDZRMNXeqv4f
         DzTQ==
X-Gm-Message-State: AOJu0YyXz0imAphPwsmJEylxXEoS+jDkWJZaNFzZxeSZhtTFh5vqy0HR
	tNvqzNRLDOZtVOPe5MQ28VZ0Hzj4hMIFdj1xC7Sje3AxdoQ6XgYB5ZD4yuqVllNnA2/iPuorFCY
	NtHvlizY2EMO0TZnS8ufqKz7FhDk=
X-Google-Smtp-Source: AGHT+IEZFYQ7v2ziuXPyy4gt1IX7IbDgFPezgZzp/kn8ddZBH9oM5JGxAz0p0qUqLcyhqaO6Drr8vGGmfTG0fXYXPfA=
X-Received: by 2002:a05:690c:d81:b0:6dd:cc7f:37c1 with SMTP id
 00721157ae682-6dff280c845mr115304667b3.9.1727156174345; Mon, 23 Sep 2024
 22:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1079dd1b-b43b-434d-86a6-f65b20b4cb01@app.fastmail.com>
In-Reply-To: <1079dd1b-b43b-434d-86a6-f65b20b4cb01@app.fastmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Tue, 24 Sep 2024 07:35:58 +0200
Message-ID: <CAK-xaQYYiNafAfch29+odh6CdM7HOQh-_iJFMM_ij2dBi3X+UQ@mail.gmail.com>
Subject: Re: 6.10.6, tree first key mismatch detected, write time tree block
 corruption detected
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 24 set 2024 alle ore 00:19 Chris Murphy
<lists@colorremedies.com> ha scritto:
>
> User reports sporadic write time tree checker warnings since kernel 6.8.5 through 6.11.0 - some of these file systems break, can't be fixed, and the user reformats and reinstalls. Therefore some of the corruption is getting to disk.

Long story short: I stood still on my laptop with 6.6.x. With more
recent kernel I have similar problem, not exactly the same (looking at
logs you posted). Anyway write tree checker complain about broken fs
and switch r/o. I saw this running metadata balance or removing
snapshots (I've got 25% for bg auto reclaim). Lost logs because is one
BTRFS partition (root and home subvolumes).

Long story: two times I faced this. After: power up external recovery
disk. Start kvm to play with BTRFS partition without write permanently
(qemu-system-x86_64 -snapshot). With Ubuntu stock kernel of LiveCD
24.04, mount with skip_balance, removed snapshots, re-running metadata
balance, umount, btrfsck --check-data-csum, everything is fine (it's
4TB partition full 50%)

Can't say about 6.7.x. Avoided >6.7 because of shrinker, freeze and
hickups. Well, some of them I can't say the reason: maybe driver or
whatever. I'm using since months 6.6.36, 6.6.50 and 6.6.51, it's rock
solid.

Hope it can be useful,
Gelma

