Return-Path: <linux-btrfs+bounces-7019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03895949BC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E70288DE0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C5174ED0;
	Tue,  6 Aug 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1d9Bn8h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7B18D644
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985459; cv=none; b=c41JcncdSGl9YgBrbR1PgZHcYX/27zQuT0e2+cGTgD1dzZndNwvm1TsBRw1oTbAq71Z0qQtoj8RGgoLu5d1yO7ZXcMPeCKzHSeOiXpwSghva7VL2pLAnZZpYPALZL6v+k1100uPyD8NziRiFg3BBLUPl1MMAUzQ0RXapZak9YdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985459; c=relaxed/simple;
	bh=uP45sYGpUuPnVEPDPG6JtR51DycGs+HlSccNwLsBiMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HUGRGRiegxXVzXX77NWH6PR+ytxDDcnc3E3Dr9XvfjkiIYBvL2JayRA4w34HlWZbE8lXrl05726HlDzVu5UQlx452NYep3cK4QNbiMT4l9IxJiXA1J1tVUAf3Qg+C+e3yTaoOEmekNs0a0hfm7vSuMU3/bWLn0fZwRwkpLOTP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1d9Bn8h; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so12527821fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 16:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722985456; x=1723590256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uP45sYGpUuPnVEPDPG6JtR51DycGs+HlSccNwLsBiMA=;
        b=d1d9Bn8hcjRaOQOiBYZ945hK8wVyaH2bpi0G3XUL213li97loCd2OjH9KKS2C/52xJ
         rYLA1J76rZi7U4ZhZhoHcS9auOvvHOB/pDd0dKSSGCwfMS6ERVr3Mretvx0lmcuhHPEh
         TGxFZDbswgtq+C5b4lbzjIcI+RaWS8u61m1FMIPDqPXZqFLCKqp4gljWgzlJiHVXqdBY
         iJ/EZClrwflBODg8iw5itAi2RdIdziMgU9zoIHdYuzokSRxgzuERtnuPU/9PjqMxL9D6
         tEA7+haXhJUA4JPgOsVBvxKI7nwlz821wlX9wrs/bRyrRdlb5Ysv73GrthPgVpeodZZ/
         iqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985456; x=1723590256;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP45sYGpUuPnVEPDPG6JtR51DycGs+HlSccNwLsBiMA=;
        b=tRc1RAJnYaKs9+QJl/hJI//B2y2Dq9Q9WrI7KB8lhdMaNvsjzTKLHs4cC/DcRX81PR
         acOuz99iVPL5aJms9SPHQ2g6nEjzBDDyEtvk/9427qc73rfSm5ApYxemSqqfwxmMpNKL
         qwDpfKN0DhYlWgfsMqzIYki4b/iRQn/A5jgoUs0UZKDS1vRl94qjpwwwCcEhQaGPgWqa
         7Zlp2NQbmAyq7VBD4wtMUDt5xeDktSvzCgdO1pojFxwtgl7Cm4G+8R6TlaG9SNj/bEjE
         lBk7+oakqKGFFMpk0zGqIH1W0lN39TcPIZ8j+9/X6QgW/gsnhujU8n/qNl4kqC66ZpyC
         HW/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQWE1utsEQnraRfYsl6ONoXzW3UIbDqfL1lTObgwz1xB8Cr3sU7IeUK9V5VLW5kEVtcjEPpbcS+5xSkxgRTW85QOFsJKx5sMIukOM=
X-Gm-Message-State: AOJu0YzSDcv0Ax2lbSEqId6zbW6MBQ+hnVreasTZkC+mRxQms8kVlUhb
	J5nhOXNgfXWvhNkScrXDF3sPzib3wgmTT5Ce61BV41ZSd8aAWMDr
X-Google-Smtp-Source: AGHT+IFYl2Z79kW45I7UPtfqFTpFwsj216Bzjyksj6o5a9GAHYxbedBTb7HUmP5qXOViWu8c3OGP+Q==
X-Received: by 2002:a2e:934b:0:b0:2ef:2dfd:15dc with SMTP id 38308e7fff4ca-2f15aa7191fmr109710721fa.9.1722985456218;
        Tue, 06 Aug 2024 16:04:16 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c9c7fsm15507431fa.71.2024.08.06.16.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 16:04:16 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <1a1f1549-5fe8-4872-ae07-a83d092df56f@gmail.com>
Date: Tue, 6 Aug 2024 23:04:15 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
 <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
 <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
 <55a368af-ab0b-4bb8-b61b-53d20b163d63@gmx.com>
 <a149ff05-73bd-4232-a532-8c5efb4a69e0@gmail.com>
 <05767a39-e59c-4615-b693-774976bd54f1@gmx.com>
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <05767a39-e59c-4615-b693-774976bd54f1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 22:51, Qu Wenruo wrote:

> (I guess a UPS would be better for everyone except the budget?)

Of course, I have it. But you underestimate level of my paranoia :)


