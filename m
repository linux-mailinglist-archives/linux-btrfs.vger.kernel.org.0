Return-Path: <linux-btrfs+bounces-8273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468989879B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 21:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0101C245DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2340175D5D;
	Thu, 26 Sep 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7HsQbnz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D315AD96
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379934; cv=none; b=cfndmMG5IU9U685pupYA5gtt9xucooHpAp0Wo8Z+Kcpq8J0tTmWfoeNuXeo+qi5MxB71VSBxu2mtD3PqXw5r8Y/bcv+76So6Fsxn8uHB/dW/aAHnX7hD0W90q8DlRo6M27iSVPgLy9mcRgdOZihxtUq34VM7untRWT8Itl8pwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379934; c=relaxed/simple;
	bh=c23sEatr5DEyJTo+Qln0lri/o8R4k50uvECpm4UoUqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AQ/LkPosyimz39kqSMsGOPL4Wf2YVOUNQm7hccMna1wR0u3lG3aZ3AAVPNptLmJRZhglPjaWEgv/Ij5mNFaA9LG5Ur1GQWpFXkbVXxmvhxNvQrWcxlFr/YuM2eyAng/WhEz09jAxzsz5G+mycU0dDUNZCft+EpoarLl5AP9RM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7HsQbnz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so1277771a91.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727379931; x=1727984731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtaCzCgYiI58yuO+EKzkIKZIAQeYA2R0j6hkbwVHj8U=;
        b=b7HsQbnzOOxYbi88SyVUTyHxDXiOXz5rpAgWtJ878IGj0p17K3lQ8CoTYlQl3KncCX
         l8aFGyVfQoGHGsMEL5aEr3Xvuedkj2yJFvrLQLO53ObaDfI8poJOgg8ksjgXn73JHHNm
         J3W//Obr7Y/QP7UTQQFkFV0laH3nE1H0hC7wg46a5pe7zRervKylIERQKPNWNjBUqihE
         NBiJOdH2xhgOi9ChVNh2tFH64S7fN6gbxhLM1U3ySfYS188AET+TX65LQ4KmATSi9K2+
         93iMaj+jH+YQXP1+5GwcCCecE2NiCovrizHLJJijRl0bPzEGF8KFJ7CBlUB0mNsMfzPJ
         a0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727379931; x=1727984731;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtaCzCgYiI58yuO+EKzkIKZIAQeYA2R0j6hkbwVHj8U=;
        b=FIwhtenqwampnp9khaRi0BfVlbNZERkDZoX1WtTHVr3hYOVADNjxm5JCfB0HeDx2Of
         E2LMwYun2UZzXUYEx+mE9teMBurEV26NenkH4Mf5AN6NpEqJW5PJoN+kir19DBdACgpL
         yafpQJ4PZiCsjSVlgUi743G5TqediaMEgMIySn0LqmmFOrUKOfh7eTY+fsi6Z/gp+7D3
         aK9X8k3coAwrd04EWp3B7+CF6/3Dj3p/E81bOLHWHXg5TWkcIQqsJDyextg3K4wBfGPW
         w75zTHgkW3btFXg/KbpjahmIkzYho9VCOOXQj8WNC4qqbTnfonmxyV+2BuYZ45uYF69j
         bbRQ==
X-Gm-Message-State: AOJu0YxjvsNqv2DX5v7l/HF9rBaXtxjWXjxVa0HutpoZNqiDqfURTgJS
	3QA5nsoGH6hz9oIH8GgjqOY4YqtWQw/DI9woDI0blIUeuXWw/jHnxxRGwA==
X-Google-Smtp-Source: AGHT+IFMHdDdPaiER67D9gMWWEx85rVxq7xACS3TFbMsyJsWRHXJlYZIMW4pYJVEtfJuy+WBMzWtNQ==
X-Received: by 2002:a17:90a:f006:b0:2d8:ea11:1c68 with SMTP id 98e67ed59e1d1-2e0b8ea0f26mr967918a91.31.1727379930855;
        Thu, 26 Sep 2024 12:45:30 -0700 (PDT)
Received: from [192.168.1.12] ([200.4.98.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e22ce6sm406314a91.48.2024.09.26.12.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 12:45:30 -0700 (PDT)
Message-ID: <f6d5ffbc-85f9-43b3-90ab-7c8de3aeab35@gmail.com>
Date: Thu, 26 Sep 2024 16:45:28 -0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
Subject: Request for beginner tasks
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi btrfs devs,

I'm Diogo, a mentee in the Linux Kernel Mentorship Program that took interest 
in the subsystem; Javi spoke with Josef for a possibility of the fs having 
easier tasks that (maybe) mentees can help with. I'm reaching out here to see 
if there are some I can be of any assistance!  

Thanks,
Diogo Jahchan Koike


