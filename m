Return-Path: <linux-btrfs+bounces-6900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B19422A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 00:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A71D1C231F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC61917E8;
	Tue, 30 Jul 2024 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QE9ZmdwO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA11917E4
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377880; cv=none; b=MIJ3UmandrNPXFD9KKYepneW94O6PdXQi3/IduJ9YDDZek/OPDnrCCDAzcfOLBGodc8tN+hSGR8Jdzq58FvIfEc2414786yI3gzRV0yC24fuE4MKi5wxQLoWyEziV4aNPtaC6posMilm3q611xplTj7SlB/723SwFZGOePDPP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377880; c=relaxed/simple;
	bh=kQNBZViW6FdRGRUHXJxTZ9xgPE9IbaklY66Y4FmG3u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc6z2T+mqsvS87S7jdVQ8jPz5hHQFXnAc8PjUI5gvR8xecslGT/QzX91xpG3wCMOMonvDz9sAkQOipMFXZqEnoke2Fz3MiCF5AXdNZXqMUZ5biofku+SnFIybmzLidXvZaNbOpb9Djz7aJoWU9JTalPx2ERfg2seyD+6CKGZ3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QE9ZmdwO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3683178b226so2334223f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722377876; x=1722982676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/dnf3HxJeleucSVnYfsQoQmthePST81frOySCTXq7s=;
        b=QE9ZmdwOkioQxigtrq8FuosWdwULobHCcVe0YMY6PjZcXI/0IbCYl/eTpE6ityLZC2
         /3ppmWMyHDtdE116U9w6xiu9OHrDG+P9kIDhwIW2SeoqwaTd9r16T5xaGu7ufC4zig6c
         mLqjEciCemiDIzctSGyvYKG/zUxOrF9L1XPptmY6E8f5RxUkqRKmdFB0qYbcgbEdU+iX
         hlxO69353ZdPDKMiPCumFkU9yymReeIgZyNTLoeJddhYPu3Am7RQClA7n9Ca8h64oAPT
         qReGjJEMKb3gW/2T3P1rIeDwgSPIlD2QArWJrJ/8oNO9PD92zWukGwUG5DZlQR4q9a/I
         wa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377876; x=1722982676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/dnf3HxJeleucSVnYfsQoQmthePST81frOySCTXq7s=;
        b=Ed3+uT7vpH+6hmIjF/cz+c+jH5Gk2/4t/nkUW9aBexX2XjaxRrq52ajPP8cjNPziXu
         IUJPwvCLMCyfX9/d2wKpkkb4qAhfc3HYia4XYUMWhtqvGeRegCDsyct2EGlAqSGv6uJo
         qp5M+Os+xyak13FsyQH8w5rnIHpyBD2pcB/glxAKy0AilD47x77IL/nKbjj19G9Dz7U0
         2gAdgbTs/r6EJYWtWMapiN/y0ykwCff52OfbDJI6bj66W1/rQASHA5/ftlgFiR//mMr5
         Uny0jDqXMwUnEyZXhTd6kHlgj7YklAK4o4nvagQnRYfNBO6Uy7eW+1Jxq6ym7LguHE5a
         PdoQ==
X-Gm-Message-State: AOJu0Yy2oe3PzqS7zNOClZTGB2UGmTDHIIJve2MjWTmmJnxJA//EQHWg
	91CWGeu8yGBWUmc8DfloBOso1w/uoZGtxqACZyOy6WrSmtQ4Pu663aRqMM3X2ww=
X-Google-Smtp-Source: AGHT+IGZuRyAXs0qnSDGjy5N25gcwYCM4pKck8pVw83BsjRsoLDkomzZ4RDky5xRfpelFsuL72OimQ==
X-Received: by 2002:a05:6000:1289:b0:368:78ed:994c with SMTP id ffacd0b85a97d-36b5ceeec80mr7307406f8f.17.1722377876219;
        Tue, 30 Jul 2024 15:17:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8751d3sm8900547b3a.168.2024.07.30.15.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:17:55 -0700 (PDT)
Message-ID: <aaa0e841-fc2f-458f-9561-c7116c8a646e@suse.com>
Date: Wed, 31 Jul 2024 07:47:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1720159494.git.wqu@suse.com>
 <20240705145543.GB879955@perftesting> <20240730135538.GC17473@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20240730135538.GC17473@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/30 23:25, David Sterba 写道:
> On Fri, Jul 05, 2024 at 10:55:43AM -0400, Josef Bacik wrote:
>> On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
>>> This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
>>> DEBUG builds.
>>>
>>> There are 3 call sites utilizing __GFP_NOFAIL:
>>>
>>> - __alloc_extent_buffer()
>>>    It's for the extent_buffer structure allocation.
>>>    All callers are already handling the errors.
>>>
>>> - attach_eb_folio_to_filemap()
>>>    It's for the filemap_add_folio() call, the flag is also passed to mem
>>>    cgroup, which I suspect is not handling larger folio and __GFP_NOFAIL
>>>    correctly, as I'm hitting soft lockups when testing larger folios
>>>
>>>    New error handling is added.
>>>
>>> - btrfs_alloc_folio_array()
>>>    This is for page allocation for extent buffers.
>>>    All callers are already handling the errors.
>>>
>>> Furthermore, to enable more testing while not affecting end users, the
>>> change is only implemented for DEBUG builds.
>>>
>>> Qu Wenruo (3):
>>>    btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
>>>    btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
>>>    btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()
>>
>> The reason I want to leave NOFAIL is because in a cgroup memory constrained
>> environment we could get an errant ENOMEM on some sort of metadata operation,
>> which then gets turned into an aborted transaction.  I don't want a memory
>> constrained cgroup flipping the whole file system read only because it got an
>> ENOMEM in a place where we have no choice but to abort the transaction.
>>
>> If we could eliminate that possibility then hooray, but that's not actually
>> possible, because any COW for a multi-modification case (think finish ordered
>> io) could result in an ENOMEM and thus a transaction abort.  We need to live
>> with NOFAIL for these cases.  Thanks,
> 
> I agree with keeping NOFAIL.  Please add the above as a comment to
> btrfs_alloc_folio_array().

That will soon no longer be a problem.

The cgroup guys are fine if certain inode should not be limited by mem 
cgroup, so I already have patches to use root mem cgroup so that it will 
not be charged at all.

https://lore.kernel.org/linux-mm/6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com/

Furthermore, using NOFAIL just to workaround mem cgroup looks like an 
abuse to me.

Thanks,
Qu

