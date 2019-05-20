Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852B0232DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfETLnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 07:43:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39969 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETLnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 07:43:02 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so927294itf.5
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CO+tQYtSHd5QOSiznEHvgAiuNqd/Ompcatl2cav6JMw=;
        b=mXCqZJG9IJX1oR6mDd36zAmwr0uSHgnfN75F0gnsmxcf3Oh1z8DgcBMUf1zrx3xp7I
         lBLd5+BOsGmcFqZ6JDhosgMW1DviCzesNf8NWbUSc5mMIibW4irPofB6jXMWeI0X6tcm
         ajk/QNFrDpYx9/TLh+dPonFEne6PLZyDAQba+KOwuvrDC5giozvu6gdBWj08+ljaALul
         YGyvVH8a3NODrXf5Ck548evjlWeG9EoMP3YOVL3aSZ9qf7K8Kz8TlZqBSEZecoqExZq1
         38t9gRNkMQS9WZ+ZlggNkFwEqyMK+f0PcLZqrgIdqevVtZDlYVWLsDQ2kz3Gi3eBImr5
         2hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CO+tQYtSHd5QOSiznEHvgAiuNqd/Ompcatl2cav6JMw=;
        b=k+pS2B5v8NO4WRRyOhRatVEJ+UyrBpD/fpqlwMLS92M0SDq+eQoMNCzyimw+9mr8k/
         zsQi3Sl3tTiVUcvMSrr/HA9blTHXsYv6s4PeU6YdjdDfObW2go7fxBTLG/ah7XA8qMPh
         5I0JpIbqahGK4+55xRzio6NMyx18HfMBbdoNvoQdWHQzLnM/15WZ5nfiYH6QzEf3mvVd
         z2ESLNkRiSnRoAp5M2VfYNR5w+1AHBw9r7UKhL6vgbKDnUM8Cc6DqTu4sCDTZQqv8h7T
         x2Q3nz4NIh3JRb81hbJ3OO2/15Kipp39jq9TFN6Zl8jUfPWi3yaJuA46RXRsdUEO3W0y
         pkJg==
X-Gm-Message-State: APjAAAW9QkZRvsQSFQ5TV/IAS0GHKwjsvQO8rq1rlb9CL4m6aV35NWKy
        jLBc5iuhbM///I1xxnbgYhZe+IHcVAQ=
X-Google-Smtp-Source: APXvYqxbQ3SxTVwQVK5Yuva0PTSXcBhyJkF1Eu1Y/ezO7zOzxw0HZ/5A7gzB4Z7hiQmt+TPpExzSqw==
X-Received: by 2002:a02:241:: with SMTP id 62mr8450545jau.58.1558352580956;
        Mon, 20 May 2019 04:43:00 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id d22sm5444270ioc.51.2019.05.20.04.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:43:00 -0700 (PDT)
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
To:     Diego Calleja <diegocg@gmail.com>, dsterba@suse.cz
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz> <2947276.sp5yYTaRCK@archlinux>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <2b38d154-c9c6-6040-bb18-781dd9616752@gmail.com>
Date:   Mon, 20 May 2019 07:42:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2947276.sp5yYTaRCK@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-17 14:36, Diego Calleja wrote:
> El miércoles, 15 de mayo de 2019 19:27:21 (CEST) David Sterba escribió:
>> Once the code is ready for more checksum algos, we'll pick candidates
>> and my idea is to select 1 fast (not necessarily strong, but better
>> than crc32c) and 1 strong (but slow, and sha256 is the candidate at the
>> moment)
> 
> Modern CPUs have SHA256 instructions, it is actually that slow? (not sure how
> fast these instructions are)
> 
> If btrfs needs an algorithm with good performance/security ratio, I would
> suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made
> to the final round in the SHA3 competition, it is considered pretty secure
> (above SHA2 at least), and it was designed to take advantage of modern CPU
> features and be as fast as possible - it even beats SHA1 in that regard. It is
> not currently in the kernel but Wireguard uses it and will add an
> implementation when it's merged (but Wireguard doesn't use the crypto layer
> for some reason...)
If anything, I'd argue for BLAKE2 instead of SHA256 as the 'slow' hash, 
as it's got equivalent or better strength but runs significantly faster.

For the fast hash, we should probably be looking more at stuff like 
xxhash or murmur3, both of which make CRC32c look slow by comparison (at 
least, when you don't have hardware acceleration for the CRC calculations).
