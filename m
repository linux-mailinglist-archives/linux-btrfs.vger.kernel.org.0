Return-Path: <linux-btrfs+bounces-10996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E04A152F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0F1889996
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A556195FE5;
	Fri, 17 Jan 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUP41Z0r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62814F9D6
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128498; cv=none; b=UTClUTNmVUpGU08kFebzaS0tUa5QkZi9Sh8FW6uzEDwPJHBHtm+y6rrDDsCn/q38VfvdQ1/ZUXG0tkp2R3+53onH+bMVDJSfafJMnoQW1gpGBWrQiDi80vdL7quSbDmWbymX3iTO/Qpa4cUfIkQtYkh4qpQwHV69erCSj00RqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128498; c=relaxed/simple;
	bh=7AgyMQ4BjvqJI6/QhVvB0NuBxpU4KoJprCqCq1jAQ5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dvVr5eRqGNNXAp2BSVhSLAHGIPDa8HPFWDiI4fsUwdODcg7bnssldpguOeapnjjfwytLngd2I4TOS4XcohqiF/nYs7lqUv31VWHp8pRbcxd+BzuFQoM4PwX0pHjYnV8RFN7eej/8Jqxzd+fy3QgL1irGEwpiX3SYX0i7pvwkra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUP41Z0r; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53537d8feeso3419043276.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737128495; x=1737733295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AgyMQ4BjvqJI6/QhVvB0NuBxpU4KoJprCqCq1jAQ5o=;
        b=gUP41Z0rUIB0cCPbYSH6GQKfdvDpXU6I+Lq5tTbLnfGwPTF2nk7psTkk7da8PxGZ//
         f3PifpBYVfOecBffaL9IZ0N8rkXuzP/gbBTtiSZb44LnbBN06IRoR7jDzAyRlsUsnQ43
         SIVZk5d1oevr555/34FvrZ0j/ZueZP7/qSGRF9H88FDEgpxiZaUlM+3QrUIsMa9ay8pB
         xHBt1lZjw+oulpCBvt/8InwtJlx4OaN4XAHZVhWIPzJtZYPmjYOsFMnBsGyeNzMGubRe
         A1mhBD1yOMDnmAC+THCHKtflnpnCiwkUmbPqhLKHsAMjcDwuy8RXWnm4GQ853ajSLpb4
         nDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737128495; x=1737733295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AgyMQ4BjvqJI6/QhVvB0NuBxpU4KoJprCqCq1jAQ5o=;
        b=m2r37dxq5VtvnL66XkItVWum4kG8PLvgN5W7wft4ZThciVRB2w75DO8T4tGZanynEu
         BnnsNOncmvDt/DqaFMpVttlgccvBpmckTVlan+sbFd3QZP56w/RspbNbTPVep5+houBB
         ueNtar/0iAG7DIlpf9CNa8SELYPTS/FSDB3ZljN/Es5acuSNn7vxYIqx5hO5HIEW8EwN
         L62/BILTBPY73FWVcfirRi9+cWdCMZsJItOcZ3l1al15CgGrdigoAuaLovNeHaPc42LM
         Voh7ufYU9SgN22VlxC6EmXeaLg4PRAogy626TsRmLoHvjNiuX3hUSRxZE/+xicERE4q9
         yPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN8ipVfiXIsQ1JP+kxN+XG5DKTIe+AA3rGLB27BYh6ncpk3ERpHnULh8svbtKptuPDxCju8Zr+ERNkgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyakI//GDNEhJeybKvZxHOhymcZKlwYdJ9v49mZqqBt/5/9Cb30
	bw5X3SSCH//vrZ0RylpEFpOxCNu7djHNMo78uAC0CZE0miyhELSr
X-Gm-Gg: ASbGncs+e//CE7q2FYxprabympv+dHLv4oM+a95UcwQ77hVGnn2tXDa+oXiJpZwDcnt
	vdUI2Vh4Y8BzvCuStcoCgh5jo9fQp2IFRLb1GjErofEOMDhJ1HlXVEEuQzF3t7qIHM3qqKO7wxc
	zahx0WqDpDMUhMOyMBiYorGeWeZMer6rvJEavXNAZVjycjMqSmHruX7eLd1NKV52U4qClb13oyJ
	NAVw8ceZNYjkpNERNTrjgmR1BabvBTsnE4Y+dqQqL1uwn6O1nge//7ERO6wtC2o9KEfaRDjW+1q
	6MjevubsiQ==
X-Google-Smtp-Source: AGHT+IGSkXMxOQu2DYf/Uo4XK4KOSkbG+gA/dQA9kuGGxscvgdZnEqxkftud/BGrP0FLkPfZ5b6W1w==
X-Received: by 2002:a05:6902:1a42:b0:e39:b02b:192d with SMTP id 3f1490d57ef6-e57b1076740mr2402421276.23.1737128495145;
        Fri, 17 Jan 2025 07:41:35 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e57ab43a8a1sm463017276.41.2025.01.17.07.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 07:41:34 -0800 (PST)
Message-ID: <b31f9d73-25d9-4ab7-bd19-44fdc30169e7@gmail.com>
Date: Fri, 17 Jan 2025 09:41:34 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of --convert-to-block-group-tree makes fs unmountable
To: Jeff Bahr <jeffrey.bahr@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAL4+Tgzk=MS1P93u6yq_m0aqbMyjXrwPiP-8nA5zp=fTu7Vr6w@mail.gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <CAL4+Tgzk=MS1P93u6yq_m0aqbMyjXrwPiP-8nA5zp=fTu7Vr6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/24 2:37 PM, Jeff Bahr wrote:
> Looking for suggestions on recovering a broken btrfs fs after
> attempting to use --convert-to-block-group-tree.

I had a similar experience ~2 years ago. It may be related.

https://lore.kernel.org/linux-btrfs/eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com/

There's more detail in that thread than remains in my memory, so I doubt
I can provide any assistance, alas.

Good luck,
Russell

