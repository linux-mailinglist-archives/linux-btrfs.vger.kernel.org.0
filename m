Return-Path: <linux-btrfs+bounces-2673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620E861732
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688D31C20BA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4E84A4B;
	Fri, 23 Feb 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="H0Tq3Enq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049184A34
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704739; cv=none; b=ZO00L/j6ZF153fbFUo71rMpPpk1jtUnonBtT53D/9QRVmbdSlJm08mPetNiXOQxGCFgWK7+ifJwIS3Yyp0IlwwmOdf22C+9GI94aQkdG1s9HJ+qk7YPgLycVWhmniSa+an3MTj45kCAPG+vii6s3agKOEuRMEXQlflzzd0vqWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704739; c=relaxed/simple;
	bh=1HxsgyjZXj5xpb/kJDcGDCMSnpdNJSQShH/bPxUTKHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X7Ee624DNANM6IZJ2A5+o3Rc5/ETOyK9ij5PxYQBdW7MAqD5YYjWsUHix4+kNLoaiJ9pajEUUcb8o1H57UJH9ZiDf1eJSTKYwuD468k95LDF00tn2jcOt6jmqjRm2+uMOhWM9a0O6pCP0ISeErkIHiTJYwLialUKqUteXn91qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=H0Tq3Enq; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 2E18680D12;
	Fri, 23 Feb 2024 11:12:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1708704731; bh=1HxsgyjZXj5xpb/kJDcGDCMSnpdNJSQShH/bPxUTKHA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=H0Tq3EnqhqZ1t0aI6iXowtItklWCjSzn90RzM5ff6zXF0v7VUJ814osx6sUtA8FJe
	 kg0OMAJxJIA0LPNEvFP+m6d8QWn7n/l50gCA5+eTRMM/PkGu9zYDrgqmpNFeSUyXEU
	 mftqf8ESHe1jDp5RrnNwb7sOi9/hkx3qqGZMAcQtYCzEOuFV9R9BWHz0t407fAsnT+
	 1qIZfFWQJJVrg3yX4PS2asi40OdFHGlveCmSK9uO29YVgOug9BUzAK2x57rUiOBgme
	 /jETB5C9xXI6VqelyX9oVpgYC6Wfb1BO4ITILBHtoyBGAOmIbCR+xwwbmCbJmbzCE0
	 XGjyhgE3G8HKg==
Message-ID: <3da9b99e-96ff-4d74-8a74-da8284f169f0@dorminy.me>
Date: Fri, 23 Feb 2024 11:12:10 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 06:26, Anand Jain wrote:
> To better debug issues surrounding device scans, include the device's
> major and minor numbers in the device scan notice for btrfs.
> 

It would also be nice to add in maj:min into all the error messages in 
that function too, if you're sending a new version. Or I can send 
another patch with that if it feels too different in spirit to you.

But either way (with Filipe's adjustment):
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

