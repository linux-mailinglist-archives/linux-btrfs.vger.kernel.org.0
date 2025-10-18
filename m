Return-Path: <linux-btrfs+bounces-17997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23570BED0D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FCE406B35
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015EA1F03D9;
	Sat, 18 Oct 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvTeiHwC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DA42AA6
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760796331; cv=none; b=awb21hbE7b4IjzvEG9xhebtxrHUtpWtGYh27H25pK6b3ThBCndprxRmd6h6LdnCW6C+U4Ra04ImJI/UBqkC9oULmcAhsLTYNBIKMFQ+Jb/HBnoJXCGCZtzdg5UywY7CngbiAbBqAGvjzEuQ5u97SLl2jtchf5bbtUJMO+rOowgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760796331; c=relaxed/simple;
	bh=VjP9NuW/CobZTSxmZflLMUjqw7SjbBzZHVXQVkXKk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orbGYXJZmbfTG4yCCxoSPuwVwQ7P2Oqub7PNCN8iOQIVCNSaE3nTEUdcbk8jBj/hQ2rBBAmkOanMdwKrT8tq/n2BJ5xaJJ01A4xYkMDleYuKlMSZ7MngQYLEcfAdJ4c+7QsI8bXSJRnAl+4SFIRaMy/7WNsbuN7bWSyeZsU8I7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvTeiHwC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760796328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhSauSM2IFyBlTKpDxEEF7KFbZU2eE7CTjj0cSZwp7k=;
	b=QvTeiHwCGh06tFbyuO4Nl6rNKOs/wGBV0ISGzEZd5S6hOQEFNXne9zQ8YTwSJgPmum+qdF
	FB4+QesL9m1Ybk670duAMTUzf+YImtxL1oRKKchMuM2ap7QuKi4rSdp8ik1tuf7QF49nc0
	vzmNVF0GbjJwh3iQKE8n6pQ33y62Lss=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-XLPU9oxTO1iCrFXvRspEdQ-1; Sat, 18 Oct 2025 10:05:26 -0400
X-MC-Unique: XLPU9oxTO1iCrFXvRspEdQ-1
X-Mimecast-MFC-AGG-ID: XLPU9oxTO1iCrFXvRspEdQ_1760796326
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d75897745so736297a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760796326; x=1761401126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhSauSM2IFyBlTKpDxEEF7KFbZU2eE7CTjj0cSZwp7k=;
        b=uCdmN4jTVGXK1caLpVTbvSJMyx8Ft3BmylWOUAK77Fhys5u7pThq9AI7BvYr/dP1zP
         SuAt1nJpNMnMaE9E8uDI/OvvcFlSRbtrYWSE1+8lJFpwR/xT3jqMepvIAQOqwLhc+WfF
         dXZ5AhIlW0fUeUNz7vLKuJZFC+TKllxoRbGXcuk6ejjkNefDLbjMZqlYhLvGfS/OfUXi
         HGeOiRBBBJWD7D9Ca8/DEmOk2nZ/L7tqmvkpS/oXIJq0YUi4fTnkAggztf3B1zfPYoYu
         ytdNsarBS/gHJ8ItpPOp31EAPfj0pBsn32fCvMepnh6hLHekyHFOQYOgqETc3mPGlC9X
         LtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtqs8+aU33xETzMEgCV1DdMmAbBYUT5LoomtAaSnkoMGFuqWGzyn5uf1+RyrDLW3KfG452fEoa0BxxRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBgBH6uU4GLgQG/wjIG87PHNYotSZmTuUR2BvvPrrwVQRp3pH
	te5VzHNqioMf4H0kCFI8HpLz7NFg65fslF7B/72XhlwXM+JMBKtk5TabJTSaKR1xCZQ3/2u9iWd
	Z6bbmq1TXpWLPTkHZMkwMxAcDho0VPP9SN98Def6J9YaH8o/nZCF5MZhVupxQ73NX
X-Gm-Gg: ASbGncuB5sBI0dclZ0nXJkvNQ/NCW/gzeLNawvZ9N+f+XqOG4tAmrqw3YQ/pQ4+2ZE1
	E0FnEJSBSj/W49mh7/dFhu4/38T/sFW0QBB5FR9oZfQDZjxsnnp2WUsWhqIPca1AMMmjHGxGl36
	T7trRb9Rv+ccMzMGet1SprTyNskO68qIRiDEeYetuidYUOdnQC5QAnizG+zN/Z/F/sfrw/8RNGm
	7XsWhWij5Lvic/6M4KpgCASl0edHdAhOzURP9FNjokkE+FA2eQlOlyCaYTSbvZ8szVugxU126zm
	ENzpYrD9e32O7aqN03jJMetjnWL9kW4ELBAWV9AgqtD9jeHPjFB+CNZosIkGyKMy7lePrpX50fp
	qSKLm/T8nHN6/OM/p6/Lg2n07JDIKKuM3OHOHRSU=
X-Received: by 2002:a17:90b:2d8b:b0:33b:c172:6b1a with SMTP id 98e67ed59e1d1-33bcf87c4d6mr9992953a91.12.1760796325744;
        Sat, 18 Oct 2025 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8P1OnvVde6Urgu/5G/IcNIm4QzhIalGuckBWRj7z3lbY2W8XWPFOFmdKeThbLievb//Hz4w==
X-Received: by 2002:a17:90b:2d8b:b0:33b:c172:6b1a with SMTP id 98e67ed59e1d1-33bcf87c4d6mr9992890a91.12.1760796325279;
        Sat, 18 Oct 2025 07:05:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f254esm2894383b3a.45.2025.10.18.07.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:05:24 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:05:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>

On Sat, Oct 18, 2025 at 11:13:03AM +0000, Johannes Thumshirn wrote:
> On 10/17/25 8:56 PM, Zorro Lang wrote:
> > Does this mean the current FSTYP doesn't support zoned?
> >
> > As this's a generic test case, the FSTYP can be any other filesystems, likes
> > nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
> > If not, how about _notrun if current FSTYP doesn't support.
> 
> I did that in v1 and got told that I shouldn't do this.

This's your V1, right?
https://lore.kernel.org/fstests/20251007041321.GA15727@lst.de/T/#u

Which line is "_notrun if current FSTYP doesn't support zloop creation"? And where is
the message that told you don't to that? Could you provides more details, I'd like
to learn about more, thanks :)

Thanks,
Zorro

> 


