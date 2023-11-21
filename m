Return-Path: <linux-btrfs+bounces-248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097747F308B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3005B1C21A74
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5154FAC;
	Tue, 21 Nov 2023 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pSWkUxVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648B10CB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 06:20:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so5461464276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700576399; x=1701181199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y23FWuz6PW8S0smY6WbbhGEXrCcP+R/szjSRN7aCT8=;
        b=pSWkUxVlXFRA34cTwHEW5S8dLdvaOlMauGOpQrsISGIIVVqn337RdkCOF1uqxE28D4
         5q5J9sxipOmy203ltWSkS6XyIbSx7jKpMN67zeoqAG4/tch9bdZAUi/FN2Z6kxpCIk9B
         XTtRmPSe6pMEzSVIDVSgV09BSS0IT/5Qrlk1WTHI/8RqZxKJH8kbs7BILZPIRjik36jl
         XJFYpbvBVVcri5hGS6noJpeP307ZTKBDPcpZMfXUOpC9b/1cfCCcihGkXWnEj7CsTdGn
         7CruFkgYfulRRt6G86cly53oAGbL298KViJo5zABeIXeP1gi/lx9ArRyFvsbRhRobZeR
         Bskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576399; x=1701181199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y23FWuz6PW8S0smY6WbbhGEXrCcP+R/szjSRN7aCT8=;
        b=ZPZ4wIXQ8zoazujd7MvyyrGRnQm3VvXXP7g5ZBcp5ydxL3mZsNWJnTawCW5IdwRQa/
         z+MKsMggVL/NvXeLxKO1FO5HpB3cd6+nQLhzxSVvgZ44aAnQ/qzTS+pTn8K47HdDGtSY
         0u6SlOMhjoH53IV7wyfnXZN7V3VAn1RS5F+vU6lHM/ttifK3fAuNbx4WA0zMm03k76W1
         Lr/Ig83XQ3UpjtZ4gARM3rGo80W7o2YbXdf59Lz1/LFxvvp/4MzmO4sF76GH3Z32+DJK
         bSEJt38Ij0F4upPtdL3cKMawrwhytualIhHLH56msGOBFkhbCanSAYSGHyWU3shN8Erb
         +c6w==
X-Gm-Message-State: AOJu0YwFNv4n7N7TbNd4kjMX/KVbjheJXBH8TEsYpajhTOYcqdkUrEGh
	Jlf/QLOhw+cNkc6fiT/Tki2W84cFXRH3oIyo80mgcQNo
X-Google-Smtp-Source: AGHT+IG5DWqsbXiH9pgFAk7q7UR5i7wyXZN3ItzEAQNEvuTk8K0wItke4fzX4RrSaX/85x7oSg2NnQ==
X-Received: by 2002:a05:690c:2a85:b0:5b3:26e1:320c with SMTP id ek5-20020a05690c2a8500b005b326e1320cmr4372562ywb.40.1700576399323;
        Tue, 21 Nov 2023 06:19:59 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a0df704000000b00559fb950d9fsm3033400ywf.45.2023.11.21.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:19:59 -0800 (PST)
Date: Tue, 21 Nov 2023 09:19:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Reduce size of extent_io_tree, remove fs_info
Message-ID: <20231121141958.GB1667963@perftesting>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>

On Tue, Nov 21, 2023 at 02:20:12PM +0100, David Sterba wrote:
> We have the fs_info pointer in extent_io_tree for the trace points as
> the inode is not always set. This is a bit wasteful and extent_io_tree
> is also embedded in other structures. The tree owner can be used to
> determine if the inode is expected to be non-NULL, otherwise we can
> store the fs_info pointer.
> 
> I tried to do it in the cleanest way, union and access wrappers, it's
> IMO worth the space savings:
> 
> - btrfs_inode		1104 -> 1088
> - btrfs_device		 520 ->  512
> - btrfs_root		1360 -> 1344
> - btrfs_transaction	 456 ->  440
> - btrfs_fs_info		3600 -> 3592
> - reloc_control		1520 -> 1512
> 
> The btrfs_inode structure is getting closer to the 1024 size where it
> would pack better in the slab pages.
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 

