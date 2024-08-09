Return-Path: <linux-btrfs+bounces-7070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F394D540
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C68B20BB3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0E4502F;
	Fri,  9 Aug 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="Rk9EK4yJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99B4084E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223678; cv=none; b=SIHPnIpVSNJD89aLGXOUVcXYfscAAXctcOaow/YApXcnALUHLuyczOtyO/u9VcYz4NSsiI3taQejQPTIGK/Z3Ei180Ohd4G4iu+TTN2lZ6X6RnG/4vdkECYrLT/q6gDZ4fa3hbFXTrzhUgIC1rEZuEbW3KOQUk4HGCIm2OZwuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223678; c=relaxed/simple;
	bh=WJvHovzMZ14z1jS1iSIk+C6e5+yhZAOfL85icxFI0Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZU/rTWvUC8x5Ak+JTMQeKMqC9j+bmUZepCQZeU46mIvo0wqZNozmo3xMhlsBqzF54+0AvjVSv+dp0r7yDD+CEhsbk6iPscmRleDmL9BpNU9vpYNfg8Y0oVwLgm78TDYjte5SNui0cSouCRiqvVxSy4NnDNH3wuiFcykQQSn8fZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=Rk9EK4yJ; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBRKLvRapxY5UL+Jjh9WSpehJ+RB+8jVc4C7VKyVvLQ=; b=Rk9EK4yJYCJjzB/+i00wUryLch
	ATMjVpEEz6buudf5zkrf8C1ryF/CUopW1GpudctPZPLr5rpomclj0kt6huicGTrv57rOUk9tbYULC
	SaRfkj/QleHc0/XEh28J6r0f5h2YOrMcYi2+Y+Pk1//Wt8KBbI4Gximkqi5lZFn0WSH0J1x9FSZqe
	E2SvWV9HsGUTcOclCqef+3NR7A174D6gXGalVAz7HkAS3Sm+AHGOFfoJmtqmv2bkWwqAzbTqWt/xy
	zNM020S9PBzkrfrk3erCCvjKTuJz838m8oehCRgGkWY2EF3lQwdzkFGAPhnmK2xoSU7E+ovWhneY/
	bSlAHM7Q==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1scTC6-0008Nw-TZ
	for linux-btrfs@vger.kernel.org; Fri, 09 Aug 2024 17:14:28 +0000
Message-ID: <e42a03e0-df4f-45f8-a61e-3b44fcd387e3@zetafleet.com>
Date: Fri, 9 Aug 2024 12:14:25 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

On 09/08/2024 00:17, Qu Wenruo wrote:

> Another possibility is, some NVME firmware has automatic dedup, thus the
> DUP profile makes no different than single. 

If this is a known behaviour of some firmware, is it possible/do 
benefits outweigh risks to store DUP copies with a simple transformation 
like fixed XOR to stop them from ever doing this?


On 09/08/2024 02:31, Qu Wenruo wrote:

>> Is there any sort of worst-case scenario data recovery tools (maybe 3rd
>> party?) that does pattern-matching of the raw data or something? It's
>> not like I need to recover videos or something, it's only a few text
>> files with known names, locations and partially known content.
> Unfortunately no.

testdisk/photorec/scalpel do pattern matching recovery. Is there some 
special thing about the way btrfs stores data with single profile that 
would make them worse for btrfs than other filesystem? I guess if 
transparent compression is used then they will not see anything, but 
anything else?

Searching, there are some other third party utilities that claim to 
support btrfs and attempt tree reconstruction at 
<https://superuser.com/a/1752751> but I do not know anything about them.

Thanks, and good luck OP,

