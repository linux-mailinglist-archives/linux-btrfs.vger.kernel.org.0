Return-Path: <linux-btrfs+bounces-1403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C782B4D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 19:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED00B2302B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA953E06;
	Thu, 11 Jan 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUY0QzpL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E891F60F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso813895e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998493; x=1705603293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmlVMCygDyZCVL/jtfhNOPTesHvp7KwH/QFVf+O9/Fs=;
        b=PUY0QzpLQ/nojkCZcLfV+w2pSaPExZmKXqb/56xvfQTmq6Hiw0vw6o4sbNgq/kKu/w
         ZBP0+oaQyCGAwCZZI/L2tjSO+ZbAINHcwHhU4ICWyhw1zuNi8gIWQUpu/+WCnSs+lCnX
         KBj8X84zMYV2wF1zPys3iSsPDBnfr/1aIVmOJN6zyYPfZ5p6Pj18dTmQwwIbieSNShMG
         UYR/tQPAA7JsRaj3oPY3t/bevv7mw8XvXfOUhfa+PgRVH6KgWrSG0LRJA7+shYxNHWGc
         fJsmAcn6n0Pz7RY+G2Nuf7N6mopWaRKJuV3RABm1WA0JIHlVLCTAKa4V52m2dONPXGwJ
         If0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998493; x=1705603293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmlVMCygDyZCVL/jtfhNOPTesHvp7KwH/QFVf+O9/Fs=;
        b=hM8XI2ZQJjta16B4yVw4IDiWLF4LDz47dFz0CyfbiA3GgFDJoDB3Bi4wSYXlNiaihn
         /M9J4zduOfR4+79sj0EQ0UXaTTdJj7pamEVflNhq7EWBVmCiQZj/fvSmKMCYilnC9ShJ
         9tgbwtm9MHfy0RRnlaR1nZ03aZ9S1ovjVWmN05aOXL/wBSRzuRBzxbRjwxR0fRKFRlN9
         IoMt/8RB8tLdXIux/irZDdy6/DPR9vSEQf8XI1e0q5QQxpEYca8lQjZWz4eR19biXort
         N4a5WYR7Zuo7myxQNTNnVw+8yk5WMw9nLuoFpL0AWKUove5uwkwzGYgleWQDTxYVKAoh
         ESxA==
X-Gm-Message-State: AOJu0Yz9bz6IPbgnmNCEb67CmD5qKXzbgkw8wECf48EUWpCGPmZeHO4y
	Zggx3E4VJR49J09OJzYY7fxTfUEi68s=
X-Google-Smtp-Source: AGHT+IF9ZEl60dGViLCz+kYPGnq7Xj6aBDCWrfFFQ3zr9z0PTotyvsN33yyTc4i1oxeAJqVUndP59Q==
X-Received: by 2002:a19:6406:0:b0:50e:74f2:fada with SMTP id y6-20020a196406000000b0050e74f2fadamr151171lfb.0.1704998492795;
        Thu, 11 Jan 2024 10:41:32 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:225c:48f4:10ea:8912:bcf6? ([2a00:1370:8180:225c:48f4:10ea:8912:bcf6])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b0050e758ee006sm266580lfh.205.2024.01.11.10.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 10:41:32 -0800 (PST)
Message-ID: <c81112ab-3111-4a1c-8740-2641f3862e29@gmail.com>
Date: Thu, 11 Jan 2024 21:41:31 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
 <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <354d852c-0283-4008-ae20-e00788b8d5eb@gmail.com>
 <CAFvQSYRHFkjDEyd7rBUnpZm4oQe0MKd3jgkR8WPuK_2KPvSDwg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAFvQSYRHFkjDEyd7rBUnpZm4oQe0MKd3jgkR8WPuK_2KPvSDwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.2024 22:36, Clemens Eisserer wrote:
