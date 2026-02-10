Return-Path: <linux-btrfs+bounces-21586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNufA8LvimmwOwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21586-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:43:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D711851D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04DD430459C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C133D6CF;
	Tue, 10 Feb 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq2+zdMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44032C949
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713008; cv=none; b=CylDRfdny9+6Pj2lcTJQ3gQxN4aagcZ9ZPPgzCkvlK7r9/ou/YxI8x2YohTvLTe2qYh4zcD30vUx/tNR17Kzn/W72aA+xL9CDt0uNMyl9C+KT99JbdAPTOrEDlhQX5zMFPErc4aEY6xff++H0wmH1L2flos2KYwdyg7VZge46oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713008; c=relaxed/simple;
	bh=Pr9nRycdxoc//fNTPViwz8OG4Ku81qb0AGYpsY6KZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EYru6DNuwopulGdjh8RK07lWZlCXycCYx5OLC/fHeF/V3StNOdf1M/t5fDoANuDzuHdwexP4cQjqm4fQ2xAMx7lEn4RAMh/pOVAaCd44iGlBW5rIB1K9lQVnCqwzqvCtsulNmDm762B2hUthBhZsHai5315/eTjkRLh8v6RAbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq2+zdMF; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so4780725e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770713005; x=1771317805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI+qmGEV3K9y9s6cZ8oVhrw4MxnWzMdbgj2AbEOu01U=;
        b=Fq2+zdMFccJjxBZoDQZdelIvV93+d7rHWBHX3bqVVnuMBs6WO3rOeqxynvLwaXO7+r
         VEav7oUggN7ruy3ZO/rwz7op9jYzqaoFY6fiWHmVFiFWpsNNzoCnyi2ei2u91o8KKAhK
         R0raqzI4IortFoTkT1dC0WaAFIaq/ld2Dn3kL2w5/8XXGrQkUzk282Q3+pQ64152EEKF
         gInfleZKW7YbNyTKp73gJNRuXyhNJZp/WIasl1J2irbafqTe5pYBHBEfDvZfSl/3WPJy
         iiTgW2JXVTZl+exXZwg7NHnXHeYEJ1uIj6Srjfz5RGoqw9Vh2CllEGbVSyBxTI/DLvgK
         5dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770713005; x=1771317805;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI+qmGEV3K9y9s6cZ8oVhrw4MxnWzMdbgj2AbEOu01U=;
        b=QAOVf9BKl7ULulKgyB/KmITV8dEtS/ccr8t2solZ2aZliylSZzJMxvuz3gwiktkanc
         u/Bm3TcDy4Wj/gWQta7imrYGeuLV1MbB6CnTonehiSfMuuTzM/Y5CHLmRAzhGumgflFC
         L+QM5NDVEbtrHiY9ke6A8DteI1J7SeV+RXjDTSOMv09AwSYnXNYL+aj6FnT94HD7sXTw
         E+6vg9l1qi2EzOXnWpzdvAMX+vRglK/TzaUJdDkqND2MuXT4RkFJj1vlnX02aEdxqm6d
         t3j2Em0P9YlpufhcjWY8vOLE/hE+G0a6NeF5s1fyqXqZxEOG2RQEGuSavu0wq0tikQF/
         GP3Q==
X-Gm-Message-State: AOJu0Yy4m/1QOTa/2y9tUKbHmLIgpPwTmpgc/Db2RXnjQQHkiCkdLe5W
	ubJl7aT24Tlq5JGUdzkrzxwnUt1x0jZiALEmJoqHnVWjkWRn3uGYoSvLAKW5QNO7dEQmewKALI4
	3hTY6
X-Gm-Gg: AZuq6aKaVCuLpWiR5xd2HWgjanG5sRT/s8BSTdzFom+o0Db/gkotRUHknKQG/I6rK2e
	Cfy+JZRd3dme3E6XwO3UQ+jK95zRq1UO/PoXS6ddtd5pu0BEoGq7SPKfDWqJk4C00BsMNArkwRI
	DvNADOsEx7l8vfL6Y3lCOSHYVJOWhlUvTvrBJ7VL2WlmF93rhFVN3rSiP0ThdhiaglYLrjDvmgL
	o0Y3eEFCoiskhQvKUYy7iEMwe9f0070aO4CvzyqoYxMFf5uMX/aSQSb0VKwl9z8rqlntj3hacdo
	ZQ+FeSZO5FOjERhipFx7I2KNTBfuUK0IX8SUkhgmjOfr8DKO8PUXte+4Jie6oAmcZJgyN48D4Xx
	YcsyE55EP/nVWeTtd3ONcnlQd5tvlFk32TJeXkcI4Tefg2TBhTTjNFZPqQ+zIaJZjGGPj6QgI5m
	fLP8MhpjI2vy1Orbqr9yDxieZbvOToZ7Njv/TSXd4=
X-Received: by 2002:a05:600c:3b83:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-4834a956702mr44488295e9.13.1770713005462;
        Tue, 10 Feb 2026 00:43:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d53c3sm49773385e9.7.2026.02.10.00.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 00:43:24 -0800 (PST)
Date: Tue, 10 Feb 2026 11:43:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] btrfs: tests: zoned: add tests cases for zoned code
Message-ID: <aYrvqbjR7S0RtjSI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21586-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A22D711851D
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
Hello Naohiro Aota,

Commit df321b214f62 ("btrfs: tests: zoned: add tests cases for zoned
code") from Feb 4, 2026 (linux-next), leads to the following Smatch
static checker warning:

	fs/btrfs/tests/zoned-tests.c:68 test_load_zone_info()
	warn: duplicate check 'zone_info' (previous on line 62)

fs/btrfs/tests/zoned-tests.c
    40 static int test_load_zone_info(struct btrfs_fs_info *fs_info,
    41                                const struct load_zone_info_test_vector *test)
    42 {
    43         struct btrfs_block_group *bg __free(btrfs_free_dummy_block_group) = NULL;
    44         struct btrfs_chunk_map *map __free(btrfs_free_chunk_map) = NULL;
    45         struct zone_info AUTO_KFREE(zone_info);
    46         unsigned long AUTO_KFREE(active);
    47         int ret;
    48 
    49         bg = btrfs_alloc_dummy_block_group(fs_info, test->bg_length);
    50         if (!bg) {
    51                 test_std_err(TEST_ALLOC_BLOCK_GROUP);
    52                 return -ENOMEM;
    53         }
    54 
    55         map = btrfs_alloc_chunk_map(test->num_stripes, GFP_KERNEL);
    56         if (!map) {
    57                 test_std_err(TEST_ALLOC_EXTENT_MAP);
    58                 return -ENOMEM;
    59         }
    60 
    61         zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
    62         if (!zone_info) {
    63                 test_err("cannot allocate zone info");
    64                 return -ENOMEM;
    65         }
    66 
    67         active = bitmap_zalloc(test->num_stripes, GFP_KERNEL);
--> 68         if (!zone_info) {

s/zone_info/active/

    69                 test_err("cannot allocate active bitmap");
    70                 return -ENOMEM;
    71         }
    72 

regards,
dan carpenter

