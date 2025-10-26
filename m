Return-Path: <linux-btrfs+bounces-18341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585EC0AA29
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71504EB1DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536252E7193;
	Sun, 26 Oct 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="EcvlvsyD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA714D29B
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488968; cv=none; b=om/E4TxSN0DyaQsAYpGH7qR0+pF3qGgbfPxalqoIG6Y5OGPnvXtJFb6NIeEyB2W7BKxODr14XB9/FSOp1Sab8O2LDsHV9Y0lDS9EAuwrI4t0lN36S8ywO7DNeF9da2OKn86DRLDgYMZdKbJlcaxbDp6S69kLayV/qRetiBJSlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488968; c=relaxed/simple;
	bh=eHV/02Xg3jorl0ZzWZuIYXV3hlGg3X/RFoCqEwUFDBs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=Bcx610FVlmhHQSh4K+vFcgwQzTodvjCyFXEDWRRivroi/9s5mV8GHvhQqcHyzC0nr8BxV899ZFMOB8kNgewPJ3/eeGI8R6aL9qoqlGnn0iyUkKVxeO9tcF/hJoIrCZAdGjn626BbesCx72FM46zff0/EmwQtYATRvt2+v/lg9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=EcvlvsyD; arc=none smtp.client-ip=98.137.69.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1761488960; bh=a6mjxV9OCd9CB4Oq15XrHC5inGfg9VpbMT5a/+S51ik=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=EcvlvsyDduQQT5Sa20xw2PmpwNnfFRZstzU0kwRdGglKce4i7gOnmM0gqEFxPaPNAdBpMWu0mxkFc0uHZJIxMGMZRmiKthK+sjC21FY48VlDCLngR1TE06FF7KZmrGwQeYhFijEVLRC7vseE8NQ4dJIi5KS3YgWH73UyP2Uy++eTVHbSwEGj0wlBaGU+DlR0htY33SVBckMm4ZMZq0wppmd0IevGjlH6ljJF/Z2H4U5v67zzrBd/d2POcCv1drnGSYKZyguOkm6/WyOy6CWvFc/u/J8zQY+g1edJt/qxm50MQCwKitRWk6B+4JNyujLNY0rblfUbABUYFQ0v0AUNLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761488960; bh=riImLemxacu8hdJpFGAsnOW8izpfZ4ZreJY6R3ia0Da=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=YCkLFzMiKoChNbM0ZHz5h5kGYpnhY35f7ttU1Ozz3IPE38257HOwCZ7yGUcxLtzW2mamNp8Hz40VHFsZe1e7b/vrJ3RPdWI1buLuLvJLKMlug0n9My6DNYVdQ1JLs30GApC/kiJW4OlLvNp3oud8fHJoGIIUzfU7gzyQQF5q5QsjJ4XoD8t+BiZrjRRZOsjUVQFwryWkx5YdkBttlsA2nD21ksH+zhXNEh3QI3C72l3cMWSaAAWXQI1ex6Sc5KyC/VT/hzJ9iuWqIfUWB/BGJ6tBv6l+0QSJICX3JKfusPjB2gYVOcK9gAHqUXZPFv1lobmZvpaRBkrV+dXEruh7RA==
