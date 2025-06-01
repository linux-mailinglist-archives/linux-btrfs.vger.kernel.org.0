Return-Path: <linux-btrfs+bounces-14350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208EACA119
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD82E7A7D48
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jun 2025 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86D24889B;
	Sun,  1 Jun 2025 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="s8wvoEjo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out2.mxs.au (h1.out2.mxs.au [110.232.143.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCE1A9B4C
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Jun 2025 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748819453; cv=none; b=c1+3iRQU8OOqkKyKFoykDxEgCJ9sQJotNTvLKIhrJGxgHa16pqCEh4n1T+qx6I4GH4ojHGtZMHv+jPe0EcFd62NJmp8+5PUGlYPwmz9YFh3qkx9+PGKPdz6lXXKOacyF2JnZE4uoyXVundfLIUsPhJiycUTlfPhrSdbGc7LOZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748819453; c=relaxed/simple;
	bh=b+uGQCaKBNtN+AzXMg58ehKFT99J82tgU+TH5EZj5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU7EhEes1X7vfM5NwBfjWmvWKhepF7+tMWMrhkq1dGWYdd3fJu00ZN6xf/Ea6ZQkfHp4mvMxFj2dVg9cIphLBtHf5cCgO3l2UaBUFBRW7CcfmIRzicWAclm241Tfp3aGhAt5qactnxX02mMZa3bC1mul1NJi3MBhe8M9tB1Wbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=s8wvoEjo; arc=none smtp.client-ip=110.232.143.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out2.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 084f0532-3f3e-11f0-906c-00163c1ebd60
	for <linux-btrfs@vger.kernel.org>;
	Mon, 02 Jun 2025 09:13:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wmkRFsEhExkHBpSRKQE0vzMADbQBtMbEHNqxLmg75kk=; b=s8wvoEjojx/sKvfLbjS5MdNmBK
	AoV62fNl0jow/iQT/S6cuPQhvyZBe9gk9fx5hFrLBFoNdioaVr2lnaCAspp4Wiwjy3AUbOa64XD0v
	ogUOdkKA5g5E6L8vFxz6tqaVTWwPsDSIe8t57t1wLGLsBiAjaCNYPPCAjZnkYbT11y6gWZtRRVD4B
	lJxcP1NSca6I3BhQVLVnNzvOXkGUfBBJhpYqAm+RNIAAq0kI/jxQt75b9nFAoaOvQBgeB9UOo66kC
	WGa+oRtm1c3IOkwUWEeTXrS1tn5rj78joZ8qAdkvGnK/RxNT2qYTfJlrEm72e62by8jLKnAixHvLD
	DaEQKrGw==;
