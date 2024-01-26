Return-Path: <linux-btrfs+bounces-1833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA683E44B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 22:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2BB24B4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE82563C;
	Fri, 26 Jan 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SHzbf5CV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0425562
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305890; cv=none; b=Qmzfq/3HwfW3/U8Y2vsvKlmxdFIebBJ9amJ6JeegoiXnDDWy4/RGigys9K84OMKx4pK7KF3FiFr7Aklt3mSLYNogQAPddhNuO1LoEh0FWJToXPPlYTYhFOZLOKdCnQ8QUX1CaDA0TIDXGP6v7sWu9i5sU42VWjd7Hwj32t82al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305890; c=relaxed/simple;
	bh=04D3xXJMPnckdiNNY8fguQ6tU0HevW+YvL65Y5Kj82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiKsdUqdTOLhjM7B7lXeI4+j0ENWL2+PKlTRXz47L7DKPqZTJhbM1U7clv0a3QbTR/FcJw76AWD5hZN4+y5SYNa4G1PlN6K+OO5mzZVE08FVqeUbkjD6ao1K1qroq0efVQK06NRHZZsKya47+PKqm7vA3xR6ncRCDcqLJXpNhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SHzbf5CV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a34c5ca2537so79062966b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 13:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706305886; x=1706910686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MqrpniylWfWC1VCZp5L8n3yVakZrt949RVza9zF/u5c=;
        b=SHzbf5CVAn3i7Gv1lciH4U7BfG6+kPT476PSwoL0ZBTwOwgklvya1J4W1ONtyXgagZ
         ICRp8ndJyeLPKj07w2Oet0qmlItIYguMWibetWkzUge1TKaQ2pjmJskuxIjGw/3gqkmY
         KjQdL45EYDCw/SmjQY7AZxSIYWSHpHqkYpJAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305886; x=1706910686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqrpniylWfWC1VCZp5L8n3yVakZrt949RVza9zF/u5c=;
        b=DD03GhDyKiIPWN5xL/q6fkc7AXqglOluO8hIFnFS/dCMGs8K7/DdSfyW2lBJqvzoXn
         PxDKjrLgiu3EyFe+bbLuRdLjXc8UlKU+W8Uv2sVWNy1K2v3tQhrP0CreW9BFvoO0HPF4
         BItl1c1KjiZGF10NAj9TL4XjfQJbcSwmWKaBKKEn0FkmO51HQ5RlS9ak0PPpWVB+fio0
         fx1JjrS+9fS8YkuqpRpHdBXecjs1LCsdpu2MMw/uGPJtQKxmg0v5Li4lMqig9n7u2cZ/
         4c4JqHqIngNESbflk8RDeriCRQLr1HbOZFsjASNaQH6ShgIWalfx2U/9bkLAH9geUwt+
         J3IQ==
X-Gm-Message-State: AOJu0YwygbclNDLLYupccCoGl5HyNtCZN9EsRg/Gouq+cqw9Fufex/df
	W1U3WnBSqknhDVDvl9NA8dLxZU6JCrqWOuGtGL+itFsc/Si0cpCP/8hf/QjsP5ofUdrQG5NjDhn
	nXnGJgA==
X-Google-Smtp-Source: AGHT+IGWwaJk033NDFkNutvw0AVZSnE/eHAlFEAYCCkQo8Msuz0GdyonBBoGu4hcbiWT7Vh2V9RpQA==
X-Received: by 2002:a17:906:715a:b0:a2e:4ba2:d9e5 with SMTP id z26-20020a170906715a00b00a2e4ba2d9e5mr219276ejj.65.1706305886611;
        Fri, 26 Jan 2024 13:51:26 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id jg8-20020a170907970800b00a3165a8b70esm1043718ejc.68.2024.01.26.13.51.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:51:26 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e80046264so18248335e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 13:51:25 -0800 (PST)
X-Received: by 2002:a05:600c:548b:b0:40e:7d24:cc15 with SMTP id
 iv11-20020a05600c548b00b0040e7d24cc15mr344687wmb.34.1706305885604; Fri, 26
 Jan 2024 13:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz> <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
In-Reply-To: <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:51:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com>
Message-ID: <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:39, Qu Wenruo <wqu@suse.com> wrote:
>
> Oh, I forgot the most obvious problem.
>
> This means the extent buffer is full of garbage.

Allocation lifetime problems?

> What's the page size of the system? 4K or 16K or 64K?

This is a bog-standard x86-64 system. With 32 cores (and 64 threads),
but there's nothing remotely odd about it, except for the fact that
it's running a very recent kernel...

             Linus

