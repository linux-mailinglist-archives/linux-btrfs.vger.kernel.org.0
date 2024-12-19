Return-Path: <linux-btrfs+bounces-10611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4549F7E42
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E78165880
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3B225A4C;
	Thu, 19 Dec 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUGFxISF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD02AD16;
	Thu, 19 Dec 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622837; cv=none; b=h8y2o2h0LqB6qt7VKLz9o0vNPZGFMIJTSnuxYs+OGyAOr6x7alWE1AbBTnWLUtKQ3iyx56Tjp36IY21S9Dh2jS+dAggiHxBey251SVfYfIpNKq/YUpOSBbKb9dceGWyz8CBLFgS5F84iVn5bZ8lK3vC5tfiRWDQFcTbS5Hsz0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622837; c=relaxed/simple;
	bh=/uAt920FD/Sk3BFpPCBkY1NCBDMZ0MMpVBpTRlmG2Zk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=klTRhaG3o/lFo6uBovolwSilG8Psea42cUs78m7ePZPfjIV6W5lPpyFYCSSFdbGf+umlit+ssmM65Uapj72dsqDfxbL8mvCoGgctCwaC5zkiFzD/Z3d+isyVgqaXQv20MjNA6lI8EKO0XEWoNOarEpW6WO0/VQKlbVbgX29Fgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUGFxISF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso7175215e9.2;
        Thu, 19 Dec 2024 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734622834; x=1735227634; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9naOK8f9NiinQN07Rkhqr8ZvLVguhfUabo7lyYbETxY=;
        b=gUGFxISFG7fTxsajX0Wh2K5H7UlNSjUoJr95+6/wxOoW1hVHzO6X0ZQhZHpTkZvCLx
         dEdbzEuLSSfjpD9IGOOEwEQRgilq+8mDTzgFS1U+S84F5DMFVhzv+eTaPjzFibbaDwp7
         V2v+XOlTGS4+7BmuZjzpOS8VQbZqOh/fLXi9bdlFnGlkpQaFPqIm2bnZNNGxSpOsaAut
         ukxQgP0ajZ9/C7TacBrKgsGfo81ylR1SDODHXeMNfoV06yh5NOaLjA7oCFi4QYmdyL30
         1rih/uP5bePXO8nhZ0rAHAXMqM9Zq/mPw+i3uftu95nILz5W80zmO2ayzadIbX2hq7j+
         6V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622834; x=1735227634;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9naOK8f9NiinQN07Rkhqr8ZvLVguhfUabo7lyYbETxY=;
        b=cyNChEQ7R28e5GdKcfc8Y9j4nx0s9hmEdBEtmLJLb8omeqZ2mJpcVtpasi9i8qvPOW
         44pmdymQxKZ3FDqj3Rgu6vd1voR8mSvrQtFaE3hF4aypNIgMEaej0fy5Wc6/hRuLzUP5
         FwV4oZytFFk2jets+yN5MoMV1OFwDndq3EeYTAqKYGQDCXMjSfKgiQ1HDZu2bRKnDhyo
         gdbQVWQNn8T//dV9czLXPTNlnYn88n8DQ/HCygsmTogGPtfHvIaeV061GLPT29p08g0X
         jlMwDsUTycLrFHYaXNxAWzuhdj8RGLSA/ZJj88t0SjCpWJrW5/2EigQhJe6YXgqPGT+c
         4Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCVjhF3GXUYPRrl/ajZ9uHMufyeIteQnaZ8lu1zeU1KQvJbjeG+WvhUVs6dRcWYuP9e9kHVEuE5TOBHJhQ==@vger.kernel.org, AJvYcCWMC2gGAnzh00FgQ4iD4HK2O+Jray34MIpM/+chQ5t/Phf2wlUfYZsFpk6ZGTOrszTDQUjitbqQxKfwbdmz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gh/4mQa6pfZ/vM4JXI13SpIs6OqBTtJ/KQxL+JTbEPCyjOol
	g1qMMgPP0ZAEFZsymi93bmoyZ9/jfGxEReFvui2AIrR/UuA/fuLa3KHwSLsG
X-Gm-Gg: ASbGncsr1/hFibSLXsJz+7vLFbxErsFzvalmMqZdM+IEfGxMQiP2pk3N6s3sOZnDfpS
	r4Zg+/bbqDo3pWPg1TLFAr+n6U3KT1aQJTWRVGsNb0B1m7jh6+pTRg3Ki2JmEpxQDJ0vCIADLOh
	mI2uats9/EiEdqVPSkK6ZxzQpvBU+djdgDls2yPzOkmuLYjYEScGvuC0Y8BZwTTfsSstP582545
	ApOx563LJg+N4ROjsNvLYvDD9kCbnLT5IbcYYF+NZQRGblhGoGoYphw7/4wdi7xrQ==
X-Google-Smtp-Source: AGHT+IEqNvv1DuBi//V8wG7dJyQxM3vSL+HhY7G24jQJiByRvtCIhvNBIPTna0FvE1W2k4Q/t/d4BA==
X-Received: by 2002:a05:600c:5126:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-4366312eec4mr19081365e9.27.1734622833619;
        Thu, 19 Dec 2024 07:40:33 -0800 (PST)
Received: from [192.168.1.240] ([194.120.133.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436611ea42esm21463575e9.9.2024.12.19.07.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:40:33 -0800 (PST)
Message-ID: <cd8135e4-2de5-48d7-a7de-65afb201b3fe@gmail.com>
Date: Thu, 19 Dec 2024 15:40:32 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: btrfs: add btrfs_read_policy_to_enum helper and refactor read,
 policy store
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Static analysis on linux-next today has found a potential buffer 
overflow in fs/btrfs/sysfs.c in function btrfs_read_policy_to_enum()

The strcpy to string param has no length checks on str and hence if str 
is longer than param a buffer overflow on the stack occurs. This can 
potentially occur when a user writes a long string to the btrfs sysfs 
file read_policy via btrfs_read_policy_store()

int btrfs_read_policy_to_enum(const char *str, s64 *value)
{
         char param[32] = {'\0'};
         char *__maybe_unused value_str;
         int index;
         bool found = false;

         if (!str || strlen(str) == 0)
                 return 0;

         strcpy(param, str);   /* issue here */

	....
}

Colin

