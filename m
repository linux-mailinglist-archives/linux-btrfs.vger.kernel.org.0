Return-Path: <linux-btrfs+bounces-10684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D99FF76D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438F97A10A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C92193419;
	Thu,  2 Jan 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKbziKFZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0902B2CF
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810367; cv=none; b=ovNskUiz2wljOxUkOO8DectdeZA/KrZ4/FOPxXwxMZ6ruBlTHgtpNk2UP7QHwHqC9jiYjKPlvh0hv9oNvPSJQ4TOfmSWAt6h0gitHwYzbR39DoEvseKUNvKrer88LI//jfmDmHts1cr3EXO95A0S17+8HwMZ5HzlEs/2sKUKSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810367; c=relaxed/simple;
	bh=PwAxTPWSMtlvAmpWmkfZnXedH488tXXg+vxKN/ko0ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1WnHqFuC49tycARg+Z79nDEqBldiW69LY+32psT9yRJNtD5koOsq9M0PLqHgDLZjFBwBg63ttA8b//40uES3StYEcuDhcqaEyco4GBSaGbcYPmrB/m6IrBn15NS1Epgw15oGIG5B/2UC4qWqLBws+amlHQdkWgqggl0LD8/xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKbziKFZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e2880606so8244287f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2025 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735810364; x=1736415164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Og8UtgwfC6T7sXBXxfWFoF8GVm1UYDIMUeQ2eX507/A=;
        b=TKbziKFZ/GjD5sZX/KSIpHwqW78EHdQf2XD7YXdulC726NISZbr4RJZ/trqDaLJjbQ
         BrpNisngX/kpZ1KdgWG1EHafsdkNxgLyreR53JCuzmVO+oSqbFvQcqQBeBaI1irh425h
         xGT0Ynu68in099yTaeo0k8rSdCFj2meWY1+YebbBvmSuDz38rLcu+43ZRrbMhXlo8qyF
         9vAy5VX50Ku5BBpL91j4sa9TuxtsUSuF21KM3ud4e+OZH+eI6G6l0okjyHIOeWlWgUUB
         KmjDSQ7zFe5hFEevbPB7v68xEGkStjoN2RFO3kNIW2KFYDs/JEvy1NQ5T1FcpsobgAcB
         R+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735810364; x=1736415164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Og8UtgwfC6T7sXBXxfWFoF8GVm1UYDIMUeQ2eX507/A=;
        b=bQ2ci12Jl5iVsM2D09wgEWxWWoEpyDAkIe9dxW8riNnUnZzmfhvt6b7thr+4imvrTr
         7FSAvFXw1Gvw70F+3clflYmuE3bnMdP6lZhYyhkkQwFm1cRksAJ9E+WwKuooO4A/0uqZ
         Jiiz+1tK6r1XZgMDKw6V+xSiKW3ARYUR1M4YQUINJdOzZF5F3fpjyRP8hcGiDdg5XTAW
         xjmtFsTXuNc63ez5nR6LLd8OjqhLx9wMxQTLv/Wb26/dJUQAPUvaVQbgmWkMQSayHpGn
         eQq45jl7n2ufwSKXDVHHyoQ8mBkFtP1/Ci4yIDC/10n6x05Mt334GwFZKMwYeB01HBRT
         W2Og==
X-Forwarded-Encrypted: i=1; AJvYcCWTLEMFSoQz7m9ikPq8GVwQMSglQl5WzUvd2yUYPspZco6VyxiHKoNTJHFVDw64m4qzwWzUkr4R4IQvvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/e9IR2tP0vXaBYY1scWUD0czUoZi0G5RdLR334Dq+yrSJVT9
	PBtObWlRrqjsqBMd0+tm0MZP57gibo4GLDhhu3i8CfjEj5gXwcp4
X-Gm-Gg: ASbGncs1aLiUw91fxBAeVjjnR/Jqx/kyEHiFB8G39Wn409GObx8rkzaRDDfXK+9kqVl
	1q6AD/S0DTpsxje2GTRHAOZf/im63fZQLAEvstCktW5QPdLSGgmyM+aACuIFzpdtfTK+zP6eeuZ
	Tmj7pRoij1LV0AhUB+BaZxXxr1y/SxTxE4k1M/GB6TKb3aV9hkvnPZenovxOlkzoIYssNsL2KTs
	cg7noOTTsL3Xw/VSikNAVG7eYIuWkEcUEoROib85Pceg0+sbzZrDm8A4B2VonptPIaOWZZQXgT7
	VnYvOQjBN6c17ge4
X-Google-Smtp-Source: AGHT+IHTYZwvn4/pFiyddH/HNPlD6iiWcuHZbVxlQjsLIWA2DnljsnI50ZDCHES9rPGlcnBOUeImGg==
X-Received: by 2002:a05:6000:1887:b0:388:c61d:43e4 with SMTP id ffacd0b85a97d-38a223f8368mr35838815f8f.45.1735810364154;
        Thu, 02 Jan 2025 01:32:44 -0800 (PST)
Received: from [128.93.66.153] (ptb-02008469.paris.inria.fr. [128.93.66.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c515sm448956595e9.30.2025.01.02.01.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 01:32:43 -0800 (PST)
Message-ID: <a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
Date: Thu, 2 Jan 2025 10:32:43 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS errors following bad SATA connection
To: remi@georgianit.com, linux-btrfs@vger.kernel.org
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
 <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
 <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
Content-Language: en-US
From: Victor Banon <banon.victor@gmail.com>
In-Reply-To: <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2025 00:40, remi@georgianit.com wrote:
> This was probably the worst thing to do in this case.  If the errors were all caused by one drive known to have suffered SATA problems, you could have tried removing that drive, mount degraded and read only, and see if the file system was intact with parity data for the missing drive, (and if yes, then rebuild that one drive.)  But forcing a repair will have replaced all the parity data with the corrupt data.
I understand. I did it knowing what the command was doing, but at that 
point I was under the impression I had already identified and deleted 
all the files with mismatched parity data. I also don't think it was 
only one drive that had SATA issues, and at the time I didn't understand 
how to identify which drive(s) were responsible. So I understand I 
possibly have 1000 corrupted files somewhere with no way of identifying 
which without using a backup for comparison. Either way, it did not 
appear to fix my problem, so I don't know if properly rebuilding parity 
data would have helped - unless I'm getting the timeline wrong and this 
was somehow before I finally solved the original SATA issues... I'll run 
a new echo check.

I'll keep in mind that procedure for the future though.

