Return-Path: <linux-btrfs+bounces-17871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D723BE1DF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0233BE53C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3E2FABE1;
	Thu, 16 Oct 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VPXkkEgK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C552F7AC3
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598555; cv=none; b=fZIvBcFbx96Zn10RlNu124qte+AHKk8n2mSkhzcGCGRw7q8YaV4yy3/Q0GHjDBEJv2Ux0SjsmBEUN4VsUMYRMazauvMPBrkRRZyfFsjt/V3qmbKmxYpLj0licNRW898mTQ/a2Hybgfbsj2p5XC3O2A7ybz4V6vV0JJAcGS4mjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598555; c=relaxed/simple;
	bh=5nHvZamFEkH9EvPLMXQNlxC9Wmfg98It5AsesLKv6IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChtvYSRvicdxdNnhFDEtnqWmmemk+NNiYN0BhoklivvYegFzxIJRk+GtrY7BZIapEBy439bzxrn0ZyvOztq3uTescdIeJrp492wi4en5rWLxq+gswVqVpHOqK/2UHDQW/4DGYorXqTgEQ5Bv0LvtPpVlILhMkLVjlT/bEvMzz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VPXkkEgK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so256971f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760598551; x=1761203351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSIMe5l7UI5vEmVvxSYex6af8FroTpoooyg2xvpjJIA=;
        b=VPXkkEgKEMfDprue6Y7x6YrDDLHmf5xRxdo6nR+Dvr1jfATXn0FyD3o+5KddxxtpuI
         OJSrDimp2j7UPHe7E64jcFtHSeTB3peCDFKbSS0Q4yDzJjFGcz7vSJjyrBVed8r5q5iA
         5l9lD0Mz3DwHxuXlcOnjcdbhc3X+m9R4b/8hCVVZwRw0qeAtGbgT+wlnKJh9JwYuMSft
         Ph2rKHRTF12wzaL41q5Ak3q+QsHWf2+tHcTCLucDv5c1/WbvYiWcv5hH1WRdiP7KJrAY
         /moyDk3dBvt2SNr+muqeS0VXZ1+/AMTToo1llrgFEt1PZ3SLwL1crdSqQF2wCMo0Xsae
         1TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598551; x=1761203351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSIMe5l7UI5vEmVvxSYex6af8FroTpoooyg2xvpjJIA=;
        b=n+9EmOoZ9Rjt3kM1HZziVsN7cWnTE1d4n7SABZvpjW53RpHh+SV8f+OJgzhWNLyPzB
         YcCRav3oKOrb9YnDXAxsdp+SmpuIMJZG2ptvkHEKYzy7q4fSdwfxtVqRCH/YUcyo3Ieg
         qb2CCg/MnlDF506kVzkfTHSiOJMuHa/4RUvAq8g4Fh1sIx/coJZy7Yea/wKGHa3OFG41
         7qdhQkacF6iMvXt8yRSWEUg5Wrq9FH9tvIlngLSOg2tNM6yUeQX2jyoAfzXItC2Fdaer
         LRzKA6w3cAOt0gxaeknA3MJqRqoBjfcCf9j8AH1GyelIaeVHvMB0N4Avndk6Rt/fgyvS
         /kJg==
X-Gm-Message-State: AOJu0Yypai+dFvi5FLNsmmETo/Xfg9RPPSmESubxJGwywLaGsZjWp7lR
	DfVNl5QVSdXwAuWdCc3LtXKIN7Z+AZ04UAGQKRiUDshJI8zcg1wjRLVmxB4PMTtC0IY=
X-Gm-Gg: ASbGncteh8fgS8qmpNWLLzFYCAL9wezO9M5aCnC4b3pw0jivd8lKh58rwWxrmMAV8+m
	hV2mSF0nfELEycebRQrgSkIBwk+cPPeNlmOquy80+Zg3Iui1POWvMEyL5IMfp8iYS1prYmi+gAQ
	8sjRbTzUJakm23+QUKFflXEllvZsrO3ynhnGi49AxSPEZHaMVH3Cvh3YgCYE2Bj8vqGPUGLFX9M
	6gjUihonH6eiF9ZgbfqmaE/JcnAzC2hER2qIBg1l18+0Zr5wmpnvoLnFidw9ciDGzolqhGjGNzi
	0oLPQudE2zAj0vlcrVakbQKoFiXdya1Gf7Ud5IQODS2lXPYjPIaeY7oPq1byTrWxv6O5GUI2pVM
	MdqfTZAx4nUaTiInlouaRr+IIzilk1gOakRYTLWUiJG5p4xcIAEz7yrDmwV4xQ6jantrMOJ6Smm
	6WwFamlUkdgJQvhSJwvWaZPdrS99US
X-Google-Smtp-Source: AGHT+IG3xHOgjpo7n0eMc01/ows8fVl/W9nPPptegztBLolxI1Z7VulTw5HECk2nkQioT21JP/vihw==
X-Received: by 2002:a5d:5f43:0:b0:427:151:3d9c with SMTP id ffacd0b85a97d-42701514223mr500660f8f.16.1760598551320;
        Thu, 16 Oct 2025 00:09:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099314ceesm18941095ad.16.2025.10.16.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:09:10 -0700 (PDT)
Message-ID: <51c7108b-19ab-499a-afdc-14e4a00431db@suse.com>
Date: Thu, 16 Oct 2025 17:39:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com,
 quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Vacek <neelx@suse.com>
References: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
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
In-Reply-To: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/16 16:40, Dewei Meng 写道:
> If fs_info->super_copy or fs_info->super_for_commit allocated failed in
> btrfs_get_tree_subvol(), then no need to call btrfs_free_fs_info().
> Otherwise btrfs_check_leaked_roots() would access NULL pointer because
> fs_info->allocated_roots had not been initialised.
> 
> syzkaller reported the following information:
>    ------------[ cut here ]------------
>    BUG: unable to handle page fault for address: fffffffffffffbb0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>    Oops: Oops: 0000 [#1] SMP KASAN PTI
>    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>    RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>    RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
>    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:1230
>    [...]
>    Call Trace:
>     <TASK>
>     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>     vfs_get_tree+0x98/0x320 fs/super.c:1759
>     do_new_mount+0x357/0x660 fs/namespace.c:3899
>     path_mount+0x716/0x19c0 fs/namespace.c:4226
>     do_mount fs/namespace.c:4239 [inline]
>     __do_sys_mount fs/namespace.c:4450 [inline]
>     __se_sys_mount fs/namespace.c:4427 [inline]
>     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    RIP: 0033:0x7f032eaffa8d
>    [...]
> 
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> Reviewed-by: Daniel Vacek <neelx@suse.com>

Now pushed into for-next branch.

Thanks,
Qu

> ---
> V1 -> V2:
> - Revise the patch description to make it easier to read
> - Delete btrfs_free_fs_info() when super_copy/super_for_commit allocated
>    failed, instead of NULL pointer check in btrfs_check_leaked_roots()
> 
>   fs/btrfs/super.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d6e496436539..dc95e697b22b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2069,7 +2069,9 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>   	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>   	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>   	if (!fs_info->super_copy || !fs_info->super_for_commit) {
> -		btrfs_free_fs_info(fs_info);
> +		kfree(fs_info->super_copy);
> +		kfree(fs_info->super_for_commit);
> +		kvfree(fs_info);
>   		return -ENOMEM;
>   	}
>   	btrfs_init_fs_info(fs_info);


