Return-Path: <linux-btrfs+bounces-12978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D120A87734
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 07:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45306188D902
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 05:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD91A0BE0;
	Mon, 14 Apr 2025 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7V+wLqP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40A7E9
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744608192; cv=none; b=FRE55NmtBqh14PH6Fqoj6WMASR+snMwuENHLFaQYMEBT28f1ZAH8zpT1k4N2mu5ktgeMX2r6TeO4HN45s9tDWPTK3GTNZSd1ZeHLR5rSEeVVXn5fuVLRAtlcKY5ahCr81oJ3zPa8RGge6NmamW6r5G+OUwImEm2nvYpt5oRDf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744608192; c=relaxed/simple;
	bh=0Byl6qpqj4TRR7ajTVv/QePynAzOm2YDyHX2hjG8gcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgmBcKa9hSB6zp/E5C8BEe/V+ZL5T5P0359c8qYlJGNofR3yil2BtgJPeLCKIEnJF127nPKySkC+s+ltpQYPvkW5ZqCWihGofzEuM6TotJrg0gF89T5iqhJwzZazsl5Vxn5SgcMXN6QXnxzuRMGH7uwhzIqMxK4osyUTAOJDlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7V+wLqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744608188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gF2teFVfGAxFn8r+dTFnUpErSC9eX1TYiVavCB7Zkc=;
	b=i7V+wLqP9WW5pRRHV4kKfXeEJKXZmsEDuKb4ZKsEgWxwEn0kaoC6jAzVUm6TWYYj5qsQWw
	5DS0tw87+O6pkxn7I58MrjreYJIkUs+jvqufPbJ0j2yDBQWkPaRyTJz//If3VTbRphi9aC
	9GCIX7AXijxIAzx+Gy2J4TtVUhkZSlk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-7GbVCdezNziJnxugrFIVKA-1; Mon, 14 Apr 2025 01:23:06 -0400
X-MC-Unique: 7GbVCdezNziJnxugrFIVKA-1
X-Mimecast-MFC-AGG-ID: 7GbVCdezNziJnxugrFIVKA_1744608185
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af91ea9e884so1985624a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 22:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744608185; x=1745212985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gF2teFVfGAxFn8r+dTFnUpErSC9eX1TYiVavCB7Zkc=;
        b=oVdgGZx1Ku4RLDdcCTe+Nv3F2OHGUkVUSBhfA41TMu4KnE/HvKzpVHWFwv0Kk8At4w
         Gim+/TByrvoGuBQYQSkxqIQ+zUrMbgTcApYAvDZiLDUpZnsImgFxGnJ3YCnfo6TYlnuG
         xAYj8YkKy2md4LS/tkhLQTC0rIQZrE5p6VlTS47aijweCe0Er/ILsRd4XIF0GXnuNvu+
         VACsO47907uSQ9p7P1/jdRbZZz7dMrT7a24AYTt2+iTBWwt+3996V9MHhOK5LxmN9xKf
         dz06+SM9IlIsJLpJ8YUlBTp6tpfOC+dDHfWNP74TT0L8+b8M5ScSdjcetyRVjV9b+gKo
         6NRw==
X-Forwarded-Encrypted: i=1; AJvYcCUMEnPn8nU0w4A1KVEycDJu61hMGN1WWlhNf8K56/h/KhKnsI0ExeAkoTIeq+x5MuIw2l34SzzfzPyByw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR17gZOx4OrTxguNPVNDT/BSKwpF0oXN0DClzhlA7lAtKz9p4d
	LThzQ2rwWAFOn70a3wiR6t9p94vkUV14+4PKxrfFzukXX4WzqH9jK8b9MNqarPDXdUh23UddwWf
	XgwIv0R3cYy+5aJgvnnuHTO9o6buuFfdqgE0ExDMKw97ZHnfbXDaFC61yNNFaNwVhEa/ZEZM=
