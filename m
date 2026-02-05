Return-Path: <linux-btrfs+bounces-21383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHJoDloihGkDzgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21383-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:53:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D30EE97A
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC0130156DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6872C1585;
	Thu,  5 Feb 2026 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0s5+GhB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B1267B07
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267221; cv=none; b=cQaSFBQQpfDsuB/X1GHEuKN13pSPxXC1kkfUTLgBRsFrM+P8cTsZh9wR7ib56jfg8YnEhK0x0WfEL38v0FLPkK7zPWCCK1dFk2myYntXbOG9or4C8PLZsXpzb47z2Dlv7CjLVcjtvOvwMTBVIlU/L0o/cMY2aSFWlbD4GilAgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267221; c=relaxed/simple;
	bh=96blYaM31HJ7iGVnXsRVZppfBU+xZYHcQR3Y+L+2gLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOa5Nqp4veTqGp/9R6CVn9pFxNuNNfRO211eWncfmnN5ueD/Fnow1ns4yJDmOXPY+W/mOc+keNInTmj81/0114L51QnJRTlCps2hIGzp+taFMYoO+zOm38wC0SE2NhSCMrrRSJwwx9wWZ4dPesqIF7nu5FeoZmtT+EzLRWlO/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0s5+GhB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806bf39419so9200645e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 20:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770267220; x=1770872020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg5nOnVVeBqW7h91BcXpkmorLdsklG5hg0521rEKVa0=;
        b=d0s5+GhB7nye1cGLTF3/k0GVT0SbyRjIoPdgBFeOypJXUiwjZaInCHhBM8FPowNb/K
         j8I9EFUa2I+hGFsaUCt//KXmIAJ51RId8Lhy90E+0QCQkEYzr+rNShuB0AVjOhZzVvsn
         eQ3tcyGQ6V6DHZcMqq3B+rh+WL6LfuIbwKr5TeWTFO2Jo75slB4KVRseLcQrv+G5hH6V
         H97FiqDSmrX75AE9eUM90G6Th1HO9aHvQm4R9RIZvaUHpBhzY6DFShTvQdXukj+zgO9b
         fcd6ZG69q2TZuXebK3yBYvcgGNQIDwh8iHqZ36MAlaQzcaklR5kzNDAdhqVhjZAlcUcB
         MAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770267220; x=1770872020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg5nOnVVeBqW7h91BcXpkmorLdsklG5hg0521rEKVa0=;
        b=dFpxQpPeyyjaZh6DSKyHDGJ/W+rfTc9aMcf04HAHYhKSxV7rHgnZMzMPn53QHOemw4
         at0Qsqc5dj5arONPXXjASaHgFcrUHmOLMa9FyvrXfnUUqbUzbvvcmi+snvDEi3dGsSBB
         ysDA0/q9oRRu9CW74PYJ9/AujBdo8w4IX5hGO+rhFbFG4ZBpVjjEmcoqBzS01pJQyUiq
         xKxdCk0h3WBwGjK9zNRjQnVBoJM4Wihv7Eq3SCOt2hkdowUjLVFClVDQsbE4Xpe3oGhe
         kVQOIYoKXtMp++9JlB9T5KRv7m5zRj+XNKKt2RuhBJTNmLdRdlOcO40hZIdcgclYs7C3
         rHeA==
X-Gm-Message-State: AOJu0Yy0WP7q0buzc0wJM/pZzjcbchwChuuKE4eH6dGWmFUcC2mtrOhm
	AYvBd8/RRPso7RQGDfhAKeQ0VfygcQehb89/bVSiBieCI68HfT1aMsDSBYzPYfil5O2oTKvEXOP
	IVkNy9sI=
X-Gm-Gg: AZuq6aL2fHzByjDPhbVrcvy+hVzrBdfMBAZdZXtA5Hh7UfCyKEhpoSF8SJHkh+GRwSQ
	7+L60ynGt9zjE/1Rm0iZs1eyuAzOlFvMnPpfqX5RN1KHcLI+lRtcS9StM9BcnG86xCfA+/mZxQ/
	7gEmh23AWUB+0oEzQMOggbcApibqT2MEN08XYkiu/AEZqmKJeKBwX+qlzsZE2sm3mtbpsPsrnw3
	oAh1Rg6jIJpytLGI2jYpquPpmx9rGH8M3J/ag4c+QH+6B7gwr78kMf3V+Ib6akdPGyJi+aPKqM4
	DvpyVIhI0DM1ibS6aYJnZpptiJ8H9319WZuWUYtolXhs4MJQYc1PuHLWYFRkSpCSeWiZkZY3emD
	UzpufsivrIrgP7VaSQPVoeWuSksLEAm3keRFn8UaL0FbK358wULqiWj4rxIPwxlzSTGKShPZxOF
	rYFG6lyQkJcmyzWEWMBtjU38r2QK4iAMfdI+PKxsw=
X-Received: by 2002:a7b:ce17:0:b0:480:63c1:3ac7 with SMTP id 5b1f17b1804b1-483178e3012mr15281395e9.2.1770267219507;
        Wed, 04 Feb 2026 20:53:39 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933854321sm36969375ad.3.2026.02.04.20.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 20:53:38 -0800 (PST)
Message-ID: <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
Date: Thu, 5 Feb 2026 15:23:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21383-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4D30EE97A
X-Rspamd-Action: no action



在 2026/2/5 15:20, Christoph Anton Mitterer 写道:
> On Thu, 2026-02-05 at 15:13 +1030, Qu Wenruo wrote:
>>>
>> That message only means we're parsing the "clear_cache" mount option,
>> it
>> doesn't really mean we're rebuilding the v2 cache.
> 
> Is it really *only* a "parsed the option" message... or did it actually
> clear the cache?

According to the code of v6.18, it's really the option parsing.

> And would it now cause any issues if I have the cache cleared but no
> new one was rebuilt?

Unless there is something wrong about the fs that has a free space tree 
but without the proper compat_ro flag.

Mind to dump the super block of the involved fses, and may be the root 
tree too?

# btrfs ins dump-super <dev>
# btrfs ins dump-tree -t root <dev>

Thanks,
Qu

> 
> 
>> Normally for "clear_cache,space_cache=v2" mount option, we will enter
>> btrfs_start_pre_rw_mouont(), and it will set @rebuild_free_space_tree
>> to
>> true, and later entering btrfs_rebuild_free_space_tree(), and
>> outputting
>> a message showing "rebuilding free space tree".
> 
> checked for that message... not in the log :-(
> 
> 
>> So by somehow your kernel didn't go that path. I have no idea why
>> that
>> happened.
> 
> It's the kernel as shipped by Debian (in unstable)...
> linux-image-6.18.8+deb14-amd64 package.
> 
> Any way to find out why it doesn't rebuild?
> 
> 
>> I guess for the worst case you can disable space cache completely
>> first?
>> E.g. -o space_cache=no,clear_cache.
>>
>> Then retry with v2 cache.
> 
> Well... *if* that's safe to do... I'll try it tomorrow.
> 
> 
> Thanks,
> Chris.


