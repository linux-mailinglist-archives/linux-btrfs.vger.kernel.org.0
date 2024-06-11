Return-Path: <linux-btrfs+bounces-5659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC90418D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D61C214E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0442058;
	Tue, 11 Jun 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ET/mTTOr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0517721
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124539; cv=none; b=tKQIrhfu5hcjANL37p4+lv185VZW4wqjustyo9h809UEw2kTNHrHl8KunW7+cqoLbtFFm2knmKwbDzT1OATXsAqIfOBi4LHSHcNKcRPcIvhKkpX3shQvFt8TNrGxdc95QAzzqwe2yZ6KEhXxrw3gub1VEZhPOMqPbx/bYNtgshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124539; c=relaxed/simple;
	bh=A+Q32bO8Msud9DAjE+w+cVey+b4YIQSDJUOeraFg05c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC+xBbbg/sWuh9/hw0n6M0oFaDnrqUV7E8PBXBmEFWvf3odyeKp4KlbXRuUA4snHr1yWaf9wRS3PFxIjVX+2o/5wZ7dZeMJElzkSxljjVoY0qP4LT29UgtD2vLEoIdeLgZJG2QhXFFwB6DAbu3JPLUw1E/mH0PIKYLFN/cIUg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ET/mTTOr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62f39fcb010so4360017b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124534; x=1718729334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SU5Z0+qurQVNetB0YODM2Onz07NARR6ZkU4JeU+Drjo=;
        b=ET/mTTOrpUxnpqirQReeXvwo/KFidNCtE/IGrMVKlKDFXnG8yjz6rEn0sBXD4+ODPA
         FJmvXtJssqYm7YJfl5s62RAq/vbx63q1vSSKJ2EalwY4Ki1qcP/z14YyjLNqswyyRB4c
         URBT9U1dqhHc2E6xWZNCVBPWYVRrCquK55PySauiFcYwlU79C8RnxF7yUMGblShzuEfy
         PsktrwLDuvfTBMuQCuxg/8cQUI71LvN1IOWj071Z8P01cA4ix6U3ZPu6qJJG9R2ri9j7
         a8RPnYrM/CyyK8Bl+ygVNh3AxMteiqhM8ZJ0LJBkN1JYthxMbbnyxEX6iI3yzmN3Aqa5
         MGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124534; x=1718729334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU5Z0+qurQVNetB0YODM2Onz07NARR6ZkU4JeU+Drjo=;
        b=sfR9FdoIi+2b/g7Zw/IzFVQ4y3C9OHxaSW6OUnns+HvIPlCJH0EmFwkyhUOQsSarid
         UMlOSguwc3QSHS3QWEjkI5igky7QB/NQBBWW+RDBGLBdohyZ3GhWGLLXjEGhiCJO+bV8
         Vv/EvuFSaADz64XLUj2WKgmLvZCjf2r4Db81NCKrA/NxrYiqVLE+OtrnAi3jRJKcF/mn
         7KombTxurr3xlC1cxUhFEJ9FD0CWLIRcsVMYbFusiYtCfSJL2vIYhCIv3HrrjiBkzwc/
         XsrLq0z0xn2ljwJj8ZWpt22lciBGIYNcOtO5FsQbYsCOHOfzNYtunhpPLj1IwWs54G/9
         J4fA==
X-Gm-Message-State: AOJu0Yxqcayh4ZwyAXkzP+A1CcwuYd8ru7gKRxgCxHamshL71z5oQNko
	69kCUHCFR3thy/Hmich+AR1l5Wp/4gmPEw7ljKPNWtBYx1fF8C17RFylweitoy4=
X-Google-Smtp-Source: AGHT+IHY8+RcMMdeWyCdBwHaqhDFALrriPg+8bmVBGDsrgayNHMmCpBTMKukp4gfXCfLyX1AlwuxRw==
X-Received: by 2002:a81:a14a:0:b0:61e:a36:8d85 with SMTP id 00721157ae682-62cd568c5a5mr120701507b3.50.1718124533921;
        Tue, 11 Jun 2024 09:48:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62d11fb1133sm7104407b3.116.2024.06.11.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:48:53 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:48:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid transaction commit on any fsync after
 subvolume creation
Message-ID: <20240611164852.GB247672@perftesting>
References: <65a8b2e10dc470b52858865906f36c80b77ce010.1718104115.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a8b2e10dc470b52858865906f36c80b77ce010.1718104115.git.fdmanana@suse.com>

On Tue, Jun 11, 2024 at 12:10:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> As of commit 1b53e51a4a8f ("btrfs: don't commit transaction for every
> subvol create") we started to make any fsync after creating a subvolume
> to fallback to a transaction commit if the fsync is performed in the
> same transaction that was used to create the subvolume. This happens
> with the following at ioctl.c:create_subvol():
> 
>   $ cat fs/btrfs/ioctl.c
>   (...)
>       /* Tree log can't currently deal with an inode which is a new root. */
>       btrfs_set_log_full_commit(trans);
>   (...)
> 
> Note that the comment is misleading as the problem is not that fsync can
> not deal with the root inode of a new root, but that we can not log any
> inode that belongs to a root that was not yet persisted because that would
> make log replay fail since the root doesn't exist at log replay time.
> 
> The above simply makes any fsync fallback to a full transaction commit if
> it happens in the same transaction used to create the subvolume - even if
> it's an inode that belongs to any other subvolume. This is a brute force
> solution and it doesn't necessarily improve performance for every workload
> out there - it just moves a full transaction commit from one place, the
> subvolume creation, to another - an fsync for any inode.
> 
> Just improve on this by making the fallback to a transacton commit only
> for an fsync against an inode of the new subvolume, or for the directory
> that contains the dentry that points to the new subvolume (in case anyone
> attempts to fsync the directory in the same transaction).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

