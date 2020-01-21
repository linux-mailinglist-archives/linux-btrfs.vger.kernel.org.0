Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C141439D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUJvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 04:51:54 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54716 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUJvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 04:51:53 -0500
Received: by mail-wm1-f50.google.com with SMTP id b19so2207249wmj.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oJbE2zAIAoGEfKaEO/ehpFxHP50fghEXle+4oUJGqXM=;
        b=eg8tIahvVYU3+qB4Rtuvq7jB3voxORKRzUh1V+503H+sspqWWgq/FRo3F+K2Z/pFUE
         DvVrTlOb02+KrkbFRKQ8vZ6T2V6NY50jZjYMzzEjHuxTwzm61BOc6HCu0gTb9FhlsLx2
         3G57Ne0JMZRn19/qtVK74Knee27bWAm9mfp/9P30sicIm3puLMkWBSmVHX3gmGHW8tKm
         uUVILTWSgvQrw3a3vaQpw1euGPwTdOdZoJ4M77gir2R2Najc1Ej5LeiPgRJCJtpEudZV
         u2k8nJkLb2Bt2r+nBqptn7lxB1sVfDxMDZnK480if/NHggG/iDwNRmpmwNa/h5pIv2af
         LErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJbE2zAIAoGEfKaEO/ehpFxHP50fghEXle+4oUJGqXM=;
        b=miZqO0J6nVQN6HX+v79Ipo6bNbF0XeelyD0UN3Bb+JenH0Pj6o3KiRwf41TFVc8Vfs
         m6qOxHR5inGBF0cx5THdG5NbqR4kL4xB0M0y0G+CeZJDFEryZjpmUQctouKEq34zV04k
         fAebQcakLmp8wreRnwTPF4Jds1BM5Pl3ouec/qqs0BjMXzSFLjHEvPt7QW6TuAZi5bhj
         hX0rU7Sv8BPNhUuzaL1GUUvfpv1ORgxgk3dE/bxWmYHM4Crd51UBth6v9NSr8GBVeGdL
         4/gYtynUlpRg7n2cGLsysB+vC8dIRWmzDo6klxZyypW2TGv3ag1T6UjLuom+27Y/j6c+
         MB9w==
X-Gm-Message-State: APjAAAUQVfdiywwjkv8diUxKh4XooK9LqHWWQ8oRvBMaJ1gcwsj0pLFx
        jdJqyQGbCU+H2BtQg/eBHh7OCR7z
X-Google-Smtp-Source: APXvYqw+mDUUAIV/KgEPgSFq1icPBbICI3wvr0okGizP1wsyr4aEvdUL2sub7n/7Neo6wp+7E4sGxQ==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr3527077wmj.165.1579600311538;
        Tue, 21 Jan 2020 01:51:51 -0800 (PST)
Received: from [172.23.13.41] ([159.255.217.230])
        by smtp.gmail.com with ESMTPSA id z11sm53887667wrt.82.2020.01.21.01.51.50
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 01:51:50 -0800 (PST)
Subject: Re: btrfs raid1 balance slow
From:   kjansen387 <kjansen387@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
Message-ID: <176ec92f-56ba-4c8a-bcce-115c69fb7eeb@gmail.com>
Date:   Tue, 21 Jan 2020 10:51:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Forgot to mention; I'm running kernel 5.4.10-200.fc31.x86_64 .

Op 20-Jan-20 om 23:08 schreef kjansen387:
> Hello,
> 
> I had a btrfs raid1 with 2 4TB SATA 5400RPM disks . Regular disk I/O is 
> about 2MB/sec per drive, ~40IOPS, mostly write. I had ~150GB free and 
> added one 2 TB disk and started the balance:
> 
> btrfs device add -f /dev/sdb /export
> btrfs filesystem balance /export
> 
> It's now running for 24 hours, 70% remaining:
> 
> # btrfs balance status -v /export
> Balance on '/export' is running
> 1057 out of about 3561 chunks balanced (1058 considered),  70% left
> Dumping filters: flags 0x7, state 0x1, force is off
>    DATA (flags 0x0): balancing
>    METADATA (flags 0x0): balancing
>    SYSTEM (flags 0x0): balancing
> 
> I have searched for similar cases, but, I do not have quotas enabled, I 
> do not have compression enabled, and my CPU supports sse4_2 . CPU 
> (i7-8700K) is doing fine, 80% idle (average over all threads).
> 
> Is this normal ? I have to repeat this process 2 times (adding more 2TB 
> disks), any way I can make it faster ?
> 
> Thanks!
> Klaas
> 
