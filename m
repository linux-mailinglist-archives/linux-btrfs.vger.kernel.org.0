Return-Path: <linux-btrfs+bounces-1938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED31842BBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CE4B26B40
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243D157E7D;
	Tue, 30 Jan 2024 18:24:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF4157059
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639049; cv=none; b=HheHFiX35PU3UR9OKF+4oSF4XxOZr+PQcIPcw+l9ALI5kkYLKnPG/M6POb2iWp5d15cQ7Roh1txvcTkFexPETGeWsrawLbK6hDr2PNtNmJUwfnWcW6lVwuY/+lJJkdZ6RbOoRACgNz8tE7H6rDkxI1SBUJsxnaSvf53UOyEbZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639049; c=relaxed/simple;
	bh=uoKI6RDYxfXNZxHDf7INMQiHroMYFz/pgjAqVLrTRsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uSVjgSpJHm0l+sseTlqXvofqyt+m7mxV7WQrR4tP53272U9nQLTpb+f4Pg+pzL+Q+DW9yhs4BsrtmyTwmkDeOZvp+wj2Bfj36Tz+2H8QrZz3QyCx/2tej/DPSNlrxaX8W2QjGd24hocLNFuDuLwIXf5IvVDWXObitqqiNXkX4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3637fbf4d1eso18289745ab.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 10:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639047; x=1707243847;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CV5aSs+6xluhqn1Lle8bIA3VgXMJZ5IHasZ7SG6Dftg=;
        b=cb9MW7PqlV0LKkDY1tOwhY/RRqQbXYT9cHVmcjiam3M1pR5Z7bzTH5NJoAWl4JHc+A
         fBVVwCBJdHONCIhnOs3DyOaXsHa1JJo8FI+Kz1kZelXADY1yz9HT73zlGm/CK2j4QSBi
         vBb6mp2ylu7N2RfNk2egNxFXy3pvNBwUzjEx5H+NO8TrOwED5oTzXU+cWJRZA7AZ6b8Z
         DCfVtDPBhstUf80jbR/kGrmyM1KZdQnGROOzQzJ0nu6YmrQjY5Vv5f29pf5cZbvFhUdn
         Lk85Pgf56B/9O9BOFzWBc3KdTkfh9zo6Zep16LIAtjzj7bRAx/oruaROzvzPxtHdGahZ
         pa6Q==
X-Gm-Message-State: AOJu0YwgbnT9soQJIfsD9lrojazAyYfom9W8pwhHhwMdPk1E2Kpc/dTa
	axtKP4RehX7DxyIpHFBGjXlq81tuHC/Q9CFhl05a1Gqq/ZpJ29UwOG2nh3ap274kgRFzVV6MmZa
	C7GB0omv3piyB+xSFJ0VsCTDGfQ3y6xO9tldEYp7xFTV+R2Ejkzy+Fh4=
X-Google-Smtp-Source: AGHT+IGqPlnfA0jiwGiQvSw21UNGIJNql4jllxn8DVhRbkrpiczcaQWyBvCfi/ZU+uSb6Zzyo1VSLAsavb7KAC9C/I/4wKiYZO18
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:361:a961:b31a with SMTP id
 h21-20020a056e021d9500b00361a961b31amr855839ila.5.1706639047616; Tue, 30 Jan
 2024 10:24:07 -0800 (PST)
Date: Tue, 30 Jan 2024 10:24:07 -0800
In-Reply-To: <00000000000014b32705fa5f3585@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003172ac06102dde5b@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_orphan_cleanup
From: syzbot <syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103f19fde80000
start commit:   1ae78a14516b Merge tag '6.4-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=50dff7d7b2557ef1
dashboard link: https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255f594280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b28f8280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

