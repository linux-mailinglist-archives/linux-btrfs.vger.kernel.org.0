Return-Path: <linux-btrfs+bounces-15747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101DB15933
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FF4176F3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA11FFC46;
	Wed, 30 Jul 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAxOglA+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3B1FBEA6;
	Wed, 30 Jul 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858706; cv=none; b=mYUwBzcI5cWY4cB3xHy3qMzcOl6VEAHHQonYGwMRZcobwKyjL6rKcJWJgYqoMGEz0zbpnbVgcfl/RGwnjsz9qTz2Bh7UwyDxshwoM/kO6UKgGr3ynDawR1rtvs38ehG8azeFHXdEX3sm0KvvyAWGMLdyza32MypsEqWR4boq41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858706; c=relaxed/simple;
	bh=5pjH5bGDJslV+PWUxnoZ83BGVZ2TA8c3zUJVab4Zw7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoIwyqFPzpDxegcjv60gIcw8qoDnwUIRrWqnWp1eLFPTpC5LikQ40RT7rnCX+I4M9M0NJHVxFux1IefuX5/s3jsu1ZTuWs5aTXIjirjeEplzujTyuGPQQt5UbibtMadZlf62Nj7k21jNsIxnjI9MiqP8cIQWCOaaPL/33FJMtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAxOglA+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so2870370a91.1;
        Tue, 29 Jul 2025 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753858704; x=1754463504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pjH5bGDJslV+PWUxnoZ83BGVZ2TA8c3zUJVab4Zw7c=;
        b=iAxOglA+uIFogV3TIdQqNd8rUD1ZizjbMyvGs1J5wXnw2T20t98ChIUYzQnsN92fTg
         ekobNIY5HMYSCoOWL+o0nbPvEhlIm5ibyhrGgrhbmvW8jfH7+gDFgVqthsoAJvcJ1k+j
         T9QTObMkp65oJKyMjxk/ax4MJeyEq8u97QOW2wshtZST5mSThbGC/pD03C6c8+JiJo4D
         AdLfHUuUM2mlxAiLN5kPabdcShimFnI2yibP2BTIdFvfn0UVMy4KjXOEiIRvsBdnj2PS
         Zx38ulLX4LnzZg8NSGcgI8YnF6qhRqXBFWfplG5cxo+dVHw0KiscFRmE/2Aq0hKLrhoP
         6z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753858704; x=1754463504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pjH5bGDJslV+PWUxnoZ83BGVZ2TA8c3zUJVab4Zw7c=;
        b=TQLVdRixg8CU/tmQNfu4XXeGIk5YfGkZhqo02hHKFhpSg9+kcZHqX9IcNevIJAemO2
         prhkzfpvSBdptusMj9Z4MUTnjf3YkXDC/72T+3X+Tb3u1QRxUWCNZ31fOCCIbwXwqlCD
         E4BdkM9RMhkOCSeBjj+gqXRNGEuitEy305vusCpYvs/QjWYZ4IvhOAwU08y7LP2z6eIS
         sZg2IRkZHTYr0NoB7ZkugVM7LAJvAnzq3jT4NjDPTCM9xFcg06VENId825umrUdDkheE
         /ckNnVNc0C4zxJ8V/ioQhlh6W1nRLDfOScg6vFbPrW90NjYgVIogoU+LGUbVSGOAOsMq
         2qkw==
X-Forwarded-Encrypted: i=1; AJvYcCWnAyvbtkZLjhZWpI0nHbO3Y5h3uFIF0MaJxTCC9Bii5HvYkVD3Xnw3LCHPOSH7Wz4Erh6HpWM7PbxYhQ/f@vger.kernel.org, AJvYcCWzZRhUN+4E/lJlQV9STG0iu6V+m6d/C7WBZ8cWV/jm3P2A11d9jsOoYQoLm/n2kB8BClJmS14d4RCYAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTJ/hpzn2/Cp0AW+IFq52r2naMYC3iWbX5uRD0xoCtTu3JYsn
	CFq7o9XqIQAIoFR+PwkrR9L8BC4hXxlX4RJwSkmREEWWBNMEqsgLWMZWdsTrIw==
