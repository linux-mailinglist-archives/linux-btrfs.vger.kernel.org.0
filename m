Return-Path: <linux-btrfs+bounces-7151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42A94FA40
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EF91F22C7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733419A296;
	Mon, 12 Aug 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RxfDjdGS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51E175D59
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505234; cv=none; b=otG6GdDHudQqR4f0WhluxWwz8vPLnGyrN8B/lb5lUxwYe4njxcg1PPlakGhvp5KWh13B80dKorZwwHdlkO0rihCnPWZ3f/83XW9IrClXt9SEzFUowZGtKJvnHqXiU4XC+y80M82JgTRdVzrAvLZ9bNX8Yea0fQmweGh7VxDmq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505234; c=relaxed/simple;
	bh=tvqcMueI8bhXuiqM6AK7srDyvkZ4Cq75Q/GFz5bTpX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDwq65iOnNr4vSeCV182e9p75/6UeVRpho38sV/dP9MYkDWQ6abVunDUB47nXQUXkOwt9h2/rEHFzyjXe1RsDR7KUF74BzqE4z5ymYxn/3fivOWIymg7pzLgVMaj1AW51ZOZEPjdcBXbSluCg0gwbQwluzq1iiDsx6t+FKnHQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RxfDjdGS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368440b073bso2931383f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723505231; x=1724110031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YD7cg+9/vEjihVTfP6GdSKzC4qTymdlhkccRC+5Gbok=;
        b=RxfDjdGSa3K+ujRxXnkcYKnsGfqygd+qRDiQThH1rOyn5mV+71MVllpiaehPL4AMF2
         u1xQ0TPuZ3wr8f5K3y/Cj7GKSTu5w7A8QMvpKwPHLsFEOmsp1oPkCzVa3KehxnMjFJay
         QnwaGMNVzmy5Jzr7P37hJP51gYHJoZNjS84x40pC5P3yLDp7p+MaYhe4EqtS74zSyjOJ
         a/Mkdj/5Y3IHEjeWjQjyTWO9Yv3EnQKTCblQMXLCk6bkYQJT8q7I7P8UdmMsFLJkTgh4
         XmKX7C2ALyQsJv9fjoJRe7eAKaTFva3GWKV5/Jt/pN0D/iO/Eq35BtZO8G8gy4FeAF+k
         4kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505231; x=1724110031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD7cg+9/vEjihVTfP6GdSKzC4qTymdlhkccRC+5Gbok=;
        b=fhNeytEzTC4Whje5dD5c/iakE50Zn7aYRvjSB3KQcJyHtaDBY8NsOmwEY2TaK6BpRx
         n5Liz769Hm+H6Tj+82movjoerLuEwnNFbcNCP8v80jwwrMGnM7SeaKw9NBtOfPCigQ9G
         D8A0o6WB4RFi0zrVQBYTYn3DIPA05KAI6xJKXGlKLsheZoZiwCYbgKkQLcACtZR0mXV9
         PeU10ra96yjyfREsuLBjBD/9z4NjDcnHknpmnQ8ac1F88tcggJzJrL4cREkeHjKhAFua
         HhQHCoMpwE4lUiNHPDp0q4D2A2EhvLyG8Z/AW+8flrsZZ7M9sw2GO7o9EoBKKPmVN5WW
         rQgA==
X-Gm-Message-State: AOJu0Yw4YNsYhWXjCGA528GBx3NwlPFul7tx9Ga9j71UmVKwgppmsfSZ
	2ynxxNFIkUlmrTiv++XFlBv93BY86VeFi9tzb0K5pJD5FYTW3mtD7QJEbhrv63c=
X-Google-Smtp-Source: AGHT+IG6CXy2Pt1GGArovitwUEAUTVVp2pZrsNj7gQT7hvcVDqW1OA2/mPl3SeDPLn1DldH7lvDWlA==
X-Received: by 2002:adf:ef42:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-3716e42b973mr806943f8f.17.1723505230255;
        Mon, 12 Aug 2024 16:27:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a99efsm4521191b3a.82.2024.08.12.16.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 16:27:09 -0700 (PDT)
Message-ID: <cd06772c-b4be-4416-9f0f-6d849146ffe0@suse.com>
Date: Tue, 13 Aug 2024 08:57:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
To: Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
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
In-Reply-To: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/13 02:00, Jeff Layton 写道:
> Unlink changes the link count on the target inode. POSIX mandates that
> the ctime must also change when this occurs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And since we decreased the nlink of the target inode already, updating 
the timestamp will not cause extra COW overhead.

So this won't cause any extra performance penalty.

Thanks,
Qu

> ---
> Found using the nfstest_posix testsuite with knfsd exporting btrfs.
> ---
>   fs/btrfs/inode.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 333b0e8587a2..b1b6564ab68f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4195,6 +4195,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>   
>   	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
>   	inode_inc_iversion(&inode->vfs_inode);
> +	inode_set_ctime_current(&inode->vfs_inode);
>   	inode_inc_iversion(&dir->vfs_inode);
>    	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
>   	ret = btrfs_update_inode(trans, dir);
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240812-btrfs-unlink-77293421e416
> 
> Best regards,

