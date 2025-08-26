Return-Path: <linux-btrfs+bounces-16355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849EB3506F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6D216D249
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F876266B64;
	Tue, 26 Aug 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvLx8lpp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CF257830;
	Tue, 26 Aug 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169039; cv=none; b=MVkhCGsWLI2aS5mV4OOEzqXau5utH66/2a3Nmnhk4jqvFV7JIoqXueJf0+VlEaxPGeduNvG5Iu6jFZl8CTt9IVogH8KY4P7mjs0k2gxduV51Jt7vVrv9eg5cJnPeXpR3kJ5iUAZFg/nywARjbP6kKnPKaKTb1aWFVwvkXU/U43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169039; c=relaxed/simple;
	bh=VuprAmNdVwRNwOpNRwdqS3ze/UV1SfnuogRvhgFIa4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj0W224LEQNLXFtZg9gWzOqnQHNI2L2dmlLaGVMM6NtViK4qZ7rhVl6xzXmpiOqp5UTCjjfRGGBUztC9YFhP4OuONmHIRjMRYCrMaIDtP1ACO2zbHoMcDR9HLI3ih4IgCqQF0zIUk6YOU6FaU6kg9mlk9Aa2wa7O2wnWQaQ/xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvLx8lpp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso4074639a12.2;
        Mon, 25 Aug 2025 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756169034; x=1756773834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuprAmNdVwRNwOpNRwdqS3ze/UV1SfnuogRvhgFIa4c=;
        b=BvLx8lppu7G09/YeilUGEbxPqZN5A+9bD1RRW9sP/rl5rbMg/6pMVa2auwgi3AvJfP
         He8BHL9Sb4jiv0lsOqNB7zkIYNw5Ph1b2owtUUuEdLDLNVbTnmoKntj/3ciJUjiaBfMc
         CqN193x6zUHQdpc11OS8+Tb36ZU1OIwEWU3J3r4Lk+yt91cPXWQWix7ZtBGJa7Fa3WVE
         6ymG8MnNuWoIDfJ3I4AFsgnug6lt6C8YRZbQL05tp+fb01s+RPwX4J6qJqZoWvQNJsUH
         0cdBO8OG5Vqxpj/y+d0e1EiAkibEjjuaPj6OLTq6xrVraVguW7Q4WJjnuCjfJsiwlFxd
         dVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756169034; x=1756773834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuprAmNdVwRNwOpNRwdqS3ze/UV1SfnuogRvhgFIa4c=;
        b=a86QPpJpl50ytEMIBe7ZwIMvUQM2VxkuHE85K5vYU56X1CqVwsoGhDMI+9QMBLrJuG
         5Z77bUCyoISNwl592KSzueWTTGZirwSKRgBr/UO7h7LjwRKptA26IRKYZLXpFC3yWRiI
         RPKm0XORv5MXkXB2mE7RlgKC7gC4rqWaAGahz//QR2CFwgy3pzj9rUvJgneOpKJr9Hc6
         qpQla7MgFUA7ES2FBy6r909pm6K8xHlB7u4rT6D+aJvIGQN0WDuXaKpE4aMd37aBr8Cf
         NLJbxF9m1XmEWnigr3gP4shLZ7Pc998K2IfXGB8W0WBanboBFbob7Gp+HA65AoUzGKWb
         JnCA==
X-Forwarded-Encrypted: i=1; AJvYcCXl6LVTJqzmhwyH9W3fIQH+atwWuCElyC4s4H8tXRRNJtWv2LnixkvJ5y+kEdOUnvkVnKvzsgXx3iCMXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCx1r2nGAQ0Tlg7aPAUdxmvB8txpc9v0DF3f/SoeteoDLJMRGX
	Pe3U6oB1NiLVklSeVeV9N3lSfTbwXuL/KKbNkcSqdgbkf8SkKgJ9+Bz/
X-Gm-Gg: ASbGncsyLXm5PnRBHL4qesGJMTj6TnANUhglbr2g3iIpjuSDN/yjUHz7hsMtgKgvnA3
	Y4G3iaLpb4kwiWtONHTs0KPsIRmA8U6nKfGuGTJQ9Q3rqp9egeU5QGdIcmn62K2m7nwu2V3dmbk
	AzInQB7mEHpigUUFmNnHLCXm/GXP+H0cN4pKvMKPYjS3WICUPOFwlXcva9MFH06wMiltsI3v/zz
	WQb2c3EKx5MTzVhynsbC2A0Xzov2Z+JauOJxnHNA6wQAYY9xACXtUy59ZQ32+PjyWDSe9GsMTqj
	TcfiTpJm/cziqHNPNMEatVktQlociW5Qy8RGTbYowJaM0K+4M3kXInHXyNQqyUoyvE+akg789H0
	+TRgF3zWhjQp1vz9cMsqcg61ryOHwvCJ6T8APfEziWs3mH5z6W1GrBJ3AOHtoGEYzzd9y/rdHWW
	m3
X-Google-Smtp-Source: AGHT+IGp5FBArIhU/5h3FompoWSCrr9aBj9rYowb5yYc8b97+Kug3LWN+VlxhvsRiwLfgUmOqNa3lQ==
X-Received: by 2002:a17:902:c40f:b0:244:99aa:54a1 with SMTP id d9443c01a7336-2462ee0b77emr194203385ad.7.1756169034231;
        Mon, 25 Aug 2025 17:43:54 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:9ce0:b09e:9199:95c4:55ec? ([2600:8802:b00:9ce0:b09e:9199:95c4:55ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af23fsm79304815ad.51.2025.08.25.17.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 17:43:53 -0700 (PDT)
Message-ID: <7be35af0-d249-4910-8f67-309e111f8c08@gmail.com>
Date: Mon, 25 Aug 2025 17:43:52 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/009: increase max open zones limit to 16
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 Naohiro Aota <naohiro.aota@wdc.com>
References: <20250826002720.12222-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20250826002720.12222-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/25 17:27, Shin'ichiro Kawasaki wrote:
> The kernel commit 04147d8394e8 ("btrfs: zoned: limit active zones to
> max_open_zones") introduced in kernel version v6.17-rc3 caused the
> zbd/009 test case to hang during execution. The hang happens because
> zoned btrfs requires the maximum active zones limit of zoned block
> devices to be at least 11 or greater. The kernel commit applies this
> same requirement to the maximum open zones limit also.
>
> However, by default, the maximum open zones limit for zoned scsi_debug
> devices is 8. The test case zbd/009 creates a scsi_debug device with
> this limit and set up zoned btrfs. Thereby it violates the 11-zones
> requirement, which resulted in the hang.
>
> To avoid the hang, increase the max open zones limit of the scsi_debug
> device from the default value 8 to 16.
>
> Suggested-by: Naohiro Aota<naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


