Return-Path: <linux-btrfs+bounces-22243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P/2A45PqWk14AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22243-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 10:40:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5F20EB40
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F1531506E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A13793C0;
	Thu,  5 Mar 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG2lEdIy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BE37B01A
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703160; cv=none; b=Rxvg/JCfB73LMT3O0m2pTU+puSmXMmn2Eb4Z55L/lb7KIA9SARgP+IB6tzsVdkNpNEelie/IwLItQdpqZe/OVfm+TE2jbr+8PrqENWRuT8aL08EPE7Z4tl7w1QiP/hml7cVd1wPATR/1oK+zjCRYhAPsTi1+qn4fQtjIxs6dSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703160; c=relaxed/simple;
	bh=NTI2sbNqmXefHVl9iq5aGjDsfbtqWEWb9pGbTAhKmbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QzCnDXp5mE/pwoglyyYhibSocMmIuY73fomL9ij2Oo85IMdUonSKgPHObuD3ZGTylX5YzCZfYDBCgEkqmr1RNDNCHfQKKqzpdNoKYByPYhDkG6Ov+iwF0Ba+sMMATDQTQIdB31pwMIfSq3HOCAJcKZJQLhTwjE77PtwtlIoTIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG2lEdIy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3598cab697eso2515309a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2026 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703159; x=1773307959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YxMc0zSq1+O+4DI+93m766Ua5MlZWmUYfipBYyLeUE=;
        b=jG2lEdIy5LvJPs9ufYconitWsAzUepVcBeFffZROeOIiGrQMWX+lg1xNcV0ysHOeOd
         UNE/WsDJg6zmXXuuTVEuKbGjEV/8jkjrA/QJdTgqK0ecEaS8Vl+KK3r9gUzIhRSkqWOP
         sn9mljtddmD57o8sxB9KZHD0bz9P17aMkHZRZnp4T7iUa34JwE2yfWQHAhYVZip998M0
         Ogf6dT+VdBW7oLqCwJuuTeTnAW+XCNIzloKLmthAgYnnTR9EZe73MkdozmwGHS+OPn+N
         BrINXtX4gGKpwyg2B4XzgNQs9ySmN4paKYyNOo426Kn4NiajOQh+hUrK3piCVaAur9Ta
         o1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703159; x=1773307959;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YxMc0zSq1+O+4DI+93m766Ua5MlZWmUYfipBYyLeUE=;
        b=gikWPywGZXmRR3pUfUiisMkMPeiCronlHMW91qqoY4SSvK05SJFyGfXbwGhrSmYEGq
         9OFyHvuvE+/itd1zilbASBybMGp211xXyh3A0ribtDyBdwsCd4w37GTMblj+LAuvMm87
         IuOdM9BHx4bh5iO1IAlite+1c3YsP6ahnapBzD68YQEGawLNH/cxUW2Ceh1mSL2ByiqR
         Uwf1nNopqT/HDaT33N+gllnpVYYkZ6uiOaNGn93vMpAEkyOpCRbm6z14R+MCQWa/M7xd
         hzwXjlzbnFOn8drRtZNcAZf+DXcNKnBBBsQGJEpod9X/hJg2w9JE9DAZsEMWjcozkdiu
         pFlg==
X-Gm-Message-State: AOJu0YzN7HCAPZGLumv7kSBtzZtX8PzXbTTL1vEsjwMSiF5qfmqRvxXG
	gPf8Yt4arHkv/LzGSRS9yw3dEplEiHyHwUR1+AQeT/Y0PB80NH5FSS8V
X-Gm-Gg: ATEYQzwwCdQHmRVUWvuUp5H0FPJMOXxYnP26QANBg3lcYJKWBVaZWpaYxvDteIzr9au
	XADjghZ3nJeY3b3mjkaOq5mhFTxxqvPwW2qDxsmVsIxBUKNtB3GsFsWUvmIRzUX7RIhfgynwIt1
	zhHlO5IX5VdWfPVyOfAHDjcvcaLe2OiSvrhtXZu7xvCAtEO5te8lpUWaY9MOjm6RaqXoLi6BLwd
	FTOgFtfnhpJq+clZKFQOPVThUy5Q+ydl58eM+D64sEp9eq++e4yO2gh5VMucA9zZcslrPRzq2jX
	uBRmysZrqCXS+aqszYNCUgmKXZv5wQybTBm7uyFebuZJT98iYybCkyPgGiDPwKndoMQ8Hs0tQKx
	RlYa3s5SfcYY6AYtvx+1LJI7BqWH5GFjvbs8NtxyocIZLoXSL1ON9WzJl2AEfpm1TThlNR3CF6q
	x+K1fEgvtKLqd4ayj9L46I2VrCi1k=
X-Received: by 2002:a17:90b:5102:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-359b1ba0e7bmr1521475a91.1.1772703158842;
        Thu, 05 Mar 2026 01:32:38 -0800 (PST)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d2b1c7sm1899251a91.4.2026.03.05.01.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:32:38 -0800 (PST)
Message-ID: <9078e07d-5997-41f3-9991-c1f6975c768b@gmail.com>
Date: Thu, 5 Mar 2026 17:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anand Jain <anajain.sg@gmail.com>
Subject: Re: [PATCH 0/3] fix s_uuid and f_fsid consistency for cloned
 filesystems
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <cover.1772095546.git.asj@kernel.org>
 <aagzcbj_CohXgIXe@infradead.org>
Content-Language: en-US
In-Reply-To: <aagzcbj_CohXgIXe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61D5F20EB40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22243-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 4/3/26 21:28, Christoph Hellwig wrote:
> On Thu, Feb 26, 2026 at 10:23:32PM +0800, Anand Jain wrote:
>> This series resolves the tradeoff by aligning btrfs and ext4 behaviour
>> with XFS: f_fsid incorporates device identity (devt) to remain unique
>> across clones, while s_uuid is preserved consistently matching the on-disk
>> uuid.
> 
> While I like fixing this up, switching the f_fsid construction to a
> different method might break things.  Is there a way to only change
> it for cloned file systems to reduce the surface of this change?

The problem is that we won't know which filesystem is the original
and which is the clone. Generally, the first one mounted is treated
as the original and the following one as the clone. However, f_fsid
should remain consistent regardless of mount order, at least for
the duration that the block device is connected (or until a
system reboot).

>> Patches
>> -------
>> Patch 1/3: btrfs: fix f_fsid to include rootid and devt
>> Patch 2/3: btrfs: fix s_uuid to be stable across mounts for cloned filesystems  
>> Patch 3/3: ext4: fix f_fsid to use devt instead of s_uuid
> 
> I don't really see that patch 3 in my inbox on linux-btrfs.


My bad, I sent the btrfs/ext4 patches only to their respective
mailing lists. I'll copy both in v2.

Here it is:

 https://lore.kernel.org/linux-ext4/e269a49eed2de23eb9f9bd7f506f0fe47696a023.1772095546.git.asj@kernel.org/


Thanks, Anand

