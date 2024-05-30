Return-Path: <linux-btrfs+bounces-5364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E3E8D4BE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4691B282949
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE617F514;
	Thu, 30 May 2024 12:45:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.pmacedo.com (mail.pmacedo.com [178.79.159.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20197183087
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.159.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073148; cv=none; b=enLfyESCBchKYMfj+Vm6+T39LdZrWcAlA2H/oI+DoLzuVEs7U6AhvKAlUimJczFOySqApCxnicP1iLjcXn9GIfhkXX7Ba2KuoANq5mypRbhZ0I+moHrQXy0zqnr7qDN2OzIKCeNk6qfoj9LYzMrMV8+HdKiA2rzgb8EmboE6c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073148; c=relaxed/simple;
	bh=76T0h1fjhrVfCqGsq1DzbH2nzxCSrZ186Iflg8S5ywQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cH15H+KQdTwyli6iKc8CSot6UCNRHOR3ET6sUNQDoBTiGIuZc4x5Yq4nAnbq27EgKsPVd3HVtM/LvDX6WUS+g3+z4tgY0ALigaKATxcZWXKM/A54ogabo2x9smuD271uedPuy5OYA6Y0MsH5BH6KtZPFDrnBPit9YFnFzao9uME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pmacedo.com; spf=pass smtp.mailfrom=pmacedo.com; arc=none smtp.client-ip=178.79.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pmacedo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmacedo.com
Received: from localhost (localhost [127.0.0.1])
	by mail.pmacedo.com (Postfix) with ESMTP id 300AA227A20
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 12:36:27 +0000 (UTC)
X-Virus-Scanned: Debian amavis at mail.pmacedo.com
Received: from mail.pmacedo.com ([127.0.0.1])
 by localhost (mail.pmacedo.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JoVSlzb_0yPd for <linux-btrfs@vger.kernel.org>;
 Thu, 30 May 2024 12:36:26 +0000 (UTC)
Received: from [IPV6:2a00:79e0:60:200:c0cc:b407:73e7:968c] (unknown [IPv6:2a00:79e0:60:200:c0cc:b407:73e7:968c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(Client did not present a certificate)
	by mail.pmacedo.com (Postfix) with ESMTPSA id 9ADCD2277DE
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 12:36:26 +0000 (UTC)
Message-ID: <4122a35a-a7ba-4deb-8db9-6e67647f53cd@pmacedo.com>
Date: Thu, 30 May 2024 14:36:25 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-GB
From: Pedro Macedo <pmacedo@pmacedo.com>
Subject: Profile conversion - unexpected large allocation on target profile
 during conversion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

I'm in the process of converting a few btrfs arrays from single to raid 
6 and noticed one behavior that seems unexpected: according to btrfs 
filesystem usage, the total value is extremely large compared to the 
used value during the conversion.

For example, on one filesystem this is the reported total/used while 
conversion is running - notice the 2TB allocation for ~370GB of data:

Data,single: Size:40032.00GiB, Used:39982.40GiB (99.88%)
Data,RAID6: Size:2021.09GiB, Used:376.60GiB (18.63%)
Metadata,RAID1C4: Size:84.00GiB, Used:83.47GiB (99.37%)
System,RAID1C4: Size:0.03GiB, Used:0.00GiB (14.06%)

If I cancel the conversion and give it a few seconds then the vast 
majority of the reported space for raid6 is reclaimed 
(bg_reclaim_threshold is set to a very high 75%, but I don't see the 
usual log messages about reclaiming used blocks):

Data,single: Size:40023.00GiB, Used:39973.42GiB (99.88%)
Data,RAID6: Size:406.25GiB, Used:384.58GiB (94.67%)
Metadata,RAID1C4: Size:84.00GiB, Used:83.47GiB (99.37%)
System,RAID1C4: Size:0.03GiB, Used:0.00GiB (14.01%)

Is this over-allocation during conversion expected or known? This is on 
kernel 6.8.9; I only really noticed this because one of the filesystems 
failed the conversion with ENOSPC even though there should be plenty of 
space. For now I'm working around the ENOSPC issue on the smaller array 
by using a loop with dconvert=raid6,limit=100 followed by a 30s sleep.


Thanks,

Pedro Macedo



