Return-Path: <linux-btrfs+bounces-6825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010D93F49D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83757B2351A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9201465BB;
	Mon, 29 Jul 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl1vzxff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2914658C
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254056; cv=none; b=qFTbVQ56kLrSZaZGHA+F5kJ9fGxDstSjgJPJjmknpyarLF2XXNRzVP6JBxTgKfeqD561f+2O5VlHEhCIHSKkTurdKULtF8t2OTY7JbxAdS4uIrxvgYXlHNg6sleQNoP4Hs/BS0Su1a77lkvwJXs9Y7l1MZC8afjFSLmk8J2AZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254056; c=relaxed/simple;
	bh=EKijWOvLLsqY7bUTe7PVtwAaqlpyfEWMeKgG9qADmxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDaE9aU0jojZjX0CkBsqqHTZ4LfCsPx57tHE+eaF+1lVhG68Ywm+EBNGRZ4hYtqpt3l8OEOuuPs/DZXbj8VFouYKE/40rt93EEPFzOmeLcMiWPmiesqFnEoKof3OlONI/UjIGwovLT11A2YUvd2Sra7Nf4kfVV5J+ld5b1dKmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl1vzxff; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722254053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXePJtt7hByyZsJDLFJwf97e9ppdYM7Bp/sPZUTEVkg=;
	b=hl1vzxffIFxMSwEHyQXVsnLUaDFdmqFm47kvStxucDb0+jlcG6YBXvpc8Wz3dWtCjFtNfd
	QJucOEM6u5VubSuao88Byxr0DDAqar1ciopTaJnTjznKi0r67Qw0tOoEwHVP8RNCZxukt6
	JaHK6Y+IQF3cddsKYECkz75IElYlSao=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-nUCkkKKgPuy7jog54Uft_A-1; Mon, 29 Jul 2024 07:54:12 -0400
X-MC-Unique: nUCkkKKgPuy7jog54Uft_A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3687f5a2480so1313565f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 04:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254050; x=1722858850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXePJtt7hByyZsJDLFJwf97e9ppdYM7Bp/sPZUTEVkg=;
        b=qqi9+T/Wo4/F2QDe5Ub/8c+flMw6arf+irgkNkiWv4dl6lTKHojDMC0SAUfnFbvAAZ
         OPmbTUh7E8AAqJk/bsGJizdPRe1HepTH2KpgW/tn+w4L4HOj2x5eH2sfOZI9Xb+jgHbE
         Kvvr2ftqUMU+eFAH53NC8VtHuSvxXvJjKbDRPbChtCoLlbuMUDksYnhlVNjr3P1tRAh5
         hl+ffdXsbryAwdmcy1AiOy/5p8H7WBWQETU+PwbULMFsZ7yom0kReV8iroNF1wWfbCUT
         W85ohZyjn6J1cuK1ZJs5xskMNalFxKNEvV2oDAsd10tkiPnvGfgURKbc5NqTx53S2FNI
         7ZMA==
X-Gm-Message-State: AOJu0YyXTrhE9fq40bUUPHi08P1iRKPik9XB9I88tz132cF+xhfEy2uT
	dOljByYARrThpr5oRdvEVTie54RRLHDphM53J7P7H7DRBWUDbzygmrAeHt2MoyFTpatyvb031T8
	HlyNraaW1M77behAY1iEfGF0eghgZhs7TB5dX4XSDqYW7N5Jy1HGmVrPvnI5C
X-Received: by 2002:a5d:42d0:0:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-36b5d0cd9a7mr4440001f8f.60.1722254050306;
        Mon, 29 Jul 2024 04:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7jxnR4oGGgddl6PPIWG++DXTUO6NVdLmxeui3+ar7Gt10C1QjgyhkEuXlE/BzKPiUunD4YA==
