Return-Path: <linux-btrfs+bounces-13526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B5AA1B6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6411466431
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FBE25E81F;
	Tue, 29 Apr 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="OaIw8Nt4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AF1C6B4
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955628; cv=none; b=hZREnh+Ku/x1q3NzhPOHQlj/GP/JoddBgB3TvITtY0wzvbmj9ouEqvHFpW/tnCqeqz2GnLqRyjzOv9E5Xb5bzk1af1DMFytmV3U/yZpiFMi9y/AV2O/veKPVZ5I2f8Amv5Ie3BB1GxNSKcoiG4qDGW5yDvqf1KdTKFHmAliyl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955628; c=relaxed/simple;
	bh=HDSa5fIK9xH7zoAXQewsNnvQV8Vp9nCt1HnUC3+PKxg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=cWitLpI+vhvPMqXGVc4LIYtMKW+rsFTCdH4QGfTlothoiD2oxKJ07Ce1CR1P+RsU7j0guNnsfkiT/7zO0523RjDbeH0uDW8Y8wVBqn26qieP3lHjCbyBEzkRWRYgsKYroOAlJCz4QLMOEicFfxNNMs/3I2YxNLAz1H5ypFs6GBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=OaIw8Nt4; arc=none smtp.client-ip=98.137.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1745955626; bh=9peKSBiWzND75iBaVf2O+cCryrSVQih/wJOE0Z44qzQ=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=OaIw8Nt4XZdWsST+sv/5bAJeawn3B/M4receO0O8NsknYkSnSzS6+XCuQNv89dIJY40WxR605Er/kU53DtyEmy0+TKGPGoJmcT/MfBAfekJOFzHeiTkM+tBv/8zPAwUhzYywQ6gECEOv3mZGVvhX54EBKQGeduEbp5DZuYQ84GI4uW0T+98gFYy5rhS4PMclBs0VZsDJJT2OBU+AlWPCJk7GFJMXGlRETaLzWOGZE414i3VszXVCezz4ABz9o5+EDUFlcbz9nLkvMhsQRMDFVYsKD514F/SsgchEjsMhttr3ZQmDpjqb2TymgXLfqeUWBmbQTGSdqLNaM2a/kW5zkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745955626; bh=uQm+1onXV449J0qXbwpLEW7YpxQVQkF05xlGPLOyCEP=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=CRBIBesa3qb9YrG6cmbkAtP8056D7GBBTt/cbG0MzPycZLmMED2su4lVwg4d7kCCIZ9KiX/FuAf9owZeRw0FjF2pKPpxF6xD8Fge0hY2JW7FE7KK2eqJXCyT9x/+prMlpwdqnOn/DpA2ISMa6HMLAcvd6sxVF+ND2ypKIsLbLO++JSDNea0euJCaIJxieSugrcSy7+MX0jsK1BWiU6ynacsFnwHfoYWAewlHmLv/ppN4plPXuug7MmMGVUk9Fc2NPmv+gRkF57jm2GnGS4xGfUaMcLayExvMMVwX8eyaJu5BuQxczBIGrzO1Vk7ye9mRUP/70zzvXaDGVIPc6mZQGQ==
