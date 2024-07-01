Return-Path: <linux-btrfs+bounces-6104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD091E21A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4506E283097
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28E15B102;
	Mon,  1 Jul 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="25B8Fhyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200A8C1D
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843368; cv=none; b=OStd14ZnX+S+2V1kk0nwplSrLUM9m2r8/PG+O4A97GvzgJFpl1ZeaKqUFo5BDLBGqsNAofF35FPDNt8rxh0xCrSEPLdasOBRr6/vrBDdhuR/hiayC15F6GXaIDSaReLvdGbW1Z7jUkhElX8OpZ2x4HpKLF4AL+YbYia8dmnqH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843368; c=relaxed/simple;
	bh=qM8q64AuntNcrCS0om60CodOX/obePOP8YepPP5dicM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeNNi/yAQBJHv1RVSWDi0reD/GNjLbkcekaEjNRBZ6raC3K0d6d3gKZ7a+1pC2xt1gyf4DFzuzsf91CylK83IEIYlKENEEeKiHdHEd2c6UI6ohLS/ipXuYp+ovzyfBjDOWOeWcbYtT7oWuBW6kKbxZ9nF82XTnpZgP07lxYQDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=25B8Fhyw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44639872fd4so24182011cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719843364; x=1720448164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYLQ5WVgalLniLyBo6Pk/JdAA9oT1HDsumsMFmZdl5I=;
        b=25B8FhywoYJ0kohGN90tps2BBxr3oKvN6rws8aGbuF7rGDIpDi/Ds4ivEHUqGiSCwC
         JtnSe4Xx2kj0lHzVI3Uqf45IUTf4GE5pwXCK5LmlgaI38E7+SQS/RNbyxD20BslHAMPa
         c9F45PaSPTlPY/FhzepqOsk3GO67BDD2TwCF4BBNvWyWQox9mS8/Eh8lXzdXDYpMIne9
         28KnEvzhPuMMIJmnzdRit2oo9SkRXsRE01hnsM5u9CFd3Y9dE9W7GUzNoob/eQFb0d0t
         zb8iToc2pvuhgy6MdZho2phihSAxqtGWyRAj3r9U6YooFIJ2v+GphkiK+9zZ2FGVbNm3
         xciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843364; x=1720448164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYLQ5WVgalLniLyBo6Pk/JdAA9oT1HDsumsMFmZdl5I=;
        b=NxMwAIaRbLZB0Cid3PliUYPiBRxshJ+kF9SxkySpAiRnQTHgfgT+Dwu+X0MIyetFA7
         Gn6qZk4E/aQba98heZqW3yWqONqwOIvAprWu2hkLR95aEpK8w8pcHF0qqN4DYNMBv2G1
         u+2ZX9Jsb7dW6uhJeVOhwQFA8Nkl59b35nMNFeTtYEFIp34wxfpAb5QuxUv8//BFoBx9
         CikK47UcwWmKTGJgZigmt/cDRS+KxRxa7sgKehdzIHbfWVTC9EmcPhoaKymLxIbJjyJO
         p5glgwxVc/Eljogy6bKpbn5Gy1KsuumrMKaXk1uedyhq2BRsscnaN0kl1wM0IIyvG/Y9
         GoAg==
X-Gm-Message-State: AOJu0YwCkhXFvZCGLV0aT2LIRLPIHUCW/odRWxC484R3DD1UPbKQLq4k
	mhzGBu7EZQ1LJAVeHBtjfLERjf4xQdFeSDPUSFIHIkT25R8P65+HG/Sr1iAqEieIugO3anOp6bT
	u
X-Google-Smtp-Source: AGHT+IH7DnnQpC56FRRjHuVxUGTIer36j+ah8l1Dd5PBMHMBbd6jtJiG685zqU/EanNxdIZr3jOlNw==
X-Received: by 2002:ac8:598f:0:b0:446:497b:fa59 with SMTP id d75a77b69052e-44662ea64e1mr72578561cf.66.1719843363823;
        Mon, 01 Jul 2024 07:16:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513db848sm31617101cf.1.2024.07.01.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:16:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:16:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
Message-ID: <20240701141602.GJ504479@perftesting>
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>

On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> KCSAN complains about a data race when accessing the last_trans field of a
> root:
> 
>   [  199.553628] BUG: KCSAN: data-race in btrfs_record_root_in_trans [btrfs] / record_root_in_trans [btrfs]
> 
>   [  199.555186] read to 0x000000008801e308 of 8 bytes by task 2812 on cpu 1:
>   [  199.555210]  btrfs_record_root_in_trans+0x9a/0x128 [btrfs]
>   [  199.555999]  start_transaction+0x154/0xcd8 [btrfs]
>   [  199.556780]  btrfs_join_transaction+0x44/0x60 [btrfs]
>   [  199.557559]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
>   [  199.558339]  btrfs_update_time+0x8c/0xb0 [btrfs]
>   [  199.559123]  touch_atime+0x16c/0x1e0
>   [  199.559151]  pipe_read+0x6a8/0x7d0
>   [  199.559179]  vfs_read+0x466/0x498
>   [  199.559204]  ksys_read+0x108/0x150
>   [  199.559230]  __s390x_sys_read+0x68/0x88
>   [  199.559257]  do_syscall+0x1c6/0x210
>   [  199.559286]  __do_syscall+0xc8/0xf0
>   [  199.559318]  system_call+0x70/0x98
> 
>   [  199.559431] write to 0x000000008801e308 of 8 bytes by task 2808 on cpu 0:
>   [  199.559464]  record_root_in_trans+0x196/0x228 [btrfs]
>   [  199.560236]  btrfs_record_root_in_trans+0xfe/0x128 [btrfs]
>   [  199.561097]  start_transaction+0x154/0xcd8 [btrfs]
>   [  199.561927]  btrfs_join_transaction+0x44/0x60 [btrfs]
>   [  199.562700]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
>   [  199.563493]  btrfs_update_time+0x8c/0xb0 [btrfs]
>   [  199.564277]  file_update_time+0xb8/0xf0
>   [  199.564301]  pipe_write+0x8ac/0xab8
>   [  199.564326]  vfs_write+0x33c/0x588
>   [  199.564349]  ksys_write+0x108/0x150
>   [  199.564372]  __s390x_sys_write+0x68/0x88
>   [  199.564397]  do_syscall+0x1c6/0x210
>   [  199.564424]  __do_syscall+0xc8/0xf0
>   [  199.564452]  system_call+0x70/0x98
> 
> This is because we update and read last_trans concurrently without any
> type of synchronization. This should be generally harmless and in the
> worst case it can make us do extra locking (btrfs_record_root_in_trans())
> trigger some warnings at ctree.c or do extra work during relocation - this
> would probably only happen in case of load or store tearing.
> 
> So fix this by always reading and updating the field using READ_ONCE()
> and WRITE_ONCE(), this silences KCSAN and prevents load and store tearing.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

