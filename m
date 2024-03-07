Return-Path: <linux-btrfs+bounces-3048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033B874719
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 05:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C761F23985
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6614F7F;
	Thu,  7 Mar 2024 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="Gde+LiyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-108-mta154.mxroute.com (mail-108-mta154.mxroute.com [136.175.108.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B45EAD4
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784823; cv=none; b=ZFfvPeQ3J9FJ7IcHQ/DS2rh2UCl/qB3BuhsGkqu9g4fiUQBkeBngH0lAKPf38+jDJZeeYNaOptibjqUG44WXle5/YNSsb2jDsxLEjASnSzYW1XmMFqTP5O/HJOyEDubhTYH0fWKeO87jfllW4nnTI+QW2U5f6InhHfaY3awat7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784823; c=relaxed/simple;
	bh=SvbZ3QNs71f4okbEweGI/xImazctbsLjTwy4tEJ7eVc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=tho20nF2IYATVuW1D+d9If99j4s4uKGyRS/ZAt4tSBpI08Jg5/anNUhzKLoSh+5bboK7Qc5akZC3IP3S4fcLvDwnueodbW59u8ZKuq/9Crv6lwAsshJ7TgE9iV2E0/JMmqZBKv9qEFFotn1ijArWeRuYYW+iHKWBhNjCo3GOxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=Gde+LiyV; arc=none smtp.client-ip=136.175.108.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta154.mxroute.com (ZoneMTA) with ESMTPSA id 18e17192fce0003bea.006
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 07 Mar 2024 04:08:30 +0000
X-Zone-Loop: 17382e2d55764fce1dd7f11308d81d4b7612e3dd23e4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zfW0G4Ck1nPduZV3AIhvDTPqneIV5TLVZym+M3wgt0M=; b=Gde+LiyVS4qXvI3rhPjEPakDgW
	yF67YLS+uQMjKcjRYzO4TYKCXJupHYBEZ3XT5GLCiRLsuUIfsMBgf90yIrCvzMM6Dk2kRNOUIhqE+
	DWL117G+HE4ULoStnuctuK6ebwQwHjEqoWwJoPfJ15yPpu+kNgrJX11i3JJqiR4MVxHDVD2OEipDa
	YRoFrnjD5fQPET3SGKvKhnHaQOdngyVBYCLkNkRfNS2QlswMdnpkek2G8MLx+exfovySIScXUCAB+
	WHW9ZgCzeIyyHmuANgH3IdSxcx8LAT1nbZ98aeFnCJwmYIpsUOANFAD9+mSAD4yApVLNNQOAMBHWC
	Lwb963Dg==;
References: <20240216102550.46210-1-l@damenly.org>
 <20240225162212.qcidpyb2bhdburl6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Su Yue <glass.su@suse.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, l@damenly.org, Filipe Manana
 <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs/172,206: call _log_writes_cleanup in _cleanup
Date: Thu, 07 Mar 2024 12:03:14 +0800
In-reply-to: <20240225162212.qcidpyb2bhdburl6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Message-ID: <zfvar8hx.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Mon 26 Feb 2024 at 00:22, Zorro Lang <zlang@redhat.com> wrote:

> On Fri, Feb 16, 2024 at 06:25:50PM +0800, Su Yue wrote:
>> From: Su Yue <glass.su@suse.com>
>>
>> Because block group tree requires require no-holes feature,
>> _log_writes_mkfs "-O ^no-holes" fails when "-O 
>> block-group-tree" is
>> given in MKFS_OPTION.
>> Without explicit _log_writes_cleanup, the two tests fail with
>> logwrites-test device left. And all next tests will fail due to
>> SCRATCH DEVICE EBUSY.
>>
>> Fix it by overriding _cleanup to call _log_writes_cleanup.
>>
>> Signed-off-by: Su Yue <glass.su@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>> ---
>> changelog:
>> v2:
>>     Remove unneeded comments for _cleanup.
>>     Add rvbs.
>> ---
>>  tests/btrfs/172 | 5 +++++
>>  tests/btrfs/206 | 5 +++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/tests/btrfs/172 b/tests/btrfs/172
>> index f5acc6982cd7..e5e16681ec21 100755
>> --- a/tests/btrfs/172
>> +++ b/tests/btrfs/172
>> @@ -13,6 +13,11 @@
>>  . ./common/preamble
>>  _begin_fstest auto quick log replay recoveryloop
>>
>> +_cleanup()
>> +{
>> +	_log_writes_cleanup &> /dev/null
>
> Currently we need to copy the code in default _cleanup into new 
> _cleanup()
> function, if you need a override, e.g.
>

Sorry for the late reply, I was working on other things with 
headache.
I saw the cleanup thing you mentioned in v1 thread. v3 was sent. 
Thanks.

--
Su

>         cd /
>         _log_writes_cleanup
>         rm -f $tmp.*
>
>> +}
>> +
>>  # Import common functions.
>>  . ./common/filter
>>  . ./common/dmlogwrites
>> diff --git a/tests/btrfs/206 b/tests/btrfs/206
>> index f6571649076f..d9ce33b659e7 100755
>> --- a/tests/btrfs/206
>> +++ b/tests/btrfs/206
>> @@ -14,6 +14,11 @@
>>  . ./common/preamble
>>  _begin_fstest auto quick log replay recoveryloop punch 
>>  prealloc
>>
>> +_cleanup()
>> +{
>> +	_log_writes_cleanup &> /dev/null
>> +}
>> +
>>  # Import common functions.
>>  . ./common/filter
>>  . ./common/dmlogwrites
>> --
>> 2.43.0
>>
>>

