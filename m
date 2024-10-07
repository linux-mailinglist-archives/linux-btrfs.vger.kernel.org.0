Return-Path: <linux-btrfs+bounces-8577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F288D9928F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922751F24283
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414A1B85FB;
	Mon,  7 Oct 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b="Z5sp2ZHh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184018C004
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296103; cv=none; b=VsZfn7srOYUyf/iBUtW8HXaHwLPtoF157XYsUEzDGlrcxCnJDWYBQNI1zju7rJn36Dsr7l33vI8cZvxb9O0eVEQV0eKZHdhpfDPb+1d0CveKG8TiCwvh19s+Hspy3E/q3w9baBwoDDZUsx21pxxXCF28+4HjQx906SN7FDqJepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296103; c=relaxed/simple;
	bh=Q1P2168sOfwBoNsnXBoX+NClX2hEu1QSEgTnDUYDXFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n7QyUhKbww+bWeZkt32ot78NOh92KbsjJ2z1lOZ0q704urZhul6PbR22S/Tn1dYzJ30lt88f1goLOfGojkhJCVk4X383vKakKMIQrVOtO7Nj9tIqoOm53V3nGeEJnB0b4Ewbm0zudiMkNoj8Vit2vUI1NPGXShgPPWCeDbhdKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl; spf=pass smtp.mailfrom=dubielvitrum.pl; dkim=pass (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b=Z5sp2ZHh; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubielvitrum.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 212B5C0A7C2
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 12:14:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Authentication-Results: naboo.endor.pl (amavisd-new); dkim=pass (2048-bit key)
	header.d=dubielvitrum.pl
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3A2EIq6Pv18p for <linux-btrfs@vger.kernel.org>;
	Mon,  7 Oct 2024 12:14:48 +0200 (CEST)
Received: from orion.dubielvitrum.pl (unknown [157.25.148.26])
	(Authenticated sender: postmaster@dubielvitrum.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 48798C0A771
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 12:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dubielvitrum.pl; s=dkim-2022; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZDu/p1b68E2NtXJt4JExu4Z3rWr9AvYbneA9mHaz7tc=; b=Z5sp2ZHh6nAa+fwN3XMOy8Xzf5
	QzIJlR5+GTrDnMy7PIS/u+Wo8cHHAnclTUNnzzbgbmconSP7kX7H5dckvzt2IbN/2hBfIkOuiipFQ
	w21JxTrxfjCeg3jwWSY3h4QTuZoRisRr3TpJsnVoU6MnAFFU+EgZslVRU4Wyrgh0lKX1RVVZG8G30
	/6XDCqHQRWbN2MWr04UG/nD/yyyv9j5IrRdAwfTqs+jtSNbQywoJzZ/pDYLk+HnhTcLidahn86apy
	fIgVVV75yjJFuICsMAo8qpvrSr+pymzMUDNRDpFSC+evqlmlRdjag9rq0+csioERl+pUpE+6+19iS
	nDAS3hJg==;
Received: from [192.168.18.34]
	by orion.dubielvitrum.pl with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <leszek.dubiel@dubielvitrum.pl>)
	id 1sxklM-0053WG-03
	for linux-btrfs@vger.kernel.org;
	Mon, 07 Oct 2024 12:14:47 +0200
Message-ID: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
Date: Mon, 7 Oct 2024 12:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pl-PL
To: linux-btrfs@vger.kernel.org
From: Leszek Dubiel <leszek.dubiel@dubielvitrum.pl>
Subject: failed to clone extents ... Invalid argument
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Backup system failed with error:

ERROR: failed to clone extents to 
root/Metki/Repository/Dyspozycje/etykiety_transportowe_rozkroj.csv: 
Invalid argument



I moved serwer to new one — new hardware, new disk, restored server from 
backups.



It was running few hours, and again fails with that errors.





Source system:

root@orion:~/Admin# uname -a; btrfs --version
Linux orion 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 
(2024-09-30) x86_64 GNU/Linux
btrfs-progs v6.6.3




Target system:


root@zefir:/mnt/root/orion_recznie# uname -a; btrfs --version
Linux zefir 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 
(2024-09-30) x86_64 GNU/Linux
btrfs-progs v6.6.3



