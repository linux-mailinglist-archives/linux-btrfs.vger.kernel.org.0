Return-Path: <linux-btrfs+bounces-8658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D9995849
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172B2289E70
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A83212D23;
	Tue,  8 Oct 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="TJLOe4Jr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514120A5FF
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418868; cv=none; b=mJ0k+riAmQtAThfHNTizdGkYWxXri+VcELgZw1/LL4qnYHhjHNge+B9sSnL/+bzOr5+HAyDOfkiCfZrxSiCM/TIWdSjp3hG4X3xRl4xwyIzkYVEy7pqbzag1luJQFCmbm1F7uSU2N1CZ8E+ZShoeaR7zPU9ZnM9lBW9nNXtAdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418868; c=relaxed/simple;
	bh=2P/UeiA5DGcXYvftHf96SH/KM0NY+7bWoh+JDyu0mvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz2ybwp2g/DU9WHCOQDNrnzOvor5VbUH6aaoAumuy1HGVcI0m4Ka891HpR1oqaIUk9xFD//qBFo4FfvQKkzp3ObAtLpJgn9rqAO399VGvp9TZ14p0oQMSSJu8+PIAxWxyHHQMy5We3RB+A3Vm80gFCau9Auxgp/VKs4ntrgv3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=TJLOe4Jr; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728418862; bh=2P/UeiA5DGcXYvftHf96SH/KM0NY+7bWoh+JDyu0mvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TJLOe4Jr6qSLetJWI6BumsgEe+P5K/5sEhGoDmWj4mx8d1mojus7B8kuL8L6xziWf
	 nh6oEekeNZ5tLt39jzzJxEnb36jJuXw7BAu9hvInQEmKei2xICj6t8gPNMqBSez3Lz
	 kpBUCxy9vFc9UvImA2ey0V+vFoHvlyemocIDoXahv2Eelc8WU5wML3koGUKfGnt986
	 nEep5dFVZpSW9rkTlxNb/y1hF+DFfvir7OvgHhf+x74bWZTl6yhpNcNvUOKgpfxClp
	 n3zQdREdlHvl5R2HnJ2I+2EhgsffW6IaMek5DjW36pMT9efP1lAIrjlN+D+EHVKCY6
	 0AyHB1a3p9krU7DeKgDmfyxNxPex7nXAgGIht4LzJI3D6tdoEUvR+fbtsR4W0SlADJ
	 yYkU7oOOmMQxl/MBM/ICcJ6XhjocWbVtW/0IaApGu5BliydY2/LJyubwMD50BBD4Y8
	 GNgsY6sxNj9h1F4F9UFSX0gaWCK2dv+R9FCc2LXd+beB1ZDzCtoow4rajGtt8PDbRg
	 Y6nhv1txKo0grKFRGWXOr/OonGZFtu7tMi74xFhajjVaoW+374D4ZKXlO9BqkEflWi
	 /t3cGz6uURNsTEOXtHzjCWUEwbKs79svwJFHBJZVamJbyDiubyvkLv5gXve/oXyUpY
	 nkBn1BOVRgoDCAR5ezOCDTHo=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 4707118D984;
	Tue,  8 Oct 2024 22:21:02 +0200 (CEST)
Message-ID: <ffe53748-0375-4901-9b83-62e4fe49ec69@ijzerbout.nl>
Date: Tue, 8 Oct 2024 22:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] btrfs: fix missing error handling when adding
 delayed ref with qgroups enabled
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727342969.git.fdmanana@suse.com>
 <7e4b248dad75a0f0dd3a41b4a3af138a418b05d8.1727342969.git.fdmanana@suse.com>
 <f6a720b3-65cc-494d-b32a-50a2991929a2@ijzerbout.nl>
 <CAL3q7H7WvUbQB99GtYTNQvr3oSb3tMJZMdq0v3DRmyPehj1gPw@mail.gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <CAL3q7H7WvUbQB99GtYTNQvr3oSb3tMJZMdq0v3DRmyPehj1gPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 08-10-2024 om 22:03 schreef Filipe Manana:
> On Tue, Oct 8, 2024 at 8:39 PM Kees Bakker <kees@ijzerbout.nl> wrote:
>> Op 26-09-2024 om 11:33 schreef fdmanana@kernel.org:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When adding a delayed ref head, at delayed-ref.c:add_delayed_ref_head(),
>>> if we fail to insert the qgroup record we don't error out, we ignore it.
>>> In fact we treat it as if there was no error and there was already an
>>> existing record - we don't distinguish between the cases where
>>> btrfs_qgroup_trace_extent_nolock() returns 1, meaning a record already
>>> existed and we can free the given record, and the case where it returns
>>> a negative error value, meaning the insertion into the xarray that is
>>> used to track records failed.
>>>
>>> Effectively we end up ignoring that we are lacking qgroup record in the
>>> dirty extents xarray, resulting in incorrect qgroup accounting.
>>>
>>> Fix this by checking for errors and return them to the callers.
>>>
>>> Fixes: 3cce39a8ca4e ("btrfs: qgroup: use xarray to track dirty extents in transaction")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>> [...
>>> @@ -1034,8 +1047,14 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
>>>         * insert both the head node and the new ref without dropping
>>>         * the spin lock
>>>         */
>>> -     head_ref = add_delayed_ref_head(trans, head_ref, record,
>>> -                                     action, &qrecord_inserted);
>>> +     new_head_ref = add_delayed_ref_head(trans, head_ref, record,
>>> +                                         action, &qrecord_inserted);
>>> +     if (IS_ERR(new_head_ref)) {
>>> +             spin_unlock(&delayed_refs->lock);
>>> +             ret = PTR_ERR(new_head_ref);
>>> +             goto free_record;
>>> +     }
>>> +     head_ref = new_head_ref;
>>>
>> There is a chance (not sure how big a chance) that head_ref is going to
>> be freed twice.
>>
>> In the IS_ERR true path, head_ref still has the old value from before
>> calling add_delayed_ref_head.
>> However, in add_delayed_ref_head is is possible that head_ref is freed
>> and replaced. If
>> IS_ERR(new_head_ref) is true the code jumps to the end of the function
>> where (the old) head_ref
>> is freed again.
> No, it's not possible to have a double free.
> add_delayed_ref_head() never frees the given head_ref in case it
> returns an error - it's the caller's responsibility to free it.
>
> Thanks.
OK, but ... in add_delayed_ref_head() I see the following on line 881

         existing = htree_insert(&delayed_refs->href_root,
                                 &head_ref->href_node);
         if (existing) {
                 update_existing_head_ref(trans, existing, head_ref);
                 /*
                  * we've updated the existing ref, free the newly
                  * allocated ref
                  */
                 kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
                 head_ref = existing;

It's calling kmem_cache_free with (the old) head_ref, which can be 
repeated in add_delayed_ref
>
>> Is it perhaps possible to assign head_ref to the new value before doing
>> the IS_ERR check?
>> In other words, do this:
>>           head_ref = new_head_ref;
>>           if (IS_ERR(new_head_ref)) {
>>                   spin_unlock(&delayed_refs->lock);
>>                   ret = PTR_ERR(new_head_ref);
>>                   goto free_record;
>>           }
>>
>> --
>> Kees


