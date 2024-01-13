Return-Path: <linux-btrfs+bounces-1424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5682CA79
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51911C2233F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274618C2F;
	Sat, 13 Jan 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R75erNed"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AC168C2
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e6c0c0c6bso1569971e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705133155; x=1705737955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95K4ldKBwILzAWZyxH+yZh9alql3/vSCChYVb0/EMik=;
        b=R75erNedv1HHkUi2NL2+5M+mbm1nCuuQCQLm4ZpeT0LXRJevLLTv8ZkqQ63A6RZ2wD
         /msOnwHH0Nhe8M7EOA/t25ZC/SgDdlH+5Pvh4kR5RQQCags6wlii/EPbSGNYX4+oswpy
         /cKKNW6Tt0Uxk/FbXcSYHN7I9X31MhTd3bPWGwkzbqSpeHU4/ou2y03ojCd2QgH5Y30j
         1BB47Q5CudUCPl5lSDc3nZ8SbjZvQMindXga7qDT1NJOFyAltLdlUrcqDvcciIZzHXOx
         KoQAI673L1/yfOv3a2ZOJBj+0GfRBLqt0IRw4OLlJ/KG2L1Sb0q5eSFsDDwEsSCxW7H9
         q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705133155; x=1705737955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95K4ldKBwILzAWZyxH+yZh9alql3/vSCChYVb0/EMik=;
        b=Qz7DD/tGWtAGbiShc7lVuHArgAd4Ajbqfc4ENefYpcKSO0go6CV09YR1OsZgU7ntDt
         iJsAYMDvSimSCIb95MAOMCOG0S1JFUAyDHpwaxEysMqsq13CrarMKNNYv/GiHKw9mpao
         aTCkUvgGIbHJiATildj1Orbw8SLwb0UdqcEYFwkKIRApvgS/v7uhHSiMixGRdODgHi/a
         4aXt4NfJxHEZ/QUO7jK3OZnZ8hMKBm5Fw0qivQC1uTBB07EFSnuzeeNmI1Sv7w25Pvhz
         Vbdd305SkEkZQzq7haV8up7I/0D0D1DwudQXdWeMM8QVtwYrjq+SmTPuugXV4QOCVme5
         Y7kA==
X-Gm-Message-State: AOJu0Yyl8EFqv9Puj3L0OiZy2NeXqMcMntphMSTiZ/IqHkLZ/OE914E6
	tomilw16p0RpYvKPAOSy2Cwi754lWfQ=
X-Google-Smtp-Source: AGHT+IHDpl5ftTq7LyMv/MEYAxqXo0a0dVPHnPQhv0Zb2edHUN8KpBVHurIekOXk5zAnlq06+BKtlA==
X-Received: by 2002:a2e:5c86:0:b0:2cd:3731:9c24 with SMTP id q128-20020a2e5c86000000b002cd37319c24mr2237290ljb.1.1705133155287;
        Sat, 13 Jan 2024 00:05:55 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:225c:1a3d:4c49:4f1b:95bc? ([2a00:1370:8180:225c:1a3d:4c49:4f1b:95bc])
        by smtp.gmail.com with ESMTPSA id x21-20020a05651c069500b002cd37ceea4bsm735317ljb.46.2024.01.13.00.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 00:05:54 -0800 (PST)
Message-ID: <15751051-dc90-498f-82bb-773d639a3b24@gmail.com>
Date: Sat, 13 Jan 2024 11:05:52 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US, ru-RU
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
 <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
 <20240112155806.GS31555@twin.jikos.cz>
 <7bef3393-a1b4-4a18-98cb-508cfb1ca6ee@gmx.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <7bef3393-a1b4-4a18-98cb-508cfb1ca6ee@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.2024 06:17, Qu Wenruo wrote:
> 
> What we really want to do is, just add extra filters to allow end users
> to re-dirty the last file extent.
> 

It is possible to punch holes in the middle of the file, so partial 
extents can happen anywhere.


