Return-Path: <linux-btrfs+bounces-18020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86370BEEFCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 03:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9237C4E5635
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 01:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662D1C8611;
	Mon, 20 Oct 2025 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LEY9PXGF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72A3FFD
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923074; cv=none; b=FqonQPAyATq7RloH1J1PliHIBWHFcpMh95Ho4IkNG0tkGu1fEOrzZ+ZpAaooqNpxyN/NS7Atmbs58UiHHBVNY1rELGlthdHwdi+z38ZUECBCqL1IwT2jE+hmj3LMSCnjwDAZbrQkRUL2u1Wi73Ex9Uuc+9ZxQafw/laWq5d1HMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923074; c=relaxed/simple;
	bh=mJD/bzm7fcLRKMP580ak2gEd90LFfkcxfajSZFUvHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwo3Cvltf8cUGv9ulcbVbJpjT0K/yeKex/hUoR42K4JF2w1BHo+f32iZIfYGn3NKdZBRO0TzdbRFbmc8B+xOFi+a+DP4Hkiiz1vGBZkmuH4iIbZez8JRi73W+z5LpZprXVzvJZHB1iHpb5taV0smPozRVb9PpRjGU0mi80kVKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LEY9PXGF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b456d2dc440so612539366b.0
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760923070; x=1761527870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsNoL0sS86ArEXrUpcTMrn2Yzq8PGH8khZpMEn48fww=;
        b=LEY9PXGFT0Ejr9gXfl7GXunZshFS9jpB7tVygzNh5qcS+2kQ3dfwok1gTV8KuBrRxv
         X0ZWgpaCufO0WbgptVNt5jcP1XAHGo/+Lxhrmjyj6IcN9OVBglULRRyPVBbVWRA3mET5
         Yj33zvrpCz25gj0vEC5WymmWgSFwVCvZxDeOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760923070; x=1761527870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsNoL0sS86ArEXrUpcTMrn2Yzq8PGH8khZpMEn48fww=;
        b=HW+cMwf8w3cHiyATzTBOYyzwuonZ5x0f31P1Gni0ompywkRPHIeuT72hGWF2X5dgMf
         KprxpnfjooAJO2SA6lNE4FP+XjJcU5HkacyN2Ic+a0wbGJB/lBxOFxpJ0IDF9RSpLa/J
         pZWLzT/A0N2Inm/YpYzWfsuADIY/DJE811aTM6F6OnemHpYpxebLNj+M0m521lMj9mp4
         9UlMpJ2P7rM0BJOjwfcVVxrZyq3alxo14WmV4SYATk8z/UC1nBOf0oVPV/P/9mR968Gw
         rKakNLuCJnx9pT+D5pf3+YjIs5gvjN+VOSEY4NFFTGwwnyHLLw5u19xt57yHfPlz3CBR
         lbdA==
X-Forwarded-Encrypted: i=1; AJvYcCVZNw48Bpqex2yggLn+kvgxFNBSzI7Nub2rXM4B/cfXSgSiOAc59BCHu62usGDpfNmpsbR0RgpYBe1ikg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9IRQdhkHKC0fRxu/Qa/eMwa7S7o4W7OPy+PxHSGotcuVajs1
	zbMfodUzeHB5HxwPcdytAEjd+zJdnGkZvSqHWBrdO5E3wSU6iNibPzXh2ZFviUPH2rtV+sVvU60
	galhqaKU=
X-Gm-Gg: ASbGnctKj5fVx390jwgnAC668Hlb8IZppAsF2wrQE1dvWy0cqL4vAm79i4HxKcJkpaq
	wfAuPHii2mpgNZ4Ng4R/wEQevz0TOBMNCe+fXnCVawmKvWGmx0GSOodEKuDfp0Zz6E9YhYP/jav
	xxi6TEWGq4UT7Hvf1vZdJi24OYICavQ5etDXQ2TB1xuaIQ3xnBgZT0ZFoO6xSE/p4BF2AmTQ5i7
	XfRYZ9Xof1lojQrdmQprkbY5JPGIWBpBUFSsllR2BMzzY2PFnn7ShjHbc4An1MSknGEHgjf6XME
	pwfgbIXAZ6oc5pdvCmALRWoFuJ1awVSh65XsQE2k6JBVqRIt/nhr9ouveVXjZ0sEokTOt3TeTsV
	24lLeS6097T66gFrnXn6FN5ffR75cBx91IVYRHRuY4g2/K/INPlQMSeUd3GA8ugaVIzYOmKHawf
	lQfHY4gk07NXJU5DDHtr7tGai7zAJYsK2O6NvvgyIwfKY/iSa5axeCb3aa+vyu
X-Google-Smtp-Source: AGHT+IFHFvVbpqq4FwqPP1/KG0Ah+KhFXpS9uO70cy3I2GUqpwSj9NookqcSzdLVcFkD4qtHoKuD9A==
X-Received: by 2002:a17:906:eecd:b0:b44:fb0c:5c43 with SMTP id a640c23a62f3a-b6475512222mr1292367566b.57.1760923070207;
        Sun, 19 Oct 2025 18:17:50 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm642788666b.21.2025.10.19.18.17.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 18:17:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b50645ecfbbso757883266b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 18:17:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1RZG+HTUcE4Esl5p9+Se2PZiWEv09TJDaabyAlVQMRqTI+ZGvkROc6L8SqM85auEcw1mkQwZu7/HpWg==@vger.kernel.org
X-Received: by 2002:a17:907:268a:b0:b47:de64:df1e with SMTP id
 a640c23a62f3a-b6472b5fb81mr1333514866b.4.1760923069016; Sun, 19 Oct 2025
 18:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760633129.git.dsterba@suse.com> <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
 <87plaieexu.fsf@prevas.dk>
In-Reply-To: <87plaieexu.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Oct 2025 15:17:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
X-Gm-Features: AS18NWD9HyRh8jNCcR5HaCwAUJwoqAFhf2DlmK3heg9hwTylB5TMwhLlL0ysbmY
Message-ID: <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 11:53, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> I think this has come up before [*]. Doesn't -fms-extensions allow one
> to do

I clearly have some goldfish genes, because I had completely forgotten
about that whole similar conversation.

Yeah, so now we've had at least two use-cases for that thing, although
from that older discussion we'd apparently need both

  -fms-extensions

and

  -Wno-microsoft-anon-tag

to also make clang happy about it.

But yeah, if all versions of gcc and clang that we support do accept
this thing, maybe we should just bite the bullet and do it, because
it's just universally useful to be able to define a common helper
structure and then use it in other structures without naming it. Kind
of standard "inheritance" syntax, and very useful for that "I have two
or more parts to this object".

Want to take that up and see if the btrfs people like the end result?


            Linus

