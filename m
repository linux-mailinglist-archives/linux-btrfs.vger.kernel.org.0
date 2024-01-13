Return-Path: <linux-btrfs+bounces-1427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734B82CA88
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB301F2331C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA915BD;
	Sat, 13 Jan 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heCZN4mo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58407A38
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e6c0c0c6bso1575568e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 00:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705135334; x=1705740134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5XATw9L0WCYvQifCHSI37OhbUDQJgrI8oGXEvLLj+o=;
        b=heCZN4mouyZG5i/MfeCbVg7Y7r3VX6WVSSiz+zPTDJEXDE4MFAX8QYlVSU51ZLCupF
         QGPBi5HE/s338JuY59h229yJmAMhqEuTEhQkdZKV3MpbrjvzdJKkjZDCH2toevdX7A2Y
         4tvm4MKgkmMgKdm4jWeeAWCZqKMa3g7mV9bDdvKt8JNofIRKLKsUEhuLB/aZ27b8pLsy
         TN89e80VVj10YvRZCoZxAfp4imKa+p59vkMNEQIJm9tXFFO4SaT1Nb7Yhq0BX03hUCK/
         bXeXWOMx1CLX+ARyx1/hQFCEW45CIA4Tfczwyo46emttBOruEMIPFaxbEZVGoOnab+2x
         R8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705135334; x=1705740134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5XATw9L0WCYvQifCHSI37OhbUDQJgrI8oGXEvLLj+o=;
        b=ndQ7OuMRkn2JUl+9sZZKieWssRr+Ru0oLsG0h1a2idEHbSZfbMyowC4p5hx8NHYJH3
         Ay/F2FAzF+UiI0lq5q9wBaaCD1AgKesIwXiw9kNnoh8DRmLfywwWGWDN3RMks5IGXVfo
         OyWqbMqzQAEhc+fZjjO0YzCLroIHbYcSkykHh1RC+CNQbxZ0L5KsGF7bvbTtLaNnP7Hm
         HVpunufElIJFNvWbaZQq40oro+29I2g6B+UvSPjC6ORfbQceHGH0RYwPYluVSxu7X7Df
         ez/AeKnqPBzD9U4Xn6Hs+K9ayDGY7HfJ7JHhVuZqdXV/BaAHqUUmPWu3MpQGbgn+8WTB
         sT2g==
X-Gm-Message-State: AOJu0YwnIQig5LIgPOFiBqlPOASHC7RGryseCCG413I5QyGR7QNFw9wa
	siV6d4RIeIIUTh9KDQL75pMKlq9Lu7s=
X-Google-Smtp-Source: AGHT+IHJCinL/pYlFopIDsXFXTg46OhcRmQ80eqMNqXpxYDVbRMeq19QGfP8vLCkvK1/u2v8jxyIIg==
X-Received: by 2002:a05:6512:1ce:b0:50e:b2ba:15d with SMTP id f14-20020a05651201ce00b0050eb2ba015dmr2228468lfp.1.1705135333800;
        Sat, 13 Jan 2024 00:42:13 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:225c:1a3d:4c49:4f1b:95bc? ([2a00:1370:8180:225c:1a3d:4c49:4f1b:95bc])
        by smtp.gmail.com with ESMTPSA id v27-20020a056512049b00b0050eb207ab58sm761241lfq.74.2024.01.13.00.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 00:42:13 -0800 (PST)
Message-ID: <ad8d4b3e-44e7-4152-b2d8-ca98bce2d36e@gmail.com>
Date: Sat, 13 Jan 2024 11:42:12 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
Content-Language: en-US, ru-RU
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
 <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
 <354d852c-0283-4008-ae20-e00788b8d5eb@gmail.com>
 <CAFvQSYRHFkjDEyd7rBUnpZm4oQe0MKd3jgkR8WPuK_2KPvSDwg@mail.gmail.com>
 <c81112ab-3111-4a1c-8740-2641f3862e29@gmail.com>
 <CAFvQSYQwa-=xPLK+DXzacHtL6u6LdNLa4Qsp+F1V_SDL0HYj=g@mail.gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAFvQSYQwa-=xPLK+DXzacHtL6u6LdNLa4Qsp+F1V_SDL0HYj=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.01.2024 11:44, Clemens Eisserer wrote:
