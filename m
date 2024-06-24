Return-Path: <linux-btrfs+bounces-5917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36704914575
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 10:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A94280DDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826547F7FB;
	Mon, 24 Jun 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVyV/ZzU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D53F9FC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219347; cv=none; b=F0Nv7ImHaPVXIJVmT8qkfOVJ1JV+TuVOqj+yMju22B/t3R7AEuIbL1aaSnm7VIb0EAPA9WcRVOgL4q0kApnzfxVEkm8q42r6j+DvUn2el3Gfbq1qXXq/i+lrzXmZ/0ZNbR3Oq8UVtxuB1OB8sWddcq1pZjJHlIrpdtrjkEvLijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219347; c=relaxed/simple;
	bh=nomsBXf0EycBaCSJPb78n+uS0vjDLE/nrYYnE5q2lPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThbkP1RDJ3J7f6ejyBK4dkhk8DDXyalThboLYYXyHXc3lCEjdxODpRM90fCYytLztRrEgUircO2JB/96PLJU+Qaxx9nsGgY7Heh6nCVGRICjjVwOHyjThdU1VWmbnIi+JE3wBIfxyEw34fqw1GqZQ+OeNHu6lNSR4a6XC0755CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVyV/ZzU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70670188420so983028b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719219346; x=1719824146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nomsBXf0EycBaCSJPb78n+uS0vjDLE/nrYYnE5q2lPY=;
        b=KVyV/ZzU/169jhozmzzT6zy+aQs4OPdNPpOvbR7dmIZeinkN3Cg83szyBJaLMm3B9C
         499qmsyPfQhfgQ2D76egkB32B9syUz7zlHKlNFBglLgZ1ef0kaMxnHqOGOACqrZdGwZc
         aLK1k3lJj/E6hgloIPQjhxhgf+XPpWJ5SK64z4FsszFLtP5EosoCKz6f+EcCOFr3Rc0u
         Sm2Dcxo3S+0eeIAu83qRgFjhz0a1/5zClUkFovLBUx1+GxgOughI5UgSv7jVVHpudxBk
         DQ71GjrTFA1G0LU6JdwM0ouvsHJbP8TBbcVQLXKGF5rTM4RwuujnMLh5d3Yc+adRNfIp
         ZmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219346; x=1719824146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nomsBXf0EycBaCSJPb78n+uS0vjDLE/nrYYnE5q2lPY=;
        b=k5UdqD4IE7DdLzTEsTr2xnRH+UuMvY3bd79R4Os7CTLXfUcUubUkjraR/anh7hNrp1
         roTlko7jE7MksKuHx7O4NjmS7Dui6x7lOjqVpdhZtTr6dsaV0up1voINp5tfA30dg6JF
         doSmTBlhsvknfPFPYc9atMZ6lRwSBNbIN+/Bv4pHyl4q125kNgKzOBOajgimCXaJR2X5
         qMiuIYoa2/h6k8nauB4kigj3/iE4PxG37etlCHYwIkiIvT1mD7HLzV7TLgCVZdvgeMIc
         MB7a16I/qRSBG36DvPE15RA5I4AfSA6BwFDW2IOWJxVABeGkkpUIqA/RgnzEtOghfLEo
         aKyw==
X-Gm-Message-State: AOJu0Yyt2ijHglsOHHzhP8EOaP1JrTEzdWo6b+BaaLGXlN5ZpKA34Re6
	/gYI76kIETwOSPPbIkPM1iWC93sT4tOIDIQyW8tVB7R0V03Ch6gY87nx4yNKjRU=
X-Google-Smtp-Source: AGHT+IHuL6LM2vMBcgbGig5Mz/Elb0w1ooRVyTeZa/thCW97LhYYmFWZwp+V/PqIG1/GiQmI0iCtvw==
X-Received: by 2002:a62:fb07:0:b0:704:14b9:105 with SMTP id d2e1a72fcca58-7066e538954mr4078112b3a.13.1719219345612;
        Mon, 24 Jun 2024 01:55:45 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512e08b3sm5686454b3a.182.2024.06.24.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:55:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] btrfs: always do the basic checks for btrfs_qgroup_inherit structure
Date: Mon, 24 Jun 2024 17:55:39 +0900
Message-Id: <20240624085539.140192-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
References: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com> wrotten:
> [FIX]
> Make btrfs_qgroup_check_inherit() only skip the source qgroup checks.
> So that even if invalid btrfs_qgroup_inherit structure is passed in, we
> can still reject invalid ones no matter if qgroup is enabled or not.

> Furthermore we do already have an extra safenet inside
> btrfs_qgroup_inherit(), which would just ignore invalid qgroup sources,
> so even if we only skip the qgroup source check we're still safe.

> Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
> Fixes: b5357cb268c4 ("btrfs: qgroup: do not check qgroup inherit if qgroup is disabled")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Great. This patch is the best way I think.

Regards.
Jeongjun Park.

