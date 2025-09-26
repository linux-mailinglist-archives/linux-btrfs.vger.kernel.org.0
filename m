Return-Path: <linux-btrfs+bounces-17221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D28BA3990
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08F56257A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5042EB86B;
	Fri, 26 Sep 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="b/EbtFYU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519410E3
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889498; cv=none; b=oPj6kAsYMjCWUP8snFRi3t1U5kMZwGkYJMS89fOPnZyOJZHPeT0/BfGt0lQpxG9S6v8gDk+Qn3UpwI0Nd9jVKbyHWCDYFK57yKbg5G2Er/QOVx6lODtuL+SbLARn5ti7Xb7acAJdVZtDIcHhApRe0NC/TZnJsn4LIDx52prL2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889498; c=relaxed/simple;
	bh=tI3GUxW04UgsqPMBZuvOrWCbuwNtTn8iHtpCnsyVlNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM869Jy8yaLqmIDTkB/c4fLzss/MqXmOTcIs4TFiZ72SMdZFm/F6T6SH8Hrua+YpvFVUUYFhSJplGXeY/WSyBUlRs0IJdWBqwaVpbZXtQTTbNhfR1aLTmjvb+rKwH2q3pAswIGtJ/mPkb0s4yyN1iKa9GEBLhdIxPVqSRil4ZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=b/EbtFYU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso11954155e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1758889495; x=1759494295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YFnk+WHY+YbL6Q69GOA1MXViyeBdLRtP0DRJcFOkB/Q=;
        b=b/EbtFYUxJsk30qAIUS76au7UBv2N54/JGaQL/HY8I0CSj0QTUfdKpzCfFlb44zYA2
         Yjh+qNKS0vuF0e7EisSGqp7+ueRg0zLujo3TZft3RoltKjzR7j3sNOUT+6g0W91plsd9
         4JM7cPB1etP9ebcldaTrHoxW4hvDn67DhUaGtq2RvBwrQI6+MQFfdcJ3CzZkuFDz4UP6
         8eeaQOmld0MhtgmSoX8Hn9aqq4n9i1pyZocOcQxA+0aNWKTUsJKfVPRvySJMzM+M0H12
         ldqJz+hw8nPOjFC30f/xEWmGHlXnJewDZuofxbQNPLsZpN/hDWKnbPYV3Y/RB5ZUg2gX
         n7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758889495; x=1759494295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFnk+WHY+YbL6Q69GOA1MXViyeBdLRtP0DRJcFOkB/Q=;
        b=vxnLtrBtpzvIEr1SOjxjd4FNlX3Sp0QChqey2NFrweJmoDy/NnigF4pgDWHPsvh2yy
         9sBVUyamI0/ikDduDU42m7bxynNWZTGSTfEPxnqlLoMMCMNHE132GLB2PHlp07FI4J22
         c2mxCRzHxYUA7LjPThJgHW05b3dK+y4B/nE6jIDVKH6oBbW2yl095SLT3Bf2X2NXtUt2
         b1IeiyjPoAaI8LmdgLKQoWCurLEe21zicgr28HZfQY9eIOodLIDMFJ7qb18tx2nxkjvu
         Io7QKNlX6zDitks9Uw/QtHvzypW7h++0MjQzs5AG8H9fhS22ooxmKk024z013uGQOzCz
         XywA==
X-Forwarded-Encrypted: i=1; AJvYcCVa6zzLffsH+m2/1zbF9dmj2+eEea5AwbThkmRg2/vOmPVUF/BcmFtBk05kYuWaMdUQtMYAlo4SSyiGfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuRDt2swjJMC7Y7ft9DwMThjIb8jBL+idJz0LHqN/VFdsn86N
	5/Q6Y6K29J7LGnqWy6idqmLvvDNV9jwB3WckHdeu0LMlz9CdfbKS3XDsW4pw/UbTCoI=
X-Gm-Gg: ASbGnctyrD1sZ6/gFD1tpDnAt/0bzZjhHKz9wbDp15NqlgQ5+9sBo3to0EBZkYWP8Zg
	7HgWLdsWhSyO7uKSuwXP86dKcjnv5WLMJ1BZa6CY1gZpgiF5YaoGegKFuCJKnA7UUA0N6SSwcJx
	T6D5uSohgSZ+BRaXpVGYheBJz6iVTh1CtM0G9BKMofTTlyV2n/fZAd5l2Ruk03Ozd+Wwm/Y+l83
	QBYcPbmq/wmD77rJZVnjGyaaMQN/skX6GeB0t8r3ra4clIEGwfX7u3ipraRSAQ6+4g3YZNEly04
	MklCCgEXYeXFw1hlSXeLh4jjDfoG+F6sRd7SkQO/BAHHYTDw9nSHes/VwOVBrqCj9CS0KiecUoQ
	EbacepXK9M48LU1ok4fOv6keL7ePc3QGxxXvegoGYdHFaNnkI21OLlSAgaglg2b0v
X-Google-Smtp-Source: AGHT+IFelFATU5sIRTwCwlfccQfy85fqWmsGJk2vYCZ4rkvmPgsguITsESTixnDIScg+We8FsFNF/g==
X-Received: by 2002:a05:600c:4683:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46e329a34a4mr62019375e9.1.1758889494772;
        Fri, 26 Sep 2025 05:24:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9ee5:820b:e03b:ab3d? ([2001:67c:2fbc:1:9ee5:820b:e03b:ab3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a7c8531sm116095465e9.0.2025.09.26.05.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 05:24:54 -0700 (PDT)
Message-ID: <44f303f3-9eea-48a3-9e18-6e902037313e@mandelbit.com>
Date: Fri, 26 Sep 2025 14:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] btrfs: assume fs_info is non-NULL and drop ternary check
To: dsterba@suse.cz
Cc: clm@fb.com, dsterba@suse.com, naohiro.aota@wdc.com,
 johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org
References: <20250926121344.25706-1-antonio@mandelbit.com>
 <20250926122152.GT5333@twin.jikos.cz>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <20250926122152.GT5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2025 14:21, David Sterba wrote:
> Thanks, the fix for that was sent yesterday and is now in for-next.
> 
> https://lore.kernel.org/linux-btrfs/686d2506851c2df8cb9ceab5241b15bb01737ebb.1758793968.git.wqu@suse.com/

Ah perfect!
Thanks for the quick feedback.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