X-Gm-Gg: ASbGncvDwgrsWd4SRJvdRXmRQK5MemXMqJQi+YIkM1Oc9/77/Wv9qIowxQ5umRUMNY1
	2tVIzRYFuTSNFu8vtuDFpERg5cFfDUU7YJZD/Z+0H4lWYQV8xwVLB4L6QtzqnEdIDi0/Dv2ko26
	JHJUgwgDugk2puzYDwCJaDCRsFwwv+NB/Ocvvi7fFoRdUXhzb/6NT7aAOvSVv9B893teGm6VMAm
	J4Z3vec1hVURu3sHZJlPy/Y2McA+RZNN/VtoIJBkMoimtpQbOvA0dx9kiloCZxij2+3BA0quno5
	neFBfagtZA7UCjGDbNPOFhaU8844gEYLuYy4Bcm+4XXK7M5c7K8+zLPa80RyGQnVKeyVaahHC0k
	p2mj+BHHxCCdS4AZk5QxkoBUEkYd2Uvwuaks3CKQnDhEzkvj7GyIqgaSR5XgR0tPWVRhEruJKp3
	54E7Geow==
X-Google-Smtp-Source: AGHT+IFJs1DT5Yvb56u38lYx+6vvfWV7r0rBgkLbhuToytqdijfwMb76ER2iDqkWV8E1SX4gEWiEog==
X-Received: by 2002:a17:90b:3145:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-31f5de96a5cmr3398959a91.20.1753858703893;
        Tue, 29 Jul 2025 23:58:23 -0700 (PDT)
Received: from mail.free-proletariat.dpdns.org ([182.215.2.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm1087191a91.26.2025.07.29.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:58:23 -0700 (PDT)
From: kmpfqgdwxucqz9@gmail.com
X-Google-Original-From: admin@mail.free-proletariat.dpdns.org
Received: from kernelkraze-550XDA.. (_gateway [192.168.219.1])
	by mail.free-proletariat.dpdns.org (Postfix) with ESMTPSA id 47FE14C025C;
	Wed, 30 Jul 2025 15:58:19 +0900 (KST)
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	KernelKraze <admin@mail.free-proletariat.dpdns.org>
Subject: Re: [PATCH 1/1] btrfs: add integer overflow protection to flush_dir_items_batch allocation
Date: Wed, 30 Jul 2025 15:58:18 +0900
Message-ID: <20250730065818.149092-1-admin@mail.free-proletariat.dpdns.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <53686e91-5822-4137-9f79-e4f4d98ff6fb@wdc.com>
References: <20250730044348.133387-1-admin@mail.free-proletariat.dpdns.org> <20250730044348.133387-2-admin@mail.free-proletariat.dpdns.org> <53686e91-5822-4137-9f79-e4f4d98ff6fb@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: KernelKraze <admin@mail.free-proletariat.dpdns.org>

Hi Johannes,

Thanks for the review.

On 7/30/25 6:35 AM, Johannes Thumshirn wrote:
> Where does this number come from?

It's from log_delayed_insertion_items() at line 6111:

/* 195 (4095 bytes of keys and sizes) fits in a single 4K page. */
const int max_batch_size =3D 195;

I reused this limit for consistency across btrfs batch operations.

> Wouldn't kcalloc() or kmalloc_array() be the better choice here?
> kcalloc() calls kmalloc_array() which in term does overflow checking.

Good point. The issue is we're allocating a mixed buffer:

[u32 sizes array][struct btrfs_key keys array]

kmalloc_array() handles single-type arrays, but we need:
- ins_sizes =3D (u32 *)ins_data
- ins_keys =3D (struct btrfs_key *)(ins_data + sizes_size)

Two options:
1. Keep current approach with manual overflow checks
2. Split into separate kmalloc_array() calls (potential cache miss cost)

Which would you prefer? I'm happy to rework it either way.

Thanks,
KernelKraze