Received: from [159.196.20.165] (port=60045 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1uLrp2-00000000FTq-00Bb;
	Mon, 02 Jun 2025 09:10:32 +1000
Message-ID: <b2dbfdb5-4cce-459c-8d30-01ac6124d9ad@edcint.co.nz>
Date: Mon, 2 Jun 2025 09:10:31 +1000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
 <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
 <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
Content-Language: en-US
From: Matthew Jurgens <btrfs@edcint.co.nz>
In-Reply-To: <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

>>
>> I ran a mem test and 4 rounds all passed. I have had some 
>> intermittent RAM issues in the past (with other RAM though), so I'll 
>> keep running it a bit.
>>
>> I can happily rebuild this drive but just wondering if there is 
>> anything else that's needed from it before I do so?
>
> Maybe a full "btrfs check --mode=lowmem" output?
>
> That output is a little more human readable, although much slower.
> With that the clue may be a little more obvious.
>
> Thanks,
> Qu
>
2 more rounds of mem test passed

Output of "btrfs check --mode=lowmem" below

Let me know if this is worth pursuing (for the sake or btrfs) or if I 
should be recreate it

[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ERROR: extent[34471936 16384] backref lost (owner: 1, level: 0) root 1
ERROR: extent [34521088 16384] referencer bytenr mismatch, wanted: 
34521088, have: 32030720
ERROR: extent [908886016 16384] referencer bytenr mismatch, wanted: 
908886016, have: 31195136
ERROR: extent [2875780890624 16384] referencer bytenr mismatch, wanted: 
2875780890624, have: 33013760
ERROR: extent [2875809234944 16384] referencer bytenr mismatch, wanted: 
2875809234944, have: 31817728
ERROR: extent [2875830599680 16384] referencer bytenr mismatch, wanted: 
2875830599680, have: 31506432
ERROR: extent [2875838840832 16384] referencer bytenr mismatch, wanted: 
2875838840832, have: 31899648
ERROR: extent [2876162703360 16384] referencer bytenr mismatch, wanted: 
2876162703360, have: 31899648
ERROR: extent [2876166127616 16384] referencer bytenr mismatch, wanted: 
2876166127616, have: 32407552
ERROR: extent [2876166144000 16384] referencer bytenr mismatch, wanted: 
2876166144000, have: 32423936
ERROR: extent [2876330934272 16384] referencer bytenr mismatch, wanted: 
2876330934272, have: 32358400
ERROR: extent [2876331147264 16384] referencer bytenr mismatch, wanted: 
2876331147264, have: 31178752
ERROR: extent [2876332736512 16384] referencer bytenr mismatch, wanted: 
2876332736512, have: 31096832
ERROR: extent [2876335390720 16384] referencer bytenr mismatch, wanted: 
2876335390720, have: 31178752
ERROR: extent [2876339290112 16384] referencer bytenr mismatch, wanted: 
2876339290112, have: 31211520
ERROR: extent [2876340469760 16384] referencer bytenr mismatch, wanted: 
2876340469760, have: 31309824
ERROR: extent [2876344238080 16384] referencer bytenr mismatch, wanted: 
2876344238080, have: 31326208
ERROR: extent [2876352102400 16384] referencer bytenr mismatch, wanted: 
2876352102400, have: 31358976
ERROR: extent [2876353953792 16384] referencer bytenr mismatch, wanted: 
2876353953792, have: 31375360
ERROR: extent [2876355870720 16384] referencer bytenr mismatch, wanted: 
2876355870720, have: 31358976
ERROR: extent [2876382806016 16384] referencer bytenr mismatch, wanted: 
2876382806016, have: 31588352
ERROR: extent [2876388818944 16384] referencer bytenr mismatch, wanted: 
2876388818944, have: 31686656
ERROR: extent [2876388835328 16384] referencer bytenr mismatch, wanted: 
2876388835328, have: 31670272
ERROR: extent [2876389031936 16384] referencer bytenr mismatch, wanted: 
2876389031936, have: 31801344
ERROR: extent [2876389310464 16384] referencer bytenr mismatch, wanted: 
2876389310464, have: 32423936
ERROR: extent [2876389621760 16384] referencer bytenr mismatch, wanted: 
2876389621760, have: 32620544
ERROR: extent [2876389736448 16384] referencer bytenr mismatch, wanted: 
2876389736448, have: 32964608
ERROR: extent [2876390260736 16384] referencer bytenr mismatch, wanted: 
2876390260736, have: 33013760
ERROR: extent [2876391063552 16384] referencer bytenr mismatch, wanted: 
2876391063552, have: 33144832
ERROR: extent [2876391292928 16384] referencer bytenr mismatch, wanted: 
2876391292928, have: 33374208
ERROR: extent [2876397912064 16384] referencer bytenr mismatch, wanted: 
2876397912064, have: 34045952
ERROR: extent [2876409970688 16384] referencer bytenr mismatch, wanted: 
2876409970688, have: 34209792
ERROR: extent [2876422029312 16384] referencer bytenr mismatch, wanted: 
2876422029312, have: 34455552
ERROR: extent [2876422144000 16384] referencer bytenr mismatch, wanted: 
2876422144000, have: 34455552
ERROR: extent [2876422307840 16384] referencer bytenr mismatch, wanted: 
2876422307840, have: 34455552
ERROR: extent [2876424159232 16384] referencer bytenr mismatch, wanted: 
2876424159232, have: 34471936
ERROR: extent [3745800863744 16384] referencer bytenr mismatch, wanted: 
3745800863744, have: 34455552
ERROR: extent [3745945550848 16384] referencer bytenr mismatch, wanted: 
3745945550848, have: 31834112
ERROR: extent [3746020147200 16384] referencer bytenr mismatch, wanted: 
3746020147200, have: 34455552
ERROR: extent [3746020212736 16384] referencer bytenr mismatch, wanted: 
3746020212736, have: 34455552
ERROR: extent [6651510882304 16384] referencer bytenr mismatch, wanted: 
6651510882304, have: 31522816
ERROR: extent [6651638415360 16384] referencer bytenr mismatch, wanted: 
6651638415360, have: 34275328
ERROR: extent [6651738914816 16384] referencer bytenr mismatch, wanted: 
6651738914816, have: 31571968
ERROR: extent [6651740110848 16384] referencer bytenr mismatch, wanted: 
6651740110848, have: 31621120
ERROR: extent [6651747434496 16384] referencer bytenr mismatch, wanted: 
6651747434496, have: 31817728
ERROR: extent [6651748761600 16384] referencer bytenr mismatch, wanted: 
6651748761600, have: 31850496
ERROR: extent [6651790704640 16384] referencer bytenr mismatch, wanted: 
6651790704640, have: 34275328
ERROR: extent [6651790884864 16384] referencer bytenr mismatch, wanted: 
6651790884864, have: 34357248
ERROR: extent [6651793424384 16384] referencer bytenr mismatch, wanted: 
6651793424384, have: 34455552
ERROR: extent [6651798159360 16384] referencer bytenr mismatch, wanted: 
6651798159360, have: 34455552
ERROR: extent [6651799388160 16384] referencer bytenr mismatch, wanted: 
6651799388160, have: 34455552
ERROR: extent[31506432 16384] backref lost (owner: 4, level: 1) root 4
ERROR: extent[31522816 16384] backref lost (owner: 4, level: 0) root 4
ERROR: extent[32358400 16384] backref lost (owner: 10, level: 1) root 10
ERROR: extent[31096832 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31178752 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31195136 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31211520 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31309824 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31326208 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31358976 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31375360 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31588352 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31571968 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31621120 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31670272 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31686656 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31801344 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31817728 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31834112 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31850496 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[31899648 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32030720 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32407552 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32423936 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32620544 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32964608 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[33013760 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[33144832 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[33374208 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[34045952 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[34209792 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[34275328 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[34357248 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[34455552 16384] backref lost (owner: 10, level: 0) root 10
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs done with fs roots in lowmem mode, skipping
[8/8] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sdb
UUID: 83f64b18-a2e8-443b-bfa8-78ff90dc86de
found 4034412851200 bytes used, error(s) found
total csum bytes: 3932948140
total tree bytes: 7073136640
total fs tree bytes: 2757738496
total extent tree bytes: 200310784
btree space waste bytes: 601929804
file data blocks allocated: 4027338895360
  referenced 4084210130944


