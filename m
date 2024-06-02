Return-Path: <linux-btrfs+bounces-5386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4208D730A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8DC281DFD
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42229AB;
	Sun,  2 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="DN+p29gJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CE19B
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717293630; cv=none; b=pyt6PxAWjXFQAga2r+jfk55CRBNHKOcbl5NDG15lbT+fLb9GX1WvK2fJTSbCEbKNCri88Z2wQpfuU7pEIa6vcSHNEXB1JN6vzy9jRbAD+dg0Gz/M3mfzXhC3VO8weE749g1BuPyJZfuZanDHvGxa36Xp16g8knfUq7e6758rp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717293630; c=relaxed/simple;
	bh=wTshQHl3q5vbt3bIjVHhSw1wk4U4b9w9rtaQMc9Myko=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bB0ERb1yYmpBlJnRDBAEhC+VlmvMIG/TFh3Er3Y4G8SXqigomTQz+ikqR5d35IPc4FNW2VunM5EHKlVskRG3GHuSKUCMSFE5m/UREmqxkES8k4eDOsEwMMb59Gh3MHfUXWFsn+aL65QfGM6Ms1+BlMAgXcykBd13pFkEsPaEPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=binghamton.edu; spf=pass smtp.mailfrom=binghamton.edu; dkim=pass (1024-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b=DN+p29gJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=binghamton.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=binghamton.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-628c1f09f5cso30360167b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jun 2024 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google; t=1717293627; x=1717898427; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLDMBRdqUzSv+WtfrujdkJ72lW43fiGeDNwvuXoNOn4=;
        b=DN+p29gJ6rTBbO++JaTwm78agsCF2AmG7pYnsi4skYcI64BwEdyKJWY7tb2Sy+hkNu
         yoCTys93c/KTV3SIASPE8hregZJJTxuWK/L7OFOpDgHiwQCProhl/2oUd1RV9VvdONAJ
         1x5DUM7IdtneK3suvk1xzGtDD83RCFhIZDYU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717293627; x=1717898427;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kLDMBRdqUzSv+WtfrujdkJ72lW43fiGeDNwvuXoNOn4=;
        b=NHf2Nx4pxuvDQK2VwmH/dowua33mgn0k2EvBe5Dy6TYh0hxYTGnxuS2VSyj8bRlpd+
         u2qOErJ64sYH1itPmS4EhTFPjqY4lDBdKoFpp0yikujxwncikHtqtWRft7BmQIbmYWY+
         DAJ2+FpObPqwY5CLCmV0Dt5TnyvnJGc3dmVZyIDpLGWgzX9M7mWnEnBUZTDh/wU80jN8
         EIqHesjLucYWgb0xEhBV6bCKC18jZH6wxzxApAyU4Kps0vPLwZLv1NpbJkibhbGR/njX
         0J2GGCfHBILKGOKW3f1UHT9pRYNDxDzKJ8/jV4qbgue8HyDaXCEOJosXHt8jQ9hR5tV7
         iclw==
X-Gm-Message-State: AOJu0Yzs1zJPaKpkFPVmICgeN6CMr+rnJo/6oxCSTgot06g5ovbtSRdT
	dPVPrEZd6T6HOl6/AiHQFU575M++/qG3uAcxeiyMlKja0FYS/Cub1Oysj4cO9z2UkhXhrTgspZy
	njkW5999Nh8ang589vNW8likpVVRzZgCH97UGmKrkUfQMdAJABqgYIdl/VRcMmBI6vC7T+GJvk9
	uKfgm/5w1vRnWXFsnVcr7IWEfiGv6FW6BJlz8dFw33hk2Qfcg=
X-Google-Smtp-Source: AGHT+IEoY0W3K7y8GUube+BkgGNnydz83oIL4oMaNm0DpNbo8i5jO4XKx14t+4JsAA/s5BSSj57/DA==
X-Received: by 2002:a81:af0c:0:b0:61b:c92:ece5 with SMTP id 00721157ae682-62c796ed9e1mr60360467b3.20.1717293626479;
        Sat, 01 Jun 2024 19:00:26 -0700 (PDT)
Received: from [192.168.0.149] (108-253-160-33.lightspeed.dybhfl.sbcglobal.net. [108.253.160.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766ad84fsm8824347b3.116.2024.06.01.19.00.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:00:26 -0700 (PDT)
Message-ID: <51b057bf-ce55-4649-a70d-a7b4c7b8981d@binghamton.edu>
Date: Sat, 1 Jun 2024 22:00:25 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: William Rotach <wrotach1@binghamton.edu>
Subject: file system failure after hard reboot support request
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


   I have reached out to a couple different locations for help with 
BTRFS, and I have reached a dead end at my google-foo, and my 
distributions discussion boards.  If there is a better place to ask for 
help with respect to a hard file system crash, please let me know.
   I have a corrupted BTRFS file system, with a quick summary in bullet 
points:
-    single new NVME, 6 months old, 2Tb size, 1Tb used, 200Mb of really 
needed stuff
-    one backup exists, 6 months old, still need the new copies of above 
needed files
-    Fedora 39
-    chromium, high tab count, apparent culprit
-    hard system lock (no ssh response, no console switching)
-    repeated hard system restarts, last one crashed btrfs file system
-    btrfs hard failures:
-        parent transid;
-        checksum;
-        bytenr;
-        search for next directory;
-        can't read tree root;
-        bad tree block start;
-        212 found roots, none seem to have a "good match", as noted above

   I started looking into the kernel driver source code to help my 
understanding of the physical layout, and may build a more forensic 
method of retrieving the binary/text data that I need.  I hope there is 
something that is already included in the btrfs-progs packaging, 
available through the source code, or by the developer team itself.