X-YMail-OSG: qPdEVRkVM1n5vl1lJUGy98plTP7QHpeFRu9XRftbIofQD4eTcBKmxfkAVmKf79m
 i11sKTO1TcHtndE3OOqaAJSh.a49RNeX0Fw5VR1iVcO.Yybn_VGFlShkX3Q4hwyYK96xLFPrgs3u
 7kPBNdE.1R8VzEOyrzXAJX7YBUIKMp5dXuaOXLpW_lzeUEfLP_S8TZ2bnvSN_2AH1qcboZ4L71Iv
 KTyBZFPvfWpZ3BlL6NedCxcpI61K.Gu8MzgskcYvnCNHLEbtxM.uQzUhLFEcnsbqIvpW.U9384Iz
 fVGpYHFEJzyKg8WfNINuWGJa4nC3uPRdY1hFur7pXh0WvFHN3gBmpt0WaU1bOSfrwPqjilQsAMYR
 0HM5lURdnmerLqNCJGz05F8P5WLy4PmUgP8Z45TyFV4IEcF1iAG1myxdUiDIgZYYUpyBtmGYadKE
 D82elCMjooxYOzvHqTxWLuF_N.1C0JFJhV42HvzO2mlwY7qM3tCkjcPzpTZUNO9vtbG_AG10vN43
 s8O.8wQv03hajJsP5MbLVfS7ltwqDlomlS1p4p2cTRux3UnIa17I4ClL7UVEmRXS2AmNgvnLK4Px
 bofz1T3UKM.XiKdlCiz5Bez4XIlF5TL4tUPGU.MXvXtMptbmfXz0fJLfVaNN7RHWVwYVTF5FmRIo
 OaLG.gAAfJQLchLHmK6myNPPneEAyboWfJ1gDG5_TDsbzN0ZaB6AwxXUrOTfWmRFWRgXntbedNiE
 N9DPnYbNn.4rsEFZ8FMFbeOtOv2MqkBZqHxuudpQtUQYUWmmht0UYpkuCfFiLMArvnj7XaeGFq33
 9SxKdJ1fgTAxVJKcfOm8OI2uAfnVt_BMCZCcT85.ZKAU_wa0m1SLmtwhsaj9Goh9Fj4MftFHgLp5
 tKbjWOiM60NGpQUOJlv.UhVLubXpOPgZETXfuHii4wtosdGv2LEjjOpiO4FG1pSaQcnS3YoHTRY_
 zDOd2giCTmKvbx_OD8vuyr9O1z50oICJ.c5UrOJD_eIFnQT1gA8HWrsQ0hvzTzqYt9aSLwUXyK06
 OLe9IX0E1_K7NlKW4R2jme9R4L_iWX_D1MKfWlqngYCSORDRztBP5JY8b_Kf5tC4FDeaZYuXQYcA
 veECPYmEHPdeHccu8PNJEFTvup7dSjeke_r8IGCDoNgESHCl5BVbYJncholGLP4rKxWJM4ZkhvzS
 hqAApNHTKCDOBZW82bKkFy8cj18zI9WLZZoLVAWnxUxY5OOzFQy7JlwCp2EnBJ0HgkVH4DmHwF5C
 NuchhYppImM1iV1_srgwl2qIpu9iaqG8VPhpea8R72M15A2s7q06EsJMgwnc2FPhQoYp5ANU.HmG
 XVqwxYKYLFxqLLGWCpyt97cT43A5mPQtnWKB_qaTJIjS9LDDsTwPB7BGEsssPr0KrAcR6Dx9ka26
 0VIrlWzPgT1qxeVdM4hz8iXCAeZz8eOjRTg.JAdTZE6lOLbmeusEMmycXAgMucbI8JEcwLN68B7.
 LAG6P7e0WNzJ2NnCrNEqSs10pZiM5ojJ4B621dNCh9LMz8t4t.NZ9bdGpyG6LZwvtBaVZCtNKjey
 DQ7xxBn0OgUXJK7hyvXWMUiSa2aYsuuyNoVa1vn9xSv7YhOfJNKHkaE9IerTYe1ODBwvQO2fQU.V
 1rVFNbcikmpqJ9Z2OyHGhl19u80qBpQkcHaLeF5iyb2D1Uu6cmeudi7VZN09FaV9sJYLWUERhB5e
 FQXwOb_AXIsHRAL4iD_HQfAcXUE_sQTwYeTXffvRHXKT3i2F4FVptJ21XufWmCGKD7h1jzAMiHKN
 vrUilcwJ2z.BaFKRG589EUvtx0lv8BnYFwaKJ9vAMi_dduipCvRWB9Ba76WNTtCu.NTLF7ZWSVHs
 EV0MR28jQTMfCm8jsHKwM.g0yeHtjTUx84ezstVCtiTjXUU4Gv3WZHPJ5y01u17cTh6yA7mXMyfy
 OwLaI0VRtiETO7.J_aT24ZvB5us4QvBp6CIXXYD3qU_m1L.6YHXQPqXiN9uwaOdjPinP7r2wvCbu
 9bOhuhNqepCvEfxIwcP3Sj_8x3nMVEITjFm6vFv9ZwMMhod76TzhWZ_DFj.n_Lvv5daVYtSGzQWC
 UoPl.7fdvk.u2lgYHhHeXBrQ.Z6vwR9XM.ZU5qyMByzadSaet3yF4JiNahLB3Au0kWWdF6SlO3Qh
 2mCJ3ilVvhhCr9yZslGlE.1nV1dlrxjENaB.90Z3.D3U9_hBWl435PKAY_1pisMZIfJ9muQMHjjf
 ssRTuMhh1rdfrMlcwkGepKNQC
X-Sonic-MF: <brent.belisle@verizon.net>
X-Sonic-ID: 916fc9eb-7370-4c4e-92d5-35dbbbf8765b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 29 Apr 2025 19:40:26 +0000
Received: by hermes--production-bf1-689c4795f-895qn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fbd68fbb7d0e2d3a0cfe59fb600c6157;
          Tue, 29 Apr 2025 19:40:23 +0000 (UTC)
Message-ID: <b2e58691-8912-4723-b5b4-ed9e80cbdb14@verizon.net>
Date: Tue, 29 Apr 2025 14:40:20 -0500
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
Subject: btrfs reduction in disk io
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <b2e58691-8912-4723-b5b4-ed9e80cbdb14.ref@verizon.net>
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

I've noticed since upgrading to the Linus 6.14 Kernel that when I Run 
iotop -aoP, that btrfs-transaction and btrfs-cleaner Show almost Zero 
Disk io. 'm not complaining but was just curious if indeed such changes 
have been implemented in the 6.14 Kernel. If boot into the 6.12 LTS 
Kernel or 6.13 Kernel (EOL) then both those Threads so IO activity in 
iotop. I'm not a Developer, just a happy btrfs end user. My System is 
using a Samsung 970 PRO SSD so I'm not worried  about wearing the ssd 
out via excessive Disk io.

Thanks,

Brent Belisle