> Hi Andrei,
> 
>> The error is correct. There is no subvolume with UUID
>> 29fca96e-ca6a-3d4b-b7c9-566f1240d978 and according to the output in your
>> other mail there are no received UUIDs which breaks send/receive chain.
>>
>> Unfortunately the output you sent was *after* your script already
>> destroyed the original state of both filesystems - it recreated
>> subvolumes without running successful send/receive first. So we still do
>> not know the state when error happened.
> 
> I am really sorry, I didn't think of this.
> 
> I've followed your suggestions and tried to reproduce it once again.
> This time I booted from extern/root-rw two times and performed
> ext->int->ext in between, but didn't manually change files like in the
> previous runs.
> After the second boot send/receive failed as expected. I've omitted
> manual mounts/unmounts this time from the command-list.
> 
> 
> I would be really glad if you could - once again - have a look at the results:
> 
> btrfs send source_disk/root-ro | btrfs receive extern/ #initial source->ext
> btrfs send extern/root-ro | btrfs receive intern/ #initial ext -> int
> btrfs sub snap extern/root-ro extern/root-rw # rw snapshot to modify
> ext, will be used as subvol when booting
> btrfs sub snap intern/root-ro intern/root-rw # rw snapshot to modify
> int, won't be used
> 
> # boot fedora from extern (+ install firefox via dnf) + shutdown again
> 
> btrfs subvolume list -pqRu intern/
> ID 386 gen 576 parent 5 top level 5 parent_uuid -
>                received_uuid 8d1ee193-2522-014b-b436-032f0a4fc461 uuid
> a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 path root-ro
> ID 387 gen 576 parent 5 top level 5 parent_uuid
> a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 received_uuid -
>                   uuid f4d1c9cc-3e4b-4248-9b02-626bed3ad238 path
> root-rw
> 
> btrfs subvolume list -pqRu extern/
> ID 345 gen 588 parent 5 top level 5 parent_uuid -
>                received_uuid 8d1ee193-2522-014b-b436-032f0a4fc461 uuid
> 21cabdfd-02f5-ab4b-943a-6ebf88326dae path root-ro
> ID 346 gen 611 parent 5 top level 5 parent_uuid
> 21cabdfd-02f5-ab4b-943a-6ebf88326dae received_uuid -
>                   uuid 0c9d9843-32f3-d341-b657-a33de46c9d0e path
> root-rw
> 
> sh sync_ext_to_int.sh
> 
> btrfs subvolume list -pqRu intern/
> ID 388 gen 583 parent 5 top level 5 parent_uuid
> a88bb4ed-65c8-db4f-b209-9ca07eaf3d21 received_uuid
> b326e1fe-7295-3948-a401-b6de850e213c uuid
> f055e3e8-d048-744c-abb4-c3efd87c4875 path root-ro
> ID 389 gen 583 parent 5 top level 5 parent_uuid
> f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
>                   uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
> root-rw
> 
> btrfs subvolume list -pqRu extern/
> ID 346 gen 615 parent 5 top level 5 parent_uuid
> 21cabdfd-02f5-ab4b-943a-6ebf88326dae received_uuid -
>                   uuid 0c9d9843-32f3-d341-b657-a33de46c9d0e path
> root-rw
> ID 347 gen 615 parent 5 top level 5 parent_uuid
> 0c9d9843-32f3-d341-b657-a33de46c9d0e received_uuid -
>                   uuid b326e1fe-7295-3948-a401-b6de850e213c path
> root-ro
> 
> sh sync_int_to_ext.sh (intern was not changed, just to keep ext->int,
> int->ext in order)
> 

This should have failed already and the real question is why it did not. 
The parent subvolume is identified by rceieved_uuid which is missing.

