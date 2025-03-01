Return-Path: <linux-btrfs+bounces-11953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB810A4A83D
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Mar 2025 04:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B4F3BBD0A
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Mar 2025 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC02189906;
	Sat,  1 Mar 2025 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPoXLNwV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7B1CD15
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Mar 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740799160; cv=none; b=CGWWqWGHoNvCmUqJQRBFNMxVFcXHvIyt97j2pL+sMQ9rkN75yg19qK6dNiGBtQSX6o/QdooyEj5uXcyAB6fWL0gKAr9tI9ZBqNiDWRuKBhZL65xoZim8sllWy+VcNKR4vWtCBJyLR0/2wh+/1BA+pQnf90X0uU36pCFBWK+cEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740799160; c=relaxed/simple;
	bh=4xekqjCpQLzAr0Q14XWMMP+38rJCpfpCTWiN3F2+oFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=HMcfWD3gleLIZHGepZVn5zGEFJd6xeRcMQBBAtuBWWdny0k37cpTRTOtzk9cDo1LwzaO5xKOrzuD5m/839QngXTwUKW19xqGkc03XZ49atMRldyRwPf9X3EC7nLozC6p5yqibnhh+hjyEGr+pjnRZtNvrnC5V7YEUxiapetZtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPoXLNwV; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so681942a91.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 19:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740799157; x=1741403957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4D/4t7bX/6psyPB0fdCN+wO6mmkj2fRGyyrx/5bsw=;
        b=VPoXLNwVY1EBsBdIryqdQYEMmxAfTCcKjo7EkDr23wrzt6cQlrILGZ4D7FjWjZ/mzz
         N7XpRiDrUEIaqburEYbA6RfP2j5LumSsGynDSW6ZcGiHyGX3B8B5qy5TI0vs4IpbIY29
         f5WfsVZE1utUE8QRLU+ipP7e08E9lR+mM8BZotzk4ZffJbKtHrGr1mLtFBr618daNVg+
         VXuQ8C54OosG/NBlzfGYL29uRTPiPytXsEQuAw8d/avgrLDkpMjSYR7IfWIib8ItrTbD
         PXDJ5pV4vYqjXEeZDg245hwhWxQDxtpcp9xOswvrpbI/Sxn2Vdf8x8nO2PxDJNpREorI
         DENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740799157; x=1741403957;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb4D/4t7bX/6psyPB0fdCN+wO6mmkj2fRGyyrx/5bsw=;
        b=qXoSpd3gkhFTSzOHnYeRsqbA9mFX8Ph187YMzUZfX4OsnLOb2HnT3iWJdkgX2hss4O
         jUZCxT1xfoUqLNEYggkURTwFGc7xbKuPCRgdzBqoPZVrYp41ISqeFrnfG5xtxVX9CdzL
         BECEUApBf35rFhcQMkZOBoxM3HNUewvrLpdpE5fl6j0DvpZw46XnknmDAGgZ5cHWrdIc
         X31eYJL9TRJHPvGCdU93e06gbQ04hY1M5955eTieABcYuNU3VzmbPsA3Qx+TWzeHOVT8
         0rUNrG7IIC6+ixxsSxGd646hUNMihTragOytaYuQVUyJHLZcE8ZRnlF3RpDTaErYN5AX
         C2ZQ==
X-Gm-Message-State: AOJu0YyM9nkzxv8pEk61htPkSNMfdA30XGXLjMWJoPV6UK7fxfZxjB4c
	2veeu87tVXQ9eac7VN757uEwrRf5VtYBRlhxvKQnjFwMYBFhkHEt
X-Gm-Gg: ASbGncuGCCaAJ9dbeSxkxm6WKD1FYApnf4B+dlUcuA9Gsxw0s7bSDh5S9DyysL3rIZh
	vv/k1xbTVSHLZW/zYtT96OjLLa4BdfMCoeGfAT/3a3QkQy1OIeeFW74uw6KMd2g2p4x2IJtNAww
	zQwj12ZBN4rwxh41HozdBruZxGrSYFOl/6dMldhQRcFcSY8jcE8E6lzIWOLDSx5PQncl8yKiCta
	dR+KVPgn6oB/xybeMpotHHG6AB6723Hzkl1CjNLJD4lBDcbIlx1Nc+o3KsQmfkrJx0DFkSJPeWo
	t189ekMdfI4+wYy1hcNnTgI5teAUlYFNcjyz9uxWyfHv7PhPyMZLU84=
X-Google-Smtp-Source: AGHT+IEYMsyoGhSaOmUP1b2CXUhVzYnmJJlLLg9kf0TbvOqXUN3g/CZYSwOsnfzyVOwZrNuAvel9Rg==
X-Received: by 2002:a17:90b:1e0e:b0:2fe:a8f0:5265 with SMTP id 98e67ed59e1d1-2febab19f4emr3532748a91.2.1740799157518;
        Fri, 28 Feb 2025 19:19:17 -0800 (PST)
Received: from saltykitkat.localnet ([185.2.163.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98e7sm6714846a91.4.2025.02.28.19.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 19:19:17 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Date: Sat, 01 Mar 2025 11:19:13 +0800
Message-ID: <8510159.T7Z3S40VBb@saltykitkat>
In-Reply-To:
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

New to lkml, please correct me if I made any mistake :P

> +static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_ioctl_clear_free_args args;
> +	u64 total_bytes;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&args, arg, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.type >= BTRFS_NR_CLEAR_OP_TYPES)
> +		return -EOPNOTSUPP;
> +
> +	ret = mnt_want_write_file(file);
> +	if (ret)
> +		return ret;
> +
> +	fs_info = inode_to_fs_info(file_inode(file));
> +	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
> +	if (args.start > total_bytes) {
> +		ret = -EINVAL;
> +		goto out_drop_write;
> +	}
> +
> +	ret = btrfs_clear_free_space(fs_info, &args);
> +	if (ret < 0)
> +		goto out_drop_write;
> +
> +	if (copy_to_user(arg, &args, sizeof(args)))
> +		ret = -EFAULT;
> +
> +out_drop_write:
> +	mnt_drop_write_file(file);
> +
> +	return 0;
previous stored return value int `ret` is not used here.
> +}



