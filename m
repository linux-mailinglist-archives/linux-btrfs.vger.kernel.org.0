Return-Path: <linux-btrfs+bounces-535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6C801B5C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 09:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E7D1F21191
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FDC8E3;
	Sat,  2 Dec 2023 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtG8rR2M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42647D50
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Dec 2023 00:04:47 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7fa93afe9so924780a34.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Dec 2023 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701504286; x=1702109086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RY/E2WVYBrEWN86KLGxhI9WM2xgSYAXePiDzFxz2iHg=;
        b=PtG8rR2MCTnzKlWXJ32Lo9BKj5ZQywXUDOMsiJHcs+BKvG0wUikKJR9EeDHERIwP4S
         +PgqCNxeV0pseN2bVLG0aTAxqRg5rscusZAeVXwU4t8vJWqTXi0z6FqvHeFr3ZJi0BBg
         PYVI11T+Mbrg3HRPoo0WHnbpdp3xWo0EC4kwXxrf92rypm5o7Zp6PFdzjz6iSd/Jl3zV
         qNpMXTChkgsJ5jaNN1ZLqQ3gEBM70Ko0jsk/R3EtIX9b8ydHS61MbAbrvFoFo7Ewx5oS
         NR+CLQgu3vl+Ii6H4S7FhwYcCMcTKCkIW6KnhHKKAATeTTKsgBe7FqYhcqGMgOFqUU3V
         Fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701504286; x=1702109086;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY/E2WVYBrEWN86KLGxhI9WM2xgSYAXePiDzFxz2iHg=;
        b=GKaskQemogLxBHVqk57dOp4eghim0F+cHMiJtL+6BqSU/RD/22NEjKRgSwGgcpZX1y
         FUbL2rn4aXgcAVuEOQqm/n27L8odv9GKPihGesauthSyzdiTX3alJBEdmZaFaUTtP5W8
         +fgl2MxshTSZGbhPSQbNMMTUa2FXBrtrqS83MvFgOKEAyo6y6IO43Sgb9xxXF2gSbrro
         ZXU7gfBN1QULTPhZrGSvc+ocLAxgyJesYkibw0kwwuFOSAWWZbo0uh4eTSHEYZzLuQ21
         ebmqDxumAneqqtpd8XW2IgGV7lh2bRoefzhVnf0/ZdvD6PPEwNemb/Oyoyz84t4PGW5D
         Y4sg==
X-Gm-Message-State: AOJu0YwTDYuNjNpQyKetLRVSBJO5herix/bP5ia3dDUzM8/SKMmsc/Y9
	RlrxyVsIR+rrkWI70zqs9oWAtSc22dI=
X-Google-Smtp-Source: AGHT+IFcYWhwNyhh3uoxsTCSvMq4pD5AWUKmCS7zkHA64fOU3N2JXQ5+FmcDv4D1nvbZyXO+F9tfFw==
X-Received: by 2002:a9d:6186:0:b0:6d8:11ba:ed47 with SMTP id g6-20020a9d6186000000b006d811baed47mr778864otk.14.1701504286437;
        Sat, 02 Dec 2023 00:04:46 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm787103oor.2.2023.12.02.00.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 00:04:46 -0800 (PST)
Message-ID: <d1db5758-35d1-4737-b69d-06473cc46e86@gmail.com>
Date: Sat, 2 Dec 2023 02:04:45 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
 <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
 <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/2/23 00:43, Qu Wenruo wrote:
> 
> 
> On 2023/12/2 16:43, Russell Haley wrote:
>> To be clear, there is no reason to be suspicious of the other disk that
>> was converted to block group tree and has passed a scrub after
>> rebooting? It should be safe to mount that one read-write again?
> 
> Scrub is only checksum verification, no comprehensive extent tree
> cross-check like `btrfs check`.
> 
> If we really screwed up the block group tree conversion, btrfs check
> should be able to expose it.
> 
> Thus that's why I'm going to add "btrfs check" runs before and after
> block group tree conversion.
> 
> Just remember, scrub is never as good as "btrfs check".

Thanks. `btrfs check` passed too, so I've removed `ro` from fstab.

