Return-Path: <linux-btrfs+bounces-10175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028819EA516
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 03:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D692284F2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF41442F3;
	Tue, 10 Dec 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="WJz+KqXz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737F233159
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797598; cv=none; b=KYtNBi43blqmVol6O/Mj864jGjrTxU7l/6te0SG/aLSRi0lAAt8mOddo8mf6Y40IFBbnMA8BPo8BsFOU0KHkOMoIu+r2AFRma3Ylod4sC9jAcT9mEmsPPUrqx16zX6OibuiJqAj4PumeKg7iaG57n07KcqwmTydnmODspDKtDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797598; c=relaxed/simple;
	bh=LguocFZfD+RAyy9P2QbrfmuEu1Ix+fQXQbvJgCgdHoU=;
	h=MIME-Version:Message-ID:Date:From:Subject:To:Content-Type; b=LugrevRPrI05n1pIpJEtqz6s7Tqtprs5pnkuKguCikflHfR7p0wBFkma5Fpw7MzOkIl6sGAmDdCDFgFsJ5uwNt0w87XKhbThe51H9uE2Vqmltow9hRFGa8WUevVH8DRPAknSYFFx7A4Z7u+dr6IpbNChNdM5Gzz6jA8LN2jZpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=WJz+KqXz; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=WJz+KqXzDWXmUp9F7Bb0L7aiqJldZtQ0LfpCzj9qjQYaUXRdv+Fbnd2cEJJyEke5xS10bytAlve9Ej3rgLERAjHvvEPJ+OY5sYy/n49HJVyc+7ZXwO7xTqr2a6uBJznnsNFtH91r6bID8KQMm0qkPv2TvhdZc4pxuuxW/YpU88h7x4n2OO1bUyWNM07MAaVwlBRNaEqOI/2T5fKgYZ5b5FMtxjfngwMrI9AQb3B5VHomXYlklH0Phe753iCASinO2XnJ/VzezYufFGMaz1ii2oGRv0C48oMnT86Eb/Zx0stQfmTV0dMuuQWmKiChBdYP1h+E3Z764HkxnvPcedv9Xrvb2TBdr0Llm6fEhC5wmNuVFAIrzF0jM18UM1dcdfP+noV81w6Dx1MvXjNG+mudt5JRyR6rmjgo5bsbgRCQxGVvFd/hLik+3xt0WTbf/X6I8E6J04WcQePBbJSHzYJ2f5tGhYaITEgT0P/v30EuI+s2AEbWX0hMHIzoYo7TEtRPcTrERtYcsY7aXCWHN1pqpOnyI7l2XCWnYnDKC9EfKFf4B8XliflDvgkX2VPbU2s3j6mDtGHiy4R5XeuaNZMG4JhZLICwCSnf1hnR1vzFmKOcwg9mzbc71Ax6CNuMijAU4OCSyPehTtl1CuXVoGitJI3RJX2ja8zQ5HRWwXIs/GD8J6GfVSWh3dC6VY2uTo1AAdnlshSurRcGhv5VtpdPBcXYf5lJdxYFx2gQwEQCR8ZJl7zS8OP1b2Ur94Mzj/7hF7T0Z/FaKXqYL57h3c1N8gd/q3nKeKGBLMhqO+3QjKb5ja2/KSi5IgOVSAlDhe6behfca+E52vPh8571yyI2Clx8Rq+fIwXDbE1hnOSjZOQ4xkpBn1JEAMoNspFla+VsUe/IBDiLSJwO8wuIQqS/Tt3ZMhQGOsBXQq9uhxcX50TZQZcbrlnGwOr+OTXtL+p+qLFCMK
 rtqPq8PTy0fUoZcv7Wv4BO8D9xTHyKqpaGxdZfhNLKuuFt5e5MvzzigcxXKL+qp0nKpcNG198/hw57IPfyKPwBz368CvAaVBz/MuaCW3ddnLYt5h1Ln/+ox3AdiycNveWZwbbmP7VVpoBqRB6QotHmM1OR8MTvF8vA66tE1ujaJ6enDCa9w0olkTeH85dMt1OPbMN7lGe5Wv5TQoW9pk6jHxIUWTj71fcQbVPMbyBRIDLX+zh0iStnTQdKSb7M59prVHl09Y+5OQvjB79uJk1OVNu2n9SCotTmi/hH1BN4XZaKWhHEJbIoTNKnW8jnSEIXZSmlixzF2zyXxuXuDQpm4aTfPF2kZm85vg2TCUsdfkVGenRQb7rT0Bh0ZqWUwbnWpjcyMj9N/Hy3BQ==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=315QAA4Ch0Z1HzaAZGuDpPMP/9+wR0S+Oc957zS1F3k=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from me.scoopta.ninja (EHLO [IPV6:2602:2e1:80:111::f0c5:cafe]) ([2602:2e1:80:111:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -801086124
          for <linux-btrfs@vger.kernel.org>;
          Mon, 09 Dec 2024 18:26:25 -0800 (PST)
Message-ID: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
Date: Mon, 9 Dec 2024 18:26:24 -0800
User-Agent: Mozilla Thunderbird
From: Scoopta <mlist@scoopta.email>
Subject: Safety of raid1 vs raid10
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've read online that btrfs raid10 is theoretically safer than raid1 
because raid10 groups drives together into mirrored pairs making the 
filesystem more likely to successfully survive a multi-drive failure 
event. I can't find any documentation that says this to be the case. Is 
it true that btrfs pairs drives together for raid10 but not raid1, if 
this is the case what's the reasoning for it?


