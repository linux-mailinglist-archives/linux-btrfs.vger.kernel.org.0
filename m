Return-Path: <linux-btrfs+bounces-12706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F7A773E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 07:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE6B3AC140
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623331D86C6;
	Tue,  1 Apr 2025 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="f4+zpNO8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C801C5D62
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485308; cv=none; b=qnw136kpXONOCW9Vj6m5GSfoZwB1sWmXXyiebGB2zZsiL8JxQrA4GTbvy0NRTLZbozwf3+1ko3315sXeaxfqTiJD6DA1MJ/Kb3SyzXORTHvlPBLiDGy5EcUU1tj+5SlUorBTD2M6SSbQ8KQzU1QizROlwGpDbVXUJHPvSmX2+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485308; c=relaxed/simple;
	bh=uq6iEDw80nkAqSc2Z27pQFmkHyRByclerLnUdvsTYQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2gUyH/ULIzgToRthauyXAr6XkaJJ0KJO5cyZmmrAMOSIl7TI7K0k9VtSB8/ciZ17UnztCVjz35FrZxfwogLFQlMV35LKkYx46+psU7N2UMyOaY48D9tZ0C45tl55EjODUXwwUw33DBaOOt2GH0aRrzr4FbeBZZ+cscYBeWDbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=f4+zpNO8; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1743484705;
	bh=/ufw4Pqv4WZYc7oHTm1Ph9PImbPBgwQzG99U0iEaU8c=; l=853;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f4+zpNO8fIYSJ0j4djhN+BD7jcmdDzbSQ5F1lNkhp/Mqsf1A2KItnV6xK+Q/Zll/v
	 mH6XWna6qY6MO3KlB5iltK8emf0YFYBWohKfTLicSu/s+gvW5k4hON4hoW0WHIA/Q5
	 bg2o5xB+b1bJvvt9duFwx8q9kOG9XNAJMcs2SMyA=
Received: from liv.coker.com.au (n175-33-160-16.sun22.vic.optusnet.com.au [175.33.160.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 8320BFD73;
	Tue,  1 Apr 2025 16:18:24 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Chris Murphy <lists@colorremedies.com>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Date: Tue, 01 Apr 2025 16:18:15 +1100
Message-ID: <3682098.taCxCBeP46@cupcakke>
In-Reply-To: <834224db-bd52-41ee-bce4-599cf12183c2@app.fastmail.com>
References:
 <3349404.aeNJFYEL58@xev>
 <834224db-bd52-41ee-bce4-599cf12183c2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 1 April 2025 15:04:20 AEDT Chris Murphy wrote:
> These are likely old errors. You'd need to check old logs to see when the
> write errors occurred. These statistics are just a counter. You can reset
> them with `btrfs dev stats -z` and they'll go back to zero.
> 
> It's simple counter. It could be 754 errors seen one time. Or it could be `1
> error seen 754 times. Or any combination of multiple errors multiple times
> adding up to 754 errors.

Is "btrfs dev stats -z" covered by removing the device from the set and adding 
it again?  If so I did that but it kept recurring.  The fact that the error 
count was there in the first place wasn't the unexpected thing, it was the 
fact that it kept coming back and had no log entries about it.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




