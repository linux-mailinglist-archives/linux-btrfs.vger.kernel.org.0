Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C3553811
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354013AbiFUQjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353706AbiFUQje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 12:39:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB92E6A6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 09:39:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n12so6653695pfq.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6vuHyNB+RqnQVYLwpag6Fnu7dXUTKQNhooaePlPvyK0=;
        b=kwLQfOqHfz5bEL3qk7rx5h1dXRpgECTgdV1U0bBbN1hqUJJE79uyPvCE2/aZ+Ov9Ua
         VYAzTl5aahTynvc3tIr6/lKpLJkV3tcz9B1ssZj3LeE/v4jlQfIJc/OsFDUl60aD3jvE
         UPQ6D7VcMTfMKzcCVg0ZCdWzs5pw4Pt+khkPPqVfuuYtjUAUCnyLB5RZ3MCGnQ6nuV1g
         R1Y0OKdJxHUiCndLcprDQvOqI5uJrfdKtDrXENBCrk4vJIyAmg/xHaJ/lqfVgghIAwLN
         +9poUUZFBg67mhs7e7A9GakNUGFohP53aVwCQt/j0MC0ExEekO2/XhenHgbVbH3ckHfR
         Xd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6vuHyNB+RqnQVYLwpag6Fnu7dXUTKQNhooaePlPvyK0=;
        b=v0q1j5wp8K5Of3h+M+uRsqkyMcmPrHmCIlp4k3c9nHIvEmf+BJYkEzQosAKl+oiZ6A
         Ji+TH6XPOLM5UG5P4euCXKrWj9qw/FDr97haBYJE6wrL5oabKhIrKzpFe1E6xtdaC3MS
         TWVHi1OxzJZ8ZV9EsAIKN4d7DfGzGpMr6M2I56SQZeFiwbLfguc6GovvHIK59Hy3wC9J
         p+trfY4w5s74i0liSTU9BExRJPx/MnCfb7BNRq48WWW4NbXVcfagCGKzFZoboxwnv2tc
         Ttgq9KeujcuehoQdOsI5D5+p3yfURi+mexr68HfpAYnDCNag0ROFvvL/MAWU+nwgdOaF
         Z/og==
X-Gm-Message-State: AJIora+RKTLgZu1DbSB1f+Iep3CsS4W70ObuFTL67CNzfBla8qoCN/Vg
        Kj4hdlZ5Aa3vppneLqm0X/0=
X-Google-Smtp-Source: AGRyM1vMFqitsylsMG+fCEyDR9MWVQE7DwM9gVhghIbH0ovIoqAqN9r6lXEKhrbnLpTQIj4kjqd0JQ==
X-Received: by 2002:a63:4c1d:0:b0:3fd:9833:cdd9 with SMTP id z29-20020a634c1d000000b003fd9833cdd9mr27485676pga.103.1655829558183;
        Tue, 21 Jun 2022 09:39:18 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id gf13-20020a17090ac7cd00b001ec4f258028sm9042057pjb.55.2022.06.21.09.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:39:17 -0700 (PDT)
Message-ID: <8eba9e24-ab81-6226-000a-95b5974047a7@gmail.com>
Date:   Wed, 22 Jun 2022 00:39:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [IDEA RFC] Forward error correction (FEC) / Error correction code
 (ECC) for BTRFS
Content-Language: en-US
To:     dsterba@suse.cz, Phillip Susi <phill@thesusis.net>,
        linux-btrfs@vger.kernel.org
References: <f5cc6c6f-2238-b126-3b0e-00e9e49b0706@gmail.com>
 <87zgi65cn5.fsf@vps.thesusis.net> <20220621142541.GZ20633@twin.jikos.cz>
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <20220621142541.GZ20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 2022/6/21 21:56, Phillip Susi wrote:
 >> 2) Low-cost approach:
 >
 > Both of these home brew methods rely on guess and check to repair, which
 > has a high computational cost and the possibility of false repair.  It
 > also requires that only a minescule amount of silent corruption has
 > occured.

The computational cost for repairing is indeed high, but I think it is 
acceptable. Take the example of approach 2. For typical 4096 bytes data 
block, the cost is nearly same as checksumming a 16MB file, which is 
very fast. For default setting (nodesize == 16384), the cost is nearly 
same as checksumming a 256MB file. For worst setting (nodesize == 
65536), the cost is nearly same as checksumming a 4GB file. It can be 
done in several seconds on a typical computer. We can even speed up by 
multithreading.

