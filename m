Return-Path: <linux-btrfs+bounces-3385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0487F64E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 05:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38D1282D68
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1067C08D;
	Tue, 19 Mar 2024 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyC1NtZW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294307C086
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821808; cv=none; b=jNPEQ9XVM4RSgX3pCxWTPv0MaySDHMY17o1+zs3u864yUTIV8RJIcmlWEu8Rfq/SchICvk53qxo6mn7K9ocqHnDFWkGmF9yGPFdExksY62Eiqj34OwGYzt9wbV2ZVUuaqXe7+7ajneAR4Lf9U30bD3yLcvbCXo0W3YvT/ztP778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821808; c=relaxed/simple;
	bh=oBUFix4xJ9HmyXtK0FS0msR1Uprvu8MvzrmK3K0DUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnhu5M421tnCBpvX3zO/Ntt/C/Tr2hrXSmcm1CkO//Geptm+LpY55k8q1MaQUf3m5mmDi3kvWhlrE9SQdAeQDZ1BWSpM1eQDLi7N8ReiFDF0OGWgvNq55syAJ9xYNWcb7P78zzGXZMcN8xOiQM/7Ju5iC3bP7K9O9d8iMzJ0CXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyC1NtZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710821802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cFtfNnxEJ01CephbW6v2igIJA6n9Y9cgi1+keL4pqM=;
	b=TyC1NtZWbmIFZfXHoU+vFOy6+O1Hm8KZPiAB/G5uDU3UMPOeX2IoFvXd+sTwyM/WNygUl/
	e4VttoOc09927N16pa2EFNKDUf8G1RMgURaXw6frd/7HiptVoTu6VTCzMbPHWFUGcx/i1c
	Y4miyJak7+U1qjyzyu3ne1BbjArOAlA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-jl8D41O9P62GSygEcUXbOw-1; Tue, 19 Mar 2024 00:16:38 -0400
X-MC-Unique: jl8D41O9P62GSygEcUXbOw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso4508351a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 21:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710821797; x=1711426597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cFtfNnxEJ01CephbW6v2igIJA6n9Y9cgi1+keL4pqM=;
        b=VrmM6raZG8Am19yllVgXqrOLrnrKFsZ1cpdlESVQwz2EsaTjv5I8H6sZxu7Jvl5Mcy
         3aNTsmRbd+3KGmpvF3EfggfRq99owXWkffW6U8x4RI1SMICZpMLMnfNQN2WZCX88ASYA
         pEymi5fwVGecwOq4K0dXpji5QRQQi4KzNnW3/rc3VGTpWg5xWIX2q721vDb26urcsUEo
         kQfnpKOhWDMXpXjjGJA+PSnXzNS5D4tXXvhdho62TYSZLBGArpqFWSI01BXjOhdcKFdu
         xmzX5mKIh9+qsaisCsghucgezXuPb7p/Fqhf54j1/wcSOCt39mk5frE/a51zwX+0xnsa
         5M0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUhUJ9GpHw2Uwz8VssiCYHU5o3WZCaVdzrJ28M17f/TgnaWHqhyuYuamikTVaRwi2u4aWOO5hyq2IzmVz0zbBNA+FgfKyLtpIhiqw=
X-Gm-Message-State: AOJu0YwceTZXDK8ZIggO3AVd5dB5OXT15vnENlTzgrgDrksyQqbKhT+f
	PgGJDQIeKrHhMsWP6SgDNkSeYkoNBSNxzFPxLq1IOIbyyER9I4ahIPUKRwL5l44rO0XmHR/fMoK
	bdRuhK1NXinyph0jMZowBA05aIer7BeSz7iJWTT7Q/Ta8iq16JEZSLPi6dYtB
X-Received: by 2002:a17:903:28c7:b0:1e0:16e0:b28e with SMTP id kv7-20020a17090328c700b001e016e0b28emr1771082plb.34.1710821797370;
        Mon, 18 Mar 2024 21:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXqPBbawYv4+8ogQd1QC/W45is8KfuwC92ZEvUpNhC7nvb5U26hp8nT3MoMN1hCB0pmM35Cg==
X-Received: by 2002:a17:903:28c7:b0:1e0:16e0:b28e with SMTP id kv7-20020a17090328c700b001e016e0b28emr1771060plb.34.1710821796769;
        Mon, 18 Mar 2024 21:16:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t188-20020a625fc5000000b006e6f8e9ab6asm7247539pfb.15.2024.03.18.21.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 21:16:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:16:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318220219.GI16737@twin.jikos.cz>

On Mon, Mar 18, 2024 at 11:02:19PM +0100, David Sterba wrote:
> On Sat, Mar 16, 2024 at 10:32:33PM +0530, Anand Jain wrote:
> > Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> > test case btrfs/312, which assesses the functionality of cloned filesystem
> > support, can be refactored to be under the shared group.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v2:
> > Move to shared testcase instead of generic.
> 
> What's the purpose of shared/ ? We have tests that make sense for a
> subset of supported filesystems in generic/, with proper _required and
> other the checks it works fine.
> 
> I see that v1 did the move to generic/ but then the 'shared' got
> suggested, which is IMHO the wrong direction. I remember some distant
> past discussions about shared/ and what to put there. Right now there
> are 3 remaining tests which I think is a good opportunity to make it 0.

I didn't suggest to make it a shared case directly, I asked if there's a
_require_xxxx helper to make this case notrun on "not proper" fs, not
just use "btrfs ext4" to be whitelist :

https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

In my personal opinion, the "shared" directory is a place to store the cases
which are nearly to be generic, but not ready. It's a place to remind us
there're still some cases use something likes "supported btrfs ext4" as the
hard condition of _notrun, rather than a flexible _require_xxx helper. These
cases in shared better to be moved to generic, if we can improve it in one day.

It more likes a "TODO" list of generic. If we just write it in generic/
directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.

What do you think?

Thanks,
Zorro

> 