> btrfs subvolume list -pqRu intern/
> ID 389 gen 588 parent 5 top level 5 parent_uuid
> f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
>                   uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
> root-rw
> ID 390 gen 588 parent 5 top level 5 parent_uuid
> da51f30f-f10a-b04c-b7a7-5e718118a49c received_uuid -
>                   uuid 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 path
> root-ro
> 
> btrfs subvolume list -pqRu extern/
> ID 348 gen 623 parent 5 top level 5 parent_uuid
> b326e1fe-7295-3948-a401-b6de850e213c received_uuid
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
> ID 349 gen 623 parent 5 top level 5 parent_uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
>                   uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
> root-rw
> 
> # boot fedora from extern (remove google-chrome and chromium via dnf)
> + shutdown again
> 
> btrfs subvolume list -pqRu extern/
> ID 348 gen 623 parent 5 top level 5 parent_uuid
> b326e1fe-7295-3948-a401-b6de850e213c received_uuid
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
> ID 349 gen 633 parent 5 top level 5 parent_uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
>                   uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
> root-rw
> 
> sh sync_ext_to_int.sh
> 
> manually executed line-by-line in expecting it would fail it failed at:
> btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/
> At subvol extern/root-ro-new
> At snapshot root-ro-new
> ERROR: clone: cannot find source subvol 8a1f263b-581d-1847-a0da-0fc17e1ca2c4
> 
> interestingly, despite send-receive failed/aborted with the message
> above, intern/root-ro-new was created and contains contents but left
> in writable state:
> 

Correct. Where "btrfs receive" fails is cloning extents from the parent 
subvolume. The difference is that rebooting performs much larger 
modifications of the root-rw subvolume which triggers "clone" operation 
during send/receive. Your test runs basically do nothing. Post output of

btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive --dump

I do not know off-hand how to trigger "clone" operation.

It is definitely "btrfs receive" bug. Either it should fail from the 
very beginning due to missing received_uuid or it should consistently 
fall back to subvolume uuid in all cases. But starting with subvolume 
that cannot be later used to apply incremental changes is certainly the 
wrong thing to do.

> btrfs sub show intern/root-ro-new/
> root-ro-new
>          Name:                   root-ro-new
>          UUID:                   d32788b9-5572-5743-bf27-46b57c8b92c1
>          Parent UUID:            8a1f263b-581d-1847-a0da-0fc17e1ca2c4
>          Received UUID:          -
>          Creation time:          2024-01-08 20:14:59 +0100
>          Subvolume ID:           391
>          Generation:             596
>          Gen at creation:        594
>          Parent ID:              5
>          Top level ID:           5
>          Flags:                  -
>          Send transid:           0
>          Send time:              2024-01-08 20:14:59 +0100
>          Receive transid:        0
>          Receive time:           -
>          Snapshot(s):
>          Quota group:            n/a
> 
> 
> btrfs subvolume list -pqRu intern/
> ID 389 gen 588 parent 5 top level 5 parent_uuid
> f055e3e8-d048-744c-abb4-c3efd87c4875 received_uuid -
>                   uuid da51f30f-f10a-b04c-b7a7-5e718118a49c path
> root-rw
> ID 390 gen 594 parent 5 top level 5 parent_uuid
> da51f30f-f10a-b04c-b7a7-5e718118a49c received_uuid -
>                   uuid 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 path
> root-ro
> ID 391 gen 595 parent 5 top level 5 parent_uuid
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 received_uuid -
>                   uuid d32788b9-5572-5743-bf27-46b57c8b92c1 path
> root-ro-new
> 
> 
> btrfs subvolume list -pqRu extern/
> ID 348 gen 623 parent 5 top level 5 parent_uuid
> b326e1fe-7295-3948-a401-b6de850e213c received_uuid
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f path root-ro
> ID 349 gen 636 parent 5 top level 5 parent_uuid
> c481acb9-b077-7841-a4b6-a0273f7aa12f received_uuid -
>                   uuid cf80f17f-3d5d-7744-83f4-096b7688288c path
> root-rw
> ID 350 gen 636 parent 5 top level 5 parent_uuid
> cf80f17f-3d5d-7744-83f4-096b7688288c received_uuid -
>                   uuid d73b4afe-0837-8046-b798-21102cb82d4d path
> root-ro-new
> 
> Looking at the last output I have to admit I am confused.
> The error mentioned missing parent with
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4 for intern/root-ro-new seems to
> be there. Isn't this, as expected intern/root-ro with
> 8a1f263b-581d-1847-a0da-0fc17e1ca2c4.
> 
> Thanks for all your patience and help!
> 
> Best regards, Clemens


