Return-Path: <linux-btrfs+bounces-16301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB0AB31FB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D4BC14BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA381263F4E;
	Fri, 22 Aug 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXe/TiuK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE91124679E
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877887; cv=none; b=H5TotvFXD3gik6kKq7Zrs9g+bbD8fIcmBOfYSOScmQvG7LUgrohxebVQ7M/LKYCv//qt2RlZZ0PwfCmNdnbXT1vMrWA35XI6ueEVj+IEeEJ8khW36ezcgEkniLvEzd/I6yrgvPmZOjn34FJ8KmIoAHveGuE4Zk1jCUuSH5pVqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877887; c=relaxed/simple;
	bh=q3p11HQ60N7YyFe+q1czztsfQ1k/I2umwK4C65cnMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=amOqJ9Rf0KrnNmE+ERu7Y0L4S21NwmXZKGbxnSmJDRPOSTc1/lVcMLffEYDie5imQwB2M9TyP3Qxxkz11DcSsLfDj/5Jg48oKU/P0+sdekQE0f+qJvVLLvDdSlzuN9FQJ5jg0Bo0qwxFxosdmg9e+Baf2j12jVsVciWxizbPcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXe/TiuK; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-24641067be2so1454365ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755877885; x=1756482685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gNoojvPzZIJ2vFZaANdlwat04C6PqPcOQxKmj1VhNw=;
        b=PXe/TiuK/9oBa99eKUC9CX208OI4kNn1cZxSqwBIR/iXF3ifennWvvFJUiYB92dWb1
         QtGknvnMXy/OfwVdRVcEgdeg09O8/kJTlDKPEqc9V/YTfBHwDYi66Oqo216TcMTpohTY
         n0BrRa8CvZGin4DKqlptA7u895HHFKtf0JR5OAlu7h+VTmpZYXmnlvECvqt5JGrFy0PR
         jTfg8XG4JoOoE+ZSHf72Lwv+A5QdbP+D0I66+9zb2AQGN52CFNOAiwZYQ5gXPX1H0iYC
         saEF8UTN8JI4G82cwgNuUiOy/wBqTFmG586PCJ9XXNWmSCkKD+yaBlGSlHRYwzarJejo
         VaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755877885; x=1756482685;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gNoojvPzZIJ2vFZaANdlwat04C6PqPcOQxKmj1VhNw=;
        b=DO4a8PB/C3fOSzAO2jula3rEpO9LyBhz5yBSyhf9I5PzHYOPkDiN2o5uOPy5SpLJ8C
         CDvUeUkd8yRcBJ0SePB9p6tVn3Ye1V2dRiqKhujmE7DG3mbvl3+hhxhsFnm7hOzq91Y2
         CtQKYYdm91TBTGkaPgjk799LR4UphD8DyO8udkEGxtaiA1gqTs0bILhGagyfdgMfc4r7
         g/vMfLesaKaA2OtByqYmp+lvL7unIRVjgfsE9x86nrtgeqQremMPn7fasKGBfcPMBFOe
         5TZyqpNx2mugG8PNtcPF4oy6WuCQhs4tbwMNRXiMF0RbPysD21JZy9t5urB6bSET7jPR
         473w==
X-Gm-Message-State: AOJu0YwwreSePh1ro3kYrPm/QPEDlTH/M+lR2RX6WlcRRjgWU52A7Y6H
	+y3TyWmWMN8bkSJuZOHxTS3HOH7xlBTvtTkkx/s7Fk5U8jggANPGuc9Sfb6flTBl4SmpgQ==
X-Gm-Gg: ASbGncvpLKZPiF86Lr+SNRE3I/Vo1PGGx+NuCSr990ilt5Bvts+VFGjtscP8KXOCqUd
	cqWEIQytadfhIzH3vSrfS6SOFX5VHbIF2y/8B/rRom5F7HcGAujXlbgsLtSgO8EuwXqyEJFmnPG
	B1PGmrMYzw39Hw+CZ1VCXeaOcB1vzQaq2P3Nl+gCkhNMQNpgJabR591J0E1J9r1D88UsFGb3WO9
	cXpszAPkHwcey/4I8Wlju95z9cMoFDLuV8AKIR9rISeswLab0sFxV30k3wcl9g6AqumqTkXbMvc
	fiuCvgOoCL2iE7SREcp5Kb1JaUSEWG7VrU72HX3Cdp0mVsBbJ98Er/YuSx7eX3MyOlP8fs6aGlW
	PsG2jh5ybU4lXj++hmA73/SDs/EZmZU7dqAxK0TOZG0EA
X-Google-Smtp-Source: AGHT+IFP2jnWLl/0fLufg8T6/CV6aknPBBpQd6W7MjGCjm7/UVegF1sog3LJBgRL29OlCjsIi1e7rQ==
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id d9443c01a7336-2462ef99564mr24454135ad.6.1755877884777;
        Fri, 22 Aug 2025 08:51:24 -0700 (PDT)
Received: from saltykitkat.localnet ([104.28.237.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877c707sm436345ad.22.2025.08.22.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:51:24 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Fri, 22 Aug 2025 23:51:18 +0800
Message-ID: <13839041.dW097sEU6C@saltykitkat>
In-Reply-To: <20250822130123.GV22430@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Please split the patch to parts that have the described trivial changes,
> and then one patch per function in case it's not trivial and needs some
> adjustments.
> 

After learning more about the auto-free/cleanup mechanism, I realized that its 
only advantage is to eliminate the need for the goto out; pattern. Therefore, 
it seems unnecessary to apply this conversion in non-trivial cases.

Moreover, if the cleanup code contains other logic, it might be better to 
leave it unchanged even in trivial cases.

> The freeing followed by other code can be still converted to auto
> cleaning but there must be an explicit path = NULL after the free.

I'm sorry, I didn't understand. If the freeing is followed by other code, 
maybe we could just leave them untouched?

Please let me know if I've got anything wrong.

Best regards,
Sun Yangkai




