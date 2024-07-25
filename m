Return-Path: <linux-btrfs+bounces-6692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32F93C1EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D841C21BDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F719AA4F;
	Thu, 25 Jul 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWJAd0TZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95D199E94
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910232; cv=none; b=iC/i4ho6jPSJP05j5SFJ4O3VujTrHteg6JliueDzp0eUyDyeR3D5b1WMKAQq38ndVqHCUqLbGggVm7XjfWpXvWT/UkkemL89krX1ZNIJ4wKk4Epp7OYgQcgeRzpa7WXXICLPYbW1UpNQGmo1Tg6ehBQ32MMZoJdlaiVBYI2tTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910232; c=relaxed/simple;
	bh=zsB2sCo09VdrfozJXJkdqrV2GZKlDWLIXERP2xQgu+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNnDkqHpEOcKBl5c+v0MvkgXYg89ONcvCbBipT66E8z7EFbCyb0PnapmUykkrbLG87FtnWIDHvT8akSyuqY0FXk0Q6jDJGSK16nNiRDCG8vw5hawzK6793EUJSp2w/NiJ1bAYSfLo+H+rlmL7wk8nI4YtbLDTTLPv+HBuTeuXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWJAd0TZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEdajkh5S0gar9bqfcS3D4rN2qEhFoRjdGkhbB+sVmw=;
	b=CWJAd0TZ8CfcJcIJtyvTnm6DruutIPkobM2dRzrlzbk4wWBwhKYlJpiFDFbTpt3uyqhgIL
	g3YldOclo0+R8oXWpiYOP5+JFkE8hPPaQQPMrybxmwOGC6Q/FxdJLa41+1vQpFb/6hkW0l
	FDikkWvOM2bp5igZw7+nWjNeV1ch8wM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-iTLFsK-BP8Oh8TCHze0N_w-1; Thu, 25 Jul 2024 08:23:47 -0400
X-MC-Unique: iTLFsK-BP8Oh8TCHze0N_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42807a05413so3782205e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910225; x=1722515025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEdajkh5S0gar9bqfcS3D4rN2qEhFoRjdGkhbB+sVmw=;
        b=KhzHnaiA1LPMnCHg+3Vder/rrj3TUqgwo8v4/2YhOZmqWMVBwdZx2nmm6iT5beXeMe
         JiRA2s26f8HRDaBvaxYNFZ1G2+zpKQuwOaVh+LIlymfVINZpuwi8Q1Z/FH8uDnfijCRg
         YAr5etuLgn0/q2W4s7TaXiIL+eeSe1HapiSejPtRqyjH3wDNRSxF1Jn7z8dyr8U9gwUS
         TpjxMavx+J6Uttf4JNc8q0cxW0BLpnLTYG3OWQ77zagCbrkiHBON19hV2wKm/JKnWqd+
         25G96JeXkv7aXh/jerLbchjuGQGsu04KlULWrrvqvzG89Rc2vZhZ2LqKQjh7NpJQWEs7
         UuSw==
X-Gm-Message-State: AOJu0YxYARQL5OPI87lP7uqlmtmYiXINv1u1299K8M3Q0VFZVmalB9RB
	eEZE9LxDr8VdB6w82MiskAqozgQOw0QWbPQ6grqqJrzYiSrit9lyBO13kwnk5EglvAH7Mzy5D93
	0FP4nNYJ1PnaZb8qEpHZFdVcQJBWD/ghsCWqMAqZVnMXlc37alLWFrnHK91gR
X-Received: by 2002:a05:600c:4f51:b0:426:5b21:9801 with SMTP id 5b1f17b1804b1-4280574219amr15517285e9.27.1721910225251;
        Thu, 25 Jul 2024 05:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhzU4Z8/iFL/ffss3vB1bLp6J2Ri5LEqqWyawpNcW1eUsQ5Fcg78owTmEPYUebfozf+kH/zQ==
X-Received: by 2002:a05:600c:4f51:b0:426:5b21:9801 with SMTP id 5b1f17b1804b1-4280574219amr15517055e9.27.1721910224694;
        Thu, 25 Jul 2024 05:23:44 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1c0d:f9c1:fd6b:b3:d669? (p200300cfd74b1c0df9c1fd6b00b3d669.dip0.t-ipconnect.de. [2003:cf:d74b:1c0d:f9c1:fd6b:b3:d669])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862271sm2005112f8f.98.2024.07.25.05.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 05:23:43 -0700 (PDT)
Message-ID: <0192c705-df2c-4fcf-8385-4ece04e4ba3f@redhat.com>
Date: Thu, 25 Jul 2024 14:23:42 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Appending from unpopulated page creates hole
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
 <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.24 12:19, Filipe Manana wrote:
> On Thu, Jul 25, 2024 at 10:16 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> Hi,
>>
>> I’ve noticed that appending to a file on btrfs will create a hole before the appended data under certain circumstances:
>>
>> - Appending means O_APPEND or RWF_APPEND,
>> - Writing is done in direct mode, i.e. O_DIRECT, and
>> - The source buffer is not present in the page tables (what mmap() calls “unpopulated”).
>>
>> The hole seems to generally have the size of the data being written (i.e. a 64k write will create a 64k hole, followed by the 64k of data we actually wanted to write), but I assume this is true only up to a specific size (depending on how the request is split in the kernel).
>>
>> I’ve appended a reproducer.
>>
>> We encounter this problem with virtio-fs (sharing of directories between a virtual machine host and guest), where writing is done by virtiofsd, a process external to the VMM (e.g. qemu), but the buffer comes from the VM guest.  Memory is shared between virtiofsd and the VMM, so virtiofsd often writes data from shared memory without having accessed it itself, so it isn’t present in virtiofsd’s page tables.
>>
>> Stefano Garzarella (CC-ed) has tested some Fedora kernels, and has confirmed that this bug does not appear in 6.0.7-301.fc37.x86_64, but does appear in 6.0.9-300.fc37.x86_64.
>>
>> While I don’t know anything about btrfs code, I looked into it, and I believe the changes made by commit 8184620ae21213d51eaf2e0bd4186baacb928172 (btrfs: fix lost file sync on direct IO write with nowait and dsync iocb) may have caused this.  Specifically, it changed the `goto again` on EFAULT to `goto relock`, a much earlier label, which causes btrfs_direct_write() to call generic_write_checks() again after the first btrfs_dio_write() attempt.
>>
>> btrfs_dio_write() will have already allocated extents for the data and updated the file length before trying to actually write the data (which generates the EFAULT), so this second generic_write_checks() call will update the I/O position to this new file length, exactly at the end of the area to where the data was supposed to be written.
> Yes.
>
>> To test this hypothesis, I’ve tried skipping the generic_write_checks() call after reaching this specific goto, and that does make the bug disappear.
> Yes that confirms it, but it's not the correct fix but the inode was
> unlocked and relocked and a lot of things may have changed between
> those steps.

I thought as much :)

> I'll work on a fix and let you know when it's ready in case you want
> to test/review.

Great, thanks a lot!

Hanna


