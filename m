Return-Path: <linux-btrfs+bounces-7408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32995B53D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0041C2202D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752D1C9DCA;
	Thu, 22 Aug 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L52gNvw1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04584175D3D;
	Thu, 22 Aug 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330732; cv=none; b=gbiNhF7dtrPSwgdLe0x8a+Wino8c2s6HURmone6lg5Qg4UnR2AXQf7p26LJCOzs3Px+Wk1FcNz3KjCmdRhjFxSbP+DhyDaS2bJCwANLFadNp5pRkIZv9WdI7LIrrPGAc+t/ntsZIP0g8KVe4Uap7Zu7xga1Ev61Yj6Ua2ZdCb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330732; c=relaxed/simple;
	bh=Q6SH3FYt51by2q32IKhEP/t4rViZNyFHFgf+m1/x2RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9Ci79uYy2idm8SIgjC0bTxgY+4R/4EkghVZ/TJBvzN9L6d6BGSsLVBSY3h+bi718fh8HQHjb9c90q7FDG5HjdBG7o5SuYcTjo17HjYJvaloVCmI2R9L0E9a9VcS68jxD4egfT6EOyCf7VTrMRFYaoBgmjMq9s18qSEaAS3Ivo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L52gNvw1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71433096e89so680679b3a.3;
        Thu, 22 Aug 2024 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724330730; x=1724935530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw92LChcTdvrulVUMy/q3xlLOj3MhEnQ5NiA8+OpcV4=;
        b=L52gNvw18J7TaYVg7M3Qc1J3cHp49wJ6s5Ba5BNiXDJW7Ck97myZWMRNnPyLJCrfCp
         OW2DuOB86jLeMA9lrZg4GSEqD8Ev+M0JbINkXTTN472IMFWkgORYJaerQUTWVe5bIpCq
         SlBrcIMnMfOC+zvz5V8fVfLTlFpAnTqASH14sAnA5lBT1leIANPuB4fuqxEd9/efr/gT
         gAz0/o3/7x98knSZNGCs58oND5oob0gJjPx/nUeqSGhHjC4aRJPXJyLQ/FINcVFKmxwG
         ooEpMN4ejB9/Iz5hDl+RRMgFgrIeh8hW//vTN4CoqvUxpbm6A/xK1TQJwbUT26Bw+0QF
         o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330730; x=1724935530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw92LChcTdvrulVUMy/q3xlLOj3MhEnQ5NiA8+OpcV4=;
        b=I8VDs9c20V7zQCqbi6dfHVHJSSAc6cG4AlxvaW3IHCrBTjoZpjrhGzQFfuj2pcvGQz
         zDgsPEunney7Xs6OLVycVzhFgfERfo4lEngE8U9QQd4KoYkFVk1LCH8HDK0SxOpS9JEB
         wcJsYGkl34BO3CFdCNkaCkdwnIyKqax3zByqvScibhZ7WTYg6uOrpai4PgaKtBvmDFyD
         Cjf80p+hJuY6etREPKJP82ga7duFln4kTrYkzBcAcU9fXbq1if+fqFINPRrmsSguuiNI
         lekEIwloZQwxUNFKoajDbalU1fAKadA83X2iJKyqct/KBJuOAWAGBm0/VfS1ixV7jqzA
         kgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0egqpmGHkTb5Bu+4fAEsi24p8oRwrWAGH4M6zDiU8QuRw+r5Vejwm3fXL0233gz3MhmN4VgBbZPnVw==@vger.kernel.org, AJvYcCXZoOopzblVTb2Zr3h2YtoNCKeddEhKBy1UyxgJvcGO/67OTCpPO+uxYRm6uH4Me1jAKtKGr+kn@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPVDgGAqhPUBZZr9HtQEcFYFQDjiBLImE1y9GkWN0Anu4/OmA
	UvV9Hu/QhUdEv4baKc+0O14hvezvH0YnhKRgffzpjpwxmzoy1C2M
X-Google-Smtp-Source: AGHT+IFLyIiw2H8N9zrfgYgnFd/RF9RmIos3SZDaew6tEoJwsYzlV9DRkvYpBNC4LPdXd0KiRHSwmQ==
X-Received: by 2002:a05:6a21:9207:b0:1c2:912f:ca70 with SMTP id adf61e73a8af0-1cad8163440mr7964266637.42.1724330730032;
        Thu, 22 Aug 2024 05:45:30 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af1879sm1677320a91.46.2024.08.22.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:29 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: josef@toxicpanda.com
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	sunjunchao2870@gmail.com,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix the race between umount and btrfs-cleaner
Date: Thu, 22 Aug 2024 20:45:24 +0800
Message-Id: <20240822124524.1375008-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821180804.GF1998418@perftesting>
References: <20240821180804.GF1998418@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Josef

I believe there is a bug in the following scenario, but I'm not sure
if it is the same bug reported by syzbot. Do you have any idea?

umount thread:                     btrfs-cleaner thread:
                                   btrfs_run_delayed_iputs()
                                     ->run_delayed_iput_locked()
  btrfs_kill_super()                   ->iput(inode)
    ->generic_shutdown_super()           ->spin_lock(inode)
      ->evict_inodes()               	 // inode->i_count dec to 0
       ->spin_lock(inode)                ->iput_final()
                                          // cause some reason, get into
                                          // __inode_add_lru
       // passed i_count==0 test          ->__inode_add_lru()
       // and then schedule out		  // so iput_final() returned wich I_FREEING was not set
                                          // note here: the inode still in the sb list
				     ->__btrfs_run_defrag_inode()
					    ->btrfs_iget()
  		                              ->find_inode()
                                                ->spin_lock(inode)
                                                ->__iget(); // i_count inc to 1
                                                ->spin_unlock(inode);
     // schedule back
     spin_lock(inode)
     // I_FREEING was not set
     // so we continue
     set I_FREEING flag
     spin_unlock(inode)                   ->iput() 
     // put the inode into dispose          ->spin_lock(inode)
     // list                                    // dec i_count to 0
  ->dispose_list()                          ->iput_final()
    ->evict()                                 ->spin_unlock()
                                              ->evict()
                                              
Now, we have two threads simultaneously evicting
the same inode, which led to a bug.
I think this can be addressed by protecting the 
atomic_read(inode->i_count) in evict_inode() with
inode->i_lock.

