Return-Path: <linux-btrfs+bounces-11186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDC1A2355D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3033A639F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832D1B3943;
	Thu, 30 Jan 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="12ItyyZ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F121196DB1
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270218; cv=none; b=YlQaSde357tlFfp1YOAh2Quv2DZMY4FWGgADo58jF1hNdSqDMYXLGK2n5TRRXAtjITA1X6L7ykcpEsVeNfPkZYdrp9gDMH7QiPxxe7ZONxe93WySyOZlwkBeKZRzia6gWbmPL9d12kSS8ymHpUbcUEmiDlMDbbxiqOsqgjst3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270218; c=relaxed/simple;
	bh=2VY/ViKDRyU6YXw9y0djerweNLV8XCRrM+62Sknx4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QspPAJsty9sjE6Vflw0TK5k48QzO1AmL5mOSEdK4V+55BWPFVCiROrDEKOZBFPXlbVcjf0bqrin6roVeBUO1F7+jRCssFGW/KdWZxPdAznCxaEnS6cIsjF36MiQAPE6dluSptVs+49MzLxjggFdWOGtO93f9lISNyADjm78Hvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=12ItyyZ/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-218c8aca5f1so11126545ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738270215; x=1738875015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNrCGgEqijIM4yxxbVALPZNjpU5BZk2lZn82e6B/5BU=;
        b=12ItyyZ/oYSea8Sju8WUpHuBtNUdBqNhw7Pz5PYQNXMd303ggBnWIReLMGSRCS+8rp
         /q7A4JTTdNPzn/EBuLotD2IQ8ugNxM6X0sXm4W0u6aNje5C2BRVl80xTxrJAfTYqyYkA
         i2cWgc/GkK7+VVL+vQ0oYG5ezvv45wFKyoFgaFX+JC0EieAqthzqFJW4wvL0sMgwTDKe
         9vn2Xbg62AuX58nybw/gr/HmPmJcoKUVjOpKf6166RfVWGTy3MGZ4asaysNBe7RDLJ7Q
         aBrYoDc8PCXBVExCbrkI72dtTY/YCldXnpnAHH74T2lsTnmer/cp2SnN8w3cF4lIPxUB
         yUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738270215; x=1738875015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNrCGgEqijIM4yxxbVALPZNjpU5BZk2lZn82e6B/5BU=;
        b=MtDOQicWm5Ca0wqv9ZC8VhUXMZCOSnPpQcFmfZecesupDZ+MGjmfPP2jckZwbFrv8t
         pGuthF1jnnjcBuyLXWDscENBuDr951VEf2jUCarIXV8d1PQLsXSkAjZwP1dkQEhNIuyX
         Ci3DMdUe+DxtRxxCqpA2T+A5mlClgVYkGYdjaROAcvYjoNBWc6Xio8EkMsQ9MO1bVQsI
         U2PStW1plf21LdF2Kuh8lSz4Fc1XDOQqmTlHLbvRicFg4OHrg95l4UJ+RwBgvvw9BNn4
         VZur+b4veQsuYNqURDC4++e2/hQMozz2ich7F14KYOw6B/zWLuNZPYJNq/GafgZkW4Lz
         pqLw==
X-Forwarded-Encrypted: i=1; AJvYcCVtphIEZL7yQBzizv+ikXT9DW43lC2BqlDrbbNZr0nADn99B0XC9p6wOJkbsCs7S6o9NAeT/C9bAVdiZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q69wVZoFzGN1HH22T1ApSrzxnVDauAc88xxuP/RDBCVkdU+2
	w0wuAWv9bKCtzrQBTzZqYFXxcJ6RpLVGjmSfALH4Yjjopgj1sa6BN3LRM6oLMtQ=
X-Gm-Gg: ASbGncuS0DnFnrUS4X+BJ/oN2KIo4zJRUSNxBL5lW31zgDXmTMfvi3cTc/jJeHqfe79
	QN5PnVn3bjzQHvOrNmvPLInUl4OcDtDf/7aM8TGVN1ZDIpP5pPetL8128d1GlpJtPkWdifmR8c7
	aBcbw1IwmfdP/dguyxMslFHp7ko9mapXaelpD3FAlZ9IU4ExAPkdkz6f92NWcLeDDWocKlDQj3m
	Z07oqhNCPWxk9KLZwryYAGT+I2SEHW8djQSWEmUTtn7YuxIJrKOarhuSP9dmsDZwJntB8rTHQP2
	o+ChCMkjo5tto0riMx4oxrytUKy35rh7stEN3jpla/OZ3GXQRE5nhR5dV22nWHOoXxI=
X-Google-Smtp-Source: AGHT+IHlfN1d22f6+db2vxdMJ7Z6v0jZYOuGsJSMpHBga2xHmYbZJRPruJUl67tofc6roF4x92wOjA==
X-Received: by 2002:a17:902:c941:b0:216:25a2:2ebe with SMTP id d9443c01a7336-21dd7c65844mr123458885ad.19.1738270214822;
        Thu, 30 Jan 2025 12:50:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee1efsm18190795ad.28.2025.01.30.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 12:50:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tdbUJ-0000000CZ0f-3T99;
	Fri, 31 Jan 2025 07:50:11 +1100
Date: Fri, 31 Jan 2025 07:50:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <Z5vmAzAEtzK_EuXO@dread.disaster.area>
References: <cover.1738161075.git.anand.jain@oracle.com>
 <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>

On Wed, Jan 29, 2025 at 11:19:54PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/329     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/329.out |  2 +
>  2 files changed, 94 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..9f63ab951eac
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# Verify sysfs knob input syntax.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_fs_sysfs read_policy
> +
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +set_sysfs_policy()
> +{
> +	local attr=$1
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy}
> +	_get_fs_sysfs_attr $SCRATCH_DEV $attr | grep -q "[${policy}]"
> +	if [[ $? != 0 ]]; then
> +		echo "Setting sysfs $attr $policy failed"
> +	fi
> +}
> +
> +set_sysfs_policy_must_fail()
> +{
> +	local attr=$1
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
> +			| _expect_error_invalid_argument | tee -a $seqres.full

This "catch an exact error or output a different error then use
golden image match failure on secondary error to mark the test as
failed" semantic is .... overly complex.

The output on failure of _filter_sysfs_error will be "Invalid
input". If there's some other failure or it succeeds, the output
will indicate the failure that occurred (i.e. missing line means no
error, different error will output directly by the filter). The
golden image matching will still fail the test.

IOWs, _expect_error_invalid_argument and the output to seqres.full
can go away if the test.out file has a matching error for each
call to set_sysfs_policy_must_fail(). i.e it looks like:

QA output created by 329
Invalid input
Invalid input
Invalid input
Invalid input
Invalid input
Invalid input
.....
Invalid input

-Dave.
-- 
Dave Chinner
david@fromorbit.com

