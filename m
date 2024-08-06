Return-Path: <linux-btrfs+bounces-7014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F77949B38
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304FF1F2100D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AA1741DC;
	Tue,  6 Aug 2024 22:18:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76E173347
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982731; cv=none; b=oTASRQBECIGD39pF8y2DeUYg/6x5oe/+Iug/CEz+NaSNSw1uL82tOIKL4Kd8l3iMtJ1lHjAeOqseBfGH6GEAuTWHXTmTl6oTcyO8+I2BAH3cs/CJoDqIHscFXgo1ocv8m1W+INmwlv4JJqgiHOVCSmt0EKmuW45nRluU5MeR2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982731; c=relaxed/simple;
	bh=XBOTNrgQouJow2mtcvNorPdu6ZwHPZzLY2QvmeOTCiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ffOqx76GyBW5R/x0qd2dXIMGd1U8eJlSfxkfABaepnJXWWUYmYod9FrD7QKrljFBpysd46TGXZX7bFiIJsfopJOV5jWys1pZ6zJDTERspvB2EHsFKsZ2/B/qSwU8aE64KHMESxnWKvJ1UDsV4hYrOqwgZYk+eC0I3MbHtuQ4fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f99189f5fso160576039f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 15:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982729; x=1723587529;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PP1h4B7qKO8yrH53cKEsFZGXe+GswNbdNOzW19uGwAE=;
        b=khw4Cw8QAPZbpz7t8r653GJGsIihLRH4VNGhU5ChqC5KMNVxRxar9EfqzS09yjyHjw
         lzczgSoL+vFd0RVRydt+EcYM1iGkCirvxB6Q16ccX/1yN0f9bbdriAWM9b+jOabSUJmZ
         S/UxlnYPr2Lsai30naquFJscz92wzX9jlhksP4DX/Aq7QTOTVRKmpdz19HhsCyfB0uZ4
         +j6YnkkkSEYvMtqz2aLut6PZoaKKOWg5G7bWZkqXfTbskx4VHQ6UdV7QrpeAquBDuV7g
         gsxfY0zwr/Etn7E6hLsIcdzoTiSNTA25HI84prRrG8Mvp5uMugWsRV4lm02Uo7iDoNTr
         clHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTb+52i60VxcmUTPuH+X34v2L/K92zp0xBIWLB5D/IMnVSZ8+6EXj/0ayuN8lxiMKW2qnQpkehvuU2pTp27FqwOerDdPp4xh0uYg0=
X-Gm-Message-State: AOJu0YyOMfE/0t7O8jS2CLOvNc8oo4tqMzfsHsdWeD0FomWHAQLg/I+s
	mrSIuDNNdvrPlxLo9scSEFGNyE2muLC9PoQ5CuTxHRWMQHgpcYBjdiuHN8LqLt3ld19cnBM5AqW
	dC8qEewu675/Rk6ZvHXN7GlVdD1LMO5Jn+u7VK/1SF8klU2WfnwH0GrM=
X-Google-Smtp-Source: AGHT+IEqdW8Z5VhqHm6dClecQ4wYIXRV9ksWbAnqmdhH3XztqBCnSSroE7lkNLCSVKg+hPdCtCHjxCnXsBV7INOaCNeVHh2tszjE
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c4:b0:81f:8666:c71d with SMTP id
 ca18e2360f4ac-81fd43dcf7emr62035539f.2.1722982728799; Tue, 06 Aug 2024
 15:18:48 -0700 (PDT)
Date: Tue, 06 Aug 2024 15:18:48 -0700
In-Reply-To: <20240806221845.GA623904@frogsfrogsfrogs>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000812b06061f0b2d48@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
From: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To: djwong@kernel.org
Cc: boris@bur.io, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	fdmanana@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Aug 06, 2024 at 12:25:03PM -0700, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
>> Author: Boris Burkov <boris@bur.io>
>> Date:   Thu Jun 20 17:33:10 2024 +0000
>> 
>>     btrfs: preallocate ulist memory for qgroup rsv
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
>> start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
>> git tree:       upstream
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000
>> 
>> If the result looks correct, please mark the issue as fixed by replying with:
>> 
>> #syz fix: btrfs: preallocate ulist memory for qgroup rsv
>> 
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> I don't get it, why am I being cc'd on some random btrfs bug?
>
> #syz check yourself before you wreck yourself

unknown command "check"

>
> --D