X-Gm-Gg: ASbGnct6AgxUuT+0Pc58VoQZpSpKoGEXqWXaDe7OY9G1nESc80Qn2ZU0QLq0GT/aVct
	01T1K55cdVx/knTqWEDL7IpHxuPGlsTn2EbVfrcv8tGyefIl2HXxuVGDTGPn1G9ajK9/EbdRKnF
	rWmf/qBoNWbsU21mePpyfVAt5y1NtT+RaL7UqDxzkk+uEpbesFULb/OCVH7tOlNcLFMlHEap9Wd
	XL1xFtwCZMhKjhQ/+NzkVf6z7DzeJneBh8LEbbnA2nPpDGZLHNiMzEUYJ66/Epaw95hheCKrbjo
	e5pokqMenxQ5nxunwBiwajnP14Rua/NmL0b6B9MDxO674l8xxp70
X-Received: by 2002:a17:90b:5744:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-30823672b84mr16575195a91.11.1744608184996;
        Sun, 13 Apr 2025 22:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3qtP0FLxev6e9FnRB7hnYTsjV+SgtTG5oQjHTMLHSiKGOmsMRs3FqyMJYe9JyPPEWp+54Q==
X-Received: by 2002:a17:90b:5744:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-30823672b84mr16575175a91.11.1744608184618;
        Sun, 13 Apr 2025 22:23:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a71fsm10245136a91.8.2025.04.13.22.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:23:04 -0700 (PDT)
Date: Mon, 14 Apr 2025 13:22:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [xfstests generic/619] hang on aarch64 with btrfs
Message-ID: <20250414052259.ldxjeiamj2l23bwc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <17cd9240-99eb-49e1-8843-0a80a18f8ac2@suse.com>
 <20250414042322.ehea2rb5g5bo34zq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <31bd0214-955a-49a9-a4ae-f102044fcbdc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31bd0214-955a-49a9-a4ae-f102044fcbdc@gmx.com>

On Mon, Apr 14, 2025 at 02:09:59PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/14 13:53, Zorro Lang 写道:
> > On Mon, Apr 14, 2025 at 10:05:21AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/4/13 22:23, Zorro Lang 写道:
> > > > Hi,
> > > > 
> > > > Recently I ran fstests on aarch64 with btrfs (default options), then I the test
> > > > was always blocked on generic/619:
> > > >     FSTYP         -- btrfs
> > > >     PLATFORM      -- Linux/aarch64 nvidia-grace-hopper-02 6.15.0-rc1+ #1 SMP PREEMPT_DYNAMIC Sun Apr 13 01:44:03 EDT 2025
> > > 
> > > Mind to provide the kernel config? Especially the page size.
> > > 
> > > I guess since you're running on nvidia SoCs, they are pushing 64K page size
> > > already.
> > > 
> > > At least on my aarch64 (our for-next branch, based on v6.14-rc7), I didn't
> > > hit any hang here.
> > > Neither any hang in my older runs on aarch64.
> > > 
> > > And my test is done with 64K page size and default mkfs options (4K fs block
> > > size, 16K node size).
> > 
> > Hi Qu,
> > 
> > Thanks for looking into it. Although aarch64 supports 64k page size, but my
> > test kernel was built with CONFIG_ARM64_4K_PAGES=y, so
> >    # getconf PAGE_SIZE
> >    4096
> >    #blockdev --getsz --getss --getpbsz /dev/sda6
> >    20971520
> >    512
> >    512
> > 
> 
> Now this means it's no different than x86_64, at least for the page size.
> 
> > The whole config file is large, I paste it at the end of this email (hope it's
> > not out of the size limitation:)
> 
> I'll try to reproduce it on aarch64 with 4K page size.

Thanks, I'll keep testing on latest mainline linux, to check if this issue
is still there.

> 
> Meanwhile if you can reproduce it, the early "sysrq-w" call traces will
> definitely help us a lot.

How "early" do you need? I can add "echo w > /proc/sysrq-trigger" to generic/619
source code, just not sure where do you need?

> 
> BTW, you can use attachment instead of pasting all the config into the mail.

Oh, I heard some mail lists don't like attachment, not sure if that's true :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 


