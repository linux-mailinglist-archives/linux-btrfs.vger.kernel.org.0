Return-Path: <linux-btrfs+bounces-2650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A28603B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 21:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408011F26A25
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43096E602;
	Thu, 22 Feb 2024 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HyZhTj9A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640444414
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633968; cv=none; b=VYU9JkfhVIXIPmlYDbEaxUh8C6PKgaVRydPa+/e3hau2JejFUfRAhq9azaFlpM3Z8v0OWXfxGlRBbmMGX4Tiz+r8f7Kyj3LdauHis1s2Kd221xklm57GhYQ01nEFnAXYWWNLjqmPkxtzDhzaGu0BM87PyYseIKipv8hiM+jUosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633968; c=relaxed/simple;
	bh=2GeDByVcyZwoSCjEJ2IgupVFlKtUweGESljAzB1rfho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0tbFk2O9ZVhh5RgbwU84XnJgJVak/nI5DXK2dJ7irXiyGEQIzjEW02PQEtiTgdNVy3RRqaCLqXqbpfDoSyEOhYAJrVVnAz86Jwmu4Ts5799v29W4+BJw7hqNQxwR+U2tGIkuywsed4KxfLwG91u2cerDng5v1NHop/EQzaHU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HyZhTj9A; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d23114b19dso2820171fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708633964; x=1709238764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k00FHEga49EJbIZWCcIEQrs8Vm4fiz3nzVBOMywvEIc=;
        b=HyZhTj9AmTa2QQ1kLoc71A0eJjMLANiMEkoJanjBgOexwFckF8B3qEG2xTNpclzcEm
         e7hGXj6uewBdwDvgqTASW2mK2Sto5zRNMzVBODxqyC0Fc+qfOCHdxLqK6hEHmTpjrESS
         YhqKI+QC+YU6Lon3f48ReEB4djYo3Cgt9Veegpvzm21YIRW1dB+p9FnjOUmuIlPSpCTl
         zNmfgqMkD6OvYSWbjjBEaivzN8ldMq+Ah5NNcpFOraniF9ghhGodh3waiKnf1ds3vvzq
         RWwyt2zyy/7s7eIiTeM2vylevmAwZ5TgTN76sPPj6P2U6KEm2TcDZO9hHnlnJlul/33N
         vIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633964; x=1709238764;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k00FHEga49EJbIZWCcIEQrs8Vm4fiz3nzVBOMywvEIc=;
        b=lpWec741SbwyvbHSjN2Agk35yGtJBHlmE4GtP5ENDzRWesPxQEGQOnJhCrSMDgxONl
         rY6u78l+jqPHiYeJfOwGRU2dV8lrWhGS9e7JHnCcyFoZK/SzcIaKxMzLU6fUs7jHybDB
         6/RcylIoxyl9XBUE8joiysB20Wu3KdXfjZuYsVEtNwjRlKuWYoZ2b9GTT/iKVjcszdAV
         YuvxXo0U5wHMV4vKrjeFDXhlMkhWP4q/NmCBOGuhn5o6vRel5Kd5ISKX2xO+ZWVhUxeU
         +6fWpJuFAnPcIaUFX+gAEZ4rnv0ajpx5TdUI+xS2p79qvtf7Rl4xqTzYAynVx0uJmBGB
         N4AQ==
X-Gm-Message-State: AOJu0Yzu0DidPisNoT1yhxXWgLrpAalGJ8D2zxO1iwbQ+J8wcVbRKT+c
	A7BHCVR0zJDZHcu7GMSGcyReTsymp44bv26vpA48Jxfdh61S4DigOrr6WV7neUgOXqeEnXdH+5+
	dkxU=
X-Google-Smtp-Source: AGHT+IEWtf8PMzd0LM0TVHZAd3HQlH02Q6PP/CHeK3rvIYR9MCxI0xlAscDiFt1cOwvzUqjXMzCXHQ==
X-Received: by 2002:a05:651c:1030:b0:2d2:6ae9:3eb9 with SMTP id w16-20020a05651c103000b002d26ae93eb9mr88558ljm.15.1708633964479;
        Thu, 22 Feb 2024 12:32:44 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e20500b001dc1088357asm5925350plb.1.2024.02.22.12.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 12:32:43 -0800 (PST)
Message-ID: <d40c1cb8-a4f6-44ca-a5a1-2b598baa521c@suse.com>
Date: Fri, 23 Feb 2024 07:02:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: compression: remove dead comments on
 btrfs_compress_heuristic()
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <6ddea79ce1701adca117880a492a3e08282e318c.1708572619.git.wqu@suse.com>
 <20240222104656.GM355@twin.jikos.cz>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240222104656.GM355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/22 21:16, David Sterba 写道:
> On Thu, Feb 22, 2024 at 02:00:25PM +1030, Qu Wenruo wrote:
>> Since commit a440d48c7f93 ("Btrfs: heuristic: implement sampling
>> logic"), btrfs_compress_heuristic() is no longer a simple "return true",
>> but more complex system to determine if we should compress.
>>
>> Thus the comment is dead and can be confusing, just remove it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
>> ---
>> Furthermore, the current btrfs_compress_heuristic() looks a little too
>> conservative, resulting a pretty low compression ratio for some common
>> workload, and driving end users to go "compress-force" options.
> 
> We'd need the samples of data where the heuristic is too pessimistic but
> the compression would work.

Here you go:

https://bugzilla.proxmox.com/show_bug.cgi?id=5250#c6

Thanks,
Qu

