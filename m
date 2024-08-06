Return-Path: <linux-btrfs+bounces-7013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC686949B36
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DA01C22A8D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2117166E;
	Tue,  6 Aug 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKAMM9j4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954A15B0EE;
	Tue,  6 Aug 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982726; cv=none; b=J2puAwpiPta1mYxX5di/CM3gcRTvVUxWvwgtI0FQK1R08cHeVulefM+GDYYWT6hugBYDca3xAD0dZyAbIDLfwYe7jMRiv7J+0dRqNGsgYWGB+s2BGay+f6/Yv66XlMIJIB6qVQaA4cpi4UlU4wjKngrsk5HZK+Q5D7S95ublZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982726; c=relaxed/simple;
	bh=fBegLiTxA0N7AAc2njIPgvnl6X/brLv/goRh1ajhNnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+Muv+iti3Mf59zHDfyx2Iqj7pVmIitLdYyTTzvH/gItKeS/lwZTZsQMh5zW/m+SF7Klx/IjtzgSsQjLQ+dQH9JH1fZgLg13acNZ4imzWUntJ2/b06zpsAfeys6MTMjH8eiJu+JJM+BtpNiXxc35JfR5F5wPg3ZDmQ4lfCAusJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKAMM9j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88D4C4AF09;
	Tue,  6 Aug 2024 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722982725;
	bh=fBegLiTxA0N7AAc2njIPgvnl6X/brLv/goRh1ajhNnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKAMM9j4VKj/ExN4Wx+nNpzBVCY0GZDQHR414NKZalCLCBDrgyqSsnW2sqNIr7gzW
	 jbzzs9rejDWwqaXqiVYbFDP/nU5cuLFyQ9unXdboz1dvPGVHxms7Tt7qHEYJaAvrFW
	 /MGTRfOinT/L7So/hNBMH7onP6rwFcoHD9RdiTuRpMmHSmxGsKYos0y+8+CBYXffWM
	 rjNgUzLJ9jPLeUlyur8f6zXLfjJ5q2wrhIKR21IIf8MXUZL+w7LRQAsl8dcBx77IFu
	 cD+3JeuHn04XePyOws4sVj9ii8V3IEkIW0Q1BYGR15KdGtPU5U8uT1unF479yFvZW1
	 Q+9UCxPyGYcjQ==
Date: Tue, 6 Aug 2024 15:18:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	wqu@suse.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
Message-ID: <20240806221845.GA623904@frogsfrogsfrogs>
References: <0000000000000e082305eec34072@google.com>
 <0000000000001e43de061f08c0d4@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001e43de061f08c0d4@google.com>

On Tue, Aug 06, 2024 at 12:25:03PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
> Author: Boris Burkov <boris@bur.io>
> Date:   Thu Jun 20 17:33:10 2024 +0000
> 
>     btrfs: preallocate ulist memory for qgroup rsv
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
> start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
> dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: btrfs: preallocate ulist memory for qgroup rsv
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I don't get it, why am I being cc'd on some random btrfs bug?

#syz check yourself before you wreck yourself

--D

