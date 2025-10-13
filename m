Return-Path: <linux-btrfs+bounces-17710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A96BD3122
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4EF3B197C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF42E6CCC;
	Mon, 13 Oct 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApjK8+TF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EA255F2C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359834; cv=none; b=Pq3fNQu0mx0RL1Jn+5T6YH6TyU1WmU8vOIST2ROD5VdbtYXlrzTmXzi1jPuBCKIeWU19803RvtqBtSHlR1KYTOXvbMFKV4+NcBIhIHrs1+v+Ak+FrpPfg8T/MXtRFB0eXC0dHMawgyINIqooPCF9oewJagK1v5ktdn02czqM56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359834; c=relaxed/simple;
	bh=/vbJN+GTFa73FryYW5KO21cm50erek3RkwQo2KmYHuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdvIJh4xVtyjyxfrhVw8U1/YH3k7WKEr6gDqm56HKcN1P4WS2GCrZ82jaH3w6VHC+LEkhnHl2NAhPhMmUlyCbK200OXhCRqFcnFHP+J4gP6rkLKOzaLARp4QPryRnSt64O0I8r8jlNHNLlarOGHNQaAtYAsUKDgxLo8jPoXAiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApjK8+TF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760359830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fmLpGViBdbcMLzx1bb+Kxqb3+3UtyUNscErHdno+a+c=;
	b=ApjK8+TFmj8PXajDObDIt9yfNi3EoONxgd2NJAwnKwimYfnsS5Oir/jBFUCDgIB+kXO8Bd
	hsEiNDymu2Eb70hbPA/2uDUyE3j1Hld+btEopoW/4UU4jt88msJmn0VS3QcDn/KIAjykAZ
	pVUXyuQrVIsA8qlwe/Q2TGF5t5bpQPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-xYvodNfVPLeTUAVeNdkYUA-1; Mon, 13 Oct 2025 08:50:29 -0400
X-MC-Unique: xYvodNfVPLeTUAVeNdkYUA-1
X-Mimecast-MFC-AGG-ID: xYvodNfVPLeTUAVeNdkYUA_1760359828
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso27944765e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 05:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359828; x=1760964628;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmLpGViBdbcMLzx1bb+Kxqb3+3UtyUNscErHdno+a+c=;
        b=O9z/dcJe7y+5Bh7VqsAUr3EHw8HC8RIHnG7jFJqOOcO4rDUEG4JwAcikG+smLTt/MJ
         t9Cg3dTADDr3/wgMd4xUrgsqg2OAP/N3KfxwQxgU2YGFJS3X4+06r4wGkvhPsOWrCqar
         WT3MFSQHz5YUovDsTr+P+oG95WqfvDXVfbY1sSPJkZ9BktqGztgnW2yD80Hk0Kx8TVjK
         BOJ3T+JovX8KpUrOOhuykgJxRQWjpEfSu1n9+EUzMHEqbR4VT7xHqiYPTqzxhx4gv4JN
         YtQfmFLJyIn+G0ix6mufrMe2WgUTakNjqkhu8cMkiA389OyQhQs7KPDtLYM/2X7pulsC
         +M7w==
X-Forwarded-Encrypted: i=1; AJvYcCWqthq2FCncGonYumoRlGX6DELhGMX84y+Nd1GlLvfjdm5ujEbXTpOfXtfXe59IFbxH98bqrSv2gnxB/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTHO/8xWehSLP8BlCDROlPSAP/LE005ey6G8uG2e0SPMjiwlr
	3GXjZlPCrWoZnka3r9BsP8rXfri4hGEYXhSBBBpjoCZE7ntCZJgoMAaJu6sxdym4dSoMf9QnWe5
	8g2ha0FD5S4mljR0M0xJo3+4eSJaBeHrHjrFSIyREZ9jfn7lYRyVgSQ/Z2VyoPozf
X-Gm-Gg: ASbGncvx6uj5iQTo9h0gGBWpRfOznC1N2i2iymjnkawlNVmeuCOezIfXq4IVmsj5IGb
	USeWowaWViIKmzM6t9q9NWV7hVPfCnXyqV+I066z5NmArWKIZLYUAAEcHp5JAdrID5v8lsewEp9
	Xv47lTIITnSn+tPGFSAmcGoo9S+e2nCW3yDZKDG41DQyj3qhUJ5lst5elm4w1vW/B9onLGLSILk
	gpoBJjYXaftZvn3GW3SGXJXOBGnoNwesklu8W60zXXYOhNFiIRcXM21IpeR81XeVpUgaB7ZDVgG
	6/laRsXpUd24jywoN9vHjMw6f4QUOlB5909mORb7Tk60w24u7tSWNYcWymVYWo8rDdz1rFllw1H
	/w8g=
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr126817175e9.0.1760359827996;
        Mon, 13 Oct 2025 05:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMMoKs4VS2gHV3gKsNnQk9DNjQ77BVoRLFBciblN4uYmPY7ldMdNRqp+3ZL0M1o/a3ErG8+Q==
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr126817005e9.0.1760359827614;
        Mon, 13 Oct 2025 05:50:27 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49c3e49sm183435545e9.16.2025.10.13.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:50:27 -0700 (PDT)
Message-ID: <3fdede63-0bb7-4618-af45-6605ed25b6c0@redhat.com>
Date: Mon, 13 Oct 2025 14:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: remove filemap_fdatawrite_wbc
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-9-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251013025808.4111128-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 04:58, Christoph Hellwig wrote:
> Replace filemap_fdatawrite_wbc, which exposes a writeback_control to the
> callers with a __filemap_fdatawrite helper that takes all the possible
> arguments and declares the writeback_control itself.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