The possibility of false repair is negligible since we are using crypto 
hashes. If there is a misrepair, then you can find a hash collision of 
crypto hash function.

 > Disk drives already have highly robust error correction and
 > detection in place, so it is almost unheard of for them to silently
 > corrupt data, but rather they refuse to read the whole sector.  If
 > corrupt data somehow managed to pass the error detection code in the
 > drive, it is highly likely that a lot more than one or two bytes will 
be wrong.

Indeed, disk drives are likely to refuse reading the whole sector. My 
idea can't handle it if whole sector is lost. But I don't think silently 
corrupt data is seldom. Link: https://en.wikipedia.org/wiki/Data_corruption

If the corrupted sector can be read from disk, and corrupted bytes is 
very near (i.e. burst errors), my idea may able to repair them. If using 
T=8 in approach 2, it can fix 8 consecutive bytes of corruption. I think 
it is quite a large amount of redundancy.


 >> 3) Reed-Solomon approach:
 >
 > If you are going to do error correction, this or another real FEC
 > altorithm is the way to go.  Also since the drive reports corrupt
 > sectors, you can use RS in erasure mode where it can correct T errors
 > instead of T/2.  There is a handy tool called par2 that lets you create
 > a small RS FEC archive of a file that you can later use to repair damaged
 > portions of it.
 >

My idea can't handle this, because it only generate very few parity 
symbols (less than 16). So even one single lost sector will exceed the 
redundancy capacity.

 > Another common behavior of drives is for them to fail outright with 100%
 > data loss rather than just have a few bad sectors.  For that reason, I
 > think that anyone who really cares about their data should be using a
 > raid and making regular backups rather than relying on an automatic on
 > the fly FEC in the filesystem.  If they don't care enough to do that
 > then they probably don't care enough to think the cost of online FEC is
 > worth it either.

Indeed, if someone really cares about data safety, that person should 
use RAID to protect the data. RAID can handle data corruption way better 
than FEC. But there exists situations that the user want to choose 
cheaper solutions. Think about a disk full of games, music, movies, even 
server logs or security camera videos. The value of data is low, but it 
is annoying if these data really corrupted. The FEC can help these 
situations.


On 2022/6/21 22:25, David Sterba wrote:
> I basically agree with all the points above. Adding the FEC is an
> interesting idea but it's another layer with own correction and there
> are other mechanisms that protect against isolated data loss.
> 
> The introduction why to implement this lightly touches on the reasons of
> the corruptions, but I think this is the crucial part. For a security
> feature this would be the threat model, for storage and correctness it's
> an equivalent I don't know name for.

I think the `threat model' is same as checksum/ctree itself. We have 
checksum/ctree because we want to detect errors. FEC go further, it can 
fix (some of) these errors.

> Most common source of byte-level errors is faulty RAM, one or two bits,
> and FEC can't fix all problems once a corrupted value spreads in the
> structures. That's why we don't have automatic repair even for such a
> "simple" type of error. If there are more bits corrupeted in different
> bytes, the repair code would have to be upgraded for that.

I think the fundamental assumption of FEC is "data corrupted after 
checksumming". If corrupted value already spread, there is no reliable 
way to deal with it (checksum will even say it's OK). If corrupted value 
not spread, checksum and FEC can should be able to repair it reliablly. 
I think the only susceptible part is checksumming itself. As long as a 
random error occured in checksumming will not further corrupt data by 
mis-repairing, the process of automatic repair should be safe.

> Storage devices tend to lose data in bigger chunks, we'd have to have
> large correction codes, but I think device level redundancy solves that
> in a more robust way.

Yes. RAID already did it very well.

> 
> Ad 1, we can already do bruteforce repair, enumerating bit flipped
> values for data and matching against the checksum, but it's an
> unreliable guess work.
> 

I think it's quite reliable as long as the hash function is 
cryptographic and didn't truncate too much.

> Ad 2 and 3, costly compared to plain checksum and additional measures
> like redundant devices and profiles.

Approach 2 is really fast. The extra cost at writing data is as little 
as XORing all data together, and we can use SIMD to do it very well. 
There is no extra cost when reading data. However, a crypto hash indeed 
required, which may slower than non-crypto hash functions, but I think 
BLAKE2b is fast enough for daily use.

Approach 3 is very slow. This can hardly improved.

I think we can provide user an option to use approach 2, e.g. providing 
a new checksum option, which concatenate BLAKE2b-160 and 12-XORed-bytes, 
or BLAKE2b-192 and 8-XORed-bytes, or BLAKE2b-224 and 4-XORed-bytes. 
These options provide redundancy against 12bytes, 8bytes, 4bytes of 
consecutive bytes of corruption, respectively.

Best Regards,
Zhang Boyang