X-Received: by 2002:a5d:42d0:0:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-36b5d0cd9a7mr4439982f8f.60.1722254049566;
        Mon, 29 Jul 2024 04:54:09 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1caa:cdf6:6c58:632f:797d? (p200300cfd74b1caacdf66c58632f797d.dip0.t-ipconnect.de. [2003:cf:d74b:1caa:cdf6:6c58:632f:797d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9a2fsm11976219f8f.32.2024.07.29.04.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:54:08 -0700 (PDT)
Message-ID: <46bcb520-0a93-47bf-9252-309056ad0c99@redhat.com>
Date: Mon, 29 Jul 2024 13:54:06 +0200
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
 <0192c705-df2c-4fcf-8385-4ece04e4ba3f@redhat.com>
 <CAL3q7H6f=y5xJWn7UOFdbsAktEkE9EY71rbBAeZ0VRvN4DM2MQ@mail.gmail.com>
 <CAL3q7H7H-DCKObFv3enobqkzDqccw8KLOoEFStugR6fkc-aX=w@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAL3q7H7H-DCKObFv3enobqkzDqccw8KLOoEFStugR6fkc-aX=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.07.24 18:32, Filipe Manana wrote:
> On Fri, Jul 26, 2024 at 5:13 PM Filipe Manana <fdmanana@kernel.org> wrote:
>> On Thu, Jul 25, 2024 at 1:23 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>> On 25.07.24 12:19, Filipe Manana wrote:
>>>> On Thu, Jul 25, 2024 at 10:16 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I’ve noticed that appending to a file on btrfs will create a hole before the appended data under certain circumstances:
>>>>>
>>>>> - Appending means O_APPEND or RWF_APPEND,
>>>>> - Writing is done in direct mode, i.e. O_DIRECT, and
>>>>> - The source buffer is not present in the page tables (what mmap() calls “unpopulated”).
>>>>>
>>>>> The hole seems to generally have the size of the data being written (i.e. a 64k write will create a 64k hole, followed by the 64k of data we actually wanted to write), but I assume this is true only up to a specific size (depending on how the request is split in the kernel).
>>>>>
>>>>> I’ve appended a reproducer.
>>>>>
>>>>> We encounter this problem with virtio-fs (sharing of directories between a virtual machine host and guest), where writing is done by virtiofsd, a process external to the VMM (e.g. qemu), but the buffer comes from the VM guest.  Memory is shared between virtiofsd and the VMM, so virtiofsd often writes data from shared memory without having accessed it itself, so it isn’t present in virtiofsd’s page tables.
>>>>>
>>>>> Stefano Garzarella (CC-ed) has tested some Fedora kernels, and has confirmed that this bug does not appear in 6.0.7-301.fc37.x86_64, but does appear in 6.0.9-300.fc37.x86_64.
>>>>>
>>>>> While I don’t know anything about btrfs code, I looked into it, and I believe the changes made by commit 8184620ae21213d51eaf2e0bd4186baacb928172 (btrfs: fix lost file sync on direct IO write with nowait and dsync iocb) may have caused this.  Specifically, it changed the `goto again` on EFAULT to `goto relock`, a much earlier label, which causes btrfs_direct_write() to call generic_write_checks() again after the first btrfs_dio_write() attempt.
>>>>>
>>>>> btrfs_dio_write() will have already allocated extents for the data and updated the file length before trying to actually write the data (which generates the EFAULT), so this second generic_write_checks() call will update the I/O position to this new file length, exactly at the end of the area to where the data was supposed to be written.
>>>> Yes.
>>>>
>>>>> To test this hypothesis, I’ve tried skipping the generic_write_checks() call after reaching this specific goto, and that does make the bug disappear.
>>>> Yes that confirms it, but it's not the correct fix but the inode was
>>>> unlocked and relocked and a lot of things may have changed between
>>>> those steps.
>>> I thought as much :)
>>>
>>>> I'll work on a fix and let you know when it's ready in case you want
>>>> to test/review.
>>> Great, thanks a lot!
>> So here it is:
>>
>> https://lore.kernel.org/linux-btrfs/a7cdb10155e5e823ce82edfc8eed99d1b0ef4eeb.1722005943.git.fdmanana@suse.com/
> I updated it to a v2 since there was missing unlock update in error
> path for fsync:
>
> https://lore.kernel.org/linux-btrfs/4922c658c56d0f5be975a477facebbc4df588da9.1722010742.git.fdmanana@suse.com/

Besides the reproducer, I’ve also tested this fix with my original 
problem case (virtio-fs test case), and it does fix it.  Thanks a lot!

So FWIW,

Tested-by: Hanna Czenczek <hreitz@redhat.com>


