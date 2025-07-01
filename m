Return-Path: <linux-btrfs+bounces-15182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B726AF0353
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555124E1528
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35B27FD4F;
	Tue,  1 Jul 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T9frOHSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B2192D83
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396761; cv=none; b=GI4M7PlxhtP9C9prNsnWcbQQbDJhAq+yy92ifkNTTrA3XLjR0RPtNlKdXMdm5woW6+Mg1Gj67lhHXLqDhJGziECIQVDuwXsLfUaKGmNPFmhHPG1dYNae1NTFGhh1wIymoKKA6C59UpUQi91S1SZ1+AEwlWwwoWXoblYc9k8oQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396761; c=relaxed/simple;
	bh=3yZbjzxDVDYQJwaaKXh5NfwJopR6odWrswC4Uexz3EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9nZ3L3Knw5H/dn/8Qeiqou3VMWnXFLDoV+BKQTwb4e98qYmDBxCjDho22c18RXHO2PChPDjzVdz/nrWzMZI0lS3vG1r77jUhGTbMO/KYJu5fciUsOZJTavuQTCATCsvIsHkDgOgIApn3NpnXZkAptOzI3uzAivEeVcWkn6v/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T9frOHSD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df2f937370so19648435ab.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751396759; x=1752001559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/rCw+Zb9Mvts9DJelBmRopD1r8plgjJIjK44R7yOGU=;
        b=T9frOHSDOBCdAFJt1kmzXMDr/CXARB7S5lSdR+xvIha5y/TYEBrFK723FcvjGejiYe
         iq08Cb1NQfaF0zVkYkJjP/ajgD48CSOd+dVt0z3FO2pkkE37fQ0I35G92skzGjJrhNvY
         2o5qCDF2PqQ9Tq/JfZGiGyf9uPHxSEpqjgIhmFFQPcAMIx+06veheny05JFIWqvaDQOc
         DaMRz1NJlxIS0ctvTjZm8pcfFqqVUBc7vngAZcVgPXojK84eoziDh79SR8gk/ZdNqr94
         xhT6Gl1XfwRg0LYNtOsvJSauZAJkpL81uyTQNwnfcPj8YDlbikgkQw8l0/8NqlIksJl7
         LKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751396759; x=1752001559;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/rCw+Zb9Mvts9DJelBmRopD1r8plgjJIjK44R7yOGU=;
        b=EhDwz+plJbDP6Kry/SboFnz6vINoz3tm2U9Fy/hCYgcVucMaMwsT14Blouh+HEuz0y
         S+5UHA3yZSDZpzzGlihtRiMvaedr5xftH4NirxmkB8ChPuwG7fjjBNSFbjiqTO24tuOj
         NUEGJMTTTXZxwH97ZlyNczDp5BdugfuNR9zbWPERWhVGb/QVLmKumu1pgyAn8qCuVBnv
         bk0FyS4XWXtZ8l1aJF9RL322MvIljsbNzRBSg+rbodqYcQ+pbDfYKhlZ95htt+/3UZex
         41gxzuX9X2BoHxkEw5VbyVTLnR8eoSOsyK7bxNVehYCjKwr62Cj2yR3dcUbjJtRpIrmA
         x5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXS6U5rKE9BJsqGEyShNmDJ4rhUMzeBDglg9NT1lodQ5MRZhFITXZNIz7xVKyi2ZMtaURXvLGjTtEZMLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgG5PXrp/H4zj20FlJOdMl9cP5D/Cmu5XFJ2w1Od00oJp//Xe
	2K4RFSPsSxXBLyGS32N48ZccC0Lo9RnCBIEI9aejxMVOhxNu6HOXzjIV9QZDLByFfHU=
X-Gm-Gg: ASbGncuJZR23Aa5m2syeNz73B1jtFJiHp1RrIqoRZeD8B8qQZM/MURU+4ophkrp6jep
	xHXSv+Nf99b4b/zHHP90YPlike4H9zvPQYS5xni3hxpXD+BS1ZmYOrI4o7cFuWLpjJnV51daIDh
	4uzbM630+H6Ak8hby9cu+qcSL1c4QCVcO8bzzshWh2dXAYmy9lM73VbWRWKYbtGo/06ccXVSJKc
	Z6U62mOV7I6Fkt+Ee0x7jl1xScD6MMwMU9jEpO/rhrUXzcy9DRMShka6iQ7Uf/phucUF0ygSKt5
	PQUc7Qi7Xi/j4LssLkwcxfHwZ/Up7EYB37A7L0dzwCuLa89os4jXHp2Tew==
X-Google-Smtp-Source: AGHT+IGRWjQOhmtHj++QwKNWgHf7AHpn02TWL1X53w/dyXCPPx9y3hHFUywI0EXa9hDdgpHBFStmXA==
X-Received: by 2002:a05:6e02:3805:b0:3dc:8423:5440 with SMTP id e9e14a558f8ab-3e05485c170mr2894785ab.0.1751396759152;
        Tue, 01 Jul 2025 12:05:59 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df49fd4f86sm29817955ab.5.2025.07.01.12.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:05:58 -0700 (PDT)
Message-ID: <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
Date: Tue, 1 Jul 2025 13:05:57 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in
 io_btrfs_cmd
To: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250619192748.3602122-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>  	loff_t pos;
>  	struct kiocb kiocb;
>  	struct extent_state *cached_state = NULL;
>  	u64 start, lockend;
>  	void __user *sqe_addr;
> -	struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
> +	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
> +	struct btrfs_uring_encoded_data *data = NULL;
> +
> +	if (cmd->flags & IORING_URING_CMD_REISSUE)
> +		data = bc->data;

Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
would need to be io_uring wide.

-- 
Jens Axboe

