Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E27168A81
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 00:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgBUXr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 18:47:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40300 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXr3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 18:47:29 -0500
Received: by mail-qv1-f65.google.com with SMTP id q9so1747024qvu.7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 15:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfYByrcXqAl6Fj0bC6qhAGGY7OmvDD2HeDOHKtJnd8E=;
        b=FZ3tJ/4kh4T5ZANz26bqH2s8/a7xTl2QmmwSPTXdXMj7h0exHWHRJArDuFqSAyPwwq
         TgbwCkaIy2BGLFTSFy48p/M5gN8P7hrpUJGJpBllzGbxiOPY5xKS8X03RZiBosmbWLi8
         8+qJPGocKmarOsk148ij0GR6QuZFvPOFE+LGJjRLHpjFzS3AHtiBW3WoPn46bXFrIfeK
         QblnaP9cVNdiC3nr3BR8rCdoeC98VkBjwDgmRq1Mn0renUkTLF/IEqQIl1o+LurHgwYK
         YdrYD6z4JGhL+a0Z1Adyp16OBe52n6r0Q4gWPg7K3abtST+dLL9DDasWveD4Fx0desXa
         2ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfYByrcXqAl6Fj0bC6qhAGGY7OmvDD2HeDOHKtJnd8E=;
        b=bDRaDB/yWhFUiE0pXDh4uRSqtgJpe0xDNF3hHDvPbmPT0n8GcjoaW5KUuM4P2cUVXb
         Qg994hr+8PNSuQts7CXltkpvC2Ixi1Zi7w5vGqyCDxzs5FJGLJ28RuVY8vj8RaKQmT86
         0lPc6SGL7KCQFozWbsjudLenlx0Voh7CXviFtOtRIXWBhIowCIRcusEOaRLxnhWjt9KP
         Q7G6CXiScYIPh5TD/beFd0NPnT9P4cE+2okjA6W2S1Dunqx1UpTDEtcLWVJjHIyNrY4o
         hkSo65gsHNgTeGGXNC77aPFdhkgexl8Jt9OMgWPZA5P7J6YOCr3xHatBCVglzBKD47Hy
         e9GQ==
X-Gm-Message-State: APjAAAW7fwFo1C3v1Nx9Ck7ZgDNixsUt/twGbpQcCIPoAfrp9kXWVkYs
        pGDe97DzbuYrPKYJk0yRNl+MSQ==
X-Google-Smtp-Source: APXvYqytbGo2uXFkmckKKqALcWCkZ2xo8mLjTM0717IU4p92uxl0kDQvfKPgMNPI3HgomhSQ5x/xjw==
X-Received: by 2002:a0c:f98a:: with SMTP id t10mr33497114qvn.144.1582328848009;
        Fri, 21 Feb 2020 15:47:28 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::31fe])
        by smtp.gmail.com with ESMTPSA id a128sm115004qkc.44.2020.02.21.15.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 15:47:27 -0800 (PST)
Subject: Re: How to roll back btrfs filesystem a few revisions?
To:     Marc MERLIN <marc@merlins.org>, Roman Mamedov <rm@romanrm.net>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <2656316.bop9uDDU3N@merkaba> <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org> <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org> <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org> <20200221231738.GD11482@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5cb4781d-5580-0a8d-562b-c8bfa3def5b4@toxicpanda.com>
Date:   Fri, 21 Feb 2020 18:47:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221231738.GD11482@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/20 6:17 PM, Marc MERLIN wrote:
> On Fri, Feb 21, 2020 at 03:07:40PM -0800, Marc MERLIN wrote:
>> And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
>> [64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
>> [64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
>> [64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
>> [64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> 
> While I'm going to destroy and recreate one of the two filesystems, the
> other one has lots of of btrfs relationships I really don't want to lose
> and have to re-create.
> 
> I'm sure it got in a bad state because it got write denied when trying
> to write.
> I don't care about last data written, is there a clean way to open the
> filesystem and revert it a few revisions?
> Basically I want
> git reset --hard HEAD^ or HEAD^^
> 
> I'm ok with data loss, I just want to get back to a previous good known
> consistent state. If I've not disabled COW (which I have not), this
> should be possible, correct?
> 
> If so, how to I proceed?]

Yeah you can try the backup roots, btrfs check -b and see if that works out? 
Thanks,

Josef