X-YMail-OSG: AXF0Te4VM1l7jYJbv8pbBOWrkc7ld7PA.nMCQ1RwCrQU7P4tMEbVw1ZJ6IDixNg
 ee1NMqolD8nRT46LpntBNIROU2XD9SvrO6dttGVkPm7n2SIjSqNxyuhv7VEMmuQCl_OT1akhYeZ_
 _BAiqEM07tN1Ry4aKP2wEFRZ7eHWls6jk7z9IKkxEwrArOFwliHv42cwCK.WMTxf4I31OlWKAte2
 TdFqWakcgae3ExtBCNSZME1qqIKpITogQwSsaw9OZ58Aj3py0hoHmBCBwb.U1S4dNwWt1F81CP.V
 3wqlIxz2ix3zD4BIak3GsSb3Xfj9aMkWTTsQRLhfREtUdTtc0IbFE5LnOjftQ3nsHflrb0KrE.g0
 MKPV_G8AzWVcA676MQ3akZ82qqJk1.Hhiye.XIpRrpETZjIKrYgaGT1mkKsE4PAFbZpXJXv4l9oo
 nKQa0FbxjnIyjHK7qz_IbELz9JedJrdVatmKrw7s.EyZDJsmNViWTbN_F8n9_SAJ7gmPTb1sXsRE
 Cx8.thUjf6UwSp3Sve6H3GZHD20XluoB_tk.zICwK4R5xT6SN4NeR.7MoSX01q.24Ku9AJBgOk.O
 RIByWc3m_0X6SDnsNVuKxu1y40a7yo2hWfszzMwcfar2oJsv3cJjXhGDl7Y5QoRXrEDAM8Mmn.iR
 D3dGzuDge0_HkklcHR_mT6FxWzSW3Y2.ghEupvU0yEtJgnYooIzwM1Geh_cMMxiQ2ife_YKDSR_p
 F3SyRmRr5j3R8FHPeeMn23142UpdLQnxm1wZOVRKWJKmytaFkJpgmIXo_dLGh1h306OGRRpSojTA
 gQ2ciNlx2UKpOzsCUXn7i_Ecv7r6VgENK7E2HzraqVtRVawYyjLFdHyFd2WEtsPqqUfTMWr03tQ6
 SK99gWkLmbeQclInEPiH6SV3R0YLJTAsEhHgpfYmgeDvc6momLyuUNUKGVel934YpzJFJlDw2ONM
 99U4KUmyMVLlONxvz5hnnn00js.MHU2T3mKA58rc6b87rrxDjHc.itE_WGtw0y0V0zlNouUVxy0.
 hQitVrNxtlbmTYiMe43bsE2k_XWdV18Z118rQfMXF1Ch9VT00btB.nRkh9zQT5agygLAMer5wOhS
 N68FEYcWiqQYO2kTmR7mUwx03NZK3ib9BDRCbfxET8ugwb17w4VDBme0UuIHOSYwmm5tDo.wZu_g
 O4bXxAF3n70Dr5ePKLVFkMnn8aw2xmGcLbFruE5P62h6Rmq.X3Fl7t_rhLqvRzQb8HZcQhru3OiF
 aW6Mkp5YOjuvW6IbmP7kmtGKFjO9H1IdMVARhyptLxZfzHvzYumG1qTdKQAM9uyKN3OiDUKdPEZu
 JxON23U9Lr89ib3dqzT1BuN3v5Q224WgNPPXQW8qTgozzoa6M6nUYykgZurS53dVMdU7TPZzRgvA
 PUnyIr2cNTROaofUCGX.1OaSqcDY9EfDIaaPyTkA3EvRPsAPQ7k5zQuA6RRWt6eb9WHeUQFaBr1T
 4NG2HF8palhONaQV0fdwjN8iMM4dldARdmHvxC6UsuAJDGwgZxpN3ztNeKpJdrnaYy7JdqWCtbLj
 hXvQVTiw0uWfzyaqY8igJtjzd7cnNwzwsEjwLcOGgmM9rGF2239u1chZiRHK2OcmhgyKfB4YTVY9
 MOOVLPJV4PTt2pqbb1Ph2aSKJxBppnLansCxCe8MB9LYDMtrYax1KqKL_8ctHYPRS32EWa7MDlQI
 IVcj3gkwLA6DV52texFtCZHNXIWjKPrAEQML.1CmnbZ0MKQYnTPXZw8N9T8FLSXILrjnqxlApnnH
 JJ1DPYcJCDYBl3BfVu98pBHLUG_GXvWqpmlSz3fg71RMCWPSrWCh95uCWFYsH0uqC7RGfGBMPZO4
 cI6C4L2_UPcLrwXx.kbU0S6BK2e21SchTOaknOwXtt9jAqgGs3dOVAJCK820THdLeIQJ7.Is0eDo
 hwQJ6CK5Y_1W0Ln1nMklMfZCATZ2vVvoKi.43suTcMejrFA_KGj9ElbifujTBmkAdKDCMnoGo1T5
 JEhk_TbhMr5ZWPTtwAnPaJjfP4fGz1AEHRCO7cLBYx4AvaAgL.2YfxNTRE1s6uE_bX4.FLARoab0
 qteYiGqCK9w.RQjNvNptXZDhNe6CY6rYjxml_hPjXGgfCDyjVutVQeKRHls5AGG4rh84OwaaowjH
 R5FVwk2R0yS47BR03K442XanMdI.ODKOyHzNvfRQVqBPjNMoCDnVvLBcQYQlAS.xEKoO.NDHa0K9
 qBIrm1AQyKaIyqBkqjb1k9RlYV_4BLaBLvIYAok_vixU-
X-Sonic-MF: <brent.belisle@verizon.net>
X-Sonic-ID: d6de0a74-56da-4e9c-a9ba-8569b3d03008
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 26 Oct 2025 14:29:20 +0000
Received: by hermes--production-ne1-56478d9679-khlhl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5cad2adfc4cd4da86122ed483483c97d;
          Sun, 26 Oct 2025 14:29:16 +0000 (UTC)
Message-ID: <c01bd806-9490-454b-b29d-61e5911b2483@verizon.net>
Date: Sun, 26 Oct 2025 09:29:14 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Brent Belisle <brent.belisle@verizon.net>
Subject: Strange btrfs error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <c01bd806-9490-454b-b29d-61e5911b2483.ref@verizon.net>
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

when I run a btrfs check on my file system using btrfs-progs 6.17-1 I 
receive the following error "we have a spare info key for a block group 
that doesn't exist" , however when I do the same btrfs check using 
btrfs-progs 6.16-2 the operation completes and says "no errors".  Is 
this just a bug or has btrfs-progs 6.17-1 really found an error in my 
filesystem?

Thanks for looking into this


