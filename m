Return-Path: <linux-btrfs+bounces-3733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D789084E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE302291A7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57EC131BB6;
	Thu, 28 Mar 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMMwqo9A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A951311BD
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650573; cv=none; b=WDkA4aMHATNsc0kiLV4E55w6bN/6rOPckt9dzbTgTFfnTibuvLYOzGDRg50c3RwX1h3o/fX/Yj1l+65ikslgzNT5JXAvpullJLEaXPN6OJ2q3ty7Wf4+BnUq7Bd+mpYbhCi3YQJwJSuDUGVuIdDaksja79qe+sxsVkXO40iNtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650573; c=relaxed/simple;
	bh=GthFzf4c2CnxlFa+euL1T99nUeV+RK/jqmB1OAtv88w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8yM1A94sIlYpX7wpfCRrAo8Jx15AksV/E9seJpaaTiEPyk8MiRodoux0bmMpUFmTADHdUbNREjDkpiUQ1qsof/qX5RP9/YWv73Ah8A8nDP3bOsZo6HMKv02xBgUuGdMG0P0yKnfgMYxUJOun6Lv7KNak3hsU05wlrv+EVrZruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMMwqo9A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711650571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=295Tz66lZ5wzxYSBeQjEsXjOn4yj5P6f+q+3yKW440Y=;
	b=XMMwqo9AhmjGZZFHJOiB5GPeicsDVn0Aw+XibKdbOO78fIT7/+EZHqXazeGn+o2sydFA8e
	7nrHYP75bELZXS/lHjnJnyct/T2+OiG3RBbXvzvOq+EYmla9ZjJ8psvQIF6v0KBuENrsmd
	yzJm150Tdw9Jz1WuG2IaTEw/D7j5CgU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-dqFE2ZSEOCep-yckqf-QKQ-1; Thu, 28 Mar 2024 14:29:29 -0400
X-MC-Unique: dqFE2ZSEOCep-yckqf-QKQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-696a35b5d38so13412656d6.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711650569; x=1712255369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=295Tz66lZ5wzxYSBeQjEsXjOn4yj5P6f+q+3yKW440Y=;
        b=J1CEDTzC0pWiVy3n7p5gRAU3WKU8WAlRUQGgypKxwSJh0pXGkowOYO2mlG0pe7/aa+
         1LLeZRbmBAinrMJFrJr52GwvBfPfTiL90wzckmD1qwaV+oY7E4MFSkSYCMTaYeWgog0u
         o2gPhH14BC6gP/g1Su1geDneIo1bnnKWPCZLC+7yhP4GB/4Mktfyvty5ZUHc9O9A21qY
         DC1AA2jc4f/cB4eBAxYD9LQ4AXh7RKG/VlzDkwgPUhDMxEchvrgg1t3u6kC9VpH+rqay
         stVdYalj+DdTYwklqh2c8NDYVQpw6oMXRyTCfankt8ipAONO5R6C5I+/eeVSY6o46Dbp
         Oapg==
X-Forwarded-Encrypted: i=1; AJvYcCUsL/nDQ5yEpagmq6jeZnow2pYN3yncos56bXWGySHF5RUN0LDn/V2YvhAg9zN6lefWOPZkqRvSfAbGr+/0pmUFOk9YIYhTNpa/k9U=
X-Gm-Message-State: AOJu0YzAm1omCQ8vmmrBIymTSZD/DKx4Jj6MYeqcGVChHO7thlsvht8y
	dQBfCbMG/5DCBSh4V/puZ6SExDaTkk8umyTvC+Ivhr698VBXDulLe1oNA4QEUL+4l8qqDZXdAKL
	teU8ehBMYeaziMkzWuKNK9CWxr1Zyjb0WPnJWralnyA3Z8aPB0LpvFKIqVq0n
X-Received: by 2002:a0c:d64d:0:b0:696:3a75:2964 with SMTP id e13-20020a0cd64d000000b006963a752964mr57854qvj.18.1711650569463;
        Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5oHWCZzfUomrQkq5TZ0+KX+12VkRPiBcXfHIdH4JazXT/nPJvHY3WgEr/AA6t75OSJCiAw==
X-Received: by 2002:a0c:d64d:0:b0:696:3a75:2964 with SMTP id e13-20020a0cd64d000000b006963a752964mr57839qvj.18.1711650569212;
        Thu, 28 Mar 2024 11:29:29 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id c13-20020a056214224d00b006913aa64629sm854751qvc.22.2024.03.28.11.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:29:28 -0700 (PDT)
Message-ID: <2ae69d9f-a42c-00d7-f9eb-e93c071153ce@redhat.com>
Date: Thu, 28 Mar 2024 14:29:27 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: add a bio_list_merge_init helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 dm-devel@lists.linux.dev, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240328084147.2954434-1-hch@lst.de>
 <20240328084147.2954434-2-hch@lst.de>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240328084147.2954434-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/28/24 04:41, Christoph Hellwig wrote:
> This is a simple combination of bio_list_merge + bio_list_init
> similar to list_splice_init.  While it only saves a single
> line in a callers, it makes the move all bios from one list to
> another and reinitialize the original pattern a lot more obvious
> in the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/bio.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 875d792bffff82..9b8a369f44bc6b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -615,6 +615,13 @@ static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
>   	bl->tail = bl2->tail;
>   }
>   
> +static inline void bio_list_merge_init(struct bio_list *bl,
> +		struct bio_list *bl2)

Nit: The indentation in this line looks off to me.
Otherwise, for the series:

Reviewed-by: Matthew Sakai <msakai@redhat.com>

> +{
> +	bio_list_merge(bl, bl2);
> +	bio_list_init(bl2);
> +}
> +
>   static inline void bio_list_merge_head(struct bio_list *bl,
>   				       struct bio_list *bl2)
>   {


