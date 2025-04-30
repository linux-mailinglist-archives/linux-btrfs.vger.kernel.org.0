Return-Path: <linux-btrfs+bounces-13567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25ECAA568F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0375A9A370E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3612BEC29;
	Wed, 30 Apr 2025 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyDlCTQw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5F26659D
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047273; cv=none; b=cAewpI7ZnUaIpL+HN56W1zarZieaf/bkPRdkiDCD4ZDMcxk5upSFI+bh1xSRPYng3m25WxNxlA+y2Vhm040g/a4+TWS5oX3OW+7pJ59cZUxS6q4nkcIvAjU6i1qJQNmeEuWem7NJcWc9vEQZU3kzTd6Q4SCA2oxJ/rUv9wmUXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047273; c=relaxed/simple;
	bh=cwCs+zpkrMOPPZeQHKLa+BnlB0Xf6e58qBB1QWLZyJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ek77z7+TFG0FE0kNb8X8xQB/BzzxMA2bPWMWDLhtRzQLGn3lBYwt37dHBN2HT6N8GjHz78XgdpYVyVPd+Ifvp7g5JXKpYMDTuI2UaEOt3fGGhusIa9GeLrrrZlpvO7e+rGemDAr80dVYDBCY4tBz6JbjXx/yYVYEJovyi6p+SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyDlCTQw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746047270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xCTNXStG6Jgjf/krGcp6W4D8H/hsb7gaw/+9wel0lI0=;
	b=WyDlCTQw5R3X948Frem3SS89AvAoR3vA+TyPaUndO2ubeUmRtYIy+SPT+dUCMXNlubYKxF
	h9Qu5qX2kQg4T3dVQHhil0eWYpFvwcOYZ9wnaOfr1VSu7LNMEOAcEK/Ogq7PCWNbjwjrBa
	lilv6v6Khv5sTxwTne54EKuXHwLg2e0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-LwZPqJa1MqisBh93ut23CQ-1; Wed, 30 Apr 2025 17:07:48 -0400
X-MC-Unique: LwZPqJa1MqisBh93ut23CQ-1
X-Mimecast-MFC-AGG-ID: LwZPqJa1MqisBh93ut23CQ_1746047267
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39135d31ca4so114892f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746047267; x=1746652067;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCTNXStG6Jgjf/krGcp6W4D8H/hsb7gaw/+9wel0lI0=;
        b=wj+8em7BPPWfgCaO5gnCe+xH73iwW5xDP3vPQ2C7AahmSI5sUl2QwUdcloSLniM+GE
         zkZpyjpUwzNBICgcFGW1DURUt1fop4oZqGeC5SUZq4vbSkElyFW2O50KiKImgrrqpPrp
         sPIyZE/hS7mdaMVCJhQTDdVRcPNJCPBFuFg5546MJQJivI2QrNDbsolTg1j8aMLI/Fdq
         PvcBNyDu/5C4ixRr9tG4xYKWKkF0TDAUrUq+X3tui7CS3HmlXYU3tbv4M8JwVOBMd6jX
         nL291odN/+UkNxj4tKVgEHmv1JhUTT3+mX3l3hZUfGLEquUD0N0KK22UMWEazRpFYA5l
         vP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVGEBsLEYPokbt07rAimw3fqv25LzLGrQkEZbLx3zlhf96MKci8+00PB/t+RhvOkyly7do4K4HNsUhGJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxboBjobEB8EAeUmrA09xStdpuzeLsoMjal3UKK3jPXOisq4Zje
	5Y+ajKaToDkhqR47AGem5Op4G7CiytS9zhaJhcm6/8KbyEHsFwlGGYww+Jxh5gvrQMNqzjhsxad
	irJBft77mcRf68ErNCl1hd9AT3S9sqdXzfjSAJeuBOjGio/sFrjaP38HYqB9+
X-Gm-Gg: ASbGncvPtI5webl107L2MFn6MykUrILOGYtKAG8KD25Bx+AL/mJmuMSdQSNNQ9Kz7XC
	MWYpLLch/4IBzFguvW72Mwsb6tF4AbbNplqOF242ySlpPKVZack2V9OahkHB7mQESbriIMTlPgC
	z8yDUECG7l3HawuHDbjNDUBu8TX+UAQ5BtFqnRoVWDA94xN3Pq1jcZ4+25QmlQpOxXWzqXrQWvz
	esg/sONERnfECxEoDZOscIDiD0gRd/4L+vzsXllN0Yr0+72eE2donWnAPkckC0lJC+jUG2Txlwz
	DQVBlubiblZIfx4XqECNFSe6C4KLTijovLrEZ398Gb7mFYfDTIS7tmxQGLghym5PXIEU4jW0Jdu
	quQCNUZqRIjWH/vlvx2hhLv8iBbp/KcFro+fn5lU=
X-Received: by 2002:a5d:5f8d:0:b0:39c:1401:679e with SMTP id ffacd0b85a97d-3a092cf2c0cmr868541f8f.5.1746047267113;
        Wed, 30 Apr 2025 14:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEog72SutnheszftTSCfiKun8Y4HdqThvk1mAh/dfhpjZg2tbfsVDEmaiAQ0AdWogX66blQiA==
X-Received: by 2002:a5d:5f8d:0:b0:39c:1401:679e with SMTP id ffacd0b85a97d-3a092cf2c0cmr868527f8f.5.1746047266755;
        Wed, 30 Apr 2025 14:07:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9? (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de. [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46869sm18003938f8f.72.2025.04.30.14.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:07:46 -0700 (PDT)
Message-ID: <38af3e39-a639-4807-aed2-d15c956cf2cc@redhat.com>
Date: Wed, 30 Apr 2025 23:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] btrfs: drop usage of folio_index
To: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <20250430181052.55698-1-ryncsn@gmail.com>
 <20250430181052.55698-3-ryncsn@gmail.com>
 <20250430140608.6f53896a1f09d58e65dd1cc2@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250430140608.6f53896a1f09d58e65dd1cc2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 23:06, Andrew Morton wrote:
> On Thu,  1 May 2025 02:10:48 +0800 Kairui Song <ryncsn@gmail.com> wrote:
> 
>> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
>> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
>> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> 
> Please tell us where these extra tags came from.  Did some tool
> generate them?
> 
> I think they're quite useful - perhaps something we could encourage.
> 

I guess that's just the get_maintainers output?

-- 
Cheers,

David / dhildenb


