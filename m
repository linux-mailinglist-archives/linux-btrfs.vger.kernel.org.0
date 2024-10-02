Return-Path: <linux-btrfs+bounces-8419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CD98CDAC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 09:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B01C215A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AB192B79;
	Wed,  2 Oct 2024 07:20:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD211754B
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853630; cv=none; b=fLGa4CSEH/5P5eTT8sEMOZe2xdm/uZukfQlRXqzz66dwOBh7XcwXyLhvZbEz7y0AJ8V4N2y7WLEGlrb52NtTczvVgHXNL/BNh6VwoObU58BC7rZcg+qDhmvV1gRrb9M5QE69zsoQOhg+lOxegqC0iWKyijyPq2dx5fetMS6gQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853630; c=relaxed/simple;
	bh=f3ewz7+fyQlOso+KVaw7uVcSR4DuZrrc/46adEroUmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jO8hKNH9OfFmZh8EcrYgrI6esnLDjHftUd8XaLj6hlJC8eSRCn6z+T29YvYPRRuksJgfFsKs5EtQasJQOw+behOEceG1h5DjuYMSKhUFB34lnlONp9ZiK8aB7B/JAEcXI8G2NvOGMOuSbIrLfRWDmRdle74p79vPy8lInruDsIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.115.142.59] (dynamic-176-003-131-142.176.3.pool.telefonica.de [176.3.131.142])
	by mail.ekdawn.com (Postfix) with ESMTPSA id E3993188C13
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 07:20:09 +0000 (UTC)
Message-ID: <48390596-364e-48a1-868a-4e77b81bdef6@horse64.org>
Date: Wed, 2 Oct 2024 09:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
From: ellie <el@horse64.org>
To: linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
Content-Language: en-US
In-Reply-To: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

An update: I've largely ignored the corruption issue for now, which is 
somewhat feasible since outside of large write loads for a longer time 
it doesn't seem to happen.

But there seems to be another larger issue with btrfs on this device. 
When syncthing scans on all its threads seemingly maxing out I/O at 
least according to iotop, all other apps including Phosh (the window 
manager) freeze eveery 5 seconds or so for long 10+ seconds durations. 
It seems like syncthing simply reading blocks vital reads for even just 
basic continued operation of other processes. Something about its tuning 
seems to fundamentally not work on this low spec hardware. With ext4, I 
had no such issues.

Sorry if my rambling isn't useful, I'm not experienced at reporting 
filesystem hiccups.

Regards,

Ellie

On 8/5/24 07:39, ellie wrote:
> Dear kernel list,
> 
> I'm hoping this is the right place to sent this. But there seems to be a 
> btrfs corruption issue on the Pine64 PinePhone:
> 
> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
> 
> The kernel is 6.9.10, I wouldn't know what exact additional patches may 
> be used by postmarketOS (which is based on Alpine). The device is the 
> PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/ 
> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to 
> check in software if it's 1.2a or 1.2b, and I don't remember which it is.
> 
> This is on an SD Card, so an inherently rather unreliable storage 
> medium. However, I tried two cards from what I believe to be two 
> different vendors, Lexar and SanDisk, and I'm seeing this with both.
> 
> The PinePhone had various chipset instability issues before, like
> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe 
> has however been fixed since. I have no idea if that's relevant, I'm 
> just pointing it out. I also don't know if other filesystems, like ext4 
> that I used before, might have also had corruption and just didn't 
> detect it. Not that I ever noticed anything, but I'm not sure I 
> necessarily ever would have.
> 
> Regards,
> 
> Ellie
> 


