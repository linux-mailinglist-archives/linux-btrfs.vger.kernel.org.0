Return-Path: <linux-btrfs+bounces-992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70526815A7B
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D4B21B1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119463035D;
	Sat, 16 Dec 2023 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaRbNYXR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E62FE3A
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e25e5a4easo244758e87.0
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702745128; x=1703349928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYgJqErR42aQ5FqRo4EvRhisC9A7K6XvNizFhteCsDk=;
        b=DaRbNYXRQ4EoDH3JN0JYALnHaUQEXDHt1oq1z3XLni2O2v2CXW1uwUbOv9UAY9V2Wx
         EsIGvRrWyNRiYw/1DoJ1Olm5lageNrQq7vlCY8OftG3ji+nviXGkCH1kDlDoYXOQ1yMG
         TnHg8q0S/vNW4gxLDc5T24WE65q5/VOlIruX4gdMGhJ+3mFz/I1HhmIAHBJG6o/FI95j
         HAwFZs0l1GNWw4FukM80cJhhec/vG6to1NmJTARjlxydPB3kKMX0uNmzO9WOIrARHm2T
         C1Bz5z3VBoBF72Rk/VMqRnUSIEu1l20/gqq5/sAQO9kXvOdDHP3iI5DgOH8tlFP7GL91
         vVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702745128; x=1703349928;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYgJqErR42aQ5FqRo4EvRhisC9A7K6XvNizFhteCsDk=;
        b=oOMYeIAVLXKAeqfMLHpG8oNTZPYyC5HiYLqoCwNVbLhOgkE9JsVxTjikbn+UgV92Gm
         UulouLaQpmA7L3nMveOYC4sln0SsaKGuQByVduhw3Iwxl7FEoBqMg/9VoK2FWxuYjS4S
         C/Vo9wxMdgee4+pWaUZTBv/BcjJlinpkZq6UbzfI/G37Hmg6mvWNbvGND5m2CeYddT4L
         7gB0Z/pT35x7MzlvYOudeJKGsKH89eDhf8AI3fnEotP6OKnumbYcTC0UmSko0FTYbZsW
         vtiUXYpq6mThVYgyWJRthfQNcTItHQEF317N+sKUqLdfdo21F6cbsF34CmcP4uU3x4gm
         9JxA==
X-Gm-Message-State: AOJu0YyZnN+kbfhj7MfUIaLNtqIquxSjTqthsqfrJ7/yiNz9JYhLSI74
	8ddJ1MqU2cnufhbV1PUUP5gceUBIZyE=
X-Google-Smtp-Source: AGHT+IGbpSmHhKhgc028XNtYSHE2SVib+PR12nLfHDQ5VS/vFM+2gTr4kkZFQ0/12//Y/61vSlLQgA==
X-Received: by 2002:a05:6512:b26:b0:50e:18e0:697 with SMTP id w38-20020a0565120b2600b0050e18e00697mr4298283lfu.6.1702745127504;
        Sat, 16 Dec 2023 08:45:27 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:2474:5264:f1ab:8b82:c744? ([2a00:1370:8180:2474:5264:f1ab:8b82:c744])
        by smtp.gmail.com with ESMTPSA id br21-20020a056512401500b0050bfcae9637sm2437639lfb.12.2023.12.16.08.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:45:27 -0800 (PST)
Message-ID: <a5699aee-0e36-4c4c-96b3-aaa04e6b74ea@gmail.com>
Date: Sat, 16 Dec 2023 19:45:26 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs send subvolume from read-only mount with missing ro=true
 flag?
Content-Language: en-US, ru-RU
To: thomas <thomas85@mail.ch>, linux-btrfs@vger.kernel.org
References: <a41a77e3-95aa-450f-9712-c5681f8a8912@mail.ch>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <a41a77e3-95aa-450f-9712-c5681f8a8912@mail.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.12.2023 17:47, thomas wrote:
> I have a btrfs volume damaged (it seems beyond repair..) by writing to
> it via an unstable USB connection which disconnected at a particularly
> bad time it seems.
> 
> I found I can still mount said volume in read-only mount using:
> 
> |mount -t btrfs -o ro,rescue=ignorebadroots,rescue=ignoredatacsums
> /dev/ice /mnt/point |
> 
> Now I would have liked to copy some of the subvolumes from that damaged
> volume over to a new one, but sadly |`btrfs send||`| disallows using
> subvolumes that don't already have a ro=true flag on them, so only
> read-only snapshots are allowed as source.
> 
> Can I somehow make |`btrfs send||`| believe that on a read-only mount
> everything is guaranteed to be read-only, even if the subvolume does not
> have that read-only flag? Sadly because I can only mount said damaged
> btrfs volume in read-only mode I can't add the read-only flag to the
> subvolumes I'd like to copy..
> 
> 

Theoretically even if filesystem is mounted ro, it is possible to 
remount it rw on the fly. So one would need to add some mutual exclusion 
between "btrfs send" and "mount -o remount,rw". Not sure how difficult 
it is or whether it is worth the troubles.

What is the exact reason to use "btrfs send" in this case? Why cannot 
you simply archive the content and extract on new filesystem?