> Hi Andrei,
> 
>> Correct. Where "btrfs receive" fails is cloning extents from the parent
>> subvolume. The difference is that rebooting performs much larger
>> modifications of the root-rw subvolume which triggers "clone" operation
>> during send/receive. Your test runs basically do nothing. Post output of
>>
>> btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive --dump
>>
>> I do not know off-hand how to trigger "clone" operation.
> 
> I've uploaded the receive dump to:
> https://drive.google.com/file/d/1aluawM35xFxm7Au4dWtUzBcXbM3hyK-P/view?usp=sharing
> The dump contains 4 clone operations, seemingly caused by an
> in-process database used by some kde component:
> 
> At subvol extern/root-ro-new
> clone
> ./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-wal
> offset=4096 len=61440
> from=./root-ro-new/root/.local/share/kactivitymanager
> d/resources/test-backup/database-wal clone_offset=4096
> clone
> ./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-wal
> offset=65536 len=147456
> from=./root-ro-new/root/.local/share/kactivitymanag
> erd/resources/test-backup/database-wal clone_offset=65536
> clone
> ./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-shm
> offset=4096 len=12288
> from=./root-ro-new/root/.local/share/kactivitymanager
> d/resources/test-backup/database-shm clone_offset=4096
> clone
> ./root-ro-new/root/.local/share/kactivitymanagerd/resources/working-backup/database-shm
> offset=16384 len=8192
> from=./root-ro-new/root/.local/share/kactivitymanager
> d/resources/test-backup/database-shm clone_offset=16384
> 

Good. So this confirms the root cause. To be absolutely sure you could 
also enable verbose logging in "btrfs receive" to get the exact point 
where it stops.

> This would also explain why it worked for the first boot (fresh
> profile, db-files are created) and fails the second time (db files are
> modified leading to clone).
> 

Correct. New files result in "btrfs send" instructions to create and 
fill in data, not to clone existing data.

>> It is definitely "btrfs receive" bug. Either it should fail from the
>> very beginning due to missing received_uuid or it should consistently
>> fall back to subvolume uuid in all cases.
> 
> Do you have any idea why the received_uuid is missing in the first place?
> 

Where should it come from? Received_uuid is set by "btrfs receive" on 
the target of replication and is always equal to UUID of the source 
subvolume data. But in your workflow when you sync in reverse direction 
the former source subvolumes are not the result of replication and so do 
not have received_uuid.

When you perform int/root-ro-new -> ext/root-ro-new, ext/root-ro-new 
gets received_uuid equal to int/root-ro-new UUID. But int/root-ro-new 
does not have any received_uuid because it was just created locally on int.

As Hugo mentioned, the current design of btrfs replication with 
send/receive is fundamentally unidirectional.

To allow bidirectional replication in the current design you must always 
have the same data with the same received_uuid on both sides. So 
replication will become something like

1. Start with initial replica having the same received_uuid (look 
carefully at your btrfs subvolume list output)

int/root-ro <-> ext/root-ro (*both* received_uuid == UUID1)

2. Do incremental update with initial replica as parent

btrfs send -p int/root-ro int/root-ro-new

int/root-ro-new (*empty* received_uuid) -> ext/root-ro-new 
(received_uuid == UUID2 == int/root-ro-new UUID)

3. Delete int/root-ro-new and perform reverse incremental sync

btrfs sub del int/root-ro-new
btrfs send -p ext/root-ro ext/root-ro-new

which results in

int/root-ro-new <-> ext/root-ro-new (*both* now have received_uuid == UUID2)

now you are on the square one and can again resync in every direction 
but must follow the same procedure every time.

It does mean extra time and bandwidth. Of course you can take the 
sledgehammer and simply manually set int/root-ro-new received_uuid to be 
equal its own UUID ... but I am not sure if this would not violate some 
of the current or future btrfs checks (there is no legitimate workflow 
where received_uuid would be equal to UUID).

> Should I file a bug-report against btrfs receive?
> 

I guess it never hurts, but I am not sure whether btrfs is using any 
formal bug tracker.

Thinking more about it - the fallback to subvolume UUID if received_uuid 
is missing is wrong. We have no way to verify that subvolume data was 
not really changed. It was one of the most common problem with 
send/receive - people flipped read-only -> read-write, made some 
changes, then flipped back read-write -> read-only and now source and 
target replicas were no more in sync and incremental stream created on 
one side could not be applied to another side.

Recent btrfs progs will clear received_uuid when subvolume is changed to 
read-write which offers some protection against such mishandling, but if 
we will fall back to plain UUID anyway, any bets are off.

