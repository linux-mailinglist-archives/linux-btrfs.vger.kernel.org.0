Return-Path: <linux-btrfs+bounces-15259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF5AF92FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E517482319
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5742D8DB1;
	Fri,  4 Jul 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guA7Qxen"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3C2D8DDB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632945; cv=none; b=kjfPWxbFmOFcsM9p5u8eRdpzKUGjW4ihlFpz6KaFzEB+U2j8blNX/+0ETk3BDit/c+ohsElIvwmJJuumdkR8ye9u9c4P1GbaEMb8zO67ljjUHY3EfJPi1wPdoVFkcml1XE4ZvSkEvsjGWfy5GL0qI+Ns3OatPk/GnOj/cqfYKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632945; c=relaxed/simple;
	bh=iXjW/xsUHmGokVuwLp2f3sQNhBzBpQzh33grVo2yC6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=U9OOZu1dimpbb0CIN/rbnMX4tnr741EP7NkDCMwCDwp1xy6u4hEjdrZvV5sw/VmtNT7bQOEXGZ+25b47XkDcaHlsdrnvuuDsabmdpdsQAws9jmCbXftRqsdHQ2lJg8k74T0wny2qT18swI7ScS6X+0cRSJzlL2oOYY6eUchiI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guA7Qxen; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553c31542b1so1015518e87.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jul 2025 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751632942; x=1752237742; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXjW/xsUHmGokVuwLp2f3sQNhBzBpQzh33grVo2yC6M=;
        b=guA7QxenYPaOf0RnyP2H/wiz3sPI53xUtn31/p5pOPbt4kyNxdWFV2WOgDwg8vJbbr
         btkjyhXqwexZg0C4J0FIsfAhFu1NR3jD3Bzj6ZMouGBXSm0aE7vRrzJUax+lKxG2+qSN
         KmvKRIVLZFrqxCl/do80PBRhSDN+iFeWCrcX+Dm1Ow7IptadilSN/PZTbRsQ7rWCfueY
         KkcIetNZ5dPPqZTEXaVuyB/XR65BPfQfIKIYo6YUHmDDPD7EMbVcM1fXss6pNJtzLLvN
         b0snegHZkqgQ00qhem/SGpkI6+aJCU7z0prjNw/JM8rR2P4XmSXyUtpdYtXVRuYapvFC
         Ji7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632942; x=1752237742;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXjW/xsUHmGokVuwLp2f3sQNhBzBpQzh33grVo2yC6M=;
        b=ZjjEZBYTpT/3JWD0NC11Jn1JJQ+ySn2y00xQrJmA5Q3LRK40bRVmOZedcAQ81+Cj6W
         7FkX3IllI7tRjfJEfo4bccVTAKrLHxRvTHgtmc6PsbXlD9cNa8yejTkpb3tqkzkJ0EXl
         ekt4OfTYEyBjNMQ0gwF9qVGMgf1a2MAEH4uoY9AQfUhbq6Mz2U8ZkOKYx/69sd44ZBCA
         mFSZloK/NlQBG97Rn2Wp9AJk+jX26Tdu/K691gw4O3TYNRNfRUvHfhli5Ahuij0o+5w2
         edO65COPYJG82xK67v9RDFv47d5l5dz1CaNQjbo/BGN6P/p0RyEvot7ahAEZeoMm0gbL
         lwXA==
X-Gm-Message-State: AOJu0Yx2U00x6E9kJian5X4bb62+xPk2uMTjCCoJbMiT2hZi6PbY+TCl
	WZ2EwB/uadjQWvHKj1SNwKBIEZ0t2ZDd9IkXlEi/6QhHVI2I6xVy6J+BY5sRlzWhJMfIqo1lVXh
	luhK6uN7cgO1ocHrAS719ZVcHMKPu8OpGMma0
X-Gm-Gg: ASbGncsoFoBfkZKSC0X2CgaT77VXrtbCdTqHs21OEJx+PCZciJ888QTPbIj9ULPzjj5
	VojNYCQaaTe18j4CIfdOPKSlg4atVl3iyd/MXYnTNk7Eyh94c0/xZpoDdQMxCo9lfCTRqZ20FfO
	8pQjBDJSqtk6sTniPUfQxt0IJonVN86nS2S8VSVlFje935LfCVU92DLio=
X-Google-Smtp-Source: AGHT+IF6cs4wI8Wd+LqyGcq2iut4w6ZT9N21hgjIi849SCb+BYYn+c6e33U5qoZ4ZaCwyKhwuZAf6WmYMQS8F6lmEUs=
X-Received: by 2002:a05:6512:3d22:b0:553:2f8c:e631 with SMTP id
 2adb3069b0e04-557a132c26bmr605013e87.9.1751632941998; Fri, 04 Jul 2025
 05:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
In-Reply-To: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Fri, 4 Jul 2025 15:42:11 +0300
X-Gm-Features: Ac12FXzTif1ittDaPfTKqiuFVeHXU61CHFnF6VNHJFqme49aG55LIQvi_ywUz9M
Message-ID: <CAPYq2E0QSmpQR2wV7TRnSTfihPHOEtx=3JHtCq7Yd2rOMwiXMw@mail.gmail.com>
Subject: Re: [help needed] parent verity error on HDD
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

extra information:

> sudo btrfs rescue chunk-recover /dev/sdc1
Scanning: 789579710464 in dev0scan chunk headers error

